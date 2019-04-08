Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 799C5C10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 21:44:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E4A52084F
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 21:44:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZTWZdhB/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728752AbfDHVoM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 17:44:12 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:44654 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726780AbfDHVnT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 17:43:19 -0400
Received: by mail-lj1-f194.google.com with SMTP id h16so12592510ljg.11;
        Mon, 08 Apr 2019 14:43:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TDPWX+c9T8wtLVwEqZLlhf3dHuEObpXGSnaRZkfVeqo=;
        b=ZTWZdhB/OFzD9rVvGhiW8mkmgo5pEDqG3JYgsUK7mzudPv5RFiwjuaF//snIOzR4Cm
         WTV3mvQPERZcfbhRcbL3SIojFa2j6lbCl3xN4WelY3qwb2B3tMqZ8Q5ki+QxMwWTd38O
         a5n9hbTFw9pL1cOKjHFgzTch82Qm7VeTli0niIukU7WBgpuPMIMACpShltGfNEReKHHL
         1ky6VlyIHhuEO+HvU8xLAh/fReOGdtut5Xn3zAmjGsVck/BeRJVQ32y72A7jq8ZeUSHi
         3bCJ3eVW0H1JGWNzTCjqrxjg2UvGH8xvVQWUPoFuXksCOchByJn3cn5qqbEMDlrZSsIx
         tGQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TDPWX+c9T8wtLVwEqZLlhf3dHuEObpXGSnaRZkfVeqo=;
        b=ifUDjKipSb07lNkt1+LKymhWgkII4etPy3F3+iV1eXhn+UTAQlKrUc78XEPdJI2iE3
         3lm0OQQ9LrU2tu1plNnSqlgBLIe2oUT/wyOFKJnnPy6Y+4T6uiKpgxWIgfOX5m97kxSn
         Fbyn145saaSfm4StCjgoz0HyG4tgIVG/DkdBD5BmwvW9x3k2y2IN3So7doLnI6XtuqJI
         Xs48ZKP+lhq5j7DJNTB78tjH8kVhSSPD3QKZv/NAygyRbDenewJnPTr2CDCZV/JroK2V
         vM7hzCnO0NTWHE8ok/wS4QPpPhUz6jx9bIi5AlcGqvX0fvKw+wUCHn3J/yZs3RedrtNB
         SYdw==
X-Gm-Message-State: APjAAAXcOMAL6KToCOu4ESuTjQFBfxSf5TBNJRo13/KuFSD1AP1TMxZe
        bpEoUjt5c0hvpXD7cONcHyo=
X-Google-Smtp-Source: APXvYqybad6RwzU9/9VlZroERFMff7Ldyv/jJ+o8b73V8h3WGCqzgR/gQj9hPSGOZ/5uKoPMywP1LQ==
X-Received: by 2002:a2e:808e:: with SMTP id i14mr18167106ljg.103.1554759796391;
        Mon, 08 Apr 2019 14:43:16 -0700 (PDT)
Received: from z50.gdansk-morena.vectranet.pl (109241207190.gdansk.vectranet.pl. [109.241.207.190])
        by smtp.gmail.com with ESMTPSA id j6sm5286048ljc.0.2019.04.08.14.43.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Apr 2019 14:43:15 -0700 (PDT)
From:   Janusz Krzysztofik <jmkrzyszt@gmail.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Janusz Krzysztofik <jmkrzyszt@gmail.com>,
        staable@vger.kernel.org
