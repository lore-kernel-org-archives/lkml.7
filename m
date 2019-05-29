Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D33F6C28CC0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 10:56:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 829E920B7C
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 10:56:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="kfGgahWw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726613AbfE2K4m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 06:56:42 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:32857 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725990AbfE2K4m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 06:56:42 -0400
Received: by mail-pg1-f193.google.com with SMTP id h17so1171379pgv.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2019 03:56:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QlH+bdDvrGkuMtx4C8zLdS+VSlbI3yCzUmJWnWewlAQ=;
        b=kfGgahWwlz5uJSHrLWZExXhJWc3KlK4MMXhmTTh+sXSy+X+iDvCc5QAhKKrMul3hax
         A06X6vN8umwMZrLMbJigUxxvoiTdMo+G+G+zXKocEc+mu6DeVbKjcbgn9OkfVFbM7Fmz
         EhJ6p3maCAEB1pecz9FsYfm3piVA8gqN4OxNs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QlH+bdDvrGkuMtx4C8zLdS+VSlbI3yCzUmJWnWewlAQ=;
        b=nq1+DC8MH95DY4bu17whGDZUzLEc7TLeNme56heBG7XZB4kaXSDryHTeVxl8etdcC0
         kaEemYsidDCPnf4JWJgXP3s5Lh+EFVkdxKdcRZ9NKyq8gzmT7HRGaXEbUkJAz6X77QW3
         j40dvHUjF6y7Q6XratpbtifFle/+9DFCVpqwIY5ySE6+VseCgegu7tCo465g+oFz52x7
         mcl9MMYSLOjKbv30ulh56i5OZlcEKWR3IrV6eacs9Ko9WbW0EjtmNBaDM0X+2BdSIZyX
         fK+GrOxARF/pBX38QuVqcvDmv5+Ce/QaclUrojA/jXkAZj5NBQ6yl61uMpdWiw0abT3e
         VQ0Q==
X-Gm-Message-State: APjAAAV2hL6zj5Ten8EKwJK9+S2VizlWV8PdTq3pdgw5Ue1IfGi3jnhD
        vhvoKB6xlQLte2enQrf0M7JzMA==
X-Google-Smtp-Source: APXvYqxDCqXNYYDrNO19C8eevIbe90q34Fw+quaxpak9TU0mVV/bwLX0fPihzSEx0Ivy40x8IOR0eQ==
X-Received: by 2002:a65:5347:: with SMTP id w7mr81611008pgr.375.1559127401755;
        Wed, 29 May 2019 03:56:41 -0700 (PDT)
Received: from localhost.localdomain ([49.206.202.218])
        by smtp.gmail.com with ESMTPSA id 184sm18974479pfa.48.2019.05.29.03.56.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 May 2019 03:56:41 -0700 (PDT)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Chen-Yu Tsai <wens@csie.org>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Michael Trimarchi <michael@amarulasolutions.com>,
        devicetree@vger.kernel.org, linux-sunxi@googlegroups.com,
        linux-amarula@amarulasolutions.com,
        Sergey Suloev <ssuloev@orpaltech.com>,
        Ryan Pannell <ryan@osukl.com>, bshah@mykolab.com,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH v9 0/9] drm/sun4i: Allwinner A64 MIPI-DSI support
Date:   Wed, 29 May 2019 16:26:06 +0530
Message-Id: <20190529105615.14027-1-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is v9 version for Allwinner A64 MIPI-DSI support
and here is the previous version set[1].

This depends on dsi host controller fixes which were
supported in this series[2].

All these changes are tested in Allwinner A64 with
2, 4 lanes devices and whose pixel clocks are 27.5 MHz,
30MHz, 55MHz and 147MHz.

Changes for v9:
- moved dsi fixes in separate series on top of A33 [2]
- rebase on linux-next and on top of [2]
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

[1] https://patchwork.freedesktop.org/series/57834/
[2] https://patchwork.freedesktop.org/series/60847/

Jagan Teki (9):
  dt-bindings: sun6i-dsi: Add A64 MIPI-DSI compatible
  dt-bindings: sun6i-dsi: Add A64 DPHY compatible (w/ A31 fallback)
  drm/sun4i: dsi: Add has_mod_clk quirk
  drm/sun4i: dsi: Add Allwinner A64 MIPI DSI support
  arm64: dts: allwinner: a64: Add MIPI DSI pipeline
  arm64: dts: allwinner: a64-amarula-relic: Add Techstar TS8550B MIPI-DSI panel
  [DO NOT MERGE] arm64: dts: allwinner: bananapi-m64: Enable Bananapi S070WV20-CT16 DSI panel
  [DO NOT MERGE] arm64: dts: allwinner: a64-pine64-lts: Enable Feiyang FY07024DI26A30-D DSI panel
  [DO NOT MERGE] arm64: dts: allwinner: oceanic-5205-5inmfd: Enable Microtech MTF050FHDI-03 panel

 .../bindings/display/sunxi/sun6i-dsi.txt      |  2 +
 .../allwinner/sun50i-a64-amarula-relic.dts    | 35 +++++++++++++
 .../dts/allwinner/sun50i-a64-bananapi-m64.dts | 31 ++++++++++++
 .../sun50i-a64-oceanic-5205-5inmfd.dts        | 49 +++++++++++++++++++
 .../allwinner/sun50i-a64-sopine-baseboard.dts | 31 ++++++++++++
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 38 ++++++++++++++
 drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c        | 45 ++++++++++++-----
 drivers/gpu/drm/sun4i/sun6i_mipi_dsi.h        |  5 ++
 8 files changed, 225 insertions(+), 11 deletions(-)

-- 
2.18.0.321.gffc6fa0e3

