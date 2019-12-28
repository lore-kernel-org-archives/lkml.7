Return-Path: <SRS0=tgXE=2S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 199F6C2D0C8
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Dec 2019 20:36:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5F22218AC
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Dec 2019 20:36:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LdCLnFGu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727004AbfL1UgJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Dec 2019 15:36:09 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:33857 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726896AbfL1UgI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Dec 2019 15:36:08 -0500
Received: by mail-lj1-f195.google.com with SMTP id z22so25059039ljg.1;
        Sat, 28 Dec 2019 12:36:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lqAUmy5BKsU2hWI4xTMeQKOQWq5FWjGsTaeyKb6AlCo=;
        b=LdCLnFGu6hlu/s9j10rkIB+ghnry+wcVpZD8Xzw4/NE6Ilf23LZt0x4Vstc3cRoHzx
         v3zSYgiAn4DqCVkcw0Ml32ZKnbZd0aXAZNDByvYCYBYJIu54eEI3woFeUNq1HBHAAg/G
         7zsio1hZr1/sbXbmU1pY4mgzZo5NiI3Pe0LmI0RtW2FfiDEqwgPWn/BSkiGYu15sOMUi
         PufAHTHcJYn29Otu/Lyu9UgX5OqcN37SAsTNvH4VmVEgdMFEXbYxtBQ4QK5xrJiwRGuL
         HqAPubuDm4Kz958M8KSVlnEB0ObBHqKtxyLFFPBcrOVunkEk6unVUfABnEa8ipcFDlsR
         wJRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lqAUmy5BKsU2hWI4xTMeQKOQWq5FWjGsTaeyKb6AlCo=;
        b=CCT+zJV5LHwN18DCzCpSiTF+gtOyIn1CX9O2t8yto/Z0nzFYKT3/WgswYsPi+gPcZr
         l8IyRv5c41Jm1EdMsQ1bI5dG5hxdqI+HJ2Fij4U20SXnGoQEt1IuPhvrPqDnAlGYKRvk
         vFP7/sKmoseSHNpoGE3iFqqDDcUCipJkCmJsjNQJU+0or6J7GcqSQ4Pk32LSy4GV7hnH
         qOioLy286u62PiLhx2vbGvWjQqgE7gp799coXGef+29UTVj71j5JpuA9WH9YYk7Y3oZw
         wn4YHJ+DRHY5SqP9eWNlud9YVvDjD2f77fwxqeCxDii1Zi3wyOTC4351CJXx1YMGZWf4
         q0Hw==
X-Gm-Message-State: APjAAAUv2krjBu/+fVvO3iCBOswgGiCxY4tBHrZPdrxYSzpaoUnCwaMz
        zrWqo/oEEoSttD3WZRcUz2M=
X-Google-Smtp-Source: APXvYqyFnBHRquRWsd5QX2sC028DK/0v6h9t94ZaEtg6zHFpanMtsgPSX3+eMUsX9coEc2COp3jkhQ==
X-Received: by 2002:a05:651c:111a:: with SMTP id d26mr28891709ljo.153.1577565365566;
        Sat, 28 Dec 2019 12:36:05 -0800 (PST)
Received: from localhost.localdomain (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.gmail.com with ESMTPSA id d9sm15162614lja.73.2019.12.28.12.36.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Dec 2019 12:36:05 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Chen <Peter.Chen@nxp.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Felipe Balbi <balbi@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 07/16] usb: phy: tegra: Use devm_otg_ulpi_create()
Date:   Sat, 28 Dec 2019 23:33:49 +0300
Message-Id: <20191228203358.23490-8-digetx@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191228203358.23490-1-digetx@gmail.com>
References: <20191228203358.23490-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The resource-managed variant removes the necessity for the driver to care
about freeing ULPI resources.

Suggested-by: Thierry Reding <thierry.reding@gmail.com>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/usb/phy/phy-tegra-usb.c | 22 ++++++----------------
 1 file changed, 6 insertions(+), 16 deletions(-)

diff --git a/drivers/usb/phy/phy-tegra-usb.c b/drivers/usb/phy/phy-tegra-usb.c
index 0a07efc9de06..a3d102f6f81e 100644
--- a/drivers/usb/phy/phy-tegra-usb.c
+++ b/drivers/usb/phy/phy-tegra-usb.c
@@ -1080,6 +1080,7 @@ static int tegra_usb_phy_probe(struct platform_device *pdev)
 	enum usb_phy_interface phy_type;
 	struct reset_control *reset;
 	struct resource *res;
+	struct usb_phy *phy;
 	int err;
 
 	tegra_phy = devm_kzalloc(&pdev->dev, sizeof(*tegra_phy), GFP_KERNEL);
@@ -1180,12 +1181,14 @@ static int tegra_usb_phy_probe(struct platform_device *pdev)
 			return err;
 		}
 
-		tegra_phy->ulpi = otg_ulpi_create(&ulpi_viewport_access_ops, 0);
-		if (!tegra_phy->ulpi) {
+		phy = devm_otg_ulpi_create(&pdev->dev,
+					   &ulpi_viewport_access_ops, 0);
+		if (!phy) {
 			dev_err(&pdev->dev, "Failed to create ULPI OTG\n");
 			return -ENOMEM;
 		}
 
+		tegra_phy->ulpi = phy;
 		tegra_phy->ulpi->io_priv = tegra_phy->regs + ULPI_VIEWPORT;
 		break;
 
@@ -1204,17 +1207,9 @@ static int tegra_usb_phy_probe(struct platform_device *pdev)
 
 	err = usb_add_phy_dev(&tegra_phy->u_phy);
 	if (err)
-		goto free_ulpi;
+		return err;
 
 	return 0;
-
-free_ulpi:
-	if (tegra_phy->ulpi) {
-		kfree(tegra_phy->ulpi->otg);
-		kfree(tegra_phy->ulpi);
-	}
-
-	return err;
 }
 
 static int tegra_usb_phy_remove(struct platform_device *pdev)
@@ -1223,11 +1218,6 @@ static int tegra_usb_phy_remove(struct platform_device *pdev)
 
 	usb_remove_phy(&tegra_phy->u_phy);
 
-	if (tegra_phy->ulpi) {
-		kfree(tegra_phy->ulpi->otg);
-		kfree(tegra_phy->ulpi);
-	}
-
 	return 0;
 }
 
-- 
2.24.0

