Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B84D2C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 12:39:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80E6420693
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 12:39:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727484AbfDOMjP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 08:39:15 -0400
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:56819 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726298AbfDOMjP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 08:39:15 -0400
X-Originating-IP: 90.88.18.121
Received: from localhost.localdomain (aaubervilliers-681-1-63-121.w90-88.abo.wanadoo.fr [90.88.18.121])
        (Authenticated sender: paul.kocialkowski@bootlin.com)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id 4163E1C0009;
        Mon, 15 Apr 2019 12:39:11 +0000 (UTC)
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     Eric Anholt <eric@anholt.net>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Eben Upton <eben@raspberrypi.org>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Subject: [PATCH v5 0/4] drm/vc4: Binner BO management improvements
Date:   Mon, 15 Apr 2019 14:39:04 +0200
Message-Id: <20190415123908.28986-1-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes since v4:
* Used a kref on the binner bo instead of firstopen/lastclose;
* Added a mutex to prevent race conditions;
* Took care of enabling the OOM interrupt when we have a binner BO allocated.

Changes since v3:
* Split changes into more commits when possible;
* Reworked binner bo alloc condition as discussed.

Changes since v2:
* Removed deprecated sentence about fristopen;
* Added collected Reviewed-By tags.

Changes since v1:
* Squashed the two final patches into one.

Paul Kocialkowski (4):
  drm/vc4: Reformat and export binner bo allocation helper
  drm/vc4: Check for V3D before binner bo alloc
  drm/vc4: Check for the binner bo before handling OOM interrupt
  drm/vc4: Allocate binner bo when starting to use the V3D

 drivers/gpu/drm/vc4/vc4_bo.c  | 30 ++++++++++++++++++
 drivers/gpu/drm/vc4/vc4_drv.c | 17 +++++++++++
 drivers/gpu/drm/vc4/vc4_drv.h | 10 ++++++
 drivers/gpu/drm/vc4/vc4_irq.c |  9 ++++--
 drivers/gpu/drm/vc4/vc4_v3d.c | 57 ++++++++++++++++++++++++-----------
 5 files changed, 104 insertions(+), 19 deletions(-)

-- 
2.21.0

