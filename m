Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1BC5C282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 09:27:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDD9C20675
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 09:27:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="UlNn7Ngd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730115AbfEWJ1u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 05:27:50 -0400
Received: from terminus.zytor.com ([198.137.202.136]:59593 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726309AbfEWJ1t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 05:27:49 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x4N9Rcpd4042097
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 23 May 2019 02:27:38 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x4N9Rcpd4042097
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1558603659;
        bh=8/XC8mh+H2ci+20MGNdj6Eua2Kx6OCat7fjk8pjiyEs=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=UlNn7Ngdaqw9yvEdkeje3s7ASD0bvWjHo2c1EVNA3zJag3JM4Cxc+HZ5gdTEcTAGX
         N/mlEstxJRcp2QsPxd1rnTwrr7rQYx6GTWanNc4QDRJXmVG9WerEuoriZO74BkDkT2
         dbJVQcB+yv35GhuPokayL1sp+DyLT8AqQvvAbjAhKwY75X+9xf00oVECPe7ASdEeda
         Nx9SmhrzSe6pj7kuHWloadMFahfD1tA/o6pZKUX+Pbl1ZN31VGoN8drrf/g8Wngld/
         nbeXzu5++HZ/IqQalZ+KZDwHO/XPK0u7VsnLV3Uf80QkX70t5xYJ9O/XRPRRaYKGL8
         f2bzQkSR6JkKw==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x4N9Rcr94042094;
        Thu, 23 May 2019 02:27:38 -0700
Date:   Thu, 23 May 2019 02:27:38 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Zhang Rui <tipbot@zytor.com>
Message-ID: <tip-724adec33c2491f26f739f285ddca25fca226e48@git.kernel.org>
Cc:     len.brown@intel.com, linux-kernel@vger.kernel.org, hpa@zytor.com,
        mingo@kernel.org, tglx@linutronix.de, rui.zhang@intel.com,
        peterz@infradead.org
Reply-To: rui.zhang@intel.com, mingo@kernel.org, tglx@linutronix.de,
          peterz@infradead.org, hpa@zytor.com,
          linux-kernel@vger.kernel.org, len.brown@intel.com
In-Reply-To: <281695c854d38d3bdec803480c3049c36198ca44.1557769318.git.len.brown@intel.com>
References: <281695c854d38d3bdec803480c3049c36198ca44.1557769318.git.len.brown@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/topology] thermal/x86_pkg_temp_thermal: Support
 multi-die/package
Git-Commit-ID: 724adec33c2491f26f739f285ddca25fca226e48
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

Commit-ID:  724adec33c2491f26f739f285ddca25fca226e48
Gitweb:     https://git.kernel.org/tip/724adec33c2491f26f739f285ddca25fca226e48
Author:     Zhang Rui <rui.zhang@intel.com>
AuthorDate: Mon, 13 May 2019 13:58:52 -0400
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Thu, 23 May 2019 10:08:33 +0200

thermal/x86_pkg_temp_thermal: Support multi-die/package

Package temperature sensors are actually implemented in hardware per-die.
Thus, the new multi-die/package systems sport mulitple package thermal
zones for each package.

Update the x86_pkg_temp_thermal to be "multi-die-aware", so it can expose
multiple zones per package, instead of just one.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/281695c854d38d3bdec803480c3049c36198ca44.1557769318.git.len.brown@intel.com

---
 drivers/thermal/intel/x86_pkg_temp_thermal.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/thermal/intel/x86_pkg_temp_thermal.c b/drivers/thermal/intel/x86_pkg_temp_thermal.c
index 1ef937d799e4..405b3858900a 100644
--- a/drivers/thermal/intel/x86_pkg_temp_thermal.c
+++ b/drivers/thermal/intel/x86_pkg_temp_thermal.c
@@ -122,7 +122,7 @@ err_out:
  */
 static struct pkg_device *pkg_temp_thermal_get_dev(unsigned int cpu)
 {
-	int pkgid = topology_logical_package_id(cpu);
+	int pkgid = topology_logical_die_id(cpu);
 
 	if (pkgid >= 0 && pkgid < max_packages)
 		return packages[pkgid];
@@ -353,7 +353,7 @@ static int pkg_thermal_notify(u64 msr_val)
 
 static int pkg_temp_thermal_device_add(unsigned int cpu)
 {
-	int pkgid = topology_logical_package_id(cpu);
+	int pkgid = topology_logical_die_id(cpu);
 	u32 tj_max, eax, ebx, ecx, edx;
 	struct pkg_device *pkgdev;
 	int thres_count, err;
@@ -449,7 +449,7 @@ static int pkg_thermal_cpu_offline(unsigned int cpu)
 	 * worker will see the package anymore.
 	 */
 	if (lastcpu) {
-		packages[topology_logical_package_id(cpu)] = NULL;
+		packages[topology_logical_die_id(cpu)] = NULL;
 		/* After this point nothing touches the MSR anymore. */
 		wrmsr(MSR_IA32_PACKAGE_THERM_INTERRUPT,
 		      pkgdev->msr_pkg_therm_low, pkgdev->msr_pkg_therm_high);
@@ -515,7 +515,7 @@ static int __init pkg_temp_thermal_init(void)
 	if (!x86_match_cpu(pkg_temp_thermal_ids))
 		return -ENODEV;
 
-	max_packages = topology_max_packages();
+	max_packages = topology_max_packages() * topology_max_die_per_package();
 	packages = kcalloc(max_packages, sizeof(struct pkg_device *),
 			   GFP_KERNEL);
 	if (!packages)
