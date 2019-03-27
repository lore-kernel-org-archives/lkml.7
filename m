Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E700CC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 19:03:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2CE8206B7
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 19:03:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553713425;
	bh=Y4rT8gAFjxr5By5aPaUjpOZnCnpawLfWHz5cz7ca4Tc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zOMYA9fStHKrTFxbBXI3WX5mFOMkpSoF3FZt6mBLe3V8e9KpzkiXZ8hPlu6AryrFH
	 YmxE8ZA+UunBWdXmOtltqKVcocM5I/QKFL7YAZQWgBw0OPah2X9xvujUPDEODpSFHs
	 rRWeLPTrwQ8xvg7kmx/eex4h86heYXeDhXHiigOk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389791AbfC0TDn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 15:03:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:55956 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389405AbfC0SNW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 14:13:22 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 592952147C;
        Wed, 27 Mar 2019 18:13:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553710401;
        bh=Y4rT8gAFjxr5By5aPaUjpOZnCnpawLfWHz5cz7ca4Tc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RJwc9wAEVYTx/dogI85W6AWbV/gBnB4Wl76EFexdc6svAkRqYA9MoqKBUfIzLkE7w
         mUSJTxwyw0pSPBe4Dw0HA8WGHB3J+wOxNsXtNxq70t/MUznIOGwXmqlO2kgD+NjsWr
         CW4bh4P5qKPti3HApitpTOM8qFkvEcfgUkdKzj74=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Emil Velikov <emil.velikov@collabora.com>,
        intel-gfx@lists.freedesktop.org, Sasha Levin <sashal@kernel.org>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 4.19 102/192] drm: allow render capable master with DRM_AUTH ioctls
Date:   Wed, 27 Mar 2019 14:08:54 -0400
Message-Id: <20190327181025.13507-102-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190327181025.13507-1-sashal@kernel.org>
References: <20190327181025.13507-1-sashal@kernel.org>
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
index ba129b64b61f..f8d333f658a4 100644
--- a/drivers/gpu/drm/drm_ioctl.c
+++ b/drivers/gpu/drm/drm_ioctl.c
@@ -502,6 +502,13 @@ int drm_version(struct drm_device *dev, void *data,
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
@@ -516,14 +523,19 @@ int drm_version(struct drm_device *dev, void *data,
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

