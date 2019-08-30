Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95E8DC3A5A4
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 13:34:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C527233FF
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 13:34:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YJzO+Iif"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727859AbfH3NeR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 09:34:17 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:40906 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727135AbfH3NeR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 09:34:17 -0400
Received: by mail-wm1-f68.google.com with SMTP id t9so7465866wmi.5
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2019 06:34:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=F9xpA9YEFObwvI8dY+JY+1p/cXOMcHmHG8GrzDw/c3k=;
        b=YJzO+Iif88RxSjWuEZ7mu5uUV3EZWtpDGnJYlB6iuTBOnWHHBMker+JAi2gZ7QOFnS
         RIhJp6RNKIq3l8TJLMSwXRcm87ribtTozWuMhtf8fmSQz8kQpqI29sT8z2WaQngbr6Ta
         +bvOSPJb8+aQgzsvdG+DTxfwiJwj99VNTl+f8f2uT21GgzHJR8HjQ8TajJWbKfthcZce
         I/6QZw4SN9wWAnM+ME5zLun9tba0wMlW9aFlzUuwKRBu6PTaHoDuDikbXShaHpwniF/y
         RSOP/LGyign6LiF6VSzzW7pwqiNGJabWwFgETYQwJkuK1XiCD2XUMmMm6a8jhYGsuWyH
         e9ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=F9xpA9YEFObwvI8dY+JY+1p/cXOMcHmHG8GrzDw/c3k=;
        b=ULhUP0cCHsMP47WmJfS424zfeRPI0SXs0qom/FZu0N6vwJxFWZGyIxX/pagU53ieqy
         kb0E2iqP0jM09b/7EJtnIVaFrOklAyspGsq3srQiIGscKIeveoFGq1ju16e3C05jxfm/
         FsnKY1oZSkEYCk13s/m+9QCsitJY/BXLKDfWCLhT+HM2rSUdbi/WTwIHvoVF94IbTp2q
         rhDzyESuh475zMyICjpx+fs7Pg6hr2xpFkyXLTmo+lYv+EhPayJivaRiYwDnwvPnaczF
         XDjp054ziQrvRsxFlkjzGRMT+pP7Av2s+4mXtcKFh75k79RfbtnT8a16F7JQSSSzFsVJ
         BMuw==
X-Gm-Message-State: APjAAAUjKCwywpJoJplgbhcttcBaWfMmhznhRF8meUQJvS0oEkknUrN1
        7n3BqbAPol4AMfWstxfPgogRCBaZ
X-Google-Smtp-Source: APXvYqy6gsWTLjXP1eV0Fa3+C+ToQl6HhDcQt6CnHKZlOVaGaCB8SRQEukp8rY3gg1JM6BquIjj1/Q==
X-Received: by 2002:a05:600c:34d:: with SMTP id u13mr5771336wmd.97.1567172054334;
        Fri, 30 Aug 2019 06:34:14 -0700 (PDT)
Received: from ogabbay-VM.habana-labs.com ([31.154.190.6])
        by smtp.gmail.com with ESMTPSA id x6sm9289624wrt.63.2019.08.30.06.34.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2019 06:34:13 -0700 (PDT)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     linux-kernel@vger.kernel.org, oshpigelman@habana.ai,
        ttayar@habana.ai
Cc:     gregkh@linuxfoundation.org
Subject: [PATCH] habanalabs: display card name as sensors header
Date:   Fri, 30 Aug 2019 16:34:11 +0300
Message-Id: <20190830133411.24697-1-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To allow the user to use a custom file for the HWMON lm-sensors library
per card type, the driver needs to register the HWMON sensors with the
specific card type name.

The card name is supplied by the F/W running on the device. If the F/W is
old and doesn't supply a card name, a default card name is displayed as
the sensors group name.

Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
 drivers/misc/habanalabs/goya/goya.c        |  4 ++++
 drivers/misc/habanalabs/goya/goyaP.h       |  2 ++
 drivers/misc/habanalabs/hwmon.c            |  4 +++-
 drivers/misc/habanalabs/include/armcp_if.h | 17 ++++++++++++++++-
 4 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/goya/goya.c
index 1267ec75b19f..c88c2fea97b9 100644
--- a/drivers/misc/habanalabs/goya/goya.c
+++ b/drivers/misc/habanalabs/goya/goya.c
@@ -4961,6 +4961,10 @@ int goya_armcp_info_get(struct hl_device *hdev)
 		prop->dram_end_address = prop->dram_base_address + dram_size;
 	}
 
