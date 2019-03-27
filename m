Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 075E2C10F00
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:45:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0851205C9
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:45:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553712357;
	bh=nuD/PVs0Ei4XkV8Iup9ZJfxrf+Y6eSh6Y9hnGgqefjs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=QXWw+1jOsz5pBU3DbeO4g+JACICF7yuVbtefECDq6OXnC2t3zKhtSUkmgwEiz8BBu
	 36YMwQLTA5Uqdfh8p4tXQrVirawGNUIpylsXien1BIOQ7tLhgC3kSDYGcGwBDHHMoE
	 ByclCsiXCPujKbWu0yfb6xRDI94NmcVN84yVJgZI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390990AbfC0SUk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 14:20:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:38250 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390968AbfC0SUi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 14:20:38 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3D6382063F;
        Wed, 27 Mar 2019 18:20:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553710837;
        bh=nuD/PVs0Ei4XkV8Iup9ZJfxrf+Y6eSh6Y9hnGgqefjs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=c89tagQM8NV0EMxxSQAI47ptbHueR+XNeV6uAwrXauTD4NdfNBzzJRuNfQ3e7Yyu0
         cAm8FBMwskNqgR/lRjHhdjkZeeWUllDziF9TFw341dkfv4S9Y0RzxZnN0k0y5MYyHA
         hPfmQez5m3i0CS5Q+9D65h1A7AEFVByNsJWYZPFA=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Chris Wilson <chris@chris-wilson.co.uk>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Sasha Levin <sashal@kernel.org>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 4.14 121/123] drm: Reorder set_property_atomic to avoid returning with an active ww_ctx
Date:   Wed, 27 Mar 2019 14:16:25 -0400
Message-Id: <20190327181628.15899-121-sashal@kernel.org>
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

From: Chris Wilson <chris@chris-wilson.co.uk>

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
index 1055533792f3..ebbcccfd8428 100644
--- a/drivers/gpu/drm/drm_mode_object.c
+++ b/drivers/gpu/drm/drm_mode_object.c
@@ -438,6 +438,7 @@ static int set_property_atomic(struct drm_mode_object *obj,
 	if (!state)
 		return -ENOMEM;
 	state->acquire_ctx = &ctx;
+
 retry:
 	if (prop == state->dev->mode_config.dpms_property) {
 		if (obj->type != DRM_MODE_OBJECT_CONNECTOR) {
-- 
2.19.1

