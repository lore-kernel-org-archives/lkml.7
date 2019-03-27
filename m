Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D0DDC4360F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:18:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CE372087C
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:18:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553710715;
	bh=CuzjeY4s4b46XczcAQIrD9ZF85EVr3w4qnAcTlPhPXk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=TPuNua8zIkd1k+j3cCNa6+PecY/kk1xaluPrj3jHPerGBKOYCtoxqqDK8gB0X7zw/
	 Ex6sG4qs7zs5P4xHAxtVOEUMg9upZB4TkoBeb/GniXPOsVN14jJAWlhZqOH/rsYqxb
	 qYoUFmwhP3KfTaEI8dmoaLLyWTuHtUqPirR7wV3k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390542AbfC0SSd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 14:18:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:35460 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389903AbfC0SSa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 14:18:30 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 490862087C;
        Wed, 27 Mar 2019 18:18:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553710709;
        bh=CuzjeY4s4b46XczcAQIrD9ZF85EVr3w4qnAcTlPhPXk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dSZExMbVoWO/DjMmewW6fRAaunBzdNNugHJxhcz0crCZ+cmIIKTMJ+Ibn5UffMYlF
         2fPpjIDkbO7mB/7n+W1NHi4bHbcjbicYWSfcVVdtPS6tFTT7OQP7h1oJQCy22GsKnl
         23X1rJnRTvsfow/cs8ymR7Ehy7aC8SCp0KYxfTo8=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Emil Velikov <emil.velikov@collabora.com>,
        intel-gfx@lists.freedesktop.org, Sasha Levin <sashal@kernel.org>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 4.14 068/123] drm: allow render capable master with DRM_AUTH ioctls
Date:   Wed, 27 Mar 2019 14:15:32 -0400
Message-Id: <20190327181628.15899-68-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190327181628.15899-1-sashal@kernel.org>
References: <20190327181628.15899-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Emil Velikov <emil.velikov@collabora.com>

[ Upstream commit 8059add0478e29cb641936011a8fcc9ce9fd80be ]

There are cases (in mesa and applications) where one would open the
primary node without properly authenticating the client.

Sometimes we don't check if the authentication succeeds, but there's
also cases we simply forget to do it.

The former was a case for Mesa where it did not not check the return
value of drmGetMagic() [1]. That was fixed recently although, there's
the question of older drivers or other apps that exbibit this behaviour.

While omitting the call results in issues as seen in [2] and [3].

In the libva case, libva itself doesn't authenticate the DRM client and
the vaGetDisplayDRM documentation doesn't mention if the app should
either.

As of today, the official vainfo utility doesn't authenticate.

To workaround issues like these, some users resort to running their apps
under sudo. Which admittedly isn't always a good idea.

Since any DRIVER_RENDER driver has sufficient isolation between clients,
we can use that, for unauthenticated [primary node] ioctls that require
DRM_AUTH. But only if the respective ioctl is tagged as DRM_RENDER_ALLOW.

v2:
- Rework/simplify if check (Daniel V)
- Add examples to commit messages, elaborate. (Daniel V)

v3:
- Use single unlikely (Daniel V)

[1] https://gitlab.freedesktop.org/mesa/mesa/blob/2bc1f5c2e70fe3b4d41f060af9859bc2a94c5b62/src/egl/drivers/dri2/platform_wayland.c#L1136
[2] https://lists.freedesktop.org/archives/libva/2016-July/004185.html
[3] https://gitlab.freedesktop.org/mesa/kmscube/issues/1
Testcase: igt/core_unauth_vs_render
Cc: intel-gfx@lists.freedesktop.org
Signed-off-by: Emil Velikov <emil.velikov@collabora.com>
Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
Link: https://patchwork.freedesktop.org/patch/msgid/20190114085408.15933-2-emil.l.velikov@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/drm_ioctl.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/drm_ioctl.c b/drivers/gpu/drm/drm_ioctl.c
index 53f319369de5..8ae2e9a5573b 100644
--- a/drivers/gpu/drm/drm_ioctl.c
+++ b/drivers/gpu/drm/drm_ioctl.c
@@ -486,6 +486,13 @@ int drm_version(struct drm_device *dev, void *data,
 	return err;
 }
 
+static inline bool
+drm_render_driver_and_ioctl(const struct drm_device *dev, u32 flags)
+{
+	return drm_core_check_feature(dev, DRIVER_RENDER) &&
+		(flags & DRM_RENDER_ALLOW);
+}
+
 /**
  * drm_ioctl_permit - Check ioctl permissions against caller
  *
@@ -500,14 +507,19 @@ int drm_version(struct drm_device *dev, void *data,
  */
 int drm_ioctl_permit(u32 flags, struct drm_file *file_priv)
 {
+	const struct drm_device *dev = file_priv->minor->dev;
+
 	/* ROOT_ONLY is only for CAP_SYS_ADMIN */
 	if (unlikely((flags & DRM_ROOT_ONLY) && !capable(CAP_SYS_ADMIN)))
 		return -EACCES;
 
-	/* AUTH is only for authenticated or render client */
-	if (unlikely((flags & DRM_AUTH) && !drm_is_render_client(file_priv) &&
-		     !file_priv->authenticated))
-		return -EACCES;
+	/* AUTH is only for master ... */
+	if (unlikely((flags & DRM_AUTH) && drm_is_primary_client(file_priv))) {
+		/* authenticated ones, or render capable on DRM_RENDER_ALLOW. */
+		if (!file_priv->authenticated &&
+		    !drm_render_driver_and_ioctl(dev, flags))
+			return -EACCES;
+	}
 
 	/* MASTER is only for master or control clients */
 	if (unlikely((flags & DRM_MASTER) && 
-- 
2.19.1

