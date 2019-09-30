Return-Path: <SRS0=rUXN=XZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40088C32792
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 22:28:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F7A12168B
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 22:28:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730900AbfI3W2P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Sep 2019 18:28:15 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:60246 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726858AbfI3W2O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Sep 2019 18:28:14 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: ezequiel)
        with ESMTPSA id 2D967283BA6
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
Subject: [PATCH v3 0/5] RK3288 Gamma LUT
Date:   Mon, 30 Sep 2019 19:27:57 -0300
Message-Id: <20190930222802.32088-1-ezequiel@collabora.com>
X-Mailer: git-send-email 2.22.0
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

This has been tested on a Rock2 Square board, using
'modetest' tool (modetest now supports GAMMA_LUT property),
with legacy and atomic APIs.

In addition, I've tested it with Jacopo's modified kmsxx [1],
See the rcar-du color management series for more information [2].

[1] https://jmondi.org/cgit/kmsxx/
[2] https://lkml.org/lkml/2019/9/6/490

Thanks,
Eze

Changes from v2:
* revert Sean Paul's patch, in order to use
  atomic_commit_tail hook.
* add RFC/patch for color management on resume.

Changes from v1:
* drop explicit linear LUT after finding a proper
  way to disable gamma correction.
* avoid setting gamma is the CRTC is not active.
* s/int/unsigned int as suggested by Jacopo.
* only enable color management and set gamma size
  if gamma LUT is supported, suggested by Doug.
* drop the reg-names usage, and instead just use indexed reg
  specifiers, suggested by Doug.

Changes from RFC:
* Request (an optional) address resource for the LUT.
* Add devicetree changes.
* Drop support for RK3399, which doesn't seem to work
  out of the box and needs more research.
* Support pass-thru setting when GAMMA_LUT is NULL.
* Add a check for the gamma size, as suggested by Ilia.
* Move gamma setting to atomic_commit_tail, as pointed
  out by Jacopo/Laurent, is the correct way.

Ezequiel Garcia (5):
  Revert "drm/rockchip: Use drm_atomic_helper_commit_tail_rpm"
  dt-bindings: display: rockchip: document VOP gamma LUT address
  drm/rockchip: Add optional support for CRTC gamma LUT
  ARM: dts: rockchip: Add RK3288 VOP gamma LUT address
  RFC: drm/atomic-helper: Reapply color transformation after resume

 .../display/rockchip/rockchip-vop.txt         |   6 +-
 arch/arm/boot/dts/rk3288.dtsi                 |   4 +-
 drivers/gpu/drm/drm_atomic_helper.c           |  12 ++
 drivers/gpu/drm/rockchip/rockchip_drm_fb.c    |  24 +++-
 drivers/gpu/drm/rockchip/rockchip_drm_vop.c   | 114 ++++++++++++++++++
 drivers/gpu/drm/rockchip/rockchip_drm_vop.h   |   7 ++
 drivers/gpu/drm/rockchip/rockchip_vop_reg.c   |   2 +
 7 files changed, 165 insertions(+), 4 deletions(-)

-- 
2.22.0

