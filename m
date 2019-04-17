Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6DC1C282DC
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 22:14:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6ADAB2184B
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 22:14:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="vVJbkE0u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387559AbfDQWOf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 18:14:35 -0400
Received: from terminus.zytor.com ([198.137.202.136]:44361 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728237AbfDQWOd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 18:14:33 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x3HMEGl84101645
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 17 Apr 2019 15:14:16 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x3HMEGl84101645
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019041745; t=1555539257;
        bh=H4Ns6j4EL3bIQdf0Xi11rZeGz8JL0vrrQVR/xv1t+wo=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=vVJbkE0uX+y/LFGPSYqY8CnJ1ACtDC2DqYw4p2u8e6gAV1cNqmA+TYYOl1rthvH3T
         tWMXZiXVZMZlo3KQHHqzj+VS/eSHYEc4OEZ4Ko9FqQx+EojfWR2POSJ3Tb8zjWzL7J
         82VascX4+npJ5lypymFLZMIDSogtPO7/b9whNw+CYDjO9SRQfVSrtuIzEYmIoKfVPJ
         mEMdj2GIwTi07P/G7K/W5j87uERQwy3mPZJ8m7ywD208vTEBOoq+pDal4Fo/5chrFJ
         zOCWC3Bts+HGkScvZ4penEk3Mqxr3kIwludN5hAIKPXMhyTemhIJC4J+x7jBzO6pLY
         e8BcH3or8dCUQ==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x3HMEFPe4101639;
        Wed, 17 Apr 2019 15:14:15 -0700
Date:   Wed, 17 Apr 2019 15:14:15 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Xiaochen Shen <tipbot@zytor.com>
Message-ID: <tip-47820e73f5b3a1fdb8ebd1219191edc96e0c85c1@git.kernel.org>
Cc:     hpa@zytor.com, tglx@linutronix.de, xiaochen.shen@intel.com,
        mingo@kernel.org, linux-kernel@vger.kernel.org,
        fenghua.yu@intel.com, tony.luck@intel.com, x86@kernel.org,
        bp@suse.de, mingo@redhat.com, reinette.chatre@intel.com
Reply-To: tony.luck@intel.com, x86@kernel.org, mingo@redhat.com,
          bp@suse.de, reinette.chatre@intel.com, hpa@zytor.com,
          tglx@linutronix.de, xiaochen.shen@intel.com, mingo@kernel.org,
          linux-kernel@vger.kernel.org, fenghua.yu@intel.com
In-Reply-To: <1555499329-1170-3-git-send-email-xiaochen.shen@intel.com>
References: <1555499329-1170-3-git-send-email-xiaochen.shen@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/cache] x86/resctrl: Initialize a new resource group with
 default MBA values
Git-Commit-ID: 47820e73f5b3a1fdb8ebd1219191edc96e0c85c1
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  47820e73f5b3a1fdb8ebd1219191edc96e0c85c1
Gitweb:     https://git.kernel.org/tip/47820e73f5b3a1fdb8ebd1219191edc96e0c85c1
Author:     Xiaochen Shen <xiaochen.shen@intel.com>
AuthorDate: Wed, 17 Apr 2019 19:08:49 +0800
Committer:  Borislav Petkov <bp@suse.de>
CommitDate: Thu, 18 Apr 2019 00:06:31 +0200

x86/resctrl: Initialize a new resource group with default MBA values

Currently, when a new resource group is created, the allocation values
of the MBA resource are not initialized and remain meaningless data.

For example:

  mkdir /sys/fs/resctrl/p1
  cat /sys/fs/resctrl/p1/schemata
  MB:0=100;1=100

  echo "MB:0=10;1=20" > /sys/fs/resctrl/p1/schemata
  cat /sys/fs/resctrl/p1/schemata
  MB:0= 10;1= 20

  rmdir /sys/fs/resctrl/p1
  mkdir /sys/fs/resctrl/p2
  cat /sys/fs/resctrl/p2/schemata
  MB:0= 10;1= 20

Therefore, when the new group is created, it is reasonable to initialize
MBA resource with default values.

Initialize the MBA resource and cache resources in separate functions.

 [ bp: Add newlines between code blocks for better readability. ]

