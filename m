Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C755AC04AB3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 20:10:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9ED3E2133F
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 20:10:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GLpFAL4w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727242AbfE0UKV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 16:10:21 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:52243 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726346AbfE0UKR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 16:10:17 -0400
Received: by mail-wm1-f65.google.com with SMTP id y3so531325wmm.2;
        Mon, 27 May 2019 13:10:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=t6VdND5amN3StrhVc/zIi7Y91LySYgcr3YUPE2udaNw=;
        b=GLpFAL4wu2OrqSDvxzgInDtXCuimTNOqaHJziuaMoWOTVLMYBrJEbzRCGIVqQinpIS
         xeY0389EDmZ4JpQYjVNdRo2DtKE9/Sje54FrxlxZOIAZjV5knm+sTOp68PqqNyDPvRM0
         uUlLytSd2Zs/FxFU282CMHz4nx3Ha+th8GVF+13SuZEv+hndX+zmy/6zrIN3IOvfl3nN
         ESYjm3YPKgBkqSRFMUY0WbkxdAwez86GmY6zf4rd+HFypmxYWV4uBcLvxwwLmC1CKgQ/
         Giaiz+t2+C6sdmd3naO9c85x13RVAeqjMaFoN5fgp9LGewHYfwcRQNUvtO1D1lfa/zyB
         ivog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=t6VdND5amN3StrhVc/zIi7Y91LySYgcr3YUPE2udaNw=;
        b=WA35Wo6ppS8WVqd1k//OEshHG9Gcj64r+CbgN9O31/xcBm55cSMCZ7VDl8ifO+i0qM
         20Qd6YexzjPfV6EvheZ/tabmpQ2wna9Cc1s2X5AWOTH0lYtA8d0VtkIyV28aP+QRU+Z4
         TtBwRQig/+A2yZowjYWPJvhT/r5G0DFgc791XjNx4IhGyDaderh3LBy3FjGTxOa1btR6
         DnZ1aSUJGs8f/6Xf6Z85FaLLwXFN9J2BUgyFIZJlITuCzNIDTZ3acfUegfR+aO7mIn9o
         YtU5CRU5TlAKgCUN/1z0PfQMVAlemeUk58+ggNOk+mCebLESW+eRkubLBgWTVgOoppie
         Bsyg==
X-Gm-Message-State: APjAAAUdnVMNmDF62w5e0DiZsPsqODubgKpjhot90itlkDd+J3MBfXWj
        oxnvPv1nK0Lf1w/z96Gd7pg=
X-Google-Smtp-Source: APXvYqwhDPRjhw9OpYYCmRvpl9ZRKHy8xPORapsR6gjT3JrkGdCqImbpQ0zkOtaRtG4S2cd9sPO+9w==
X-Received: by 2002:a7b:c549:: with SMTP id j9mr453146wmk.122.1558987814935;
        Mon, 27 May 2019 13:10:14 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:1f1:d0f0::4e2b:d7ca])
        by smtp.gmail.com with ESMTPSA id s127sm308523wmf.48.2019.05.27.13.10.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 May 2019 13:10:13 -0700 (PDT)
From:   =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Jagan Teki <jagan@amarulasolutions.com>
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Subject: [PATCH v4 2/7] ASoC: sun4i-spdif: Move quirks to the top
Date:   Mon, 27 May 2019 22:06:22 +0200
Message-Id: <20190527200627.8635-3-peron.clem@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190527200627.8635-1-peron.clem@gmail.com>
References: <20190527200627.8635-1-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The quirks are actually defines in the middle of the file with
short explanation.

Move this at the top and add a section to have coherency with
sun4i-i2s.

Signed-off-by: Clément Péron <peron.clem@gmail.com>
Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>
---
 sound/soc/sunxi/sun4i-spdif.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/sound/soc/sunxi/sun4i-spdif.c b/sound/soc/sunxi/sun4i-spdif.c
index b4af4aabead1..b6c66a62e915 100644
--- a/sound/soc/sunxi/sun4i-spdif.c
+++ b/sound/soc/sunxi/sun4i-spdif.c
@@ -161,6 +161,17 @@
 #define SUN4I_SPDIF_SAMFREQ_176_4KHZ		0xc
 #define SUN4I_SPDIF_SAMFREQ_192KHZ		0xe
 
+/**
+ * struct sun4i_spdif_quirks - Differences between SoC variants.
+ *
+ * @reg_dac_tx_data: TX FIFO offset for DMA config.
+ * @has_reset: SoC needs reset deasserted.
+ */
+struct sun4i_spdif_quirks {
+	unsigned int reg_dac_txdata;
+	bool has_reset;
+};
+
 struct sun4i_spdif_dev {
 	struct platform_device *pdev;
 	struct clk *spdif_clk;
@@ -405,11 +416,6 @@ static struct snd_soc_dai_driver sun4i_spdif_dai = {
 	.name = "spdif",
 };
 
-struct sun4i_spdif_quirks {
-	unsigned int reg_dac_txdata;	/* TX FIFO offset for DMA config */
-	bool has_reset;
-};
-
 static const struct sun4i_spdif_quirks sun4i_a10_spdif_quirks = {
 	.reg_dac_txdata	= SUN4I_SPDIF_TXFIFO,
 };
-- 
2.20.1

