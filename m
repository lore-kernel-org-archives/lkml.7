Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 647DBC76186
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 19:37:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 332452171F
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 19:37:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564429058;
	bh=OM+oao33KGs0GJ/R8HaZfy5nw4JYJb8g+JBCHwjDJm8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wN8hxd9kKhWiPvXKe35jrXZHtaRj5753tXJ23IFxxwsVSprG31yk23a2r88sOR8kh
	 FNeU5LZ708DZbYYNm0gC4fwXAADvwOEnMhSd+Pq2rhEaS5N7MytaQUmnccLvGHhyxi
	 /XRNOcWyTcsFqzg1tl+bgvhmWoz6MsZ04l/m+RA0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388735AbfG2Thg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 15:37:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:52380 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388723AbfG2Thd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 15:37:33 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E135C217F5;
        Mon, 29 Jul 2019 19:37:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564429052;
        bh=OM+oao33KGs0GJ/R8HaZfy5nw4JYJb8g+JBCHwjDJm8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cGsJ9FJeqDcuAhbtL1dBr15rafB7mb32z+ni0w0I0+tRqJHDEX+8jhIHn2ncClSs7
         m4zKxz9Y/Sd+p9HL3LhdlTwzMa3LPTBwDrXTmzvy/R9k4nhy7ZdSYPvRWqOBx3QWa5
         4q0czrqyP4dgXG9zBVN4fKHkc/EoUL3cjE05RJy0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Emil Velikov <emil.velikov@collabora.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 231/293] drm/crc-debugfs: User irqsafe spinlock in drm_crtc_add_crc_entry
Date:   Mon, 29 Jul 2019 21:22:02 +0200
Message-Id: <20190729190842.182992398@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190729190820.321094988@linuxfoundation.org>
References: <20190729190820.321094988@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 1882018a70e06376234133e69ede9dd743b4dbd9 ]

We can be called from any context, we need to be prepared.

Noticed this while hacking on vkms, which calls this function from a
normal worker. Which really upsets lockdep.

Cc: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
Cc: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc: Emil Velikov <emil.velikov@collabora.com>
Cc: Benjamin Gaignard <benjamin.gaignard@linaro.org>
Reviewed-by: Benjamin Gaignard <benjamin.gaignard@linaro.org>
Reviewed-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20190605194556.16744-1-daniel.vetter@ffwll.ch
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/drm_debugfs_crc.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/drm_debugfs_crc.c b/drivers/gpu/drm/drm_debugfs_crc.c
index f9e26dda56d6..021813b20e97 100644
--- a/drivers/gpu/drm/drm_debugfs_crc.c
+++ b/drivers/gpu/drm/drm_debugfs_crc.c
@@ -359,8 +359,9 @@ int drm_crtc_add_crc_entry(struct drm_crtc *crtc, bool has_frame,
 	struct drm_crtc_crc *crc = &crtc->crc;
 	struct drm_crtc_crc_entry *entry;
 	int head, tail;
+	unsigned long flags;
 
-	spin_lock(&crc->lock);
+	spin_lock_irqsave(&crc->lock, flags);
 
 	/* Caller may not have noticed yet that userspace has stopped reading */
 	if (!crc->entries) {
@@ -385,7 +386,7 @@ int drm_crtc_add_crc_entry(struct drm_crtc *crtc, bool has_frame,
 	head = (head + 1) & (DRM_CRC_ENTRIES_NR - 1);
 	crc->head = head;
 
-	spin_unlock(&crc->lock);
+	spin_unlock_irqrestore(&crc->lock, flags);
 
 	wake_up_interruptible(&crc->wq);
 
-- 
2.20.1



