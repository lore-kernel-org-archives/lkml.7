Return-Path: <SRS0=Y9JJ=T2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52F10C46460
	for <linux-kernel@archiver.kernel.org>; Sun, 26 May 2019 20:48:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 205842075E
	for <linux-kernel@archiver.kernel.org>; Sun, 26 May 2019 20:48:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FJZ3qf3E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726197AbfEZUsY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 May 2019 16:48:24 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:38187 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725788AbfEZUsT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 May 2019 16:48:19 -0400
Received: by mail-lf1-f68.google.com with SMTP id b11so4172950lfa.5;
        Sun, 26 May 2019 13:48:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+x6WG6WqbSoE6WUEpqF/4MvaYXvmZDdI8YQeSR6pdD8=;
        b=FJZ3qf3EdxoSTq8Zw6mow2R8CM8rKNPwCia7dpfuJr79mWc3Y+l7Yd3oBMtj9rZYJY
         EGSE8r5UI81ttNQpJaIUxQtFAh+mI1onGNQKJv93No1Tdv8I9NwJQOOVnpbCVcq84fcw
         tbkEDyYx0xRfMs7EUkVSYcoR8Co+J6CxYIGlyUOw4pQLT6/BlWA8gMd73HYkxzwNCDiF
         ryy4Tp77LPg1LrdUdteoodZ9kmogF/Ttp2Iodgp9ifY635nu0dxg4kdQKCEjZeTQxNVp
         8ZnB/J1DBuIuR0zGAlHs9yZJ1gAVwwLpY9+PmXtwHGTSRx5UiDhd6OgfZUPFQbYSyIsR
         PjpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+x6WG6WqbSoE6WUEpqF/4MvaYXvmZDdI8YQeSR6pdD8=;
        b=o7m3nWoF1iDR6unuRMj71Rdxf4brEOp7QqjYwvJs4jJsjrnDdOBttacTBnJQotr2tl
         6Q1D93B1ocWVWtQ7yhaXW01s7YPItr+Wdvp+NeINv5Vvua8nqIx+p59rcTFJGbrFv3+U
         W28eFSg7FhJCw8QFl7z6BvICtNEZBRKOGnoT2zQA7sPYSfhrbvaMcdkkiIW1saCPu4hn
         IllwGAsMIxGxUX+ylhIOVfYmgD3Z2gzydrw0i6FUwByPI3PQrF+QTgD7hBPesQtRWbHV
         JkDOBz4YwpKBPtlK0230RXMyIF9+J3XzjNwbE9ylml62uO+JEQK1zSotjF59mgcsy6mq
         a+rQ==
X-Gm-Message-State: APjAAAV1lFN1POVvVaFplSH7Uq6u8H0dJoa7dsnFw5cJO+bMErW9qbwi
        DQWgEw9zPDu8wPTveZ+0cxE=
X-Google-Smtp-Source: APXvYqxEZxbj0cvy32Qo1Uc8bigNO+ua0rKsDLgeke2jkdcJeBuoF1/4drlztU40NHIxnsyUaLRU3g==
X-Received: by 2002:a19:2247:: with SMTP id i68mr719938lfi.174.1558903697319;
        Sun, 26 May 2019 13:48:17 -0700 (PDT)
Received: from z50.gdansk-morena.vectranet.pl (109241207190.gdansk.vectranet.pl. [109.241.207.190])
        by smtp.gmail.com with ESMTPSA id i187sm1859475lfe.64.2019.05.26.13.48.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 26 May 2019 13:48:16 -0700 (PDT)
From:   Janusz Krzysztofik <jmkrzyszt@gmail.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>
Subject: [RFC PATCH 5/5] media: ov6650: Add .init_cfg() pad operation callback
Date:   Sun, 26 May 2019 22:47:58 +0200
Message-Id: <20190526204758.1904-6-jmkrzyszt@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190526204758.1904-1-jmkrzyszt@gmail.com>
References: <20190526204758.1904-1-jmkrzyszt@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver now supports V4L2_SUBDEV_FORMAT_TRY operation mode only in
.get/set_fmt() pad operation callbacks.  That means only .try_format
member of pad config is maintained.  As a consequence, active crop
rectangle is used as a referece while V4L2_SUBDEV_FORMAT_TRY requests
are processed.  In order to fix that, a method for initialization of
.try_crop pad config member is needed.

Implement .init_cfg() pad operation callback which initializes the pad
config from current active format and selection settings.  From now on,
and before the driver V4L2_SUBDEV_FORMAT_TRY support is further
modified, host interface drivers should call .init_cfg() on a pad
config before passing it to V4L2_SUBDEV_FORMAT_TRY operations.

Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
---
 drivers/media/i2c/ov6650.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/media/i2c/ov6650.c b/drivers/media/i2c/ov6650.c
index cc70d8952999..c3d4c1f598b2 100644
--- a/drivers/media/i2c/ov6650.c
+++ b/drivers/media/i2c/ov6650.c
@@ -447,6 +447,26 @@ static int ov6650_s_power(struct v4l2_subdev *sd, int on)
 	return ret;
 }
 
+static int ov6650_init_cfg(struct v4l2_subdev *sd,
+			   struct v4l2_subdev_pad_config *cfg)
+{
+	struct i2c_client *client = v4l2_get_subdevdata(sd);
+	struct ov6650 *priv = to_ov6650(client);
+	struct v4l2_mbus_framefmt *mf;
+	struct v4l2_rect *rect;
+
+	mf = &cfg->try_fmt;
+	*mf = ov6650_def_fmt;
+	mf->width = priv->rect.width >> priv->half_scale;
+	mf->height = priv->rect.height >> priv->half_scale;
+	mf->code = priv->code;
+
+	rect = &cfg->try_crop;
+	*rect = priv->rect;
+
+	return 0;
+}
+
 static int ov6650_get_selection(struct v4l2_subdev *sd,
 		struct v4l2_subdev_pad_config *cfg,
 		struct v4l2_subdev_selection *sel)
@@ -959,6 +979,7 @@ static const struct v4l2_subdev_video_ops ov6650_video_ops = {
 };
 
 static const struct v4l2_subdev_pad_ops ov6650_pad_ops = {
+	.init_cfg	= ov6650_init_cfg,
 	.enum_mbus_code = ov6650_enum_mbus_code,
 	.get_selection	= ov6650_get_selection,
 	.set_selection	= ov6650_set_selection,
-- 
2.21.0

