Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15BE2C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:04:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA93A2063F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:04:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553709856;
	bh=PS9cLOtuEHtVrC6GCM+3U4hVfZYr9gBjv0rFFMGxhio=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=iNsDwybvU5vyAsT3sIt46hWrtPh2kqA8K/vym5pNY4aFI116uGQx2K1Ih6maROwhl
	 y53lbEuWqObnkksp9vZD1XvPiETm6ugVTyldr8Sy69E9tfoJVjT77UIUzjxHlxGIsY
	 d7f+84izi3JQ7MxrNr5NdPFvF/1LuQzm4U/N7dMw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730921AbfC0SEO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 14:04:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:44664 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733148AbfC0SEG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 14:04:06 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E160E2063F;
        Wed, 27 Mar 2019 18:04:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553709845;
        bh=PS9cLOtuEHtVrC6GCM+3U4hVfZYr9gBjv0rFFMGxhio=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YsaHK2ICNwF2Gc9G4ZSxU/M7eFvge+QjAPjSuPN2z3SCsVUOslSf832wBL+djO0zK
         iyJD2C1QX1ZCXxmHP6mGlEhOpFxheODPEL3hgfWKebYRp7GXF+Bf3APXtZyMlSjvpo
         pHYiP0LXHSV/X5FVd8tsDPiekman9vqjt3He8E3Y=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 5.0 070/262] drm/amd/display: Pass app_tf by value rather than by reference
Date:   Wed, 27 Mar 2019 13:58:45 -0400
Message-Id: <20190327180158.10245-70-sashal@kernel.org>
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

From: Nathan Chancellor <natechancellor@gmail.com>

[ Upstream commit 672e78cab819ebe31e3b9b8abac367be8a110472 ]

Clang warns when an expression that equals zero is used as a null
pointer constant (in lieu of NULL):

drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:4435:3:
warning: expression which evaluates to zero treated as a null pointer
constant of type 'const enum color_transfer_func *'
[-Wnon-literal-null-conversion]
                TRANSFER_FUNC_UNKNOWN,
                ^~~~~~~~~~~~~~~~~~~~~
1 warning generated.

This warning is caused by commit bb47de736661 ("drm/amdgpu: Set FreeSync
state using drm VRR properties") and it could be solved by using NULL
instead of TRANSFER_FUNC_UNKNOWN or casting TRANSFER_FUNC_UNKNOWN as a
pointer. However, after looking into it, there doesn't appear to be a
good reason to pass app_tf by reference as it is never mutated along the
way. This is the only code path in which app_tf is used:

mod_freesync_build_vrr_infopacket ->
    build_vrr_infopacket_v2 ->
        build_vrr_infopacket_fs2_data

Neither mod_freesync_build_vrr_infopacket or build_vrr_infopacket_v2
modify app_tf's value and build_vrr_infopacket_fs2_data expects just
the value so we can avoid dereferencing anything by just passing in
app_tf's value to mod_freesync_build_vrr_infopacket and
build_vrr_infopacket_v2.

There is no functional change because build_vrr_infopacket_fs2_data
doesn't do anything if TRANSFER_FUNC_UNKNOWN is passed to it, the same
as not calling build_vrr_infopacket_fs2_data at all like before this
change when NULL was used for app_tf.

Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/modules/freesync/freesync.c | 7 +++----
 drivers/gpu/drm/amd/display/modules/inc/mod_freesync.h  | 2 +-
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/modules/freesync/freesync.c b/drivers/gpu/drm/amd/display/modules/freesync/freesync.c
index 1544ed3f1747..945e845f3358 100644
--- a/drivers/gpu/drm/amd/display/modules/freesync/freesync.c
+++ b/drivers/gpu/drm/amd/display/modules/freesync/freesync.c
@@ -656,7 +656,7 @@ static void build_vrr_infopacket_v1(enum signal_type signal,
 
 static void build_vrr_infopacket_v2(enum signal_type signal,
 		const struct mod_vrr_params *vrr,
-		const enum color_transfer_func *app_tf,
+		enum color_transfer_func app_tf,
 		struct dc_info_packet *infopacket)
 {
 	unsigned int payload_size = 0;
@@ -664,8 +664,7 @@ static void build_vrr_infopacket_v2(enum signal_type signal,
 	build_vrr_infopacket_header_v2(signal, infopacket, &payload_size);
 	build_vrr_infopacket_data(vrr, infopacket);
 
-	if (app_tf != NULL)
-		build_vrr_infopacket_fs2_data(*app_tf, infopacket);
+	build_vrr_infopacket_fs2_data(app_tf, infopacket);
 
 	build_vrr_infopacket_checksum(&payload_size, infopacket);
 
@@ -676,7 +675,7 @@ void mod_freesync_build_vrr_infopacket(struct mod_freesync *mod_freesync,
 		const struct dc_stream_state *stream,
 		const struct mod_vrr_params *vrr,
 		enum vrr_packet_type packet_type,
-		const enum color_transfer_func *app_tf,
+		enum color_transfer_func app_tf,
 		struct dc_info_packet *infopacket)
 {
 	/* SPD info packet for FreeSync */
diff --git a/drivers/gpu/drm/amd/display/modules/inc/mod_freesync.h b/drivers/gpu/drm/amd/display/modules/inc/mod_freesync.h
index 949a8b62aa98..063af6258fd9 100644
--- a/drivers/gpu/drm/amd/display/modules/inc/mod_freesync.h
+++ b/drivers/gpu/drm/amd/display/modules/inc/mod_freesync.h
@@ -145,7 +145,7 @@ void mod_freesync_build_vrr_infopacket(struct mod_freesync *mod_freesync,
 		const struct dc_stream_state *stream,
 		const struct mod_vrr_params *vrr,
 		enum vrr_packet_type packet_type,
-		const enum color_transfer_func *app_tf,
+		enum color_transfer_func app_tf,
 		struct dc_info_packet *infopacket);
 
 void mod_freesync_build_vrr_params(struct mod_freesync *mod_freesync,
-- 
2.19.1

