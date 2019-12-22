Return-Path: <SRS0=7h0X=2M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFDF2C2D0D4
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Dec 2019 13:29:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B97C020733
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Dec 2019 13:29:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="XcW78meM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725791AbfLVN31 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Dec 2019 08:29:27 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:44712 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725807AbfLVN31 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Dec 2019 08:29:27 -0500
Received: by mail-pl1-f196.google.com with SMTP id az3so6101398plb.11
        for <linux-kernel@vger.kernel.org>; Sun, 22 Dec 2019 05:29:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LWZqcIgXzVjxh5QO9iqiielSvIWzDSYtzjB+sutWZrE=;
        b=XcW78meMsHm0SpaX4VrEA6E4dieJGP37g5HDR1y6DPqGx8T31EVyv2759+sjQgyXBo
         zKe5IZITHQmhWhUS1fJYiGKuBbLHTC+aTNrSnhGFPDyUBXtW44LDMvlK/r/+FOQE8M+R
         XUFHsmUeMKxQlxxdHNGeBujV8sNd+fgHDD5No=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LWZqcIgXzVjxh5QO9iqiielSvIWzDSYtzjB+sutWZrE=;
        b=b/ZPsZcySgyX1AiidhpAvvq+9eCoyriVOX8Gm5sxOiGyJgwCt3UvF3OzmscxmJnNAP
         k5eUEHhcIktw+YABCj5ltep8ib7q8UQtxzSG53niJ9yOEZEJbBsHMclMy3AP21fEEWFL
         OyNRItPCWkzdHDwf3rDkGWhY95kjvXsxNZ7HyZQ7qvLgWVLkCXCcM8Hl3zYqf6s8QKnn
         Adqfnot/MJxg8ORHVHmxLV9R1g8sFKmXMPvQZXCgWMBwKz3thcPWDSQso8WSjU0AVuf0
         5FI/R9AgTf74QPkM1BnDD8eSubPTUq+i+kpEhA8gb8SlfdblXqLHAUbcZPHAu1dlI5YW
         YOTg==
X-Gm-Message-State: APjAAAUwsenNq8PLKhIeYYGq7FOGwmhQC52uKjJted2pBJG2bKYXpvVt
        vEybnfWWtVcqWZX5d3xWW/fbsg==
X-Google-Smtp-Source: APXvYqzcNJuWc8MTuhe7A8pH5TeATr3P+P2XEUlqmG+YPokbTDnm72De/WEtbLWj75YMaAAOnnqb+A==
X-Received: by 2002:a17:902:ac97:: with SMTP id h23mr26261351plr.237.1577021365959;
        Sun, 22 Dec 2019 05:29:25 -0800 (PST)
Received: from localhost.localdomain ([49.206.202.16])
        by smtp.gmail.com with ESMTPSA id o2sm12073058pjo.26.2019.12.22.05.29.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Dec 2019 05:29:25 -0800 (PST)
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
Subject: [PATCH v14 0/7] drm/sun4i: Allwinner A64 MIPI-DSI support
Date:   Sun, 22 Dec 2019 18:52:22 +0530
Message-Id: <20191222132229.30276-1-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is v14 version for Allwinner A64 MIPI-DSI support
and here is the previous version set[1]

Changes for v14:
- drop explicit regmap_exit, clk_put
Changes for v13:
- update dt-bindings for A64
- drop has_mod_clk variant
- use regmap bus clock properly
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

[1] https://patchwork.freedesktop.org/series/71131/

Any inputs?
Jagan.

Jagan Teki (7):
  dt-bindings: sun6i-dsi: Document A64 MIPI-DSI controller
  dt-bindings: sun6i-dsi: Add A64 DPHY compatible (w/ A31 fallback)
  drm/sun4i: dsi: Get the mod clock for A31
  drm/sun4i: dsi: Handle bus clock via regmap_mmio_attach_clk
  drm/sun4i: dsi: Add Allwinner A64 MIPI DSI support
  arm64: dts: allwinner: a64: Add MIPI DSI pipeline
  [DO NOT MERGE] arm64: dts: allwinner: bananapi-m64: Enable Bananapi S070WV20-CT16 DSI
    panel

 .../display/allwinner,sun6i-a31-mipi-dsi.yaml | 33 ++++++++++++-
 .../phy/allwinner,sun6i-a31-mipi-dphy.yaml    |  6 ++-
 .../dts/allwinner/sun50i-a64-bananapi-m64.dts | 31 ++++++++++++
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 37 +++++++++++++++
 drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c        | 47 ++++++++++++++-----
 5 files changed, 140 insertions(+), 14 deletions(-)

-- 
2.18.0.321.gffc6fa0e3

