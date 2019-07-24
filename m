Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E51DC7618B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 16:24:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24D372190F
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 16:24:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="tU0u8Kzo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728838AbfGXQYV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 12:24:21 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44028 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728780AbfGXQYR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 12:24:17 -0400
Received: by mail-wr1-f68.google.com with SMTP id p13so47623852wru.10
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2019 09:24:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UJ9KDGBOl8aIUqKuxRToZa5/dKJVoJYKCqFTu5LeV1A=;
        b=tU0u8Kzo4EqYFk+S/PB7XaSJUsAodzLIXYMpL2tWf18qebqFw73F789ZMYL9or9SsK
         dqKPqCfMrQm/8qtBnymmETaftmj2gXdDTqbZeXG94Gcn5Fb8vfeZiMuiL+siIEU4EZO/
         chX0PSxfTCfqr/6ho4HEP9cQJ2OvcSntdppRHBL7xpC02MhR5YZN537v2LeeBKtn3aS6
         B5HCEKhe4Bsa/xsFrKapjdoaJaoSFK7pS35WXAQ5rGtDx/6F5GLO3/LdkR2T/9mTXY2o
         RR5rolvIqI94A16zqWHC8eg7NqWQBgxATiaOGRqNE18Pf+VU9hDDWW9yyNX5nK4rWcRh
         S24Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UJ9KDGBOl8aIUqKuxRToZa5/dKJVoJYKCqFTu5LeV1A=;
        b=l8/tM+fn1FffhGBz+xVgprYiEspM2qXdRcUu7i19Zrg0XS78u1ZrAHwnJzJpaiUr4V
         ELQTXKktzb6PtpijR4fA8cRRL7RHnXX4WZzaGnFhlNRJz/ntm2t6VUGmYDPWviobKl+g
         BYJy9wQj3QfpFda3foa2drtUHPLOr73btVd+To3xo3gKFVPZ2Gy44ffsIBKLbMFQ9R8r
         VFF65CJ1hUlgi/TLsQqgL1OKXaj55mMCaz7PAwJbelSl8vMrUw6F4ca4Nye39yuKB+Fl
         byoZ6S+zYifImKst2SXeS76lqtCRgd4YZwP5005HV6uGmtpmenckzggUyQu3ZEpkeq9f
         JlFQ==
X-Gm-Message-State: APjAAAWLx2H/QaQ4k5DilpfsGSGqLSqL6ITo9argbfod4o00tedxt/x6
        CnhZMQIbvU00xqkXLtA9eIQDmA==
X-Google-Smtp-Source: APXvYqzsz5R+uA08ZspQl/NwiF9hq2F7Y6DPHaohqRpu1K0XA0Ds+ppWxCNxwgiM91KqJEfr0XmU8A==
X-Received: by 2002:adf:da4d:: with SMTP id r13mr57578825wrl.281.1563985455657;
        Wed, 24 Jul 2019 09:24:15 -0700 (PDT)
Received: from starbuck.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id f70sm55688960wme.22.2019.07.24.09.24.14
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 24 Jul 2019 09:24:15 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Kevin Hilman <khilman@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org
Subject: [PATCH 6/6] ASoC: codec2codec: fill some of the runtime stream parameters
Date:   Wed, 24 Jul 2019 18:24:05 +0200
Message-Id: <20190724162405.6574-7-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190724162405.6574-1-jbrunet@baylibre.com>
References: <20190724162405.6574-1-jbrunet@baylibre.com>
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Set the information provided struct snd_soc_pcm_stream in the
struct snd_pcm_runtime of the codec to codec link.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 sound/soc/soc-dapm.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index e0eedff5fe94..a6bc3eda275d 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -3892,6 +3892,11 @@ static int snd_soc_dai_link_event(struct snd_soc_dapm_widget *w,
 			dapm_update_dai_unlocked(substream, &params, sink);
 		}
 
+		runtime->format = params_format(&params);
+		runtime->subformat = params_subformat(&params);
+		runtime->channels = params_channels(&params);
+		runtime->rate = params_rate(&params);
+
 		break;
 
 	case SND_SOC_DAPM_POST_PMU:
-- 
2.21.0

