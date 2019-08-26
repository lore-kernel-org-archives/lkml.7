Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01F77C3A59F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 18:07:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBE0922CED
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 18:07:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EgvQISlK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387675AbfHZSHm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 14:07:42 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:36971 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732525AbfHZSHk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 14:07:40 -0400
Received: by mail-lf1-f67.google.com with SMTP id w67so4831162lff.4
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2019 11:07:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/JiaxK/MezpMCfRnwIhrVE4IjsVGzm6Nc+QZ48CrwOY=;
        b=EgvQISlKJ+5es9A7LQNq8YnjzB6ejn9iKFaSRGei+/ko/Yjunes3Znum8wo5UnxF2Z
         Lz3PC6TCzXPQrogqz+mh3pSChnbCcndR6u0HBdD0n+vohJBgqkIZk719s9zvhhuW1HP3
         5HeMxENPm0LECvwvf/t0HXvBT9WgLhQEp5jUp8q4CRaopGDRFdctsx1PR/ttozm+/n/g
         3uYoHXVB8CCSEl3QkoRrbw8UHsTFhX/5x4Lv3+mGx1XPfT8Y+h/AkJN8q1p57iCO8EWv
         4xsX4dL2ZDGxcO6Usje9s1b2Y7lhJoT1lislmHWIKcK9hBu05ewqcKYUkMQvliw5WLy8
         sSFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/JiaxK/MezpMCfRnwIhrVE4IjsVGzm6Nc+QZ48CrwOY=;
        b=j31KBy3ryygdQRQBWXRIIey6iiU72pXcVW8nyY1Pyhje/2Na9ezjAHocN1w0vMQz7V
         AMrgi6Ga77/xOCuwscbegvFJhc8gjsTyaXM4eXBCN6sxIHLjBbSZWy9GZ5s7K8vMY2pb
         pzYGO2f/k4k1HFUiZZVItx/nnIjVCE4y2NZ8QJy3ElX23KFzcZelCPhnOS6r51+DY0DH
         Pnc5X5AHpWpGA7a6z/iUGSoebX10D+f/TRWWCTm0YouHvOuH0/8k2Arkl36k9aGpAfoT
         MP0a1E+I9dbUzYfQ9i2cx4+MDYRVxbqQ2Wdor6tk3o/svF9w+InTt5W1rJ1unTQ6C9/i
         a66w==
X-Gm-Message-State: APjAAAWopWy9JsinU3IEcKf4idv6Oezi/KaV19J3IokASnJNG9ndWzdV
        E57xCUEFmVbCAEZt/TyFCJM=
X-Google-Smtp-Source: APXvYqzvwQEeLDNp/oEFJY/UIHzL09RuXN5pNsb/Lcsmp9zAEJz0rTV9pQLcZzBHFdtOCEO3bmOhPg==
X-Received: by 2002:ac2:5939:: with SMTP id v25mr11839754lfi.115.1566842858249;
        Mon, 26 Aug 2019 11:07:38 -0700 (PDT)
Received: from localhost.localdomain (c213-102-74-69.bredband.comhem.se. [213.102.74.69])
        by smtp.gmail.com with ESMTPSA id u3sm2215564lfm.16.2019.08.26.11.07.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2019 11:07:37 -0700 (PDT)
From:   codekipper@gmail.com
To:     mripard@kernel.org, wens@csie.org, linux-sunxi@googlegroups.com
Cc:     linux-arm-kernel@lists.infradead.org, lgirdwood@gmail.com,
        broonie@kernel.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, be17068@iperbole.bo.it,
        Marcus Cooper <codekipper@gmail.com>
Subject: [PATCH v6 1/3] ASoC: sun4i-i2s: incorrect regmap for A83T
Date:   Mon, 26 Aug 2019 20:07:32 +0200
Message-Id: <20190826180734.15801-2-codekipper@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190826180734.15801-1-codekipper@gmail.com>
References: <20190826180734.15801-1-codekipper@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcus Cooper <codekipper@gmail.com>

The regmap configuration is set up for the legacy block on the
A83T whereas it uses the new block with a larger register map.

Fixes: 21faaea1343f ("ASoC: sun4i-i2s: Add support for A83T")
Signed-off-by: Marcus Cooper <codekipper@gmail.com>
---
 sound/soc/sunxi/sun4i-i2s.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
index 57bf2a33753e..34575a8aa9f6 100644
--- a/sound/soc/sunxi/sun4i-i2s.c
+++ b/sound/soc/sunxi/sun4i-i2s.c
@@ -1100,7 +1100,7 @@ static const struct sun4i_i2s_quirks sun6i_a31_i2s_quirks = {
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

