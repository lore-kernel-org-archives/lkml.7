Return-Path: <SRS0=daYT=YG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2550DC4CECE
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Oct 2019 12:52:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2ECD206A3
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Oct 2019 12:52:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CTN2oK77"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729288AbfJMMwC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 13 Oct 2019 08:52:02 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:36402 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729130AbfJMMvw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Oct 2019 08:51:52 -0400
Received: by mail-lj1-f194.google.com with SMTP id v24so13989241ljj.3;
        Sun, 13 Oct 2019 05:51:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=70J2v6uWAhiRGhg1LXaKeSs3P933eEPAxMOkaLLVTnY=;
        b=CTN2oK77tCXIp720Tnm8zkekHhQBJtobWchPYrfMyK/GFp7krlrQI3QPlGQQdMa8rQ
         yWEE5ax0nTomURXqRGy+yictEzflVUhQTLYeWQIjl8XGG1BMh0TwRHHQEOBkbnwAInuR
         jmncYHfrYCW79noHYBnbKD4TagFNatditDVTbPOWqLNHs3UntOSW9Lhv4czHTsfr4fN7
         3bogGRaCfNNcGrvgQIFmGbDBVwOt3zmLSoeLvQeef9C+kwlUUc5SLuadjwGQcdsZsyCT
         MFO1qptRggyLm0lBTaO+XeNuB2+30uOYNXqfnpXJeVdpC/vy7fcpwE+P2xYvQBY0RFAf
         q5PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=70J2v6uWAhiRGhg1LXaKeSs3P933eEPAxMOkaLLVTnY=;
        b=mEscd4FmiYY5ea2AGJqyeiQu8UPznQ6pVMdgF/v8XsZ/5pDnOrKIUkmJKsy59doz+a
         bm6XGIKwCZH7uCOp+voRrxtrF5Kz966FJX8gbmoNwd3zyd87NOAGwbfHCjpjwRVsjIb1
         xy6W1KOoUSXsLRXkNKjoklihr0GPLoBLZlHS/RJDaLsh4RT47W4dJlFvJMzEhS+a5ovR
         VoSM4wdxmKi9CsLwB7YTTgtZ/CEDvnpMfgfU9x3iC5q2M6hSzcYmkEZI78DTq/+p4u75
         B/6q5V0EKcaZZJf9I4+qLb0A8ehtCKrPV6w/KYjIQ4nBIMFtsvv1gwNN31nZ9UaT78M1
         dhIw==
X-Gm-Message-State: APjAAAXQt1da8p8VWCH9AcnrdR57XCc0jQU99rmkF/82dIa8/vYTyxvE
        Yx3JqinCoXQqJ8MeCytzPoc=
X-Google-Smtp-Source: APXvYqyEk7Pf5/iDdl4rfqrTpep8lZSSS1xJoS2maMB+X6qF2Rtv9Y9Pa++ZBfEoDtLZk4YUWuEmmg==
X-Received: by 2002:a2e:6101:: with SMTP id v1mr15628226ljb.122.1570971110374;
        Sun, 13 Oct 2019 05:51:50 -0700 (PDT)
Received: from z50.gdansk-morena.vectranet.pl (109241207190.gdansk.vectranet.pl. [109.241.207.190])
        by smtp.gmail.com with ESMTPSA id m18sm3327243lfb.73.2019.10.13.05.51.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 13 Oct 2019 05:51:49 -0700 (PDT)
From:   Janusz Krzysztofik <jmkrzyszt@gmail.com>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>
Subject: [PATCH 5/6] media: ov6650: Drop unused .pclk_max field
Date:   Sun, 13 Oct 2019 14:50:49 +0200
Message-Id: <20191013125050.4153-6-jmkrzyszt@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191013125050.4153-1-jmkrzyszt@gmail.com>
References: <20191013125050.4153-1-jmkrzyszt@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This field of the driver private structure is no longer used, drop it.

Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
---
 drivers/media/i2c/ov6650.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/media/i2c/ov6650.c b/drivers/media/i2c/ov6650.c
index e95ea132ef06..f4723c0b5c70 100644
--- a/drivers/media/i2c/ov6650.c
+++ b/drivers/media/i2c/ov6650.c
@@ -197,7 +197,6 @@ struct ov6650 {
 	struct v4l2_clk		*clk;
 	bool			half_scale;	/* scale down output by 2 */
 	struct v4l2_rect	rect;		/* sensor cropping window */
-	unsigned long		pclk_max;	/* from resolution and format */
 	struct v4l2_fract	tpf;		/* as requested with s_frame_interval */
 	u32 code;
 };
@@ -618,17 +617,14 @@ static int ov6650_s_fmt(struct v4l2_subdev *sd, struct v4l2_mbus_framefmt *mf)
 			code == MEDIA_BUS_FMT_SBGGR8_1X8) {
 		coml_mask = COML_ONE_CHANNEL;
 		coml_set = 0;
-		priv->pclk_max = 4000000;
 	} else {
 		coml_mask = 0;
 		coml_set = COML_ONE_CHANNEL;
-		priv->pclk_max = 8000000;
 	}
 
 	if (half_scale) {
 		dev_dbg(&client->dev, "max resolution: QCIF\n");
 		coma_set |= COMA_QCIF;
-		priv->pclk_max /= 2;
 	} else {
 		dev_dbg(&client->dev, "max resolution: CIF\n");
 		coma_mask |= COMA_QCIF;
-- 
2.21.0

