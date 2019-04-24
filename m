Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D8F8C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 16:27:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34DF3218B0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 16:27:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732396AbfDXQ1x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 12:27:53 -0400
Received: from gateway33.websitewelcome.com ([192.185.146.210]:26888 "EHLO
        gateway33.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731034AbfDXQ1u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 12:27:50 -0400
Received: from cm12.websitewelcome.com (cm12.websitewelcome.com [100.42.49.8])
        by gateway33.websitewelcome.com (Postfix) with ESMTP id 7E5C71B057
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2019 11:27:48 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id JKkOhTVPQiQerJKkOhAXVx; Wed, 24 Apr 2019 11:27:48 -0500
X-Authority-Reason: nr=8
Received: from [189.250.127.223] (port=40096 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1hJKkM-00394d-Qi; Wed, 24 Apr 2019 11:27:48 -0500
Date:   Wed, 24 Apr 2019 11:27:42 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Casey Leedom <leedom@chelsio.com>,
        "David S. Miller" <davem@davemloft.net>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Kees Cook <keescook@chromium.org>
Subject: [PATCH net-next] cxgb4/cxgb4vf_main: Mark expected switch
 fall-through
Message-ID: <20190424162742.GA10085@embeddedor>
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
X-Exim-ID: 1hJKkM-00394d-Qi
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.127.223]:40096
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 14
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to enabling -Wimplicit-fallthrough, mark switch
cases where we are expecting to fall through.

This patch fixes the following warning:

drivers/net/ethernet/chelsio/cxgb4vf/cxgb4vf_main.c: In function ‘fwevtq_handler’:
drivers/net/ethernet/chelsio/cxgb4vf/cxgb4vf_main.c:520:7: warning: this statement may fall through [-Wimplicit-fallthrough=]
   cpl = (void *)p;
   ~~~~^~~~~~~~~~~
drivers/net/ethernet/chelsio/cxgb4vf/cxgb4vf_main.c:524:2: note: here
  case CPL_SGE_EGR_UPDATE: {
  ^~~~

Warning level 3 was used: -Wimplicit-fallthrough=3

Notice that, in this particular case, the code comment is modified
in accordance with what GCC is expecting to find.

This patch is part of the ongoing efforts to enable
-Wimplicit-fallthrough.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/net/ethernet/chelsio/cxgb4vf/cxgb4vf_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/chelsio/cxgb4vf/cxgb4vf_main.c b/drivers/net/ethernet/chelsio/cxgb4vf/cxgb4vf_main.c
index a8c4e0c851e7..6d4cf3d0b2f0 100644
--- a/drivers/net/ethernet/chelsio/cxgb4vf/cxgb4vf_main.c
+++ b/drivers/net/ethernet/chelsio/cxgb4vf/cxgb4vf_main.c
@@ -518,8 +518,8 @@ static int fwevtq_handler(struct sge_rspq *rspq, const __be64 *rsp,
 			break;
 		}
 		cpl = (void *)p;
-		/*FALLTHROUGH*/
 	}
+		/* Fall through */
 
 	case CPL_SGE_EGR_UPDATE: {
 		/*
-- 
2.21.0

