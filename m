Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AC2CC43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 15:28:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64BF920661
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 15:28:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="H83DSUY7";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="mm0e27pQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728731AbfCFP2d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 10:28:33 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:46008 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726877AbfCFP2c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 10:28:32 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 58ECB60ACE; Wed,  6 Mar 2019 15:28:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1551886111;
        bh=lr6xzu7kGN76YrY51OX5vOavA1Q3p7mxTgffMhP+ox0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=H83DSUY77oPss5VUyyo+KFapYjzCsy/ioaSv8+Fw7LMCDgMkSWlD0fS9KEAHZR46N
         XFWA6FS4mRSpCXzAF3FLqtIxu09FPW7KJC3gCIjb7rVp08s+rqeynaXjbLfSbUDfwa
         i4Hi4RiB4z67p8Lbwsbs67beIQWntTIiMbR8gPiM=
Received: from lingutla-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: clingutla@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 23CD9606AC;
        Wed,  6 Mar 2019 15:28:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1551886109;
        bh=lr6xzu7kGN76YrY51OX5vOavA1Q3p7mxTgffMhP+ox0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mm0e27pQEdQJuqopTnGW1Bv4oOsAR7xsjC/BMwWPaIk/JrrR4GsoQTMgbSWsZQqsg
         daOiV/I6pRlHwGXTNe5NcP7b4o1pgfH3tCEpnAtHji79rlEA4aQK1/n7d5GAPdcDQq
         1/Ig6bKBge2GYx+hvbhr/p5zC5OBLWcQN5DAbpAk=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 23CD9606AC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=clingutla@codeaurora.org
From:   Lingutla Chandrasekhar <clingutla@codeaurora.org>
To:     quentin.perret@arm.com, sudeep.holla@arm.com,
        dietmar.eggemann@arm.com, gregkh@linuxfoundation.org
Cc:     will.deacon@arm.com, catalin.marinas@arm.com,
        morten.rasmussen@arm.com, linux-arm-kernel@lists.infradead.org,
        jeremy.linton@arm.com, linux-kernel@vger.kernel.org,
        Lingutla Chandrasekhar <clingutla@codeaurora.org>
Subject: [PATCH v1] arch_topology: Make cpu_capacity sysfs node as ready-only
Date:   Wed,  6 Mar 2019 20:57:53 +0530
Message-Id: <1551886073-16217-1-git-send-email-clingutla@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <20190306152254.GB19434@e105550-lin.cambridge.arm.com>
References: <20190306152254.GB19434@e105550-lin.cambridge.arm.com>
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

Signed-off-by: Lingutla Chandrasekhar <clingutla@codeaurora.org>
---
 drivers/base/arch_topology.c | 33 +--------------------------------
 1 file changed, 1 insertion(+), 32 deletions(-)

diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
index edfcf8d..d455897 100644
--- a/drivers/base/arch_topology.c
+++ b/drivers/base/arch_topology.c
@@ -7,7 +7,6 @@
  */
 
 #include <linux/acpi.h>
-#include <linux/arch_topology.h>
 #include <linux/cpu.h>
 #include <linux/cpufreq.h>
 #include <linux/device.h>
@@ -51,37 +50,7 @@ static ssize_t cpu_capacity_show(struct device *dev,
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
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
 a Linux Foundation Collaborative Project.

