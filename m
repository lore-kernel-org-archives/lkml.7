Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82A0FECE59D
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 08:54:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66C9020872
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 08:54:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391804AbfJPIyy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 04:54:54 -0400
Received: from relay10.mail.gandi.net ([217.70.178.230]:38265 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732135AbfJPIyx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 04:54:53 -0400
Received: from uno.localdomain (2-224-242-101.ip172.fastwebnet.it [2.224.242.101])
        (Authenticated sender: jacopo@jmondi.org)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id 87D0224000E;
        Wed, 16 Oct 2019 08:54:48 +0000 (UTC)
From:   Jacopo Mondi <jacopo+renesas@jmondi.org>
To:     laurent.pinchart@ideasonboard.com,
        kieran.bingham+renesas@ideasonboard.com, geert@linux-m68k.org,
        horms@verge.net.au, uli+renesas@fpond.eu
Cc:     Jacopo Mondi <jacopo+renesas@jmondi.org>, airlied@linux.ie,
        daniel@ffwll.ch, linux-renesas-soc@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 0/8] drm: rcar-du: Add Color Management Module (CMM)
Date:   Wed, 16 Oct 2019 10:55:40 +0200
Message-Id: <20191016085548.105703-1-jacopo+renesas@jmondi.org>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Minimal increment to the CMM series, this time should really be the last one.

Just missing Rob's ack on [1/8] and Laurent's one on [5/8].

Changelog is minimal:
CMM
- Remove the cmm_config.enable flag. The cmm_config.table field validity is
  used to enable/disable the LUT operations
- Expand comments as suggested by Laurent

CRTC
- use drm_color_lut_size() to check the LUT table size
- Inline calls to rcar_cmm_enable()/disable()
- Add TODO entries as suggested by Laurent

For the record, the full series changelog is available at:
https://paste.debian.net/1107427/

v5 from yesterday with informations on testing is available at:
https://lkml.org/lkml/2019/10/15/337

Geert will you collect for DTS patches for the next release?
I assume the DU changes go through Laurent instead ?

Thanks
   j

Jacopo Mondi (8):
  dt-bindings: display: renesas,cmm: Add R-Car CMM documentation
  dt-bindings: display, renesas,du: Document cmms property
  drm: rcar-du: Add support for CMM
  drm: rcar-du: kms: Initialize CMM instances
  drm: rcar-du: crtc: Control CMM operations
  drm: rcar-du: crtc: Register GAMMA_LUT properties
  arm64: dts: renesas: Add CMM units to Gen3 SoCs
  drm: rcar-du: kms: Expand comment in vsps parsing routine

 .../bindings/display/renesas,cmm.yaml         |  67 ++++++
 .../bindings/display/renesas,du.txt           |   5 +
 arch/arm64/boot/dts/renesas/r8a7795.dtsi      |  39 ++++
 arch/arm64/boot/dts/renesas/r8a7796.dtsi      |  31 ++-
 arch/arm64/boot/dts/renesas/r8a77965.dtsi     |  31 ++-
 arch/arm64/boot/dts/renesas/r8a77990.dtsi     |  21 ++
 arch/arm64/boot/dts/renesas/r8a77995.dtsi     |  21 ++
 drivers/gpu/drm/rcar-du/Kconfig               |   7 +
 drivers/gpu/drm/rcar-du/Makefile              |   1 +
 drivers/gpu/drm/rcar-du/rcar_cmm.c            | 212 ++++++++++++++++++
 drivers/gpu/drm/rcar-du/rcar_cmm.h            |  58 +++++
 drivers/gpu/drm/rcar-du/rcar_du_crtc.c        |  65 ++++++
 drivers/gpu/drm/rcar-du/rcar_du_crtc.h        |   2 +
 drivers/gpu/drm/rcar-du/rcar_du_drv.h         |   2 +
 drivers/gpu/drm/rcar-du/rcar_du_group.c       |  10 +
 drivers/gpu/drm/rcar-du/rcar_du_group.h       |   2 +
 drivers/gpu/drm/rcar-du/rcar_du_kms.c         |  82 ++++++-
 drivers/gpu/drm/rcar-du/rcar_du_regs.h        |   5 +
 18 files changed, 658 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/display/renesas,cmm.yaml
 create mode 100644 drivers/gpu/drm/rcar-du/rcar_cmm.c
 create mode 100644 drivers/gpu/drm/rcar-du/rcar_cmm.h

--
2.23.0

