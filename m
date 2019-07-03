Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F7E8C0650E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 12:07:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF91C218B0
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 12:07:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="tSLd8Mxk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726550AbfGCMH4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 08:07:56 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:40419 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725847AbfGCMHz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 08:07:55 -0400
Received: by mail-wm1-f68.google.com with SMTP id v19so2094943wmj.5
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2019 05:07:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=58+wQHNFY1FZ9kJxcysuLiIfPy4FWwdFF39AnxV0wiw=;
        b=tSLd8MxkTDIPty1ZVy45elawWaFPNF6Jg+TYasAX7ii2/0G5N+lecXsA1agJGG7Bzj
         jTwgdSonkOIGaHbx6jnquaosIGpfBZ8Y3e//zVbY0zxRQiJJgwt8IITWTL5c88nVfC79
         WBDfT9KGTVQa8fGWOmd4MBKFx6l+VbHJ2IGT5pmP3PjoObMo2ZTeVYFCIn0nc1Q4CqIl
         UsF+Gy+vE4kEyuI/oIs+GSQKgJzE1O/YBWZx91bBoZJFigDpLfKgZDYFgVLdI4ukLrAP
         cV2AyhrXuRbrYceJ473DrvMJmtIXCxj26Fqgt9cqpd9yZpFmRa7NWLlAz9XNF/2pPL7M
         ejdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=58+wQHNFY1FZ9kJxcysuLiIfPy4FWwdFF39AnxV0wiw=;
        b=NeujZcDFswLaOP8D3vgNx0YrN65Hsa37wbQFYGkRuXTMVKdYj3AomyeyGNyjyDz39R
         8FTdGgR4pNqsPcDxrDhuKUNsm5hmCe1KA9xJ40BFxzpSq7Z2w9Rn+SefVb2/SuU7u62+
         NdQE9L2z63c5bsWIoI3lizPwJI2yeAAUpqyPqoIIaSJDJwF4gvG44HSIggDyhTT4ppVQ
         Vw4bd1x8Nn3GvWIgjBTywLgny77rgjGnqDUMpOantIUqC9pq8c4fSOY6S/DofKlimmKn
         +lC7edgd8VhmxjnVFSTQO+QwwelKvqVfYVemzBZWwLF6YcHnG5BGKbw6SUHighJFYeqC
         qnXw==
X-Gm-Message-State: APjAAAUuorBVY6reyjP3jio9+QjeMmDzZPWvHpGl6Rz8tUwj/RxBZfhd
        O4U2/FHEdGXCAg+exoGGcHJong==
X-Google-Smtp-Source: APXvYqyBMzzq4idwjAjHjTuoGLGjP+FyAOgZQbzeVCROJZPeqmJuXI+iq9gE/QUUnzONCZaeN9B1FQ==
X-Received: by 2002:a1c:96c7:: with SMTP id y190mr7250688wmd.87.1562155673832;
        Wed, 03 Jul 2019 05:07:53 -0700 (PDT)
Received: from starbuck.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id z126sm2767638wmb.32.2019.07.03.05.07.52
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 03 Jul 2019 05:07:53 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Kevin Hilman <khilman@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org
Subject: [PATCH 0/2] ASoC: meson: axg-tdm-formatter: add g12a reset
Date:   Wed,  3 Jul 2019 14:07:47 +0200
Message-Id: <20190703120749.32341-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset add the possibility to provide a reset to the tdm formatter.
Such reset is available on the g12a SoC family and helps solve a random
channel output shift when using more than one output lane.

Jerome Brunet (2):
  ASoC: meson: axg-tdm-formatter: add reset to the bindings
    documentation
  ASoC: meson: axg-tdm-formatter: add reset

 .../sound/amlogic,axg-tdm-formatters.txt      |  6 +++-
 sound/soc/meson/axg-tdm-formatter.c           | 29 +++++++++++++++++++
 2 files changed, 34 insertions(+), 1 deletion(-)

-- 
2.21.0

