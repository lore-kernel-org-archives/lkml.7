Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94075C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 00:55:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DABB20663
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 00:55:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726226AbfCGAzL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 19:55:11 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49374 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726010AbfCGAzL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 19:55:11 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E541681DE9;
        Thu,  7 Mar 2019 00:55:10 +0000 (UTC)
Received: from jsavitz.bos.com (dhcp-17-166.bos.redhat.com [10.18.17.166])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F38A060C1B;
        Thu,  7 Mar 2019 00:55:09 +0000 (UTC)
From:   Joel Savitz <jsavitz@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Joel Savitz <jsavitz@redhat.com>, Li Zefan <lizefan@huawei.com>,
        cgroups@vger.kernel.org
Subject: [PATCH] cpuset: restore sanity to cpuset_cpus_allowed_fallback()
Date:   Wed,  6 Mar 2019 19:54:48 -0500
Message-Id: <1551920088-30685-1-git-send-email-jsavitz@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Thu, 07 Mar 2019 00:55:10 +0000 (UTC)
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

This patch changes the above behavior by instead simply resetting the mask
to cpu_possible_mask.

Signed-off-by: Joel Savitz <jsavitz@redhat.com>
---
 kernel/cgroup/cpuset.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 479743db6c37..5f65a2167bdf 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -3243,7 +3243,7 @@ void cpuset_cpus_allowed(struct task_struct *tsk, struct cpumask *pmask)
 void cpuset_cpus_allowed_fallback(struct task_struct *tsk)
 {
 	rcu_read_lock();
-	do_set_cpus_allowed(tsk, task_cs(tsk)->effective_cpus);
+	do_set_cpus_allowed(tsk, cpu_possible_mask);
 	rcu_read_unlock();
 
 	/*
-- 
2.20.1

