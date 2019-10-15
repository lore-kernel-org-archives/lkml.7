Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 079D4ECE59D
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 22:46:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D19DB205F4
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 22:46:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="JfcWX6oX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390071AbfJOWqR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 18:46:17 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:45589 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390034AbfJOWqQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 18:46:16 -0400
Received: by mail-pf1-f194.google.com with SMTP id y72so13383398pfb.12
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2019 15:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=MRyV5VGzOFvJD5NtZvpjWbXZE/GnucRH2hQg8MRkrmE=;
        b=JfcWX6oXfyVq3TmG7LHvU0pKK1ND0Oo4l2GcBxe6MeEUvf8OczBR7JJrhNl9e6zK91
         SPT8wPn/444F6wWUkDN0WdiU2ZU46nlVO7twyuqpH0YHFnuwNo/zH/iPJrnMgS9jwucQ
         pdMuNwg902bajHGO5SpdM56zkUQTJy7hSCEq8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=MRyV5VGzOFvJD5NtZvpjWbXZE/GnucRH2hQg8MRkrmE=;
        b=GzXNv5v7zxLgdzbeDZR1FvvwtN3OqOPtC6kf/eya60ZmjNrRsj4+mA8Q01T8PidliJ
         J5YbIo8/3J63rBBDIRYlNcHOX3Bbce83j6FB56cxLY0XYs9l0OQ7KLQST1eUj0fDItNt
         W0DP7pXpIpQknELMT8xrs8c+lQatws6dwj8ct9owcxWtL8iLN0hEVmAwiWWB1RjKmnxR
         KQUETHLEGAFWOLY3NO6aB7rUN2eksmziiP8vJTcGZBPVTDesDqAFFf74vaMBtWb7tXqZ
         72qtweLTFUop9gRYDdg32KzQ5/ifeaGyLTOmuwE1gezQdi0g39wei81EtS8QBmg7Sris
         KCwg==
X-Gm-Message-State: APjAAAXduHrkdYXgmoDeJArjULkiFJdUpJ56OhGCkquc9oFpOiWn2mFN
        wx/Qrb87LZXk5gwc5g9x2FzloA==
X-Google-Smtp-Source: APXvYqxIkLhhpNmJeTJg2ZZOaEaj7KCdmc0Am5liLgcddpekavNnSA5Y0wz9B935nC6Gh50fZc9/Hg==
X-Received: by 2002:a63:394:: with SMTP id 142mr40929199pgd.375.1571179575156;
        Tue, 15 Oct 2019 15:46:15 -0700 (PDT)
Received: from lbrmn-mmayer.ric.broadcom.com ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id e127sm23019837pfe.37.2019.10.15.15.46.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2019 15:46:14 -0700 (PDT)
From:   Markus Mayer <mmayer@broadcom.com>
To:     Brian Norris <computersforpeace@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Gregory Fong <gregory.0xf0@gmail.com>
Cc:     Markus Mayer <mmayer@broadcom.com>,
        Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>,
        ARM Kernel List <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH 3/8] memory: brcmstb: dpfe: add locking around DCPU enable/disable
Date:   Tue, 15 Oct 2019 15:45:08 -0700
Message-Id: <20191015224513.16969-4-mmayer@broadcom.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191015224513.16969-1-mmayer@broadcom.com>
References: <20191015224513.16969-1-mmayer@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To ensure consistency, we add locking primitives inside the DCPU enable
and disable routines.

Signed-off-by: Markus Mayer <mmayer@broadcom.com>
---
 drivers/memory/brcmstb_dpfe.c | 31 +++++++++++++++++++++----------
 1 file changed, 21 insertions(+), 10 deletions(-)

diff --git a/drivers/memory/brcmstb_dpfe.c b/drivers/memory/brcmstb_dpfe.c
index 2ef3e365c1b5..c10c24a76729 100644
--- a/drivers/memory/brcmstb_dpfe.c
+++ b/drivers/memory/brcmstb_dpfe.c
@@ -290,32 +290,41 @@ static const struct dpfe_api dpfe_api_v3 = {
 	},
 };
 
-static bool is_dcpu_enabled(void __iomem *regs)
+static bool is_dcpu_enabled(struct brcmstb_dpfe_priv *priv)
 {
 	u32 val;
 
-	val = readl_relaxed(regs + REG_DCPU_RESET);
+	mutex_lock(&priv->lock);
+	val = readl_relaxed(priv->regs + REG_DCPU_RESET);
+	mutex_unlock(&priv->lock);
 
 	return !(val & DCPU_RESET_MASK);
 }
 
-static void __disable_dcpu(void __iomem *regs)
+static void __disable_dcpu(struct brcmstb_dpfe_priv *priv)
 {
 	u32 val;
 
-	if (!is_dcpu_enabled(regs))
+	if (!is_dcpu_enabled(priv))
 		return;
 
+	mutex_lock(&priv->lock);
+
 	/* Put DCPU in reset if it's running. */
-	val = readl_relaxed(regs + REG_DCPU_RESET);
+	val = readl_relaxed(priv->regs + REG_DCPU_RESET);
 	val |= (1 << DCPU_RESET_SHIFT);
-	writel_relaxed(val, regs + REG_DCPU_RESET);
+	writel_relaxed(val, priv->regs + REG_DCPU_RESET);
+
+	mutex_unlock(&priv->lock);
 }
 
-static void __enable_dcpu(void __iomem *regs)
+static void __enable_dcpu(struct brcmstb_dpfe_priv *priv)
 {
+	void __iomem *regs = priv->regs;
 	u32 val;
 
+	mutex_lock(&priv->lock);
+
 	/* Clear mailbox registers. */
 	writel_relaxed(0, regs + REG_TO_DCPU_MBOX);
 	writel_relaxed(0, regs + REG_TO_HOST_MBOX);
@@ -329,6 +338,8 @@ static void __enable_dcpu(void __iomem *regs)
 	val = readl_relaxed(regs + REG_DCPU_RESET);
 	val &= ~(1 << DCPU_RESET_SHIFT);
 	writel_relaxed(val, regs + REG_DCPU_RESET);
+
+	mutex_unlock(&priv->lock);
 }
 
 static unsigned int get_msg_chksum(const u32 msg[], unsigned int max)
@@ -590,7 +601,7 @@ static int brcmstb_dpfe_download_firmware(struct platform_device *pdev,
 	 * Skip downloading the firmware if the DCPU is already running and
 	 * responding to commands.
 	 */
-	if (is_dcpu_enabled(priv->regs)) {
+	if (is_dcpu_enabled(priv)) {
 		u32 response[MSG_FIELD_MAX];
 
 		ret = __send_command(priv, DPFE_CMD_GET_INFO, response);
@@ -615,7 +626,7 @@ static int brcmstb_dpfe_download_firmware(struct platform_device *pdev,
 	if (ret)
 		return -EFAULT;
 
-	__disable_dcpu(priv->regs);
+	__disable_dcpu(priv);
 
 	is_big_endian = init->is_big_endian;
 	dmem_size = init->dmem_len;
@@ -641,7 +652,7 @@ static int brcmstb_dpfe_download_firmware(struct platform_device *pdev,
 	if (ret)
 		return ret;
 
-	__enable_dcpu(priv->regs);
+	__enable_dcpu(priv);
 
 	return 0;
 }
-- 
2.17.1

