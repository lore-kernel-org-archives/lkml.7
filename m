Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7F66C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 16:20:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EAD8208E4
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 16:20:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732041AbfDXQUz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 12:20:55 -0400
Received: from gateway33.websitewelcome.com ([192.185.146.210]:26389 "EHLO
        gateway33.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730945AbfDXQUy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 12:20:54 -0400
Received: from cm13.websitewelcome.com (cm13.websitewelcome.com [100.42.49.6])
        by gateway33.websitewelcome.com (Postfix) with ESMTP id BABA93336A0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2019 11:20:53 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id JKdhhDUPIYTGMJKdhhJYVL; Wed, 24 Apr 2019 11:20:53 -0500
X-Authority-Reason: nr=8
Received: from [189.250.127.223] (port=40004 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1hJKdg-0034tx-A0; Wed, 24 Apr 2019 11:20:53 -0500
Date:   Wed, 24 Apr 2019 11:20:16 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Inaky Perez-Gonzalez <inaky.perez-gonzalez@intel.com>,
        "linux-wimax@intel.com David S. Miller" <davem@davemloft.net>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Kees Cook <keescook@chromium.org>
Subject: [PATCH net-next] wimax/i2400m/control: Mark expected switch
 fall-through
Message-ID: <20190424162016.GA8393@embeddedor>
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
X-Exim-ID: 1hJKdg-0034tx-A0
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.127.223]:40004
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 9
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to enabling -Wimplicit-fallthrough, mark switch
cases where we are expecting to fall through.

This patch fixes the following warning:

In file included from drivers/net/wimax/i2400m/debug-levels.h:30,
                 from drivers/net/wimax/i2400m/control.c:86:
drivers/net/wimax/i2400m/control.c: In function ‘i2400m_report_tlv_system_state’:
./include/linux/wimax/debug.h:200:4: warning: this statement may fall through [-Wimplicit-fallthrough=]
 do {         \
    ^
./include/linux/wimax/debug.h:404:36: note: in expansion of macro ‘_d_printf’
 #define d_printf(l, _dev, f, a...) _d_printf(l, "", _dev, f, ## a)
                                    ^~~~~~~~~
drivers/net/wimax/i2400m/control.c:354:3: note: in expansion of macro ‘d_printf’
   d_printf(1, dev, "entering BS-negotiated idle mode\n");
   ^~~~~~~~
drivers/net/wimax/i2400m/control.c:355:2: note: here
  case I2400M_SS_DISCONNECTING:
  ^~~~

Warning level 3 was used: -Wimplicit-fallthrough=3

This patch is part of the ongoing efforts to enable
-Wimplicit-fallthrough.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/net/wimax/i2400m/control.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wimax/i2400m/control.c b/drivers/net/wimax/i2400m/control.c
index ef298d8525c5..4fe7c7e132c4 100644
--- a/drivers/net/wimax/i2400m/control.c
+++ b/drivers/net/wimax/i2400m/control.c
@@ -352,6 +352,7 @@ void i2400m_report_tlv_system_state(struct i2400m *i2400m,
 
 	case I2400M_SS_IDLE:
 		d_printf(1, dev, "entering BS-negotiated idle mode\n");
+		/* Fall through */
 	case I2400M_SS_DISCONNECTING:
 	case I2400M_SS_DATA_PATH_CONNECTED:
 		wimax_state_change(wimax_dev, WIMAX_ST_CONNECTED);
-- 
2.21.0

