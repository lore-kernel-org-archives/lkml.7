Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDD53C4360C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 23:00:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D05C420679
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 23:00:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729524AbfJHXAz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 19:00:55 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:52062 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725942AbfJHXAz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 19:00:55 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: ezequiel)
        with ESMTPSA id 75A41283BB8
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
Subject: [PATCH v4 0/3] RK3288 Gamma LUT
Date:   Tue,  8 Oct 2019 20:00:35 -0300
Message-Id: <20191008230038.24037-1-ezequiel@collabora.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Following Sean's comments, here's a new version.

On this new iteration, we modify the GAMMA LUT
on .atomic_enable and .atomic_begin.

With this change, the GAMMA settings are effectively
re-applied after resuming the machine, so the previous
patch "RFC: drm/atomic-helper: Reapply color transformation after
resume" is now dropped.

Also, I dropped Reviewed-bys tags on patch 2, given
the implementation is a bit different now.

Thanks!

Ezequiel Garcia (3):
  dt-bindings: display: rockchip: document VOP gamma LUT address
  drm/rockchip: Add optional support for CRTC gamma LUT
  ARM: dts: rockchip: Add RK3288 VOP gamma LUT address

 .../display/rockchip/rockchip-vop.txt         |   6 +-
 arch/arm/boot/dts/rk3288.dtsi                 |   4 +-
 drivers/gpu/drm/rockchip/rockchip_drm_fb.c    |   1 +
 drivers/gpu/drm/rockchip/rockchip_drm_vop.c   | 125 ++++++++++++++++++
 drivers/gpu/drm/rockchip/rockchip_drm_vop.h   |   5 +
 drivers/gpu/drm/rockchip/rockchip_vop_reg.c   |   2 +
 6 files changed, 140 insertions(+), 3 deletions(-)

-- 
2.22.0

