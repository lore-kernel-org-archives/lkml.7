Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A66AC606BD
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 15:31:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2970720665
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 15:31:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562599908;
	bh=ixDuyIVwNBlt4I/Il/74gIWl5jtN2lUC4ax7LQpxNAc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=VT376YADF7srrLtCM+vduzbTRQD7n+C8mZqp2ABL3oqdU+KMVVvYsIhpALxNva1Yf
	 8Vb33RGh+VhGl+u1N7EruQkr5pcnE/EeHz+lV+nn5B10B2Aq1oy5ehlGYPSz6Py55R
	 sEaZC87HEDgstkyR95TqxqAmfgtAnv1IRXKrXHW8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389973AbfGHPbr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 11:31:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:32942 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389949AbfGHPbk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 11:31:40 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 092A8216C4;
        Mon,  8 Jul 2019 15:31:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562599899;
        bh=ixDuyIVwNBlt4I/Il/74gIWl5jtN2lUC4ax7LQpxNAc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JIoqud/C3i+qUWO8qAYxG5xkLFmi3uPKaCZphnScV2UloPcqbk2fQOn63Whvz2l+U
         v0WRQ5HSEJXvF9yIsVEtUgWxSnfKAL4AZjSzBIqKlJZ4KJgiM7IYxzOwIj6ESQEg2u
         rOhSTBUhNpZEutV3HUGjA1VWaOjA3C1nzJ/c6Heg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Marcus Cooper <codekipper@gmail.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.1 26/96] ASoC: sun4i-i2s: Add offset to RX channel select
Date:   Mon,  8 Jul 2019 17:12:58 +0200
Message-Id: <20190708150527.914983492@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190708150526.234572443@linuxfoundation.org>
References: <20190708150526.234572443@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit f9927000cb35f250051f0f1878db12ee2626eea1 ]

Whilst testing the capture functionality of the i2s on the newer
SoCs it was noticed that the recording was somewhat distorted.
This was due to the offset not being set correctly on the receiver
side.

Signed-off-by: Marcus Cooper <codekipper@gmail.com>
Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>
Acked-by: Chen-Yu Tsai <wens@csie.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/sunxi/sun4i-i2s.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
index 8162e107e50b..bc128e2a6096 100644
--- a/sound/soc/sunxi/sun4i-i2s.c
+++ b/sound/soc/sunxi/sun4i-i2s.c
@@ -460,6 +460,10 @@ static int sun4i_i2s_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
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
2.20.1



