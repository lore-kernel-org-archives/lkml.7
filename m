Return-Path: <SRS0=maO4=XY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9CCAC4360C
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Sep 2019 14:03:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E2082086A
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Sep 2019 14:03:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569765818;
	bh=xiOUHBKHsvXvkss4dduRDk/CwAhsptPTvK2WdmB5jcc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ZZ52KROjNXarSnIdgcm24YaOSQDs7kF261CKMhe00p0lHYDmzFIX78rGODYjSJX3x
	 Die+fUqA07BG5tWndYs8nNhiFMxHE9lEuuCwUQZ60BjPhgEFq/8W+MfhvWI/bL+s1D
	 INSFUUHvIdT1XFUUyTew8ptgfm0eYc/qIdf68occ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730371AbfI2ODg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Sep 2019 10:03:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:46714 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728809AbfI2ODe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Sep 2019 10:03:34 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D9AE32082F;
        Sun, 29 Sep 2019 14:03:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569765813;
        bh=xiOUHBKHsvXvkss4dduRDk/CwAhsptPTvK2WdmB5jcc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IAhAv2bAM2YbGLyWj/LEfzDeDWmaCBY5LR2jvy7LLZBKGucIHDZxKCqcg0vdxKBY6
         wRD6yDdOGmIhqJYe3OqbknvXWLVFmfej8lw670CdKgKa580MtugAj7Nkaqapx8Pn+1
         yh5qXBe4uKj6ZgP23ksNmiVzmdl4L0i+1gyLxBUI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        David Francis <david.francis@amd.com>
Subject: [PATCH 5.3 05/25] drm/amd/display: Skip determining update type for async updates
Date:   Sun, 29 Sep 2019 15:56:08 +0200
Message-Id: <20190929135010.311865952@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190929135006.127269625@linuxfoundation.org>
References: <20190929135006.127269625@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

commit 43d10d30df156f7834fa91aecb69614fefc8bb0a upstream.

[Why]
By passing through the dm_determine_update_type_for_commit for atomic
commits that can be done asynchronously we are incurring a
performance penalty by locking access to the global private object
and holding that access until the end of the programming sequence.

This is also allocating a new large dc_state on every access in addition
to retaining all the references on each stream and plane until the end
of the programming sequence.

[How]
Shift the determination for async update before validation. Return early
if it's going to be an async update.

Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
Reviewed-by: David Francis <david.francis@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |   27 ++++++++++++++++------
 1 file changed, 20 insertions(+), 7 deletions(-)

--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -7274,6 +7274,26 @@ static int amdgpu_dm_atomic_check(struct
 	if (ret)
 		goto fail;
 
+	if (state->legacy_cursor_update) {
+		/*
+		 * This is a fast cursor update coming from the plane update
+		 * helper, check if it can be done asynchronously for better
+		 * performance.
+		 */
+		state->async_update =
+			!drm_atomic_helper_async_check(dev, state);
+
+		/*
+		 * Skip the remaining global validation if this is an async
+		 * update. Cursor updates can be done without affecting
+		 * state or bandwidth calcs and this avoids the performance
+		 * penalty of locking the private state object and
+		 * allocating a new dc_state.
+		 */
+		if (state->async_update)
+			return 0;
+	}
+
 	/* Check scaling and underscan changes*/
 	/* TODO Removed scaling changes validation due to inability to commit
 	 * new stream into context w\o causing full reset. Need to
@@ -7326,13 +7346,6 @@ static int amdgpu_dm_atomic_check(struct
 			ret = -EINVAL;
 			goto fail;
 		}
-	} else if (state->legacy_cursor_update) {
-		/*
-		 * This is a fast cursor update coming from the plane update
-		 * helper, check if it can be done asynchronously for better
-		 * performance.
-		 */
-		state->async_update = !drm_atomic_helper_async_check(dev, state);
 	}
 
 	/* Must be success */


