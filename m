Return-Path: <SRS0=YpA9=XT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19CC0C432C1
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 16:46:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D93E621D6C
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 16:46:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569343605;
	bh=RXz6wrou/rLsSHwyEPfyPMYLuJ/X2bB/HTRQZPCvBoU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=GP804CP0iVO4+7OeUj/zukXrfPF4t5MIx2f6VhhEgR8e2qha1d6PHqI2dlZVeveEn
	 RC5XvQnCmuzGLSR8DApDcacwX4JvuMBBLft0/rU5bkP4B1+pSjQmAIcoko5Wc9fjJK
	 oQT/f8+JZPOzQbgjD/00Ax90oYZ+kQTfPi4i13kk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2633280AbfIXQqo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Sep 2019 12:46:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:37420 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2633263AbfIXQqj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 12:46:39 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DCE0121D82;
        Tue, 24 Sep 2019 16:46:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569343598;
        bh=RXz6wrou/rLsSHwyEPfyPMYLuJ/X2bB/HTRQZPCvBoU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qZEQ+KouidK6bsaSSLrC9pbWlfkNF9+KfuVP8HjOQG0nm424Qp64+ki20neofpz8y
         Fnuy6iAuU3FLGh4aDZBEiIk6qTDSplwUdQkFkkvWKzAbxow9lDwXnFzpkTBI3Sd8y9
         l4u8PkBDiIuTvQaHy39swhbvjPIZYSH8jTHdKBks=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Anthony Koo <Anthony.Koo@amd.com>, Aric Cyr <Aric.Cyr@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 5.2 22/70] drm/amd/display: fix issue where 252-255 values are clipped
Date:   Tue, 24 Sep 2019 12:45:01 -0400
Message-Id: <20190924164549.27058-22-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190924164549.27058-1-sashal@kernel.org>
References: <20190924164549.27058-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Anthony Koo <Anthony.Koo@amd.com>

[ Upstream commit 1cbcfc975164f397b449efb17f59d81a703090db ]

[Why]
When endpoint is at the boundary of a region, such as at 2^0=1
we find that the last segment has a sharp slope and some points
are clipped at the top.

[How]
If end point is 1, which is exactly at the 2^0 region boundary, we
need to program an additional region beyond this point.

Signed-off-by: Anthony Koo <Anthony.Koo@amd.com>
Reviewed-by: Aric Cyr <Aric.Cyr@amd.com>
Acked-by: Leo Li <sunpeng.li@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_cm_common.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_cm_common.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_cm_common.c
index 7469333a2c8a5..8166fdbacd732 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_cm_common.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_cm_common.c
@@ -357,9 +357,10 @@ bool cm_helper_translate_curve_to_hw_format(
 		seg_distr[7] = 4;
 		seg_distr[8] = 4;
 		seg_distr[9] = 4;
+		seg_distr[10] = 1;
 
 		region_start = -10;
-		region_end = 0;
+		region_end = 1;
 	}
 
 	for (i = region_end - region_start; i < MAX_REGIONS_NUMBER ; i++)
-- 
2.20.1

