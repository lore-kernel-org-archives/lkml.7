Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD067C43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 20:56:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7831C20652
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 20:56:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556657801;
	bh=/LvNSlIz8up6JSQaJpK+BUSx9jTdLZu6yKTkBvNeEU4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To:List-ID:
	 From;
	b=CJ5cXGWW2pJHmIfLEkae3iOJWMlmt+gJgUjp5kezzKCN34z/zMSYOz8aJo1nUJkAl
	 2D2d43QjgNq0mDeW0tnW8fiJgM+Z51pm/fny5Ue2Rmwg4PJGTYRjZ776Pua+awELhO
	 l8WnkQi4Gg4OCgUFAZ/eKYqTwgI9lgdYNX4QqozM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727421AbfD3U4e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 16:56:34 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:44865 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727138AbfD3U42 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 16:56:28 -0400
Received: by mail-io1-f66.google.com with SMTP id r71so13416946iod.11
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2019 13:56:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :reply-to:organization;
        bh=b/Kzn17Vf6dzrUo0Ue4UVG8xwRuP07tjAkgwmkdmxSM=;
        b=l2Ngkm3udG5DyEeOtAZ6oGOA4KVZFxOuU8B0Eh/mhP/bJhBtNOJ3THAVMUUOf2adi6
         twyrG8mco4dS9wuz/9nT/P5/Axw/6yzp90UW052mZYeGiDVTybOex8vALV93D8ezIys5
         NhJ6JQGiYyw+SklgO2z+4+4MCMJ9akazv3+X9gh4BuRMbfGIvnC6PRyxv0wAPuqC7gzr
         Mj3Nb1haakcj6ZSmSh+WgfED0+Vwi5suzzrRVyhjMYe9r8rAE/mg6sp4Qq0N6zlWKIgG
         TUGE5E/wStrgmQ266qa/ony2I83HWhu1g56K71ikeIg3WBRsJzdq+16snOwQgmAX6Yhy
         1NMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:reply-to:organization;
        bh=b/Kzn17Vf6dzrUo0Ue4UVG8xwRuP07tjAkgwmkdmxSM=;
        b=ObuCxE/uEWpr3ItdIvK0AIwoDmFFEGaPtc2n7m6OsxlMCeuaYdiQcNubXeGdN+cj8R
         MWm79Na1c902pKhDrjGj05aLW4gTkedpNoLzjCo+x4bgT47RWzms0E9QwKUyQM/ixdlc
         Pxcb++JHbH3SvATTYUiOBGyurdes7Wno2j26CErVK32HJuqH6rC4yTJZsV3pZVh+rbSc
         C3Xs9Y4viQjgei60QC5l9LpVISHVrjazgYvsoRKMGvGnW9CFcCXX8fyPyovQmoZEeWDL
         CjrAPmJ2lm/nxPCu9BtoqXML6NYBN0VFXADG9V97wGmNZhTjuRHhMxerGg9LU6F/YWve
         2qgQ==
X-Gm-Message-State: APjAAAXDbmLkWju86zFtONneP63p/O9Ekvliz7+w2me+Iu9x996LjuEK
        2m5mxd6elOLQcP2emrCULUX9wZXS
X-Google-Smtp-Source: APXvYqwncIigHMiJETH+4ro6ueyZkUOSyaVwYxmnrWJXJ36KfDE/YcqKqBbEQO+xFqQ5sYzZ4dvx2A==
X-Received: by 2002:a5e:8f09:: with SMTP id c9mr5900530iok.62.1556657787203;
        Tue, 30 Apr 2019 13:56:27 -0700 (PDT)
Received: from nuc8.lan (h69-131-112-51.cntcnh.dsl.dynamic.tds.net. [69.131.112.51])
        by smtp.gmail.com with ESMTPSA id s7sm9799349ioo.17.2019.04.30.13.56.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Apr 2019 13:56:26 -0700 (PDT)
From:   Len Brown <lenb@kernel.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>,
        Len Brown <len.brown@intel.com>
Subject: [PATCH 10/14] thermal/x86_pkg_temp_thermal: Support multi-die/package
Date:   Tue, 30 Apr 2019 16:55:55 -0400
Message-Id: <feda86927b54526ffc2b9d244d33e73cf0ca3e74.1553624867.git.len.brown@intel.com>
X-Mailer: git-send-email 2.18.0-rc0
In-Reply-To: <75386dff62ee869eb7357dff1e60dfd9b3e68023.1553624867.git.len.brown@intel.com>
References: <75386dff62ee869eb7357dff1e60dfd9b3e68023.1553624867.git.len.brown@intel.com>
Reply-To: Len Brown <lenb@kernel.org>
Organization: Intel Open Source Technology Center
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhang Rui <rui.zhang@intel.com>

On the new dual-die/package systems, the package temperature MSR becomes
die-scope. Thus instead of one thermal zone device per physical package,
now there should be one thermal_zone for each die on these systems.

This patch introduces x86_pkg_temp_thermal support for new
dual-die/package systems.

On the hardwares that do not have multi-die, topology_logical_die_id()
equals topology_physical_package_id(), thus there is no functional change.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/thermal/intel/x86_pkg_temp_thermal.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/thermal/intel/x86_pkg_temp_thermal.c b/drivers/thermal/intel/x86_pkg_temp_thermal.c
index 1ef937d799e4..1b03ab3ee20c 100644
--- a/drivers/thermal/intel/x86_pkg_temp_thermal.c
+++ b/drivers/thermal/intel/x86_pkg_temp_thermal.c
@@ -122,7 +122,7 @@ static int pkg_temp_debugfs_init(void)
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
@@ -511,11 +511,12 @@ MODULE_DEVICE_TABLE(x86cpu, pkg_temp_thermal_ids);
 static int __init pkg_temp_thermal_init(void)
 {
 	int ret;
+	struct cpuinfo_x86 *c = &cpu_data(0);
 
 	if (!x86_match_cpu(pkg_temp_thermal_ids))
 		return -ENODEV;
 
-	max_packages = topology_max_packages();
+	max_packages = topology_max_packages() * c->x86_max_dies;
 	packages = kcalloc(max_packages, sizeof(struct pkg_device *),
 			   GFP_KERNEL);
 	if (!packages)
-- 
2.18.0-rc0

