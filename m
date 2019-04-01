Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 259AFC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 04:25:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0F7420870
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 04:25:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="CGrd+dX2";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="BJhBq6Na"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726633AbfDAEZC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 00:25:02 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:44850 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726083AbfDAEZB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 00:25:01 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 3C4216081E; Mon,  1 Apr 2019 04:25:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1554092700;
        bh=CwN29Ux2tMWdbpP6AMzORy+Ofh4yeQL2Myzhhan0s6o=;
        h=From:To:Cc:Subject:Date:From;
        b=CGrd+dX2qLaxRPbyZ+V4Wmlxiq62nJ7vPXtVTYIAN/f3NZVRi9KUgBVnVHHCeaBqN
         VyJ/6vxCX/pCUHF6TTmk2xm5jD+f3P9ojHwuAJn30PaxTh469U+lljjBc3aczpzgPO
         h1P25BOcKIerTVOncFe7rzy4cZOD+ccBdUBtv/6Q=
Received: from lingutla-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: clingutla@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id AFAED60234;
        Mon,  1 Apr 2019 04:24:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1554092698;
        bh=CwN29Ux2tMWdbpP6AMzORy+Ofh4yeQL2Myzhhan0s6o=;
        h=From:To:Cc:Subject:Date:From;
        b=BJhBq6NaoKoI+iiRrh2fho+y24BnY63BxTPloPjitWC3L8UPg+humTA1LyfLJdE2r
         4BJVZ+OevP3x4Xu0PVxnEIMeFtR/ulzQZ8ppi8rpYbcULPIRN671wL/Oot8jkcRJc0
         aL4yFvo4DHc/FF4JWlDW/m7HpYn2aAOHuOjCsR+g=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org AFAED60234
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=clingutla@codeaurora.org
From:   Lingutla Chandrasekhar <clingutla@codeaurora.org>
To:     gregkh@linuxfoundation.org, quentin.perret@arm.com,
        sudeep.holla@arm.com, dietmar.eggemann@arm.com,
        juri.lelli@gmail.com
Cc:     catalin.marinas@arm.com, jeremy.linton@arm.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Lingutla Chandrasekhar <clingutla@codeaurora.org>
Subject: [PATCH v3] arch_topology: Make cpu_capacity sysfs node as ready-only
Date:   Mon,  1 Apr 2019 09:54:41 +0530
Message-Id: <20190401042441.21993-1-clingutla@codeaurora.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If user updates any cpu's cpu_capacity, then the new value is going to
be applied to all its online sibling cpus. But this need not to be correct
always, as sibling cpus (in ARM, same micro architecture cpus) would have
different cpu_capacity with different performance characteristics.
So, updating the user supplied cpu_capacity to all cpu siblings
is not correct.

And another problem is, current code assumes that 'all cpus in a cluster
or with same package_id (core_siblings), would have same cpu_capacity'.
But with commit '5bdd2b3f0f8 ("arm64: topology: add support to remove
cpu topology sibling masks")', when a cpu hotplugged out, the cpu
information gets cleared in its sibling cpus. So, user supplied
cpu_capacity would be applied to only online sibling cpus at the time.
After that, if any cpu hotplugged in, it would have different cpu_capacity
than its siblings, which breaks the above assumption.

So, instead of mucking around the core sibling mask for user supplied
value, use device-tree to set cpu capacity. And make the cpu_capacity
node as read-only to know the asymmetry between cpus in the system.
While at it, remove cpu_scale_mutex usage, which used for sysfs write
protection.

Tested-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Tested-by: Quentin Perret <quentin.perret@arm.com>
Reviewed-by: Quentin Perret <quentin.perret@arm.com>
Acked-by: Sudeep Holla <sudeep.holla@arm.com>
Signed-off-by: Lingutla Chandrasekhar <clingutla@codeaurora.org>

---

Changes from v2:
   - Corrected spelling mistakes in commit text.
Changes from v1:
   - Removed cpu_scale_mutex usage, suggested by Dietmar Eggemann.
Changes from v0:
   - Instead of iterating all possible cpus to update cpu capacity,
     removed write capability for the sysfs node.

diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
index edfcf8d982e4..1739d7e1952a 100644
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