Signed-off-by: Xiaochen Shen <xiaochen.shen@intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Fenghua Yu <fenghua.yu@intel.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: pei.p.jia@intel.com
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Tony Luck <tony.luck@intel.com>
Cc: x86-ml <x86@kernel.org>
Link: https://lkml.kernel.org/r/1555499329-1170-3-git-send-email-xiaochen.shen@intel.com
---
 arch/x86/kernel/cpu/resctrl/ctrlmondata.c |  4 +--
 arch/x86/kernel/cpu/resctrl/rdtgroup.c    | 52 ++++++++++++++++++++-----------
 2 files changed, 35 insertions(+), 21 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
index 2dbd990a2eb7..89320c0396b1 100644
--- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
+++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
@@ -342,10 +342,10 @@ int update_domains(struct rdt_resource *r, int closid)
 	if (cpumask_empty(cpu_mask) || mba_sc)
 		goto done;
 	cpu = get_cpu();
-	/* Update CBM on this cpu if it's in cpu_mask. */
+	/* Update resource control msr on this CPU if it's in cpu_mask. */
 	if (cpumask_test_cpu(cpu, cpu_mask))
 		rdt_ctrl_update(&msr_param);
-	/* Update CBM on other cpus. */
+	/* Update resource control msr on other CPUs. */
 	smp_call_function_many(cpu_mask, rdt_ctrl_update, &msr_param, 1);
 	put_cpu();
 
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 36ace51ee705..333c177a2471 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -2581,8 +2581,8 @@ static int __init_one_rdt_domain(struct rdt_domain *d, struct rdt_resource *r,
 	return 0;
 }
 
-/**
- * rdtgroup_init_alloc - Initialize the new RDT group's allocations
+/*
+ * Initialize cache resources with default values.
  *
  * A new RDT group is being created on an allocation capable (CAT)
  * supporting system. Set this group up to start off with all usable
@@ -2591,38 +2591,52 @@ static int __init_one_rdt_domain(struct rdt_domain *d, struct rdt_resource *r,
  * If there are no more shareable bits available on any domain then
  * the entire allocation will fail.
  */
+static int rdtgroup_init_cat(struct rdt_resource *r, u32 closid)
+{
+	struct rdt_domain *d;
+	int ret;
+
+	list_for_each_entry(d, &r->domains, list) {
+		ret = __init_one_rdt_domain(d, r, closid);
+		if (ret < 0)
+			return ret;
+	}
+
+	return 0;
+}
+
+/* Initialize MBA resource with default values. */
+static void rdtgroup_init_mba(struct rdt_resource *r)
+{
+	struct rdt_domain *d;
+
+	list_for_each_entry(d, &r->domains, list) {
+		d->new_ctrl = is_mba_sc(r) ? MBA_MAX_MBPS : r->default_ctrl;
+		d->have_new_ctrl = true;
+	}
+}
+
+/* Initialize the RDT group's allocations. */
 static int rdtgroup_init_alloc(struct rdtgroup *rdtgrp)
 {
 	struct rdt_resource *r;
-	struct rdt_domain *d;
 	int ret;
 
 	for_each_alloc_enabled_rdt_resource(r) {
-		/*
-		 * Only initialize default allocations for CBM cache
-		 * resources
-		 */
-		if (r->rid == RDT_RESOURCE_MBA)
-			continue;
-		list_for_each_entry(d, &r->domains, list) {
-			ret = __init_one_rdt_domain(d, r, rdtgrp->closid);
+		if (r->rid == RDT_RESOURCE_MBA) {
+			rdtgroup_init_mba(r);
+		} else {
+			ret = rdtgroup_init_cat(r, rdtgrp->closid);
 			if (ret < 0)
 				return ret;
 		}
-	}
 
-	for_each_alloc_enabled_rdt_resource(r) {
-		/*
-		 * Only initialize default allocations for CBM cache
-		 * resources
-		 */
-		if (r->rid == RDT_RESOURCE_MBA)
-			continue;
 		ret = update_domains(r, rdtgrp->closid);
 		if (ret < 0) {
 			rdt_last_cmd_puts("Failed to initialize allocations\n");
 			return ret;
 		}
+
 	}
 
 	rdtgrp->mode = RDT_MODE_SHAREABLE;
