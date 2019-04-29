Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05F14C43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 13:30:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6EBF21530
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 13:30:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="ns9DV7vl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728319AbfD2NaR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 09:30:17 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:55250 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725838AbfD2N3w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 09:29:52 -0400
Received: by mail-wm1-f68.google.com with SMTP id b10so759215wmj.4
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2019 06:29:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jguxe++uQg1Tg16qsCOT2xdBZ2LoE15AQChE753+pog=;
        b=ns9DV7vl1GqOrO/l7Pw/dLmy4NgN3/x795IBIKZ+BKXrvNhko8jL+GoCk33SLpy7nF
         GphkEdLsA1stWrdCKWx20VUWt0I8WUBc+s7fvJgfBs1SeB61JEkA1oxNmTRIluXP87g5
         xJtw8WLKxGjC2bFqvsAiFkZtMyKHE4MJdov2el5ZY2sbLNkl/K52f9Xitk383AEiq/Ht
         ZIIYkFr4XvTxV8WamLucfoPYlelow6AmwOej3EUaHz4AebYx52vKuwUdQyv+BoZTmUjB
         ndUGecFTHr8UYRamWk0vJP6sQLfC4pLm9TnIcemJ8aIKRqoZU3wZhZaghTXBIXLZc0sk
         BaSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jguxe++uQg1Tg16qsCOT2xdBZ2LoE15AQChE753+pog=;
        b=SWUAvLmJ1fwkwKz323uKIPJDnw906flAiERE+rRVeXoiThJ3ykeRkS9eCO67lad+M4
         rwRjHQ9hUu24im5Qj7XWmKlTpA1mt4Gp0e55d36c0bLOPCTyLNHsMAgq8ULMnVUygT0b
         +cfE/AS6PU/qhXQiJ1zZ+VDTPiBgz57Lun/DksDDuSEV7shz+aA5iwyDGIiNIhu/t90f
         un0VT1RTHaq2bENTyTimq5X1WcVmTg15dHM2QXJz0SMICBy+5Umv+SuLnbwe8ZoLushw
         0cIjOmp5aYqI82PMbS+Z6TZ6LkMlRdVWPK/GVUFWdzKHMbmB14xS8DPrSXTNdsPyRTOR
         0KQg==
X-Gm-Message-State: APjAAAVbduYZ8J6h4kbNQSFmYI6KdytoILkjYO2Vl6kXl/dYlPziGR21
        YwTCalJp1VQnsqxCiRxsLELyGQ==
X-Google-Smtp-Source: APXvYqznEB34S8Y0R3lfnUYKt0vBonlD/vhA5qe5px4C4oql/IzQD3R62u57tqApFNuPCVB1fZfEEQ==
X-Received: by 2002:a7b:ce84:: with SMTP id q4mr18135443wmj.41.1556544590406;
        Mon, 29 Apr 2019 06:29:50 -0700 (PDT)
Received: from boomer.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id s17sm2857593wra.94.2019.04.29.06.29.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 29 Apr 2019 06:29:49 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, patchwork-bot+notify@kernel.org
Subject: [PATCH 2/6] ASoC: hdmi-codec: unlock the device on startup errors
Date:   Mon, 29 Apr 2019 15:29:39 +0200
Message-Id: <20190429132943.16269-3-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190429132943.16269-1-jbrunet@baylibre.com>
References: <20190429132943.16269-1-jbrunet@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the hdmi codec startup fails, it should clear the current_substream
pointer to free the device. This is properly done for the audio_startup()
callback but for snd_pcm_hw_constraint_eld().

Make sure the pointer cleared if an error is reported.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 sound/soc/codecs/hdmi-codec.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/hdmi-codec.c b/sound/soc/codecs/hdmi-codec.c
index 9dca24732069..4bd598253c62 100644
--- a/sound/soc/codecs/hdmi-codec.c
+++ b/sound/soc/codecs/hdmi-codec.c
@@ -437,8 +437,12 @@ static int hdmi_codec_startup(struct snd_pcm_substream *substream,
 		if (!ret) {
 			ret = snd_pcm_hw_constraint_eld(substream->runtime,
 							hcp->eld);
-			if (ret)
+			if (ret) {
+				mutex_lock(&hcp->current_stream_lock);
+				hcp->current_stream = NULL;
+				mutex_unlock(&hcp->current_stream_lock);
 				return ret;
+			}
 		}
 		/* Select chmap supported */
 		hdmi_codec_eld_chmap(hcp);
-- 
2.20.1

