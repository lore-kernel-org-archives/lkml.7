Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAA0FC32750
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 13:36:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5C0B20665
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 13:36:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564752974;
	bh=lqq2VbkePfNbRKWHBmATFXzrCNh4xuuTzls6CUQ9NzA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ry6uUW9qtRRqsyEluZc0SoHmH8KVwCRPCnKHdUvapPE7gaCS10/e3A5DsTfuM55SS
	 dhgsVxFUnwzadw6J0jg07YLI5SzmVOkvO2QwLNDgKYofSjWeffIS3TxirhnGYvfzQ+
	 /0UyRhoAy0wVqSV4vUjavsWh6/YX6H8FvbgbH6aE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392098AbfHBNgN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 09:36:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:58758 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2393353AbfHBNUY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 09:20:24 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6AB5821849;
        Fri,  2 Aug 2019 13:20:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564752023;
        bh=lqq2VbkePfNbRKWHBmATFXzrCNh4xuuTzls6CUQ9NzA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fEgMcwBvaB2DJxOyl4jyhGcLil8yKHTBzlFianS6oqxr2NP0mxbdLW3LfLB2+4eFG
         SCgnsiQmNqXtemkwmHxU1FN+9m5KNI2Rns4CJMiS/WNryRAnWxJz924xMTuGVejLNe
         1HyvVKitagyGwUWsWJwJkTxbqvmJvmPB5Q2f10sE=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Derek Lai <Derek.Lai@amd.com>, Aric Cyr <Aric.Cyr@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 5.2 22/76] drm/amd/display: allocate 4 ddc engines for RV2
Date:   Fri,  2 Aug 2019 09:18:56 -0400
Message-Id: <20190802131951.11600-22-sashal@kernel.org>
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

From: Derek Lai <Derek.Lai@amd.com>

[ Upstream commit 67fd6c0d2de8e51e84ff3fa6e68bbd524f823e49 ]

[Why]
Driver will create 0, 1, and 2 ddc engines for RV2,
but some platforms used 0, 1, and 3.

[How]
Still allocate 4 ddc engines for RV2.

Signed-off-by: Derek Lai <Derek.Lai@amd.com>
Reviewed-by: Aric Cyr <Aric.Cyr@amd.com>
Acked-by: Leo Li <sunpeng.li@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_resource.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_resource.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_resource.c
index 7eccb54c421d9..aac52eed6b2aa 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_resource.c
@@ -512,7 +512,7 @@ static const struct resource_caps rv2_res_cap = {
 		.num_audio = 3,
 		.num_stream_encoder = 3,
 		.num_pll = 3,
-		.num_ddc = 3,
+		.num_ddc = 4,
 };
 #endif
 
-- 
2.20.1

