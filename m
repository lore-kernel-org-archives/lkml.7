Return-Path: <SRS0=Dm7n=X7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38BD2C10F14
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 16:04:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A96B20835
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 16:04:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726822AbfJFQEL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Oct 2019 12:04:11 -0400
Received: from hermes.aosc.io ([199.195.250.187]:47334 "EHLO hermes.aosc.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726430AbfJFQEL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Oct 2019 12:04:11 -0400
Received: from localhost (localhost [127.0.0.1]) (Authenticated sender: icenowy@aosc.io)
        by hermes.aosc.io (Postfix) with ESMTPSA id B0BE18289D;
        Sun,  6 Oct 2019 16:04:06 +0000 (UTC)
From:   Icenowy Zheng <icenowy@aosc.io>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jagan Teki <jagan@amarulasolutions.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com, Icenowy Zheng <icenowy@aosc.io>
Subject: [PATCH v2 0/3] drm/sun4i: dsi: misc fixes
Date:   Mon,  7 Oct 2019 00:02:59 +0800
Message-Id: <20191006160303.24413-1-icenowy@aosc.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset contains several fixes to the sun6i_mipi_dsi driver.

First, it's a rebased version of video start delay porch fix from Jagan
Teki.

The next patch fixes the overhead of HFP packet, according to the source
code of BSP [1].

The final patch fixes DCS long write, which fixes initialization issue
with a panel with ST7703 controller (XBD599 panel used by PinePhone).
This seems to be a misread of [2]. (The formula in [2] is para_num+1,
and the code of the sun6i_mipi_dsi driver uses tx_len, which is the
length including the command; thus tx_len is equal to para_num+1, so it
shouldn't be added with 1 for another time.)

Icenowy Zheng (2):
  drm/sun4i: dsi: fix the overhead of the horizontal front porch
  drm/sun4i: sun6i_mipi_dsi: fix DCS long write packet length

Jagan Teki (1):
  drm/sun4i: dsi: Fix video start delay computation

[1] https://github.com/ayufan-pine64/linux-pine64/blob/my-hacks-1.2-with-drm/drivers/video/sunxi/disp2/disp/de/lowlevel_sun50iw1/de_dsi.c#L920

[2] https://github.com/ayufan-pine64/linux-pine64/blob/my-hacks-1.2-with-drm/drivers/video/sunxi/disp2/disp/de/lowlevel_sun50iw1/de_dsi.c#L227

 drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

-- 
2.21.0

