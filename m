Return-Path: <SRS0=yJb2=SB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6654C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 01:06:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75B91206DD
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 01:06:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W5e9S/rd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731605AbfC3BGj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 21:06:39 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:36069 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731312AbfC3BGe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 21:06:34 -0400
Received: by mail-lf1-f68.google.com with SMTP id d18so2630855lfn.3;
        Fri, 29 Mar 2019 18:06:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Io1qbMYC3j8dQAZIVD5s7ZIU2u1hZ0/nBzYbRzUgKlU=;
        b=W5e9S/rdf3vJLpWgNnvi7r633xmhxhxcPT+bSdF3Vi+xEjNjjA9+t4UYsxehh5pAuY
         B/CXHjUQOjG6Xo2zFSKhvchdX0r7CgfalXTPbsVshcrU3j8guX9VS1H+pTfNFefSkabE
         Xpo23WqPEGxc093ueePxXxHNpdIDjhbSEuktsCDISL7pHjHaINuLTI1u+w9SnztI4FGf
         bUGscay7CjjaUZdWPtMAxI/h8uU4ftfArbiE6HZk90CDsNbtNMk2+jZslvzhN2GQOFl4
         EJUbOuthSms0JZ38ExSEgnQy3WfB0X9ahKKr9Lwde8adhqPrEKO0uud5Z8ALHfWDcuce
         ueOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Io1qbMYC3j8dQAZIVD5s7ZIU2u1hZ0/nBzYbRzUgKlU=;
        b=oO0nyIFKYPHEWzIrsQyc25Hq5q6/2DaLYNjC2nIM4kh6ZnmS9RNZZcBHJ5dbjAIMti
         +hwW6mws1n69y6gyrnWXGly7LRRTX7g03szvl/wuGcszsDudCto9swJAM8l8wzFRMIB6
         DATVYsOFeE4T4NjWAI1UJZt9CYB3mZCQ/6MIZTFVjf1z+3n+wj0ye0smjab6mEObBehp
         KdPJth9BkcHWvHU0+84P9uOAgJYRfksr7yGAUf8coC6Ru4wwTP/y3UyQaTWZP10MXu37
         mjnHd2qzyG1n74dCYkIPztPLvze+EpIQvh+W9OuknF0Pl96V4HFnjjheaopV+i3lq20c
         KjdA==
X-Gm-Message-State: APjAAAX4dZat3TFFkRTLZnM55aACl3riMuLjNxWHEOLiakR2/fYmhUT+
        74upK0D7DT231pOAL3DMnhw=
X-Google-Smtp-Source: APXvYqzNxWfPOafn2Dfl9MqfKj0j1h3I5UBSCqE5SswiHd+QfvhKdfnrhjXG2FlpKlzM8Geo6s9KnA==
X-Received: by 2002:a19:6a02:: with SMTP id u2mr8666250lfu.20.1553907992193;
        Fri, 29 Mar 2019 18:06:32 -0700 (PDT)
Received: from z50.gdansk-morena.vectranet.pl (109241207190.gdansk.vectranet.pl. [109.241.207.190])
        by smtp.gmail.com with ESMTPSA id v21sm556514lfg.26.2019.03.29.18.06.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 Mar 2019 18:06:31 -0700 (PDT)
From:   Janusz Krzysztofik <jmkrzyszt@gmail.com>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>
Subject: [PATCH v3 1/2] media: ov6650: Move v4l2_clk_get() to ov6650_video_probe() helper
Date:   Sat, 30 Mar 2019 02:06:09 +0100
Message-Id: <20190330010610.15094-2-jmkrzyszt@gmail.com>
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

In preparation for adding asynchronous subdevice support to the driver,
don't acquire v4l2_clk from the driver .probe() callback as that may
fail if the clock is provided by a bridge driver which may be not yet
initialized.  Move the v4l2_clk_get() to ov6650_video_probe() helper
which is going to be converted to v4l2_subdev_internal_ops.registered()
callback, executed only when the bridge driver is ready.

Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
---
 drivers/media/i2c/ov6650.c | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/drivers/media/i2c/ov6650.c b/drivers/media/i2c/ov6650.c
index f9359b11fa5c..de7d9790f054 100644
--- a/drivers/media/i2c/ov6650.c
+++ b/drivers/media/i2c/ov6650.c
@@ -810,9 +810,16 @@ static int ov6650_video_probe(struct i2c_client *client)
 	u8		pidh, pidl, midh, midl;
 	int		ret;
 
+	priv->clk = v4l2_clk_get(&client->dev, NULL);
+	if (IS_ERR(priv->clk)) {
+		ret = PTR_ERR(priv->clk);
+		dev_err(&client->dev, "v4l2_clk request err: %d\n", ret);
+		return ret;
+	}
+
 	ret = ov6650_s_power(&priv->subdev, 1);
 	if (ret < 0)
-		return ret;
+		goto eclkput;
 
 	msleep(20);
 
@@ -849,6 +856,11 @@ static int ov6650_video_probe(struct i2c_client *client)
 
 done:
 	ov6650_s_power(&priv->subdev, 0);
+	if (!ret)
+		return 0;
+eclkput:
+	v4l2_clk_put(priv->clk);
+
 	return ret;
 }
 
@@ -991,18 +1003,9 @@ static int ov6650_probe(struct i2c_client *client,
 	priv->code	  = MEDIA_BUS_FMT_YUYV8_2X8;
 	priv->colorspace  = V4L2_COLORSPACE_JPEG;
 
-	priv->clk = v4l2_clk_get(&client->dev, NULL);
-	if (IS_ERR(priv->clk)) {
-		ret = PTR_ERR(priv->clk);
-		goto eclkget;
-	}
-
 	ret = ov6650_video_probe(client);
-	if (ret) {
-		v4l2_clk_put(priv->clk);
-eclkget:
+	if (ret)
 		v4l2_ctrl_handler_free(&priv->hdl);
-	}
 
 	return ret;
 }
-- 
2.19.2

