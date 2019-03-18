Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD194C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 09:28:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E43F2087C
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 09:28:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552901301;
	bh=YKgmJYI+QrsVfbNJkweYMshig/sNWWhqFXoFItEOeH4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=te8zjqlRMeGw+jV9Qc8aYvCLvoQKP6sbfMsNYFdWbBZ8CX5O4qBKUJJlt6C5uIzGv
	 L/hur34EZVgmqJVA2Clnb3EZmZ95mwyySCg3R/vvGURNwgSjD6b+N2jN4SDh1mB/vj
	 APeyT+OZxhwQsv/07YLrmDaYql3g2OwKX5jUTaMk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728046AbfCRJ2U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 05:28:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:34020 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728002AbfCRJ2R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 05:28:17 -0400
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D09162087C;
        Mon, 18 Mar 2019 09:28:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552901296;
        bh=YKgmJYI+QrsVfbNJkweYMshig/sNWWhqFXoFItEOeH4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=k5DYRlHN73hGkXYeNwwAfuxHfBk6hGuP9bqNeTqlL3fGrMn2jpqfmgAFW6ExeaTA2
         vFh1U1CkWBFdDZ1o25lyQB5MZnbyoogHs4nQIHigFNrGV5Bx0dcTbqNu297a6FBJ7c
         GeAHY8XAzGy1SswiV5Uy3iqef6AlRPJYszunpHns=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Daniel Vetter <daniel.vetter@ffwll.ch>,
        Harry Wentland <harry.wentland@amd.com>,
        Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
        Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
        Daniel Vetter <daniel@ffwll.ch>
Subject: [PATCH 5.0 43/43] drm: Block fb changes for async plane updates
Date:   Mon, 18 Mar 2019 10:24:35 +0100
Message-Id: <20190318083717.135180711@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190318083715.877441740@linuxfoundation.org>
References: <20190318083715.877441740@linuxfoundation.org>
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

From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

commit 25dc194b34dd5919dd07b8873ee338182e15df9d upstream.

The prepare_fb call always happens on new_plane_state.

The drm_atomic_helper_cleanup_planes checks to see if
plane state pointer has changed when deciding to call cleanup_fb on
either the new_plane_state or the old_plane_state.

For a non-async atomic commit the state pointer is swapped, so this
helper calls prepare_fb on the new_plane_state and cleanup_fb on the
old_plane_state. This makes sense, since we want to prepare the
framebuffer we are going to use and cleanup the the framebuffer we are
no longer using.

For the async atomic update helpers this differs. The async atomic
update helpers perform in-place updates on the existing state. They call
drm_atomic_helper_cleanup_planes but the state pointer is not swapped.
This means that prepare_fb is called on the new_plane_state and
cleanup_fb is called on the new_plane_state (not the old).

In the case where old_plane_state->fb == new_plane_state->fb then
there should be no behavioral difference between an async update
and a non-async commit. But there are issues that arise when
old_plane_state->fb != new_plane_state->fb.

The first is that the new_plane_state->fb is immediately cleaned up
after it has been prepared, so we're using a fb that we shouldn't
be.

The second occurs during a sequence of async atomic updates and
non-async regular atomic commits. Suppose there are two framebuffers
being interleaved in a double-buffering scenario, fb1 and fb2:

- Async update, oldfb = NULL, newfb = fb1, prepare fb1, cleanup fb1
- Async update, oldfb = fb1, newfb = fb2, prepare fb2, cleanup fb2
- Non-async commit, oldfb = fb2, newfb = fb1, prepare fb1, cleanup fb2

We call cleanup_fb on fb2 twice in this example scenario, and any
further use will result in use-after-free.

The simple fix to this problem is to block framebuffer changes
in the drm_atomic_helper_async_check function for now.

v2: Move check by itself, add a FIXME (Daniel)

Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: Harry Wentland <harry.wentland@amd.com>
Cc: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Cc: <stable@vger.kernel.org> # v4.14+
Fixes: fef9df8b5945 ("drm/atomic: initial support for asynchronous plane update")
Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Acked-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Acked-by: Harry Wentland <harry.wentland@amd.com>
Reviewed-by: Daniel Vetter <daniel@ffwll.ch>
Signed-off-by: Harry Wentland <harry.wentland@amd.com>
Link: https://patchwork.freedesktop.org/patch/275364/
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/drm_atomic_helper.c |    9 +++++++++
 1 file changed, 9 insertions(+)

--- a/drivers/gpu/drm/drm_atomic_helper.c
+++ b/drivers/gpu/drm/drm_atomic_helper.c
@@ -1611,6 +1611,15 @@ int drm_atomic_helper_async_check(struct
 	if (old_plane_state->fb != new_plane_state->fb)
 		return -EINVAL;
 
+	/*
+	 * FIXME: Since prepare_fb and cleanup_fb are always called on
+	 * the new_plane_state for async updates we need to block framebuffer
+	 * changes. This prevents use of a fb that's been cleaned up and
+	 * double cleanups from occuring.
+	 */
+	if (old_plane_state->fb != new_plane_state->fb)
+		return -EINVAL;
+
 	funcs = plane->helper_private;
 	if (!funcs->atomic_async_update)
 		return -EINVAL;


