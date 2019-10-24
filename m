Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D932CA9EAF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 16:38:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F10621D71
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 16:38:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gPwrn6NP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503527AbfJXQin (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 12:38:43 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44226 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2503503AbfJXQil (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 12:38:41 -0400
Received: by mail-wr1-f68.google.com with SMTP id z11so3461390wro.11
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2019 09:38:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=QdHIheq0u1kbfETofjh9zy8pkEBm58YeSTndJs2NHac=;
        b=gPwrn6NPz7e9qabl6w9R3rqJrhVP14D5VEoM/nG38JSXosj+EzFKlTPlVNYElFho00
         +o+M2rHC0YjYffk6XVRDD8OSdWVwqxIOndJ67G98SIzgVGfeyu2GtRUJFmD/WG6dTihy
         1TN9flRSC9i7K1ODhHNV5mHaS7EfS9ZS7dluqdJNoUNzUatqHVKaSg2272m4QJQv9ZET
         Yat6gdQYo4VoX02nxBEIbJBiFvNigZs/epeRYtuOw5uqzGc5QFRr639xcuDCcKg7YKDZ
         tEBy/uFvDYMKF2GfDzfZ17TxIKWKBh1DcbZBNXHAlzAEar7zo8EHVVFXUKDoS5K4oPzC
         ygHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=QdHIheq0u1kbfETofjh9zy8pkEBm58YeSTndJs2NHac=;
        b=EfxIjxp9x8MmLYf6a/N4p0c4W+4WAYS0mTz0gVF5SAgXCChRgoKPNC+b3aTOoSaFZR
         Ye13m00iemnJ8pBq9Rg0b1HLMUFPxR6kJnLLCU0vHjjvr5MHbtXb3YTyQ3To8LoaHhDX
         m9Tnjr1Qgyi0JUYDbD85QKnFSv9qzSXOme4pZZNnTM5MoAs9nvQQJGrqP+N7Kc83KMsR
         70xSbujgovuUbZgpWAcl2CQmX2dsGS4CSoWs2k+vHbU12lxRJK6srbtZjitlQxLBl5du
         +KTHpRVJN9g7+duIIiAIqrNoRbfeNLU/1b0lGwIye14YmRANf9z+AKrX6yHeeUgZ1DEC
         1XRA==
X-Gm-Message-State: APjAAAWQXjIZDrCZza1WdkhM/2WLDF/wejdlX/DqKQQ+pDkmH50av8Rh
        VFpksmrEJOS/bDDMfxh0u3VeJg==
X-Google-Smtp-Source: APXvYqybGriaBIIX8G9nnstV8F9MgTGty7bBvcB5f3SnrbhVCru8DjpTB8Hxjodr97qZgRKtmB4Igg==
X-Received: by 2002:adf:f04e:: with SMTP id t14mr4491900wro.106.1571935119378;
        Thu, 24 Oct 2019 09:38:39 -0700 (PDT)
Received: from localhost.localdomain ([95.149.164.99])
        by smtp.gmail.com with ESMTPSA id 6sm3446175wmd.36.2019.10.24.09.38.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2019 09:38:38 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     daniel.thompson@linaro.org, arnd@arndb.de, broonie@kernel.org,
        linus.walleij@linaro.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        baohua@kernel.org, stephan@gerhold.net,
        Lee Jones <lee.jones@linaro.org>
Subject: [PATCH v3 03/10] mfd: cs5535-mfd: Request shared IO regions centrally
Date:   Thu, 24 Oct 2019 17:38:25 +0100
Message-Id: <20191024163832.31326-4-lee.jones@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191024163832.31326-1-lee.jones@linaro.org>
References: <20191024163832.31326-1-lee.jones@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Prior to this patch, IO regions were requested via an MFD subsytem-level
.enable() call-back and similarly released by a .disable() call-back.
Double requests/releases were avoided by a centrally handled usage count
mechanism.

This complexity can all be avoided by handling IO regions only once during
.probe() and .remove() of the parent device.  Since this is the only
legitimate user of the aforementioned usage count mechanism, this patch
will allow it to be removed from MFD core in subsequent steps.

Suggested-by: Daniel Thompson <daniel.thompson@linaro.org>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mfd/cs5535-mfd.c | 71 +++++++++++++++++-----------------------
 1 file changed, 30 insertions(+), 41 deletions(-)

diff --git a/drivers/mfd/cs5535-mfd.c b/drivers/mfd/cs5535-mfd.c
index b35f1efa01f6..27fa8fa1ec9b 100644
--- a/drivers/mfd/cs5535-mfd.c
+++ b/drivers/mfd/cs5535-mfd.c
@@ -27,38 +27,6 @@ enum cs5535_mfd_bars {
 	NR_BARS,
 };
 
-static int cs5535_mfd_res_enable(struct platform_device *pdev)
-{
-	struct resource *res;
-
-	res = platform_get_resource(pdev, IORESOURCE_IO, 0);
-	if (!res) {
-		dev_err(&pdev->dev, "can't fetch device resource info\n");
-		return -EIO;
-	}
-
-	if (!request_region(res->start, resource_size(res), DRV_NAME)) {
-		dev_err(&pdev->dev, "can't request region\n");
-		return -EIO;
-	}
-
-	return 0;
-}
-
-static int cs5535_mfd_res_disable(struct platform_device *pdev)
-{
-	struct resource *res;
-
-	res = platform_get_resource(pdev, IORESOURCE_IO, 0);
-	if (!res) {
-		dev_err(&pdev->dev, "can't fetch device resource info\n");
-		return -EIO;
-	}
-
-	release_region(res->start, resource_size(res));
-	return 0;
-}
-
 static struct resource cs5535_mfd_resources[NR_BARS];
 
 static struct mfd_cell cs5535_mfd_cells[] = {
@@ -81,17 +49,11 @@ static struct mfd_cell cs5535_mfd_cells[] = {
 		.name = "cs5535-pms",
 		.num_resources = 1,
 		.resources = &cs5535_mfd_resources[PMS_BAR],
-
-		.enable = cs5535_mfd_res_enable,
-		.disable = cs5535_mfd_res_disable,
 	},
 	{
 		.name = "cs5535-acpi",
 		.num_resources = 1,
 		.resources = &cs5535_mfd_resources[ACPI_BAR],
-
-		.enable = cs5535_mfd_res_enable,
-		.disable = cs5535_mfd_res_disable,
 	},
 };
 
@@ -117,22 +79,47 @@ static int cs5535_mfd_probe(struct pci_dev *pdev,
 		r->end = pci_resource_end(pdev, bar);
 	}
 
+	err = pci_request_region(pdev, PMS_BAR, DRV_NAME);
+	if (err) {
+		dev_err(&pdev->dev, "Failed to request PMS_BAR's IO region\n");
+		goto err_disable;
+	}
+
 	err = mfd_add_devices(&pdev->dev, PLATFORM_DEVID_NONE, cs5535_mfd_cells,
 			      ARRAY_SIZE(cs5535_mfd_cells), NULL, 0, NULL);
 	if (err) {
 		dev_err(&pdev->dev,
 			"Failed to add CS5535 sub-devices: %d\n", err);
-		goto err_disable;
+		goto err_release_pms;
 	}
 
-	if (machine_is_olpc())
-		mfd_clone_cell("cs5535-acpi", olpc_acpi_clones, ARRAY_SIZE(olpc_acpi_clones));
+	if (machine_is_olpc()) {
+		err = pci_request_region(pdev, ACPI_BAR, DRV_NAME);
+		if (err) {
+			dev_err(&pdev->dev,
+				"Failed to request ACPI_BAR's IO region\n");
+			goto err_remove_devices;
+		}
+
+		err = mfd_clone_cell("cs5535-acpi", olpc_acpi_clones,
+				     ARRAY_SIZE(olpc_acpi_clones));
+		if (err) {
+			dev_err(&pdev->dev, "Failed to clone MFD cell\n");
+			goto err_release_acpi;
+		}
+	}
 
 	dev_info(&pdev->dev, "%zu devices registered.\n",
 			ARRAY_SIZE(cs5535_mfd_cells));
 
 	return 0;
 
+err_release_acpi:
+	pci_release_region(pdev, ACPI_BAR);
+err_remove_devices:
+	mfd_remove_devices(&pdev->dev);
+err_release_pms:
+	pci_release_region(pdev, PMS_BAR);
 err_disable:
 	pci_disable_device(pdev);
 	return err;
@@ -141,6 +128,8 @@ static int cs5535_mfd_probe(struct pci_dev *pdev,
 static void cs5535_mfd_remove(struct pci_dev *pdev)
 {
 	mfd_remove_devices(&pdev->dev);
+	pci_release_region(pdev, ACPI_BAR);
+	pci_release_region(pdev, PMS_BAR);
 	pci_disable_device(pdev);
 }
 
-- 
2.17.1

