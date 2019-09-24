Return-Path: <SRS0=YpA9=XT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D1D2C4320D
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 12:40:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0371F214DA
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 12:40:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="ymqnFpv6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395290AbfIXMkF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Sep 2019 08:40:05 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44715 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725973AbfIXMkE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 08:40:04 -0400
Received: by mail-wr1-f65.google.com with SMTP id i18so1754292wru.11
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2019 05:40:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QU+WJPa29FF69lyvwdW7u6JWpBW55BMoTe9rf+CDynM=;
        b=ymqnFpv6sdmg2AHOFDMfgBUEl/uhL6+1gJWML2dumV5y+DSIrdvovrWnCyFsVmjLeH
         c4W5aXhFsJ6fi9CrysPrTB8OcGDOqtNtj9mZgtFSJoYYZqDFkXpmX11dVt+HmH+W1lvJ
         /3oGRiD8TuPVevnGrJF868H0SFQ6Fm+yv5rfsp2RPomxtTcGI7qykiuoKyuCKUgUHh2S
         zrDiVpwCWZoeeMRLBqltNCB+BQr346ohttuSuzk69X1+T4MMepd40Ld8wVfLYKJ2Waxi
         XBX31J9fBGXamo1MHbd2fXczWi7STEBb2NAh6J5d/eB4ClmDUUBh9mrb+glfMA6TPJ+l
         CNSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QU+WJPa29FF69lyvwdW7u6JWpBW55BMoTe9rf+CDynM=;
        b=bmqhZpBIOUBR2ZMKpHK1aClN3zJpdArn/bM5xMeYODPUgNMOGBtpmA8mFS8P8aSm88
         lE+ua8XnTWWAQ62vp3I8mFcGQsNyl0aDoOnCLZQ0A++iZiL2oStrUYSe42AXJpkXjJEH
         FTMWFp0VE4NLEjwJhF1iajFKAnFz7NCfd4bYsSr49aoir6xjmMb6wYT5EA2flNfBKyms
         KtzH6mlnnpWPilPXeD3lmI4eaz7eBI+0t/WdwhATourxJsNUiMxCJm+zy4XRE0PfWylX
         WwefAPP0DdiicRbHuvgZH4JYUPDw+LLa20A7eGzjv03zYGUmyTX8F1q/q9KQD1O3KUKZ
         BY9Q==
X-Gm-Message-State: APjAAAVOqOMnXA21YY8RyuqtnzIkOL2A39nQjtzmOws+1KEEZyVGsXAW
        JGY09xCcHQK2pU1Nea3tTlMKDA==
X-Google-Smtp-Source: APXvYqyT3jEDbsQBqF7Qoip2EVij2ZnwT27ENzhCAlSalWomhd55OVwwkoJ1V6lTueXmII1ZZAnpRA==
X-Received: by 2002:adf:ea12:: with SMTP id q18mr2216892wrm.378.1569328802720;
        Tue, 24 Sep 2019 05:40:02 -0700 (PDT)
Received: from starbuck.baylibre.local (uluru.liltaz.com. [163.172.81.188])
        by smtp.googlemail.com with ESMTPSA id u83sm2888165wme.0.2019.09.24.05.40.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Sep 2019 05:40:02 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] clk: let clock perform allocation in init
Date:   Tue, 24 Sep 2019 14:39:51 +0200
Message-Id: <20190924123954.31561-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset is a follow up on this pinky swear [0].
Its purpose is:
 * Clarify the acceptable use of clk_ops init() callback
 * Let the init() callback return an error code in case anything
   fail.
 * Add the terminate() counter part of of init() to release the
   resources which may have been claimed in init()

After discussing with Stephen at LPC, I decided to drop the 2 last patches
of the RFC [1]. I can live without it for now and nobody expressed a
critical need to get the proposed placeholder.

[0]: https://lkml.kernel.org/r/CAEG3pNB-143Pr_xCTPj=tURhpiTiJqi61xfDGDVdU7zG5H-2tA@mail.gmail.com
[1]: https://lkml.kernel.org/r/20190828102012.4493-1-jbrunet@baylibre.com

Jerome Brunet (3):
  clk: actually call the clock init before any other callback of the
    clock
  clk: let init callback return an error code
  clk: add terminate callback to clk_ops

 drivers/clk/clk.c                     | 38 ++++++++++++++++++---------
 drivers/clk/meson/clk-mpll.c          |  4 ++-
 drivers/clk/meson/clk-phase.c         |  4 ++-
 drivers/clk/meson/clk-pll.c           |  4 ++-
 drivers/clk/meson/sclk-div.c          |  4 ++-
 drivers/clk/microchip/clk-core.c      |  8 ++++--
 drivers/clk/mmp/clk-frac.c            |  4 ++-
 drivers/clk/mmp/clk-mix.c             |  4 ++-
 drivers/clk/qcom/clk-hfpll.c          |  6 +++--
 drivers/clk/rockchip/clk-pll.c        | 28 ++++++++++++--------
 drivers/clk/ti/clock.h                |  2 +-
 drivers/clk/ti/clockdomain.c          |  8 +++---
 drivers/net/phy/mdio-mux-meson-g12a.c |  4 ++-
 include/linux/clk-provider.h          | 13 ++++++---
 14 files changed, 90 insertions(+), 41 deletions(-)

-- 
2.21.0

