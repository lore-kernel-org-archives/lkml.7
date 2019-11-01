Return-Path: <SRS0=OzJr=YZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8D8FCA9EC9
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 07:45:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC27221835
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 07:45:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="At9PfBtn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730112AbfKAHp1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Nov 2019 03:45:27 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:51194 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726921AbfKAHp0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 03:45:26 -0400
Received: by mail-wm1-f68.google.com with SMTP id 11so8467355wmk.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2019 00:45:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=YwP+Ou3x0Xq501y6yZMGhDxJBzedJFnXI45wlydnDjg=;
        b=At9PfBtnr200Qg5yCgwaj6cV7dJ1Xi6kY3lokTY5Um/mHszQ9tQ+oE0Fjdi27WE2t9
         rhbGMrbX/WTBMw5kFNO9WoiX86d+KsjMX31m+b3OI4FhvnOqTDs1pzpNL8aH6R0lHkxW
         rIBOf0w6MlhnutR0f9HYYnStgyMhE5bsGFxKe5/b/SI+/PH5FXzb8DrcKt6+JlOYYBiA
         w7dk4wFw2cJGqmwTAuFVYf2F+WoOKbafPV8vZDGik639QE64nAb/ABYNof59zIsL8KNy
         +jmYlSanPX1wsWSZv1VeBm3REATgSbK1eJkuULXZAHIXHgTR5YEAHrOJjGoZm07HAkXw
         aWeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=YwP+Ou3x0Xq501y6yZMGhDxJBzedJFnXI45wlydnDjg=;
        b=tL2y0reGmqhIEJSHPTqT0zHjJopoU37NyCt9Xhi+sA63wIBZjvGJCDsGFn+haBukKi
         9cUDpuXPAzbg9wfWd33C3Z33rIDBX4IWcKNFIMUDgeXF/XkP+hYftWR8GOPW9MfL5Iup
         gTYF7NONIQYm1hwnyqR7bicmLTPrV50TPg5nbsQicvK4tsYK0It/L4Jh7Ni7/9Wjklrr
         tvDJb4WxjW6YVSS4rkFvZe71jzpnifGH2dcvHA4sTYkTPnbVjEig0YSYjTKZDhS3FtIX
         I6YbjCjkvGRIvdzjNZWqikE46VgdwwILCWZSos4E+nFCH+9HYXAFR+ltgZ6QUDE845fV
         Kr5w==
X-Gm-Message-State: APjAAAUuQiuIRnTxqGnvVW1u8oRh6ma5ElyWuYE0g5SRWBpOXGIwnEcz
        TRG4ftciuiZZ2/qzZqzoJ7A06A==
X-Google-Smtp-Source: APXvYqwzG7xFGETqQwWZl8YIeOq/BmnWWaWF/NJEgC1YTqaXF15LUaWJSOUGpw0PnQpFretUd/rZGw==
X-Received: by 2002:a7b:cb43:: with SMTP id v3mr8689669wmj.137.1572594324646;
        Fri, 01 Nov 2019 00:45:24 -0700 (PDT)
Received: from localhost.localdomain ([2.31.163.64])
        by smtp.gmail.com with ESMTPSA id b1sm576215wrw.77.2019.11.01.00.45.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2019 00:45:24 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     daniel.thompson@linaro.org, broonie@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        arnd@arndb.de, linus.walleij@linaro.org, baohua@kernel.org,
        stephan@gerhold.net, Lee Jones <lee.jones@linaro.org>
Subject: [PATCH v4 03/10] mfd: cs5535-mfd: Request shared IO regions centrally
Date:   Fri,  1 Nov 2019 07:45:11 +0000
Message-Id: <20191101074518.26228-4-lee.jones@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191101074518.26228-1-lee.jones@linaro.org>
References: <20191101074518.26228-1-lee.jones@linaro.org>
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
 drivers/mfd/cs5535-mfd.c | 74 ++++++++++++++++++----------------------
 1 file changed, 33 insertions(+), 41 deletions(-)

diff --git a/drivers/mfd/cs5535-mfd.c b/drivers/mfd/cs5535-mfd.c
index b35f1efa01f6..3b569b231510 100644
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
@@ -141,6 +128,11 @@ static int cs5535_mfd_probe(struct pci_dev *pdev,
 static void cs5535_mfd_remove(struct pci_dev *pdev)
 {
 	mfd_remove_devices(&pdev->dev);
+
+	if (machine_is_olpc())
+		pci_release_region(pdev, ACPI_BAR);
+
+	pci_release_region(pdev, PMS_BAR);
 	pci_disable_device(pdev);
 }
 
-- 
2.17.1

