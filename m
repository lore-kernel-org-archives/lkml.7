Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB9CBC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 16:12:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A79B2208E4
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 16:12:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732216AbfDXQMc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 12:12:32 -0400
Received: from gateway22.websitewelcome.com ([192.185.47.168]:46590 "EHLO
        gateway22.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730818AbfDXQMb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 12:12:31 -0400
Received: from cm11.websitewelcome.com (cm11.websitewelcome.com [100.42.49.5])
        by gateway22.websitewelcome.com (Postfix) with ESMTP id 8A40E228DE
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2019 11:08:55 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id JKS7hGEA3dnCeJKS7h1fAD; Wed, 24 Apr 2019 11:08:55 -0500
X-Authority-Reason: nr=8
Received: from [189.250.127.223] (port=39548 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1hJKS6-002xV7-Hb; Wed, 24 Apr 2019 11:08:54 -0500
Date:   Wed, 24 Apr 2019 11:08:24 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Tom Lendacky <thomas.lendacky@amd.com>,
        "David S. Miller" <davem@davemloft.net>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Kees Cook <keescook@chromium.org>
Subject: [PATCH net-next] amd-xgbe: Mark expected switch fall-throughs
Message-ID: <20190424160823.GA20314@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.250.127.223
X-Source-L: No
X-Exim-ID: 1hJKS6-002xV7-Hb
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.127.223]:39548
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 4
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to enabling -Wimplicit-fallthrough, mark switch
cases where we are expecting to fall through.

This patch fixes the following warnings:

In file included from drivers/net/ethernet/amd/xgbe/xgbe-drv.c:129:
drivers/net/ethernet/amd/xgbe/xgbe-drv.c: In function ‘xgbe_set_hwtstamp_settings’:
drivers/net/ethernet/amd/xgbe/xgbe-common.h:1392:9: warning: this statement may fall through [-Wimplicit-fallthrough=]
  (_var) |= (((_val) & ((0x1 << (_width)) - 1)) << (_index)); \
  ~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/amd/xgbe/xgbe-common.h:1419:2: note: in expansion of macro ‘SET_BITS’
  SET_BITS((_var),      \
  ^~~~~~~~
drivers/net/ethernet/amd/xgbe/xgbe-drv.c:1614:3: note: in expansion of macro ‘XGMAC_SET_BITS’
   XGMAC_SET_BITS(mac_tscr, MAC_TSCR, TSVER2ENA, 1);
   ^~~~~~~~~~~~~~
drivers/net/ethernet/amd/xgbe/xgbe-drv.c:1616:2: note: here
  case HWTSTAMP_FILTER_PTP_V1_L4_EVENT:
  ^~~~
In file included from drivers/net/ethernet/amd/xgbe/xgbe-drv.c:129:
drivers/net/ethernet/amd/xgbe/xgbe-common.h:1392:9: warning: this statement may fall through [-Wimplicit-fallthrough=]
  (_var) |= (((_val) & ((0x1 << (_width)) - 1)) << (_index)); \
  ~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/amd/xgbe/xgbe-common.h:1419:2: note: in expansion of macro ‘SET_BITS’
  SET_BITS((_var),      \
  ^~~~~~~~
drivers/net/ethernet/amd/xgbe/xgbe-drv.c:1625:3: note: in expansion of macro ‘XGMAC_SET_BITS’
   XGMAC_SET_BITS(mac_tscr, MAC_TSCR, TSVER2ENA, 1);
   ^~~~~~~~~~~~~~
drivers/net/ethernet/amd/xgbe/xgbe-drv.c:1627:2: note: here
  case HWTSTAMP_FILTER_PTP_V1_L4_SYNC:
  ^~~~
In file included from drivers/net/ethernet/amd/xgbe/xgbe-drv.c:129:
drivers/net/ethernet/amd/xgbe/xgbe-common.h:1392:9: warning: this statement may fall through [-Wimplicit-fallthrough=]
  (_var) |= (((_val) & ((0x1 << (_width)) - 1)) << (_index)); \
  ~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/amd/xgbe/xgbe-common.h:1419:2: note: in expansion of macro ‘SET_BITS’
  SET_BITS((_var),      \
  ^~~~~~~~
drivers/net/ethernet/amd/xgbe/xgbe-drv.c:1636:3: note: in expansion of macro ‘XGMAC_SET_BITS’
   XGMAC_SET_BITS(mac_tscr, MAC_TSCR, TSVER2ENA, 1);
   ^~~~~~~~~~~~~~
drivers/net/ethernet/amd/xgbe/xgbe-drv.c:1638:2: note: here
  case HWTSTAMP_FILTER_PTP_V1_L4_DELAY_REQ:
  ^~~~

Warning level 3 was used: -Wimplicit-fallthrough=3

Notice that, in this particular case, the code comments are modified
in accordance with what GCC is expecting to find.

This patch is part of the ongoing efforts to enable
-Wimplicit-fallthrough.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/net/ethernet/amd/xgbe/xgbe-drv.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-drv.c b/drivers/net/ethernet/amd/xgbe/xgbe-drv.c
index 0cc911f928b1..3dd0cecddba8 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe-drv.c
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-drv.c
@@ -1612,7 +1612,7 @@ static int xgbe_set_hwtstamp_settings(struct xgbe_prv_data *pdata,
 	/* PTP v2, UDP, any kind of event packet */
 	case HWTSTAMP_FILTER_PTP_V2_L4_EVENT:
 		XGMAC_SET_BITS(mac_tscr, MAC_TSCR, TSVER2ENA, 1);
-	/* PTP v1, UDP, any kind of event packet */
+		/* Fall through - to PTP v1, UDP, any kind of event packet */
 	case HWTSTAMP_FILTER_PTP_V1_L4_EVENT:
 		XGMAC_SET_BITS(mac_tscr, MAC_TSCR, TSIPV4ENA, 1);
 		XGMAC_SET_BITS(mac_tscr, MAC_TSCR, TSIPV6ENA, 1);
@@ -1623,7 +1623,7 @@ static int xgbe_set_hwtstamp_settings(struct xgbe_prv_data *pdata,
 	/* PTP v2, UDP, Sync packet */
 	case HWTSTAMP_FILTER_PTP_V2_L4_SYNC:
 		XGMAC_SET_BITS(mac_tscr, MAC_TSCR, TSVER2ENA, 1);
-	/* PTP v1, UDP, Sync packet */
+		/* Fall through - to PTP v1, UDP, Sync packet */
 	case HWTSTAMP_FILTER_PTP_V1_L4_SYNC:
 		XGMAC_SET_BITS(mac_tscr, MAC_TSCR, TSIPV4ENA, 1);
 		XGMAC_SET_BITS(mac_tscr, MAC_TSCR, TSIPV6ENA, 1);
@@ -1634,7 +1634,7 @@ static int xgbe_set_hwtstamp_settings(struct xgbe_prv_data *pdata,
 	/* PTP v2, UDP, Delay_req packet */
 	case HWTSTAMP_FILTER_PTP_V2_L4_DELAY_REQ:
 		XGMAC_SET_BITS(mac_tscr, MAC_TSCR, TSVER2ENA, 1);
-	/* PTP v1, UDP, Delay_req packet */
+		/* Fall through - to PTP v1, UDP, Delay_req packet */
 	case HWTSTAMP_FILTER_PTP_V1_L4_DELAY_REQ:
 		XGMAC_SET_BITS(mac_tscr, MAC_TSCR, TSIPV4ENA, 1);
 		XGMAC_SET_BITS(mac_tscr, MAC_TSCR, TSIPV6ENA, 1);
-- 
2.21.0

