Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 515CAECE58C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 15:07:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2565F21479
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 15:07:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570460821;
	bh=pK20S9w9jPx4oDEOoBNNwlgSdse6dCqOTIYN8MTHsOo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=lRB78m+jQA1/OGf16JpbkzAroxVTiFmdt41jm/PO0JaQ8JpxQH7m8PSJsClBKAAnr
	 41pk1ErO+A5GCA5YscUQnPXw5mK9yZOydd1gD3LqolanOwVUW4Srz4kJ0H+r6W+dxp
	 JLQm/h5L1ugwp6jutfL4qsIfYkxq/vYoHdbZ0IbU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728695AbfJGPHA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 11:07:00 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:40161 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728603AbfJGPGy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 11:06:54 -0400
Received: by mail-lj1-f195.google.com with SMTP id 7so14063598ljw.7;
        Mon, 07 Oct 2019 08:06:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pmVOhqPV32NcE6/VgCf74tZc8Nj51x40T3jhqugB4as=;
        b=TRWYkwkpgSPiRjKPy7XOhSTGN33f5oXhUOsnZkIejWwy/7/X81vvcWeo+GKHZsSUnp
         E3GHUBRYro6UKk8LrXrpqN0+qd86i6RKf4dAUYkIc07/3E4gCbZShiNrNCzjuhOJa0M6
         MON8JdgQg4qJ1LQqrKbpOAk1ZjD7nok8Eu2IS2lB5+AAr4YJM1F19YqS8YXiLDJHj9S9
         xsTyW2h2UXIlVs0iQ3G1Jbd7C4q2x4J2NTf0m8oP1pNctsPR9nBX++Dm5Njvdkd0dcNI
         fwG8ck28eRgmWZkTeg+jty5X1pqS7+YHBIZTq2DKnMwRyTn9mcRs6bhADHkiPF06fzAv
         +h7A==
X-Gm-Message-State: APjAAAVV4cmWImA+r2gtittKyQFZiLTddQ0g5XUbcEGHO3jKX2srFikh
        fUKAzvtbToD6MLkhjFJm4jc=
X-Google-Smtp-Source: APXvYqwK7DNQQdsfY9M8U1S6wADiMibc8D0R/IKBzbxZdTUIZvO0h2ZdKVAPY1QBihaCvYiJN5ndAA==
X-Received: by 2002:a05:651c:154:: with SMTP id c20mr18307067ljd.83.1570460812200;
        Mon, 07 Oct 2019 08:06:52 -0700 (PDT)
Received: from neopili.qtec.com (cpe.xe-3-0-1-778.vbrnqe10.dk.customer.tdc.net. [80.197.57.18])
        by smtp.gmail.com with ESMTPSA id n2sm3145517ljj.30.2019.10.07.08.06.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2019 08:06:50 -0700 (PDT)
From:   Ricardo Ribalda Delgado <ribalda@kernel.org>
To:     Philipp Zabel <p.zabel@pengutronix.de>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Jacopo Mondi <jacopo@jmondi.org>, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Ricardo Ribalda Delgado <ribalda@kernel.org>
Subject: [PATCH v12 8/8] media: imx214: Add new control with V4L2_CID_UNIT_CELL_SIZE
Date:   Mon,  7 Oct 2019 17:06:36 +0200
Message-Id: <20191007150636.16458-9-ribalda@kernel.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191007150636.16458-1-ribalda@kernel.org>
References: <20191007150636.16458-1-ribalda@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to the product brief, the unit cell size is 1120 nanometers^2.

https://www.sony-semicon.co.jp/products_en/IS/sensor1/img/products/ProductBrief_IMX214_20150428.pdf

Signed-off-by: Ricardo Ribalda Delgado <ribalda@kernel.org>
---
 drivers/media/i2c/imx214.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/media/i2c/imx214.c b/drivers/media/i2c/imx214.c
index 159a3a604f0e..adcaaa8c86d1 100644
--- a/drivers/media/i2c/imx214.c
+++ b/drivers/media/i2c/imx214.c
@@ -47,6 +47,7 @@ struct imx214 {
 	struct v4l2_ctrl *pixel_rate;
 	struct v4l2_ctrl *link_freq;
 	struct v4l2_ctrl *exposure;
+	struct v4l2_ctrl *unit_size;
 
 	struct regulator_bulk_data	supplies[IMX214_NUM_SUPPLIES];
 
@@ -948,6 +949,10 @@ static int imx214_probe(struct i2c_client *client)
 	static const s64 link_freq[] = {
 		IMX214_DEFAULT_LINK_FREQ,
 	};
+	static const struct v4l2_area unit_size = {
+		.width = 1120,
+		.height = 1120,
+	};
 	int ret;
 
 	ret = imx214_parse_fwnode(dev);
@@ -1029,6 +1034,10 @@ static int imx214_probe(struct i2c_client *client)
 					     V4L2_CID_EXPOSURE,
 					     0, 3184, 1, 0x0c70);
 
+	imx214->unit_size = v4l2_ctrl_new_std_compound(&imx214->ctrls,
+				NULL,
+				V4L2_CID_UNIT_CELL_SIZE,
+				v4l2_ctrl_ptr_create((void *)&unit_size));
 	ret = imx214->ctrls.error;
 	if (ret) {
 		dev_err(&client->dev, "%s control init failed (%d)\n",
-- 
2.23.0

