Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B1E4C282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 20:41:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E14822084B
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 20:41:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726558AbfDIUlP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 16:41:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34806 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726337AbfDIUlP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 16:41:15 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A448B31649AA;
        Tue,  9 Apr 2019 20:41:14 +0000 (UTC)
Received: from intel-knightslanding-lb-02.khw1.lab.eng.bos.redhat.com (intel-knightslanding-lb-02.khw1.lab.eng.bos.redhat.com [10.16.200.87])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9517719022;
        Tue,  9 Apr 2019 20:41:11 +0000 (UTC)
From:   Joel Savitz <jsavitz@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Joel Savitz <jsavitz@redhat.com>, Phil Auld <pauld@redhat.com>,
        Waiman Long <longman@redhat.com>, Tejun Heo <tj@kernel.org>,
        Li Zefan <lizefan@huawei.com>, cgroups@vger.kernel.org
Subject: [PATCH v2] cpuset: restore sanity to cpuset_cpus_allowed_fallback()
Date:   Tue,  9 Apr 2019 16:40:03 -0400
Message-Id: <20190409204003.6428-1-jsavitz@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Tue, 09 Apr 2019 20:41:14 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If a process is limited by taskset (i.e. cpuset) to only be allowed to
run on cpu N, and then cpu N is offlined via hotplug, the process will
be assigned the current value of its cpuset cgroup's effective_cpus field
in a call to do_set_cpus_allowed() in cpuset_cpus_allowed_fallback().
This argument's value does not makes sense for this case, because
task_cs(tsk)->effective_cpus is modified by cpuset_hotplug_workfn()
to reflect the new value of cpu_active_mask after cpu N is removed from
the mask. While this may make sense for the cgroup affinity mask, it
does not make sense on a per-task basis, as a task that was previously
limited to only be run on cpu N will be limited to every cpu _except_ for
cpu N after it is offlined/onlined via hotplug.

Pre-patch behavior:

	$ grep Cpus /proc/$$/status
	Cpus_allowed:	ff
	Cpus_allowed_list:	0-7

	$ taskset -p 4 $$
	pid 19202's current affinity mask: f
	pid 19202's new affinity mask: 4

	$ grep Cpus /proc/self/status
	Cpus_allowed:	04
	Cpus_allowed_list:	2

	# echo off > /sys/devices/system/cpu/cpu2/online
	$ grep Cpus /proc/$$/status
	Cpus_allowed:	0b
	Cpus_allowed_list:	0-1,3

	# echo on > /sys/devices/system/cpu/cpu2/online
	$ grep Cpus /proc/$$/status
	Cpus_allowed:	0b
	Cpus_allowed_list:	0-1,3

On a patched system, the final grep produces the following
output instead:

	$ grep Cpus /proc/$$/status
	Cpus_allowed:	ff
	Cpus_allowed_list:	0-7

This patch changes the above behavior by instead resetting the mask to
task_cs(tsk)->cpus_allowed by default, and cpu_possible mask in legacy
mode.

This fallback mechanism is only triggered if _every_ other valid avenue
has been traveled, and it is the last resort before calling BUG().

Signed-off-by: Joel Savitz <jsavitz@redhat.com>
---
 kernel/cgroup/cpuset.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 4834c4214e9c..6c9deb2cc687 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -3255,10 +3255,23 @@ void cpuset_cpus_allowed(struct task_struct *tsk, struct cpumask *pmask)
 	spin_unlock_irqrestore(&callback_lock, flags);
 }
 
+/**
+ * cpuset_cpus_allowed_fallback - final fallback before complete catastrophe.
+ * @tsk: pointer to task_struct with which the scheduler is struggling
+ *
+ * Description: In the case that the scheduler cannot find an allowed cpu in
+ * tsk->cpus_allowed, we fall back to task_cs(tsk)->cpus_allowed. In legacy
+ * mode however, this value is the same as task_cs(tsk)->effective_cpus,
+ * which will not contain a sane cpumask during cases such as cpu hotplugging.
+ * This is the absolute last resort for the scheduler and it is only used if
+ * _every_ other avenue has been traveled.
+ **/
+
 void cpuset_cpus_allowed_fallback(struct task_struct *tsk)
 {
 	rcu_read_lock();
-	do_set_cpus_allowed(tsk, task_cs(tsk)->effective_cpus);
+	do_set_cpus_allowed(tsk, is_in_v2_mode() ?
+		task_cs(tsk)->cpus_allowed : cpu_possible_mask);
 	rcu_read_unlock();
 
 	/*
-- 
2.18.1

