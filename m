Return-Path: <SRS0=rUXN=XZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69EC0C4360C
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 03:10:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30D102168B
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 03:10:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hetnKUgs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729456AbfI3DKA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Sep 2019 23:10:00 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:35206 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726360AbfI3DKA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Sep 2019 23:10:00 -0400
Received: by mail-io1-f66.google.com with SMTP id q10so34394834iop.2;
        Sun, 29 Sep 2019 20:09:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=JdWTb1V4IhUUMb47mN6yAdg27zy2bK0W+qF3wp30fYo=;
        b=hetnKUgsD2zSGDpE7xOLnzeBpXHQYJEYYEqnzJSwcvWeNhdWPsdlC6/Pbtswtb+2tg
         ReMBVDCg9wXGCrev7wYoFfActSDTXjhCrs0vGHKXQNlzmnTvodwpgC8GReVyUTL0cUH6
         jPTCtsx6gOP9iFcUzUyy2V77UQAkJPNLpN/9ZFmSxBsi6rCppsNdoC3ciTBBpVHYGV8Z
         Myyx7ePbg+RWklM9om4+N+eOelSbT4G5BFWA9tPOKtxcimECtmLWNhuAU4sZY3PA7GSi
         2E2BiHEuooVd+tzXxgBWNKKeiMaqgI0bZFAkItESu2W1K44vsybFpfUDwksMtW2XWFcq
         p/mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=JdWTb1V4IhUUMb47mN6yAdg27zy2bK0W+qF3wp30fYo=;
        b=qTA1OPG01dk3OU3azeHvSXJuynJuWzybyqS87C0xIBx9iOw1L7ccEs6gKcwAMC+2fR
         rdFfSav6f2CdYqr33H2BSDB7zCWtUf1gq/xatdozyZ79oixLhBbaX/YF56lYqg6qLgvs
         gSEc7bhLKfwYPi1shq+GBRZz6b8F8XLB4yCiGGOTsAmnFQXN6sP31bukhioFskm8TdXd
         AhRmkgLaobATUQG79w4oPjMkdFFe97y0RsMV7JX965F1t2pAPiphN/J59GLHxhLnCK2n
         5A/vMi22vYjsM4nXYUtDUv1DcNj9gy5xojhUK95nrfLzVYVb07/p77EojqhGCA4yhimI
         2q4w==
X-Gm-Message-State: APjAAAWGEH1bitG6HOuvyYajlEkFPJuF99oGanczrPuP1hmHFBpKZBEa
        CVczJtBMYkbExgcmb6xF9UU=
X-Google-Smtp-Source: APXvYqw9S4icJAA3Iim6bEKEOhPYCZHJFDUjRkHAKLayY1qZ/8t7tcsSVHOGYMUZdwQB5yUeCahPEQ==
X-Received: by 2002:a5d:9349:: with SMTP id i9mr3190833ioo.101.1569812999347;
        Sun, 29 Sep 2019 20:09:59 -0700 (PDT)
Received: from cs-dulles.cs.umn.edu (cs-dulles.cs.umn.edu. [128.101.35.54])
        by smtp.googlemail.com with ESMTPSA id r22sm5444086ilb.85.2019.09.29.20.09.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Sep 2019 20:09:58 -0700 (PDT)
From:   Navid Emamdoost <navid.emamdoost@gmail.com>
Cc:     emamd001@umn.edu, kjlu@umn.edu, smccaman@umn.edu,
        Navid Emamdoost <navid.emamdoost@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Bhanusree Pola <bhanusreemahesh@gmail.com>,
        Phil Reid <preid@electromag.com.au>,
        Sam Ravnborg <sam@ravnborg.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        =?UTF-8?q?Jan=20Sebastian=20G=C3=B6tte?= <linux@jaseg.net>,
        Nishad Kamdar <nishadkamdar@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Staging: fbtft: fix memory leak in fbtft_framebuffer_alloc
Date:   Sun, 29 Sep 2019 22:09:45 -0500
Message-Id: <20190930030949.28615-1-navid.emamdoost@gmail.com>
X-Mailer: git-send-email 2.17.1
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In fbtft_framebuffer_alloc the error handling path should take care of
releasing frame buffer after it is allocated via framebuffer_alloc, too.
Therefore, in two failure cases the goto destination is changed to
address this issue.

Fixes: c296d5f9957c ("staging: fbtft: core support")
Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
---
 drivers/staging/fbtft/fbtft-core.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/fbtft/fbtft-core.c b/drivers/staging/fbtft/fbtft-core.c
index cf5700a2ea66..a0a67aa517f0 100644
--- a/drivers/staging/fbtft/fbtft-core.c
+++ b/drivers/staging/fbtft/fbtft-core.c
@@ -714,7 +714,7 @@ struct fb_info *fbtft_framebuffer_alloc(struct fbtft_display *display,
 	if (par->gamma.curves && gamma) {
 		if (fbtft_gamma_parse_str(par, par->gamma.curves, gamma,
 					  strlen(gamma)))
-			goto alloc_fail;
+			goto release_framebuf;
 	}
 
 	/* Transmit buffer */
@@ -731,7 +731,7 @@ struct fb_info *fbtft_framebuffer_alloc(struct fbtft_display *display,
 	if (txbuflen > 0) {
 		txbuf = devm_kzalloc(par->info->device, txbuflen, GFP_KERNEL);
 		if (!txbuf)
-			goto alloc_fail;
+			goto release_framebuf;
 		par->txbuf.buf = txbuf;
 		par->txbuf.len = txbuflen;
 	}
@@ -753,6 +753,9 @@ struct fb_info *fbtft_framebuffer_alloc(struct fbtft_display *display,
 
 	return info;
 
+release_framebuf:
+	framebuffer_release(info);
+
 alloc_fail:
 	vfree(vmem);
 
-- 
2.17.1

