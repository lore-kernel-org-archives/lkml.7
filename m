Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF84EC4CEC9
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 13:51:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6FA92054F
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 13:51:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s+31JabZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387602AbfITNv4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 09:51:56 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:38554 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387571AbfITNvw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 09:51:52 -0400
Received: by mail-ed1-f67.google.com with SMTP id l21so1684781edr.5;
        Fri, 20 Sep 2019 06:51:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Mip9hhM4GlCkg7XXw8v5EimNCLlBX1UP4PMrnT65eGA=;
        b=s+31JabZiBSdo4+9i5gb8psqbEpaYWX0NouUD8j24FHpLXBKJZT3w7DvtNwzGwgOtl
         F1Z4h+NjiQYYkLiap4yaq1WZ63xSG1tG5IM63/MDSq6xdXex35ABgSmVoz5tBshVGKfL
         TIbrCuuqKRs97G5Vvzys+NvjBAYICAUIkeitwQLtR1qJI+DfnuDG6P9Rpla+J2h5MPgn
         s3ftV+xDrUEVV6ieF6T1GnyZ3iuAuMLagjX3qprOKiuik51BS4Xjz1cn6CXOEWWylY17
         KFgpcaheCKyeizqu8P1v1oTDB4XWrA46KcBpN+dPZD3W3hDvaB0tlk25ZBYoJldLKqGe
         spEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=Mip9hhM4GlCkg7XXw8v5EimNCLlBX1UP4PMrnT65eGA=;
        b=CSguP5ZAP94nQrvMUaNg6EoX8jVD6tyETX91DSW4Aigjuhtm2p5UQRcKbCjeKrk2E7
         JM2B+hOz9K2ukTH3TOj7OpXjIMp/QAt2i6H49ng6JACTm+U7JqnZP09TfvQOS9H2EG2T
         yeaxF3iu++d9vW1trVNYJA26xf+B49+IMGFIO7FUUx5gNttzergJjH1fz6sZT7Lvk9jx
         25y8far6sF2+R71UguzvaSYfPshdWtyUgXgrSCzkHhBsDe9qzIy/qqY6rexl1XmBDRSq
         M2urOBO58hb80m2LmMT87sXQPMvWciYxp+rmaW2SxoKO+Ft7L+8CgUBpHATcBql4GGmP
         76TQ==
X-Gm-Message-State: APjAAAXBuAcEBF0z5VMMpBLOkFgTojnQQXJmOK/pjvMmOQQK5BqeC+H5
        DcqBMcOgEZrVmbdQO6/lcP6HDzF2wAo=
X-Google-Smtp-Source: APXvYqxm5+Jfk1GgeMe0PSir7qMXVQx82RmWbXFBTAxxk7fP+7RL3b75vrpVdOs1uQE40p3H/C5Qtw==
X-Received: by 2002:a17:906:3e96:: with SMTP id a22mr3725252ejj.268.1568987510723;
        Fri, 20 Sep 2019 06:51:50 -0700 (PDT)
Received: from neopili.qtec.com (cpe.xe-3-0-1-778.vbrnqe10.dk.customer.tdc.net. [80.197.57.18])
        by smtp.gmail.com with ESMTPSA id t30sm337673edt.91.2019.09.20.06.51.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Sep 2019 06:51:49 -0700 (PDT)
From:   Ricardo Ribalda Delgado <ricardo@ribalda.com>
To:     Philipp Zabel <p.zabel@pengutronix.de>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Jacopo Mondi <jacopo@jmondi.org>, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Ricardo Ribalda Delgado <ribalda@kernel.org>
Subject: [PATCH v6 7/7] media: imx214: Add new control with V4L2_CID_UNIT_CELL_SIZE
Date:   Fri, 20 Sep 2019 15:51:37 +0200
Message-Id: <20190920135137.10052-8-ricardo@ribalda.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190920135137.10052-1-ricardo@ribalda.com>
References: <20190920135137.10052-1-ricardo@ribalda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ricardo Ribalda Delgado <ribalda@kernel.org>

According to the product brief, the unit cell size is 1120 nanometers^2.

https://www.sony-semicon.co.jp/products_en/IS/sensor1/img/products/ProductBrief_IMX214_20150428.pdf

Signed-off-by: Ricardo Ribalda Delgado <ribalda@kernel.org>
---
 drivers/media/i2c/imx214.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/media/i2c/imx214.c b/drivers/media/i2c/imx214.c
index 159a3a604f0e..57562e20c4ca 100644
--- a/drivers/media/i2c/imx214.c
+++ b/drivers/media/i2c/imx214.c
@@ -47,6 +47,7 @@ struct imx214 {
 	struct v4l2_ctrl *pixel_rate;
 	struct v4l2_ctrl *link_freq;
 	struct v4l2_ctrl *exposure;
+	struct v4l2_ctrl *unit_size;
 
 	struct regulator_bulk_data	supplies[IMX214_NUM_SUPPLIES];
 
@@ -948,6 +949,13 @@ static int imx214_probe(struct i2c_client *client)
 	static const s64 link_freq[] = {
 		IMX214_DEFAULT_LINK_FREQ,
 	};
+	struct v4l2_area unit_size = {
+		.width = 1120,
+		.height = 1120,
+	};
+	union v4l2_ctrl_ptr p_def = {
+		.p_area = &unit_size,
+	};
 	int ret;
 
 	ret = imx214_parse_fwnode(dev);
@@ -1029,6 +1037,10 @@ static int imx214_probe(struct i2c_client *client)
 					     V4L2_CID_EXPOSURE,
 					     0, 3184, 1, 0x0c70);
 
+	imx214->unit_size = v4l2_ctrl_new_std_compound(&imx214->ctrls,
+						       NULL,
+						       V4L2_CID_UNIT_CELL_SIZE,
+						       p_def);
 	ret = imx214->ctrls.error;
 	if (ret) {
 		dev_err(&client->dev, "%s control init failed (%d)\n",
-- 
2.23.0

