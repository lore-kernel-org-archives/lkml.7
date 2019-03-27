Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 021F0C10F00
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 19:25:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B82ED206C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 19:25:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553714708;
	bh=Bo7BmLm57a00gi9w6JjkHgzSbD/QgUcwRa4zFbDUc2A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=h+yO8QDbmBfpO1NBzK0YISUTjpJ9yUVRP0DqT/PQm7u37B50MB8neh2NUTNOzTaC7
	 3cpnUaBx8EbE1pzOPBjvfZ31MzAG25y70IbGbBwrNz205zrve7HCouwfvfMkouBrD9
	 lqM5pjwSFCejHqM6S+76Cggcq2CiJPOQgFI7FpUs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387693AbfC0SF1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 14:05:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:46488 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387672AbfC0SFW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 14:05:22 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EDCC92063F;
        Wed, 27 Mar 2019 18:05:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553709921;
        bh=Bo7BmLm57a00gi9w6JjkHgzSbD/QgUcwRa4zFbDUc2A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=I1jCiQ52p/aGPguWKt+7bmca/4Zr6zvAnVGn5kG7rPi3ejYIGGcrrWpR+f5iyfBUW
         bXco/LFXAVTjp8fTzW1McIIyKPPJEx9RNmr7wDS5T1BwngmfRoMGDrzXu6DdbVKQjx
         FC3SxnIEsnw2ok/duIdbJdwRvBMi9kly54Nl96EY=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 5.0 114/262] drm/amd/display: Clear stream->mode_changed after commit
Date:   Wed, 27 Mar 2019 13:59:29 -0400
Message-Id: <20190327180158.10245-114-sashal@kernel.org>
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

From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

[ Upstream commit d8d2f174bcc2c26c3485c70e0c6fe22b27bce739 ]

[Why]
The stream->mode_changed flag can persist in the following sequence
of atomic commits:

Commit 1:
Enable CRTC0 (mode_changed = true), Enable CRTC1 (mode_changed = true)

Commit 2:
Disable CRTC1 (mode_changed = false)

In this sequence we want to keep the exiting CRTC0 but it's not in the
atomic state for the commit since it hasn't been modified. In this case
the stream->mode_changed flag persists as true and we don't re-program
the planes for the existing stream.

[How]
The flag needs to be cleared and it makes the most sense to do it within
DC after the state has been committed. Nothing following dc_commit_state
should think that the stream's mode has changed.

Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Reviewed-by: Leo Li <sunpeng.li@amd.com>
Acked-by: Tony Cheng <Tony.Cheng@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 5fd52094d459..1f92e7e8e3d3 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -1078,6 +1078,9 @@ static enum dc_status dc_commit_state_no_check(struct dc *dc, struct dc_state *c
 	/* pplib is notified if disp_num changed */
 	dc->hwss.optimize_bandwidth(dc, context);
 
+	for (i = 0; i < context->stream_count; i++)
+		context->streams[i]->mode_changed = false;
+
 	dc_release_state(dc->current_state);
 
 	dc->current_state = context;
-- 
2.19.1

