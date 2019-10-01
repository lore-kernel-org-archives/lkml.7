Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABFA1FA373E
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 08:11:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CD442133F
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 08:11:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732636AbfJAILG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 04:11:06 -0400
Received: from hermes.aosc.io ([199.195.250.187]:51105 "EHLO hermes.aosc.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726148AbfJAILF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 04:11:05 -0400
X-Greylist: delayed 437 seconds by postgrey-1.27 at vger.kernel.org; Tue, 01 Oct 2019 04:11:05 EDT
Received: from localhost (localhost [127.0.0.1]) (Authenticated sender: icenowy@aosc.io)
        by hermes.aosc.io (Postfix) with ESMTPSA id DFC5182AC9;
        Tue,  1 Oct 2019 08:03:44 +0000 (UTC)
From:   Icenowy Zheng <icenowy@aosc.io>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com, Icenowy Zheng <icenowy@aosc.io>
Subject: [PATCH 0/3] drm/sun4i: dsi: misc timing fixes
Date:   Tue,  1 Oct 2019 16:02:50 +0800
Message-Id: <20191001080253.6135-1-icenowy@aosc.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset fixes some portion of timing calculation in sun6i_mipi_dsi
driver according to the BSP driver.

Two of the patches are reverting, one is fixing some misread of the BSP
source code, another is fixing a wrong refactor that actually breaks the
formula.

The other non-reverting patch is fixing a porch error which is usually
seen in the original driver commit. Most of porch errors are then fixed,
but this one gets ignored.

By applying these patches, several DSI panels are tested to be driven
properly by the timing provided by the vendor, including the LCD panel
of PinePhone "Don't Be Evil" DevKit, the final PinePhone panel and the
panel on PineTab. Without these patches they need dirty timing hacks to
work.

Icenowy Zheng (3):
  Revert "drm/sun4i: dsi: Change the start delay calculation"
  drm/sun4i: dsi: fix DRQ calculation
  Revert "drm/sun4i: dsi: Rework a bit the hblk calculation"

 drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

-- 
2.21.0

