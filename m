Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 865EEC4360F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:09:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48BAD2183F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:09:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553710159;
	bh=6TRaSxgQjJ78zgKBLjuZr9V1KfYyKpvXETRlkqiJE+E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PFYQazua4zaE7V+7Ry4eyxc3t39UQ1Mwu7PW2g6IkW7oT8XFYNhuZ8HynMMj3ThOM
	 SIuqHwrysbk8C9mAyWdvWPowj8ERmMe9//aZwYVa3+aR3JynPE9aehfhc31n0f7L5Y
	 4Y4pkaGR2cQqILrf5Oh2rnhOp1/jkfSYjBikbWNM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388134AbfC0SJS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 14:09:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:51016 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388514AbfC0SJM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 14:09:12 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 58F07217F9;
        Wed, 27 Mar 2019 18:09:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553710152;
        bh=6TRaSxgQjJ78zgKBLjuZr9V1KfYyKpvXETRlkqiJE+E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AcUHQEUFqydYTArK5WapHMSU+AqcYwfC2oxSjyWgK4azOy4MPHrST+KBerm+iSOGL
         lJYKymnqoUAr5SMMDqHU4gxJefJxoimIBp4Bbf10b2JRNLuaw2ODgFrAYJSUyhgdm1
         3MrWxslyIu63kYDDDplf1Hmdx+pq0uQ2vMSSLNyI=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Sasha Levin <sashal@kernel.org>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 5.0 220/262] drm/vkms: Fix flush_work() without INIT_WORK().
Date:   Wed, 27 Mar 2019 14:01:15 -0400
Message-Id: <20190327180158.10245-220-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190327180158.10245-1-sashal@kernel.org>
References: <20190327180158.10245-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>

[ Upstream commit b30b61ff6b1dc37f276cf56a8328b80086a3ffca ]

syzbot is hitting a lockdep warning [1] because flush_work() is called
without INIT_WORK() after kzalloc() at vkms_atomic_crtc_reset().

Commit 6c234fe37c57627a ("drm/vkms: Implement CRC debugfs API") added
INIT_WORK() to only vkms_atomic_crtc_duplicate_state() side. Assuming
that lifecycle of crc_work is appropriately managed, fix this problem
by adding INIT_WORK() to vkms_atomic_crtc_reset() side.

[1] https://syzkaller.appspot.com/bug?id=a5954455fcfa51c29ca2ab55b203076337e1c770

Reported-and-tested-by: syzbot <syzbot+12f1b031b6da017e34f8@syzkaller.appspotmail.com>
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Reviewed-by: Shayenne Moura <shayenneluzmoura@gmail.com>
Signed-off-by: Daniel Vetter <daniel.vetter@ffwll.ch>
Link: https://patchwork.freedesktop.org/patch/msgid/1547829823-9877-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/vkms/vkms_crtc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/vkms/vkms_crtc.c b/drivers/gpu/drm/vkms/vkms_crtc.c
index a0bef7de9df7..1054f535178a 100644
--- a/drivers/gpu/drm/vkms/vkms_crtc.c
+++ b/drivers/gpu/drm/vkms/vkms_crtc.c
@@ -95,6 +95,7 @@ static void vkms_atomic_crtc_reset(struct drm_crtc *crtc)
 	vkms_state = kzalloc(sizeof(*vkms_state), GFP_KERNEL);
 	if (!vkms_state)
 		return;
+	INIT_WORK(&vkms_state->crc_work, vkms_crc_work_handle);
 
 	crtc->state = &vkms_state->base;
 	crtc->state->crtc = crtc;
-- 
2.19.1

