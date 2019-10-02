Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54E56C352AA
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 09:15:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2625321783
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 09:15:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="zc2FBs7z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726559AbfJBJPg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 05:15:36 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40328 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725852AbfJBJPg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 05:15:36 -0400
Received: by mail-wr1-f65.google.com with SMTP id l3so18722515wru.7
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2019 02:15:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yH4ZTSk2dw1y5h5K76pORaKv4pdr0m6BUkDf5tas0UM=;
        b=zc2FBs7z5S2aHmF35iyYbauzzs8pRQm213RXAZUZaRZNWslRhXz7GnASQPLyM9q/en
         7T7cS+egsJAyLZFRLbx7NDJfF7bR4qg2p6bVpUTK7EaYjSnkaN9TwDBdnYS2FZv1OMze
         OArWpi9IQhYJzBZzu34oUWewKmSIdOSPNjcmqEyjVXDHLLr94SmkSWe2CD5IobsS/yu7
         s7m2DrWXIVweiWMi4MPzTIjSnx7kc11PmofHBo8+h23lqLKL0gOc6ET0NNqAzz04sM4B
         m9HbhJo3a9IIGRKYGLLFR5NiFHKFsv2DGOZBtC71SWrsD90AKlEaov7T1msz1ppAHosn
         yQ8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yH4ZTSk2dw1y5h5K76pORaKv4pdr0m6BUkDf5tas0UM=;
        b=GCYd3FCO+sJQDvdUf7EeSXsPnk3TYKI2hyQ8K/QaYIhfRB+ME+29CGA2yi7urHMcVZ
         Ky33bEhkfDv348YLvCT4uwaN/zAdpJ7WOqleRUy3b9UFVpL4JHYiZtb/oxPdlHyj4JKR
         9Ba6fejQvxvxqdBU5zVrDhTzWVaahrSkbRt999saic/rsmjFAKOPICf5/JTHTcMTXGio
         W4vEq1nQZPFrzAWiMpoP2qPx79Mg4LaU56o2NOQk8nG0G6Uv/qE+2uZAZ4tP7WA6Yt9v
         rJ6RJwQlMWC8yGlo/huvDfbOV42bRh9pr8VM/k3zreiRQMRrKFbtKzvbhkg8Zy2vD+71
         gn5g==
X-Gm-Message-State: APjAAAVoXX/4oAJHFOcZxMTfCMmKhXacRsOHkabHlIi2+sZp9I4dj6rL
        X93T1STjIgl7JY+sZv3e3bNn/Q==
X-Google-Smtp-Source: APXvYqzswOHaJVWMVNqCnIuTNovQzfrpQ6257D/8Uph/LNaRknSti77zAUS9MQUECjWMbtME96+0MA==
X-Received: by 2002:adf:d08b:: with SMTP id y11mr1934045wrh.50.1570007732457;
        Wed, 02 Oct 2019 02:15:32 -0700 (PDT)
Received: from starbuck.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id r13sm32913737wrn.0.2019.10.02.02.15.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2019 02:15:31 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/7] clk: meson: axg-audio: add sm1 support
Date:   Wed,  2 Oct 2019 11:15:22 +0200
Message-Id: <20191002091529.17112-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The purpose of this patchset is to add the sm1 support to the amlogic audio
clock controller. The line count is lot higher than what I hoped for. Even
if extremely similar, there is a shift in the register address on the sm1
which makes a bit of a mess.

I could have patched the address on the fly if running on sm1 but the end
result did not save much lines and would have been a pain to maintain and
scale in the future

Instead I choose to re-arrange the driver to share the macros and declare
separate clocks for the clock which have changed.

Changes since v2 [1]:
 - Add missing gate ops for
  * sm1_clk81_en
  * sm1_sysclk_a_en
  * sm1_sysclk_b_en

Changes since v1 [0]:
 - Fix newline in the last patch

[0]: https://lkml.kernel.org/r/20190924153356.24103-1-jbrunet@baylibre.com
[1]: https://lkml.kernel.org/r/20191001115511.17357-1-jbrunet@baylibre.com>

Jerome Brunet (7):
  dt-bindings: clk: axg-audio: add sm1 bindings
  dt-bindings: clock: meson: add sm1 resets to the axg-audio controller
  clk: meson: axg-audio: remove useless defines
  clk: meson: axg-audio: fix regmap last register
  clk: meson: axg-audio: prepare sm1 addition
  clk: meson: axg-audio: provide clk top signal name
  clk: meson: axg_audio: add sm1 support

 .../bindings/clock/amlogic,axg-audio-clkc.txt |    3 +-
 drivers/clk/meson/axg-audio.c                 | 2021 +++++++++++------
 drivers/clk/meson/axg-audio.h                 |   21 +-
 include/dt-bindings/clock/axg-audio-clkc.h    |   10 +
 .../reset/amlogic,meson-g12a-audio-reset.h    |   15 +
 5 files changed, 1373 insertions(+), 697 deletions(-)

-- 
2.21.0

