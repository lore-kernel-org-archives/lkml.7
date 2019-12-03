Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B191C432C3
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 13:48:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF48F20803
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 13:48:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="O7md203+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726422AbfLCNsa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 08:48:30 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:39090 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726330AbfLCNsa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 08:48:30 -0500
Received: by mail-pj1-f66.google.com with SMTP id v93so1552082pjb.6
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2019 05:48:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7fyH+2F2a+rl1kectMRnZFlHTKNuWeTnYPoVBXe5Db4=;
        b=O7md203+f98TyLan33Yz4aeIVna2Ip1fUra9eSfxZt0oM+104KLRNIYxIR3+igDF91
         ZSIlXuIuSFdOCRwQA6VRzSsU2uUWuWRdGZ3LpLOzawoqqBUauMRZWt0AH5gcrW+KIbbg
         TGcdTj7F2aaAZV+V9yBZPetyHggQ+sa8SJ5gI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7fyH+2F2a+rl1kectMRnZFlHTKNuWeTnYPoVBXe5Db4=;
        b=HlPt3WNk2Wxb8UMd4egsbr5Sbny7JuiW188XCoqVM7uodASDXxDS+A7Sr+Z2ijSteI
         0Hyw7rxnrZ/L8h6UXRdBJj8J0zcNy0R8wzIKpZa59Lc+UHYUdGA7Da0TTocznP5OKuep
         o+GC8VbsfWHVpsVVegtBPwYQ4LdDH/GgHP6W3J16xCTLxYmWyV244+guogWIgWHncx0t
         3Y5770q3mB3GqoC5HOxUqL4TE1SncXyPSElozCuacUJSY/16k54VnlkfPp9Mzhd1EPtx
         Mr1U+uPzER51yPpxRVEdf7fsQZXGLXj0iQhxbApvaq564F/oGDGTihw4l4dbybD1LyCz
         w/dA==
X-Gm-Message-State: APjAAAXJ769qnU7g33SWcC5GHRDMinWRETYKO4IVZ3R8kreVibzgyDDW
        NXL4fIPnJwpC0KtkfMh20777Iw==
X-Google-Smtp-Source: APXvYqzbpkPoRAjx7jYyIBTmDtEHbDTA8NmXpToYJsChd3LnIUvBCuRXvE+x3s8pofxO0AXSfe7fjg==
X-Received: by 2002:a17:902:fe12:: with SMTP id g18mr4992444plj.20.1575380908885;
        Tue, 03 Dec 2019 05:48:28 -0800 (PST)
Received: from localhost.localdomain ([115.97.190.29])
        by smtp.gmail.com with ESMTPSA id y144sm4397892pfb.188.2019.12.03.05.48.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2019 05:48:28 -0800 (PST)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     michael@amarulasolutions.com, Icenowy Zheng <icenowy@aosc.io>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-amarula@amarulasolutions.com,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH v12 0/7] drm/sun4i: Allwinner A64 MIPI-DSI support
Date:   Tue,  3 Dec 2019 19:18:09 +0530
Message-Id: <20191203134816.5319-1-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is v12 version for Allwinner A64 MIPI-DSI support
and here is the previous version set[1]

Changes for v12:
- use enum insted of oneOf+const
- handle bus clock using regmap attach clk
- tested on A64, A33 boards.
Changes for v11:
- fix dt-bindings for dphy
- fix dt-bindings for dsi controller
- add bus clock handling code
- tested on A64, A33 boards.
Changes for v10:
- updated dt-bindings as per .yaml format
- rebased on drm-misc/for-linux-next
Changes for v9:
- moved dsi fixes in separate series on top of A33
- rebase on linux-next
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

[1] https://patchwork.freedesktop.org/series/68579/

Any inputs?
Jagan.

Jagan Teki (7):
  dt-bindings: sun6i-dsi: Document A64 MIPI-DSI controller
  dt-bindings: sun6i-dsi: Add A64 DPHY compatible (w/ A31 fallback)
  drm/sun4i: dsi: Add has_mod_clk quirk
  drm/sun4i: dsi: Handle bus clock via regmap_mmio_attach_clk
  drm/sun4i: dsi: Add Allwinner A64 MIPI DSI support
  arm64: dts: allwinner: a64: Add MIPI DSI pipeline
  [DO NOT MERGE] arm64: dts: allwinner: bananapi-m64: Enable Bananapi S070WV20-CT16 DSI panel

 .../display/allwinner,sun6i-a31-mipi-dsi.yaml | 20 ++++-
 .../phy/allwinner,sun6i-a31-mipi-dphy.yaml    |  6 +-
 .../dts/allwinner/sun50i-a64-bananapi-m64.dts | 31 +++++++
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 37 ++++++++
 drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c        | 86 +++++++++++++++----
 drivers/gpu/drm/sun4i/sun6i_mipi_dsi.h        |  5 ++
 6 files changed, 164 insertions(+), 21 deletions(-)

-- 
2.18.0.321.gffc6fa0e3

