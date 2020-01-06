Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE993C33C99
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 01:35:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A55C5215A4
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 01:35:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E9t0YDM4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727592AbgAFBfl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Jan 2020 20:35:41 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:38706 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727429AbgAFBey (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jan 2020 20:34:54 -0500
Received: by mail-lj1-f194.google.com with SMTP id w1so27340347ljh.5;
        Sun, 05 Jan 2020 17:34:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dflUvxh9hQS7NEkqv7qNke7Xes24FVjfSEb+Lpz8tfc=;
        b=E9t0YDM4Xxsgsty8Mg3J/EVllC/zYTXX7GsP6p1GIdG5XiyVEAQvZXjbf4uQKuRjjR
         eTm0abx8E0pCe6sFyW8ZPgfBU7dTjPE9tjIM98MF/01GjSiv0lf9Wx+GQP/xHw+3wgzg
         vrKLZi6e/RZxHRnVtqwXaEJa50YSdmB7QoaO6AWX/fOhwH8ct8apJwGa93/LSZ5O8wib
         rz0Yoi0S1Iht1cqhzmk7BrDT0N4k6Qhy9rBxJdoj6y77wiUB0zoRQWioa2UNcozKRZzL
         rBSvnjCo32sxu0MUPQ4ZDNfHbPW2iCUVnnB4ROODXdOJgyx26qvGuVkPBszF+HFWCnXd
         NSsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dflUvxh9hQS7NEkqv7qNke7Xes24FVjfSEb+Lpz8tfc=;
        b=On8vkkNloL1hY/MDoG+o3VITn1gDD5aYJRZFJcmrf1zlznk85nKa/RDif585ZUqWUf
         fm/MZC/6Rch+AxqU11+1XcAC5YimZXDRZ2NLILRFJ67nbRZbrzY7sTsvz/LKfxKZMzIT
         LV0n8yYyZLVkAJqC+0NAogTH0kXk/q3plFPfB/B+6BC+r23WpJXgP7atpuvAi1Lw6YYE
         cV+ruV52oqnmSHY8J+azYMB96vaSkBCbiMWv9+VuXqtzmYT7Gk7E6rltRjtxd9KvyrUx
         8Foqi8c/YS03iC+azjsHxCE1kNj21skdKEFxSLx4hQH63IZJMkd7xfYUPz7IB4e6OXWk
         afXQ==
X-Gm-Message-State: APjAAAUm+clEkXkNmNV2mjcnKXpJY2wdoraFpJue50W4qZvmyzZN9GY5
        n5XIxEhpDgsKgL098EDE6b2wX9ag
X-Google-Smtp-Source: APXvYqxVKSwnEZdwUt2LK4IbiZJQHsEAJMBPngoRdgH1yCopshRt4D4JP8wdnrst7LPaajj+QkYTlg==
X-Received: by 2002:a2e:b177:: with SMTP id a23mr54673523ljm.202.1578274491613;
        Sun, 05 Jan 2020 17:34:51 -0800 (PST)
Received: from localhost.localdomain (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.gmail.com with ESMTPSA id h10sm28235739ljc.39.2020.01.05.17.34.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jan 2020 17:34:51 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Chen <Peter.Chen@nxp.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Felipe Balbi <balbi@kernel.org>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Cc:     linux-usb@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 12/20] usb: phy: tegra: Use u32 for hardware register variables
Date:   Mon,  6 Jan 2020 04:34:08 +0300
Message-Id: <20200106013416.9604-13-digetx@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200106013416.9604-1-digetx@gmail.com>
References: <20200106013416.9604-1-digetx@gmail.com>
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
index 9adbcdf8d3a1..f9acbab477cf 100644
--- a/drivers/usb/phy/phy-tegra-usb.c
+++ b/drivers/usb/phy/phy-tegra-usb.c
@@ -204,7 +204,7 @@ static inline struct tegra_usb_phy *to_tegra_usb_phy(struct usb_phy *u_phy)
 static void set_pts(struct tegra_usb_phy *phy, u8 pts_val)
 {
 	void __iomem *base = phy->regs;
-	unsigned long val;
+	u32 val;
 
 	if (phy->soc_config->has_hostpc) {
 		val = readl_relaxed(base + TEGRA_USB_HOSTPC1_DEVLC);
@@ -223,7 +223,7 @@ static void set_pts(struct tegra_usb_phy *phy, u8 pts_val)
 static void set_phcd(struct tegra_usb_phy *phy, bool enable)
 {
 	void __iomem *base = phy->regs;
-	unsigned long val;
+	u32 val;
 
 	if (phy->soc_config->has_hostpc) {
 		val = readl_relaxed(base + TEGRA_USB_HOSTPC1_DEVLC);
@@ -310,7 +310,8 @@ static int utmip_pad_power_on(struct tegra_usb_phy *phy)
 {
 	struct tegra_utmip_config *config = phy->config;
 	void __iomem *base = phy->pad_regs;
-	unsigned long val, flags;
+	unsigned long flags;
+	u32 val;
 	int err;
 
 	err = clk_prepare_enable(phy->pad_clk);
@@ -345,7 +346,8 @@ static int utmip_pad_power_on(struct tegra_usb_phy *phy)
 static int utmip_pad_power_off(struct tegra_usb_phy *phy)
 {
 	void __iomem *base = phy->pad_regs;
-	unsigned long val, flags;
+	unsigned long flags;
+	u32 val;
 	int err;
 
 	if (!utmip_pad_count) {
@@ -383,7 +385,7 @@ static int utmi_wait_register(void __iomem *reg, u32 mask, u32 result)
 static void utmi_phy_clk_disable(struct tegra_usb_phy *phy)
 {
 	void __iomem *base = phy->regs;
-	unsigned long val;
+	u32 val;
 
 	/*
 	 * The USB driver may have already initiated the phy clock
@@ -415,7 +417,7 @@ static void utmi_phy_clk_disable(struct tegra_usb_phy *phy)
 static void utmi_phy_clk_enable(struct tegra_usb_phy *phy)
 {
 	void __iomem *base = phy->regs;
-	unsigned long val;
+	u32 val;
 
 	/*
 	 * The USB driver may have already initiated the phy clock
@@ -450,7 +452,7 @@ static int utmi_phy_power_on(struct tegra_usb_phy *phy)
 {
 	struct tegra_utmip_config *config = phy->config;
 	void __iomem *base = phy->regs;
-	unsigned long val;
+	u32 val;
 	int err;
 
 	val = readl_relaxed(base + USB_SUSP_CTRL);
@@ -601,7 +603,7 @@ static int utmi_phy_power_on(struct tegra_usb_phy *phy)
 static int utmi_phy_power_off(struct tegra_usb_phy *phy)
 {
 	void __iomem *base = phy->regs;
-	unsigned long val;
+	u32 val;
 
 	utmi_phy_clk_disable(phy);
 
@@ -636,7 +638,7 @@ static int utmi_phy_power_off(struct tegra_usb_phy *phy)
 static void utmi_phy_preresume(struct tegra_usb_phy *phy)
 {
 	void __iomem *base = phy->regs;
-	unsigned long val;
+	u32 val;
 
 	val = readl_relaxed(base + UTMIP_TX_CFG0);
 	val |= UTMIP_HS_DISCON_DISABLE;
@@ -646,7 +648,7 @@ static void utmi_phy_preresume(struct tegra_usb_phy *phy)
 static void utmi_phy_postresume(struct tegra_usb_phy *phy)
 {
 	void __iomem *base = phy->regs;
-	unsigned long val;
+	u32 val;
 
 	val = readl_relaxed(base + UTMIP_TX_CFG0);
 	val &= ~UTMIP_HS_DISCON_DISABLE;
@@ -657,7 +659,7 @@ static void utmi_phy_restore_start(struct tegra_usb_phy *phy,
 				   enum tegra_usb_phy_port_speed port_speed)
 {
 	void __iomem *base = phy->regs;
-	unsigned long val;
+	u32 val;
 
 	val = readl_relaxed(base + UTMIP_MISC_CFG0);
 	val &= ~UTMIP_DPDM_OBSERVE_SEL(~0);
@@ -677,7 +679,7 @@ static void utmi_phy_restore_start(struct tegra_usb_phy *phy,
 static void utmi_phy_restore_end(struct tegra_usb_phy *phy)
 {
 	void __iomem *base = phy->regs;
-	unsigned long val;
+	u32 val;
 
 	val = readl_relaxed(base + UTMIP_MISC_CFG0);
 	val &= ~UTMIP_DPDM_OBSERVE;
@@ -688,7 +690,7 @@ static void utmi_phy_restore_end(struct tegra_usb_phy *phy)
 static int ulpi_phy_power_on(struct tegra_usb_phy *phy)
 {
 	void __iomem *base = phy->regs;
-	unsigned long val;
+	u32 val;
 	int err;
 
 	err = gpio_direction_output(phy->reset_gpio, 0);
-- 
2.24.0

