Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 263F0C04AAF
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 09:07:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89D3620644
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 09:07:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="D19AjoC0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731791AbfETJHN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 05:07:13 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:44431 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725764AbfETJHN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 05:07:13 -0400
Received: by mail-pl1-f196.google.com with SMTP id c5so6396618pll.11
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 02:07:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5cW/Ykas8y/ulbRnNYCc1U7OJGD9GTeKEiiivcIo+lE=;
        b=D19AjoC0eMZThH2guQSI02LbCXWxIu9yFHbIFGyjKVoGdpanTTC1WH7LHFeWV3LN9c
         d+yGjqnD+B5OyZm2YFjaXIFqcJ595lDsnFX1pVaqXzeFzILB+N3gsgqf8ztcbrMrnWiF
         9sRtvb5LzYCHUKcbV/RZZSIPazKFf+S+J4nbg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5cW/Ykas8y/ulbRnNYCc1U7OJGD9GTeKEiiivcIo+lE=;
        b=Ef/wqlJQaYRM939FQuBuF+zLQymwZ0zRniUNo5PiLqYDvcrcUcmF9lU5MiuHjntcVH
         fhG/X+yxXje4eUNYZrvx+mOmOySbmssnytvwu1wgNvHoMs3EtlU9MrAqWE2ZYMqct+VE
         6m2K5QTFUbuSwuH4mb6ImUCd/nSb6wh7D8HmR7YX7BRsYrD0RYvKJZExpYK+6qBGt+fQ
         fywJGnGogmBOKoLp8s5/Gvwb4qJ0s9TKN4pwQ2Qy1mbn3o6Pv+ANIDIUl0+z+R7mUxRy
         588w117HojylaGhm0Ifplx0sfGvJTMJFkkMELqmS7LutXdO9D3pOqJfNL6U5QfPKiLlu
         oWQQ==
X-Gm-Message-State: APjAAAXLnG8kb78t477FNnEVz7lCrmxphTnENELnJsb1nJP6xNLTfoiY
        OQeX7TPosZzKe6Ilt+BVMePUzQ==
X-Google-Smtp-Source: APXvYqz8pwdU8mC+t3ZXYb6Q+Pg04mL44SIkX5k3pYjBHVjtKxFYa0Qa7kCCe3U/5VkpdkgVqE12iA==
X-Received: by 2002:a17:902:2a07:: with SMTP id i7mr76936917plb.125.1558343232148;
        Mon, 20 May 2019 02:07:12 -0700 (PDT)
Received: from localhost.localdomain ([183.82.227.193])
        by smtp.gmail.com with ESMTPSA id d15sm51671614pfm.186.2019.05.20.02.07.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 May 2019 02:07:11 -0700 (PDT)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Chen-Yu Tsai <wens@csie.org>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     bshah@mykolab.com, Vasily Khoruzhick <anarsoul@gmail.com>,
        powerpan@qq.com, michael@amarulasolutions.com,
        linux-amarula@amarulasolutions.com, linux-sunxi@googlegroups.com,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH v10 00/11] drm/sun4i: dsi: Fixes/updates (A33 reworked!)
Date:   Mon, 20 May 2019 14:33:07 +0530
Message-Id: <20190520090318.27570-1-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Most of these issues are reproduced while supporting Allwinner A64
MIPI-DSI [1] but to confirm it with other SoC this series is reworked
on A33 since the controller tested it A33 as of now.

Since we don't have proper evidence and documentation for dsi controller
in Allwinner, these changes are more likely to rely on new working BSP
codes (even the initial driver written as per this rule).

All these fixes/updates are tested in "bananapi,s070wv20-ct16" panel
on Allwinner A33, the same panel timings are available in panel-simple
in mainline tree.

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

[1] https://patchwork.freedesktop.org/series/57834/

Jagan Teki (11):
  drm/sun4i: dsi: Fix TCON DRQ set bits
  drm/sun4i: dsi: Update start value in video start delay
  drm/sun4i: dsi: Fix video start delay computation
  drm/sun4i: tcon: Compute DCLK dividers based on format, lanes
  drm/sun4i: tcon: Export get tcon0 routine
  drm/sun4i: dsi: Probe tcon0 during dsi_bind
  drm/sun4i: dsi: Get tcon0_div at runtime
  dt-bindings: sun6i-dsi: Add VCC-DSI supply property
  drm/sun4i: sun6i_mipi_dsi: Add VCC-DSI regulator support
  [DO NOT MERGE] drm/panel: Add Bananapi S070WV20-CT16 ICN6211 MIPI-DSI to RGB bridge
  [DO NOT MERGE] ARM: dts: sun8i: bananapi-m2m: Enable Bananapi S070WV20-CT16 DSI panel

 .../bindings/display/sunxi/sun6i-dsi.txt      |   1 +
 arch/arm/boot/dts/sun8i-r16-bananapi-m2m.dts  |  40 +++
 drivers/gpu/drm/panel/Kconfig                 |   9 +
 drivers/gpu/drm/panel/Makefile                |   1 +
 .../panel/panel-bananapi-s070wv20-icn6211.c   | 293 ++++++++++++++++++
 drivers/gpu/drm/sun4i/sun4i_tcon.c            |   7 +-
 drivers/gpu/drm/sun4i/sun4i_tcon.h            |   1 +
 drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c        |  46 ++-
 drivers/gpu/drm/sun4i/sun6i_mipi_dsi.h        |   4 +-
 9 files changed, 393 insertions(+), 9 deletions(-)
 create mode 100644 drivers/gpu/drm/panel/panel-bananapi-s070wv20-icn6211.c

-- 
2.18.0.321.gffc6fa0e3

