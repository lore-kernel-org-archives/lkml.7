Return-Path: <SRS0=+gZy=2O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D09FC3F68F
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Dec 2019 14:39:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CF9E206B7
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Dec 2019 14:39:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726322AbfLXOjG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Dec 2019 09:39:06 -0500
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:51819 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726171AbfLXOjG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Dec 2019 09:39:06 -0500
X-Originating-IP: 91.224.148.103
Received: from localhost.localdomain (unknown [91.224.148.103])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id 80D8FE0003;
        Tue, 24 Dec 2019 14:39:01 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Sandy Huang <hjc@rock-chips.com>,
        Heiko Stuebner <heiko@sntech.de>,
        <linux-rockchip@lists.infradead.org>
Cc:     <linux-kernel@vger.kernel.org>, dri-devel@lists.freedesktop.org,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH v2 00/11] Add PX30 LVDS support
Date:   Tue, 24 Dec 2019 15:38:49 +0100
Message-Id: <20191224143900.23567-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This series aims at supporting LVDS on PX30.

A first couple of patches update the documentation with the new
compatible and the presence of a PHY. Then, the existing Rockchip
driver is cleaned and extended to support PX30 specificities. Finally,
the PX30 DTSI is updated with CRTC routes, the DSI DPHY and the LVDS
IP itself.

Cheers,
Miquèl

Changes since v1:
* Added Rob's Ack.
* Used "must" instead of "should" in the bindings.
* Precised that phy-names is an optional property in the case of
  PX30.
* Renamed the WRITE_EN macro into HIWORD_UPDATE to be aligned with
  other files.
* Removed extra configuration, not needed for generic panels (see
  Sandy Huang answer).
* Dropped the display-subsystem routes (useless).
* Merged two patches to avoid phandle interdependencies in graphs and
  intermediate build errors.

Miquel Raynal (11):
  dt-bindings: display: rockchip-lvds: Declare PX30 compatible
  dt-bindings: display: rockchip-lvds: Document PX30 PHY
  drm/rockchip: lvds: Fix indentation of a #define
  drm/rockchip: lvds: Harmonize function names
  drm/rockchip: lvds: Change platform data
  drm/rockchip: lvds: Create an RK3288 specific probe function
  drm/rockchip: lvds: Helpers should return decent values
  drm/rockchip: lvds: Pack functions together
  drm/rockchip: lvds: Add PX30 support
  arm64: dts: rockchip: Add PX30 DSI DPHY
  arm64: dts: rockchip: Add PX30 LVDS

 .../display/rockchip/rockchip-lvds.txt        |   4 +
 arch/arm64/boot/dts/rockchip/px30.dtsi        |  48 ++
 drivers/gpu/drm/rockchip/rockchip_lvds.c      | 486 ++++++++++++------
 drivers/gpu/drm/rockchip/rockchip_lvds.h      |  19 +-
 4 files changed, 401 insertions(+), 156 deletions(-)

-- 
2.20.1

