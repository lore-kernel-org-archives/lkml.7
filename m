Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3DBCC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 16:13:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C3A82183F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 16:13:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727502AbfC1QNc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 12:13:32 -0400
Received: from relay10.mail.gandi.net ([217.70.178.230]:56653 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726108AbfC1QNa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 12:13:30 -0400
Received: from localhost.localdomain (aaubervilliers-681-1-91-136.w90-88.abo.wanadoo.fr [90.88.32.136])
        (Authenticated sender: paul.kocialkowski@bootlin.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id A1B69240009;
        Thu, 28 Mar 2019 16:13:26 +0000 (UTC)
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Eric Anholt <eric@anholt.net>,
        Eben Upton <eben@raspberrypi.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Subject: [PATCH v3 1/2] drm/file: Rehabilitate the firstopen hook for non-legacy drivers
Date:   Thu, 28 Mar 2019 17:13:05 +0100
Message-Id: <20190328161306.22757-2-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190328161306.22757-1-paul.kocialkowski@bootlin.com>
References: <20190328161306.22757-1-paul.kocialkowski@bootlin.com>
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
Reviewed-by: Eric Anholt <eric@anholt.net>
---
 drivers/gpu/drm/drm_file.c | 3 +--
 include/drm/drm_drv.h      | 3 ---
 2 files changed, 1 insertion(+), 5 deletions(-)

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
index ca46a45a9cce..de5637494503 100644
--- a/include/drm/drm_drv.h
+++ b/include/drm/drm_drv.h
@@ -234,9 +234,6 @@ struct drm_driver {
 	 * kernel driver does not really own the hardware. Instead ownershipe is
 	 * handled with the help of userspace through an inheritedly racy dance
 	 * to set/unset the VT into raw mode.
-	 *
-	 * Legacy drivers initialize the hardware in the @firstopen callback,
-	 * which isn't even called for modern drivers.
 	 */
 	void (*lastclose) (struct drm_device *);
 
-- 
2.21.0

