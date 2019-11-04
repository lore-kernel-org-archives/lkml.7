Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12CCBCA9EC9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 22:08:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF3E0217F5
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 22:08:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572905288;
	bh=6lQVyhzOLL8aPXCH/uMZev8n5PhKZsk+ymbNmbvjk7g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=aAYrFRg7tiDZW8G1FSDe4U6x1rdGJE7UQZUTH6UXkTbv6/AJy71lcQLk0MQVJ7byq
	 VfkvBKoi7Nzc2wlErB/iCOTQS0AqnBi1OWd4g2pNPq2TnnMKZ0mLCqYrLyYC3Kazaa
	 2RYaw3FsVjdMeLMshDHtE80EmY1qqAZIAIZ53p2s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390191AbfKDWIH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 17:08:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:40782 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388489AbfKDWIE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 17:08:04 -0500
Received: from localhost (6.204-14-84.ripe.coltfrance.com [84.14.204.6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 21E3B205C9;
        Mon,  4 Nov 2019 22:08:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572905283;
        bh=6lQVyhzOLL8aPXCH/uMZev8n5PhKZsk+ymbNmbvjk7g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ez/FDe7bH1Dl3c0YheczbXVar7eAWP7ywVwYreHIaAmTxeV5vLIQAfXg5DF55rYK3
         2Tgyde9swqv/lNOQN4Q7GVYF97fC3vJFCEmbJLw5Qqv+H0z/ehSy78OoxAYfpSaLeE
         B22IMkuiqvFtwqhRCQ4/CZZjLxHx4jBnorlrRuG8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Joe Perches <joe@perches.com>,
        Yan-Hsuan Chuang <yhchuang@realtek.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.3 090/163] rtw88: Fix misuse of GENMASK macro
Date:   Mon,  4 Nov 2019 22:44:40 +0100
Message-Id: <20191104212146.723650192@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191104212140.046021995@linuxfoundation.org>
References: <20191104212140.046021995@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joe Perches <joe@perches.com>

[ Upstream commit 5ff29d836d1beb347080bd96e6321c811a8e3f62 ]

Arguments are supposed to be ordered high then low.

Signed-off-by: Joe Perches <joe@perches.com>
Acked-by: Yan-Hsuan Chuang <yhchuang@realtek.com>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/realtek/rtw88/rtw8822b.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw88/rtw8822b.c b/drivers/net/wireless/realtek/rtw88/rtw8822b.c
index 1172f6c0605b3..d61d534396c73 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8822b.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8822b.c
@@ -997,7 +997,7 @@ static void rtw8822b_do_iqk(struct rtw_dev *rtwdev)
 	rtw_write_rf(rtwdev, RF_PATH_A, RF_DTXLOK, RFREG_MASK, 0x0);
 
 	reload = !!rtw_read32_mask(rtwdev, REG_IQKFAILMSK, BIT(16));
-	iqk_fail_mask = rtw_read32_mask(rtwdev, REG_IQKFAILMSK, GENMASK(0, 7));
+	iqk_fail_mask = rtw_read32_mask(rtwdev, REG_IQKFAILMSK, GENMASK(7, 0));
 	rtw_dbg(rtwdev, RTW_DBG_PHY,
 		"iqk counter=%d reload=%d do_iqk_cnt=%d n_iqk_fail(mask)=0x%02x\n",
 		counter, reload, ++do_iqk_cnt, iqk_fail_mask);
-- 
2.20.1



