Return-Path: <SRS0=yJb2=SB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C126EC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 01:06:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CFD32184C
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 01:06:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kghjx4v6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731649AbfC3BGm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 21:06:42 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:45755 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730847AbfC3BGf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 21:06:35 -0400
Received: by mail-lj1-f194.google.com with SMTP id y6so3451512ljd.12;
        Fri, 29 Mar 2019 18:06:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Shu1qD9JXT2LMrmuOPOiVO+RXclrNPuRngondPpOLHc=;
        b=Kghjx4v6/YYAiGka7w+pqIsv8znZ7t9HneM9fWnGwhC3HsccFsCGu5/8nRhcG3HcQL
         oMcKG3gJQ+XTmTOMfwAyTD6nsL9GD0ZTJ2rHHre/wA5diiknhzTaGnOiQ+qnBR4752EA
         Po/FmKKYLrH0WhIE3XWS39TKBHhrcOmh1J2oUsM1S8ict0epLkDQ22p3/skhiha5ezFj
         C2yUZ87vg/rMxaCnDPBf7Szsi/x9idDNIe65KK5jV6uMDG2YyWjHtUUdB8psEQc8CEWw
         2yZUNhZulGM3ISR4H56u1uTqpekIqZgACLO/dfwkHuyeGOmeftns5o3E9y0Zcy5L3KC6
         oLjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Shu1qD9JXT2LMrmuOPOiVO+RXclrNPuRngondPpOLHc=;
        b=KmvW5cO4xV1HTqAvvl6kWuGbeg/MfZEqFuU8tV8WY7e1PXh8gpbs6hDo/GKabgRJnc
         KoceYwMUqr78KuE6FsYapodLAjoe5iTFJ8kzC9onBapJtp0vetALX/c99z4BQiFEeWiT
         Z73110SyBtI+UdtlpRsQo64cs55l4HMURoSpO7rRRF1X0/MFM67/HG0J8S90vVPpRO2X
         TCb2FAnE5zTRtxKHyZWXBd8wdKKWsbQTlJ0m+T4O2tVC2zU+w3jjXVCTHS1167qxcju0
         Rg07TpWtL6AhFT9eM+sjp8j/0Jakq7xSWMIzqELOpaYuy+Dpa7dH2AhfPg1Lj9adC9Bv
         qOOQ==
X-Gm-Message-State: APjAAAVloVBHHQgYkeFSTwKb8PrpgA8XQBe59DQyKrIMgHGW5c5YRm60
        XzUXG9nzRagO+KzVdwKHAIQ=
X-Google-Smtp-Source: APXvYqz4EnJlW34qzOevji4BKrIJhvT/nuEwc1Yj/vlee2acpgyaAJ6WV8ZmOCYNy78WQbsP9p+bww==
X-Received: by 2002:a2e:960b:: with SMTP id v11mr18259084ljh.135.1553907993452;
        Fri, 29 Mar 2019 18:06:33 -0700 (PDT)
Received: from z50.gdansk-morena.vectranet.pl (109241207190.gdansk.vectranet.pl. [109.241.207.190])
        by smtp.gmail.com with ESMTPSA id v21sm556514lfg.26.2019.03.29.18.06.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 Mar 2019 18:06:32 -0700 (PDT)
From:   Janusz Krzysztofik <jmkrzyszt@gmail.com>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>
Subject: [PATCH v3 2/2] media: ov6650: Register with asynchronous subdevice framework
Date:   Sat, 30 Mar 2019 02:06:10 +0100
Message-Id: <20190330010610.15094-3-jmkrzyszt@gmail.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20190330010610.15094-1-jmkrzyszt@gmail.com>
References: <20190329202903.5622-1-jmkrzyszt@gmail.com>
 <20190330010610.15094-1-jmkrzyszt@gmail.com>
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
 drivers/media/i2c/ov6650.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/drivers/media/i2c/ov6650.c b/drivers/media/i2c/ov6650.c
index de7d9790f054..7145bb68a9e1 100644
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
@@ -1003,7 +1008,11 @@ static int ov6650_probe(struct i2c_client *client,
 	priv->code	  = MEDIA_BUS_FMT_YUYV8_2X8;
 	priv->colorspace  = V4L2_COLORSPACE_JPEG;
 
-	ret = ov6650_video_probe(client);
+	priv->subdev.internal_ops = &ov6650_internal_ops;
+	priv->subdev.flags |= V4L2_SUBDEV_FL_HAS_DEVNODE;
+	v4l2_i2c_subdev_set_name(&priv->subdev, client, NULL, NULL);
+
+	ret = v4l2_async_register_subdev(&priv->subdev);
 	if (ret)
 		v4l2_ctrl_handler_free(&priv->hdl);
 
@@ -1015,7 +1024,7 @@ static int ov6650_remove(struct i2c_client *client)
 	struct ov6650 *priv = to_ov6650(client);
 
 	v4l2_clk_put(priv->clk);
-	v4l2_device_unregister_subdev(&priv->subdev);
+	v4l2_async_unregister_subdev(&priv->subdev);
 	v4l2_ctrl_handler_free(&priv->hdl);
 	return 0;
 }
-- 
2.19.2

