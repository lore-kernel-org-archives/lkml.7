Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1255BC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 06:37:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D54AC20863
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 06:36:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553582219;
	bh=3HQH3vHKe550ailZIBDXphfZRyHP836jLqH0tjjNHTk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Pea3uZCLWWhlCPEaCqjNtTC4NqE1EYBCYPSNBfXI3BDJYsg9HksjurkWhzCJgeb4H
	 xmLtiKXPwT5n5NCrxvg2ZarbhaE034CZI+yrQzZgo+/G1MhwSCkWnb51qxSn0Skz3a
	 Z3Kce+M9AXv+ttGdUFGAUE9VzAhQVU2bwtK3VoAc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732304AbfCZGg6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 02:36:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:49796 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731257AbfCZGgz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 02:36:55 -0400
Received: from localhost (unknown [104.132.152.111])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8A4B42070B;
        Tue, 26 Mar 2019 06:36:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553582215;
        bh=3HQH3vHKe550ailZIBDXphfZRyHP836jLqH0tjjNHTk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pXH0IiNK84ZHp3EGaBM2wmuR9OdD3vMt1l8OG1gvoYUS/wFnvLT6sWM9cdhtuuDp3
         oJCdxndZtThFY/WYSR8LKYCAw5XA96mdndY5GGinlC+3ERtLhdQ+yNjTZ5QTLD6W75
         LynnqkrWRK7IUyKPCZp8qK9y82IXojkTHXs0GTzc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+6ea337c427f5083ebdf2@syzkaller.appspotmail.com,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>
Subject: [PATCH 4.19 34/45] drm: Reorder set_property_atomic to avoid returning with an active ww_ctx
Date:   Tue, 26 Mar 2019 15:30:17 +0900
Message-Id: <20190326042704.463433831@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190326042702.565683325@linuxfoundation.org>
References: <20190326042702.565683325@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Chris Wilson <chris@chris-wilson.co.uk>

commit 227ad6d957898a88b1746e30234ece64d305f066 upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/drm_mode_object.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- a/drivers/gpu/drm/drm_mode_object.c
+++ b/drivers/gpu/drm/drm_mode_object.c
@@ -458,12 +458,13 @@ static int set_property_atomic(struct dr
 	struct drm_modeset_acquire_ctx ctx;
 	int ret;
 
-	drm_modeset_acquire_init(&ctx, 0);
-
 	state = drm_atomic_state_alloc(dev);
 	if (!state)
 		return -ENOMEM;
+
+	drm_modeset_acquire_init(&ctx, 0);
 	state->acquire_ctx = &ctx;
+
 retry:
 	if (prop == state->dev->mode_config.dpms_property) {
 		if (obj->type != DRM_MODE_OBJECT_CONNECTOR) {


