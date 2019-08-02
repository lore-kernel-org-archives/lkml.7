Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2605C32750
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 13:23:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EF5D20644
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 13:23:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564752220;
	bh=l10GuSudI+FjotOrYmXiH9xEl29VjZLJ0uN7IGgcUyk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=g5+5+kDsrAlQpeI97qCBaEo6znc9qJ9Tgc4hb8zuUNtt+4ABdYTmtbYy5+J/S+AH5
	 8ELlj1BGxZQYmwb+iDMuW6cnDetVXf8x89CivMKTnGkRnsKErjef4yyVFuNCVEqR18
	 26aPpuPOcwPu1KlXEil/m6hQN+0jxZ+YYxhuwEqs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393996AbfHBNXi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 09:23:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:34084 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388875AbfHBNXe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 09:23:34 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D46AB20644;
        Fri,  2 Aug 2019 13:23:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564752213;
        bh=l10GuSudI+FjotOrYmXiH9xEl29VjZLJ0uN7IGgcUyk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=C7eSw7g5wb0XBXBsQo+pJ4133ATuetskijrvaH7UVDQ/I7frFQqLSFbPHgwgnt0Ht
         7r6+gZ78S2INhhdFo49tjPZGDtc9i/3sL5oiRkNVZ9JHLPcsOy/EYg+GP1Ih5DrGke
         gk3Oeq06ARvWgQ+AqdwiAjJX1D6VoD1wgL3zYPfo=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Tai Man <taiman.wong@amd.com>,
        Joshua Aberback <Joshua.Aberback@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 4.19 11/42] drm/amd/display: Increase size of audios array
Date:   Fri,  2 Aug 2019 09:22:31 -0400
Message-Id: <20190802132302.13537-11-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190802132302.13537-1-sashal@kernel.org>
References: <20190802132302.13537-1-sashal@kernel.org>
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
index c0b9ca13393b6..f4469fa5afb55 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/core_types.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/core_types.h
@@ -159,7 +159,7 @@ struct resource_pool {
 	struct clock_source *clock_sources[MAX_CLOCK_SOURCES];
 	unsigned int clk_src_count;
 
-	struct audio *audios[MAX_PIPES];
+	struct audio *audios[MAX_AUDIOS];
 	unsigned int audio_count;
 	struct audio_support audio_support;
 
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/hw_shared.h b/drivers/gpu/drm/amd/display/dc/inc/hw/hw_shared.h
index cf7433ebf91a0..71901743a9387 100644
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

