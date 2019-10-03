Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 668B5C10F14
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 06:46:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D3A820815
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 06:46:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="UlIYKajk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727468AbfJCGqC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 02:46:02 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:33981 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725497AbfJCGqC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 02:46:02 -0400
Received: by mail-pf1-f193.google.com with SMTP id b128so1107507pfa.1
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2019 23:46:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tmedhzX9C+cN8nQlDlRuERilhLkK7PZoYSIAR3+m8Og=;
        b=UlIYKajkWrpON8MaHPgN7XHZDHJbOBa85ryXrpg2AQ4pavpCqkCc8RsWPqMMSIBkw/
         sB0z2HVCWKGIHFCBf2SrufCZhwoSyh5DYyjEFygGztaYKCR3A7mgmFjz87dQ1b1IR6AY
         rksgIwmeq/xMyCqS60GUxfNLTEpyrjYwTXmVE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tmedhzX9C+cN8nQlDlRuERilhLkK7PZoYSIAR3+m8Og=;
        b=Bc6hfB5Qw7AiqkWt87e1K9QS7IAUA52ClidiQ7hUU0s/jUTGHkWeg4s4CSwTl2OZCo
         Pl7yvJ66kMurwUtwh4fKr3FTDcJqbtOqy/LB3mKgfKeamJ8fw4JctjledhF2SictykVN
         uWswlCcbsNTF1N/zggixSOcVoX5P95AtkgBmfc04OAzAvDu7+aPc/5gnIM/Q+P4z7N+m
         7F7HdIIGpK5lnUQqqYDXLf3Vf5KVW3e7hozGaOjQ554bt7SPqZX+YqDFkdDQjvGhrbRQ
         /OTE1QbSOqxVTeYQG9gcbq+9ceVBGXGK66HFNNOU1Z6IT0J+wyO0byzGv4nkmw1TwYnh
         vKBg==
X-Gm-Message-State: APjAAAWZTMR6yXOzzD14RhiLWNqyOhGh5RqKbiV4IH60jS82DfIq2uLK
        Q2/nBRMseYXJdzv1/XQbA5MtLw==
X-Google-Smtp-Source: APXvYqxQCK4/7MbbkBagZV2vOcHKusaEK4mXaxvR66zcwNTDIsrsGqkeRKcQ4QxTDvq2Kmwy+8UUQw==
X-Received: by 2002:a63:4762:: with SMTP id w34mr8014842pgk.202.1570085160475;
        Wed, 02 Oct 2019 23:46:00 -0700 (PDT)
Received: from localhost.localdomain ([49.206.203.121])
        by smtp.gmail.com with ESMTPSA id b18sm1423294pfi.157.2019.10.02.23.45.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2019 23:45:59 -0700 (PDT)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     michael@amarulasolutions.com, Icenowy Zheng <icenowy@aosc.io>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH v11 0/7] drm/sun4i: dsi: Fixes/updates (A33 reworked!)
Date:   Thu,  3 Oct 2019 12:15:20 +0530
Message-Id: <20191003064527.15128-1-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is v11 version changes for previous series[1].

This series dropped the tcon->dclk_min_div and tcon->dclk_max_div
patches, since the discussion on the respective threads[2][3] 
not finalized or not agree on both the ends.

This series mostly the commit messages changes suggested by Chen-Yu.

Most of these issues are reproduced while supporting Allwinner A64
MIPI-DSI [4] but to confirm it with other SoC this series is reworked
on A33 since the controller tested it A33 as of now.

Since we don't have proper evidence and documentation for dsi controller
in Allwinner, these changes are more likely to rely on new working BSP
codes (even the initial driver written as per this rule).

All these fixes/updates are tested in "bananapi,s070wv20-ct16" panel
on Allwinner A33, the same panel timings are available in panel-simple
in mainline tree.

Changes for v11:
- Drop DCLK dividers patches
- Updated the commit message changes suggested by Chen-Yu
- rebased on linux-next
Changes for v10:
- reworked previous "Fixes/updates" patches on A33
- reworked previous A64 DSI fixes on A33
- added proper detailed commit messages with logs
- tested on BPI-M2M board.
Changes for v9:
- rebase on drm-misc
- update commit messages
- add hsync_porch overflow patch
Changes for v8:
- rebase on master
- rework on commit messages
- rework video start delay
- include drq changes from previous version
Changes for v7:
- rebase on master
- collect Merlijn Wajer Tested-by credits.
Changes for v6:
- fixed all burst mode patches as per previous version comments
- rebase on master
- update proper commit message
- dropped unneeded comments
- order the patches that make review easy
Changes for v5, v4, v3, v2:
- use existing driver code construct for hblk computation
- create separate function for vblk computation
- cleanup commit messages
- update proper commit messages
- fixed checkpatch warnings/errors
- use proper return value for tcon0 probe
- add logic to get tcon0 divider values
- simplify timings code to support burst mode
- fix drq computation return values
- rebase on master

Any inputs?
Jagan.

[1] https://patchwork.freedesktop.org/series/60847/
[2] https://patchwork.freedesktop.org/patch/305923/?series=60847&rev=1
[3] https://patchwork.kernel.org/patch/10779937/
[4] https://patchwork.freedesktop.org/series/57834/

Jagan Teki (7):
  drm/sun4i: dsi: Fix TCON DRQ set bits
  drm/sun4i: dsi: Update start value in video start delay
  drm/sun4i: dsi: Fix video start delay computation
  dt-bindings: sun6i-dsi: Add VCC-DSI supply property
  drm/sun4i: sun6i_mipi_dsi: Add VCC-DSI regulator support
  [DO NOT MERGE] drm/panel: Add Bananapi S070WV20-CT16 ICN6211 MIPI-DSI to RGB bridge
  [DO NOT MERGE] ARM: dts: sun8i: bananapi-m2m: Enable Bananapi S070WV20-CT16 DSI panel

 .../display/allwinner,sun6i-a31-mipi-dsi.yaml |   3 +
 arch/arm/boot/dts/sun8i-r16-bananapi-m2m.dts  |  40 +++
 drivers/gpu/drm/panel/Kconfig                 |   9 +
 drivers/gpu/drm/panel/Makefile                |   1 +
 .../panel/panel-bananapi-s070wv20-icn6211.c   | 293 ++++++++++++++++++
 drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c        |  32 +-
 drivers/gpu/drm/sun4i/sun6i_mipi_dsi.h        |   2 +
 7 files changed, 376 insertions(+), 4 deletions(-)
 create mode 100644 drivers/gpu/drm/panel/panel-bananapi-s070wv20-icn6211.c

-- 
2.18.0.321.gffc6fa0e3

