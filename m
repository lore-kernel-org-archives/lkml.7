Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C284C433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 19:51:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 290B3217F4
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 19:51:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=starry.com header.i=@starry.com header.b="rIipgiyV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388813AbfHATvX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 15:51:23 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:39380 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388633AbfHATvU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 15:51:20 -0400
Received: by mail-qk1-f195.google.com with SMTP id w190so52998723qkc.6
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2019 12:51:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=starry.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=D/K1loka/6zG6DwB1243dPqmb+YIeBE9Vk0BGquD0uA=;
        b=rIipgiyV6ztL0sGjZbtl7FSbZnK6AWnBURAv//sDJBYMTnS44ruLL89eJi2Fc1gLzf
         41SpNZDk0PPEdu7mZJZrFG4Eqq+UpRyQol5rIF7ux6MnmEoYVaINcs9H7ljfBo5Kw2N5
         4SHpe6rJ+0kGH7Ra8uHZjfro5oYgcqM/LxdRY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=D/K1loka/6zG6DwB1243dPqmb+YIeBE9Vk0BGquD0uA=;
        b=NmBAziTA2WXD/YheIMCRfgVHRnFj6iH7ZtNKg0/G5htb14mWCkApZ07ykG5q1LNuR+
         awpQjq9xWZnxgZ42Pye9u9mYEumsomJNQSzGJFobz9So161gBchJxq8xspSgKWO+X4jM
         tFPaFpZ6GwipCRWMPVh60xAHOl8SCAWmxBgkhTlSsLuFuHrNyXvoKvoMAX40SXzQMPiF
         dH+4KWdN1QYkmFfWqO1IYniyYM6G8HAyw+gzO6HOGOJT1eOHMdyaROkPmwbPM01g5xEE
         784cfY2bsQP5MkB/6CxnSOOLyiwckZC5rAmBlgVai30idm9OHKn3LAhFE/puSUDkEgKJ
         dvVA==
X-Gm-Message-State: APjAAAXGAIyU6872wDUPNB6TJHpRV/F2sVc2RuOZmvo82X/ml5V18Bv0
        r6zaiQ+oigbwwZcRlj/WqsmhJ/OOx5Q=
X-Google-Smtp-Source: APXvYqwqVy85RtMqklKEkeAy3tMF0/TY1NNt7W0rkaAzUBYOP3aIXfdsS+aNntrY/aIgejujnk3SAA==
X-Received: by 2002:ae9:ea17:: with SMTP id f23mr67338580qkg.236.1564689079639;
        Thu, 01 Aug 2019 12:51:19 -0700 (PDT)
Received: from localhost.localdomain (205-201-16-55.starry-inc.net. [205.201.16.55])
        by smtp.gmail.com with ESMTPSA id h4sm31271944qkk.39.2019.08.01.12.51.18
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 01 Aug 2019 12:51:19 -0700 (PDT)
From:   Matt Pelland <mpelland@starry.com>
To:     linux-kernel@vger.kernel.org
Cc:     kishon@ti.com, antoine.tenart@bootlin.com,
        linux-arm-kernel@lists.infradead.org,
        Matt Pelland <mpelland@starry.com>
Subject: [PATCH 2/4] phy: marvell: phy-mvebu-cp110-comphy: rename instances of DLT
Date:   Thu,  1 Aug 2019 15:50:59 -0400
Message-Id: <20190801195059.24005-3-mpelland@starry.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190801195059.24005-1-mpelland@starry.com>
References: <20190801195059.24005-1-mpelland@starry.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The documentation for Marvell's cp110 phy refers to these
registers/register regions as DTL control, DTL frequency loop enable,
etc. This patch aligns the relevant code for these accordingly.

Signed-off-by: Matt Pelland <mpelland@starry.com>
---
 drivers/phy/marvell/phy-mvebu-cp110-comphy.c | 22 ++++++++++----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/phy/marvell/phy-mvebu-cp110-comphy.c b/drivers/phy/marvell/phy-mvebu-cp110-comphy.c
index f7f8d2bfd641..f0c02e426da4 100644
--- a/drivers/phy/marvell/phy-mvebu-cp110-comphy.c
+++ b/drivers/phy/marvell/phy-mvebu-cp110-comphy.c
@@ -78,8 +78,8 @@
 #define MVEBU_COMPHY_TX_SLEW_RATE(n)		(0x974 + (n) * 0x1000)
 #define     MVEBU_COMPHY_TX_SLEW_RATE_EMPH(n)	((n) << 5)
 #define     MVEBU_COMPHY_TX_SLEW_RATE_SLC(n)	((n) << 10)
