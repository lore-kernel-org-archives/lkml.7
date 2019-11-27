Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5443FC43215
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 21:04:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21D4D21775
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 21:04:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574888662;
	bh=YRIoyCqFbllyk9Rbao0HAflYjxyFvS7VSLfoVAW4XKI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=YTTJPioNgGuMkxu3+hMIshX9TXR639P/H9kADcTHvG3GVIEm0tlYrKxSwV1wvF158
	 W363ovtsLdA5/V2TvYPvl8+LlbgmJUcP8Yxd4+8NnlZIZP2NuGooMLb6wc7yg/0m9f
	 2OH8GtzIm5bvLr6mIeK55MKYb7+XmjfS40DQFdZY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732137AbfK0VEU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 16:04:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:57678 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731521AbfK0VEP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 16:04:15 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 27D432086A;
        Wed, 27 Nov 2019 21:04:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574888654;
        bh=YRIoyCqFbllyk9Rbao0HAflYjxyFvS7VSLfoVAW4XKI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=in82cZC+c+V6j4Nql8YgnMPj6PLNN3YN7khKUc2nL9QyAbZyKzuaThpSKfQA9PhEk
         ansdj/t3xCE9wiGDsECfUT+5IgbagamE06w/avgwomZN52HDmcrlOEw/nTeTKCdZnz
         KQA1nLTs8VZrW6d6RdpSqpPkg650Yc/B9SMdqBJs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Brian Norris <briannorris@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Kalle Valo <kvalo@codeaurora.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 217/306] ath10k: snoc: fix unbalanced clock error handling
Date:   Wed, 27 Nov 2019 21:31:07 +0100
Message-Id: <20191127203130.930122869@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191127203114.766709977@linuxfoundation.org>
References: <20191127203114.766709977@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Brian Norris <briannorris@chromium.org>

[ Upstream commit 82e60d920e8ad70cd9a280ab156566755f1fe4aa ]

Similar to regulator error handling, we should only start tearing down
the 'i - 1' clock when clock 'i' fails to enable. Otherwise, we might
end up with an unbalanced clock, where we never successfully enabled the
clock, but we try to disable it anyway.

Fixes: a6a793f98786 ("ath10k: vote for hardware resources for WCN3990")
Signed-off-by: Brian Norris <briannorris@chromium.org>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/ath/ath10k/snoc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath10k/snoc.c b/drivers/net/wireless/ath/ath10k/snoc.c
index fa1843a7e0fda..e2d78f77edb70 100644
--- a/drivers/net/wireless/ath/ath10k/snoc.c
+++ b/drivers/net/wireless/ath/ath10k/snoc.c
@@ -1190,7 +1190,7 @@ static int ath10k_wcn3990_clk_init(struct ath10k *ar)
 	return 0;
 
 err_clock_config:
-	for (; i >= 0; i--) {
+	for (i = i - 1; i >= 0; i--) {
 		clk_info = &ar_snoc->clk[i];
 
 		if (!clk_info->handle)
-- 
2.20.1



