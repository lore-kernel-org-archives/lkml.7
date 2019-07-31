Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22404C32751
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 12:44:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EACE7208E3
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 12:44:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564577076;
	bh=WkqAHanTxQx5yUJI8jkG4KR2Oxhqk5ywNQpUPn5vZ0w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=aLGzbaKjgmppr0MxXNVmeFfPGjKGgGeAQCkQZ9BpZ8Ex8n0y67l9mgbqDlkO8exSA
	 +KiFwgdK+yjr58qSxS1nhA8Gd50tPvsFmFjZmC0O0Dsv8hdydZkShkb1cV2zr1RsLz
	 ajpWtoxjQxquJ303SfNBrJ0sm2cSaGSIrZZ5QXVI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388082AbfGaMoe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 08:44:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:36926 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729012AbfGaMo0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 08:44:26 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5EAFE217D4;
        Wed, 31 Jul 2019 12:44:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564577065;
        bh=WkqAHanTxQx5yUJI8jkG4KR2Oxhqk5ywNQpUPn5vZ0w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IeGNaHqO7mU7FVNZgLJgpD1nSBX+og+oFJK8Lv70p6INJwOHscvf3U50pBreu3WaC
         gadW9vLuBIPrHaP36YcZaIAw9E3xLPWA4pPXwBZy5n9fdcSie6vqxP5wzl5RiCJfdu
         sU7JqBxB+9Ut+zINEm3Qivs89aq6PTpwxdTuHKvU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org,
        Richard Gong <richard.gong@linux.intel.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tony Prisk <linux@prisktech.co.nz>,
        linux-arm-kernel@lists.infradead.org,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH v2 09/10] video: fbdev: w100fb: convert platform driver to use dev_groups
Date:   Wed, 31 Jul 2019 14:43:48 +0200
Message-Id: <20190731124349.4474-10-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190731124349.4474-1-gregkh@linuxfoundation.org>
References: <20190731124349.4474-1-gregkh@linuxfoundation.org>
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
Cc: linux-arm-kernel@lists.infradead.org
Cc: dri-devel@lists.freedesktop.org
Cc: linux-fbdev@vger.kernel.org
Acked-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/video/fbdev/w100fb.c | 23 ++++++++++-------------
 1 file changed, 10 insertions(+), 13 deletions(-)

diff --git a/drivers/video/fbdev/w100fb.c b/drivers/video/fbdev/w100fb.c
index 597ffaa13cd2..3be07807edcd 100644
--- a/drivers/video/fbdev/w100fb.c
+++ b/drivers/video/fbdev/w100fb.c
@@ -164,6 +164,15 @@ static ssize_t fastpllclk_store(struct device *dev, struct device_attribute *att
 
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
@@ -752,14 +761,6 @@ int w100fb_probe(struct platform_device *pdev)
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
@@ -784,11 +785,6 @@ static int w100fb_remove(struct platform_device *pdev)
 	struct fb_info *info = platform_get_drvdata(pdev);
 	struct w100fb_par *par=info->par;
 
-	device_remove_file(&pdev->dev, &dev_attr_fastpllclk);
-	device_remove_file(&pdev->dev, &dev_attr_reg_read);
-	device_remove_file(&pdev->dev, &dev_attr_reg_write);
-	device_remove_file(&pdev->dev, &dev_attr_flip);
-
 	unregister_framebuffer(info);
 
 	vfree(par->saved_intmem);
@@ -1625,6 +1621,7 @@ static struct platform_driver w100fb_driver = {
 	.resume		= w100fb_resume,
 	.driver		= {
 		.name	= "w100fb",
+		.dev_groups	= w100fb_groups,
 	},
 };
 
-- 
2.22.0

