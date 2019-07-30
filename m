Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABE7FC0650F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 18:16:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A56A20693
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 18:16:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NMzARui8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388198AbfG3SQv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 14:16:51 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:36300 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387944AbfG3SQi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 14:16:38 -0400
Received: by mail-pf1-f196.google.com with SMTP id r7so30266012pfl.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2019 11:16:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nPhDfjxW/VqkltTfokj9fJ6/qREHMvH5O4AA+8mxaUw=;
        b=NMzARui867kGdB9A1UYs4zbCXT3RjzMlWWT7kvvFXXaz5/vfwU02qjop8UMwz8/TnX
         NnKda0EyH8SlHsr+/6bNxInRvbF8MYuf+Pa6qiUJkO1Yj6zE2Uvw6c3jCjjBtMr5n8nJ
         xy0P8QaPvniobYF5/gIKwaFnSpgFElmSTiA6E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nPhDfjxW/VqkltTfokj9fJ6/qREHMvH5O4AA+8mxaUw=;
        b=gTEE0zf20x5/ovBZnoaiB0lidDRmgQPf0xFw06nIYWgm7cqXSNH19lhvjgz3KDyOcP
         XNHBGGW4xk9oBEPX0fdDDgB3HrE3NRyxUQCKzz7FLmfF46J72S4g9WfHXPC86g3zDlLB
         wFDOldPkuNSeJPKv4HW2SHSOe/qPjkl+Sh09RAw8rOQePRGVigxRNl9QcetKmN+ui80q
         1V+v1WN+VDRDPHqTd55OhkNYwwOrbccFFO8uDieJ7t0VP3L1QS6OGeXVTNZ7Uk7tyIKw
         rtEyglERH/C0/sFUJ5xwl0bcFTZdQlmtyrIqkFB5pplAe3hFA391DbSUj1q+6VZK6e2z
         OnJw==
X-Gm-Message-State: APjAAAXF7SHqHuSiEZTSl+7qBAvZsdZqjKIPnAem5dDKCfomTOfKVf8S
        vfE8qL9NnPEBO1OveCUOn0mSQsY9SDhvFQ==
X-Google-Smtp-Source: APXvYqw19MihHg/lZICk2Z6Mer8w0uXAamqYkW9qwe9AgnCF26fFuoRNzw9fB3+j11R0Q+UGDxqeLA==
X-Received: by 2002:a17:90a:1785:: with SMTP id q5mr117320027pja.106.1564510597533;
        Tue, 30 Jul 2019 11:16:37 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id g1sm106744083pgg.27.2019.07.30.11.16.36
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 30 Jul 2019 11:16:37 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v6 47/57] video: Remove dev_err() usage after platform_get_irq()
Date:   Tue, 30 Jul 2019 11:15:47 -0700
Message-Id: <20190730181557.90391-48-swboyd@chromium.org>
X-Mailer: git-send-email 2.22.0.709.g102302147b-goog
In-Reply-To: <20190730181557.90391-1-swboyd@chromium.org>
References: <20190730181557.90391-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We don't need dev_err() messages when platform_get_irq() fails now that
platform_get_irq() prints an error message itself when something goes
wrong. Let's remove these prints with a simple semantic patch.

// <smpl>
@@
expression ret;
struct platform_device *E;
@@

ret =
(
platform_get_irq(E, ...)
|
platform_get_irq_byname(E, ...)
);

if ( \( ret < 0 \| ret <= 0 \) )
{
(
-if (ret != -EPROBE_DEFER)
-{ ...
-dev_err(...);
-... }
|
...
-dev_err(...);
)
...
}
// </smpl>

While we're here, remove braces on if statements that only have one
statement (manually).

Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: dri-devel@lists.freedesktop.org
Cc: linux-fbdev@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---

Please apply directly to subsystem trees

 drivers/video/fbdev/atmel_lcdfb.c     | 1 -
 drivers/video/fbdev/mmp/hw/mmp_ctrl.c | 1 -
 drivers/video/fbdev/nuc900fb.c        | 4 +---
 drivers/video/fbdev/pxa168fb.c        | 4 +---
 drivers/video/fbdev/pxa3xx-gcu.c      | 4 +---
 drivers/video/fbdev/pxafb.c           | 1 -
 drivers/video/fbdev/s3c2410fb.c       | 4 +---
 drivers/video/fbdev/vt8500lcdfb.c     | 1 -
 8 files changed, 4 insertions(+), 16 deletions(-)

diff --git a/drivers/video/fbdev/atmel_lcdfb.c b/drivers/video/fbdev/atmel_lcdfb.c
index 5ff8e0320d95..4a16354d65c8 100644
--- a/drivers/video/fbdev/atmel_lcdfb.c
+++ b/drivers/video/fbdev/atmel_lcdfb.c
@@ -1114,7 +1114,6 @@ static int __init atmel_lcdfb_probe(struct platform_device *pdev)
 
 	sinfo->irq_base = platform_get_irq(pdev, 0);
 	if (sinfo->irq_base < 0) {
-		dev_err(dev, "unable to get irq\n");
 		ret = sinfo->irq_base;
 		goto stop_clk;
 	}
