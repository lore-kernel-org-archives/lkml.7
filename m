Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 806A7C282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 09:29:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C2FD2175B
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 09:29:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="KH1WfXm5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730250AbfEWJ3e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 05:29:34 -0400
Received: from terminus.zytor.com ([198.137.202.136]:44367 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726309AbfEWJ3e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 05:29:34 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x4N9T3CA4042229
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 23 May 2019 02:29:03 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x4N9T3CA4042229
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1558603744;
        bh=x6zjVOAulB5sB+Og5ouCDwrEuGfiyZ/AFuJ+CqSTKHE=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=KH1WfXm5ytFVuLNkvVGPHI2ZivUWuJo1WmSTFwqbz9hafVYN30MWVEx6pwWHD63N4
         34jUHLiFfQXr+mXH7KkIlcJzfApaAAxvAeMRR2W8xP1QLIHvKBsGvJNcEhlSeo7oWK
         OMnhKRTE87Y5C5yNor9QyHTh+6JhgrI3NhHfxRE5Oa0CxiNYZBAJ+BnSIWs+Be+A7X
         99biqiS3oR3CxHOMM6jUUFOyPkTRNYyKkxkm8l4lvfSibSeNOPD+U6XbtuAJ/83Nej
         qJ53NSUlNBaRY5Dm1O7iPNixnLnVlVYtpMmLK4XNje4FZWFFYVCV7VZpDdIW52IW9N
         oDVxWfHV90mYw==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x4N9T3Ih4042225;
        Thu, 23 May 2019 02:29:03 -0700
Date:   Thu, 23 May 2019 02:29:03 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Zhang Rui <tipbot@zytor.com>
Message-ID: <tip-cfcd82e632882372db960b50782a439a8ba56c09@git.kernel.org>
Cc:     linux@roeck-us.net, peterz@infradead.org,
        linux-kernel@vger.kernel.org, len.brown@intel.com,
        tglx@linutronix.de, rui.zhang@intel.com, mingo@kernel.org,
        hpa@zytor.com
Reply-To: tglx@linutronix.de, rui.zhang@intel.com,
          linux-kernel@vger.kernel.org, len.brown@intel.com,
          peterz@infradead.org, linux@roeck-us.net, hpa@zytor.com,
          mingo@kernel.org
In-Reply-To: <ec2868f35113a01ff72d9041e0b97fc6a1c7df84.1557769318.git.len.brown@intel.com>
References: <ec2868f35113a01ff72d9041e0b97fc6a1c7df84.1557769318.git.len.brown@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/topology] hwmon/coretemp: Support multi-die/package
Git-Commit-ID: cfcd82e632882372db960b50782a439a8ba56c09
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

Commit-ID:  cfcd82e632882372db960b50782a439a8ba56c09
Gitweb:     https://git.kernel.org/tip/cfcd82e632882372db960b50782a439a8ba56c09
Author:     Zhang Rui <rui.zhang@intel.com>
AuthorDate: Mon, 13 May 2019 13:58:54 -0400
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Thu, 23 May 2019 10:08:33 +0200

hwmon/coretemp: Support multi-die/package

Package temperature sensors are actually implemented in hardware per-die.

Update coretemp to be "die-aware", so it can expose mulitple sensors per
package, instead of just one.  No change to single-die/package systems.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Guenter Roeck <linux@roeck-us.net>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: linux-pm@vger.kernel.org
Cc: linux-hwmon@vger.kernel.org
Link: https://lkml.kernel.org/r/ec2868f35113a01ff72d9041e0b97fc6a1c7df84.1557769318.git.len.brown@intel.com

---
 drivers/hwmon/coretemp.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/hwmon/coretemp.c b/drivers/hwmon/coretemp.c
index 5d34f7271e67..c64ce32d3214 100644
--- a/drivers/hwmon/coretemp.c
+++ b/drivers/hwmon/coretemp.c
@@ -435,7 +435,7 @@ static int chk_ucode_version(unsigned int cpu)
 
 static struct platform_device *coretemp_get_pdev(unsigned int cpu)
 {
-	int pkgid = topology_logical_package_id(cpu);
+	int pkgid = topology_logical_die_id(cpu);
 
 	if (pkgid >= 0 && pkgid < max_packages)
 		return pkg_devices[pkgid];
@@ -579,7 +579,7 @@ static struct platform_driver coretemp_driver = {
 
 static struct platform_device *coretemp_device_add(unsigned int cpu)
 {
-	int err, pkgid = topology_logical_package_id(cpu);
+	int err, pkgid = topology_logical_die_id(cpu);
 	struct platform_device *pdev;
 
 	if (pkgid < 0)
@@ -703,7 +703,7 @@ static int coretemp_cpu_offline(unsigned int cpu)
 	 * the rest.
 	 */
 	if (cpumask_empty(&pd->cpumask)) {
-		pkg_devices[topology_logical_package_id(cpu)] = NULL;
+		pkg_devices[topology_logical_die_id(cpu)] = NULL;
 		platform_device_unregister(pdev);
 		return 0;
 	}
@@ -741,7 +741,7 @@ static int __init coretemp_init(void)
 	if (!x86_match_cpu(coretemp_ids))
 		return -ENODEV;
 
-	max_packages = topology_max_packages();
+	max_packages = topology_max_packages() * topology_max_die_per_package();
 	pkg_devices = kcalloc(max_packages, sizeof(struct platform_device *),
 			      GFP_KERNEL);
 	if (!pkg_devices)
