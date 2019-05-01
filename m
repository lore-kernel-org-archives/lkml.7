Return-Path: <SRS0=0OOB=TB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15EBBC43219
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 04:25:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDDE32177B
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 04:25:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556684720;
	bh=VFmF4WS6JtISMVf5yHfToITGVLcDpVuw1ddtxVJMEmE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To:List-ID:
	 From;
	b=EggtQHhD/iNtmcC1QoVED1boymCsDHc2dqgd0aLhjNnJwpVzPn1lt1wcJVG9JHS2v
	 zZzn6tcx7jQl9o2ceZBjEYhaOou/SGogChPGdTSA/umZoekZ59R9OnuKEvQsfV8/Ek
	 /oAlnMAD/XFaPXnPucN1l2mtUoNJFiyNbN+//8/s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726437AbfEAEZT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 May 2019 00:25:19 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:35560 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726304AbfEAEYu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 May 2019 00:24:50 -0400
Received: by mail-it1-f193.google.com with SMTP id l140so7128867itb.0;
        Tue, 30 Apr 2019 21:24:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :reply-to:organization;
        bh=rda4g5SmmmtmdoeM7SRiTHesp2r+cZMc+xc7m73KM/g=;
        b=mL7EYPtl3eTw0zWsEq89GUs8m6iX0v6/eMe1c9ucZxVMJi6TnXJlR33EzsHbMeV1eX
         7hEaLIX9v2VFXl1ZXIjPnrQFe7WVelc4403n6BocqoTYjZ+dMI9XFu+SQYDTqJzpM0c/
         EAvoLg5PyPsPBdIuOcBycVWZW8XAliPhF/ivvl4YqPfwX0CoXsFnjD1l8c9JH8vq2yz3
         8t09jb+rlsrPLy0GZVz1kiiOMvuog0k+kgdFC87OtcKCJjdUIMaDrIv+kE7BKhisN4s6
         6io5eNh4YFPwhHK4zdyN1QY+MUWxViMUJm+xhlMnXyV+pcfHo4mSdjLeXZkzbk7eF8DZ
         CJeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:reply-to:organization;
        bh=rda4g5SmmmtmdoeM7SRiTHesp2r+cZMc+xc7m73KM/g=;
        b=s8Os9ODyWVxvAT3IRxrZgDdboAArt6m+XWgtU1Xr1unjwHvusHrTHwI0EIoHtKCAeM
         P/KrF21AGhyCIfjCQC5MZJl47ghs9kchBU9alChSwvgeacfppAhYpnNVt1c9fMU7J2a4
         43htAVuHsUZ5jLvhwOU9uM+k86cDlfZwfmXtnZl/KDxVX5iFCxG6fUiTNMl4W9EWQRGV
         93Yjtni3QdYK00iRq3hCwMpNqpZAShlfBqLzIDQ84y08/3rrZ3it3e8tHQ/rCG1ZQag5
         +KEI3HkBgPk8NMeiGbQNNXPF1g5F+1OEDCMaDZyN7psrG9aVhN1i5aN+Y0CbrZgklGog
         HLfg==
X-Gm-Message-State: APjAAAUoyJGQ3xFP9Kf7OsqCIM8J2t7TRiIx3YNQQaGfSQqBLxbUMO8T
        Av9/VGrrrd0ev2ItMSrka2k=
X-Google-Smtp-Source: APXvYqxtknx15Ai4EZE+A1SO2kwRfSyjNAMumcbNMpd4xCSYGb+tRb8REcvXdgZA4YrHD8LzfrhczQ==
X-Received: by 2002:a02:c807:: with SMTP id p7mr5228568jao.38.1556684689712;
        Tue, 30 Apr 2019 21:24:49 -0700 (PDT)
Received: from nuc8.lan (h69-131-112-51.cntcnh.dsl.dynamic.tds.net. [69.131.112.51])
        by smtp.gmail.com with ESMTPSA id b8sm2569728itb.20.2019.04.30.21.24.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Apr 2019 21:24:49 -0700 (PDT)
From:   Len Brown <lenb@kernel.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>,
        Len Brown <len.brown@intel.com>, linux-pm@vger.kernel.org,
        linux-hwmon@vger.kernel.org
Subject: [PATCH 13/18] hwmon/coretemp: Support multi-die/package
Date:   Wed,  1 May 2019 00:24:22 -0400
Message-Id: <10af238e4f996ccfc0ecf8baedca04df0c65c7c1.1556657368.git.len.brown@intel.com>
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

Update coretemp to be "die-aware", so it can expose mulitple sensors
per package, instead of just one.  No change to single-die/package
systems.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
Acked-by: Guenter Roeck <linux@roeck-us.net>
Cc: linux-pm@vger.kernel.org
Cc: linux-hwmon@vger.kernel.org
---
 drivers/hwmon/coretemp.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/hwmon/coretemp.c b/drivers/hwmon/coretemp.c
index 5d34f7271e67..23a2d90534c7 100644
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
@@ -732,6 +732,7 @@ static enum cpuhp_state coretemp_hp_online;
 static int __init coretemp_init(void)
 {
 	int err;
+	struct cpuinfo_x86 *c = &cpu_data(0);
 
 	/*
 	 * CPUID.06H.EAX[0] indicates whether the CPU has thermal
@@ -741,7 +742,7 @@ static int __init coretemp_init(void)
 	if (!x86_match_cpu(coretemp_ids))
 		return -ENODEV;
 
-	max_packages = topology_max_packages();
+	max_packages = topology_max_packages() * topology_max_die_per_package();
 	pkg_devices = kcalloc(max_packages, sizeof(struct platform_device *),
 			      GFP_KERNEL);
 	if (!pkg_devices)
-- 
2.18.0-rc0

