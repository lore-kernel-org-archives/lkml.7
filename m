Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77713C432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 11:12:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EF312070E
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 11:12:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574421163;
	bh=cSP2I36sgXizIVf9FnNRZCxT9E+EkRMfG2cJCSFnRmw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=n2i2XgzaU2jm35643Z9+a3h7iBl/jxTw5ykIkoXqxOY8SCw88JH+Udn7EFjTv4h1m
	 43raTbMNmPQMVJHXO7WMK4rc8i8U/VVQez9BBF9QAzEewu4gx42KqeZJoAYrfv1M0G
	 +Ze+m+flzGS33KFR8rA3wCCFei8S0olqOHuDKWpA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730334AbfKVK53 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 05:57:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:46044 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730651AbfKVK5S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 05:57:18 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8AF1C20718;
        Fri, 22 Nov 2019 10:57:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574420237;
        bh=cSP2I36sgXizIVf9FnNRZCxT9E+EkRMfG2cJCSFnRmw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TZ/Bf/vo61m8qJQN1CUXKOwrO/+a7hKWiV6uPFKVOGRKT9J5Fbe+BejDZFMEg/4gp
         40XQgereD7EYilmcH3WlVZ5mq+RkhstDsQar62eUvkSg/RNhxT8hdpsN/e09szO8nB
         gkwXVuubPnVgnN90wehMseIvivIYOn72/suQrPUY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Nathan Chancellor <natechancellor@gmail.com>,
        Ping-Ke Shih <pkshih@realtek.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 039/220] rtlwifi: btcoex: Use proper enumerated types for Wi-Fi only interface
Date:   Fri, 22 Nov 2019 11:26:44 +0100
Message-Id: <20191122100915.126568457@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191122100912.732983531@linuxfoundation.org>
References: <20191122100912.732983531@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nathan Chancellor <natechancellor@gmail.com>

[ Upstream commit 31138a827d1b3d6e4855bddb5a1e44e7b32309c0 ]

Clang warns when one enumerated type is implicitly converted to another.

drivers/net/wireless/realtek/rtlwifi/btcoexist/halbtcoutsrc.c:1327:34:
warning: implicit conversion from enumeration type 'enum
btc_chip_interface' to different enumeration type 'enum
wifionly_chip_interface' [-Wenum-conversion]
                wifionly_cfg->chip_interface = BTC_INTF_PCI;
                                             ~ ^~~~~~~~~~~~
drivers/net/wireless/realtek/rtlwifi/btcoexist/halbtcoutsrc.c:1330:34:
warning: implicit conversion from enumeration type 'enum
btc_chip_interface' to different enumeration type 'enum
wifionly_chip_interface' [-Wenum-conversion]
                wifionly_cfg->chip_interface = BTC_INTF_USB;
                                             ~ ^~~~~~~~~~~~
drivers/net/wireless/realtek/rtlwifi/btcoexist/halbtcoutsrc.c:1333:34:
warning: implicit conversion from enumeration type 'enum
btc_chip_interface' to different enumeration type 'enum
wifionly_chip_interface' [-Wenum-conversion]
                wifionly_cfg->chip_interface = BTC_INTF_UNKNOWN;
                                             ~ ^~~~~~~~~~~~~~~~
3 warnings generated.

Use the values from the correct enumerated type, wifionly_chip_interface.

BTC_INTF_UNKNOWN = WIFIONLY_INTF_UNKNOWN = 0
BTC_INTF_PCI = WIFIONLY_INTF_PCI = 1
BTC_INTF_USB = WIFIONLY_INTF_USB = 2

Link: https://github.com/ClangBuiltLinux/linux/issues/135
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
Acked-by: Ping-Ke Shih <pkshih@realtek.com>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../net/wireless/realtek/rtlwifi/btcoexist/halbtcoutsrc.c   | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtlwifi/btcoexist/halbtcoutsrc.c b/drivers/net/wireless/realtek/rtlwifi/btcoexist/halbtcoutsrc.c
index b026e80940a4d..6fbf8845a2ab6 100644
--- a/drivers/net/wireless/realtek/rtlwifi/btcoexist/halbtcoutsrc.c
+++ b/drivers/net/wireless/realtek/rtlwifi/btcoexist/halbtcoutsrc.c
@@ -1324,13 +1324,13 @@ bool exhalbtc_initlize_variables_wifi_only(struct rtl_priv *rtlpriv)
 
 	switch (rtlpriv->rtlhal.interface) {
 	case INTF_PCI:
-		wifionly_cfg->chip_interface = BTC_INTF_PCI;
+		wifionly_cfg->chip_interface = WIFIONLY_INTF_PCI;
 		break;
 	case INTF_USB:
-		wifionly_cfg->chip_interface = BTC_INTF_USB;
+		wifionly_cfg->chip_interface = WIFIONLY_INTF_USB;
 		break;
 	default:
-		wifionly_cfg->chip_interface = BTC_INTF_UNKNOWN;
+		wifionly_cfg->chip_interface = WIFIONLY_INTF_UNKNOWN;
 		break;
 	}
 
-- 
2.20.1



