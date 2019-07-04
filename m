Return-Path: <SRS0=IBEs=VB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6C34C0650E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 08:47:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F11C218A0
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 08:47:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562230030;
	bh=zxScwFkLjiixqdeZRh7a5dXv8jDdQ8T3PHXavOyUF88=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=QEH7svUuCMB3sDEjP/X8EOUSVnZaC6YVlw86XHDAY23VEfKpCWPVcqgp8wVk/aJms
	 17NVuOqO9YAA9KoSkKt5uQncfR9tJYPOXPQXbg02YVChs/REoNxPDlo5+tqIkyJsUq
	 0yQ1/eujth6BU9BIPXHhZcYmAgLNqpU2+56BmNqc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727430AbfGDIrJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 04:47:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:54392 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727395AbfGDIrF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 04:47:05 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 090A3218BC;
        Thu,  4 Jul 2019 08:47:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562230024;
        bh=zxScwFkLjiixqdeZRh7a5dXv8jDdQ8T3PHXavOyUF88=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Dv6zzAeEQOLrSruoBnVNVkmd1VvWZ2P/o3R8uv4G3LheVuxIeaLnayVa+Wg0bHN40
         Vzq//RNvbEZmNAWyoAv35LneKIUggwAXGlWL5w34unYMha2SjdH34WS2Vg6+MY6SYz
         NJzaOTuLMWTPi+zxqcoS2IylbU2vM4unYytSg4X0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tony Prisk <linux@prisktech.co.nz>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-arm-kernel@lists.infradead.org,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Subject: [PATCH 08/11] video: fbdev: w100fb: convert platform driver to use dev_groups
Date:   Thu,  4 Jul 2019 10:46:14 +0200
Message-Id: <20190704084617.3602-9-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190704084617.3602-1-gregkh@linuxfoundation.org>
References: <20190704084617.3602-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Platform drivers now have the option to have the platform core create
and remove any needed sysfs attribute files.  So take advantage of that
and do not register "by hand" a bunch of sysfs files.

Cc: Tony Prisk <linux@prisktech.co.nz>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: dri-devel@lists.freedesktop.org
Cc: linux-fbdev@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/video/fbdev/w100fb.c | 23 ++++++++++-------------
 1 file changed, 10 insertions(+), 13 deletions(-)

diff --git a/drivers/video/fbdev/w100fb.c b/drivers/video/fbdev/w100fb.c
index 696106ecdff0..4be3afcc1c93 100644
--- a/drivers/video/fbdev/w100fb.c
+++ b/drivers/video/fbdev/w100fb.c
@@ -168,6 +168,15 @@ static ssize_t fastpllclk_store(struct device *dev, struct device_attribute *att
 
 static DEVICE_ATTR_RW(fastpllclk);
 
+static struct attribute *w100fb_attrs[] = {
+	&dev_attr_fastpllclk.attr,
+	&dev_attr_reg_read.attr,
+	&dev_attr_reg_write.attr,
+	&dev_attr_flip.attr,
+	NULL,
+};
+ATTRIBUTE_GROUPS(w100fb);
+
 /*
  * Some touchscreens need hsync information from the video driver to
  * function correctly. We export it here.
@@ -756,14 +765,6 @@ int w100fb_probe(struct platform_device *pdev)
 		goto out;
 	}
 
-	err = device_create_file(&pdev->dev, &dev_attr_fastpllclk);
-	err |= device_create_file(&pdev->dev, &dev_attr_reg_read);
-	err |= device_create_file(&pdev->dev, &dev_attr_reg_write);
-	err |= device_create_file(&pdev->dev, &dev_attr_flip);
-
-	if (err != 0)
-		fb_warn(info, "failed to register attributes (%d)\n", err);
-
 	fb_info(info, "%s frame buffer device\n", info->fix.id);
 	return 0;
 out:
@@ -788,11 +789,6 @@ static int w100fb_remove(struct platform_device *pdev)
 	struct fb_info *info = platform_get_drvdata(pdev);
 	struct w100fb_par *par=info->par;
 
-	device_remove_file(&pdev->dev, &dev_attr_fastpllclk);
-	device_remove_file(&pdev->dev, &dev_attr_reg_read);
-	device_remove_file(&pdev->dev, &dev_attr_reg_write);
-	device_remove_file(&pdev->dev, &dev_attr_flip);
-
 	unregister_framebuffer(info);
 
 	vfree(par->saved_intmem);
@@ -1630,6 +1626,7 @@ static struct platform_driver w100fb_driver = {
 	.driver		= {
 		.name	= "w100fb",
 	},
+	.dev_groups	= w100fb_groups,
 };
 
 module_platform_driver(w100fb_driver);
-- 
2.22.0

