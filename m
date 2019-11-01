Return-Path: <SRS0=OzJr=YZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09305CA9EC9
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 07:45:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFFF12080F
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 07:45:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="B6R+1JCS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730194AbfKAHpv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Nov 2019 03:45:51 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39673 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730119AbfKAHpa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 03:45:30 -0400
Received: by mail-wr1-f68.google.com with SMTP id a11so8795387wra.6
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2019 00:45:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=n8Ucez02iItku1JzTTgA4X0TOQF7g37QZ5FK6iQhubQ=;
        b=B6R+1JCSAwgKyR+aoys7iRUcEXhF3L/eli9PKppCN67iGTa5dHpuJBYW8X2vtxWRJe
         V7wTxydHk4Ct8YvnSw2UcLuTwXtjjbLQ666IT3NUpkXd5O1k08xxXtaEZwTcY64P7ngp
         +dpgTwiVaWNesy6RsktWd0EzF2wbkDF/rHJsF9tCQRKmKZi/3eYjzK4erdj7rbfyICJC
         jk6Jvl6IzMdWBLl8ebqJodEwDq8zVW63CGjUcX+SY0YJCfTuHzcxc4gMLkgx1Cf8ZrAa
         mUjSsKuDsvrttJrGmFIvqY8i6iPQPLpTQtCbWumn6yv6GTf5KqGthZt2jhVOdnHk/oRz
         G50Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=n8Ucez02iItku1JzTTgA4X0TOQF7g37QZ5FK6iQhubQ=;
        b=Vh/aVsMfDUHBcnUePb/fyeqpmi+n6AiBKGnnrPsIpyeOBY8Pm29x4vmw26mLGyoGvl
         ZjyiFwl8G4fB5BcJMUJLBMD9ty0QumydwvX/Qpxuy7vBi4e7OU0h91aGa279NoWW2x/E
         ODBbg7LoUJl40/OoI4GonveEbaTSFHMeLFfCcY6Md14n/yqs4kPePiUJ62mWRx6JHmmC
         KNDDnbTa27gYMRHE0kmSeTyuB8GKOQWuC1H+TEL5OXexpbQeFkLvlw6oKAqzwvqIzmLK
         wjIzYn0fsPAlnd5+qGqqZrzmCVSwvYrwFtvWMLsqg8KJun7MFYA7Q3QEHb4WcG280HqI
         a2wQ==
X-Gm-Message-State: APjAAAU06WzBaJsQjvnqRIX+QdzUcuOhVnxAqc9hnI+6Gj155Fb84RDb
        rJlPalPk/M380rcj2/a2bd5Kog==
X-Google-Smtp-Source: APXvYqyKsKbyPv0zQ3Ni6kKILb9D2GUOzJUzrwbEAhG0ONH4/fOkO9nO+pmIrK6g7PN7ao0thJ1obA==
X-Received: by 2002:adf:fe90:: with SMTP id l16mr9255966wrr.81.1572594328646;
        Fri, 01 Nov 2019 00:45:28 -0700 (PDT)
Received: from localhost.localdomain ([2.31.163.64])
        by smtp.gmail.com with ESMTPSA id b1sm576215wrw.77.2019.11.01.00.45.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2019 00:45:28 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     daniel.thompson@linaro.org, broonie@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        arnd@arndb.de, linus.walleij@linaro.org, baohua@kernel.org,
        stephan@gerhold.net, Lee Jones <lee.jones@linaro.org>
Subject: [PATCH v4 06/10] mfd: mfd-core: Remove mfd_clone_cell()
Date:   Fri,  1 Nov 2019 07:45:14 +0000
Message-Id: <20191101074518.26228-7-lee.jones@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191101074518.26228-1-lee.jones@linaro.org>
References: <20191101074518.26228-1-lee.jones@linaro.org>
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
index 96d02b6f06fd..e38e411ca775 100644
--- a/drivers/mfd/mfd-core.c
+++ b/drivers/mfd/mfd-core.c
@@ -392,38 +392,5 @@ int devm_mfd_add_devices(struct device *dev, int id,
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

