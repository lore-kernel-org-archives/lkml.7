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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68BBAC43603
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 01:56:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AAA0227BF
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 01:56:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HWfl77F+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727489AbfLTB4T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 20:56:19 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:46586 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727390AbfLTB4O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 20:56:14 -0500
Received: by mail-lf1-f67.google.com with SMTP id f15so5742233lfl.13;
        Thu, 19 Dec 2019 17:56:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gtkA3peZEMiQiasILLoJEvV2SQjJRrgtV9+sf4LMnXM=;
        b=HWfl77F+IvmeKqDiV00NPnWuwRBxIc/099eACUbKtTsD12v1OyPn0jvz91sBae1smV
         NKMCeNpLFNbbm7uGW5hn6x1dSrAF2K6eSnYiVANSXZaVxH0duIVo8menhSc534ShmnUd
         SOguaX/nLjNSYASFsZTGJ5uYbD6cUYCtyLHJq2+Aov3t50o79BUddC5c7T6fWc7noc39
         460oFROd1KUdcSq4yBBTUWa/4TC/aPH1xTy3Z5myCRGCJfiLCSyqDZQMu/Ic+ze4HFDe
         is3vw9yJng9ldtb3v2QqsBDjUIKTE3gRL5o8jXzDk1Slu9k+9E2xX7WI3zINRqQohdbM
         idMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gtkA3peZEMiQiasILLoJEvV2SQjJRrgtV9+sf4LMnXM=;
        b=ob7ycIbZsNPJum12T84PfjcSV+zh0f38Hb1M3TjX/1MQhDZpRVSOSz2MmHH4Vqs10z
         YZGO9bcpqhUmtzK1rMwSYC5EUFZUI7XcqFkTCxINqvqF7lPi2J9wQj04x8MsJwTrnquZ
         kQkxf2uyP+p95URTBPJ43m4aHH05Uw12wVWqmWhAs+jUbjJrGJc9qR2gRhEcyECER62Q
         Tp9wHOVFGb5TcGvK6TO5+mq5Rs1i6+yAybco6f5KINp1aHm4GH/bnbrbglp1lVGwZF8b
         7ybfbmcyzeJzFVbiOD64NpSdlo/7dKJVJVJ3jpbOaloZVLTZ8XfJVLEfBl1/wvU59HVc
         +YFQ==
X-Gm-Message-State: APjAAAXBEyRQbb9wMlVhFkGVrKCHTm/o+Ot2gc9yheZHOv/X1oNwJcRs
        wBsGZTUPEmw+MpyqEXWv2jg=
X-Google-Smtp-Source: APXvYqyAhiBefq45zCzS1L1EYjIt2qdRvy+5FQW4NSANWKJUXfLH5Ujy7VPvTp+eFbuTXxwbzXVRSg==
X-Received: by 2002:ac2:4c31:: with SMTP id u17mr7241219lfq.57.1576806971795;
        Thu, 19 Dec 2019 17:56:11 -0800 (PST)
Received: from localhost.localdomain (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.gmail.com with ESMTPSA id m13sm3270901lfo.40.2019.12.19.17.56.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2019 17:56:11 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Chen <Peter.Chen@nxp.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Felipe Balbi <balbi@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 07/10] usb: phy: tegra: Use devm_otg_ulpi_create()
Date:   Fri, 20 Dec 2019 04:52:35 +0300
Message-Id: <20191220015238.9228-8-digetx@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191220015238.9228-1-digetx@gmail.com>
References: <20191220015238.9228-1-digetx@gmail.com>
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
 drivers/usb/phy/phy-tegra-usb.c | 21 +++++----------------
 1 file changed, 5 insertions(+), 16 deletions(-)

diff --git a/drivers/usb/phy/phy-tegra-usb.c b/drivers/usb/phy/phy-tegra-usb.c
index 9ce6699f40e7..d5739b6e0b6c 100644
--- a/drivers/usb/phy/phy-tegra-usb.c
+++ b/drivers/usb/phy/phy-tegra-usb.c
@@ -1170,7 +1170,9 @@ static int tegra_usb_phy_probe(struct platform_device *pdev)
 			return err;
 		}
 
-		tegra_phy->ulpi = otg_ulpi_create(&ulpi_viewport_access_ops, 0);
+		tegra_phy->ulpi = devm_otg_ulpi_create(&pdev->dev,
+						       &ulpi_viewport_access_ops,
+						       0);
 		if (!tegra_phy->ulpi) {
 			dev_err(&pdev->dev, "Failed to create ULPI OTG\n");
 			err = -ENOMEM;
@@ -1205,18 +1207,10 @@ static int tegra_usb_phy_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, tegra_phy);
 
 	err = usb_add_phy_dev(&tegra_phy->u_phy);
-	if (err < 0)
-		goto free_ulpi;
+	if (err)
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
@@ -1225,11 +1219,6 @@ static int tegra_usb_phy_remove(struct platform_device *pdev)
 
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

