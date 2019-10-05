Return-Path: <SRS0=6Pxm=X6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F997C47404
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Oct 2019 14:19:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E61EF22466
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Oct 2019 14:19:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="RLuH2sZm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728461AbfJEOT1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Oct 2019 10:19:27 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:34383 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727715AbfJEOT0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Oct 2019 10:19:26 -0400
Received: by mail-pf1-f196.google.com with SMTP id b128so5694860pfa.1
        for <linux-kernel@vger.kernel.org>; Sat, 05 Oct 2019 07:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jdWK5vcnTFqPnDbfTqA+QzxqCP19t4414D5Iqnjivjw=;
        b=RLuH2sZmuDvU+uZL9GR5HKUHIyvGHORFuotX786UAEAO4gjExN56qdYbwWBsyNCJB9
         lB2cWvH+S52Iu4E0wWtFxOctbuBR6AG5xSCkDqwE5f1QZ1hxqVVtCJMIZEnl9D49ZEbm
         U98Psud4qpBIol8tKfWnPmsQqbYwrRnDBOLeA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jdWK5vcnTFqPnDbfTqA+QzxqCP19t4414D5Iqnjivjw=;
        b=fRPK1azv4C1p7WhV3aYPF/KYx8dIBjrF9w1OkxA5Eb8DHKOQIPFkjoA5bqBWof6zpt
         aKKESE6ZtBLisvw4kVvD21wyLst3dppqCCvosAZcJv3DTfV4ZrlTtMGX3F2q0WCgbSOp
         zEdIMAYXgEsLUmACdhYNf/kT2nhFT4nDbq0MTf6IQYo0as9F6C5CRoTwD6xrAPMyt36n
         t7AanfBbnEwtxrBGTitL2ztHdWpCPCCK/Fzu9dQuR+9vazUPN4hMKQN2mu5/Zf4LyG1X
         tx6X1no6dhrToF+r1zpC4I0wydRJ58Y0OdTyMYcOqlyU8e9joFSos9R4bdxUhHAmckxZ
         zM1A==
X-Gm-Message-State: APjAAAUzuUCbex/AxjUklplsbIM9zMhjnPMFCC0XNpF/rWk26tnVFZZk
        R+e68M0pZ7JL1CX5TXCmelIbJ1bVIvM=
X-Google-Smtp-Source: APXvYqwk1UplFcpr14yl8Ol/aKp4v+RqV5P1b8raPNprUYPv/a1x8kHBAbG4SDprN6vZk6cwyggzxw==
X-Received: by 2002:a63:d754:: with SMTP id w20mr6349432pgi.74.1570285163831;
        Sat, 05 Oct 2019 07:19:23 -0700 (PDT)
Received: from localhost.localdomain ([115.97.180.31])
        by smtp.gmail.com with ESMTPSA id y138sm8977604pfb.174.2019.10.05.07.19.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Oct 2019 07:19:22 -0700 (PDT)
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
        devicetree@vger.kernel.org, Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH v10 0/6] drm/sun4i: Allwinner A64 MIPI-DSI support
Date:   Sat,  5 Oct 2019 19:49:07 +0530
Message-Id: <20191005141913.22020-1-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is v10 version for Allwinner A64 MIPI-DSI support
and here is the previous version set[1].

This series on top of drm-misc/for-linux-next along with video start
delay fix [2]

Changes for v10:
- updated dt-bindings as per .yaml format
- rebased on drm-misc/for-linux-next
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

[1] https://patchwork.freedesktop.org/series/61310/
[2] https://patchwork.freedesktop.org/patch/334086/

Any inputs?
Jagan.

Jagan Teki (6):
  dt-bindings: sun6i-dsi: Add A64 MIPI-DSI compatible
  dt-bindings: sun6i-dsi: Add A64 DPHY compatible (w/ A31 fallback)
  drm/sun4i: dsi: Add has_mod_clk quirk
  drm/sun4i: dsi: Add Allwinner A64 MIPI DSI support
  arm64: dts: allwinner: a64: Add MIPI DSI pipeline
  [DO NOT MERGE] arm64: dts: allwinner: bananapi-m64: Enable Bananapi S070WV20-CT16 DSI
    panel

 .../display/allwinner,sun6i-a31-mipi-dsi.yaml |  4 +-
 .../phy/allwinner,sun6i-a31-mipi-dphy.yaml    |  6 ++-
 .../dts/allwinner/sun50i-a64-bananapi-m64.dts | 31 ++++++++++++++
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 38 +++++++++++++++++
 drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c        | 42 ++++++++++++++-----
 drivers/gpu/drm/sun4i/sun6i_mipi_dsi.h        |  5 +++
 6 files changed, 114 insertions(+), 12 deletions(-)

-- 
2.18.0.321.gffc6fa0e3

