Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44A12C2D0C6
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 21:44:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17D2B205C9
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 21:44:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j6gWVo88"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727120AbfLIVoV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 16:44:21 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37431 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727004AbfLIVoO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 16:44:14 -0500
Received: by mail-wr1-f65.google.com with SMTP id w15so17911849wru.4;
        Mon, 09 Dec 2019 13:44:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=RT3uMjCTNXctwL3ki3eO315EjLjo+qSfc5PPzuNqLtA=;
        b=j6gWVo88AgDxvn8Yg1lfCN5H7CC1Ea+lVXlph5sRy19Lt4qYZl6aawRuIylGJJPYJf
         GPwfGrshGktY58zsulGkoiQIxbcJocv3r2qimlFTGT4h1ZCevNkmownscbhDEJtfiz3M
         aJA3rAZu35QT5flOX3Vj6X0RNi9+fQjfr8rZK+Iy+HvDZWfWOgCMSRh5sLfFmnncUN3M
         dADuTVjvJRbYa/BHWLikRJaDRTvt4XKCHu/R8ZvdQGN63qWfnaSKf5PUhONSLx3s+qIw
         hv8HI0o5hNB5squ5hEYcALwvMI7kkfDCMa97gH6Enc+pgMV2WtCFnya5iroVHPt4fJZa
         RFSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=RT3uMjCTNXctwL3ki3eO315EjLjo+qSfc5PPzuNqLtA=;
        b=qW6thpT3U5ufZXothhU2Ul0cFtXRle5wJl/bqCQbRSjGmnhJVUFw+8Jhcd2Dg47ko1
         xlcsO4BkJEDGhhBpOIS3Xl0CJnFX6A3aSDUH8Wzp1T4lMNdkn1D5SjA0z1M1M6Wap5Zj
         iUWf538zyavjbYr8SMfS+xYWTAw/sQesxuYq+n/jiZnoJ1ugZkgxDDk6MDh6ZSNyT/KC
         ddwadg7BNGDiF0BcGHV15MsnpnflYf81HmmgqQMTXVgafuQU8BsO6/GrV3HPWzu941xa
         78sNCNMG3QnTfZpplfWzM6fFVCyMSjNHgXqd8OGb4GxEbDLZmzETQALO9UO64pA6yv3+
         vTEw==
X-Gm-Message-State: APjAAAXiDl2V/WHCAeeeUzj5sik1bUC06U3N8G4Mme7ITkg+T9DheLEy
        F122+jve3qtSU0JU9JIxH8cqQjy+zdU=
X-Google-Smtp-Source: APXvYqzHKNJxhsgEgBmDpf6YDlxQL4fag49V+/Mo6/Q7hSiO06N+Z+cQhgXoLCPxrONDXyr3WVpr7w==
X-Received: by 2002:a5d:4984:: with SMTP id r4mr4154420wrq.137.1575927851869;
        Mon, 09 Dec 2019 13:44:11 -0800 (PST)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.231.250])
        by smtp.gmail.com with ESMTPSA id z6sm757714wmz.12.2019.12.09.13.44.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2019 13:44:11 -0800 (PST)
From:   Al Cooper <alcooperx@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Al Cooper <alcooperx@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com, devicetree@vger.kernel.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-arm-kernel@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Srinath Mannam <srinath.mannam@broadcom.com>
Subject: [PATCH v2 resend 09/13] phy: usb: fix driver to defer on clk_get defer
Date:   Mon,  9 Dec 2019 16:42:45 -0500
Message-Id: <20191209214249.41137-10-alcooperx@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191209214249.41137-1-alcooperx@gmail.com>
References: <20191209214249.41137-1-alcooperx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Handle defer on clk_get because the new SCMI clock driver comes
up after this driver.

Signed-off-by: Al Cooper <alcooperx@gmail.com>
---
 drivers/phy/broadcom/phy-brcm-usb.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/phy/broadcom/phy-brcm-usb.c b/drivers/phy/broadcom/phy-brcm-usb.c
index 5f7bfa09494d..c82d7ec15334 100644
--- a/drivers/phy/broadcom/phy-brcm-usb.c
+++ b/drivers/phy/broadcom/phy-brcm-usb.c
@@ -341,6 +341,8 @@ static int brcm_usb_phy_dvr_init(struct platform_device *pdev,
 
 	priv->usb_20_clk = of_clk_get_by_name(dn, "sw_usb");
 	if (IS_ERR(priv->usb_20_clk)) {
+		if (PTR_ERR(priv->usb_20_clk) == -EPROBE_DEFER)
+			return -EPROBE_DEFER;
 		dev_info(dev, "Clock not found in Device Tree\n");
 		priv->usb_20_clk = NULL;
 	}
@@ -371,6 +373,8 @@ static int brcm_usb_phy_dvr_init(struct platform_device *pdev,
 
 		priv->usb_30_clk = of_clk_get_by_name(dn, "sw_usb3");
 		if (IS_ERR(priv->usb_30_clk)) {
+			if (PTR_ERR(priv->usb_30_clk) == -EPROBE_DEFER)
+				return -EPROBE_DEFER;
 			dev_info(dev,
 				 "USB3.0 clock not found in Device Tree\n");
 			priv->usb_30_clk = NULL;
@@ -382,6 +386,8 @@ static int brcm_usb_phy_dvr_init(struct platform_device *pdev,
 
 	priv->suspend_clk = clk_get(dev, "usb0_freerun");
 	if (IS_ERR(priv->suspend_clk)) {
+		if (PTR_ERR(priv->suspend_clk) == -EPROBE_DEFER)
+			return -EPROBE_DEFER;
 		dev_err(dev, "Suspend Clock not found in Device Tree\n");
 		priv->suspend_clk = NULL;
 	}
-- 
2.17.1

