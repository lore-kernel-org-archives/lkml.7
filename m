Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 715C0C282DD
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 21:07:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17003206DB
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 21:07:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b="L+7rDbSu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727191AbgAHVHt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 16:07:49 -0500
Received: from o1.b.az.sendgrid.net ([208.117.55.133]:40472 "EHLO
        o1.b.az.sendgrid.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726636AbgAHVHs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 16:07:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
        h=from:subject:to:cc:content-type:content-transfer-encoding;
        s=001; bh=uN626LkiVQ/IYQ07t5hafh9YVD29M1eVztEzw+fNXzo=;
        b=L+7rDbSuAq0Ia9qc9SRmnvqqaFTp4cKR53aOnONEMw+LyuDyZ8cOez218+z0LcpnDLq+
        I86taNWQY8ybiGAACLpwV/8+cOxvPGEtE+K4o1SB3TPbad7A+2MZm7uAqrh3PhPWfu2bqe
        0DMr6kaAbV/AbTZigTtv9Ag3u1KYVXdtg=
Received: by filterdrecv-p3mdw1-56c97568b5-m6gw4 with SMTP id filterdrecv-p3mdw1-56c97568b5-m6gw4-19-5E1644A3-A
        2020-01-08 21:07:47.202815829 +0000 UTC m=+1974280.427826101
Received: from bionic.localdomain (unknown [98.128.173.80])
        by ismtpd0005p1lon1.sendgrid.net (SG) with ESMTP id lJXBfmg9SiKtZf1InJRBnw
        Wed, 08 Jan 2020 21:07:47.011 +0000 (UTC)
From:   Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH v2 00/14] Support more HDMI modes on RK3228/RK3328
Date:   Wed, 08 Jan 2020 21:07:47 +0000 (UTC)
Message-Id: <20200108210740.28769-1-jonas@kwiboo.se>
X-Mailer: git-send-email 2.17.1
X-SG-EID: =?us-ascii?Q?TdbjyGynYnRZWhH+7lKUQJL+ZxmxpowvO2O9SQF5CwCVrYgcwUXgU5DKUU3QxA?=
 =?us-ascii?Q?fZekEeQsTe+RrMu3cja6a0h8tx7bkLKAWnDQBpQ?=
 =?us-ascii?Q?ZEr7pUsi+B2Ai3fmPPFJg85m7ZXab8HQv0FysAB?=
 =?us-ascii?Q?wzv2Lwwd2atjV7VtUYiUxWyFeOGsZB6BWRCHaiC?=
 =?us-ascii?Q?8frswzSua6VEYbRb4fRqHHmqC5RsNHtYPSR4Lf4?=
 =?us-ascii?Q?CKUZOgPJ7ap+SBQlFBWbsbNgIa8bLzLYCr6l=2Ff5?=
 =?us-ascii?Q?T0ljA2CyRHNjrm4jqXqoA=3D=3D?=
To:     Heiko Stuebner <heiko@sntech.de>, Sandy Huang <hjc@rock-chips.com>
Cc:     Jonas Karlman <jonas@kwiboo.se>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Zheng Yang <zhengyang@rock-chips.com>,
        linux-rockchip@lists.infradead.org,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series make it possible to use more HDMI modes on RK3328,
and presumably also on RK3228. It also prepares for a future YUV420 and
10-bit output series.

Part of this has been reworked from vendor BSP 4.4 kernel commits.

Patch 1-5 fixes issues and shortcomings in the inno hdmi phy driver.

Patch 6 prepares for use of high TMDS bit rates used with HDMI 2.0 and
10-bit output modes.

Patch 7-13 changes rk3228/rk3328 to use mode_valid functions suited for
the inno hdmi phy instead of the dw-hdmi phy. These changes allows for
more CEA modes to be usable, e.g. some 4K and fractal modes.

Patch 14 adds support for more pixel clock rates in order to support
common DMT modes in addition to CEA modes.

Note: I have only been able to build test RK322x related changes
as I do not have any RK322x device to test on.

All modes, including fractal modes, has been tested with modetest on
a RK3328 Rock64 device using e.g.

  modetest -M rockchip -s 39:3840x2160-29.97

Changes in v2:
  - collect acked-by tag
  - drop the limit resolution width to 3840 patch

This series is also available at [1] and the early work on YUV420 and
10-bit output is available at [2].

[1] https://github.com/Kwiboo/linux-rockchip/commits/next-20200108-inno-hdmi-phy
[2] https://github.com/Kwiboo/linux-rockchip/commits/next-20200108-bus-format

Regards,
Jonas

Algea Cao (1):
  phy/rockchip: inno-hdmi: Support more pre-pll configuration

Huicong Xu (1):
  phy/rockchip: inno-hdmi: force set_rate on power_on

Jonas Karlman (11):
  phy/rockchip: inno-hdmi: use correct vco_div_5 macro on rk3328
  phy/rockchip: inno-hdmi: remove unused no_c from rk3328 recalc_rate
  phy/rockchip: inno-hdmi: do not power on rk3328 post pll on reg write
  drm/rockchip: dw-hdmi: allow high tmds bit rates
  drm/rockchip: dw-hdmi: require valid vpll clock rate on rk3228/rk3328
  clk: rockchip: set parent rate for DCLK_VOP clock on rk3228
  arm64: dts: rockchip: increase vop clock rate on rk3328
  arm64: dts: rockchip: add vpll clock to hdmi node on rk3328
  ARM: dts: rockchip: add vpll clock to hdmi node on rk3228
  drm/rockchip: dw-hdmi: limit tmds to 340mhz on rk3228/rk3328
  drm/rockchip: dw-hdmi: remove unused plat_data on rk3228/rk3328

Zheng Yang (1):
  phy/rockchip: inno-hdmi: round fractal pixclock in rk3328 recalc_rate

 arch/arm/boot/dts/rk322x.dtsi                 |   4 +-
 arch/arm64/boot/dts/rockchip/rk3328.dtsi      |   6 +-
 drivers/clk/rockchip/clk-rk3228.c             |   2 +-
 drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c   |  47 ++++++--
 drivers/phy/rockchip/phy-rockchip-inno-hdmi.c | 110 ++++++++++++------
 5 files changed, 120 insertions(+), 49 deletions(-)

-- 
2.17.1

