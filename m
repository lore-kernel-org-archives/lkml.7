Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88A1FC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 12:39:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 568472085A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 12:39:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="WiRvvBmH";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="KEvIMA10"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726496AbfCHMjE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 07:39:04 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:42472 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726249AbfCHMjE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 07:39:04 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id BB88060397; Fri,  8 Mar 2019 12:39:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1552048742;
        bh=MBXmJUwHed3uQzfaC5YIkjT0Y2dYWJTpv2JcO5zujxI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WiRvvBmHEUHbkwhjeigqLtqiaJ+lCEin6ObDOVzeD1233zCLRpo5diUwUS2j5dPTj
         wgfAIoO5tG7HknAaDcl52JVsjd34EQp7gXp3+8mlVCkq6Fm1ft+173m4g+oVzbQ73F
         lxvDpfZ80KhCSXooWStvWEi+cZAjjjVtyMJmK4O8=
Received: from lingutla-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: clingutla@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 9BD0C60264;
        Fri,  8 Mar 2019 12:38:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1552048741;
        bh=MBXmJUwHed3uQzfaC5YIkjT0Y2dYWJTpv2JcO5zujxI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KEvIMA10n+a33KNJWDRFm40MHFvVu8o2xJPGKQdfzk1WzBniPSo54V43C5Dlsyem/
         Q7abCh1INfw+1xmWhsx3BhuykvKw43Es/CtFgaTDD9dVQk85ZLhMZtiP8p+u4kkpAP
         1MvHzVaag9EB6QJxX6LMrGugXhoy2Saz0MDrQ4co=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9BD0C60264
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=clingutla@codeaurora.org
From:   Lingutla Chandrasekhar <clingutla@codeaurora.org>
To:     quentin.perret@arm.com, sudeep.holla@arm.com,
        dietmar.eggemann@arm.com, gregkh@linuxfoundation.org
Cc:     will.deacon@arm.com, catalin.marinas@arm.com,
        morten.rasmussen@arm.com, linux-arm-kernel@lists.infradead.org,
        jeremy.linton@arm.com, linux-kernel@vger.kernel.org,
        Lingutla Chandrasekhar <clingutla@codeaurora.org>
Subject: [PATCH v2] arch_topology: Make cpu_capacity sysfs node as ready-only
Date:   Fri,  8 Mar 2019 18:08:48 +0530
Message-Id: <1552048728-29657-1-git-send-email-clingutla@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <df8c3952-b1ab-bc15-ccb7-e4a5d7d54bf8@arm.com>
References: <df8c3952-b1ab-bc15-ccb7-e4a5d7d54bf8@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If user updates any cpu's cpu_capacity, then the new value is going to
be applied to all its online sibling cpus. But this need not to be correct
always, as sibling cpus (in ARM, same micro architecture cpus) would have
different cpu_capacity with different performance characteristics.
So updating the user supplied cpu_capacity to all cpu siblings
is not correct.

And another problem is, current code assumes that 'all cpus in a cluster
or with same package_id (core_siblings), would have same cpu_capacity'.
But with commit '5bdd2b3f0f8 ("arm64: topology: add support to remove
cpu topology sibling masks")', when a cpu hotplugged out, the cpu
information gets cleared in its sibling cpus. So user supplied
cpu_capacity would be applied to only online sibling cpus at the time.
After that, if any cpu hot plugged in, it would have different cpu_capacity
than its siblings, which breaks the above assumption.

So instead of mucking around the core sibling mask for user supplied
value, use device-tree to set cpu capacity. And make the cpu_capacity
node as read-only to know the assymetry between cpus in the system.
While at it, remove cpu_scale_mutex usage, which used for sysfs write
protection.

Tested-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Acked-by: Sudeep Holla <sudeep.holla@arm.com>
Signed-off-by: Lingutla Chandrasekhar <clingutla@codeaurora.org>
---

Changes from v1:
   - Removed cpu_scale_mutex usage, suggested by Dietmar Eggemann.
---
 drivers/base/arch_topology.c | 36 +-----------------------------------
 1 file changed, 1 insertion(+), 35 deletions(-)

diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
index edfcf8d..1739d7e 100644
--- a/drivers/base/arch_topology.c
+++ b/drivers/base/arch_topology.c
@@ -7,7 +7,6 @@
  */
 
 #include <linux/acpi.h>
-#include <linux/arch_topology.h>
 #include <linux/cpu.h>
 #include <linux/cpufreq.h>
 #include <linux/device.h>
@@ -31,7 +30,6 @@ void arch_set_freq_scale(struct cpumask *cpus, unsigned long cur_freq,
 		per_cpu(freq_scale, i) = scale;
 }
 
-static DEFINE_MUTEX(cpu_scale_mutex);
 DEFINE_PER_CPU(unsigned long, cpu_scale) = SCHED_CAPACITY_SCALE;
 
 void topology_set_cpu_scale(unsigned int cpu, unsigned long capacity)
@@ -51,37 +49,7 @@ static ssize_t cpu_capacity_show(struct device *dev,
 static void update_topology_flags_workfn(struct work_struct *work);
 static DECLARE_WORK(update_topology_flags_work, update_topology_flags_workfn);
 
-static ssize_t cpu_capacity_store(struct device *dev,
-				  struct device_attribute *attr,
-				  const char *buf,
-				  size_t count)
-{
-	struct cpu *cpu = container_of(dev, struct cpu, dev);
-	int this_cpu = cpu->dev.id;
-	int i;
-	unsigned long new_capacity;
-	ssize_t ret;
-
-	if (!count)
-		return 0;
-
-	ret = kstrtoul(buf, 0, &new_capacity);
-	if (ret)
-		return ret;
-	if (new_capacity > SCHED_CAPACITY_SCALE)
-		return -EINVAL;
-
-	mutex_lock(&cpu_scale_mutex);
-	for_each_cpu(i, &cpu_topology[this_cpu].core_sibling)
-		topology_set_cpu_scale(i, new_capacity);
-	mutex_unlock(&cpu_scale_mutex);
-
-	schedule_work(&update_topology_flags_work);
-
-	return count;
-}
-
-static DEVICE_ATTR_RW(cpu_capacity);
+static DEVICE_ATTR_RO(cpu_capacity);
 
 static int register_cpu_capacity_sysctl(void)
 {
@@ -141,7 +109,6 @@ void topology_normalize_cpu_scale(void)
 		return;
 
 	pr_debug("cpu_capacity: capacity_scale=%u\n", capacity_scale);
-	mutex_lock(&cpu_scale_mutex);
 	for_each_possible_cpu(cpu) {
 		pr_debug("cpu_capacity: cpu=%d raw_capacity=%u\n",
 			 cpu, raw_capacity[cpu]);
@@ -151,7 +118,6 @@ void topology_normalize_cpu_scale(void)
 		pr_debug("cpu_capacity: CPU%d cpu_capacity=%lu\n",
 			cpu, topology_get_cpu_scale(NULL, cpu));
 	}
-	mutex_unlock(&cpu_scale_mutex);
 }
 
 bool __init topology_parse_cpu_capacity(struct device_node *cpu_node, int cpu)
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
 a Linux Foundation Collaborative Project.

