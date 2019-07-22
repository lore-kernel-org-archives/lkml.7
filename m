Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A44DC7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 19:00:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2065920693
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 19:00:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gg6zxIa6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728396AbfGVTAG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 15:00:06 -0400
Received: from mail-pf1-f176.google.com ([209.85.210.176]:36554 "EHLO
        mail-pf1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728089AbfGVTAC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 15:00:02 -0400
Received: by mail-pf1-f176.google.com with SMTP id r7so17817394pfl.3;
        Mon, 22 Jul 2019 12:00:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2EEUYjnGaUl9ucppac7Vlvrro4YfGIW1udHJMvAbzNY=;
        b=Gg6zxIa6eGeXZJ5jeI3xk/ohzr7R/9FakiB0Et0JQ7OLf045kqWgM5Z4jCn3z98YDq
         8mv1O2RP/m+mehED//4JTwExwiKGHC1puq7pWHOsd17aIMk08qIUrn5FuZR00W5sv4Xn
         Ijci7yEv4aurL2RO3SpR3nN63uIa0QtYzT5XfFD25v7eCcu44gSjbNtB7ZqZuI2+LNH3
         HX5+JWfhuTx4u/x4R81PVLuFYFTMHa3aHjpPn9SrHXUufn+hDCySZGPXc4Ge8SCuancR
         qQ8Mbo+LbXtqbbh1qRXKlIGkEoi6aF5vxZM4HqofExFcLJ/az6jy2O/YKzV0KhX9oX8P
         1c6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2EEUYjnGaUl9ucppac7Vlvrro4YfGIW1udHJMvAbzNY=;
        b=nr6yw3vbLxy10JABEULgjuNZ1v2vZz8Zh4sR0mvLtVYin4r9cmf7ibNKr/M2hutxKc
         aP4YiTWiVNpZandHdN6TUrYQ5rgrTKWdLd4nDusX6QH0YVs/QR9OeE3H9Jx9TvIjen3U
         Kbf25Sn7wfxyZJGF4plx6jHqRqDjxTjbKYfywHNcPYo24qhTvWVUorkhxC9o74cffoxv
         NgJFlI8SZijWTnTvFpa3LVDqfEJm9vg7rCpbWLIBnB76cpwCHqCgazG4f2vrYRTTJg1j
         YMvGka24CsJNUkFU9E75UZzkx4p4D8q0cs57b1rs98m9yjUubxStPfvpimRvmjvEfP8p
         BG2w==
X-Gm-Message-State: APjAAAVbBuE+ozXzk6Zs14oEziDBzS2BroC3Mj/1wZnHmY110KFKGv1K
        DyvxT/FGYLHcKGDjMtI+BxbKFD0krWQ=
X-Google-Smtp-Source: APXvYqweoCQrdRLyt6Lvlwgf0GH+d0SEoqwkDbqTeK4Vj3mPKooNv35TnANWukNaspcRrOetUJ6eDg==
X-Received: by 2002:a17:90a:c70c:: with SMTP id o12mr52841519pjt.62.1563822001690;
        Mon, 22 Jul 2019 12:00:01 -0700 (PDT)
Received: from localhost.localdomain ([103.51.73.174])
        by smtp.gmail.com with ESMTPSA id h1sm30777675pgv.93.2019.07.22.11.59.58
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 22 Jul 2019 12:00:01 -0700 (PDT)
From:   Anand Moon <linux.amoon@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Anand Moon <linux.amoon@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [RFC/RFT 5/5] phy: exynos5-usbdrd: drop duplicate setting PIPE3 tune signal
Date:   Tue, 23 Jul 2019 00:29:38 +0530
Message-Id: <20190722185938.9043-6-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190722185938.9043-1-linux.amoon@gmail.com>
References: <20190722185938.9043-1-linux.amoon@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop duplicate configuration setting of PIPE tune signal.

Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
 drivers/phy/samsung/phy-exynos5-usbdrd.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/phy/samsung/phy-exynos5-usbdrd.c b/drivers/phy/samsung/phy-exynos5-usbdrd.c
index 4f16c4f82ae5..f6d2f359d88a 100644
--- a/drivers/phy/samsung/phy-exynos5-usbdrd.c
+++ b/drivers/phy/samsung/phy-exynos5-usbdrd.c
@@ -410,12 +410,6 @@ static void exynos5_usbdrd_utmi_init(struct exynos5_usbdrd_phy *phy_drd)
 		PHYPARAM0_COMPDISTUNE(0x6));
 	writel(reg, phy_drd->reg_phy + EXYNOS5_DRD_PHYPARAM0);
 
-	reg = readl(phy_drd->reg_phy + EXYNOS5_DRD_PHYPARAM1);
-	/* Set Tx De-Emphasis level */
-	reg &= ~PHYPARAM1_PCS_TXDEEMPH_MASK;
-	reg |=	PHYPARAM1_PCS_TXDEEMPH;
-	writel(reg, phy_drd->reg_phy + EXYNOS5_DRD_PHYPARAM1);
-
 	/* UTMI Power Control */
 	writel(PHYUTMI_OTGDISABLE, phy_drd->reg_phy + EXYNOS5_DRD_PHYUTMI);
 
-- 
2.22.0

