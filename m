Return-Path: <SRS0=YpA9=XT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C80A2C432C1
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 16:56:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E68C2054F
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 16:56:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569344217;
	bh=of1QNR5HzhXjDt1fZDPwtrYQyMCUkN8V/luTjRNiZu0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xUG/OcRz7Gu3mMVq7IhudBaGy9z52sDAp6JvsqX1Qvgl+WbLW2M27TG8rKznxan4u
	 SEdyyYgEbn0tKn2K2yJYtoyf3O3JDfxgSk939gJHjg641+kkYJj7HcpJ7UeauXIcEB
	 yd1WvkqD/bzzsvysgibSY6DacEGdN08+1HpBUWHM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410245AbfIXQtJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Sep 2019 12:49:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:41104 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2410199AbfIXQtC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 12:49:02 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 63B1F217D9;
        Tue, 24 Sep 2019 16:49:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569343742;
        bh=of1QNR5HzhXjDt1fZDPwtrYQyMCUkN8V/luTjRNiZu0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SXpoGhi/X8t8HQIS4tysdJ0MbQxI+I2mvSrIOivwjgvIdfhDqxmdEajqY5yugcEdC
         zpc1Hp95/6QYqBgssrqHg5RVLuiU92vRGcRurGig9VgrvApfJYgZfm4clv3mI0Qz68
         Z8jy6o60OV8NDYUmH7tIh85usdTWlX4V3ue3LqNc=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Sean Paul <seanpaul@chromium.org>, Zain Wang <wzz@rock-chips.com>,
        Tomasz Figa <tfiga@chromium.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Sasha Levin <sashal@kernel.org>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 4.19 08/50] drm/rockchip: Check for fast link training before enabling psr
Date:   Tue, 24 Sep 2019 12:48:05 -0400
Message-Id: <20190924164847.27780-8-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190924164847.27780-1-sashal@kernel.org>
References: <20190924164847.27780-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sean Paul <seanpaul@chromium.org>

[ Upstream commit ad309284a52be47c8b3126c9376358bf381861bc ]

Once we start shutting off the link during PSR, we're going to want fast
training to work. If the display doesn't support fast training, don't
enable psr.

Changes in v2:
- None
Changes in v3:
- None
Changes in v4:
- None
Changes in v5:
- None

Link to v1: https://patchwork.freedesktop.org/patch/msgid/20190228210939.83386-3-sean@poorly.run
Link to v2: https://patchwork.freedesktop.org/patch/msgid/20190326204509.96515-2-sean@poorly.run
Link to v3: https://patchwork.freedesktop.org/patch/msgid/20190502194956.218441-9-sean@poorly.run
Link to v4: https://patchwork.freedesktop.org/patch/msgid/20190508160920.144739-8-sean@poorly.run

Cc: Zain Wang <wzz@rock-chips.com>
Cc: Tomasz Figa <tfiga@chromium.org>
Tested-by: Heiko Stuebner <heiko@sntech.de>
Reviewed-by: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Sean Paul <seanpaul@chromium.org>
Link: https://patchwork.freedesktop.org/patch/msgid/20190611160844.257498-8-sean@poorly.run
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/bridge/analogix/analogix_dp_core.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
index d68986cea1325..84abf5d6f760a 100644
--- a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
+++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
@@ -1040,16 +1040,17 @@ static int analogix_dp_commit(struct analogix_dp_device *dp)
 	if (ret)
 		return ret;
 
+	/* Check whether panel supports fast training */
+	ret = analogix_dp_fast_link_train_detection(dp);
+	if (ret)
+		dp->psr_enable = false;
+
 	if (dp->psr_enable) {
 		ret = analogix_dp_enable_sink_psr(dp);
 		if (ret)
 			return ret;
 	}
 
-	/* Check whether panel supports fast training */
-	ret =  analogix_dp_fast_link_train_detection(dp);
-	if (ret)
-		dp->psr_enable = false;
 
 	return ret;
 }
-- 
2.20.1

