Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 612D3C10F14
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 21:43:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D55220833
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 21:43:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vVUKrlW+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728078AbfDHVn3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 17:43:29 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:42574 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727300AbfDHVnZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 17:43:25 -0400
Received: by mail-lj1-f193.google.com with SMTP id v22so12617991lje.9;
        Mon, 08 Apr 2019 14:43:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dapVIysTDyZCwZbl3QKUERGjrDSrapcmOu05WaEF+Qo=;
        b=vVUKrlW+MHCjzgLRsR79p9GnKX8WigbpLjV8YQ8y4x8R+SbRbTMwekeHOxPL4SU6A3
         RpKzxX+f7PecTdCKy8d23gKaUtJKUUOKB69yjMtuK1orEz4kPlQLR6CJuJve/GlPvP3f
         bEMQ6pZ8MAIrFrS93enDYvl8ic9CTyYG/dO+tuA4LIGHHj837tCCZdpQxgA4kdI9lUnn
         P1jrYUmRFkXaHNG+MQnPhrZ+xZnULx9y26bTdFz0VMLh6P7GagvVq3iqiIxRwdTT/Anx
         IG0k2D3fzzUaLquSU6db7XNyWdr1rM0Kv3EQ38IEesUTp5+Y3jPRQvchwFAjxwrDou7E
         y6uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dapVIysTDyZCwZbl3QKUERGjrDSrapcmOu05WaEF+Qo=;
        b=q0z+IbXv2MMQ/3FO1c0zGQFF9r6NM7AAowzp9LuYUMoc2naW9tZVpj5BEAMQL6WNCc
         vECqOO82ANDvpSh4eHhFSFmFCJZGhXSas0tU6blTwZRg+pSeDWxbjk4I7fEvBdSWw0J9
         M3MtubUQsgy4NO6npSkExhjiflB8brEErG0m4d1qumBAkk/KWFk7FwpMNRqs6/VTnxZN
         hOSsG2dW6nnXpk1d1Tis6RZd0ihZ42vtLEklcrQnJS9bQKqVySN1NYdWoXnR/0tzo9eo
         je0T02oDJ2nujrBN1IQ2qlAspdU67Qj5LuWHNO7SB9PANBEhmAI9rnuXm2HCvlz5/ifU
         4TBQ==
X-Gm-Message-State: APjAAAWz+YpvRvQX/CyVPMFPKseBKdeKO/wQE3O4+sIPMKmW9dJ29SLN
        Y2WJ+ZJ741jUY71TnW6fJg4=
X-Google-Smtp-Source: APXvYqwQjD+eFot/DZwg5Hix3eiJughBLRJPJM790tkpcULc5G3bqKMeuvaBYN/SR5Cj3PixO+RqFg==
X-Received: by 2002:a2e:86c7:: with SMTP id n7mr13163553ljj.44.1554759802787;
        Mon, 08 Apr 2019 14:43:22 -0700 (PDT)
Received: from z50.gdansk-morena.vectranet.pl (109241207190.gdansk.vectranet.pl. [109.241.207.190])
        by smtp.gmail.com with ESMTPSA id j6sm5286048ljc.0.2019.04.08.14.43.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Apr 2019 14:43:22 -0700 (PDT)
From:   Janusz Krzysztofik <jmkrzyszt@gmail.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Janusz Krzysztofik <jmkrzyszt@gmail.com>
Subject: [PATCH 13/14] media: ov6650: Fix stored frame format not in sync with hardware
Date:   Mon,  8 Apr 2019 23:42:41 +0200
Message-Id: <20190408214242.9603-14-jmkrzyszt@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190408214242.9603-1-jmkrzyszt@gmail.com>
References: <20190408214242.9603-1-jmkrzyszt@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver stores frame format settings supposed to be in line with
hardware state in a device private structure.  Since the driver initial
submission, those settings are updated before they are actually applied
on hardware.  If an error occurs on device update, the stored settings
my not reflect hardware state anymore and consecutive calls to
.get_fmt() may return incorrect information.  That in turn may affect
ability of a host device to use correct DMA transfer settings if such
incorrect informmation on active frame format returned by .get_fmt() is
used.

Assuming a failed device update means its state hasn't changed, update
frame format related settings stored in the device private structure
only after they are successfully applied so the stored values always
reflect hardware state as closely as possible.

Fixes: 2f6e2404799a ("[media] SoC Camera: add driver for OV6650 sensor")
Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
Cc: stable@vger.kernel.org
---
 drivers/media/i2c/ov6650.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/media/i2c/ov6650.c b/drivers/media/i2c/ov6650.c
index 8013afea0c02..001457d39742 100644
--- a/drivers/media/i2c/ov6650.c
+++ b/drivers/media/i2c/ov6650.c
@@ -643,7 +643,6 @@ static int ov6650_s_fmt(struct v4l2_subdev *sd, struct v4l2_mbus_framefmt *mf)
 		dev_err(&client->dev, "Pixel format not handled: 0x%x\n", code);
 		return -EINVAL;
 	}
-	priv->code = code;
 
 	if (code == MEDIA_BUS_FMT_Y8_1X8 ||
 			code == MEDIA_BUS_FMT_SBGGR8_1X8) {
@@ -664,7 +663,6 @@ static int ov6650_s_fmt(struct v4l2_subdev *sd, struct v4l2_mbus_framefmt *mf)
 		dev_dbg(&client->dev, "max resolution: CIF\n");
 		coma_mask |= COMA_QCIF;
 	}
-	priv->half_scale = half_scale;
 
 	clkrc = CLKRC_12MHz;
 	mclk = 12000000;
@@ -682,8 +680,13 @@ static int ov6650_s_fmt(struct v4l2_subdev *sd, struct v4l2_mbus_framefmt *mf)
 		ret = ov6650_reg_rmw(client, REG_COMA, coma_set, coma_mask);
 	if (!ret)
 		ret = ov6650_reg_write(client, REG_CLKRC, clkrc);
-	if (!ret)
+	if (!ret) {
+		priv->half_scale = half_scale;
+
 		ret = ov6650_reg_rmw(client, REG_COML, coml_set, coml_mask);
+	}
+	if (!ret)
+		priv->code = code;
 
 	return ret;
 }
-- 
2.21.0

