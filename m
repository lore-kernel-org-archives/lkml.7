Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C473C10F06
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 13:37:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A2C32087C
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 13:37:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="qBrnrwK0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727572AbfCKNhK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 09:37:10 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:40292 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727426AbfCKNhJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 09:37:09 -0400
Received: by mail-pf1-f195.google.com with SMTP id h1so3715625pfo.7
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019 06:37:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RvQ7bY5HMdYTAsw8Sqg/G++8mHvUTc4957a2ztYq/EU=;
        b=qBrnrwK0bRWzB9XVhoNy4nlCBV/SME8zV05fqNPIWa9Oel0Am1KanePP1NPe5I4sDu
         4t2cYIiorEUa2neKhlLY+bI1X6HwvTeM+QTvWbJlAQJ5mlngJWS9yUMhaHET0sJ1zviC
         o1D1MvfM2zQMAKXIj8q7V012PBqI9esxj6RZs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RvQ7bY5HMdYTAsw8Sqg/G++8mHvUTc4957a2ztYq/EU=;
        b=alvC0zIeTgWsB17ggGHq7QtCYG3ur3KxoD3hrECn7qhS+DRbNKXdOLr0JAQzKk9Y9b
         ebTtNwpWM4FADP6kBBbXo9eTlWM3Z4+s5I5ZLJnxxufUMcl+LDkp3vW/J1xDNKiFozJf
         AG2ZYJKsdbCpee3vZJog3m2M/e58k0Md/V1FYNCO+QBRrHm1roNkJZVsX2MWGBOpYOt7
         +F6VEBVW/L3GSQwDETB6zgyi5ujetsvCwXr4uUr3fzNJTexEcYX3Z1v/6pXzPYdkeXMy
         N8+tH39FaXumLc1KiJiNrkciD4Nyjb0H669fMc4UxgZIUPspbu8aUUJqCU9vrNGkJYH8
         GgPQ==
X-Gm-Message-State: APjAAAUU4LX9g7NK3kjpEjvXNARZqai/nPo3AGA7AuBvCHi8TT+fZZUd
        IOwfI3N0MzF2zVXIx6DQbcFqjw==
X-Google-Smtp-Source: APXvYqwQtbjOA+LgFw9D9m/MpkVGZGsdFLplASjyH4Y4zZfGfXEFLj/waqlT8q30K1PrDBe5Rp0I7A==
X-Received: by 2002:a17:902:362:: with SMTP id 89mr5872284pld.172.1552311428246;
        Mon, 11 Mar 2019 06:37:08 -0700 (PDT)
Received: from localhost.localdomain ([183.82.224.199])
        by smtp.gmail.com with ESMTPSA id s79sm9960397pfa.61.2019.03.11.06.37.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Mar 2019 06:37:07 -0700 (PDT)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Chen-Yu Tsai <wens@csie.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-amarula@amarulasolutions.com, linux-sunxi@googlegroups.com,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH v8 00/15] drm/sun4i: Allwinner A64 MIPI-DSI support 
Date:   Mon, 11 Mar 2019 19:06:22 +0530
Message-Id: <20190311133637.18334-1-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Here is next version, v8 changes for Allwinner A64 MIPI-DSI support.
It depends on DSI fixes/update series [1]

Changes for v8:
- rebased on drm-misc change along with linux-next
- reworked video start delay patch
- tested on 4 different dsi panels
- reworked commit messages
Changes for v7:
- moved vcc-dsi binding to required filed.
- drop quotes on fallback dphy bindings.
- drop min_rate clock pll-mipi patches.
- introduce dclk divider computation as like A64 BSP.
- add A64 DSI quark patches.
- fixed A64 DSI pipeline.
- add proper commit messages.
- collect Merlijn Wajer Tested-by credits.
Changes for v6:
- dropped unneeded changes, patches
- fixed all burst mode patches as per previous version comments
- rebase on master
- update proper commit message
- dropped unneeded comments
- order the patches that make review easy
Changes for v5:
- collect Rob, Acked-by
- droped "Fix VBP size calculation" patch
- updated vblk timing calculation.
- droped techstar, bananapi dsi panel drivers which may require
  bridge or other setup. it's under discussion.
Changes for v4:
- droppoed untested CCU_FEATURE_FIXED_POSTDIV check code in
  nkm min, max rate patches
- create two patches for "Add Allwinner A64 MIPI DSI support"
  one for has_mod_clk quirk and other one for A64 support
- use existing driver code construct for hblk computation
- dropped "Increase hfp packet overhead" patch [2], though BSP added
  this but we have no issues as of now.
  (no issues on panel side w/o this change)
- create separate function for vblk computation 
- enable vcc-dsi regulator in dsi_runtime_resume
- collect Rob, Acked-by
- update MAINTAINERS file for panel drivers
- cleanup commit messages
- fixed checkpatch warnings/errors

[1] https://patchwork.kernel.org/cover/10837163/

Any inputs?
Jagan.

Jagan Teki (15):
  drm/sun4i: dsi: Fix video start delay computation
  drm/sun4i: tcon: Compute DCLK dividers based on format, lanes
  drm/sun4i: tcon: Export get tcon0 routine
  drm/sun4i: dsi: Probe tcon0 during dsi_bind
  drm/sun4i: dsi: Get tcon0_div at runtime
  dt-bindings: sun6i-dsi: Add VCC-DSI supply property
  dt-bindings: sun6i-dsi: Add A64 MIPI-DSI compatible
  dt-bindings: sun6i-dsi: Add A64 DPHY compatible (w/ A31 fallback)
  drm/sun4i: sun6i_mipi_dsi: Add has_mod_clk quirk
  drm/sun4i: sun6i_mipi_dsi: Add has_mod_clk quirk
  drm/sun4i: sun6i_mipi_dsi: Add Allwinner A64 MIPI DSI support
  arm64: dts: allwinner: a64: Add MIPI DSI pipeline
  arm64: dts: allwinner: a64-amarula-relic: Add Techstar TS8550B
    MIPI-DSI panel
  [DO NOT MERGE] arm64: dts: allwinner: a64-pine64-lts: Enable Feiyang FY07024DI26A30-D
    DSI panel
  [DO NOT MERGE] arm64: dts: allwinner: bananapi-m64: Enable Bananapi S070WV20-CT16 DSI
    panel

 .../bindings/display/sunxi/sun6i-dsi.txt      |  3 +
 .../allwinner/sun50i-a64-amarula-relic.dts    | 39 +++++++++
 .../dts/allwinner/sun50i-a64-bananapi-m64.dts | 44 ++++++++++
 .../dts/allwinner/sun50i-a64-pine64-lts.dts   | 39 +++++++++
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 45 ++++++++++
 drivers/gpu/drm/sun4i/sun4i_tcon.c            |  7 +-
 drivers/gpu/drm/sun4i/sun4i_tcon.h            |  1 +
 drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c        | 83 +++++++++++++++----
 drivers/gpu/drm/sun4i/sun6i_mipi_dsi.h        |  9 +-
 9 files changed, 252 insertions(+), 18 deletions(-)

-- 
2.18.0.321.gffc6fa0e3

