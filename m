Return-Path: <SRS0=y5Xy=UI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C95D5C468BD
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 16:46:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A33E62081C
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 16:46:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560098819;
	bh=w3fLyttRot9PQvpvJqENFjdubh78MZQDTHQmwl0Id0c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=tfKHHvlVN23DpPNmKriQfuHHw4B1R+4LdrjzSkjByz7TQqBgCBbvcE/YgJjHE67ut
	 dQF9nHWIAvjVruV/i/+IlNAe50/+Ui8yxM9sNZiKUURauY1Lbeai84f1M2LGm58bTf
	 uLEOAe0mJ1UCJzH9f2aFdCw9nSaGChlcFNnnhSOA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729223AbfFIQq6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Jun 2019 12:46:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:45320 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730652AbfFIQqx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jun 2019 12:46:53 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C0E882081C;
        Sun,  9 Jun 2019 16:46:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560098813;
        bh=w3fLyttRot9PQvpvJqENFjdubh78MZQDTHQmwl0Id0c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RyOLAU0UtPB/3llJ0GqnZTDpDQI2X/N3UgcNXpQkMoRTheftOTBn0nKHS+OAM2+By
         SlfXU3Y7mDCmsmEUhHZr8xnVBJI6GwUi3qmlvv8hejmNrOll5mZuzLl5xV+A4rZK0w
         SQvjcWfot51Sb209tx/qsBWKhDxRW5IckpdixSIg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Helen Koike <helen.koike@collabora.com>,
        Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Subject: [PATCH 5.1 69/70] drm/amd: fix fb references in async update
Date:   Sun,  9 Jun 2019 18:42:20 +0200
Message-Id: <20190609164133.176089569@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190609164127.541128197@linuxfoundation.org>
References: <20190609164127.541128197@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Helen Koike <helen.koike@collabora.com>

commit 332af874db929f92931727bfe191b2c666438c81 upstream.

Async update callbacks are expected to set the old_fb in the new_state
so prepare/cleanup framebuffers are balanced.

Calling drm_atomic_set_fb_for_plane() (which gets a reference of the new
fb and put the old fb) is not required, as it's taken care by
drm_mode_cursor_universal() when calling drm_atomic_helper_update_plane().

Cc: <stable@vger.kernel.org> # v4.20+
Fixes: 674e78acae0d ("drm/amd/display: Add fast path for cursor plane updates")
Suggested-by: Boris Brezillon <boris.brezillon@collabora.com>
Signed-off-by: Helen Koike <helen.koike@collabora.com>
Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20190603165610.24614-3-helen.koike@collabora.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -3789,8 +3789,7 @@ static void dm_plane_atomic_async_update
 	struct drm_plane_state *old_state =
 		drm_atomic_get_old_plane_state(new_state->state, plane);
 
-	if (plane->state->fb != new_state->fb)
-		drm_atomic_set_fb_for_plane(plane->state, new_state->fb);
+	swap(plane->state->fb, new_state->fb);
 
 	plane->state->src_x = new_state->src_x;
 	plane->state->src_y = new_state->src_y;


