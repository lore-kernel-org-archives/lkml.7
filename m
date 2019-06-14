Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55DA1C31E45
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 01:03:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B7BD2147A
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 01:03:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dqzAr8lD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727398AbfFNBDJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 21:03:09 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35684 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725837AbfFNBDJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 21:03:09 -0400
Received: by mail-wr1-f68.google.com with SMTP id m3so689382wrv.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2019 18:03:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=+EV7DG8i07w38rTd1k2CcWOZS1S6GGa4Mr7+B4XkO7M=;
        b=dqzAr8lDzVrREDJu/eQH5cHbAFXP18GA93BzzRHGXmp+2enb6Phtfs9IxKmg82gKz6
         EKaO8kLQlDE6p8hNbrlELjK+3KH4mNyV7BCdU9PqhEjMpbJ7ttOxV4U5mk9W4m+6blns
         p3Eh7SabkjaBcUr0MKJfp0xtCHpeQvfv3WyiR+NeGLjYq0C7uk2zjqI+8rI1uOoCwxE3
         IsBD12tP5GWeJuJkjhGFdOZNjvtDUCB52OG6RZDcHORLHAih8qV/DI049lBLYsWV7KUZ
         D6jwmEJy9QhMA6rBa8e9qPuxIEaZjemM8bP7C4FuOfETwYSKXrbEW93w563q6MXpDqsb
         KM0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=+EV7DG8i07w38rTd1k2CcWOZS1S6GGa4Mr7+B4XkO7M=;
        b=K1K/cBcveHfYTquDlSZMl5QB7Izd2o4AeeOh1JjC5Dot1xJwUkefk5/gi5HwBva4L1
         vTBcEGQ4odQndU2SIwbaD/P+FCn5F23c/1G/IQGOzeViJCtcw9s0Rh84pQQs0YVl63FV
         kOpnG9En68i3631rIQNUx8oi5GcgVQW6++nAFzXK43LQpboldWToEUIRprjrrdgANgED
         sYzLsCUxppzH2332+LlAJz0lBVCYVKBB/zQ6plqYB9ZVOc3ANJJlii1i4Mj2PaE8JMzc
         5wcQeXtIe90Ji92kaMEaa9hxEYAB9PmazqNVB/DwqU4m4CegjYo5Vn7refrOsJ9C/GK9
         rPQg==
X-Gm-Message-State: APjAAAWq9ZaWGqlayhvL2iDxE9aKYY5mzhkSMJ3OcQtOb4ey5WhjW4sF
        V+28OLMLV8mWBmC9T49jEb8=
X-Google-Smtp-Source: APXvYqzuBFsGZGklqTH+D6iW9N9NeQjHnth0STybblRODEa+D76ffLeUX/1dGRXXHPmOakPD+zw4ew==
X-Received: by 2002:a5d:53c2:: with SMTP id a2mr9034856wrw.8.1560474187054;
        Thu, 13 Jun 2019 18:03:07 -0700 (PDT)
Received: from mappy.world.mentorg.com (sjewanfw1-nat.mentorg.com. [139.181.7.34])
        by smtp.gmail.com with ESMTPSA id r131sm1177476wmf.4.2019.06.13.18.03.04
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 13 Jun 2019 18:03:06 -0700 (PDT)
From:   Steve Longerbeam <slongerbeam@gmail.com>
To:     Philipp Zabel <p.zabel@pengutronix.de>
Cc:     Steve Longerbeam <slongerbeam@gmail.com>,
        dri-devel@lists.freedesktop.org (open list:DRM DRIVERS FOR FREESCALE
        IMX), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] gpu: ipu-v3: image-convert: Enable double write reduction
Date:   Thu, 13 Jun 2019 18:02:55 -0700
Message-Id: <20190614010255.13593-1-slongerbeam@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For the write channels with 4:2:0 subsampled YUV formats, avoid chroma
overdraw by only writing chroma for even lines (skip odd chroma rows).
This reduces necessary write memory bandwidth by at least 25% (more
with rotation enabled).

Signed-off-by: Steve Longerbeam <slongerbeam@gmail.com>
---
 drivers/gpu/ipu-v3/ipu-image-convert.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/gpu/ipu-v3/ipu-image-convert.c b/drivers/gpu/ipu-v3/ipu-image-convert.c
index 36e88434513a..3036e01d8d42 100644
--- a/drivers/gpu/ipu-v3/ipu-image-convert.c
+++ b/drivers/gpu/ipu-v3/ipu-image-convert.c
@@ -1279,6 +1279,15 @@ static void init_idmac_channel(struct ipu_image_convert_ctx *ctx,
 	if (rot_mode)
 		ipu_cpmem_set_rotation(channel, rot_mode);
 
+	/*
+	 * Skip writing U and V components to odd rows in the output
+	 * channels for planar 4:2:0.
+	 */
+	if ((channel == chan->out_chan ||
+	     channel == chan->rotation_out_chan) &&
+	    image->fmt->planar && image->fmt->uv_height_dec == 2)
+		ipu_cpmem_skip_odd_chroma_rows(channel);
+
 	if (channel == chan->rotation_in_chan ||
 	    channel == chan->rotation_out_chan) {
 		burst_size = 8;
-- 
2.17.1

