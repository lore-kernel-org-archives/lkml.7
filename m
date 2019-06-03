Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D00A3C04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 17:48:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A850325DB6
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 17:48:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ogrh9eTD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729007AbfFCRrn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 13:47:43 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:37940 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727649AbfFCRrk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 13:47:40 -0400
Received: by mail-lf1-f66.google.com with SMTP id b11so14298008lfa.5
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2019 10:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GjT900taG1ijSa9lWUX/G6V7gIXt/Ttjrhy2y92+ySQ=;
        b=Ogrh9eTDgQAUONxtoCEsmlhtx9p4ZZt29kbWmmfagH5K1N51dWWiwQXBmLQshGR8J8
         JaNQR+8WKr/MTf8K1xrO0Syb9jjiMj35sivUp6zm1jV3T/QuMpE6Dw6L+RD342txYebk
         NJV8ZHfOTYFNFDubmYUOXAbSAhy5J+kUkggW04A+6mKqqgGSxB3BC5kzw4qweIKUiWXc
         RWh6GQHeO7X8UFlW3a9oj4ZkCyHYFG6u8OIgykswrOARCeyPCclz+zAeg7NjyYx51bDx
         //dpzaNZ8IwgIk00p3O4Qkzp3RAjBuhVSNlUHZlOzqvOgVE12g4mWxUF53/MCmxYTpvE
         sw7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GjT900taG1ijSa9lWUX/G6V7gIXt/Ttjrhy2y92+ySQ=;
        b=JjfPipyjCk/seOse13dgyGq8U+5dMtLl4b2YfJWJZ11tCzoxU0bwgkMg0iw+lCtN7n
         oDRxP73hv72Tzvw0N36Kl6Z7kxFTdjD7R0YVgFvPc21B4Nn188V2dZVBnUJVy86ukaOf
         RUdnKqQnSC5TZ/gZyWDTkI8ORFIW2TYA/k8dDEheO7WtZNeRKdz+KuDU8mFbVpXSpqyJ
         osmWtTq8eQtUiWAbF5zPrVhQTngqceYSpltArJE7+g/Li3JQP/1V8/LDH2eEt5NQIDA+
         byXOqcx97gTcJrsCZo0nO/XqjEJHvQn9kOLsqQPsK4oLMhWD65WRIdsbOdNmw+EzkMqE
         acAg==
X-Gm-Message-State: APjAAAW+QJVQJkNDJIPoPjkpx1YdgxWCsC5pc5VJpzqvt0ikmN3d/ky6
        GeJkhOZYFVxW5Q3erZnuR8g=
X-Google-Smtp-Source: APXvYqymibEEWq50h1UhkT3XaRXxM5Grj6g5eLWzSPNypWuItCujKf4Kk6Dvxeq4YPayp2H9tk8i+A==
X-Received: by 2002:ac2:4c3c:: with SMTP id u28mr4407330lfq.136.1559584058502;
        Mon, 03 Jun 2019 10:47:38 -0700 (PDT)
Received: from localhost.localdomain ([188.150.253.81])
        by smtp.gmail.com with ESMTPSA id n7sm2803532lfi.68.2019.06.03.10.47.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Jun 2019 10:47:38 -0700 (PDT)
From:   codekipper@gmail.com
To:     maxime.ripard@free-electrons.com, wens@csie.org,
        linux-sunxi@googlegroups.com
Cc:     linux-arm-kernel@lists.infradead.org, lgirdwood@gmail.com,
        broonie@kernel.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, be17068@iperbole.bo.it,
        Marcus Cooper <codekipper@gmail.com>
Subject: [PATCH v4 1/9] ASoC: sun4i-i2s: Fix sun8i tx channel offset mask
Date:   Mon,  3 Jun 2019 19:47:27 +0200
Message-Id: <20190603174735.21002-2-codekipper@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190603174735.21002-1-codekipper@gmail.com>
References: <20190603174735.21002-1-codekipper@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcus Cooper <codekipper@gmail.com>

Although not causing any noticeable issues, the mask for the
channel offset is covering too many bits.

Signed-off-by: Marcus Cooper <codekipper@gmail.com>
---
 sound/soc/sunxi/sun4i-i2s.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
index c53bfed8d4c2..90bd3963d8ae 100644
--- a/sound/soc/sunxi/sun4i-i2s.c
+++ b/sound/soc/sunxi/sun4i-i2s.c
@@ -106,7 +106,7 @@
 
 #define SUN8I_I2S_TX_CHAN_MAP_REG	0x44
 #define SUN8I_I2S_TX_CHAN_SEL_REG	0x34
-#define SUN8I_I2S_TX_CHAN_OFFSET_MASK		GENMASK(13, 11)
+#define SUN8I_I2S_TX_CHAN_OFFSET_MASK		GENMASK(13, 12)
 #define SUN8I_I2S_TX_CHAN_OFFSET(offset)	(offset << 12)
 #define SUN8I_I2S_TX_CHAN_EN_MASK		GENMASK(11, 4)
 #define SUN8I_I2S_TX_CHAN_EN(num_chan)		(((1 << num_chan) - 1) << 4)
-- 
2.21.0

