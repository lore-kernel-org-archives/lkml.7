Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07F5AC282CE
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 09:01:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B56D120870
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 09:01:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="K5Yxzj7o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726678AbfDHJBl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 05:01:41 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:32942 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726189AbfDHJBl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 05:01:41 -0400
Received: by mail-wr1-f66.google.com with SMTP id q1so15392774wrp.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2019 02:01:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+Chqmz3DLAhI8VyDEHCtkqYxXlFJ7zTtEYN9MLmqcUM=;
        b=K5Yxzj7ohVIHXnDYusnX5gxa+m5PV8nzOxijASwOkBBX5ZyzGNGFsVsfSkILms16fZ
         9CiV7by57eQxhdc5shP07cDvn4XdMQBelbkNQS6BY1jACf/JJTr/zkl8KgAb8c9ZYBvE
         3dHN3+DXPIGjAXK9m7j6O1XdMoqmC9nJMcWDPYR6shrgkxiNU6S/63/H2AF6ob4V/53I
         mUPenIxKysjPcSpvJXqK6RmrA6mDX8fSHHVqcY5wLfsx+aKsOsRvYODdhg3OSZy37PrD
         PoIwbwYYnSF3Q7FG3ZFJCRyq+BPCx8Wut43YtTJxZh0+eKDZ7euFzQELi2EH5+iCG/P7
         GTcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+Chqmz3DLAhI8VyDEHCtkqYxXlFJ7zTtEYN9MLmqcUM=;
        b=dbBr6gEW9PP955kZpEpmC38YG6g1obTCB9C31jELnD4kSXre3wM82AEG0GUlaLVWJm
         /J7swMmw9DSMX4lGyjCBC1yI6xUmsFkFkiKLhpwd9TxaGF4S7pkMVlm/OPy6oHcIaJbD
         z3HR51xW6X8eJLl+qEfwsYG3fOc6T7MLnlCYDRPS5rxXA0TT4rlN98nOJULEK3BB8PEI
         sLO2GIWS+XTzclNib1AdLLlNixi+UiDffIQ9GC7ECDPYSZzP/Y6K9oLzB30jNtz0kQk2
         yn3SAYv2ttfPuvg788WxVdnwN7QS87JttQBWhpbv3rufJJp4/fCBfQXL2K2c5w75Axqb
         6hTQ==
X-Gm-Message-State: APjAAAVOE7g1/LJAPEs26HRxDHH2mFhpfyulcE1Y74MxGs5BHuDniAAx
        a6sJ96pw2vyiLxxtQ8i6dN+HQA==
X-Google-Smtp-Source: APXvYqwYr7N3z9lZyDvO5/6UxOAAhUi8HsUMm4KG5KrLg+QTml0skMaVjz/83v9qxwjFzkWXWAdeHA==
X-Received: by 2002:a5d:4087:: with SMTP id o7mr18595917wrp.9.1554714099199;
        Mon, 08 Apr 2019 02:01:39 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id x5sm26799116wrt.72.2019.04.08.02.01.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 08 Apr 2019 02:01:38 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Neil Armstrong <narmstrong@baylibre.com>, sky.zhou@amlogic.com,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/meson: add size and alignment requirements for dumb buffers
Date:   Mon,  8 Apr 2019 11:01:37 +0200
Message-Id: <20190408090137.2402-1-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Amlogic SoCs Canvas buffers stride must be aligned on 64bytes
and overall size should be aligned on PAGE width.

Adds a custom dumb_create op to adds these requirements.

Fixes: bbbe775ec5b5 ("drm: Add support for Amlogic Meson Graphic Controller")
Suggested-by: Sky Zhou <sky.zhou@amlogic.com>
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/gpu/drm/meson/meson_drv.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/meson/meson_drv.c b/drivers/gpu/drm/meson/meson_drv.c
index faf1b1b0357c..72b01e6be0d9 100644
--- a/drivers/gpu/drm/meson/meson_drv.c
+++ b/drivers/gpu/drm/meson/meson_drv.c
@@ -90,6 +90,18 @@ static irqreturn_t meson_irq(int irq, void *arg)
 	return IRQ_HANDLED;
 }
 
+static int meson_dumb_create(struct drm_file *file, struct drm_device *dev,
+			     struct drm_mode_create_dumb *args)
+{
+	/*
+	 * We need 64bytes aligned stride, and PAGE aligned size
+	 */
+	args->pitch = ALIGN(DIV_ROUND_UP(args->width * args->bpp, 8), SZ_64);
+	args->size = PAGE_ALIGN(args->pitch * args->height);
+
+	return drm_gem_cma_dumb_create_internal(file, dev, args);
+}
+
 DEFINE_DRM_GEM_CMA_FOPS(fops);
 
 static struct drm_driver meson_driver = {
@@ -112,7 +124,7 @@ static struct drm_driver meson_driver = {
 	.gem_prime_mmap		= drm_gem_cma_prime_mmap,
 
 	/* GEM Ops */
-	.dumb_create		= drm_gem_cma_dumb_create,
+	.dumb_create		= meson_dumb_create,
 	.gem_free_object_unlocked = drm_gem_cma_free_object,
 	.gem_vm_ops		= &drm_gem_cma_vm_ops,
 
-- 
2.21.0