-#define MVEBU_COMPHY_DLT_CTRL(n)		(0x984 + (n) * 0x1000)
-#define     MVEBU_COMPHY_DLT_CTRL_DTL_FLOOP_EN	BIT(2)
+#define MVEBU_COMPHY_DTL_CTRL(n)		(0x984 + (n) * 0x1000)
+#define     MVEBU_COMPHY_DTL_CTRL_DTL_FLOOP_EN	BIT(2)
 #define MVEBU_COMPHY_FRAME_DETECT0(n)		(0xa14 + (n) * 0x1000)
 #define     MVEBU_COMPHY_FRAME_DETECT0_PATN(n)	((n) << 7)
 #define MVEBU_COMPHY_FRAME_DETECT3(n)		(0xa20 + (n) * 0x1000)
@@ -374,9 +374,9 @@ static int mvebu_comphy_set_mode_sgmii(struct phy *phy)
 	val |= MVEBU_COMPHY_RX_CTRL1_RXCLK2X_SEL;
 	writel(val, priv->base + MVEBU_COMPHY_RX_CTRL1(lane->id));
 
-	val = readl(priv->base + MVEBU_COMPHY_DLT_CTRL(lane->id));
-	val &= ~MVEBU_COMPHY_DLT_CTRL_DTL_FLOOP_EN;
-	writel(val, priv->base + MVEBU_COMPHY_DLT_CTRL(lane->id));
+	val = readl(priv->base + MVEBU_COMPHY_DTL_CTRL(lane->id));
+	val &= ~MVEBU_COMPHY_DTL_CTRL_DTL_FLOOP_EN;
+	writel(val, priv->base + MVEBU_COMPHY_DTL_CTRL(lane->id));
 
 	regmap_read(priv->regmap, MVEBU_COMPHY_CONF1(lane->id), &val);
 	val &= ~MVEBU_COMPHY_CONF1_USB_PCIE;
@@ -407,9 +407,9 @@ static int mvebu_comphy_set_mode_rxaui(struct phy *phy)
 	       MVEBU_COMPHY_RX_CTRL1_CLK8T_EN;
 	writel(val, priv->base + MVEBU_COMPHY_RX_CTRL1(lane->id));
 
-	val = readl(priv->base + MVEBU_COMPHY_DLT_CTRL(lane->id));
-	val |= MVEBU_COMPHY_DLT_CTRL_DLT_FLOOP_EN;
-	writel(val, priv->base + MVEBU_COMPHY_DLT_CTRL(lane->id));
+	val = readl(priv->base + MVEBU_COMPHY_DTL_CTRL(lane->id));
+	val |= MVEBU_COMPHY_DTL_CTRL_DTL_FLOOP_EN;
+	writel(val, priv->base + MVEBU_COMPHY_DTL_CTRL(lane->id));
 
 	val = readl(priv->base + MVEBU_COMPHY_SERDES_CFG2(lane->id));
 	val |= MVEBU_COMPHY_SERDES_CFG2_DFE_EN;
@@ -460,9 +460,9 @@ static int mvebu_comphy_set_mode_10gkr(struct phy *phy)
 	       MVEBU_COMPHY_RX_CTRL1_CLK8T_EN;
 	writel(val, priv->base + MVEBU_COMPHY_RX_CTRL1(lane->id));
 
-	val = readl(priv->base + MVEBU_COMPHY_DLT_CTRL(lane->id));
-	val |= MVEBU_COMPHY_DLT_CTRL_DTL_FLOOP_EN;
-	writel(val, priv->base + MVEBU_COMPHY_DLT_CTRL(lane->id));
+	val = readl(priv->base + MVEBU_COMPHY_DTL_CTRL(lane->id));
+	val |= MVEBU_COMPHY_DTL_CTRL_DTL_FLOOP_EN;
+	writel(val, priv->base + MVEBU_COMPHY_DTL_CTRL(lane->id));
 
 	/* Speed divider */
 	val = readl(priv->base + MVEBU_COMPHY_SPEED_DIV(lane->id));
-- 
2.21.0

