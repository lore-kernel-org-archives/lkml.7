Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 559D8C32750
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 12:33:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28482216F4
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 12:33:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="TSTYHZac"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728549AbfHLMdA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 08:33:00 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36160 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726424AbfHLMc7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 08:32:59 -0400
Received: by mail-wr1-f65.google.com with SMTP id r3so10669652wrt.3
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2019 05:32:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Nr8iX58l/pylFA11X0pfxij8SKgcdcbQ3mPsulHOLOw=;
        b=TSTYHZacvPBZRPOGOkxNmW9UwYDLYQIJpf0XtATvpOeYqCrXMPefQnRcRIJ7HPJlnb
         /3QsD43K5VNs4j/tgWMwF+admBA2wrJDJ5g4yQGP8nPI+uuDVxOiyuhxlW+nqh1XX4UL
         r9iQUW1yvHwoDz09Auy0e3mOyybZGpRccN7ORw1Ivw4LxzHWpBbHjkQYhL1b4Slsz1ZA
         by3d9kx+/1h602zfcj61H8MqdxJP6HF4QiJEfVdn0MgsH95jUI856gTFHUNiYC0Ykbof
         eFzmWVaoqdEVqaLTaQneOFEH1xhsZNY35BDL9N5aC1m4Wz/PcdYC2+mU0RCrs0556DHQ
         NhMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Nr8iX58l/pylFA11X0pfxij8SKgcdcbQ3mPsulHOLOw=;
        b=NRGABPAVPMtcoCo3HqBSlZopN+9DhyxEZ3xnNEgrX59XKRhJS5rLvjjZO1BCHdVdwz
         JvA91vBjxuMFyeOT9FQSAu63aNHJ5sHQWeBLIvBjxTLDmos4nyChOQes4MXlIqeEVLVb
         jlTpw/5KcXqKBtlXDa9svu4U5SlFfWI3oMh2Nshz8uAA/2LHZp63+aYpJ7u4VudZM55t
         MfOm3gboFkqGLFkcWaVGIDxVBZvkZpuiX6EjXC2IDErxJTDPtpf4G1iqzmDGYZ147FTo
         n2m5O2Etr6enI2HSqJ8osuexVlgKH7WW/OTG7ZuzVThWRsfqZG6VIT4LsieslwswNyzK
         04Bg==
X-Gm-Message-State: APjAAAWxawF2z8rcuMaNbXmOkF21j7AyYlPSoCZk13mR4lfGluByguhT
        aCcCFrU86+g5W/2HYdeasc21OQ==
X-Google-Smtp-Source: APXvYqx9Q+ux5GFsRAjfYY9EDz5s7kgz3ZmgnTcN7772qjvFYGrIolvNNUxhgaoQ+kq04Vg7URWh2g==
X-Received: by 2002:adf:c613:: with SMTP id n19mr40465331wrg.109.1565613177657;
        Mon, 12 Aug 2019 05:32:57 -0700 (PDT)
Received: from starbuck.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id z6sm15886432wre.76.2019.08.12.05.32.56
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 12 Aug 2019 05:32:57 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] clk: meson: axg-audio: add reset support
Date:   Mon, 12 Aug 2019 14:32:51 +0200
Message-Id: <20190812123253.4734-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds support for the reset provided in the register space
of the g12a audio clock controller

Changes since v1 [0]:
* Fix typo reported by Stephen

[0]: https://lkml.kernel.org/r/20190703122614.3579-1-jbrunet@baylibre.com

Jerome Brunet (2):
  dt-bindings: clock: meson: add resets to the audio clock controller
  clk: meson: axg-audio: add g12a reset support

 .../bindings/clock/amlogic,axg-audio-clkc.txt |   1 +
 drivers/clk/meson/axg-audio.c                 | 107 +++++++++++++++++-
 drivers/clk/meson/axg-audio.h                 |   1 +
 .../reset/amlogic,meson-g12a-audio-reset.h    |  38 +++++++
 4 files changed, 145 insertions(+), 2 deletions(-)
 create mode 100644 include/dt-bindings/reset/amlogic,meson-g12a-audio-reset.h

-- 
2.21.0

