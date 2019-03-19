Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB8EDC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 22:00:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A63642085A
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 22:00:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="ahMwP3k+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727837AbfCSWAT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 18:00:19 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37764 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727366AbfCSWAT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 18:00:19 -0400
Received: by mail-wr1-f65.google.com with SMTP id y15so544065wro.4;
        Tue, 19 Mar 2019 15:00:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EgE8EGo39YHuRe9fCXmuDvR01OQN1TKiCwmwvc0k/eI=;
        b=ahMwP3k+K8G9y3awxesEhP5VcmA0hogNr7vE75RgvMVKXoI8SRz2MGuKz4KA3vxlIv
         kSgZdzWrc0WvuiTs7AxEFXwXmI3vamSv8fhnjIgNArAUTjteLGBs2PhBbtxumiTOfXCk
         7sdQniqQeEjIKcj749MksMYkl2yLg71q6XNAxGw6xEmFhYWASV1oxokvfNnAJtXhML6e
         BFyIyWZaLvxQ5wCVIxtdc0hTKRiBOOrUXy+1pMUPAbhMzgLz1MpIog2kyUknkmK3esjD
         ILY9pB/f4Nv7QoHPRU/ELXeuVbjBmP4So1uM5GvTwX+kgvEyEwmc/srr4V2uQ0hgTQ0F
         d4cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EgE8EGo39YHuRe9fCXmuDvR01OQN1TKiCwmwvc0k/eI=;
        b=EQJ0NzwDnVve4qsy8B8XMOJMZukHfW60AQlNyDM7PPIJAJuno9tJCaSEbqtOFBJ+hc
         f8aTyU+ToUninNMz1O7UJJ8g5z2vxT350ioLUm2IBmaDHAgGa3czVoDWJOBRqL420/DX
         KAFLyTguPjuh9RTl7MAaeOfGq0tCYnFI9bG5dqmmTtcE+0E5sEAMh9PDX8vcDERc7Ec2
         umfaQXpAY2ndF66lfTvN0LQ0FPQ6J609juAoRtnKMwRGzocn9IWxsvZcFcDOVS67WRDT
         fCTyXx3qeprqUAP9+iKm8f5kU+xSJn+LM67C1yLxrteHOz6GUptFC07w5fl160NftYSd
         xLMw==
X-Gm-Message-State: APjAAAXaXtWzsAICNUSMjIbaZCFSmLmpMAf2hGgRykR/3SNYV4aoiviR
        nfVN3ey8q2YdNaVHYAJ1ES4=
X-Google-Smtp-Source: APXvYqxJ2k1f8ZPHWdqERcu+DugnMULZ93b5sVLILHLUL1D4HZCFHtoqpWERrijelH29v4bWfHvrnw==
X-Received: by 2002:adf:e547:: with SMTP id z7mr900438wrm.295.1553032816906;
        Tue, 19 Mar 2019 15:00:16 -0700 (PDT)
Received: from blackbox.darklights.net (p200300DCD739990039EE738515149D3E.dip0.t-ipconnect.de. [2003:dc:d739:9900:39ee:7385:1514:9d3e])
        by smtp.googlemail.com with ESMTPSA id t2sm188762wra.9.2019.03.19.15.00.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Mar 2019 15:00:16 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     narmstrong@baylibre.com, jbrunet@baylibre.com,
        linux-amlogic@lists.infradead.org, mjourdan@baylibre.com
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH 0/2] clk: meson8b: add the video decoder clocks
Date:   Tue, 19 Mar 2019 23:00:10 +0100
Message-Id: <20190319220012.31065-1-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds the video decoder clocks for Meson8, Meson8b and Meson8m2.

The clock tree on Meson8 differs from the one one Meson8b and Meson8m2.
Details can be found in patch #2.

There are some checkpatch warnings in patch #2:
  WARNING: please, no space before tabs
I decided to still send the patch because we have the same inconsistency
with all other clk_hw_onecell_data table entries. Please let me know if
I should come up with a follow-up patch to clean them all up.

Testing:
I have not tested this with Maxime's video decoder driver yet.
However, I manually enabled and set various frequencies for the HCODEC
clock and verified that clkmsr reports the correct rate.

Dependencies:
This is meant to be applied on top of my other series from [0]:
  clk: meson8b: add the VPU clock tree


[0] https://patchwork.kernel.org/cover/10860401/


Martin Blumenstingl (2):
  dt-bindings: clock: meson8b: export the video decoder clocks
  clk: meson: meson8b: add the video decoder clock trees

 drivers/clk/meson/meson8b.c              | 312 +++++++++++++++++++++++
 drivers/clk/meson/meson8b.h              |  17 +-
 include/dt-bindings/clock/meson8b-clkc.h |   4 +
 3 files changed, 332 insertions(+), 1 deletion(-)

-- 
2.21.0

