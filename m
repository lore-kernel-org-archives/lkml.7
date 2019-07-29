Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA1C7C433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 19:48:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B08EE205F4
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 19:48:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564429735;
	bh=ZmJcYVj3vIaFeFPJxeMpF8uhIBbkm+iqJEjV41m3/1M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hKMGBaZY9H66z0rYPJ/g18NEmB7VjCPeJZCnvAnq+qNwMCOAsqYdIr7wYEtayNr/X
	 NTRlHdfFr6mlvelBI1HkNgCqkTxCwz08gkZp818znqAkr3kVBNn6oletE0mKbZSTos
	 o/oRhTiH2gJoGqdJ3aeHzzdvbBLEPMWA2+12QvJM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390453AbfG2Tsy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 15:48:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:39132 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390237AbfG2Tst (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 15:48:49 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1B58E2054F;
        Mon, 29 Jul 2019 19:48:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564429728;
        bh=ZmJcYVj3vIaFeFPJxeMpF8uhIBbkm+iqJEjV41m3/1M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0KH1lNkOA2b4RYqNsbqVCP+PHUgtAKZ6Bm0P5QFZMSoYUkKUzpS3LzTf0IVWQjXrU
         JDt4/d7HKDC+ngkASM5CxUs+0tND5bbhgc7f56FSgIlPFbvLhWHMTkdP4QwNFbJTZl
         dCqa9W4QH+MKLHjyelFdH9ylrKLJzagUN8WA+FFM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
        Harry Wentland <Harry.Wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.2 037/215] drm/amd/display: Reset planes for color management changes
Date:   Mon, 29 Jul 2019 21:20:33 +0200
Message-Id: <20190729190746.833737256@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190729190739.971253303@linuxfoundation.org>
References: <20190729190739.971253303@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 7316c4ad299663a16ca9ce13e5e817b4ca760809 ]

[Why]
For commits with allow_modeset=false and CRTC degamma changes the planes
aren't reset. This results in incorrect rendering.

[How]
Reset the planes when color management has changed on the CRTC.
Technically this will include regamma changes as well, but it doesn't
really after legacy userspace since those commit with
allow_modeset=true.

Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Reviewed-by: Harry Wentland <Harry.Wentland@amd.com>
Acked-by: Leo Li <sunpeng.li@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 31530bfd002a..0e482349a5cb 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -6331,6 +6331,10 @@ static bool should_reset_plane(struct drm_atomic_state *state,
 	if (!new_crtc_state)
 		return true;
 
+	/* CRTC Degamma changes currently require us to recreate planes. */
+	if (new_crtc_state->color_mgmt_changed)
+		return true;
+
 	if (drm_atomic_crtc_needs_modeset(new_crtc_state))
 		return true;
 
-- 
2.20.1



