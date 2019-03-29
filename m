Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BACBFC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 20:29:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81EA5218A5
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 20:29:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YT3Rj3W2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730153AbfC2U3t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 16:29:49 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:42400 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730094AbfC2U3q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 16:29:46 -0400
Received: by mail-lf1-f65.google.com with SMTP id b7so2304601lfg.9;
        Fri, 29 Mar 2019 13:29:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Io1qbMYC3j8dQAZIVD5s7ZIU2u1hZ0/nBzYbRzUgKlU=;
        b=YT3Rj3W2nqbg0coT56bl+YAose+IeD68CItY82GektYwWyCis2xl6iHgKzY+cINCOc
         dy9tC02um2MILByBw33MEi/EnGr3dD2NqY8WjWdIEhjIz9A5RTMLzaZoA0m/dpgcaYLx
         7hYbJ9h4ynhOGQwCynsIezYPq/5oeWZYGMZbHErc9gHLLWuZ2D83Wy2BCe7w8X/Hk4kq
         1PWwayZR1q75yEpoxDNJ2+stw/GD3BV4Df3QIUT+U4OosdNLLLnbUpFFr+NsMiNJgQhO
         Zy5eglkupPB4O0HzKRQD5SVfevyOTbV/FoqTyclitH7nqA/ygVhWJcKrcwYX+xzD3fSk
         mxzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Io1qbMYC3j8dQAZIVD5s7ZIU2u1hZ0/nBzYbRzUgKlU=;
        b=CYkqxwLliLWleQ/XApTlErP9wwWWeCQG7AhcQMQi9w/3w6cIzORCpKuQSsyuxyvUfB
         vRpo0R6zKF1Mm3ybtZFFd6w9eV1k/J5h0BT2CNGAvNbKSKXqRZRyNc8DnqRu/MTazf/c
         TqkD9D7XM47sk0kINwB6UHbqMGQAKvHCGAv5LLfo7RF3Hi20bS/WhhZ1JdPLh57qM4LG
         uUkVhSyTPylwy8kacyeyJgTIQZ+XOZ8iWaHITzkuf18AblftarOn1rcekw2HZMR3+iwi
         DPjN0+TSguTC0vDC67ZcdBzNhkiA6WRqck2iw+6f3KU1H8txtLQbsXgs2f3/wfDCqjE7
         I2IA==
X-Gm-Message-State: APjAAAVDGVwYkZBOEHldDHAD9iqIb8XjZrt/x/C4lSXIQ11DeGHpvlXb
        T67+5xPLiabFGod6v/CNk/M=
X-Google-Smtp-Source: APXvYqzhsmKAz5VmRPSKaazOx0L+g4++/D11tDyGD8k/X/8pXCzJDy17Vdu7PyKnV0PN8ggGUXx5cw==
X-Received: by 2002:a19:6b14:: with SMTP id d20mr25358056lfa.152.1553891384414;
        Fri, 29 Mar 2019 13:29:44 -0700 (PDT)
Received: from z50.gdansk-morena.vectranet.pl (109241207190.gdansk.vectranet.pl. [109.241.207.190])
        by smtp.gmail.com with ESMTPSA id l16sm542645ljb.24.2019.03.29.13.29.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 Mar 2019 13:29:43 -0700 (PDT)
From:   Janusz Krzysztofik <jmkrzyszt@gmail.com>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>
Subject: [PATCH v2 1/2] media: ov6650: Move v4l2_clk_get() to ov6650_video_probe() helper
Date:   Fri, 29 Mar 2019 21:29:02 +0100
Message-Id: <20190329202903.5622-2-jmkrzyszt@gmail.com>
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

