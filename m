Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20120C7618B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 07:21:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8E872166E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 07:21:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hcdxHXTX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726526AbfGZHVi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 03:21:38 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:41612 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726490AbfGZHVh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 03:21:37 -0400
Received: by mail-pl1-f196.google.com with SMTP id m9so24315230pls.8
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2019 00:21:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=awaZGPNc/AiKA1O3cSLxgegYtsyLyL9rlW0mw3ih7no=;
        b=hcdxHXTXSCGhdOQdBW4+4VMJP+Jhc+nc1uovLJWNFJxc41lrFFPfCNYwCPTFcxDoXb
         9tr86iamuf0K6KAiiVUTjXGfwpT4MgiIe6IjOR7TQFqZicFg82ntoaSGMYaV7wmpo0Ie
         CqZfC8dNbK0TPqeiXoAsJwnIBcsbukcG7qH+elAgtHduucPyF0kt6NKVL3/FuNCxVwxS
         YkPZZi33pmgj+rZqQ1vAkYonQd1huLBzxfwiLZvixQKPKhxjSnPc4BJ9EscG0vQVrHBW
         o9Mik5sW0MV6Fuv0x725KZOrtn3ECutcv0/R93ssh5nHgN1o27ocG+l30Hvj2DCYc1Gu
         l+eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=awaZGPNc/AiKA1O3cSLxgegYtsyLyL9rlW0mw3ih7no=;
        b=GJR+Nauz9WALvixnllXzf+yuDWEHAisYKu3Ee5jhJQ9tQBCetIvZjUi3GkSzKpUbxh
         0InRSPgFwSzaFslzOjghTskjbKhrmJ5pWuluGP6Lgfg70PLXEFJ25cOfWVj7TIzXbTl4
         odMXIK77X2nYty3ACTbOkY1l9U3Ux31X3LhN2gcScmziZK5d3Yzvbfg0UP1CsOxTSBpa
         noI0sPNia8WpmVeR44gGyP2JFH9cC4QlkcuzNO5AjdJSG7OfMMcE7V8epmxStC7kuejJ
         toJF5XJ8A7PTSpUrhuJ2Ko2wpCfmTb/3aL07qlfi96tciJwU3uHSR4uF9JCAn+14QO6S
         ySJA==
X-Gm-Message-State: APjAAAXFxJxb+dUd+paMA3zujo/1GW11FaeGVPKSka8+evKAVh5sfAg9
        mYwogYwMB3FO+VboyYYPhXejpg==
X-Google-Smtp-Source: APXvYqz5csq4PH62Y4pHncq04XhqPmiZ0V67ygPR5K9KyAY1KJ9EhukP86bExIV61cuWT7DVjtiNvg==
X-Received: by 2002:a17:902:9688:: with SMTP id n8mr92948320plp.227.1564125696457;
        Fri, 26 Jul 2019 00:21:36 -0700 (PDT)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id o12sm39216152pjr.22.2019.07.26.00.21.33
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 26 Jul 2019 00:21:36 -0700 (PDT)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     broonie@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        orsonzhai@gmail.com, zhang.lyra@gmail.com
Cc:     weicx@spreadst.com, sherry.zong@unisoc.com, baolin.wang@linaro.org,
        vincent.guittot@linaro.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/6] spi: sprd: adi: Add a reset reason for watchdog mode
Date:   Fri, 26 Jul 2019 15:20:51 +0800
Message-Id: <1563f3de43c6c2262d597a25d6138b5de61ea23d.1564125131.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1564125131.git.baolin.wang@linaro.org>
References: <cover.1564125131.git.baolin.wang@linaro.org>
In-Reply-To: <cover.1564125131.git.baolin.wang@linaro.org>
References: <cover.1564125131.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sherry Zong <sherry.zong@unisoc.com>

When the system was rebooted by watchdog, now we did not save the watchdog
reset mode which will make system enter a incorrect mode after rebooting.

Thus we should set the watchdog reset mode as default when opening the
watchdog configuration, that means if the system was rebooted by other
reason through the restart_handler(), then we will clear the default
watchdog reset mode to save the correct reset mode.

Signed-off-by: Sherry Zong <sherry.zong@unisoc.com>
Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 drivers/spi/spi-sprd-adi.c |   15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/spi/spi-sprd-adi.c b/drivers/spi/spi-sprd-adi.c
index 509ce69..0d767eb 100644
--- a/drivers/spi/spi-sprd-adi.c
+++ b/drivers/spi/spi-sprd-adi.c
@@ -99,6 +99,7 @@
 #define HWRST_STATUS_IQMODE		0xb0
 #define HWRST_STATUS_SPRDISK		0xc0
 #define HWRST_STATUS_FACTORYTEST	0xe0
+#define HWRST_STATUS_WATCHDOG		0xf0
 
 /* Use default timeout 50 ms that converts to watchdog values */
 #define WDG_LOAD_VAL			((50 * 1000) / 32768)
@@ -309,6 +310,18 @@ static int sprd_adi_transfer_one(struct spi_controller *ctlr,
 	return 0;
 }
 
+static void sprd_adi_set_wdt_rst_mode(struct sprd_adi *sadi)
+{
+#ifdef CONFIG_SPRD_WATCHDOG
+	u32 val;
+
+	/* Set default watchdog reboot mode */
+	sprd_adi_read(sadi, sadi->slave_pbase + PMIC_RST_STATUS, &val);
+	val |= HWRST_STATUS_WATCHDOG;
+	sprd_adi_write(sadi, sadi->slave_pbase + PMIC_RST_STATUS, val);
+#endif
+}
+
 static int sprd_adi_restart_handler(struct notifier_block *this,
 				    unsigned long mode, void *cmd)
 {
@@ -347,6 +360,7 @@ static int sprd_adi_restart_handler(struct notifier_block *this,
 
 	/* Record the reboot mode */
 	sprd_adi_read(sadi, sadi->slave_pbase + PMIC_RST_STATUS, &val);
+	val &= ~HWRST_STATUS_WATCHDOG;
 	val |= reboot_mode;
 	sprd_adi_write(sadi, sadi->slave_pbase + PMIC_RST_STATUS, val);
 
@@ -475,6 +489,7 @@ static int sprd_adi_probe(struct platform_device *pdev)
 	}
 
 	sprd_adi_hw_init(sadi);
+	sprd_adi_set_wdt_rst_mode(sadi);
 
 	ctlr->dev.of_node = pdev->dev.of_node;
 	ctlr->bus_num = pdev->id;
-- 
1.7.9.5

