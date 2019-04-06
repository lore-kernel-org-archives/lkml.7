Return-Path: <SRS0=Ybdz=SI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68290C10F06
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Apr 2019 08:19:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F21C21855
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Apr 2019 08:19:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="edPI+Y5B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726404AbfDFITE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Apr 2019 04:19:04 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:34568 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725934AbfDFITE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Apr 2019 04:19:04 -0400
Received: by mail-pg1-f194.google.com with SMTP id v12so4327749pgq.1
        for <linux-kernel@vger.kernel.org>; Sat, 06 Apr 2019 01:19:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=7S+/otONJq7A1+oidV272OlqVLwinjq666S1Pp9w7yk=;
        b=edPI+Y5BRmiu56Ok5EQdQKQcP2P9Fft5RRaHds0yJym7y1CZNILfieCbgI5eyRCKIX
         OMEUGvsLMQ/X+4rzKNmdXc2j5qG9+goYWJBihiUEnJw0c7xnz/1o9voitkAzSQVY092Z
         DrcFMp8T8YLt9WGMO+riMo3zSCR1LxM07jQfa47VUGAuy7I3peWT6EiBP+wSUGAFxNYQ
         hPdMOz3/q970CinePpHjMtblt47HstWwx2aTkhUJrG8zXqLbI11GkseYjJn4JB8o/wbC
         x5KEQWNMUKDrqkGnlttZqgb3hWbCdzIqflHG+uzUXykqjlIZlXqDNGd3WAg832mg4HPu
         5v/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=7S+/otONJq7A1+oidV272OlqVLwinjq666S1Pp9w7yk=;
        b=kKrqM/x8M+J9ulRSLbIOjQ+ZhpPfDG/RUDU3k9M3P9ZPyFvrZV2Zr4duuibekJlJG/
         LgHsiSi8ouu+AAs6B6YT5gWIV7qHzIUOC0BwkS3rKldDbh88h6fAWbAQm4nOt963Ei8m
         4yXq4cz9YiTxVLCabq64nAiKkd7jFd0OYBDSd5z8JjkQDY6EfGh3f3rEbOPi1vd/FRZe
         2MWcjUYvNedlQIiUjzog4OGch+7I0dZGzm/MlEZV1/4NEKZmygSSVROzN+RL0lfbfNws
         p6B5yOHXxmDoOJ54XNTL+saIj6H5rwROK3GNE4H0y2PkqwVSOe0y4XQhaiEO/+RrUX1I
         /bbA==
X-Gm-Message-State: APjAAAURYfuHxo4xnpZlEZSsmf17vU8lp13KDG8WMR9HtJgPRQtBy57V
        91Cl37k66jyIr2TGG57g2Aw=
X-Google-Smtp-Source: APXvYqwsxhy+Wk/hmYBSfSP5bpAzWRjeU28BIu70K15iarj0EOrUh1kb+fIHZ1vKe3wg5HJu5r5g/Q==
X-Received: by 2002:a63:d304:: with SMTP id b4mr16710145pgg.300.1554538743269;
        Sat, 06 Apr 2019 01:19:03 -0700 (PDT)
Received: from localhost.localdomain ([61.83.141.141])
        by smtp.gmail.com with ESMTPSA id v43sm1694652pgn.57.2019.04.06.01.18.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 06 Apr 2019 01:19:02 -0700 (PDT)
From:   Sidong Yang <realwakka@gmail.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Sidong Yang <realwakka@gmail.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/vboxvideo: Avoid double check buffer_overflow in vbva_write()
Date:   Sat,  6 Apr 2019 08:18:50 +0000
Message-Id: <20190406081850.1906-1-realwakka@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In vbva_write(), We do not need to double check available chunk size if
chunk is smaller than available buffer. Put the second if clause in the
first if clause and avoid check twice.

Signed-off-by: Sidong Yang <realwakka@gmail.com>
---
 drivers/gpu/drm/vboxvideo/vbva_base.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/vboxvideo/vbva_base.c b/drivers/gpu/drm/vboxvideo/vbva_base.c
index 36bc9824ec3f..a0c185acf37a 100644
--- a/drivers/gpu/drm/vboxvideo/vbva_base.c
+++ b/drivers/gpu/drm/vboxvideo/vbva_base.c
@@ -80,14 +80,14 @@ bool vbva_write(struct vbva_buf_ctx *vbva_ctx, struct gen_pool *ctx,
 		if (chunk >= available) {
 			vbva_buffer_flush(ctx);
 			available = vbva_buffer_available(vbva);
-		}
-
-		if (chunk >= available) {
-			if (WARN_ON(available <= vbva->partial_write_tresh)) {
-				vbva_ctx->buffer_overflow = true;
-				return false;
+			if (chunk >= available) {
+				if (WARN_ON(available <= vbva->partial_write_tresh)) {
+					vbva_ctx->buffer_overflow = true;
+					return false;
+				}
+				chunk = available - vbva->partial_write_tresh;
 			}
-			chunk = available - vbva->partial_write_tresh;
+
 		}
 
 		vbva_buffer_place_data_at(vbva_ctx, p, chunk,
-- 
2.11.0

