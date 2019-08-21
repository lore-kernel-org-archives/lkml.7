Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07CDFC3A5A0
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 16:23:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D11A122CE3
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 16:23:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ICtotNKT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729220AbfHUQX0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 12:23:26 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:33289 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726857AbfHUQXZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 12:23:25 -0400
Received: by mail-lj1-f193.google.com with SMTP id z17so2747266ljz.0
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2019 09:23:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Xf/6rfwEQrp0EASftgj20EORMnDX6q6RijKIZ+q88Yw=;
        b=ICtotNKToutmkB9nQx4VfVASkgYOePOm5hNb5a50PjlQSPE8U/q7rMyR8+baLwJ3Mh
         CmpM2az23gX4d8pJXVnKdTcEVV5StqRg0ruKCqRAncp2kVvhsU4v3rGns4QcMHPGpGs5
         deDw2MMACqpkGH3EHbsJAgMnM/SgXO8eGr9MFODIg4AmcObsh9VgNuXKDMCs6mH+DPp6
         OlgeHmCNiCs25WSbUJ9eRVzUAUmkug7RfCE7G2UOBfyqv/4fdTT9kN9e1Y0TjSryV7fg
         h9O7TGJclq3r9cvz35xXkPFCC2stimMZxKZjFNm8rBNgSSGlacZrGpFEUCUKk3vUPDFx
         qDeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Xf/6rfwEQrp0EASftgj20EORMnDX6q6RijKIZ+q88Yw=;
        b=V9KmJbYKbtZiAMOG4K5iJNS0xWnajKNGKpOOZqpCuE3cjVvROVvEsBZEmrTaGD827O
         e/lDkzoqlXRw6xCKiuQS4aSD5yWI5qi2za1mytcQAP+TSprx2Wwa4Y3UlDFaUAe4Je32
         9EM5e64kfLbnQVrKNWFqlgTvccAF1LnCqgrK8Cw4AlJyi2WHCQeL+EWkPguOHmiHJsh4
         yVw5dRDYuLkr0jHE1HfPJfq0Wxka9h0HNslLlOJlenzWZWTdfZlonZUpDzumSnv6PK/y
         YoxsYu9eFZK+/aPKVdhBjevzZkgZTXLAI3EOPUSGy8+cfOLd2V7RqYoRIfRAGA1tvL0U
         sI7Q==
X-Gm-Message-State: APjAAAW/f8s6iYUAbH7Nu3i73RJMSX8Kboen3EW2E69JJ9gtPjZ5DBGb
        Wkm8Ux6g69AGcVSuipBgM/Y=
X-Google-Smtp-Source: APXvYqw0Y5MwdTrgHht2bigyxlj2q89zbpnhdEqIAMmmgkr3ySoVRKSHKJT1agiTNTA6HqwVbhHygw==
X-Received: by 2002:a05:651c:1a7:: with SMTP id c7mr19081216ljn.89.1566404602914;
        Wed, 21 Aug 2019 09:23:22 -0700 (PDT)
Received: from localhost.localdomain (c213-102-74-69.bredband.comhem.se. [213.102.74.69])
        by smtp.gmail.com with ESMTPSA id n9sm1867681ljj.62.2019.08.21.09.23.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2019 09:23:21 -0700 (PDT)
From:   codekipper@gmail.com
To:     mripard@kernel.org, wens@csie.org, linux-sunxi@googlegroups.com
Cc:     linux-arm-kernel@lists.infradead.org, lgirdwood@gmail.com,
        broonie@kernel.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, be17068@iperbole.bo.it,
        Marcus Cooper <codekipper@gmail.com>
Subject: [PATCH] ASoC: sun4i-i2s: incorrect regmap for A83t
Date:   Wed, 21 Aug 2019 18:23:20 +0200
Message-Id: <20190821162320.28653-1-codekipper@gmail.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcus Cooper <codekipper@gmail.com>

Fixes: 21faaea1343f ("ASoC: sun4i-i2s: Add support for A83T")
Signed-off-by: Marcus Cooper <codekipper@gmail.com>
---
 sound/soc/sunxi/sun4i-i2s.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
index cbc6e59aa089..056a299c03fb 100644
--- a/sound/soc/sunxi/sun4i-i2s.c
+++ b/sound/soc/sunxi/sun4i-i2s.c
@@ -1109,7 +1109,7 @@ static const struct sun4i_i2s_quirks sun6i_a31_i2s_quirks = {
 static const struct sun4i_i2s_quirks sun8i_a83t_i2s_quirks = {
 	.has_reset		= true,
 	.reg_offset_txdata	= SUN8I_I2S_FIFO_TX_REG,
-	.sun4i_i2s_regmap	= &sun4i_i2s_regmap_config,
+	.sun4i_i2s_regmap	= &sun8i_i2s_regmap_config,
 	.field_clkdiv_mclk_en	= REG_FIELD(SUN4I_I2S_CLK_DIV_REG, 8, 8),
 	.field_fmt_wss		= REG_FIELD(SUN4I_I2S_FMT0_REG, 0, 2),
 	.field_fmt_sr		= REG_FIELD(SUN4I_I2S_FMT0_REG, 4, 6),
-- 
2.23.0