diff --git a/drivers/video/fbdev/mmp/hw/mmp_ctrl.c b/drivers/video/fbdev/mmp/hw/mmp_ctrl.c
index 17174cd7a5bb..d6124976139b 100644
--- a/drivers/video/fbdev/mmp/hw/mmp_ctrl.c
+++ b/drivers/video/fbdev/mmp/hw/mmp_ctrl.c
@@ -447,7 +447,6 @@ static int mmphw_probe(struct platform_device *pdev)
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
-		dev_err(&pdev->dev, "%s: no IRQ defined\n", __func__);
 		ret = -ENOENT;
 		goto failed;
 	}
diff --git a/drivers/video/fbdev/nuc900fb.c b/drivers/video/fbdev/nuc900fb.c
index 4fd851598584..c4606c734f44 100644
--- a/drivers/video/fbdev/nuc900fb.c
+++ b/drivers/video/fbdev/nuc900fb.c
@@ -526,10 +526,8 @@ static int nuc900fb_probe(struct platform_device *pdev)
 	display = mach_info->displays + mach_info->default_display;
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		dev_err(&pdev->dev, "no irq for device\n");
+	if (irq < 0)
 		return -ENOENT;
-	}
 
 	fbinfo = framebuffer_alloc(sizeof(struct nuc900fb_info), &pdev->dev);
 	if (!fbinfo)
diff --git a/drivers/video/fbdev/pxa168fb.c b/drivers/video/fbdev/pxa168fb.c
index 1410f476e135..d9e5258503f0 100644
--- a/drivers/video/fbdev/pxa168fb.c
+++ b/drivers/video/fbdev/pxa168fb.c
@@ -625,10 +625,8 @@ static int pxa168fb_probe(struct platform_device *pdev)
 	}
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		dev_err(&pdev->dev, "no IRQ defined\n");
+	if (irq < 0)
 		return -ENOENT;
-	}
 
 	info = framebuffer_alloc(sizeof(struct pxa168fb_info), &pdev->dev);
 	if (info == NULL) {
diff --git a/drivers/video/fbdev/pxa3xx-gcu.c b/drivers/video/fbdev/pxa3xx-gcu.c
index 74ffb446e00c..07414d43cb3f 100644
--- a/drivers/video/fbdev/pxa3xx-gcu.c
+++ b/drivers/video/fbdev/pxa3xx-gcu.c
@@ -614,10 +614,8 @@ static int pxa3xx_gcu_probe(struct platform_device *pdev)
 
 	/* request the IRQ */
 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		dev_err(dev, "no IRQ defined: %d\n", irq);
+	if (irq < 0)
 		return irq;
-	}
 
 	ret = devm_request_irq(dev, irq, pxa3xx_gcu_handle_irq,
 			       0, DRV_NAME, priv);
diff --git a/drivers/video/fbdev/pxafb.c b/drivers/video/fbdev/pxafb.c
index 4282cb117b92..b44f402ce552 100644
--- a/drivers/video/fbdev/pxafb.c
+++ b/drivers/video/fbdev/pxafb.c
@@ -2353,7 +2353,6 @@ static int pxafb_probe(struct platform_device *dev)
 
 	irq = platform_get_irq(dev, 0);
 	if (irq < 0) {
-		dev_err(&dev->dev, "no IRQ defined\n");
 		ret = -ENODEV;
 		goto failed_free_mem;
 	}
diff --git a/drivers/video/fbdev/s3c2410fb.c b/drivers/video/fbdev/s3c2410fb.c
index a702da89910b..2a846fd5da2a 100644
--- a/drivers/video/fbdev/s3c2410fb.c
+++ b/drivers/video/fbdev/s3c2410fb.c
@@ -849,10 +849,8 @@ static int s3c24xxfb_probe(struct platform_device *pdev,
 	display = mach_info->displays + mach_info->default_display;
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		dev_err(&pdev->dev, "no irq for device\n");
+	if (irq < 0)
 		return -ENOENT;
-	}
 
 	fbinfo = framebuffer_alloc(sizeof(struct s3c2410fb_info), &pdev->dev);
 	if (!fbinfo)
diff --git a/drivers/video/fbdev/vt8500lcdfb.c b/drivers/video/fbdev/vt8500lcdfb.c
index be8d9702cbb2..a10088e1cdb0 100644
--- a/drivers/video/fbdev/vt8500lcdfb.c
+++ b/drivers/video/fbdev/vt8500lcdfb.c
@@ -372,7 +372,6 @@ static int vt8500lcd_probe(struct platform_device *pdev)
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
-		dev_err(&pdev->dev, "no IRQ defined\n");
 		ret = -ENODEV;
 		goto failed_free_palette;
 	}
-- 
Sent by a computer through tubes

