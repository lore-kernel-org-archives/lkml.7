Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4491FC433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 13:36:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C7C72073D
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 13:36:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564752968;
	bh=sLxGRHB82ABi8IPvwEJ48S+TkbwPSy9Tse9vCufO+2E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hGcDD8GmhcEjFCPRmGJcUJeb2SM627Fm6pTqtj8nmPned+FQ4Q7SGVBqUxOVRvd3g
	 12NtX8nNqPY4OXMr5UBGHUl9sjiRrY+0lIk1zzlaGaFQEPKnYWDTLeAxOwFG0jr0BA
	 8SaMb+q54WoNA2J6IfQvzBpk9pKCh222yLJNSZj4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391968AbfHBNgB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 09:36:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:58946 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2393378AbfHBNUa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 09:20:30 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 05B512173E;
        Fri,  2 Aug 2019 13:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564752029;
        bh=sLxGRHB82ABi8IPvwEJ48S+TkbwPSy9Tse9vCufO+2E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jSO4b/GITALvkSAnH+jQ4eOj7bJRU76fskGBG2bpUClmaEm+M1k5DUfbXk0Bf0AWK
         a95juFbLRtR2g9ta2/u2fBSbCXb/aUcpaBrE4qfdN5rjwSc9ohw729ZZiVY9lfMSoA
         PSPmlPzuqFCqletJMj5m6mkTdMBr1qeJrWZHYKeE=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Tai Man <taiman.wong@amd.com>,
        Joshua Aberback <Joshua.Aberback@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 5.2 25/76] drm/amd/display: Increase size of audios array
Date:   Fri,  2 Aug 2019 09:18:59 -0400
Message-Id: <20190802131951.11600-25-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190802131951.11600-1-sashal@kernel.org>
References: <20190802131951.11600-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tai Man <taiman.wong@amd.com>

[ Upstream commit 7352193a33dfc9b69ba3bf6a8caea925b96243b1 ]

[Why]
The audios array defined in "struct resource_pool" is only 6 (MAX_PIPES)
but the max number of audio devices (num_audio) is 7. In some projects,
it will run out of audios array.

[How]
Incraese the audios array size to 7.

Signed-off-by: Tai Man <taiman.wong@amd.com>
Reviewed-by: Joshua Aberback <Joshua.Aberback@amd.com>
Acked-by: Leo Li <sunpeng.li@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/inc/core_types.h   | 2 +-
 drivers/gpu/drm/amd/display/dc/inc/hw/hw_shared.h | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/inc/core_types.h b/drivers/gpu/drm/amd/display/dc/inc/core_types.h
index 6f5ab05d64677..6f0cc718fbd75 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/core_types.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/core_types.h
@@ -169,7 +169,7 @@ struct resource_pool {
 	struct clock_source *clock_sources[MAX_CLOCK_SOURCES];
 	unsigned int clk_src_count;
 
-	struct audio *audios[MAX_PIPES];
+	struct audio *audios[MAX_AUDIOS];
 	unsigned int audio_count;
 	struct audio_support audio_support;
 
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/hw_shared.h b/drivers/gpu/drm/amd/display/dc/inc/hw/hw_shared.h
index 4c8e2c6fb6dbc..72266efd826cf 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/hw_shared.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/hw_shared.h
@@ -34,6 +34,7 @@
  * Data types shared between different Virtual HW blocks
  ******************************************************************************/
 
+#define MAX_AUDIOS 7
 #define MAX_PIPES 6
 
 struct gamma_curve {
-- 
2.20.1