+	if (!strlen(prop->armcp_info.card_name))
+		strncpy(prop->armcp_info.card_name, GOYA_DEFAULT_CARD_NAME,
+				CARD_NAME_MAX_LEN);
+
 	return 0;
 }
 
diff --git a/drivers/misc/habanalabs/goya/goyaP.h b/drivers/misc/habanalabs/goya/goyaP.h
index f830cfd5c04d..06da71e8d7ea 100644
--- a/drivers/misc/habanalabs/goya/goyaP.h
+++ b/drivers/misc/habanalabs/goya/goyaP.h
@@ -55,6 +55,8 @@
 
 #define DRAM_PHYS_DEFAULT_SIZE		0x100000000ull	/* 4GB */
 
+#define GOYA_DEFAULT_CARD_NAME		"HL1000"
+
 /* DRAM Memory Map */
 
 #define CPU_FW_IMAGE_SIZE		0x10000000	/* 256MB */
diff --git a/drivers/misc/habanalabs/hwmon.c b/drivers/misc/habanalabs/hwmon.c
index 6c60b901e375..7be4bace9b4f 100644
--- a/drivers/misc/habanalabs/hwmon.c
+++ b/drivers/misc/habanalabs/hwmon.c
@@ -421,6 +421,7 @@ void hl_set_pwm_info(struct hl_device *hdev, int sensor_index, u32 attr,
 int hl_hwmon_init(struct hl_device *hdev)
 {
 	struct device *dev = hdev->pdev ? &hdev->pdev->dev : hdev->dev;
+	struct asic_fixed_properties *prop = &hdev->asic_prop;
 	int rc;
 
 	if ((hdev->hwmon_initialized) || !(hdev->fw_loading))
@@ -430,7 +431,8 @@ int hl_hwmon_init(struct hl_device *hdev)
 		hdev->hl_chip_info->ops = &hl_hwmon_ops;
 
 		hdev->hwmon_dev = hwmon_device_register_with_info(dev,
-				"habanalabs", hdev, hdev->hl_chip_info, NULL);
+					prop->armcp_info.card_name, hdev,
+					hdev->hl_chip_info, NULL);
 		if (IS_ERR(hdev->hwmon_dev)) {
 			rc = PTR_ERR(hdev->hwmon_dev);
 			dev_err(hdev->dev,
diff --git a/drivers/misc/habanalabs/include/armcp_if.h b/drivers/misc/habanalabs/include/armcp_if.h
index 1f1e35e86d84..5565bce60bc9 100644
--- a/drivers/misc/habanalabs/include/armcp_if.h
+++ b/drivers/misc/habanalabs/include/armcp_if.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0
  *
- * Copyright 2016-2018 HabanaLabs, Ltd.
+ * Copyright 2016-2019 HabanaLabs, Ltd.
  * All Rights Reserved.
  *
  */
@@ -310,6 +310,7 @@ struct eq_generic_event {
  * ArmCP info
  */
 
+#define CARD_NAME_MAX_LEN		16
 #define VERSION_MAX_LEN			128
 #define ARMCP_MAX_SENSORS		128
 
@@ -318,6 +319,19 @@ struct armcp_sensor {
 	__le32 flags;
 };
 
+/**
+ * struct armcp_info - host driver's necessary info from ArmCP.
+ * @sensors: available sensors description.
+ * @kernel_version: ArmCP linux kernel version.
+ * @reserved: reserved field.
+ * @cpld_version: CPLD programmed F/W version.
+ * @infineon_version: Infineon main DC-DC version.
+ * @fuse_version: silicon production FUSE information.
+ * @thermal_version: thermald S/W version.
+ * @armcp_version: ArmCP S/W version.
+ * @dram_size: available DRAM size.
+ * @card_name: card name that will be displayed in HWMON subsystem on the host
+ */
 struct armcp_info {
 	struct armcp_sensor sensors[ARMCP_MAX_SENSORS];
 	__u8 kernel_version[VERSION_MAX_LEN];
@@ -328,6 +342,7 @@ struct armcp_info {
 	__u8 thermal_version[VERSION_MAX_LEN];
 	__u8 armcp_version[VERSION_MAX_LEN];
 	__le64 dram_size;
+	char card_name[CARD_NAME_MAX_LEN];
 };
 
 #endif /* ARMCP_IF_H */
-- 
2.17.1

