Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37823C43603
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 01:56:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F203C2468A
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 01:56:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HSqEOwJw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727529AbfLTB4f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 20:56:35 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:36566 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727406AbfLTB4P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 20:56:15 -0500
Received: by mail-lf1-f66.google.com with SMTP id n12so5769509lfe.3;
        Thu, 19 Dec 2019 17:56:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3XNfmZ2hjnhg2qNhklB7JqCGu2d7AOuV7BZtvYddOdo=;
        b=HSqEOwJw/zMDkejr/IlMLusTy4Cie2f0YUVoAnqlfNPwtHmAm+RAWNS8RA9k3OYMBM
         mmzy/2GUOPkgxtYFJ3taDbkl3MrqOPVDKtyWKC6C60MHuYCeYISFu9N77HVLasA5A8/s
         YNsAVvziC8pS4rX63Jmzr3/J1d/PfvudxZhiCsmR+hizSORR4xyodUJkgdp0z9O2H8aF
         FSdJmyBer1UlFmftUJCraqSzOfUAc37gOd1uGqXJjqOy9ryVc0+8ph2dAfSNUb1fIz5P
         d8DQCLPM1qUuLPMXSmyc/i2eYrCJiiu1VvTr7Tl077qkMWhZzn4bTarZfPSd9NHkldis
         laVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3XNfmZ2hjnhg2qNhklB7JqCGu2d7AOuV7BZtvYddOdo=;
        b=ohMZABpBC0EFQO6bHJlJjFIUV+bAHCggh5+7FkZNEN3KdYZKs7987NIZoY/fhptx7b
         W+31byRKVbCyiP8yiJ2VU+M7H60nJa2sBK4uKExY8+r/Bo7HRtwvzVJVWk0KaDYeE3zl
         iB53QLUAFCJJWF6RsjOWZq32Fe1KHECxvovZzdKa4f8UlJ8dq0cRODYrhOWnMxhpbZ3g
         qMzBgGsHmOcXIFoNAPqhzBY8cx13+1MXi4Ss1OYBTGkybMNL4Tjbp09XBOXbyWKd+xcm
         gZDD0UUc8I5UElR49QVJ6u7soEq0GN9ZsEhfoeMH44YlcOWIkLd/xQvBUqd5V8CRzHPW
         IQeg==
X-Gm-Message-State: APjAAAUacNuT4N7RRGmLDVFvHrvx/ChZyWGuGVlnnI5cOeRqs3xNWKpA
        jhqWeVkNNRt29iDizKu0gQY=
X-Google-Smtp-Source: APXvYqyjbv45vqVVMVP8f5/41fyY2ncr6rPHHPcyaGS2gZOeoW6OxfWjSX4CkP/TiuD9k4jd/CGCjg==
X-Received: by 2002:a19:48c5:: with SMTP id v188mr7344296lfa.100.1576806972706;
        Thu, 19 Dec 2019 17:56:12 -0800 (PST)
Received: from localhost.localdomain (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.gmail.com with ESMTPSA id m13sm3270901lfo.40.2019.12.19.17.56.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2019 17:56:12 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Chen <Peter.Chen@nxp.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Felipe Balbi <balbi@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 08/10] usb: phy: tegra: Use u32 for hardware register variables
Date:   Fri, 20 Dec 2019 04:52:36 +0300
Message-Id: <20191220015238.9228-9-digetx@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191220015238.9228-1-digetx@gmail.com>
References: <20191220015238.9228-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a mix of u32/ULONG usage in the driver's code. Let's switch to
u32 uniformly, for consistency.

Suggested-by: Thierry Reding <thierry.reding@gmail.com>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/usb/phy/phy-tegra-usb.c | 28 +++++++++++++++-------------
 1 file changed, 15 insertions(+), 13 deletions(-)

