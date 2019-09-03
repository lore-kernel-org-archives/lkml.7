Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBDEFC3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 16:26:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB40E238F5
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 16:26:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567527978;
	bh=HlB0kFLFJRGc5nkzsNDy3iGdtD6dK1xJYjtH+voD000=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=BlyLV2yHfs2KIlHTrjf68T1aH4W9UbwDGx8UMf7AGwkg3FBkgyNF475um5SqjAZHt
	 2NBr9SE8+Q0N8VN2mZzZjYeUsslO4URMGWV424uA3YXq4KNSYAH5czo6DiJz5KYc45
	 dIkj2ikxz3hjWlpdtQt5GK/7ZTDcVVhoned+ZNjc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730592AbfICQ0S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 12:26:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:46478 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730522AbfICQZ7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 12:25:59 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0D79723711;
        Tue,  3 Sep 2019 16:25:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567527958;
        bh=HlB0kFLFJRGc5nkzsNDy3iGdtD6dK1xJYjtH+voD000=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=npMS1YpbXaEj9TVharNKA4Q+6JltSwqq7jBZoQSrYfBjLVW6XYCtW0Yg5MeXa0F8g
         PR2YQlI0OQZP98nFYnqVS6+lLp4hmInNQH1wf2cH9Y/GkeYcqmY2LB2DxanQLNtPWx
         93Mb2LaDxtL7E1/haaYkc6tBXOmCZMyh1EGbyWoQ=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     David Francis <David.Francis@amd.com>,
        Harry Wentland <harry.wentland@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 4.19 022/167] powerplay: Respect units on max dcfclk watermark
Date:   Tue,  3 Sep 2019 12:22:54 -0400
Message-Id: <20190903162519.7136-22-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190903162519.7136-1-sashal@kernel.org>
References: <20190903162519.7136-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Francis <David.Francis@amd.com>

[ Upstream commit f191415b24a3ad3fa22088af7cd7fc328a2f469f ]

In a refactor, the watermark clock inputs to
powerplay from DC were changed from units of 10kHz to
kHz clocks.

One division by 100 was not converted into a division
by 1000.

Signed-off-by: David Francis <David.Francis@amd.com>
Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/powerplay/hwmgr/smu_helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/smu_helper.c b/drivers/gpu/drm/amd/powerplay/hwmgr/smu_helper.c
index 2aab1b4759459..a321c465b7dce 100644
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/smu_helper.c
+++ b/drivers/gpu/drm/amd/powerplay/hwmgr/smu_helper.c
@@ -674,7 +674,7 @@ int smu_set_watermarks_for_clocks_ranges(void *wt_table,
 		table->WatermarkRow[1][i].MaxClock =
 			cpu_to_le16((uint16_t)
 			(wm_with_clock_ranges->wm_dmif_clocks_ranges[i].wm_max_dcfclk_clk_in_khz) /
-			100);
+			1000);
 		table->WatermarkRow[1][i].MinUclk =
 			cpu_to_le16((uint16_t)
 			(wm_with_clock_ranges->wm_dmif_clocks_ranges[i].wm_min_mem_clk_in_khz) /
-- 
2.20.1

