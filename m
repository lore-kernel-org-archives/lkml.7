Return-Path: <SRS0=YpA9=XT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CAD8C432C1
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 16:48:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20EC721D6C
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 16:48:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569343737;
	bh=mS7XH/egN7Y8EIFLKylZVlOZdLKV0EKtqjwNDmpgFtg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=BEne5XR4Holk/wXaQYugLQyc15A1OpTwSbj0AE+/0AJl9gmXfKT6PkiCQY2hbv/q1
	 F15GcoHEwEcGX9Br6zo1ceYgqixfk4qqcSvxBfydnDA8bI3Z9On7G8Cgr+RTKiY/KL
	 gJ1I+3kA+R3QsA0dMcS+jfIzr8476t7pL4a77xTo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410155AbfIXQs4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Sep 2019 12:48:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:40852 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730722AbfIXQsx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 12:48:53 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 57D7A21906;
        Tue, 24 Sep 2019 16:48:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569343733;
        bh=mS7XH/egN7Y8EIFLKylZVlOZdLKV0EKtqjwNDmpgFtg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JFv6bqfB66KIJKvopgOR5Iqth8jCJ5oR83WvdGm4E4xaxSmvwQh1U3CJRg3baEFN4
         EgjDxcOkN0+dERWVYGKwSYWOiyOq4MOJsQZhbsDTBO/zAhGHD9wImjEoeYVBtD4c1G
         kQ3zVfdeP1FdkyPUqNG1NufY0cCvQbG9fAK5Msq8=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        Sean Paul <sean@poorly.run>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Sasha Levin <sashal@kernel.org>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 4.19 03/50] drm/kms: Catch mode_object lifetime errors
Date:   Tue, 24 Sep 2019 12:48:00 -0400
Message-Id: <20190924164847.27780-3-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190924164847.27780-1-sashal@kernel.org>
References: <20190924164847.27780-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Vetter <daniel.vetter@ffwll.ch>

[ Upstream commit 4f5368b5541a902f6596558b05f5c21a9770dd32 ]

Only dynamic mode objects, i.e. those which are refcounted and have a free
callback, can be added while the overall drm_device is visible to
userspace. All others must be added before drm_dev_register and
removed after drm_dev_unregister.

Small issue around drivers still using the load/unload callbacks, we
need to make sure we set dev->registered so that load/unload code in
these callbacks doesn't trigger false warnings. Only a small
adjustement in drm_dev_register was needed.

Motivated by some irc discussions about object ids of dynamic objects
like blobs become invalid, and me going on a bit an audit spree.

Reviewed-by: Sean Paul <sean@poorly.run>
Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20190614061723.1173-1-daniel.vetter@ffwll.ch
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/drm_drv.c         | 4 ++--
 drivers/gpu/drm/drm_mode_object.c | 4 ++++
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/drm_drv.c b/drivers/gpu/drm/drm_drv.c
index d8ae4ca129c70..1df30ef9f455a 100644
--- a/drivers/gpu/drm/drm_drv.c
+++ b/drivers/gpu/drm/drm_drv.c
@@ -810,14 +810,14 @@ int drm_dev_register(struct drm_device *dev, unsigned long flags)
 	if (ret)
 		goto err_minors;
 
-	dev->registered = true;
-
 	if (dev->driver->load) {
 		ret = dev->driver->load(dev, flags);
 		if (ret)
 			goto err_minors;
 	}
 
+	dev->registered = true;
+
 	if (drm_core_check_feature(dev, DRIVER_MODESET))
 		drm_modeset_register_all(dev);
 
diff --git a/drivers/gpu/drm/drm_mode_object.c b/drivers/gpu/drm/drm_mode_object.c
index 57cc9aa6683a0..30bf0d08dbf2f 100644
--- a/drivers/gpu/drm/drm_mode_object.c
+++ b/drivers/gpu/drm/drm_mode_object.c
@@ -37,6 +37,8 @@ int __drm_mode_object_add(struct drm_device *dev, struct drm_mode_object *obj,
 {
 	int ret;
 
+	WARN_ON(dev->registered && !obj_free_cb);
+
 	mutex_lock(&dev->mode_config.idr_mutex);
 	ret = idr_alloc(&dev->mode_config.crtc_idr, register_obj ? obj : NULL, 1, 0, GFP_KERNEL);
 	if (ret >= 0) {
@@ -96,6 +98,8 @@ void drm_mode_object_register(struct drm_device *dev,
 void drm_mode_object_unregister(struct drm_device *dev,
 				struct drm_mode_object *object)
 {
+	WARN_ON(dev->registered && !object->free_cb);
+
 	mutex_lock(&dev->mode_config.idr_mutex);
 	if (object->id) {
 		idr_remove(&dev->mode_config.crtc_idr, object->id);
-- 
2.20.1