diff --git a/drivers/usb/phy/phy-tegra-usb.c b/drivers/usb/phy/phy-tegra-usb.c
index d5739b6e0b6c..551c94e3877a 100644
--- a/drivers/usb/phy/phy-tegra-usb.c
+++ b/drivers/usb/phy/phy-tegra-usb.c
@@ -202,7 +202,7 @@ static inline struct tegra_usb_phy *to_tegra_usb_phy(struct usb_phy *u_phy)
 static void set_pts(struct tegra_usb_phy *phy, u8 pts_val)
 {
 	void __iomem *base = phy->regs;
-	unsigned long val;
+	u32 val;
 
 	if (phy->soc_config->has_hostpc) {
 		val = readl_relaxed(base + TEGRA_USB_HOSTPC1_DEVLC);
@@ -221,7 +221,7 @@ static void set_pts(struct tegra_usb_phy *phy, u8 pts_val)
 static void set_phcd(struct tegra_usb_phy *phy, bool enable)
 {
 	void __iomem *base = phy->regs;
-	unsigned long val;
+	u32 val;
 
 	if (phy->soc_config->has_hostpc) {
 		val = readl_relaxed(base + TEGRA_USB_HOSTPC1_DEVLC);
@@ -320,7 +320,8 @@ static int utmip_pad_power_on(struct tegra_usb_phy *phy)
 {
 	struct tegra_utmip_config *config = phy->config;
 	void __iomem *base = phy->pad_regs;
-	unsigned long val, flags;
+	unsigned long flags;
+	u32 val;
 	int err;
 
 	err = clk_prepare_enable(phy->pad_clk);
@@ -355,7 +356,8 @@ static int utmip_pad_power_on(struct tegra_usb_phy *phy)
 static int utmip_pad_power_off(struct tegra_usb_phy *phy)
 {
 	void __iomem *base = phy->pad_regs;
-	unsigned long val, flags;
+	unsigned long flags;
+	u32 val;
 	int err;
 
 	if (!utmip_pad_count) {
@@ -393,7 +395,7 @@ static int utmi_wait_register(void __iomem *reg, u32 mask, u32 result)
 static void utmi_phy_clk_disable(struct tegra_usb_phy *phy)
 {
 	void __iomem *base = phy->regs;
-	unsigned long val;
+	u32 val;
 
 	/*
 	 * The USB driver may have already initiated the phy clock
@@ -425,7 +427,7 @@ static void utmi_phy_clk_disable(struct tegra_usb_phy *phy)
 static void utmi_phy_clk_enable(struct tegra_usb_phy *phy)
 {
 	void __iomem *base = phy->regs;
-	unsigned long val;
+	u32 val;
 
 	/*
 	 * The USB driver may have already initiated the phy clock
@@ -460,7 +462,7 @@ static int utmi_phy_power_on(struct tegra_usb_phy *phy)
 {
 	struct tegra_utmip_config *config = phy->config;
 	void __iomem *base = phy->regs;
-	unsigned long val;
+	u32 val;
 	int err;
 
 	val = readl_relaxed(base + USB_SUSP_CTRL);
@@ -611,7 +613,7 @@ static int utmi_phy_power_on(struct tegra_usb_phy *phy)
 static int utmi_phy_power_off(struct tegra_usb_phy *phy)
 {
 	void __iomem *base = phy->regs;
-	unsigned long val;
+	u32 val;
 
 	utmi_phy_clk_disable(phy);
 
@@ -646,7 +648,7 @@ static int utmi_phy_power_off(struct tegra_usb_phy *phy)
 static void utmi_phy_preresume(struct tegra_usb_phy *phy)
 {
 	void __iomem *base = phy->regs;
-	unsigned long val;
+	u32 val;
 
 	val = readl_relaxed(base + UTMIP_TX_CFG0);
 	val |= UTMIP_HS_DISCON_DISABLE;
@@ -656,7 +658,7 @@ static void utmi_phy_preresume(struct tegra_usb_phy *phy)
 static void utmi_phy_postresume(struct tegra_usb_phy *phy)
 {
 	void __iomem *base = phy->regs;
-	unsigned long val;
+	u32 val;
 
 	val = readl_relaxed(base + UTMIP_TX_CFG0);
 	val &= ~UTMIP_HS_DISCON_DISABLE;
@@ -667,7 +669,7 @@ static void utmi_phy_restore_start(struct tegra_usb_phy *phy,
 				   enum tegra_usb_phy_port_speed port_speed)
 {
 	void __iomem *base = phy->regs;
-	unsigned long val;
+	u32 val;
 
 	val = readl_relaxed(base + UTMIP_MISC_CFG0);
 	val &= ~UTMIP_DPDM_OBSERVE_SEL(~0);
@@ -687,7 +689,7 @@ static void utmi_phy_restore_start(struct tegra_usb_phy *phy,
 static void utmi_phy_restore_end(struct tegra_usb_phy *phy)
 {
 	void __iomem *base = phy->regs;
-	unsigned long val;
+	u32 val;
 
 	val = readl_relaxed(base + UTMIP_MISC_CFG0);
 	val &= ~UTMIP_DPDM_OBSERVE;
@@ -698,7 +700,7 @@ static void utmi_phy_restore_end(struct tegra_usb_phy *phy)
 static int ulpi_phy_power_on(struct tegra_usb_phy *phy)
 {
 	void __iomem *base = phy->regs;
-	unsigned long val;
+	u32 val;
 	int err;
 
 	err = gpio_direction_output(phy->reset_gpio, 0);
-- 
2.24.0

