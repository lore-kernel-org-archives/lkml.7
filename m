Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 441FEC10F03
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 12:29:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 107212081C
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 12:29:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729246AbfDYM3q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 08:29:46 -0400
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:49729 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726067AbfDYM3p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 08:29:45 -0400
X-Originating-IP: 90.88.147.33
Received: from localhost.localdomain (aaubervilliers-681-1-27-33.w90-88.abo.wanadoo.fr [90.88.147.33])
        (Authenticated sender: paul.kocialkowski@bootlin.com)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id AD73C240011;
        Thu, 25 Apr 2019 12:29:39 +0000 (UTC)
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     Eric Anholt <eric@anholt.net>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Eben Upton <eben@raspberrypi.org>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Subject: [PATCH v7 0/4] drm/vc4: Binner BO management improvements
Date:   Thu, 25 Apr 2019 14:29:13 +0200
Message-Id: <20190425122917.26536-1-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes since v6:
* Removed vc4_v3d_bin_bo_put from error paths;
* Added WARN_ON_ONCE when no bin BO at refcount release.

Changes since v5:
* Fix more locking mistakes;
* Introduce get/put helpers;
* Grabbed a reference when submitting an exec job with a binner slot.
* Addressed misc comments.

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
  drm/vc4: Reformat and the binner bo allocation helper
  drm/vc4: Check for V3D before binner bo alloc
  drm/vc4: Check for the binner bo before handling OOM interrupt
  drm/vc4: Allocate binner bo when starting to use the V3D

 drivers/gpu/drm/vc4/vc4_bo.c  | 33 ++++++++++++++++-
 drivers/gpu/drm/vc4/vc4_drv.c |  6 ++++
 drivers/gpu/drm/vc4/vc4_drv.h | 14 ++++++++
 drivers/gpu/drm/vc4/vc4_gem.c | 13 +++++++
 drivers/gpu/drm/vc4/vc4_irq.c | 20 ++++++++---
 drivers/gpu/drm/vc4/vc4_v3d.c | 68 ++++++++++++++++++++++++++---------
 6 files changed, 132 insertions(+), 22 deletions(-)

-- 
2.21.0

