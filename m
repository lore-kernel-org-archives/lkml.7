Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBFE9CA9EAF
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 10:58:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E540222D1
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 10:58:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="p6Ft5Tcx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728425AbfJUK6y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 06:58:54 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45239 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728213AbfJUK6c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 06:58:32 -0400
Received: by mail-wr1-f65.google.com with SMTP id q13so8439395wrs.12
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2019 03:58:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=AcYtOZZC3SDgF/F2fzm0VNHT2ydT5TrPWwuuSdTpFkI=;
        b=p6Ft5TcxLv+E+Nqn4V5r3Z58b7aTm2FHSTanPxT+z0HEeTqd5XVYhGwVw9rXy2e2Pv
         ShO6+JNNqzwtdzkUSZiwdqdw35pIai0tvvC89yyO7e0z33vfpn27aB5zrgvTbiJOiRnY
         uzXXeUp/RXxKV5IqixhMIyoZxdNHMxd9kQ77EHBg4FyapVI6c1s0E+zXjEUmpxjwgz8L
         Goj349p6YjkM2EEa0vcVX9qZs2QI3b1HtnDHAfVXhiZBjkqr1sOeH3B+NC6PYqymug+G
         aoB1UFpaD/iWX2tPqvGUEG/QH8U+ZFubBV6eZv5XR8d7mnmFru2cJfx2bXkEMkAbnJL7
         exCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=AcYtOZZC3SDgF/F2fzm0VNHT2ydT5TrPWwuuSdTpFkI=;
        b=dWkpk3TABbg/dXks2J/oBodeSnes2iH18e531GRWZ6IVGY1l7VYkdk1cnM0mKWxfFG
         X/OsUBIsI7DhN+g0qQrEsEMK4rwpeD0b5KsiS3a0V6422GK9qpQWNJP2NexWzoWSOp7z
         c3fzRjqqqWJWMGm0yaUV+sAnbW1SM5a59HCfDAM6pz1u8hEkQE/KSx34nezxCxuPaGlp
         SAPxrK00QjeikgvLJLzZdgddexEkLcaBDuPdtKVIDHsKy8rOe7czI/7dX9euCwmNmuwX
         Te+G3xe2tN7mAK/M0ruy2Dl3JyGAv8c1pboA8jfIyQZp28/q+YMrPCrQvaZVV4QU/BQO
         OnTw==
X-Gm-Message-State: APjAAAXEwgXCTK1iPl6f8TrDoLLsYyk14Y8xan8PLXMEm9UBVd+xSRpj
        fvDO8fn8CZDu9s94XHWxiVv78g==
X-Google-Smtp-Source: APXvYqwKV/AXCQB95tq4t5oleALTQ+3vAn+xOudSOk3HFRWKBU99hqCcMG+NFe8mA6BczXlus5RICQ==
X-Received: by 2002:a5d:5101:: with SMTP id s1mr3913120wrt.339.1571655510311;
        Mon, 21 Oct 2019 03:58:30 -0700 (PDT)
Received: from localhost.localdomain ([95.149.164.99])
        by smtp.gmail.com with ESMTPSA id q22sm12544289wmj.31.2019.10.21.03.58.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2019 03:58:29 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     daniel.thompson@linaro.org, arnd@arndb.de, broonie@kernel.org,
        linus.walleij@linaro.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        baohua@kernel.org, stephan@gerhold.net,
        Lee Jones <lee.jones@linaro.org>
Subject: [PATCH v2 5/9] mfd: mfd-core: Remove mfd_clone_cell()
Date:   Mon, 21 Oct 2019 11:58:18 +0100
Message-Id: <20191021105822.20271-6-lee.jones@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191021105822.20271-1-lee.jones@linaro.org>
References: <20191021105822.20271-1-lee.jones@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Providing a subsystem-level API helper seems over-kill just to save a
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

