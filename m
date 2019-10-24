Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D311CA9EBC
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 16:39:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63E7521D71
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 16:39:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="M7WkmfL0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503667AbfJXQj2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 12:39:28 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:51960 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2503520AbfJXQin (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 12:38:43 -0400
Received: by mail-wm1-f68.google.com with SMTP id q70so3589954wme.1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2019 09:38:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=e4HNR/0VM5m4e7dMrNKrSD8efxMPd+5rZb481ikFf74=;
        b=M7WkmfL0zrA5DnctlcBxlGdxMtMvI7tb2Et+EcJD17XeKNEcanCAnSlnnFtfrQBuM3
         sDhf5LBd626wET1CuSWyl/rNSMkVh7OT3aDCOds4shDrMV1BOqn/YQFAjcw5wHDP541P
         1/KOQc4D2Q7cPOFKXNBlEJmLOHeUPfL218/n4FP/xi+GZncaONIbCHbY3wj8Ui4KD2w1
         efGgPXWk+q/VIFUq9zoDrdj/MKBbzRWvdbAMOHU8q6g3mk2yO4zDLW0HKVtQslGanI6m
         yJaTeQurgB38QyJxOF/EQuEb5uHiE/GtD2I2MEEBn+DHfT1q9WyC8IMLjupNUcM8DF8w
         2oAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=e4HNR/0VM5m4e7dMrNKrSD8efxMPd+5rZb481ikFf74=;
        b=ZuHEpBUcryN4uCaO0e36tgjqH0Aew0Nv65WyUqvUggZgWyxOffiN+Gt2/Y1bOsEMMr
         UuqIHY26h+ytf/F+ncVarq+o+G1DdMlg3C22gKmt1d7mVdFRvIBZujuUeMBdKi9KsQWw
         IBJ8/14Ixy5Obc0B0c6nQhfA4nMEKUU1/b82ODxELFQtb4yML1GWe2BHBfQPniKl5+sM
         IMY2VBRr4WoAVv0FgX2yVKc1Rcs+BY8Nser60qD4+R2zXo7VMjv+gZaVklbAJm8IMBkM
         tZjbCMiDFdn2mgCZZu5tLMQ8JTnOC+8fCLHgVguSJ4QlTtFXWh5SbbmeaRL0pm3w3l+L
         LjiA==
X-Gm-Message-State: APjAAAXACZ68wpe5hBE0UzQI3UWKTBQT09ueeE7/sSOIjUt9KAhtBW0P
        IVls2KxbMo4lqqE6QO3Gohh6PQ==
X-Google-Smtp-Source: APXvYqxEHli1uD77KL/ELWWxWiIIpMJMsjHrKFyV9fTmvffZSzc7lJEAUYH66gJFBm49CiohcZ1L0Q==
X-Received: by 2002:a1c:2884:: with SMTP id o126mr6171815wmo.153.1571935121495;
        Thu, 24 Oct 2019 09:38:41 -0700 (PDT)
Received: from localhost.localdomain ([95.149.164.99])
        by smtp.gmail.com with ESMTPSA id 6sm3446175wmd.36.2019.10.24.09.38.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2019 09:38:40 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     daniel.thompson@linaro.org, arnd@arndb.de, broonie@kernel.org,
        linus.walleij@linaro.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        baohua@kernel.org, stephan@gerhold.net,
        Lee Jones <lee.jones@linaro.org>
Subject: [PATCH v3 05/10] mfd: mfd-core: Remove mfd_clone_cell()
Date:   Thu, 24 Oct 2019 17:38:27 +0100
Message-Id: <20191024163832.31326-6-lee.jones@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191024163832.31326-1-lee.jones@linaro.org>
References: <20191024163832.31326-1-lee.jones@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Providing a subsystem-level API helper seems over-kill just to save a
few lines of C-code.  Previous commits saw us convert mfd_clone_cell()'s
only user over to use a more traditional style of MFD child-device
registration.  Now we can remove the superfluous helper from the MFD API.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>
---
 drivers/mfd/mfd-core.c   | 33 ---------------------------------
 include/linux/mfd/core.h | 18 ------------------
 2 files changed, 51 deletions(-)

diff --git a/drivers/mfd/mfd-core.c b/drivers/mfd/mfd-core.c
index 23276a80e3b4..8126665bb2d8 100644
--- a/drivers/mfd/mfd-core.c
+++ b/drivers/mfd/mfd-core.c
@@ -382,38 +382,5 @@ int devm_mfd_add_devices(struct device *dev, int id,
 }
 EXPORT_SYMBOL(devm_mfd_add_devices);
 
-int mfd_clone_cell(const char *cell, const char **clones, size_t n_clones)
-{
-	struct mfd_cell cell_entry;
-	struct device *dev;
-	struct platform_device *pdev;
-	int i;
-
-	/* fetch the parent cell's device (should already be registered!) */
-	dev = bus_find_device_by_name(&platform_bus_type, NULL, cell);
-	if (!dev) {
-		printk(KERN_ERR "failed to find device for cell %s\n", cell);
-		return -ENODEV;
-	}
-	pdev = to_platform_device(dev);
-	memcpy(&cell_entry, mfd_get_cell(pdev), sizeof(cell_entry));
-
-	WARN_ON(!cell_entry.enable);
-
-	for (i = 0; i < n_clones; i++) {
-		cell_entry.name = clones[i];
-		/* don't give up if a single call fails; just report error */
-		if (mfd_add_device(pdev->dev.parent, -1, &cell_entry,
-				   cell_entry.usage_count, NULL, 0, NULL))
-			dev_err(dev, "failed to create platform device '%s'\n",
-					clones[i]);
-	}
-
-	put_device(dev);
-
-	return 0;
-}
-EXPORT_SYMBOL(mfd_clone_cell);
-
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Ian Molton, Dmitry Baryshkov");
diff --git a/include/linux/mfd/core.h b/include/linux/mfd/core.h
index b43fc5773ad7..bd8c0e089164 100644
--- a/include/linux/mfd/core.h
+++ b/include/linux/mfd/core.h
@@ -86,24 +86,6 @@ struct mfd_cell {
 extern int mfd_cell_enable(struct platform_device *pdev);
 extern int mfd_cell_disable(struct platform_device *pdev);
 
-/*
- * "Clone" multiple platform devices for a single cell. This is to be used
- * for devices that have multiple users of a cell.  For example, if an mfd
- * driver wants the cell "foo" to be used by a GPIO driver, an MTD driver,
- * and a platform driver, the following bit of code would be use after first
- * calling mfd_add_devices():
- *
- * const char *fclones[] = { "foo-gpio", "foo-mtd" };
- * err = mfd_clone_cells("foo", fclones, ARRAY_SIZE(fclones));
- *
- * Each driver (MTD, GPIO, and platform driver) would then register
- * platform_drivers for "foo-mtd", "foo-gpio", and "foo", respectively.
- * The cell's .enable/.disable hooks should be used to deal with hardware
- * resource contention.
- */
-extern int mfd_clone_cell(const char *cell, const char **clones,
-		size_t n_clones);
-
 /*
  * Given a platform device that's been created by mfd_add_devices(), fetch
  * the mfd_cell that created it.
-- 
2.17.1

