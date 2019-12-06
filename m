Return-Path: <SRS0=xBSd=Z4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27F2CC43603
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 18:46:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFB572467A
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 18:46:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TFnRVyht"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726465AbfLFSq0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Dec 2019 13:46:26 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:39447 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726317AbfLFSqY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Dec 2019 13:46:24 -0500
Received: by mail-pl1-f193.google.com with SMTP id o9so3072650plk.6;
        Fri, 06 Dec 2019 10:46:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4ALlNtT9n//klMFnTtfFii4pRLMXyJbBsPcMcF/Rqyk=;
        b=TFnRVyhtoot/cjUc7zbP9FvPleB1QnRt3VHm+kqU/jL/ZbvvLAn9EI3E2YIwpPSCLk
         5PDSszs2xes7VZVCLdoO3pqAHdhQQYcAZGZvOFw+Z6GpQ7u7m88VSk6SmhR35XRSzJYU
         M3aZikNJQXwd3v2bHXNTzOdYqQztoqEtQC2MPLyXl6vEepcbp0H4Gu3RKIbl55iMu1H6
         qx5uo1c/l/6cunCIiBsdsCtqczGhl51GDRotV1Ch+k0PHQfy8fF6SeAmxCBWKvovIORw
         XvL3GKPqE5m0E/h+m4fmj7Oz6oy8MGNktXXjlzipi43R5RmCX16MPjYQIHnsRy6bz7Mc
         w1DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4ALlNtT9n//klMFnTtfFii4pRLMXyJbBsPcMcF/Rqyk=;
        b=BB5po+x3OyYxQg/Z6Jubj0K9yX4XJ8OWNqC7y/Chxmhn8OKeL6Y9JXdqfJ0KlP707x
         rJug3Ejr63Fptn0B/MaJp8sVn8/RbtIgeI9FiniWGb4VdL78IIlqk3OFE9DZ+pjm90LD
         3FUD+2xEVIfPNLpG7LuQYMy50W38+np10vTga184TQFyzGLoFs0DDrW16B1MsgSaQzB6
         rONVN9kv/yzNxh++RpaRQWO7DytjAnSyw/kE00yXTfmzdLRm8+k5rODK3CCdx0aIP0Ms
         XBjZXVBdlJjIcavIdhb1ah3OyVyjQpA+7FTD+UTRxhx+6JYt8RbEWcQFpZrj4Zwtftam
         Bcag==
X-Gm-Message-State: APjAAAXuhgHI8U7g3Ww80/OJyHnBD3bzYCoVk96W/fQEop78CRSrAAPz
        8jspofH4d/XfRhQgIaUpp1I=
X-Google-Smtp-Source: APXvYqwJ3vW/5vn+8PO8lIFvDhxoxtwWhq8ZXvm66ph4wqJuhTiFgpU20jDmqQHprCawpSALC+Vcqg==
X-Received: by 2002:a17:902:fe91:: with SMTP id x17mr15451025plm.50.1575657984312;
        Fri, 06 Dec 2019 10:46:24 -0800 (PST)
Received: from localhost.localdomain ([103.51.73.190])
        by smtp.gmail.com with ESMTPSA id p4sm16777039pfb.157.2019.12.06.10.46.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2019 10:46:23 -0800 (PST)
From:   Anand Moon <linux.amoon@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Daniel Schultz <d.schultz@phytec.de>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [RFCv1 2/8] mfd: rk808: use syscore for RK805 PMIC shutdown
Date:   Fri,  6 Dec 2019 18:45:30 +0000
Message-Id: <20191206184536.2507-3-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191206184536.2507-1-linux.amoon@gmail.com>
References: <20191206184536.2507-1-linux.amoon@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use common syscore_shutdown for RK805 PMIC to do
clean I2C shutdown, drop the unused pm_pwroff_prep_fn
and pm_pwroff_fn function pointers.

Cc: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
 drivers/mfd/rk808.c | 33 +++++++++++++++++----------------
 1 file changed, 17 insertions(+), 16 deletions(-)

diff --git a/drivers/mfd/rk808.c b/drivers/mfd/rk808.c
index e637f5bcc8bb..713d989064ba 100644
--- a/drivers/mfd/rk808.c
+++ b/drivers/mfd/rk808.c
@@ -467,16 +467,6 @@ static void rk808_update_bits(unsigned int reg, unsigned int mask,
 			"can't write to register 0x%x: %x!\n", reg, ret);
 }
 
-static void rk805_device_shutdown(void)
-{
-	rk808_update_bits(RK805_DEV_CTRL_REG, DEV_OFF, DEV_OFF);
-}
-
-static void rk805_device_shutdown_prepare(void)
-{
-	rk808_update_bits(RK805_GPIO_IO_POL_REG, SLP_SD_MSK, SHUTDOWN_FUN);
-}
-
 static void rk808_device_shutdown(void)
 {
 	rk808_update_bits(RK808_DEVCTRL_REG, DEV_OFF_RST, DEV_OFF_RST);
@@ -491,10 +481,23 @@ static void rk8xx_syscore_shutdown(void)
 {
 	struct rk808 *rk808 = i2c_get_clientdata(rk808_i2c_client);
 
-	if (system_state == SYSTEM_POWER_OFF &&
-	    (rk808->variant == RK809_ID || rk808->variant == RK817_ID)) {
-		rk808_update_bits(RK817_SYS_CFG(3), RK817_SLPPIN_FUNC_MSK,
-				SLPPIN_DN_FUN);
+	if (system_state == SYSTEM_POWER_OFF) {
+		dev_info(&rk808_i2c_client->dev, "System Shutdown Event\n");
+
+		switch (rk808->variant) {
+		case RK805_ID:
+			rk808_update_bits(RK805_GPIO_IO_POL_REG,
+					SLP_SD_MSK, SHUTDOWN_FUN);
+			rk808_update_bits(RK805_DEV_CTRL_REG, DEV_OFF, DEV_OFF);
+			break;
+		case RK809_ID:
+		case RK817_ID:
+			rk808_update_bits(RK817_SYS_CFG(3),
+					RK817_SLPPIN_FUNC_MSK, SLPPIN_DN_FUN);
+			break;
+		default:
+			break;
+		}
 	}
 }
 
@@ -565,8 +568,6 @@ static int rk808_probe(struct i2c_client *client,
 		nr_pre_init_regs = ARRAY_SIZE(rk805_pre_init_reg);
 		cells = rk805s;
 		nr_cells = ARRAY_SIZE(rk805s);
-		rk808->pm_pwroff_fn = rk805_device_shutdown;
-		rk808->pm_pwroff_prep_fn = rk805_device_shutdown_prepare;
 		break;
 	case RK808_ID:
 		rk808->regmap_cfg = &rk808_regmap_config;
-- 
2.24.0

