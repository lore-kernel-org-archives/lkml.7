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
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACCD9C04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 17:48:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85BA525DB6
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 17:48:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h5dZgeoI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729239AbfFCRsQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 13:48:16 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:40729 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725876AbfFCRrk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 13:47:40 -0400
Received: by mail-lf1-f68.google.com with SMTP id a9so12869913lff.7
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2019 10:47:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=d+gHoaqCUhQT6e1Ym0xN6NiXtzxs58xfZkboy1ldAY4=;
        b=h5dZgeoIw79Kv/1VWSq4u0iUmi8FcFdS5XaGrfJHimMztfcNh7dQVIiKTiQVrkFIDN
         tt/CEWjxMPtIutWCG+Qg+dtaAfT8RTFKodnxjVUm+CTtev6nBWMKe1yR60NbdJEjuLOi
         C+DB7NPOh7+CSv6DMZJCEVsOwd/i3pQcTjpXDt/Wn5ifvBjUm2lbprVhPFw0q4fsoiLr
         TcIXPDhB2iLwZP0At3Jw9MdR5dSfxgLEYObLerFRfewHaFrjRn6FKPzO7wIez3xx1ttZ
         7iqSRQDjsL6B1qv5AlpMCLWBsJs2IKTdBCpAA7J3Uno8uUTSJ1vnaWTAZheT04VtAZED
         0P2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=d+gHoaqCUhQT6e1Ym0xN6NiXtzxs58xfZkboy1ldAY4=;
        b=L157T4tViC3yD69RjJ1qwL9jX4Au04wTvfgMfJkWzEXAvqf/7revoJnrrrN6+aozFw
         gDdPsfFqTiaVu0cytlE4tMahnX2dEgtNpmMFL51cBCsD6HnOzjtrfHybB1nQTZorwZ+k
         597OZD8y6cg1X2MmkAsePtzKp3lLRMNe1flKs0F8hM95vqhaha5L/mb2opHHhURbAFOX
         qILXcjt+iWa8EkOAm+dsVISeXVpTYE2oDMYlmyoWBaPCQQm6j8b2UnajzSjTg/jIyPNR
         l7J9QMEyquuPJutQPAeYX6oIswgvWcN25ZOouJ17BCpxAT59qbepc0xmr/AaMEAeDhqN
         wWyw==
X-Gm-Message-State: APjAAAUjZH5UYo7xrVGiOmaM5i318/MEb6H8s8zVmxSgRINuSTjnPzur
        qu9njVevbIj0choCfE043yU=
X-Google-Smtp-Source: APXvYqwSvyGLQCwtw23kykXSMCtNcYtakfcNcaj9YVYmjqtrKle0F/xUggVT07pnNTUG4U0Miv6MBA==
X-Received: by 2002:ac2:5938:: with SMTP id v24mr4108075lfi.161.1559584059490;
        Mon, 03 Jun 2019 10:47:39 -0700 (PDT)
Received: from localhost.localdomain ([188.150.253.81])
        by smtp.gmail.com with ESMTPSA id n7sm2803532lfi.68.2019.06.03.10.47.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Jun 2019 10:47:38 -0700 (PDT)
From:   codekipper@gmail.com
To:     maxime.ripard@free-electrons.com, wens@csie.org,
        linux-sunxi@googlegroups.com
Cc:     linux-arm-kernel@lists.infradead.org, lgirdwood@gmail.com,
        broonie@kernel.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, be17068@iperbole.bo.it,
        Marcus Cooper <codekipper@gmail.com>
Subject: [PATCH v4 2/9] ASoC: sun4i-i2s: Add offset to RX channel select
Date:   Mon,  3 Jun 2019 19:47:28 +0200
Message-Id: <20190603174735.21002-3-codekipper@gmail.com>
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

Whilst testing the capture functionality of the i2s on the newer
SoCs it was noticed that the recording was somewhat distorted.
This was due to the offset not being set correctly on the receiver
side.

Signed-off-by: Marcus Cooper <codekipper@gmail.com>
---
 sound/soc/sunxi/sun4i-i2s.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
index 90bd3963d8ae..fd7c37596f21 100644
--- a/sound/soc/sunxi/sun4i-i2s.c
+++ b/sound/soc/sunxi/sun4i-i2s.c
@@ -456,6 +456,10 @@ static int sun4i_i2s_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 		regmap_update_bits(i2s->regmap, SUN8I_I2S_TX_CHAN_SEL_REG,
 				   SUN8I_I2S_TX_CHAN_OFFSET_MASK,
 				   SUN8I_I2S_TX_CHAN_OFFSET(offset));
+
+		regmap_update_bits(i2s->regmap, SUN8I_I2S_RX_CHAN_SEL_REG,
+				   SUN8I_I2S_TX_CHAN_OFFSET_MASK,
+				   SUN8I_I2S_TX_CHAN_OFFSET(offset));
 	}
 
 	regmap_field_write(i2s->field_fmt_mode, val);
-- 
2.21.0

