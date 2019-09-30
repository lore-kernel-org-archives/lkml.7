Return-Path: <SRS0=rUXN=XZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96395C32792
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 10:19:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CAD621920
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 10:19:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569838741;
	bh=SdcLzt1NMV5HtC9jlXslHJgHvj8quEha2dL9Fzs+U+0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qJDPJQXS8dyQajG7/60UKlgZKq5jJzgcUAYDCZe24VawGgYYj0SvMrOPzP8R2Z9/f
	 pe3zD+wuvOv5s+QaiQm/ZEWEa2zJgQ+dReKQ0EmgSwo6m/U26i+tO3yUK4f5mjWNln
	 Jziyp33mtqWJIaL9M7DtXIGBaI6neFt6cuDcN7h4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730738AbfI3KTA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Sep 2019 06:19:00 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:40888 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730708AbfI3KS7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Sep 2019 06:18:59 -0400
Received: by mail-lj1-f195.google.com with SMTP id 7so8822796ljw.7;
        Mon, 30 Sep 2019 03:18:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=b2dEZ5VveeCRyXH+CovRffyZBiPh0RcTQuJCALACFyo=;
        b=KTyKHSWrrlMe+pJZAstb/2g9DIdKJ2SElSnnOL4ZmF8KvrXVrCO91z2zA4WtYrrOs2
         TNKqmqXzV4koMJKLPpKDmTr8ZimNx4ikbgadHfLdkwWJqAQunQfoD/zNN9gXlukQ39p5
         TmpRC2DeWzlCC7LMPPtdqiQYpzmtxu9GkDNzhtOWs3CJOJpekoealrzSZlkvjD2qKdJ/
         JrdAy1Z34iC/rz1KTZ8y97tp4WMK8erW6d8TbqOJy2NzWOpa0/nXoGObXYh886x4sG7Y
         gVxJw3pltbPjc6UIKROq5h908M9/28LQVesDKwmQ5sG+q1aYo3Y2CYaN2O++tVQnMHeU
         4ghQ==
X-Gm-Message-State: APjAAAUO5DzzIUNQOVROlJdXQ0j11eOfBC5R5xhUbW75oDMQjgQIARla
        qw3UQyM9ng8TnQdN4bRbEPdbsDH0yLw=
X-Google-Smtp-Source: APXvYqw+wTlt7ZcKy04xZEFUiYRT+L2HdloGEnfYj5G76OV5ksfPvsv0WZY9b0/mrDQNHG7s8oPTuA==
X-Received: by 2002:a2e:42c9:: with SMTP id h70mr11258722ljf.88.1569838735490;
        Mon, 30 Sep 2019 03:18:55 -0700 (PDT)
Received: from neopili.qtec.com (cpe.xe-3-0-1-778.vbrnqe10.dk.customer.tdc.net. [80.197.57.18])
        by smtp.gmail.com with ESMTPSA id z8sm3805970lfg.18.2019.09.30.03.18.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2019 03:18:54 -0700 (PDT)
From:   Ricardo Ribalda Delgado <ribalda@kernel.org>
To:     Philipp Zabel <p.zabel@pengutronix.de>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Jacopo Mondi <jacopo@jmondi.org>, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Ricardo Ribalda Delgado <ribalda@kernel.org>
Subject: [PATCH v8 8/8] media: imx214: Add new control with V4L2_CID_UNIT_CELL_SIZE
Date:   Mon, 30 Sep 2019 12:18:41 +0200
Message-Id: <20190930101841.19630-9-ribalda@kernel.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190930101841.19630-1-ribalda@kernel.org>
References: <20190930101841.19630-1-ribalda@kernel.org>
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
index 159a3a604f0e..4d9879f60dfb 100644
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
+				v4l2_ctrl_ptr_from_void((void *)&unit_size));
 	ret = imx214->ctrls.error;
 	if (ret) {
 		dev_err(&client->dev, "%s control init failed (%d)\n",
-- 
2.23.0

