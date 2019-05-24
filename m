Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C2C9C072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 14:03:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A5292081C
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 14:03:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="aDrFvuyR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403980AbfEXODZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 10:03:25 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33297 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403864AbfEXODY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 10:03:24 -0400
Received: by mail-wr1-f66.google.com with SMTP id d9so10179114wrx.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2019 07:03:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qAiP1kaATrLVhsYQVSGC57biP0RGHD32g8QSytysdio=;
        b=aDrFvuyRej7ZnCiuZ8EMAXzGNtl2fX4SmiUratwoNSiduKV5rOtpWZJxwj4yn/Y5yo
         O62Q5PrqQYB+nD0GdJKHqX+dZIwoezbHMQeJTUgK1gEUAazt8uf48hUnjXEwuegoBJRe
         xWGXStyAO3z91VrLk0sMwzlXcaRgVrW07FRBPtK4KkE2iVWmKBEjcBNYr96v2aJcPKAE
         jNUGuZcvouYDc4QcDqFzZcbpjfxz1M19bK1LJNd+9FLrREWQh1JHTJaGxE3WIJIcsFxF
         WQ1bcNgkR2xpJlN/2pokPxqssd0oDICj2uMCERSYBj3nUfgwLzQQ3qArQJHYMIuFRRcR
         PFpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qAiP1kaATrLVhsYQVSGC57biP0RGHD32g8QSytysdio=;
        b=o2AYXZIQy7Ds2o/rnVfvWe2yxZd+4y1BDf8oGLMiBzNZ+0h72zyWlmB6ccyaEv71gc
         FDycirfQa7exq9NStjf43Dy7v1rXC5A9gxGTX2Gd5HwHPpZW3ybuTJ9jMgZjviWpUIr+
         saBV5BkEoBhjq5yFe1TnmqJVoo95b8sEkNI7wCykN2WTF6EFzyCy58VnuWIl9gkVRx29
         gz8Mh1FHUFlZlH+wEoBbCfWmiCZpoVucrL48Tv4H3KteiDo60LztF0Ncde7YdAfP99Tc
         94Q6zh5r6nx+w6/5Ze1ET622QxoxYsiITXMrRM3zYNUOmq2NSrowql1Au2GDrZlPmdeo
         Kuxw==
X-Gm-Message-State: APjAAAVzmPFv/LgIdquxx8R+JTL0k/bh6C2t1rlozg1GwIrV8XWJk65n
        4ypaEbgO9nLbKdeheq2uSbVMJg==
X-Google-Smtp-Source: APXvYqzBVrbGf9H8H0xE3Tl8a6MHqOc8mGvBDzjxj+XxAWfcZRIriICIOhEBQ7bqUBsJ4PCl2qfiUA==
X-Received: by 2002:adf:f6c4:: with SMTP id y4mr37904326wrp.37.1558706602884;
        Fri, 24 May 2019 07:03:22 -0700 (PDT)
Received: from boomer.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id t7sm2797114wrq.76.2019.05.24.07.03.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 24 May 2019 07:03:22 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Kevin Hilman <khilman@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, devicetree@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] arm64: dts: meson: sei510: add sound card
Date:   Fri, 24 May 2019 16:03:16 +0200
Message-Id: <20190524140318.17608-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds the sound card of sei510 board.

Note #1:
The patchset (build) depends on the tohdmitx ASoC patch [0] for the dt
bindings of the tohdmitx glue. It also (run) depends on the mpll clock
series [1] to get a correct clock sources.

Note #2:
I would normaly prefer to use the HIFI pll dedicated to audio to provide
the base rate for the 48kHz audio family. HIFI pll rate precision is a
little bit better than the MPLL. However, the HIFI pll may sometimes,
rarely, take a long time to report a lock. I'm still debugging this.
In the mean time, let's use MPLL2 instead.

[0]: e35f5ad6a965 ("ASoC: meson: add tohdmitx DT bindings")
[1]: https://lkml.kernel.org/r/20190513123115.18145-1-jbrunet@baylibre.com

Jerome Brunet (1):
  arm64: dts: meson: sei510: add sound card

Maxime Jourdan (1):
  arm64: dts: meson: sei510: add max98357a DAC

 .../boot/dts/amlogic/meson-g12a-sei510.dts    | 207 ++++++++++++++++++
 1 file changed, 207 insertions(+)

-- 
2.20.1

