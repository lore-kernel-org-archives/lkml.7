Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20F9BC4CED1
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 16:32:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC3E6215EA
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 16:32:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570120340;
	bh=PFmsVWFZwfpmAheslFDDoN3WmtOQ4A68VbTVliDI6Oc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=pgvrH6EOas4vUnfaX7sWy6KcqC09Nby04wxVrfsoPg7Xsaut4LVpce9dXbxzbTCvK
	 Y371wmYLpGPaFH0jTUqVPqtY/zntYQs/Z8WwLHOU+SvUPJaVPALwTIT9Hasmv8Z+LK
	 7VJaA/wFwVc9iMQZDAeWRrh79w7FdggQH9QgpOkU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390367AbfJCQcT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 12:32:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:39712 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391889AbfJCQcQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 12:32:16 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 253D421848;
        Thu,  3 Oct 2019 16:32:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570120335;
        bh=PFmsVWFZwfpmAheslFDDoN3WmtOQ4A68VbTVliDI6Oc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qdF/L0P47ywsBJkj8y0CSQL7w3Qj/6PrVHpk0g6fKrOp0cUlhq9frvrKXQDsAk112
         9nfSFYrD/K+S7LWycK5W95hvC9FVvQ2YKZPcAo0o6jeKN9C4VVDoKnncerVn3tLfju
         ZKQIhboX0jV37wFncH23faD0OOeaSjSdbEWNnNrc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Katsuhiro Suzuki <katsuhiro@katsuster.net>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.2 184/313] SoC: simple-card-utils: set 0Hz to sysclk when shutdown
Date:   Thu,  3 Oct 2019 17:52:42 +0200
Message-Id: <20191003154551.123149795@linuxfoundation.org>
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

From: Katsuhiro Suzuki <katsuhiro@katsuster.net>

[ Upstream commit 2458adb8f92ad4d07ef7ab27c5bafa1d3f4678d6 ]

This patch set 0Hz to sysclk when shutdown the card.

Some codecs set rate constraints that derives from sysclk. This
mechanism works correctly if machine drivers give fixed frequency.

But simple-audio and audio-graph card set variable clock rate if
'mclk-fs' property exists. In this case, rate constraints will go
bad scenario. For example a codec accepts three limited rates
(mclk / 256, mclk / 384, mclk / 512).

Bad scenario as follows (mclk-fs = 256):
   - Initialize sysclk by correct value (Ex. 12.288MHz)
     - Codec set constraints of PCM rate by sysclk
       48kHz (1/256), 32kHz (1/384), 24kHz (1/512)
   - Play 48kHz sound, it's acceptable
   - Sysclk is not changed

   - Play 32kHz sound, it's acceptable
   - Set sysclk to 8.192MHz (= fs * mclk-fs = 32k * 256)
     - Codec set constraints of PCM rate by sysclk
       32kHz (1/256), 21.33kHz (1/384), 16kHz (1/512)

   - Play 48kHz again, but it's NOT acceptable because constraints
     do not allow 48kHz

So codecs treat 0Hz sysclk as signal of applying no constraints to
avoid this problem.

Signed-off-by: Katsuhiro Suzuki <katsuhiro@katsuster.net>
Link: https://lore.kernel.org/r/20190907174501.19833-1-katsuhiro@katsuster.net
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/generic/simple-card-utils.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/soc/generic/simple-card-utils.c b/sound/soc/generic/simple-card-utils.c
index f4c6375d11c7a..ef1adf87cbc8b 100644
--- a/sound/soc/generic/simple-card-utils.c
+++ b/sound/soc/generic/simple-card-utils.c
@@ -224,10 +224,17 @@ EXPORT_SYMBOL_GPL(asoc_simple_startup);
 void asoc_simple_shutdown(struct snd_pcm_substream *substream)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_dai *codec_dai = rtd->codec_dai;
+	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
 	struct asoc_simple_priv *priv = snd_soc_card_get_drvdata(rtd->card);
 	struct simple_dai_props *dai_props =
 		simple_priv_to_props(priv, rtd->num);
 
+	if (dai_props->mclk_fs) {
+		snd_soc_dai_set_sysclk(codec_dai, 0, 0, SND_SOC_CLOCK_IN);
+		snd_soc_dai_set_sysclk(cpu_dai, 0, 0, SND_SOC_CLOCK_OUT);
+	}
+
 	asoc_simple_clk_disable(dai_props->cpu_dai);
 
 	asoc_simple_clk_disable(dai_props->codec_dai);
-- 
2.20.1



