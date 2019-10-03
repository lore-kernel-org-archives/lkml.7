Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74ADBC10F14
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 17:12:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D2142086A
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 17:12:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570122773;
	bh=sr+EgblRId/7wU5yaG1fEFxsM+CbrijiUWe8BT4QB5M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=o2nz3mCcW6FnkKDTHguDsHvopaffqmIILgKTYYzTTAyZtM4n6BTJ4DX8uZuKyBwlF
	 XIOjY8rHV0g+Q6TOebaT1C9PK6IBrfBVsu41qVNXjCDyMwi8gdxKFrKx8cpO1w+oAB
	 hizkPVa3N6rngB96gBU74iF5AMbAy0inz3QLy2ek=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404489AbfJCRMw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 13:12:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:35156 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390426AbfJCQ3h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 12:29:37 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1730520867;
        Thu,  3 Oct 2019 16:29:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570120176;
        bh=sr+EgblRId/7wU5yaG1fEFxsM+CbrijiUWe8BT4QB5M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NcI2LeZQrHbcWzY2Sll41POzDZA0PfUUlX/BxCDWow+Oroxc6b1fJ3tuecfM60XrC
         4OA+akrtiADBZ7+nX6yrteVjBN5ADWy0WF6t0IyK9wVpUKod0t24Tv9x81YxvwqnzA
         NoPNJLgUv7SDtEtiPPYUkw9/GZyl41MRfmGH5+0Y=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Maxime Ripard <maxime.ripard@bootlin.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.2 118/313] ASoC: sun4i-i2s: Dont use the oversample to calculate BCLK
Date:   Thu,  3 Oct 2019 17:51:36 +0200
Message-Id: <20191003154544.487329014@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191003154533.590915454@linuxfoundation.org>
References: <20191003154533.590915454@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Maxime Ripard <maxime.ripard@bootlin.com>

[ Upstream commit 7df8f9a20196072162d9dc8fe99943f2d35f23d5 ]

The BCLK divider should be calculated using the parameters that actually
make the BCLK rate: the number of channels, the sampling rate and the
sample width.

We've been using the oversample_rate previously because in the former SoCs,
the BCLK's parent is MCLK, which in turn is being used to generate the
oversample rate, so we end up with something like this:

oversample = mclk_rate / sampling_rate
bclk_div = oversample / word_size / channels

So, bclk_div = mclk_rate / sampling_rate / word_size / channels.

And this is actually better, since the oversampling ratio only plays a role
because the MCLK is its parent, not because of what BCLK is supposed to be.

Furthermore, that assumption of MCLK being the parent has been broken on
newer SoCs, so let's use the proper formula, and have the parent rate as an
argument.

Fixes: 7d2993811a1e ("ASoC: sun4i-i2s: Add support for H3")
Fixes: 21faaea1343f ("ASoC: sun4i-i2s: Add support for A83T")
Fixes: 66ecce332538 ("ASoC: sun4i-i2s: Add compatibility with A64 codec I2S")
Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
Link: https://lore.kernel.org/r/c3595e3a9788c2ef2dcc30aa3c8c4953bb5cc249.1566242458.git-series.maxime.ripard@bootlin.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/sunxi/sun4i-i2s.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
index fd7c37596f21a..1d946a1927088 100644
--- a/sound/soc/sunxi/sun4i-i2s.c
+++ b/sound/soc/sunxi/sun4i-i2s.c
@@ -219,10 +219,11 @@ static const struct sun4i_i2s_clk_div sun4i_i2s_mclk_div[] = {
 };
 
 static int sun4i_i2s_get_bclk_div(struct sun4i_i2s *i2s,
-				  unsigned int oversample_rate,
+				  unsigned long parent_rate,
+				  unsigned int sampling_rate,
 				  unsigned int word_size)
 {
-	int div = oversample_rate / word_size / 2;
+	int div = parent_rate / sampling_rate / word_size / 2;
 	int i;
 
 	for (i = 0; i < ARRAY_SIZE(sun4i_i2s_bclk_div); i++) {
@@ -312,8 +313,8 @@ static int sun4i_i2s_set_clk_rate(struct snd_soc_dai *dai,
 		return -EINVAL;
 	}
 
-	bclk_div = sun4i_i2s_get_bclk_div(i2s, oversample_rate,
-					  word_size);
+	bclk_div = sun4i_i2s_get_bclk_div(i2s, i2s->mclk_freq,
+					  rate, word_size);
 	if (bclk_div < 0) {
 		dev_err(dai->dev, "Unsupported BCLK divider: %d\n", bclk_div);
 		return -EINVAL;
-- 
2.20.1



