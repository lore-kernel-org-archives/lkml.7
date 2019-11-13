Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B0AFC17447
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 10:04:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D05421D7F
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 10:04:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727324AbfKMKEO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 05:04:14 -0500
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:40513 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726155AbfKMKEN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 05:04:13 -0500
X-Originating-IP: 93.34.114.233
Received: from uno.lan (93-34-114-233.ip49.fastwebnet.it [93.34.114.233])
        (Authenticated sender: jacopo@jmondi.org)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id C1341C000F;
        Wed, 13 Nov 2019 10:04:07 +0000 (UTC)
From:   Jacopo Mondi <jacopo+renesas@jmondi.org>
To:     laurent.pinchart@ideasonboard.com,
        kieran.bingham+renesas@ideasonboard.com, geert@linux-m68k.org,
        horms@verge.net.au, uli+renesas@fpond.eu
Cc:     Jacopo Mondi <jacopo+renesas@jmondi.org>, airlied@linux.ie,
        daniel@ffwll.ch, linux-renesas-soc@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v7 0/7] drm: rcar-du: Add Color Management Module (CMM)
Date:   Wed, 13 Nov 2019 11:05:49 +0100
Message-Id: <20191113100556.15616-1-jacopo+renesas@jmondi.org>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

An additional round for cmm to fix the KConfig issue reported by Dave spotted
while collecting Laurent's pull request for the v5.5 merge window, which we've
now missed.

I could have sent a 6.2 version of the single 3/7 patch, but given I already
sent a 6.1 for this same one, I assumed a single series would have been
easier to collect, considering we're anyway late for this merge window.

The DTS patches have been collected by Geert already.

Thanks
   j

Detailed v1->v5 change log
https://lkml.org/lkml/2019/10/15/337

v6->v7
- Include the two updates for 3/7 and 5/7 I've sent as v6.1 against the v6
  series
- Make the DRM_RCAR_CMM symbol a tristate and make it implied by DRM_RCAR_DU
  to prevent having DU built-in and CMM has a module, which causes linkage
  errors due to unresolved symbols.

Jacopo Mondi (7):
  dt-bindings: display: renesas,cmm: Add R-Car CMM documentation
  dt-bindings: display, renesas,du: Document cmms property
  drm: rcar-du: Add support for CMM
  drm: rcar-du: kms: Initialize CMM instances
  drm: rcar-du: crtc: Control CMM operations
  drm: rcar-du: crtc: Register GAMMA_LUT properties
  drm: rcar-du: kms: Expand comment in vsps parsing routine

 .../bindings/display/renesas,cmm.yaml         |  67 ++++++
 .../bindings/display/renesas,du.txt           |   5 +
 drivers/gpu/drm/rcar-du/Kconfig               |   8 +
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
 13 files changed, 518 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/display/renesas,cmm.yaml
 create mode 100644 drivers/gpu/drm/rcar-du/rcar_cmm.c
 create mode 100644 drivers/gpu/drm/rcar-du/rcar_cmm.h

--
2.23.0

