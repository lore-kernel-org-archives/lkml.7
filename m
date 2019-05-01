Return-Path: <SRS0=0OOB=TB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EF1BC43219
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 04:24:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F90920866
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 04:24:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556684692;
	bh=s59kYc5ldaHcMzBRUiORUpy7Oc+zmC4Krr2i6Zh94RI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To:List-ID:
	 From;
	b=n4t9ghyDfXlnOkSshcsd4/bXgQJxwInB6QJcmc/L9cfnia3ev0vQ6NePo5i7FAxEV
	 QOe9oF52VSxe2L8vq05afgsfNr6Z+kuqlhtaj2d0nTGhxjG6BohHjIJjZhF7J1CyQl
	 DuYJkYEk7mVsOJp00qcHAhlCVKnviSMPHmSN/mQc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726333AbfEAEYv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 May 2019 00:24:51 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:40839 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726231AbfEAEYs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 May 2019 00:24:48 -0400
Received: by mail-it1-f194.google.com with SMTP id k64so8370229itb.5
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2019 21:24:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :reply-to:organization;
        bh=EqYgwV/DljsSwmFELEFQhJ3qI+LrWWEch0hPKLG0mz8=;
        b=UNKL7rZLURJmJhc1JUtT8n2YD7NCang6ss2FL0Prx73u739wMCYSh3xbvTtRIutoXu
         8Shvd93FVcyS9HGePW5a3oKM5DrOellE0kACry0GUu2jagI68LMzIMvHG/cQ5MfKqODZ
         O9Ms/6BjYOBsNIkD+s52Fu6NfOCUHENkFTVnwDCy3kQTS7pleKIJWRz7RpOO4WSMJm9M
         VtEia7SZ1tvNqsgQyHEROd2sXaxpcqQJ6qOJOguNU5erGtu7NrdIRgramXKoL9Kjmig8
         R2sM5IXZDqUcubBoqEwzY4w7MHRFqI/6xLXaoEXch8+DR3ySvCLMvlP/DxsM9M6R8/yc
         FIaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:reply-to:organization;
        bh=EqYgwV/DljsSwmFELEFQhJ3qI+LrWWEch0hPKLG0mz8=;
        b=NijaTsBvw0+ml40+hyZcYPo+VhsCVvqqm1mvsE7jhIgswrecv+LXJ9JxBNG9BaWIYR
         Nsjn25B0e4PL+Nq+VN0diH2WBYpf0E4MgydU0gk1OkN6O9I9F1IyUTVzpLHj9Plf+M1q
         jnTJEBb8swkPJVGWTjAgIpevhFyYktyhg9SjnsZNhqeBC0c3hZf/f6SZ40EUb3V9o6eO
         K9ZmS/Lh4eHvlOUZ6jAOzipXc0IKzQF9AJYZtJparw/0Q58yfxySNTAmS6DckrV3KXWN
         tZoAYyVJO0XPcLalQZg2e0Zc35Keb5a5V5rxUH8oVS0Vqi7gBO9Jlk00Cq4+sRz3yTAc
         bEaw==
X-Gm-Message-State: APjAAAVMqirMD64NQZ3f+PFKTQePFUfjntzqML4zyeju4cC0VNE+kT/n
        O8izqcNhRA4czzAk/g1cL18=
X-Google-Smtp-Source: APXvYqxxou/FX4m5YRkeTwtOoBkE2V4jVoC0/VoDJp/vrqtUd/W0nAUQRCjVnXIwTubfL5Pei0L6hA==
X-Received: by 2002:a05:660c:685:: with SMTP id n5mr6868053itk.57.1556684687274;
        Tue, 30 Apr 2019 21:24:47 -0700 (PDT)
Received: from nuc8.lan (h69-131-112-51.cntcnh.dsl.dynamic.tds.net. [69.131.112.51])
        by smtp.gmail.com with ESMTPSA id b8sm2569728itb.20.2019.04.30.21.24.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Apr 2019 21:24:46 -0700 (PDT)
From:   Len Brown <lenb@kernel.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>,
        Len Brown <len.brown@intel.com>
Subject: [PATCH 11/18] thermal/x86_pkg_temp_thermal: Support multi-die/package
Date:   Wed,  1 May 2019 00:24:20 -0400
Message-Id: <e6a6fcd9ad6a1cb8da31d467277dd519eecdbd31.1556657368.git.len.brown@intel.com>
X-Mailer: git-send-email 2.18.0-rc0
In-Reply-To: <6f53f0e494d743c79e18f6e3a98085711e6ddd0c.1556657368.git.len.brown@intel.com>
References: <6f53f0e494d743c79e18f6e3a98085711e6ddd0c.1556657368.git.len.brown@intel.com>
Reply-To: Len Brown <lenb@kernel.org>
Organization: Intel Open Source Technology Center
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhang Rui <rui.zhang@intel.com>

Package temperature sensors are actually implemented in hardware per-die.
Thus, the new multi-die/package systems sport mulitple package thermal
zones for each package.

Update the x86_pkg_temp_thermal to be "multi-die-aware", so it can
expose multiple zones per package, instead of just one.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/thermal/intel/x86_pkg_temp_thermal.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/thermal/intel/x86_pkg_temp_thermal.c b/drivers/thermal/intel/x86_pkg_temp_thermal.c
index 1ef937d799e4..405b3858900a 100644
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
@@ -515,7 +515,7 @@ static int __init pkg_temp_thermal_init(void)
 	if (!x86_match_cpu(pkg_temp_thermal_ids))
 		return -ENODEV;
 
-	max_packages = topology_max_packages();
+	max_packages = topology_max_packages() * topology_max_die_per_package();
 	packages = kcalloc(max_packages, sizeof(struct pkg_device *),
 			   GFP_KERNEL);
 	if (!packages)
-- 
2.18.0-rc0

