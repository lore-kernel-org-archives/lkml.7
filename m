Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B0B0C33C99
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 01:35:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7164E215A4
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 01:35:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WA025jnm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727615AbgAFBfu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Jan 2020 20:35:50 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:38704 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727409AbgAFBev (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jan 2020 20:34:51 -0500
Received: by mail-lj1-f194.google.com with SMTP id w1so27340288ljh.5;
        Sun, 05 Jan 2020 17:34:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ye27YVubMaQCmULnB2LfyXuyZwZTDB68pe4TarEPntk=;
        b=WA025jnmWKPyv4ZKB8OL53qeQ+iQ47UlUTuh3ULmPKN/fkCypkqxR0BubI4FYlH7jz
         IeDUFHA2bx7nWXGLjnnGndq3Jw6ulG3F1326kgBQiwDN4g3kjBB+dZIN+eXs+TUZ9nzk
         s3FYb0BVWgBgM8L5TgYk3UXJCVjsyb2K1U+S3TOseuKFSOw/to59SniF0EHtYnWKNv2L
         qb5FaFbL6OSbA6WRoXUlvHLzQ9d6xY0f7kGFvUu8ysfw7VgUHkFAdf7gm7J6edHaaED6
         b3xIgqoB+wz8JVNpX/fcmoIA58uuHWIVQULiaW0llIUWDldoEEypgY8meQAX4LEgBE62
         n7dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ye27YVubMaQCmULnB2LfyXuyZwZTDB68pe4TarEPntk=;
        b=Ed8pyDypQZaPoLdK5DFI/KLXrW1XM4uGGxeY3sgWI1mMq1Satr1ZrNhwyTeeliWK6w
         FxjwDNeYMs+7YqU56+x22povAzjdXkfZdd4O8k2Ql3BYwa74Kp9H6MuZrl6kzfLfjmmG
         QDRmIbkbL5yyWW+RpWmjl8+Az5Y18nZ5iuBo7PypEqQDLkK5YdrgR7tvusjfmIE9nz4v
         Ew1VSQhglpE9GK0GnixH4vO6nSjaGS2UGtj8vp+9xZS6rE3G3H0PlteJ8qc3cfiSeTA9
         B1RwZ9tEh4uz3LWZlpCwYglgdoHAnDt16GA0khe89OFB+JaoTJpmJplbb2NwWxFjhvW5
         BX4Q==
X-Gm-Message-State: APjAAAVTwWOJNT6SkMgmx4MJz6nMpByp+TBfRf67JN4nD7tm/L+v49WW
        SN8Fj88meWSvtGNjwXwmoo8=
X-Google-Smtp-Source: APXvYqx+v8E82hDHJwYGJQqND5KsevP6qp/z7xGihdr36NAiF8cmBwZ1PCNiLdp9NSKiT36OYQ/fnQ==
X-Received: by 2002:a05:651c:1b0:: with SMTP id c16mr58300491ljn.236.1578274489097;
        Sun, 05 Jan 2020 17:34:49 -0800 (PST)
Received: from localhost.localdomain (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.gmail.com with ESMTPSA id h10sm28235739ljc.39.2020.01.05.17.34.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jan 2020 17:34:48 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Chen <Peter.Chen@nxp.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Felipe Balbi <balbi@kernel.org>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Cc:     linux-usb@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 09/20] usb: phy: tegra: Use generic stub for a missing VBUS regulator
Date:   Mon,  6 Jan 2020 04:34:05 +0300
Message-Id: <20200106013416.9604-10-digetx@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200106013416.9604-1-digetx@gmail.com>
References: <20200106013416.9604-1-digetx@gmail.com>
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
 drivers/usb/phy/phy-tegra-usb.c | 28 +++++++++-------------------
 1 file changed, 9 insertions(+), 19 deletions(-)

diff --git a/drivers/usb/phy/phy-tegra-usb.c b/drivers/usb/phy/phy-tegra-usb.c
index 268b9d9ce57e..5b9f031619c5 100644
--- a/drivers/usb/phy/phy-tegra-usb.c
+++ b/drivers/usb/phy/phy-tegra-usb.c
@@ -836,9 +836,7 @@ static void tegra_usb_phy_shutdown(struct usb_phy *u_phy)
 	if (!phy->is_ulpi_phy)
 		utmip_pad_close(phy);
 
-	if (!IS_ERR(phy->vbus))
-		regulator_disable(phy->vbus);
-
+	regulator_disable(phy->vbus);
 	clk_disable_unprepare(phy->pll_u);
 
 	phy->freq = NULL;
@@ -900,14 +898,11 @@ static int tegra_usb_phy_init(struct usb_phy *u_phy)
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
@@ -1140,14 +1135,9 @@ static int tegra_usb_phy_probe(struct platform_device *pdev)
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
 	err = PTR_ERR_OR_ZERO(tegra_phy->pll_u);
-- 
2.24.0

