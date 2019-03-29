Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EA05C4360F
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 20:29:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E2E12184C
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 20:29:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I0j6X1xS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730169AbfC2U3z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 16:29:55 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:44496 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729996AbfC2U3r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 16:29:47 -0400
Received: by mail-lj1-f195.google.com with SMTP id h16so3063020ljg.11;
        Fri, 29 Mar 2019 13:29:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MlDXCuI7PsVS0X8mcb37dasmOR6g2cXO+GpBONhlG14=;
        b=I0j6X1xSwo1gjfZ+fWUm5bTgJYGrAb4d/d3QCP8p3ogsijcmJ9l7uMZgGgnJVz3Kcq
         6dQLN0UtyzxPM9prCCYhKtvaZSpufdSkevQ0tTSxJlFCZP+gO8x6kOeXZrN31nua/gc8
         Klqbqq+ZmLJ7FUtgOUoP5NY/M9D4cifUCb2ouiCkT9/3Q0qKQLiVeQxzc6rbZancatzr
         yXAEQ8csUNNHLZ/kdJVEbHrFFBoH9Q88zYHvwDd3qr0soypF9DOx/JxCG5dIlo57LGYz
         Maty9qL83DQpm2vTy6itNyHatrA8XN+jCgiOsxoC6XfU50h0tg3TEAIDpKCpcaLk3aFK
         ax+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MlDXCuI7PsVS0X8mcb37dasmOR6g2cXO+GpBONhlG14=;
        b=FZ3fLcd2XeRNx70+OeGubsvFzUCpcHR95Y6LcAYirCcWxwVHBhpBvk9JzMygd46wCn
         VILOapOjbs51btzkRNxpc8RpXF3CbjSxcu/SjeeKCTNPVhBLKq7shjpmz9dH9KQZ2mHU
         ydntvO972XeVlar7lokFQ8oP25Um/9fT4JFCeidu+cHXt8Gg3LppFQHIc8/Xmtmgn5ON
         atcWYFL+lsnZ+nymR515aNeFEi8lZKNtvoTRO8Kyqu13AjHLtE/dGopPqb4rR/R8ipCT
         Sb1nHhFOXlRTfLx3TKxxWwKHDzZFwazpgXcFfVuDB89q9q7BNuX6v9/ulOtAx1Yqchho
         WEaQ==
X-Gm-Message-State: APjAAAX++AEnqgcdTCbrBFW+cnBVKCo0s9HrqMg7PXxHisJlq45vWhTd
        1lIUsFGPmPvQtO/F+Ttyzdc=
X-Google-Smtp-Source: APXvYqzvCPDBZ3TK/dLLYAf5QuDVrUFwRMJREyRZlF9lNHYY/36M5zDFhOfb5AeGPY1Hm7ZgLUbyxw==
X-Received: by 2002:a2e:3010:: with SMTP id w16mr2882731ljw.62.1553891385821;
        Fri, 29 Mar 2019 13:29:45 -0700 (PDT)
Received: from z50.gdansk-morena.vectranet.pl (109241207190.gdansk.vectranet.pl. [109.241.207.190])
        by smtp.gmail.com with ESMTPSA id l16sm542645ljb.24.2019.03.29.13.29.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 Mar 2019 13:29:45 -0700 (PDT)
From:   Janusz Krzysztofik <jmkrzyszt@gmail.com>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>
Subject: [PATCH v2 2/2] media: ov6650: Register with asynchronous subdevice framework
Date:   Fri, 29 Mar 2019 21:29:03 +0100
Message-Id: <20190329202903.5622-3-jmkrzyszt@gmail.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20190329202903.5622-1-jmkrzyszt@gmail.com>
References: <20190325003501.14687-1-jmkrzyszt@gmail.com>
 <20190329202903.5622-1-jmkrzyszt@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Register V4L2 subdevice implemented by the driver to the V4L2
asynchronous subdevice framework.

Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
---
 drivers/media/i2c/ov6650.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/drivers/media/i2c/ov6650.c b/drivers/media/i2c/ov6650.c
index de7d9790f054..50e60da73036 100644
--- a/drivers/media/i2c/ov6650.c
+++ b/drivers/media/i2c/ov6650.c
@@ -804,8 +804,9 @@ static int ov6650_prog_dflt(struct i2c_client *client)
 	return ret;
 }
 
-static int ov6650_video_probe(struct i2c_client *client)
+static int ov6650_video_probe(struct v4l2_subdev *sd)
 {
+	struct i2c_client *client = v4l2_get_subdevdata(sd);
 	struct ov6650 *priv = to_ov6650(client);
 	u8		pidh, pidl, midh, midl;
 	int		ret;
@@ -817,7 +818,7 @@ static int ov6650_video_probe(struct i2c_client *client)
 		return ret;
 	}
 
-	ret = ov6650_s_power(&priv->subdev, 1);
+	ret = ov6650_s_power(sd, 1);
 	if (ret < 0)
 		goto eclkput;
 
@@ -855,7 +856,7 @@ static int ov6650_video_probe(struct i2c_client *client)
 		ret = v4l2_ctrl_handler_setup(&priv->hdl);
 
 done:
-	ov6650_s_power(&priv->subdev, 0);
+	ov6650_s_power(sd, 0);
 	if (!ret)
 		return 0;
 eclkput:
@@ -943,6 +944,10 @@ static const struct v4l2_subdev_ops ov6650_subdev_ops = {
 	.pad	= &ov6650_pad_ops,
 };
 
+static const struct v4l2_subdev_internal_ops ov6650_internal_ops = {
+	.registered = ov6650_video_probe,
+};
+
 /*
  * i2c_driver function
  */
@@ -1003,7 +1008,12 @@ static int ov6650_probe(struct i2c_client *client,
 	priv->code	  = MEDIA_BUS_FMT_YUYV8_2X8;
 	priv->colorspace  = V4L2_COLORSPACE_JPEG;
 
-	ret = ov6650_video_probe(client);
+	priv->subdev.internal_ops = &ov6650_internal_ops;
+	priv->subdev.flags |= V4L2_SUBDEV_FL_HAS_DEVNODE;
+	snprintf(priv->subdev.name, sizeof(priv->subdev.name), "%s %d-%04x",
+		 did->name, i2c_adapter_id(client->adapter), client->addr);
+
+	ret = v4l2_async_register_subdev(&priv->subdev);
 	if (ret)
 		v4l2_ctrl_handler_free(&priv->hdl);
 
@@ -1015,7 +1025,7 @@ static int ov6650_remove(struct i2c_client *client)
 	struct ov6650 *priv = to_ov6650(client);
 
 	v4l2_clk_put(priv->clk);
-	v4l2_device_unregister_subdev(&priv->subdev);
+	v4l2_async_unregister_subdev(&priv->subdev);
 	v4l2_ctrl_handler_free(&priv->hdl);
 	return 0;
 }
-- 
2.19.2

