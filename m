Return-Path: <SRS0=vISB=2T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3320C2D0CE
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 17:51:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7027B20718
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 17:51:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577641901;
	bh=eCAlv30TFhjQdVxRoptfBqArYcooBSTsH5cy3YcU/18=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=KK/SzUuq4Wk4Gs3WNpUEpBXPIAmahHZeKWoD3nm8CfovO5k4HMb2qCfTIR/LiLexL
	 xt+2ToudrZ6BUVoKXZLqcjyh8OuZGXY6/D0czJF42rqaT5NDzIHb6Cze5nKQ7BPuXG
	 Y2qSE8Z6Tz8r2qEfdELu+hBTdqdk2wLEUQurBxoM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732132AbfL2Rvk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Dec 2019 12:51:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:37102 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732111AbfL2Rvf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Dec 2019 12:51:35 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6AE1321744;
        Sun, 29 Dec 2019 17:51:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577641894;
        bh=eCAlv30TFhjQdVxRoptfBqArYcooBSTsH5cy3YcU/18=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HhiDcC37nYN79FlVeYYC6bTrMmn20bFrCYHHRAGVEFdpnGNdHlWBlG8mPmIjkPxOf
         qq9letXu2kcWYePIHZFF7Pqov78Hyb/3GGgEePCV+g5LjXziZ5V00gH6CIMGnUXJoz
         nHksrH5n1fPKc2SBg9mTk85Tgt9WziPFJUCEWrwU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Raul E Rangel <rrangel@chromium.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 256/434] drm/amd/powerplay: fix struct init in renoir_print_clk_levels
Date:   Sun, 29 Dec 2019 18:25:09 +0100
Message-Id: <20191229172718.933456949@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191229172702.393141737@linuxfoundation.org>
References: <20191229172702.393141737@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Raul E Rangel <rrangel@chromium.org>

[ Upstream commit d942070575910fdb687b9c8fd5467704b2f77c24 ]

drivers/gpu/drm/amd/powerplay/renoir_ppt.c:186:2: error: missing braces
around initializer [-Werror=missing-braces]
  SmuMetrics_t metrics = {0};
    ^

Fixes: 8b8031703bd7 ("drm/amd/powerplay: implement sysfs for getting dpm clock")

Signed-off-by: Raul E Rangel <rrangel@chromium.org>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/powerplay/renoir_ppt.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/powerplay/renoir_ppt.c b/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
index e62bfba51562..e5283dafc414 100644
--- a/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
@@ -183,11 +183,13 @@ static int renoir_print_clk_levels(struct smu_context *smu,
 	int i, size = 0, ret = 0;
 	uint32_t cur_value = 0, value = 0, count = 0, min = 0, max = 0;
 	DpmClocks_t *clk_table = smu->smu_table.clocks_table;
-	SmuMetrics_t metrics = {0};
+	SmuMetrics_t metrics;
 
 	if (!clk_table || clk_type >= SMU_CLK_COUNT)
 		return -EINVAL;
 
+	memset(&metrics, 0, sizeof(metrics));
+
 	ret = smu_update_table(smu, SMU_TABLE_SMU_METRICS, 0,
 			       (void *)&metrics, false);
 	if (ret)
-- 
2.20.1



