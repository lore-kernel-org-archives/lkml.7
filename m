Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD1B7CA9EBD
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 17:56:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9228D21D81
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 17:56:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="YhjRITCe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728657AbfJYR4p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 13:56:45 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:33265 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727961AbfJYR4o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 13:56:44 -0400
Received: by mail-pg1-f195.google.com with SMTP id u23so2029610pgo.0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2019 10:56:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CZu1y7RFPTmm+e4tCk9sCPOaUomZD2b+NU7YQ9E83qM=;
        b=YhjRITCeN91gMx3yOBIKu1C/Pio+m/xXybbzZLCU25mrLAjzyrOYfNs1bhqX/uwVzD
         xrMOinaz6vv7qJY1vx/NwIHKq3EqmHOgy/jU9Dl2pHGXYkEWrTAJQki2NH27JXd6tcQz
         QqlAaNV8+/GmvrmeZx1FFtPzeMWx9l3huboSQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CZu1y7RFPTmm+e4tCk9sCPOaUomZD2b+NU7YQ9E83qM=;
        b=ne2Tj00kxTlx4uNa4zo+4iZQNE7NsOAML5Tuu6kjUEFIcNG6WXheOG8R4tmxO8KyvS
         euTJDkxEmeBaC4fL1Zftb68qtnrK4d/GQTQ13RgbD9xoDBE0umHL3mAs74jP9UPU5ZiT
         zK1FR1h0fQiyGOPqVDt6mU9aH5JtVNaWszZeXsNQo4FMOUONuIdSfgoK0Fc5DPqbTazV
         Sbc0INhwYOav0tgPIy8ivDnBAcmZtxQbubdwlMixzH0aRr/veI2NfKwze5eJD2H6DiCm
         Sn5TgSCttIWQ++WJ/OZL7EeqclHV5xqeFcTmFtO4WasKLgfmMAaeT64t9OQRoSgxo03M
         ZeWA==
X-Gm-Message-State: APjAAAX5Xd3+6xTtlb5e8ryYC8o/yzrNuyMu1ijWJfl4k2res+9qYmcm
        BM85PXFAUMJHPaHcIOoxF3PDqA==
X-Google-Smtp-Source: APXvYqyQeMNwRRfVdYbplZky4DnGyeCS16N1lkW3Qf6FFBlut0tyb3bO5QFkhxBsvIR+NOqRTEQOdg==
X-Received: by 2002:a17:90a:ad95:: with SMTP id s21mr5737486pjq.11.1572026202818;
        Fri, 25 Oct 2019 10:56:42 -0700 (PDT)
Received: from localhost.localdomain ([115.97.180.31])
        by smtp.gmail.com with ESMTPSA id n15sm2926580pfq.146.2019.10.25.10.56.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2019 10:56:42 -0700 (PDT)
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
Subject: [PATCH v11 0/7] drm/sun4i: Allwinner A64 MIPI-DSI support
Date:   Fri, 25 Oct 2019 23:26:18 +0530
Message-Id: <20191025175625.8011-1-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is v11 version for Allwinner A64 MIPI-DSI support
and here is the previous version set[1]

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

[1] https://patchwork.freedesktop.org/series/67632/

Any inputs?
Jagan.

Jagan Teki (7):
  dt-bindings: sun6i-dsi: Document A64 MIPI-DSI controller
  dt-bindings: sun6i-dsi: Add A64 DPHY compatible (w/ A31 fallback)
  drm/sun4i: dsi: Add has_mod_clk quirk
  drm/sun4i: dsi: Handle bus clock explicitly 
  drm/sun4i: dsi: Add Allwinner A64 MIPI DSI support
  arm64: dts: allwinner: a64: Add MIPI DSI pipeline
  [DO NOT MERGE] arm64: dts: allwinner: bananapi-m64: Enable Bananapi S070WV20-CT16 DSI panel

 .../display/allwinner,sun6i-a31-mipi-dsi.yaml | 20 ++++++-
 .../phy/allwinner,sun6i-a31-mipi-dphy.yaml    |  6 +-
 .../dts/allwinner/sun50i-a64-bananapi-m64.dts | 31 +++++++++++
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 37 +++++++++++++
 drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c        | 55 +++++++++++++++----
 drivers/gpu/drm/sun4i/sun6i_mipi_dsi.h        |  5 ++
 6 files changed, 139 insertions(+), 15 deletions(-)

-- 
2.18.0.321.gffc6fa0e3

