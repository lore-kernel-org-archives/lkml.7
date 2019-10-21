Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1C80CA9EAF
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 10:58:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 667F82173B
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 10:58:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FFP1C61B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728314AbfJUK6c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 06:58:32 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:38022 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727058AbfJUK6a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 06:58:30 -0400
Received: by mail-wr1-f67.google.com with SMTP id v9so2160948wrq.5
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2019 03:58:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=45AT36kNkG6TuZTs0Da4Zkgj9k+BoulBorMLvGdJTSQ=;
        b=FFP1C61B/LvUJEmQ2mYw/K2hW8FBRzhLSkQ9m4i27lqiPrqi/dCTKUbwP/XUTjLdNO
         7q1nDyGJp4p3+IJgrl9OJ/C9HrbG5yFg5V6+hu8LVzjyWNxQhH3sa1zXaBa+cWjIj+sV
         CRoqgJ3JWtWrKBIHWK+WlEZDrlOHLkmyepoWU+YaTtoSmw9FmgsARPv8h+/iuaBJ79Bk
         kmAdJRqiSPJwczawk0wtx0PSK6k83mj0MiC1FfKB3ZYgGTRMrEXa9+iGeCQJtT48m7uv
         1yg75JMBbBoIwGBtIUwPus87jWSfu+OfzaeVCLEPZ0dM4ZBS2/0CqAOMHILGica8DXUU
         dbag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=45AT36kNkG6TuZTs0Da4Zkgj9k+BoulBorMLvGdJTSQ=;
        b=fmEqtOekAnaW0lLUbJlVDG7njw8wvyVCziFgd+dfTxzGwtBgqx2jva/TyE7C8oeXNJ
         h8j5eG0g4AWj5yevyuFadshIbYQ3m0LMAS3PsDJhtLiqhHS9OwtdarpL1k6zG52fC9kN
         yD+2WUyt/HRY6prhDXNobTW2FtSBfQEQR2gF5YVjX1kBw9u1LfUxNhebbtaFWdYroTIM
         ptoaWjctwXZoluRw8G0xmRUxBNP8fM1pOJ6cuOnjakyrY02I8WBMQDArzBT6YjgIhSKF
         cI2feoBKWUDh8Vu04Z8ANsCaPt062sNnlBeQ2MA7JhLW1BFeOSDGAHjF26jWuCjkA3wU
         tzuQ==
X-Gm-Message-State: APjAAAVdxPZV81Q8F9YXbyGgPVVrlGazC4mhgGZu3bVV4iV9DpUdYs6s
        i1jcVuiaku10mjijQOhVsvar0A==
X-Google-Smtp-Source: APXvYqwCfB1GEi1vIrmvERSut1ef1m6svBhU9PBaX+IYPMcyfDknKO0cVM9VqPhgbyJpf+0H6MCsrQ==
X-Received: by 2002:adf:e28f:: with SMTP id v15mr18585655wri.130.1571655508272;
        Mon, 21 Oct 2019 03:58:28 -0700 (PDT)
Received: from localhost.localdomain ([95.149.164.99])
        by smtp.gmail.com with ESMTPSA id q22sm12544289wmj.31.2019.10.21.03.58.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2019 03:58:27 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     daniel.thompson@linaro.org, arnd@arndb.de, broonie@kernel.org,
        linus.walleij@linaro.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        baohua@kernel.org, stephan@gerhold.net,
        Lee Jones <lee.jones@linaro.org>
Subject: [PATCH v2 3/9] mfd: cs5535-mfd: Request shared IO regions centrally
Date:   Mon, 21 Oct 2019 11:58:16 +0100
Message-Id: <20191021105822.20271-4-lee.jones@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191021105822.20271-1-lee.jones@linaro.org>
References: <20191021105822.20271-1-lee.jones@linaro.org>
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
 drivers/mfd/cs5535-mfd.c | 72 +++++++++++++++++-----------------------
 1 file changed, 30 insertions(+), 42 deletions(-)

diff --git a/drivers/mfd/cs5535-mfd.c b/drivers/mfd/cs5535-mfd.c
index 9ce6bbcdbda1..053e33447808 100644
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
 	[ACPI_BAR] = {
 		.name = "cs5535-acpi",
 		.num_resources = 1,
 		.resources = &cs5535_mfd_resources[ACPI_BAR],
-
-		.enable = cs5535_mfd_res_enable,
-		.disable = cs5535_mfd_res_disable,
 	},
 };
 
@@ -109,7 +71,6 @@ static int cs5535_mfd_probe(struct pci_dev *pdev,
 	if (err)
 		return err;
 
-	/* fill in IO range for each cell; subdrivers handle the region */
 	for (i = 0; i < NR_BARS; i++) {
 		struct mfd_cell *cell = &cs5535_mfd_cells[i];
 		struct resource *r = &cs5535_mfd_resources[i];
@@ -122,22 +83,47 @@ static int cs5535_mfd_probe(struct pci_dev *pdev,
 		r->end = pci_resource_end(pdev, i);
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
 			"Failed to add CS5532 sub-devices: %d\n", err);
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
@@ -145,6 +131,8 @@ static int cs5535_mfd_probe(struct pci_dev *pdev,
 
 static void cs5535_mfd_remove(struct pci_dev *pdev)
 {
+	pci_release_region(pdev, PMS_BAR);
+	pci_release_region(pdev, ACPI_BAR);
 	mfd_remove_devices(&pdev->dev);
 	pci_disable_device(pdev);
 }
-- 
2.17.1