Subject: [PATCH 08/14] media: ov6650: Fix crop rectangle alignment not passed back
Date:   Mon,  8 Apr 2019 23:42:36 +0200
Message-Id: <20190408214242.9603-9-jmkrzyszt@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190408214242.9603-1-jmkrzyszt@gmail.com>
References: <20190408214242.9603-1-jmkrzyszt@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 4f996594ceaf ("[media] v4l2: make vidioc_s_crop const")
introduced a writable copy of constified user requested crop rectangle
in order to be able to perform hardware alignments on it.  Later
on, commit 10d5509c8d50 ("[media] v4l2: remove g/s_crop from video
ops") replaced s_crop() video operaion using that const argument with
set_selection() pad operation which had a corresponding argument not
constified, however the original behavior of the driver was not
restored.  Since that time, any hardware alignment applied on a user
requested crop rectangle is not passed back to the user calling
.set_selection() as it should be.

Fix the issue by dropping the copy and replacing all references to it
with references to the crop rectangle embedded in the user argument.

Fixes: 10d5509c8d50 ("[media] v4l2: remove g/s_crop from video ops")
Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
Cc: staable@vger.kernel.org
---
 drivers/media/i2c/ov6650.c | 31 +++++++++++++++----------------
 1 file changed, 15 insertions(+), 16 deletions(-)

diff --git a/drivers/media/i2c/ov6650.c b/drivers/media/i2c/ov6650.c
index 1daef0c7ad91..07d7a0708cca 100644
--- a/drivers/media/i2c/ov6650.c
+++ b/drivers/media/i2c/ov6650.c
@@ -471,7 +471,6 @@ static int ov6650_set_selection(struct v4l2_subdev *sd,
 {
 	struct i2c_client *client = v4l2_get_subdevdata(sd);
 	struct ov6650 *priv = to_ov6650(client);
-	struct v4l2_rect rect = sel->r;
 	int ret;
 
 	if (sel->pad)
@@ -481,31 +480,31 @@ static int ov6650_set_selection(struct v4l2_subdev *sd,
 	    sel->target != V4L2_SEL_TGT_CROP)
 		return -EINVAL;
 
-	v4l_bound_align_image(&rect.width, 2, W_CIF, 1,
-			      &rect.height, 2, H_CIF, 1, 0);
-	v4l_bound_align_image(&rect.left, DEF_HSTRT << 1,
-			      (DEF_HSTRT << 1) + W_CIF - (__s32)rect.width, 1,
-			      &rect.top, DEF_VSTRT << 1,
-			      (DEF_VSTRT << 1) + H_CIF - (__s32)rect.height, 1,
-			      0);
+	v4l_bound_align_image(&sel->r.width, 2, W_CIF, 1,
+			      &sel->r.height, 2, H_CIF, 1, 0);
+	v4l_bound_align_image(&sel->r.left, DEF_HSTRT << 1,
+			      (DEF_HSTRT << 1) + W_CIF - (__s32)sel->r.width, 1,
+			      &sel->r.top, DEF_VSTRT << 1,
+			      (DEF_VSTRT << 1) + H_CIF - (__s32)sel->r.height,
+			      1, 0);
 
-	ret = ov6650_reg_write(client, REG_HSTRT, rect.left >> 1);
+	ret = ov6650_reg_write(client, REG_HSTRT, sel->r.left >> 1);
 	if (!ret) {
-		priv->rect.left = rect.left;
+		priv->rect.left = sel->r.left;
 		ret = ov6650_reg_write(client, REG_HSTOP,
-				(rect.left + rect.width) >> 1);
+				       (sel->r.left + sel->r.width) >> 1);
 	}
 	if (!ret) {
-		priv->rect.width = rect.width;
-		ret = ov6650_reg_write(client, REG_VSTRT, rect.top >> 1);
+		priv->rect.width = sel->r.width;
+		ret = ov6650_reg_write(client, REG_VSTRT, sel->r.top >> 1);
 	}
 	if (!ret) {
-		priv->rect.top = rect.top;
+		priv->rect.top = sel->r.top;
 		ret = ov6650_reg_write(client, REG_VSTOP,
-				(rect.top + rect.height) >> 1);
+				       (sel->r.top + sel->r.height) >> 1);
 	}
 	if (!ret)
-		priv->rect.height = rect.height;
+		priv->rect.height = sel->r.height;
 
 	return ret;
 }
-- 
2.21.0

