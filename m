Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D419DC2D0C1
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 01:56:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A85F92467F
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 01:56:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SRLxLEf/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727555AbfLTB4t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 20:56:49 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:46581 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727089AbfLTB4M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 20:56:12 -0500
Received: by mail-lf1-f65.google.com with SMTP id f15so5742196lfl.13;
        Thu, 19 Dec 2019 17:56:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oAqEHmnP0UetEaHRQNpJtTkYietWTb3GcdacfKs3eMs=;
        b=SRLxLEf/j1ddYt9WN4sz8ETMj+8t6F9tl96510wdImo5nCxAvubEPppCfcF5q17PP+
         iNGPiYJgf5VD/FPVIzgDM68jZKzOt6BNNZGIkrLz2m2EjekJGXHnEKuivHyVnevAD1f/
         trgvZ4EenSCnXRFppdLw/TGtxq83g8O4tytuMZZn8Fe4D0lUqh+FnLgKFfonI6w2QZCN
         5pTpsCbtZBAramlMlBt4lim828T2Rfi5DiXDHlDMOdRGkQDOrHTrT08hPL2xcB1h6dvw
         wmeA/OcvoWpUoXjCm+eXkc/Qc8X+3uzO9IE2Soo5nRCUhXPxNZAjqsky+nHTkj1qQO2C
         fs0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oAqEHmnP0UetEaHRQNpJtTkYietWTb3GcdacfKs3eMs=;
        b=tvAlNLBeSO+8FAIz5biUr4WlHFf1ZPnNctTooF0xk1El93NNtwr9G71T1U2vTUf0h4
         MgMWwXPRVcBPcrBZKF5iET8mCJ0/n6UFazIAqtGuNIWehDGA0x/ecj3neY9C/wmrW37i
         L0ik6iSbqRFB8ae6uF2R3WELu6nzTn6REDnoL8VIicvTA4CBqov5smTeqbnC6sjBqhTK
         zEl41fjGuxyAmxZE7kS9DCaJueGKwUFrAsW8Tj5J7bc2MfLJLTKVTeK/orR6FkVBcHdU
         xRPnMsLuP662VNxnKQyhFf0uHAZWaWQqAJmg+z49BK+RK0Qr2xnnAgsMN+tEx1HpIrqG
         ZRYg==
X-Gm-Message-State: APjAAAXLSnQ+RDNQkyblY+y9QLdplOcVu2LNC6Zl7f7yeMTIiAaOgOaV
        AL9Mj9hC86kxjPSmAC9vy4o=
X-Google-Smtp-Source: APXvYqzka0V7UwraSN1B6rno/b+tcvsKc4j7CI1iPaUWK8hWa0YDwSwNcuBHPF92vkdU4F6j6cSgQA==
X-Received: by 2002:ac2:5a43:: with SMTP id r3mr7482768lfn.150.1576806969861;
        Thu, 19 Dec 2019 17:56:09 -0800 (PST)
Received: from localhost.localdomain (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.gmail.com with ESMTPSA id m13sm3270901lfo.40.2019.12.19.17.56.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2019 17:56:09 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Chen <Peter.Chen@nxp.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Felipe Balbi <balbi@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 05/10] usb: phy: tegra: Use generic stub for a missing VBUS regulator
Date:   Fri, 20 Dec 2019 04:52:33 +0300
Message-Id: <20191220015238.9228-6-digetx@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191220015238.9228-1-digetx@gmail.com>
References: <20191220015238.9228-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Regulator core provides dummy regulator if device-tree doesn't define VBUS
regulator.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/usb/phy/phy-tegra-usb.c | 27 +++++++++------------------
 1 file changed, 9 insertions(+), 18 deletions(-)

diff --git a/drivers/usb/phy/phy-tegra-usb.c b/drivers/usb/phy/phy-tegra-usb.c
index 7456479099ce..9ce6699f40e7 100644
--- a/drivers/usb/phy/phy-tegra-usb.c
+++ b/drivers/usb/phy/phy-tegra-usb.c
@@ -798,8 +798,7 @@ static void tegra_usb_phy_shutdown(struct usb_phy *u_phy)
 	else
 		utmip_pad_close(phy);
 
-	if (!IS_ERR(phy->vbus))
-		regulator_disable(phy->vbus);
+	regulator_disable(phy->vbus);
 
 	clk_disable_unprepare(phy->pll_u);
 
@@ -878,14 +877,11 @@ static int tegra_usb_phy_init(struct usb_phy *u_phy)
 		goto fail;
 	}
 
-	if (!IS_ERR(phy->vbus)) {
-		err = regulator_enable(phy->vbus);
-		if (err) {
-			dev_err(phy->u_phy.dev,
-				"Failed to enable USB VBUS regulator: %d\n",
-				err);
-			goto fail;
-		}
+	err = regulator_enable(phy->vbus);
+	if (err) {
+		dev_err(phy->u_phy.dev,
+			"Failed to enable USB VBUS regulator: %d\n", err);
+		goto fail;
 	}
 
 	if (phy->is_ulpi_phy)
@@ -1146,14 +1142,9 @@ static int tegra_usb_phy_probe(struct platform_device *pdev)
 	}
 
 	/* On some boards, the VBUS regulator doesn't need to be controlled */
-	if (of_find_property(np, "vbus-supply", NULL)) {
-		tegra_phy->vbus = devm_regulator_get(&pdev->dev, "vbus");
-		if (IS_ERR(tegra_phy->vbus))
-			return PTR_ERR(tegra_phy->vbus);
-	} else {
-		dev_notice(&pdev->dev, "no vbus regulator");
-		tegra_phy->vbus = ERR_PTR(-ENODEV);
-	}
+	tegra_phy->vbus = devm_regulator_get(&pdev->dev, "vbus");
+	if (IS_ERR(tegra_phy->vbus))
+		return PTR_ERR(tegra_phy->vbus);
 
 	tegra_phy->pll_u = devm_clk_get(&pdev->dev, "pll_u");
 	err = PTR_ERR_OR_ZERO(tegra_phy);
-- 
2.24.0

