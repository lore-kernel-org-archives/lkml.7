Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 952EFC432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 20:37:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AA13215A5
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 20:37:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574887029;
	bh=KyCR4irzEfG7n+3FZsoOJ3KbIgEkN2xASgay6KATBSg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=c8jzL+uhuQUhNYWk9RNoU24d7o+FXpJzNxop8MakjHFxTmgxH5n3863OyQ8fKH65m
	 Mv39Mni8ojpRP2kl3qYBXTU1HFB2m9Q7kCBz83Y5OoW/2LjN+P4XKJXiQITya45j85
	 luFmn1CFU8rSvVkbyIFNf6WLP5fj3H456uVleY4E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728516AbfK0UhI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 15:37:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:39886 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727587AbfK0UhG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 15:37:06 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 230E320862;
        Wed, 27 Nov 2019 20:37:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574887025;
        bh=KyCR4irzEfG7n+3FZsoOJ3KbIgEkN2xASgay6KATBSg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=m65HqhRieGoLuE4GgxHHexUNhltZ2MkilscmYpsjo7vqcVIZ2lI/xNN0LuM948hqm
         0hQ9H7nEGzEgZOBUJZPwkm0hchNymfdfcr0ItQPzJ2Lprtzfeovh2qserolmoiCg3X
         jnVq0hRGRyeIK0q7HeSmwzK0ymvoZR6s/wufBOYs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ping-Ke Shih <pkshih@realtek.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Shaokun Zhang <zhangshaokun@hisilicon.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 085/132] rtlwifi: rtl8192de: Fix misleading REG_MCUFWDL information
Date:   Wed, 27 Nov 2019 21:31:16 +0100
Message-Id: <20191127203015.128835275@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191127202857.270233486@linuxfoundation.org>
References: <20191127202857.270233486@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shaokun Zhang <zhangshaokun@hisilicon.com>

[ Upstream commit 7d129adff3afbd3a449bc3593f2064ac546d58d3 ]

RT_TRACE shows REG_MCUFWDL value as a decimal value with a '0x'
prefix, which is somewhat misleading.

Fix it to print hexadecimal, as was intended.

Cc: Ping-Ke Shih <pkshih@realtek.com>
Cc: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Shaokun Zhang <zhangshaokun@hisilicon.com>
Acked-by: Ping-Ke Shih <pkshih@realtek.com>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/realtek/rtlwifi/rtl8192de/fw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192de/fw.c b/drivers/net/wireless/realtek/rtlwifi/rtl8192de/fw.c
index 62ef8209718f1..5bf3712a4d49d 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192de/fw.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192de/fw.c
@@ -234,7 +234,7 @@ static int _rtl92d_fw_init(struct ieee80211_hw *hw)
 			 rtl_read_byte(rtlpriv, FW_MAC1_READY));
 	}
 	RT_TRACE(rtlpriv, COMP_FW, DBG_DMESG,
-		 "Polling FW ready fail!! REG_MCUFWDL:0x%08ul\n",
+		 "Polling FW ready fail!! REG_MCUFWDL:0x%08x\n",
 		 rtl_read_dword(rtlpriv, REG_MCUFWDL));
 	return -1;
 }
-- 
2.20.1



