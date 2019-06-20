Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA736C43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 21:10:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F33E2070B
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 21:10:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S0b2a7aE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726987AbfFTVKm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 17:10:42 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:43954 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726716AbfFTVKM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 17:10:12 -0400
Received: by mail-pg1-f194.google.com with SMTP id f25so2202842pgv.10;
        Thu, 20 Jun 2019 14:10:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=G1Ij2gv2TDQKvgmKxxszCgpp7AI+3jM9fqq69fwOpA4=;
        b=S0b2a7aE0WAuieFytAiXyQlQYVr7CGECSzLS6wJFSzGtJ+1HgTIIaRECxzTfKTjNkb
         cErfqueoa45U43t+jz8QO0Zwp/ZwWHSElXz3DG5jBope2nWbrkpDBhA9V5YnPEj/MbyN
         B67GD9QJ35CfNL5Exh83tpWY1m75RLYEzuyFH3wTESQ1cFH2WuascjO24sU7gvKKUC5X
         0sm+/gYt6xFT3mUBqYxXFtiqMEuW6YfUZaLiLbHkf5Awrc2EcrPeowK9YqkPooHME/mE
         oVNqgxxj3NpqdCZ89eLk5V608mQw2kea8NJ9K65x4x3D6Gebm6f9uhgvtou/id7uGQqH
         2aYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=G1Ij2gv2TDQKvgmKxxszCgpp7AI+3jM9fqq69fwOpA4=;
        b=QeWulPQmbgmfywwsgPA9AYqLrmzKW9i8f08hEeS0pbKdFAglAnNODCLdueyH+eDcFu
         clU6pzPBgcmRRjDM/wTHclcJuMD1g8WSuOLxZ+docL/WGwl7zRBD7Z9NyequoTQ2ZoLY
         K8PlV3bcOWi1gMppjP6lm9K8XQgVC00v+eu9/4pg1sEAbj8koXahsdNPGAuubSET7o5T
         JFkfVyaNTotfV3SY+oeS3dIaQDyKYcfG8vSw+kN4vHOEgXYkKTdXjA3nb/2or7I85J3Q
         gAVo9JNoqwpwRaqcPJubjPTclIeRkLJpBdhYPrvQrMYhN/VYyPkj36frQcTzyOcE5kR1
         msyw==
X-Gm-Message-State: APjAAAXl1cM84Mxijtmx9OOud9U4WdqPig1cgedz9PEMzBV/Dp94dfWP
        yZQ8VirK9aRPaObprO8/r0glDgx06rc=
X-Google-Smtp-Source: APXvYqzhfbSmcHI0Ef9C7wLbXuSiZnL4lXcN/K/RVjRqcfrVNFxMmQJbBdZzfxS1WWdDw4WarFSUVw==
X-Received: by 2002:a17:90a:a505:: with SMTP id a5mr1715567pjq.27.1561065011551;
        Thu, 20 Jun 2019 14:10:11 -0700 (PDT)
Received: from stbsrv-and-3.and.broadcom.com ([192.19.231.250])
        by smtp.gmail.com with ESMTPSA id p1sm386805pff.74.2019.06.20.14.10.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Jun 2019 14:10:11 -0700 (PDT)
From:   Al Cooper <alcooperx@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Al Cooper <alcooperx@gmail.com>, devicetree@vger.kernel.org,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: [PATCH 2/6] usb: bdc: Cleanup clock support
Date:   Thu, 20 Jun 2019 17:09:47 -0400
Message-Id: <1561064991-16874-3-git-send-email-alcooperx@gmail.com>
X-Mailer: git-send-email 1.9.0.138.g2de3478
In-Reply-To: <1561064991-16874-1-git-send-email-alcooperx@gmail.com>
References: <1561064991-16874-1-git-send-email-alcooperx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

- Fix driver to defer on clk_get defer

Signed-off-by: Al Cooper <alcooperx@gmail.com>
---
 drivers/usb/gadget/udc/bdc/bdc_core.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/gadget/udc/bdc/bdc_core.c b/drivers/usb/gadget/udc/bdc/bdc_core.c
index ccbd1d34eb2a..11a43de6c1c6 100644
--- a/drivers/usb/gadget/udc/bdc/bdc_core.c
+++ b/drivers/usb/gadget/udc/bdc/bdc_core.c
@@ -490,8 +490,14 @@ static int bdc_probe(struct platform_device *pdev)
 
 	dev_dbg(dev, "%s()\n", __func__);
 
+	bdc = devm_kzalloc(dev, sizeof(*bdc), GFP_KERNEL);
+	if (!bdc)
+		return -ENOMEM;
+
 	clk = devm_clk_get(dev, "sw_usbd");
 	if (IS_ERR(clk)) {
+		if (PTR_ERR(clk) == -EPROBE_DEFER)
+			return -EPROBE_DEFER;
 		dev_info(dev, "Clock not found in Device Tree\n");
 		clk = NULL;
 	}
@@ -501,11 +507,6 @@ static int bdc_probe(struct platform_device *pdev)
 		dev_err(dev, "could not enable clock\n");
 		return ret;
 	}
-
-	bdc = devm_kzalloc(dev, sizeof(*bdc), GFP_KERNEL);
-	if (!bdc)
-		return -ENOMEM;
-
 	bdc->clk = clk;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
@@ -551,7 +552,7 @@ static int bdc_probe(struct platform_device *pdev)
 	ret = bdc_phy_init(bdc);
 	if (ret) {
 		dev_err(bdc->dev, "BDC phy init failure:%d\n", ret);
-		return ret;
+		goto clk_cleanup;
 	}
 
 	temp = bdc_readl(bdc->regs, BDC_BDCCAP1);
@@ -583,6 +584,8 @@ static int bdc_probe(struct platform_device *pdev)
 	bdc_hw_exit(bdc);
 phycleanup:
 	bdc_phy_exit(bdc);
+clk_cleanup:
+	clk_disable_unprepare(bdc->clk);
 	return ret;
 }
 
-- 
1.9.0.138.g2de3478

