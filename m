Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73BE6C10F0C
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:19:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42F8820652
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:19:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554369545;
	bh=h+ImyU7ghwR5F6pzAFizN4aNSoCP0+Y3xVKiCkA259U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hngNU+tceE1SMX4RbtKEbvEe+7lHwgo2p+l8U6YwGobfI3BvLmpDDgZsuO2tBqv7E
	 /2GChC5De2xrvSofAHcXM9GM+NOgMi6Ctf3xmy0koMtOQgY2ULK6HHqA2X7YvXOOSy
	 SixzMV0EGJXePr9zWJaWqNUd5yao9KPIvDJ5scLE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388369AbfDDJS0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 05:18:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:60498 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727108AbfDDJSX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 05:18:23 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0CDC920652;
        Thu,  4 Apr 2019 09:18:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554369502;
        bh=h+ImyU7ghwR5F6pzAFizN4aNSoCP0+Y3xVKiCkA259U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=laAI8x74ziLWMVOJZboJ83qY2jfQ9+1GTboTn6b24oj1UVyWauFSnTcTEDkftTPOp
         JyvjgkogxHq4oHWfQTu/ozHKyRfZfyA+oOf/As4KDhS+7xmemPhcGzZ+7FMnJtoqRE
         QWKaDXh8wsDT6zLXQ2SzwjhyZwuTweZoGjl4DvcA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+6ea337c427f5083ebdf2@syzkaller.appspotmail.com,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.0 240/246] drm: Reorder set_property_atomic to avoid returning with an active ww_ctx
Date:   Thu,  4 Apr 2019 10:49:00 +0200
Message-Id: <20190404084627.698861429@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190404084619.236418459@linuxfoundation.org>
References: <20190404084619.236418459@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

5.0-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 227ad6d957898a88b1746e30234ece64d305f066 ]

Delay the drm_modeset_acquire_init() until after we check for an
allocation failure so that we can return immediately upon error without
having to unwind.

WARNING: lock held when returning to user space!
4.20.0+ #174 Not tainted
------------------------------------------------
syz-executor556/8153 is leaving the kernel with locks still held!
1 lock held by syz-executor556/8153:
  #0: 000000005100c85c (crtc_ww_class_acquire){+.+.}, at:
set_property_atomic+0xb3/0x330 drivers/gpu/drm/drm_mode_object.c:462

Reported-by: syzbot+6ea337c427f5083ebdf2@syzkaller.appspotmail.com
Fixes: 144a7999d633 ("drm: Handle properties in the core for atomic drivers")
Signed-off-by: Chris Wilson <chris@chris-wilson.co.uk>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Sean Paul <sean@poorly.run>
Cc: David Airlie <airlied@linux.ie>
Cc: <stable@vger.kernel.org> # v4.14+
Reviewed-by: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20181230122842.21917-1-chris@chris-wilson.co.uk

Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/drm_mode_object.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/drm_mode_object.c b/drivers/gpu/drm/drm_mode_object.c
index 004191d01772..15b919f90c5a 100644
--- a/drivers/gpu/drm/drm_mode_object.c
+++ b/drivers/gpu/drm/drm_mode_object.c
@@ -465,6 +465,7 @@ static int set_property_atomic(struct drm_mode_object *obj,
 
 	drm_modeset_acquire_init(&ctx, 0);
 	state->acquire_ctx = &ctx;
+
 retry:
 	if (prop == state->dev->mode_config.dpms_property) {
 		if (obj->type != DRM_MODE_OBJECT_CONNECTOR) {
-- 
2.19.1



