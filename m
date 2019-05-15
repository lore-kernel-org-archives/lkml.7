Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA5EEC04E84
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 11:29:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D8C921473
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 11:29:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557919775;
	bh=QZMtasH51Y9A6IM0dWwB0QJC2iAoLYhoTFvxrndNLoU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ia7lcpTBJTZ5yOEfqUBJZLOUGcUHcWyKcKzS2kYhBEMyGWAxDtatLysLeWrRf6gmq
	 LMeQ/9VD+gWTecDjTdIkcKtRGnmyfpCUikKGi7VWVu6/B1WEo5mWP23A0D5bJqp+sb
	 rZr2wipAdpWiu7PDc4IEHXTRR1O7Civz5fNZdpxQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732593AbfEOL3e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 07:29:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:40802 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732580AbfEOL3b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 07:29:31 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2DF80206BF;
        Wed, 15 May 2019 11:29:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557919770;
        bh=QZMtasH51Y9A6IM0dWwB0QJC2iAoLYhoTFvxrndNLoU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wpzmhviCqfUNeKLDHq5hacIyGGbq3DnIHsYDO784QOwhoXEwmQXnDi4oJJAZzazk1
         Gv5vsGnxxYpBW0RUq5444odk+iS+jebFvOo6uGat65NJkSstLPJA4cGkXNyrJdCVVZ
         5ZPYOirzvo9KXEDTE/IP0lbs5HKgWVeY7Yu2kxms=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
        Dave Airlie <airlied@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.0 088/137] Revert "drm/virtio: drop prime import/export callbacks"
Date:   Wed, 15 May 2019 12:56:09 +0200
Message-Id: <20190515090659.915385938@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190515090651.633556783@linuxfoundation.org>
References: <20190515090651.633556783@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit a0cecc23cfcbf2626497a8c8770856dd56b67917 ]

This patch does more harm than good, as it breaks both Xwayland and
gnome-shell with X11.

Xwayland requires DRI3 & DRI3 requires PRIME.

X11 crash for obscure double-free reason which are hard to debug
(starting X11 by hand doesn't trigger the crash).

I don't see an apparent problem implementing those stub prime
functions, they may return an error at run-time, and it seems to be
handled fine by GNOME at least.

This reverts commit b318e3ff7ca065d6b107e424c85a63d7a6798a69.
[airlied:
This broke userspace for virtio-gpus, and regressed things from DRI3 to DRI2.

This brings back the original problem, but it's better than regressions.]

Fixes: b318e3ff7ca065d6b107e424c85a63d7a6798a ("drm/virtio: drop prime import/export callbacks")
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Dave Airlie <airlied@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/virtio/virtgpu_drv.c   |  4 ++++
 drivers/gpu/drm/virtio/virtgpu_drv.h   |  4 ++++
 drivers/gpu/drm/virtio/virtgpu_prime.c | 12 ++++++++++++
 3 files changed, 20 insertions(+)

diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.c b/drivers/gpu/drm/virtio/virtgpu_drv.c
index 2d1aaca491050..f7f32a885af79 100644
--- a/drivers/gpu/drm/virtio/virtgpu_drv.c
+++ b/drivers/gpu/drm/virtio/virtgpu_drv.c
@@ -127,10 +127,14 @@ static struct drm_driver driver = {
 #if defined(CONFIG_DEBUG_FS)
 	.debugfs_init = virtio_gpu_debugfs_init,
 #endif
+	.prime_handle_to_fd = drm_gem_prime_handle_to_fd,
+	.prime_fd_to_handle = drm_gem_prime_fd_to_handle,
 	.gem_prime_export = drm_gem_prime_export,
 	.gem_prime_import = drm_gem_prime_import,
 	.gem_prime_pin = virtgpu_gem_prime_pin,
 	.gem_prime_unpin = virtgpu_gem_prime_unpin,
+	.gem_prime_get_sg_table = virtgpu_gem_prime_get_sg_table,
+	.gem_prime_import_sg_table = virtgpu_gem_prime_import_sg_table,
 	.gem_prime_vmap = virtgpu_gem_prime_vmap,
 	.gem_prime_vunmap = virtgpu_gem_prime_vunmap,
 	.gem_prime_mmap = virtgpu_gem_prime_mmap,
diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.h b/drivers/gpu/drm/virtio/virtgpu_drv.h
index 0c15000f926eb..1deb41d42ea4d 100644
--- a/drivers/gpu/drm/virtio/virtgpu_drv.h
+++ b/drivers/gpu/drm/virtio/virtgpu_drv.h
@@ -372,6 +372,10 @@ int virtio_gpu_object_wait(struct virtio_gpu_object *bo, bool no_wait);
 /* virtgpu_prime.c */
 int virtgpu_gem_prime_pin(struct drm_gem_object *obj);
 void virtgpu_gem_prime_unpin(struct drm_gem_object *obj);
+struct sg_table *virtgpu_gem_prime_get_sg_table(struct drm_gem_object *obj);
+struct drm_gem_object *virtgpu_gem_prime_import_sg_table(
+	struct drm_device *dev, struct dma_buf_attachment *attach,
+	struct sg_table *sgt);
 void *virtgpu_gem_prime_vmap(struct drm_gem_object *obj);
 void virtgpu_gem_prime_vunmap(struct drm_gem_object *obj, void *vaddr);
 int virtgpu_gem_prime_mmap(struct drm_gem_object *obj,
diff --git a/drivers/gpu/drm/virtio/virtgpu_prime.c b/drivers/gpu/drm/virtio/virtgpu_prime.c
index c59ec34c80a5d..eb51a78e11991 100644
--- a/drivers/gpu/drm/virtio/virtgpu_prime.c
+++ b/drivers/gpu/drm/virtio/virtgpu_prime.c
@@ -39,6 +39,18 @@ void virtgpu_gem_prime_unpin(struct drm_gem_object *obj)
 	WARN_ONCE(1, "not implemented");
 }
 
+struct sg_table *virtgpu_gem_prime_get_sg_table(struct drm_gem_object *obj)
+{
+	return ERR_PTR(-ENODEV);
+}
+
+struct drm_gem_object *virtgpu_gem_prime_import_sg_table(
+	struct drm_device *dev, struct dma_buf_attachment *attach,
+	struct sg_table *table)
+{
+	return ERR_PTR(-ENODEV);
+}
+
 void *virtgpu_gem_prime_vmap(struct drm_gem_object *obj)
 {
 	struct virtio_gpu_object *bo = gem_to_virtio_gpu_obj(obj);
-- 
2.20.1



