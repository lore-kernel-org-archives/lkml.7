Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4669FC31E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 21:36:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1946D2082C
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 21:36:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730501AbfFRVgt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 17:36:49 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:35808 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730176AbfFRVgt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 17:36:49 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: ezequiel)
        with ESMTPSA id BB3BF2610BE
From:   Ezequiel Garcia <ezequiel@collabora.com>
To:     dri-devel@lists.freedesktop.org
Cc:     linux-rockchip@lists.infradead.org,
        =?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
        Sandy Huang <hjc@rock-chips.com>, kernel@collabora.com,
        Sean Paul <seanpaul@chromium.org>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Douglas Anderson <dianders@chromium.org>,
        Jacopo Mondi <jacopo@jmondi.org>,
        Ilia Mirkin <imirkin@alum.mit.edu>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ezequiel Garcia <ezequiel@collabora.com>
Subject: [PATCH 0/3] RK3288 Gamma LUT
Date:   Tue, 18 Jun 2019 18:34:03 -0300
Message-Id: <20190618213406.7667-1-ezequiel@collabora.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let's support Gamma LUT configuration on RK3288 SoCs.

In order to do so, this series adds a new and optional
address resource.
    
A separate address resource is required because on this RK3288,
the LUT address is after the MMU address, which is requested
by the iommu driver. This prevents the DRM driver
from requesting an entire register space.

The current implementation works for RGB 10-bit tables, as that
is what seems to work on RK3288.

This has been tested on Rock2 Square board, using
a hacked 'modetest' tool, with legacy and atomic APIs. 

Thanks,
Eze

Changes from RFC:
* Request (an optional) address resource for the LUT.
* Add devicetree changes.
* Drop support for RK3399, which doesn't seem to work
  out of the box and needs more research.
* Support pass-thru setting when GAMMA_LUT is NULL.
* Add a check for the gamma size, as suggested by Ilia.
* Move gamma setting to atomic_commit_tail, as pointed
  out by Jacopo/Laurent, is the correct way.

Ezequiel Garcia (3):
  dt-bindings: display: rockchip: document VOP gamma LUT address
  drm/rockchip: Add optional support for CRTC gamma LUT
  ARM: dts: rockchip: Add RK3288 VOP gamma LUT address

 .../display/rockchip/rockchip-vop.txt         |  10 +-
 arch/arm/boot/dts/rk3288.dtsi                 |   6 +-
 drivers/gpu/drm/rockchip/rockchip_drm_fb.c    |   3 +
 drivers/gpu/drm/rockchip/rockchip_drm_vop.c   | 106 ++++++++++++++++++
 drivers/gpu/drm/rockchip/rockchip_drm_vop.h   |   7 ++
 drivers/gpu/drm/rockchip/rockchip_vop_reg.c   |   2 +
 6 files changed, 131 insertions(+), 3 deletions(-)

-- 
2.20.1

