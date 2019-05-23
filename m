Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7003CC282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 09:26:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34A5820675
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 09:26:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="p7I4z70C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730236AbfEWJ0Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 05:26:25 -0400
Received: from terminus.zytor.com ([198.137.202.136]:38179 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726081AbfEWJ0Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 05:26:24 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x4N9QD6C4041756
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 23 May 2019 02:26:14 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x4N9QD6C4041756
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1558603574;
        bh=SeRSkk7rBDoF9RcYi/fBKrnRRUiI9j1SpLKdo4Y/naE=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=p7I4z70CsmCMGkM6cyYe7hrDbmW96Q2wEWOiQgPhicuHsKSicrxAAP4kwZGHm1WzT
         Fp6VT3Iwq7UlxxelyQSMpqJROsv/EUo3qw6ECQD+nYaYVFH907bcWj8nd21WNavFMU
         ylCR/Z1Vsjg5sr3ynI4V8ecU2cAbXxj1uGRVzAS4bOOQ/EiviFDSp2QZzC1ia9bHSu
         WrAvUwZyosGdlGJhhe6UP5L7vFrWp3082AYKZi5nPi9+o3kSRqyhU9Dh6dAkU6vocQ
         hFVwFW3BPi9Q+Um/BZSL7fpRevJT4ZSa8IxyofPXTot2q0yvdHNyXYQANCzeQcXtX0
         +zrqNxTZf1juA==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x4N9QDjV4041753;
        Thu, 23 May 2019 02:26:13 -0700
Date:   Thu, 23 May 2019 02:26:13 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Zhang Rui <tipbot@zytor.com>
Message-ID: <tip-aadf7b38337108627b014fb285147aacdfafe42e@git.kernel.org>
Cc:     tglx@linutronix.de, len.brown@intel.com,
        linux-kernel@vger.kernel.org, hpa@zytor.com, rui.zhang@intel.com,
        mingo@kernel.org, peterz@infradead.org, rafael.j.wysocki@intel.com
Reply-To: mingo@kernel.org, rui.zhang@intel.com,
          rafael.j.wysocki@intel.com, peterz@infradead.org,
          len.brown@intel.com, tglx@linutronix.de, hpa@zytor.com,
          linux-kernel@vger.kernel.org
In-Reply-To: <ae3d1903407fd6e3684234b674f4f0e62c2ab54c.1557769318.git.len.brown@intel.com>
References: <ae3d1903407fd6e3684234b674f4f0e62c2ab54c.1557769318.git.len.brown@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/topology] powercap/intel_rapl: Simplify
 rapl_find_package()
Git-Commit-ID: aadf7b38337108627b014fb285147aacdfafe42e
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

Commit-ID:  aadf7b38337108627b014fb285147aacdfafe42e
Gitweb:     https://git.kernel.org/tip/aadf7b38337108627b014fb285147aacdfafe42e
Author:     Zhang Rui <rui.zhang@intel.com>
AuthorDate: Mon, 13 May 2019 13:58:50 -0400
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Thu, 23 May 2019 10:08:32 +0200

powercap/intel_rapl: Simplify rapl_find_package()

Simplify how the code to discover a package is called.  Rename
find_package_by_id() to rapl_find_package_domain()

Syntax only, no functional or semantic change.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: linux-pm@vger.kernel.org
Link: https://lkml.kernel.org/r/ae3d1903407fd6e3684234b674f4f0e62c2ab54c.1557769318.git.len.brown@intel.com

---
 drivers/powercap/intel_rapl.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/powercap/intel_rapl.c b/drivers/powercap/intel_rapl.c
index 4347f15165f8..3c3c0c23180b 100644
--- a/drivers/powercap/intel_rapl.c
+++ b/drivers/powercap/intel_rapl.c
@@ -264,8 +264,9 @@ static struct powercap_control_type *control_type; /* PowerCap Controller */
 static struct rapl_domain *platform_rapl_domain; /* Platform (PSys) domain */
 
 /* caller to ensure CPU hotplug lock is held */
-static struct rapl_package *find_package_by_id(int id)
+static struct rapl_package *rapl_find_package_domain(int cpu)
 {
+	int id = topology_physical_package_id(cpu);
 	struct rapl_package *rp;
 
 	list_for_each_entry(rp, &rapl_packages, plist) {
@@ -1300,7 +1301,7 @@ static int __init rapl_register_psys(void)
 	rd->rpl[0].name = pl1_name;
 	rd->rpl[1].prim_id = PL2_ENABLE;
 	rd->rpl[1].name = pl2_name;
-	rd->rp = find_package_by_id(0);
+	rd->rp = rapl_find_package_domain(0);
 
 	power_zone = powercap_register_zone(&rd->power_zone, control_type,
 					    "psys", NULL,
@@ -1456,8 +1457,9 @@ static void rapl_remove_package(struct rapl_package *rp)
 }
 
 /* called from CPU hotplug notifier, hotplug lock held */
-static struct rapl_package *rapl_add_package(int cpu, int pkgid)
+static struct rapl_package *rapl_add_package(int cpu)
 {
+	int id = topology_physical_package_id(cpu);
 	struct rapl_package *rp;
 	int ret;
 
@@ -1466,7 +1468,7 @@ static struct rapl_package *rapl_add_package(int cpu, int pkgid)
 		return ERR_PTR(-ENOMEM);
 
 	/* add the new package to the list */
-	rp->id = pkgid;
+	rp->id = id;
 	rp->lead_cpu = cpu;
 
 	/* check if the package contains valid domains */
@@ -1497,12 +1499,11 @@ err_free_package:
  */
 static int rapl_cpu_online(unsigned int cpu)
 {
-	int pkgid = topology_physical_package_id(cpu);
 	struct rapl_package *rp;
 
-	rp = find_package_by_id(pkgid);
+	rp = rapl_find_package_domain(cpu);
 	if (!rp) {
-		rp = rapl_add_package(cpu, pkgid);
+		rp = rapl_add_package(cpu);
 		if (IS_ERR(rp))
 			return PTR_ERR(rp);
 	}
@@ -1512,11 +1513,10 @@ static int rapl_cpu_online(unsigned int cpu)
 
 static int rapl_cpu_down_prep(unsigned int cpu)
 {
-	int pkgid = topology_physical_package_id(cpu);
 	struct rapl_package *rp;
 	int lead_cpu;
 
-	rp = find_package_by_id(pkgid);
+	rp = rapl_find_package_domain(cpu);
 	if (!rp)
 		return 0;
 
