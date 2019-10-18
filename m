Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51860CA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 12:56:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2ADA9222C2
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 12:56:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ylikPevI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410158AbfJRM4Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 08:56:25 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:38866 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2408410AbfJRM4R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 08:56:17 -0400
Received: by mail-wm1-f67.google.com with SMTP id 3so6009197wmi.3
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2019 05:56:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=H4mTo2HGqwmy0EIuop2B1GXHxjKBlt/sTDf6EAka3Lg=;
        b=ylikPevI+WeeuVyJHM9diR5Ll0ND42DwvS62otpbOR7NpeVRkv/QxIllgr1dp+sUV4
         YugopkImYD6Wj4mho/7VDBT/WB5E1hGmeKZr+6C6pkRCjmgxpBlZFOkbN1nLCw1cPBKN
         051SK/eiFMelfug6/IP+D7VAHuvPuB93d6m8GPe4hQuWMLxaoGCzMfuNyuqC+WmMZ1Xa
         AMCQpURQHcxKPIDPBwE1rud0PcXzgk2aApAx5Do2GJRNKhaNLb5tjDzaIHglatPa+rQD
         BEdF5iSLd0em235wEA+/oVIphuMvjRnI52cipOAmb/qVkUy8KDxrYqAd5btpAwxJYn7D
         4Ulw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=H4mTo2HGqwmy0EIuop2B1GXHxjKBlt/sTDf6EAka3Lg=;
        b=ro3TwsfJ19ZTrJI8EtHZgfosC4wAZBc0yGgEYeoLzpA8v4NTEKkXyxPEia+rclYTG9
         ulZPSL6NHp7dMwkQbiaoMS/raIaZba7rkZhVnUP5K1o+sVjKUt6dw0zAf4BXvR9GAZba
         aVQv7k9fbkRAOx5wonbYluTEYR5tq7tf3sotQXZTS4XLKq+rYVsyx3TiDNxSl8/wjVCL
         Lf5T8b9+oTD3H6JTuFjGjulpXQCXdLisHH2J24dMMv+fUJu13fdZHYjgC47oE3pz5kMD
         CKysyDZYQ1JIuiOTiFvjBF9qxBHGM+VIkMojDTrbMyZIWiet408gkgk8m+3n2uZH6cby
         mV6Q==
X-Gm-Message-State: APjAAAXv3tkniif/Dk9ugP8pFtpDqW7Ks8cs1fbvktlZgbhZUJlAQ/k4
        JjH2207wfeJ+6ukQsiWAxbJtcA==
X-Google-Smtp-Source: APXvYqwjuqXxWbaJcNR4hvNrAAl8FCGcVA33t80VEPmWfUUZjWl5jkUWYdIodtBWFtS4oAlBC71k/Q==
X-Received: by 2002:a1c:4805:: with SMTP id v5mr7961246wma.130.1571403374485;
        Fri, 18 Oct 2019 05:56:14 -0700 (PDT)
Received: from localhost.localdomain ([95.149.164.47])
        by smtp.gmail.com with ESMTPSA id q14sm6058491wre.27.2019.10.18.05.56.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2019 05:56:14 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     broonie@kernel.org, linus.walleij@linaro.org,
        daniel.thompson@linaro.org, arnd@arndb.de
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        dilinger@queued.net, Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 4/4] mfd: mfd-core: Remove mfd_clone_cell()
Date:   Fri, 18 Oct 2019 13:56:08 +0100
Message-Id: <20191018125608.5362-5-lee.jones@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191018125608.5362-1-lee.jones@linaro.org>
References: <20191018125608.5362-1-lee.jones@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Providing an subsystem-level API helper seems over-kill just to save a
few lines of C-code.  Previous commits saw us convert mfd_clone_cell()'s
only user over to use a more traditional style of MFD child-device
registration.  Now we can remove the superfluous helper from the MFD API.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
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

