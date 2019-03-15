Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAB54C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 16:26:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEB86218D0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 16:26:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729558AbfCOQ0C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 12:26:02 -0400
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:47115 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728510AbfCOQ0C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 12:26:02 -0400
X-Originating-IP: 90.88.22.102
Received: from localhost.localdomain (aaubervilliers-681-1-80-102.w90-88.abo.wanadoo.fr [90.88.22.102])
        (Authenticated sender: paul.kocialkowski@bootlin.com)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id C0E71C000A;
        Fri, 15 Mar 2019 16:25:58 +0000 (UTC)
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Eric Anholt <eric@anholt.net>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Eben Upton <eben@raspberrypi.org>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Subject: [PATCH 1/3] drm/file: Rehabilitate the firstopen hook for non-legacy drivers
Date:   Fri, 15 Mar 2019 17:25:36 +0100
Message-Id: <20190315162538.4120-1-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The firstopen DRM driver hook was initially used to perform hardware
initialization, which is now considered legacy. Only a single user of
firstopen remains at this point (savage).

In some specific cases, non-legacy drivers may also need to implement
these hooks. For instance on VC4, we need to allocate a 16 MiB buffer
for the GPU. Because it's not required for fbcon, it's a waste to
allocate it before userspace starts using the DRM device.

Using firstopen and lastclose for this allocation seems like the best
fit, so re-habilitate the hook to allow it to be called for non-legacy
drivers.

Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
---
 drivers/gpu/drm/drm_file.c | 3 +--
 include/drm/drm_drv.h      | 2 +-
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/drm_file.c b/drivers/gpu/drm/drm_file.c
index b1838a41ad43..c011b5cbfb6b 100644
--- a/drivers/gpu/drm/drm_file.c
+++ b/drivers/gpu/drm/drm_file.c
@@ -266,8 +266,7 @@ static int drm_setup(struct drm_device * dev)
 {
 	int ret;
 
-	if (dev->driver->firstopen &&
-	    drm_core_check_feature(dev, DRIVER_LEGACY)) {
+	if (dev->driver->firstopen) {
 		ret = dev->driver->firstopen(dev);
 		if (ret != 0)
 			return ret;
diff --git a/include/drm/drm_drv.h b/include/drm/drm_drv.h
index ca46a45a9cce..aa14607e54d4 100644
--- a/include/drm/drm_drv.h
+++ b/include/drm/drm_drv.h
@@ -236,7 +236,7 @@ struct drm_driver {
 	 * to set/unset the VT into raw mode.
 	 *
 	 * Legacy drivers initialize the hardware in the @firstopen callback,
-	 * which isn't even called for modern drivers.
+	 * modern drivers can use it for other purposes only.
 	 */
 	void (*lastclose) (struct drm_device *);
 
-- 
2.21.0

