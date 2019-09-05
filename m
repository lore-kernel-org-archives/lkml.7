Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71A98C3A59E
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 01:53:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40C1F2073F
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 01:53:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dNUFGdE6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730667AbfIEBxu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 21:53:50 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:34883 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727156AbfIEBxt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 21:53:49 -0400
Received: by mail-pf1-f196.google.com with SMTP id 205so642949pfw.2
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2019 18:53:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8ULGV/s7+qxZzul0FZw0GFFC3DnLHdGN42oRHfNbhLE=;
        b=dNUFGdE6RxUVKSBcjKmrQrqlL9FPlzSO56kd0QMh/TXkHVoF9S8yiNeuZeb+6Rj0pz
         b2mVlOWxszR2z44QxOn4skZ+uB8WrXw0acG5obbeJVaFb8wo03HDJow4wz+ef+PhXBRK
         ug7KvfyBSxnZIR2bgmAdMnUyzu2z3W7q//XuxSXcAcHw6UII4eIiL2G/G95sOTe9DXiP
         m93lAHu5LNW7U2PPohSHrsS8kyfSdPbeOtsFjgtJE+gMCq6w7r+HXFQQRcxnls3Vwo15
         282jOffbVZZJpHi7aDFAc3LfxYeclo4e37IccSvmb3dKzSAmCugucFoFIeG8iNK8D7+U
         QRVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8ULGV/s7+qxZzul0FZw0GFFC3DnLHdGN42oRHfNbhLE=;
        b=dwkfrUOap7XNo6QjSLr9PvYWNt/ZqqgVJaYmmbI/Hv/QqKiYydrypRMeO9CgxErFKn
         3nFLpJ2cL0SNVEJ1PEoY4DWvYiyfpJ6n3rWKWfBlXPoLHeGY6W8NxLfmlUj9fU1+mzaq
         iSb86MaxcFbUToPXi3357lK6MttwdkO6BIHpo/fZKp7AUZ57NafFwuiwSOKZPLBEv1Iv
         Hg0DwC9yZbVIhDuUeK7IIkBmm2dcjd+AJMbvqD9IFyFXNExByPoCworI/qA2TRk9nDFe
         7b8VsEedo2SYEJ8p/6XaQr0Zcqz77U8e1y9W3GVAKXXOUHmTfLXLVkIBFQLlEkLfWinh
         1OAQ==
X-Gm-Message-State: APjAAAUiq8PkBtyGMkLv0BymdJwv/mfIr9gIb9XV8fULcPmn9Nf6XrIg
        snpJHBCWBlFne1vbVcP9RC6Pnn3CfnM=
X-Google-Smtp-Source: APXvYqw1w8fU8E5K0bJsKsZgOMHGnxpe8l++eG8ZPXQwHo7rLedG7gEMXj3dlyn8sF5oBeQVtvNNaw==
X-Received: by 2002:a63:6fcf:: with SMTP id k198mr936312pgc.276.1567648428825;
        Wed, 04 Sep 2019 18:53:48 -0700 (PDT)
Received: from localhost.localdomain ([61.83.141.141])
        by smtp.gmail.com with ESMTPSA id z12sm330990pfj.41.2019.09.04.18.53.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2019 18:53:48 -0700 (PDT)
From:   Sidong Yang <realwakka@gmail.com>
To:     Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
Cc:     Sidong Yang <realwakka@gmail.com>,
        Haneen Mohammed <hamohammed.sa@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>
Subject: [PATCH v2] drm/vkms: Use alpha value to blend values.
Date:   Thu,  5 Sep 2019 02:53:26 +0100
Message-Id: <20190905015326.23853-1-realwakka@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use alpha value to blend source value and destination value Instead of
just overwrite with source value.

Signed-off-by: Sidong Yang <realwakka@gmail.com>
---
v1 -> v2: 
 * Move variables to tighter scope.

 drivers/gpu/drm/vkms/vkms_composer.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/vkms/vkms_composer.c b/drivers/gpu/drm/vkms/vkms_composer.c
index d5585695c64d..181472efa08c 100644
--- a/drivers/gpu/drm/vkms/vkms_composer.c
+++ b/drivers/gpu/drm/vkms/vkms_composer.c
@@ -77,6 +77,9 @@ static void blend(void *vaddr_dst, void *vaddr_src,
 
 	for (i = y_src, i_dst = y_dst; i < y_limit; ++i) {
 		for (j = x_src, j_dst = x_dst; j < x_limit; ++j) {
+			u8 *src, *dst;
+			u32 alpha, inv_alpha;
+
 			offset_dst = dest_composer->offset
 				     + (i_dst * dest_composer->pitch)
 				     + (j_dst++ * dest_composer->cpp);
@@ -84,8 +87,14 @@ static void blend(void *vaddr_dst, void *vaddr_src,
 				     + (i * src_composer->pitch)
 				     + (j * src_composer->cpp);
 
-			memcpy(vaddr_dst + offset_dst,
-			       vaddr_src + offset_src, sizeof(u32));
+			src = vaddr_src + offset_src;
+			dst = vaddr_dst + offset_dst;
+			alpha = src[3] + 1;
+			inv_alpha = 256 - src[3];
+			dst[0] = (alpha * src[0] + inv_alpha * dst[0]) >> 8;
+			dst[1] = (alpha * src[1] + inv_alpha * dst[1]) >> 8;
+			dst[2] = (alpha * src[2] + inv_alpha * dst[2]) >> 8;
+			dst[3] = 0xff;
 		}
 		i_dst++;
 	}
-- 
2.20.1

