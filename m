Return-Path: <SRS0=YpA9=XT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31553C432C2
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 15:34:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0773E20665
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 15:34:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="NEnONSEs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389922AbfIXPeD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Sep 2019 11:34:03 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:55582 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732698AbfIXPeD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 11:34:03 -0400
Received: by mail-wm1-f67.google.com with SMTP id a6so645093wma.5
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2019 08:34:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BVrzY1NA5Ch72acoAjxkDHVhN4/WGgUil5qUxNRRH7o=;
        b=NEnONSEsVbr/P7iWXVn1NB30VoyNPibfxL6JPNvs+Wa+FQKgX+BO3sG/7Pa8Tj/kDN
         EWbfbmLeDMMldOVcGmotYrPvIhzOHm4WDIRcdKZZFY3pajkZuTNdja+qvr2Y7608OBwG
         uXD8s/aUhfMn1bX6+ciSPn5LtHzQV3067gUDCO7V0Ycx0Mj5KJX9p3mK14eVv7G96rT7
         di/GeqkqnhNB/Nh6UFrsb5LA6XwcWZd/Rs4k+/YiQ9j/SzWlyqVSEUcGqVO2tOEDuWIa
         BAdKgEis7K5HslkRrMeXS6m4z7L8UjepywyoKpol17FoAXFe1c5zMYVeG1NG5e31Obh4
         sTQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BVrzY1NA5Ch72acoAjxkDHVhN4/WGgUil5qUxNRRH7o=;
        b=qMW5ofbis/7iWdnTVsRjhq4utpQ2RC2o88TLNrlLJtopvGf9sRbPp51Y+R4DqWZrTf
         4Im96aNh1er15Ac73VjdbVvP6iOa+/+3Gv8xTzloBQX3I89RfNDjyFZ6wzXnUP72JZLo
         r8SN7RLryrVTEdRErOclJ5KWrbQ1aZNY6XLSuf1LHxIq2cueBjVc36PmV6O5puTA/g3g
         AIEAPhm2o1rOQ5gQ4PWmrw3cd28AtZ8fqokuNo3zTHhxS2DYNubFOfTlHWbtIPaDE8tZ
         cC/rBXJnw3PiF22Y6eCaEMUD1GtKDWyYy7A+xRrCzEgRNzJAYxJIUzhJZpTrAZbFv4lC
         X4Jg==
X-Gm-Message-State: APjAAAVJLeDXfpkxUjb4D4euyUwJt9HzTqfKnxv5PFfSHyNSIalLNZwK
        Uc0achyw5kdlSJ2E8HNOqWnVQg==
X-Google-Smtp-Source: APXvYqyg/jaDIFG3IyGsgXjUNtj7JsiTHUa9FnEaXGDBkdZpMfihQgExMr7nYHu57aDRvaYl8zLFLg==
X-Received: by 2002:a1c:f30b:: with SMTP id q11mr711033wmq.57.1569339240364;
        Tue, 24 Sep 2019 08:34:00 -0700 (PDT)
Received: from starbuck.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id d10sm144240wma.42.2019.09.24.08.33.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Sep 2019 08:33:59 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/7] clk: meson: axg-audio: add sm1 support
Date:   Tue, 24 Sep 2019 17:33:49 +0200
Message-Id: <20190924153356.24103-1-jbrunet@baylibre.com>
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

