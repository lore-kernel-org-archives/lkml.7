Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24C11C10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 21:44:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF93D206B6
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 21:44:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dVaUmxO4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728702AbfDHVoB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 17:44:01 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:45685 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726188AbfDHVnW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 17:43:22 -0400
Received: by mail-lf1-f65.google.com with SMTP id t15so6780012lfl.12;
        Mon, 08 Apr 2019 14:43:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=X/wndm5aXTboBKQBo07EQSuwKC5btc/Z56ajATwmTuc=;
        b=dVaUmxO4/6iYQ0WLE5PxeLWpy9nu79cgZkPAQIuUkm9WqoHxj1JTPDzbUTjd7gIOx9
         WEOivKC+LeSDawac2O8vBOUgzma0stzZ+DTk0iD1no5VDHWQZmjWBxnWOHnCR0/R2tK0
         8uYZPRsirgid2kTq4h36QmsOMTm7g71EDbqI049RE+LCAMLfkkiGM3RQeoAc2JEJGPAW
         1YdaaYyukdQGsfFCJENu/VhBStac6YfsJXiiluMnUi91ISpIKmElWwE7afqLKw/dInUH
         denVDV2F8x5DSoHGflQ+ge/zOJk99u401VR+d6DYmHURLWApU/fbVMkv1jteogdgUbv/
         cqDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=X/wndm5aXTboBKQBo07EQSuwKC5btc/Z56ajATwmTuc=;
        b=OmtdVuXa+bOkD3gQhT8eq+ZAOgztMPJ205BFgjXgT1qglYo4RVJGtp7Doukc+gh+5H
         q2caVcRnHjGNXT0iN5aFsAM5S21+46dEequb2+MjnYoh1ocVOBQ7xyD/RGGpHbu/xOB2
         R66DLmzyZGaDyZ79RaHRS2zFybkVh0bRd1RANAKaAU+1kOyXgSkxMdPZj/tDTAFBE6FX
         IksoDDp/LKvxLqU0k0Oah2bUc7QreiWITMM3BqChp09oxF7YcBpCIIxsPcwXbPDLssWY
         F7EL90sCgQLH+U3Yuc6hyf3dLQ80Aibl0KnDyWb+Vm3hFPPs1cSYt5QRSmF3AoAab90V
         TPHw==
X-Gm-Message-State: APjAAAWrVYqjC0qFJnsUfoMTJi2qrliWOeh1HAKZDvlqNvjYVVaUG+4+
        6gZY8BEFVEM11Z4lvZ+Lixo=
X-Google-Smtp-Source: APXvYqxhVhDkM6TknGge7y3V37XWk+l8+LbUla4iG9ZeTbpYFUkEB+K9yFyok7+Mg4l6HJlQRFp0ww==
X-Received: by 2002:ac2:4424:: with SMTP id w4mr14293963lfl.148.1554759800118;
        Mon, 08 Apr 2019 14:43:20 -0700 (PDT)
Received: from z50.gdansk-morena.vectranet.pl (109241207190.gdansk.vectranet.pl. [109.241.207.190])
        by smtp.gmail.com with ESMTPSA id j6sm5286048ljc.0.2019.04.08.14.43.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Apr 2019 14:43:19 -0700 (PDT)
From:   Janusz Krzysztofik <jmkrzyszt@gmail.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Janusz Krzysztofik <jmkrzyszt@gmail.com>
Subject: [PATCH 11/14] media: ov6650: Fix .get_fmt() V4L2_SUBDEV_FORMAT_TRY support
Date:   Mon,  8 Apr 2019 23:42:39 +0200
Message-Id: <20190408214242.9603-12-jmkrzyszt@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190408214242.9603-1-jmkrzyszt@gmail.com>
References: <20190408214242.9603-1-jmkrzyszt@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit da298c6d98d5 ("[media] v4l2: replace video op g_mbus_fmt by pad
op get_fmt") converted a former ov6650_g_fmt() video operation callback
to an ov6650_get_fmt() pad operation callback.  However, the converted
function disregards a format->which flag that pad operations should
obey and always returns active frame format settings.

That can be fixed by always responding to V4L2_SUBDEV_FORMAT_TRY with
-EINVAL, or providing the response from a pad config argument, likely
updated by a former user call to V4L2_SUBDEV_FORMAT_TRY .set_fmt().
Since implementation of the latter is trivial, go for it.

Fixes: da298c6d98d5 ("[media] v4l2: replace video op g_mbus_fmt by pad op get_fmt")
Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
Cc: stable@vger.kernel.org
---
 drivers/media/i2c/ov6650.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/drivers/media/i2c/ov6650.c b/drivers/media/i2c/ov6650.c
index f6b0b77c5abf..e72210653f55 100644
--- a/drivers/media/i2c/ov6650.c
+++ b/drivers/media/i2c/ov6650.c
@@ -530,25 +530,27 @@ static int ov6650_get_fmt(struct v4l2_subdev *sd,
 	if (format->pad)
 		return -EINVAL;
 
+	/* initialize response with default media bus frame format */
+	*mf = ov6650_def_fmt;
+
+	/* update media bus format code and frame size */
 	switch (format->which) {
 	case V4L2_SUBDEV_FORMAT_ACTIVE:
+		mf->width = priv->rect.width >> priv->half_scale;
+		mf->height = priv->rect.height >> priv->half_scale;
+		mf->code = priv->code;
 		break;
 	case V4L2_SUBDEV_FORMAT_TRY:
-		if (cfg)
+		if (cfg) {
+			mf->width = cfg->try_fmt.width;
+			mf->height = cfg->try_fmt.height;
+			mf->code = cfg->try_fmt.code;
 			break;
+		}
 		/* fall through */
 	default:
 		return -EINVAL;
 	}
-
-	/* initialize response with default media bus frame format */
-	*mf = ov6650_def_fmt;
-
-	/* update media bus format code and frame size */
-	mf->width	= priv->rect.width >> priv->half_scale;
-	mf->height	= priv->rect.height >> priv->half_scale;
-	mf->code	= priv->code;
-
 	return 0;
 }
 
-- 
2.21.0

