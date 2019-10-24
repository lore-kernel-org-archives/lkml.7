Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BB3BCA9EAF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 14:30:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE3252070B
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 14:30:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QeMmMxh2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391802AbfJXOaH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 10:30:07 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44211 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732393AbfJXOaG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 10:30:06 -0400
Received: by mail-wr1-f67.google.com with SMTP id z11so2968215wro.11
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2019 07:30:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=bNO7Hto8/G2C7TUubatFVtXdTSGgn6JkX2p3XRrLHjY=;
        b=QeMmMxh28hQkPLiQhJxGAproWHoOfw30dZwErAfDAmevRDEL8xxWL9fPosFYvxUewe
         00lGqpsnEIcA8iyJOaLFS1ut+WVykTBqaKBUUVOz62wnTvj1Sa85kLaY/6G4DL3FaSnk
         9/WJDg1LFi2qfCzJtiWf01c1RJdDniCh8l4uNXNEdexVg55M9umTc8Cz55tHPVIgLYaw
         pgLTfRVSgoyzYKVF0XDFJte6C6986VGqH31VbdbMcb7O0Fq62V4StYvL5wzBYda6NCtV
         DsBgKVCCyVHBd9WgMV4HnKOhMg8WffO0Aa9QyRJw/FbewIWmbQQjqvip+vQG33bNLM36
         V7tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=bNO7Hto8/G2C7TUubatFVtXdTSGgn6JkX2p3XRrLHjY=;
        b=f/O7AMdIOijoPbnoQ2LOPlEI0nBz8xT6LvBDxkCokCPOnlJhprxjTvpw9H3aIo3VGi
         s0UZzPXv5Y5wmk60a1JHYaQxuHY3M4+1Y9uHgc8L4r7AHYZ0Ze0EqarVDszrQTYf5IlG
         USCwBk5yjX4CNitbJ49oSoPItZtUvMtWxKbX15Jym4Gg80WJX4wkxw9SGMxHOI7SSaxJ
         dEktjBjbmlQSi2FKD+2bZMVui6F0afQb+7EPnKIq9sj8zpQC7+HYytQy51Ut2FJmFFre
         GXhKxxQrJHt+rD8rEx9o1CgYajRGh4eAANPDf7FiZd6IgPmwv0D/tImNVPo//DHXsXF5
         tWng==
X-Gm-Message-State: APjAAAXn8dLb7UTW9L+sIBjR5QqylZPaAVSiE3EffJSbzziY9aCKvaqN
        qC0ml1fELQuMtbbQEoLx2vM=
X-Google-Smtp-Source: APXvYqyF7Wn7rwZo5yw8FQ8NtsqXf8pKes23nKfzo2ZiGHEksOHI/JG11zBpzy4MyPLl6jRsC2+h/w==
X-Received: by 2002:adf:92e7:: with SMTP id 94mr4422784wrn.199.1571927403902;
        Thu, 24 Oct 2019 07:30:03 -0700 (PDT)
Received: from aherlnxbspsrv01.lgs-net.com ([193.8.40.126])
        by smtp.gmail.com with ESMTPSA id a11sm1702190wmh.40.2019.10.24.07.30.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2019 07:30:03 -0700 (PDT)
From:   Andrey Zhizhikin <andrey.z@gmail.com>
X-Google-Original-From: Andrey Zhizhikin <andrey.zhizhikin@leica-geosystems.com>
To:     lgirdwood@gmail.com, broonie@kernel.org,
        andriy.shevchenko@linux.intel.com, lee.jones@linaro.org,
        linux-kernel@vger.kernel.org
Cc:     Andrey Zhizhikin <andrey.zhizhikin@leica-geosystems.com>
Subject: [PATCH 2/2] mfd: add regulator cell to Cherry Trail Whiskey Cove PMIC
Date:   Thu, 24 Oct 2019 14:29:39 +0000
Message-Id: <20191024142939.25920-3-andrey.zhizhikin@leica-geosystems.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191024142939.25920-1-andrey.zhizhikin@leica-geosystems.com>
References: <20191024142939.25920-1-andrey.zhizhikin@leica-geosystems.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a regulator mfd cell to Whiskey Cove PMIC driver, which is used to
supply various voltage rails.

In addition, make the initialization of this mfd driver early enough in
order to provide regulator cell to mmc sub-system when it is initialized.

Signed-off-by: Andrey Zhizhikin <andrey.zhizhikin@leica-geosystems.com>
---
 drivers/mfd/intel_soc_pmic_chtwc.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/mfd/intel_soc_pmic_chtwc.c b/drivers/mfd/intel_soc_pmic_chtwc.c
index be84bb2aa837..47c0d9994784 100644
--- a/drivers/mfd/intel_soc_pmic_chtwc.c
+++ b/drivers/mfd/intel_soc_pmic_chtwc.c
@@ -17,6 +17,7 @@
 #include <linux/mfd/core.h>
 #include <linux/mfd/intel_soc_pmic.h>
 #include <linux/regmap.h>
+#include <linux/regulator/intel-cht-wc-regulator.h>
 
 /* PMIC device registers */
 #define REG_OFFSET_MASK		GENMASK(7, 0)
@@ -58,6 +59,11 @@ static struct mfd_cell cht_wc_dev[] = {
 		.name = "cht_wcove_ext_chgr",
 		.num_resources = ARRAY_SIZE(cht_wc_ext_charger_resources),
 		.resources = cht_wc_ext_charger_resources,
+	}, {
+		.name = "cht_wcove_regulator",
+		.id = CHT_WC_REGULATOR_VSDIO + 1,
+		.num_resources = 0,
+		.resources = NULL,
 	},
 	{	.name = "cht_wcove_region", },
 	{	.name = "cht_wcove_leds", },
@@ -215,7 +221,7 @@ static const struct acpi_device_id cht_wc_acpi_ids[] = {
 	{ }
 };
 
-static struct i2c_driver cht_wc_driver = {
+static struct i2c_driver cht_wc_i2c_driver = {
 	.driver	= {
 		.name	= "CHT Whiskey Cove PMIC",
 		.pm     = &cht_wc_pm_ops,
@@ -225,4 +231,9 @@ static struct i2c_driver cht_wc_driver = {
 	.shutdown = cht_wc_shutdown,
 	.id_table = cht_wc_i2c_id,
 };
-builtin_i2c_driver(cht_wc_driver);
+
+static int __init cht_wc_i2c_init(void)
+{
+	return i2c_add_driver(&cht_wc_i2c_driver);
+}
+subsys_initcall(cht_wc_i2c_init);
-- 
2.17.1

