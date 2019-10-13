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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FE88ECE587
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Oct 2019 12:51:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6919420869
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Oct 2019 12:51:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C/sf3c72"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729126AbfJMMvs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 13 Oct 2019 08:51:48 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:36397 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728349AbfJMMvr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Oct 2019 08:51:47 -0400
Received: by mail-lj1-f193.google.com with SMTP id v24so13989156ljj.3;
        Sun, 13 Oct 2019 05:51:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GwH1bhab1sw1PLO/SmssRFS41RXLVtjgRKzNjNOiz3c=;
        b=C/sf3c72FataPDhCvthO6mKqTv1T1r0Z9RKTgU2c4C4c6IBlfElcNIA3uaM8WWhLO2
         dInce+8yIlH+chanV7D/FoO6H4S2bQjR21ozfRnpgOMAphIEw0924rQmLlScEFAL1uPV
         8gxi5puYlNVbBBvHuj5xhfLshHp5k/rHnrYVIuhty/PE2H05j17U4lNYwZP/SglDyLpy
         iMfuUNBgSPlsgMUcwa4L9xeuwgW2pzTDdYMUh1kqHbqNbGU8cSkmRQ21o7mQRPTuMs32
         0VtRXnPD5jCpzrn0iItOFRSJ9TB/+v1Bx3m50FwG+Nvr+w3YQxeEgzM1YBk3yoHgTcW+
         XrpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GwH1bhab1sw1PLO/SmssRFS41RXLVtjgRKzNjNOiz3c=;
        b=UibLw7daK1w0mEUx+yEyyrzqkqZkczkoM1LzbPBjrBiavYZW+r+I98SgY2bvz+J4XZ
         ACx7Ypk1tVCZyr8ggmxaIHLSpjL1ZqmD5mtHQOBnSyREOC53dhg1MPrNtxQ8A4o9ArPT
         qvopynFX+kOj87QCwM1Suqm+Q9tgbcIs0aJXY/DRWlBQctdWsSrfMHM2tGrNt28ICMxp
         Uk5ySafZ1vdqebRPmG5uztBPdd6Es8pgsaB/5qTPuyqHkVZHCr/w1wqv/UdHH1DOCH5T
         HZyfkw9VrKZaETvxv5PvSgtb28N7okdBxmClQZ7Kl9c4SNR6tLDisRtUtBSjqWspLlCg
         4EqQ==
X-Gm-Message-State: APjAAAUMVRl85g7LYdJCPfIP2CerXLZpb/oIHuwthEQcIW1yHBycX/yE
        Nxrtgo10Ou81g4f4ebUi+34=
X-Google-Smtp-Source: APXvYqwYcNYCXpVXtK9tV9Z7ZoW4hOROqnNBmQhbnAgpEKZd6iYn3NMKAqv6NMsz79UpTbFg3DcYYQ==
X-Received: by 2002:a2e:9f08:: with SMTP id u8mr2272513ljk.124.1570971105258;
        Sun, 13 Oct 2019 05:51:45 -0700 (PDT)
Received: from z50.gdansk-morena.vectranet.pl (109241207190.gdansk.vectranet.pl. [109.241.207.190])
        by smtp.gmail.com with ESMTPSA id m18sm3327243lfb.73.2019.10.13.05.51.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 13 Oct 2019 05:51:44 -0700 (PDT)
From:   Janusz Krzysztofik <jmkrzyszt@gmail.com>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>
Subject: [PATCH 1/6] media: ov6650: Fix stored frame interval not in sync with hardware
Date:   Sun, 13 Oct 2019 14:50:45 +0200
Message-Id: <20191013125050.4153-2-jmkrzyszt@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191013125050.4153-1-jmkrzyszt@gmail.com>
References: <20191013125050.4153-1-jmkrzyszt@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver stores a frame interval value supposed to be in line with
hardware state in a device private structure.  Since the driver initial
submission, the respective field of the structure has never been
initialised on device probe.  Moreover, if updated from
.s_frame_interval(), a new value is stored before it is applied on
hardware.  If an error occurs during device update, the stored value
may no longer reflect hardware state and consecutive calls to
.g_frame_interval() may return incorrect information.

Assuming a failed update of the device means its actual state hasn't
changed, update the frame interval field of the device private
structure with a new value only after it is successfully applied on
hardware so it always reflects actual hardware state to the extent
possible.  Also, initialise the field with hardware default frame
interval on device probe.

Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
---
 drivers/media/i2c/ov6650.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/drivers/media/i2c/ov6650.c b/drivers/media/i2c/ov6650.c
index 16887049f0cd..f60aeb1f7813 100644
--- a/drivers/media/i2c/ov6650.c
+++ b/drivers/media/i2c/ov6650.c
@@ -130,6 +130,7 @@
 #define CLKRC_24MHz		0xc0
 #define CLKRC_DIV_MASK		0x3f
 #define GET_CLKRC_DIV(x)	(((x) & CLKRC_DIV_MASK) + 1)
+#define DEF_CLKRC		0x00
 
 #define COMA_RESET		BIT(7)
 #define COMA_QCIF		BIT(5)
@@ -783,19 +784,17 @@ static int ov6650_s_frame_interval(struct v4l2_subdev *sd,
 	else if (div > GET_CLKRC_DIV(CLKRC_DIV_MASK))
 		div = GET_CLKRC_DIV(CLKRC_DIV_MASK);
 
-	/*
-	 * Keep result to be used as tpf limit
-	 * for subsequent clock divider calculations
-	 */
-	priv->tpf.numerator = div;
-	priv->tpf.denominator = FRAME_RATE_MAX;
+	tpf->numerator = div;
+	tpf->denominator = FRAME_RATE_MAX;
 
-	clkrc = to_clkrc(&priv->tpf, priv->pclk_limit, priv->pclk_max);
+	clkrc = to_clkrc(tpf, priv->pclk_limit, priv->pclk_max);
 
 	ret = ov6650_reg_rmw(client, REG_CLKRC, clkrc, CLKRC_DIV_MASK);
 	if (!ret) {
-		tpf->numerator = GET_CLKRC_DIV(clkrc);
-		tpf->denominator = FRAME_RATE_MAX;
+		priv->tpf.numerator = GET_CLKRC_DIV(clkrc);
+		priv->tpf.denominator = FRAME_RATE_MAX;
+
+		*tpf = priv->tpf;
 	}
 
 	return ret;
@@ -1038,6 +1037,10 @@ static int ov6650_probe(struct i2c_client *client,
 	priv->rect.width  = W_CIF;
 	priv->rect.height = H_CIF;
 
+	/* Hardware default frame interval */
+	priv->tpf.numerator   = GET_CLKRC_DIV(DEF_CLKRC);
+	priv->tpf.denominator = FRAME_RATE_MAX;
+
 	priv->subdev.internal_ops = &ov6650_internal_ops;
 
 	ret = v4l2_async_register_subdev(&priv->subdev);
-- 
2.21.0

