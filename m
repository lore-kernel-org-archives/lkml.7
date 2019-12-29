Return-Path: <SRS0=vISB=2T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D3F5C2D0CE
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 17:45:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8A31207FD
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 17:45:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577641528;
	bh=6o/tH8oeO74qTujAoPPNmL7NRmfGfqKYrX5yZ4nllFs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=aPyiPqKkVb6B5lu3jcxZCj5VifyTJeKKTIwQRiBsVpf0YFevxZWuIP6OFNuwh0Kkm
	 sqzzKp8aa7sNfYGg8q/6AEu/hmNwAnMaIVv4zRwdkzPEykuD0m+OVnc4fCrnrMLAef
	 dnBQ5w0a/lGo4ejCAEj+nt36UbIy6K27KHYwmlE4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730902AbfL2Rp0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Dec 2019 12:45:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:54440 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730586AbfL2RpY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Dec 2019 12:45:24 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 22ADD206A4;
        Sun, 29 Dec 2019 17:45:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577641523;
        bh=6o/tH8oeO74qTujAoPPNmL7NRmfGfqKYrX5yZ4nllFs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wnSyeQx5foXp+T2fjKvkd1eadPrnW0uHb2uX67RP60WOlx7A5pmyETrtHxYjjPtwZ
         cuoGQg68pXF3Ej6dbpSH1nVhXrlaoOR7kn6h6jpUfBKYI+Cif8zcoAB/0oHbt6Cyo4
         PRgrKyLwCnPj5wkZ0o11CLKtAeA9Iv+4jRxBBUbE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ping-Ke Shih <pkshih@realtek.com>,
        Yan-Hsuan Chuang <yhchuang@realtek.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 099/434] rtw88: fix NSS of hw_cap
Date:   Sun, 29 Dec 2019 18:22:32 +0100
Message-Id: <20191229172708.170843280@linuxfoundation.org>
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

From: Ping-Ke Shih <pkshih@realtek.com>

[ Upstream commit 4f5bb7ff8b8d4bafd91243fc969ed240e67aa1ca ]

8822C is a 2x2 11ac chip, and then NSS must be less or equal to 2. However,
current nss of hw cap is 3, likes
	hw cap: hci=0x0f, bw=0x07, ptcl=0x03, ant_num=7, nss=3

This commit adds constraint to make sure NSS <= rf_path_num, and result
looks like
	hw cap: hci=0x0f, bw=0x07, ptcl=0x03, ant_num=7, nss=2

Fixes: e3037485c68e ("rtw88: new Realtek 802.11ac driver")
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/realtek/rtw88/main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw88/main.c b/drivers/net/wireless/realtek/rtw88/main.c
index 6dd457741b15..7a3a4911bde2 100644
--- a/drivers/net/wireless/realtek/rtw88/main.c
+++ b/drivers/net/wireless/realtek/rtw88/main.c
@@ -1020,7 +1020,8 @@ static int rtw_dump_hw_feature(struct rtw_dev *rtwdev)
 
 	rtw_hw_config_rf_ant_num(rtwdev, efuse->hw_cap.ant_num);
 
-	if (efuse->hw_cap.nss == EFUSE_HW_CAP_IGNORE)
+	if (efuse->hw_cap.nss == EFUSE_HW_CAP_IGNORE ||
+	    efuse->hw_cap.nss > rtwdev->hal.rf_path_num)
 		efuse->hw_cap.nss = rtwdev->hal.rf_path_num;
 
 	rtw_dbg(rtwdev, RTW_DBG_EFUSE,
-- 
2.20.1



