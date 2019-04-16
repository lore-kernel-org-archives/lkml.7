Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D0B6C10F0E
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 00:37:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64A522075B
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 00:37:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728288AbfDPAhY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 20:37:24 -0400
Received: from gateway20.websitewelcome.com ([192.185.55.25]:15889 "EHLO
        gateway20.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726527AbfDPAhY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 20:37:24 -0400
Received: from cm16.websitewelcome.com (cm16.websitewelcome.com [100.42.49.19])
        by gateway20.websitewelcome.com (Postfix) with ESMTP id 03DCD400C6385
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2019 19:37:23 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id GC6EhRS5O4FKpGC6EhutbD; Mon, 15 Apr 2019 19:37:23 -0500
X-Authority-Reason: nr=8
Received: from [189.250.55.242] (port=59018 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1hGC6E-002zVf-6N; Mon, 15 Apr 2019 19:37:22 -0500
Date:   Mon, 15 Apr 2019 19:36:26 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Ping-Ke Shih <pkshih@realtek.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        "David S. Miller" <davem@davemloft.net>
Cc:     linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Kees Cook <keescook@chromium.org>
Subject: [PATCH wireless-drivers] rtlwifi: rtl8723ae: Fix missing break in
 switch statement
Message-ID: <20190416003626.GA16834@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.250.55.242
X-Source-L: No
X-Exim-ID: 1hGC6E-002zVf-6N
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.55.242]:59018
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 6
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing break statement in order to prevent the code from falling
through to case 0x1025, and erroneously setting rtlhal->oem_id to
RT_CID_819X_ACER when rtlefuse->eeprom_svid is equal to 0x10EC and
none of the cases in switch (rtlefuse->eeprom_smid) match.

This bug was found thanks to the ongoing efforts to enable
-Wimplicit-fallthrough.

Fixes: 238ad2ddf34b ("rtlwifi: rtl8723ae: Clean up the hardware info routine")
Cc: stable@vger.kernel.org
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/net/wireless/realtek/rtlwifi/rtl8723ae/hw.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8723ae/hw.c b/drivers/net/wireless/realtek/rtlwifi/rtl8723ae/hw.c
index 6bab162e1bb8..655460f61bbc 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8723ae/hw.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8723ae/hw.c
@@ -1675,6 +1675,7 @@ static void _rtl8723e_read_adapter_info(struct ieee80211_hw *hw,
 					rtlhal->oem_id = RT_CID_819X_LENOVO;
 					break;
 				}
+				break;
 			case 0x1025:
 				rtlhal->oem_id = RT_CID_819X_ACER;
 				break;
-- 
2.21.0

