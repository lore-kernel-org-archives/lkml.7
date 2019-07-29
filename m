Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3A85C76186
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 22:45:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDCE1206E0
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 22:45:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="pXoEJNpy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728425AbfG2WpW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 18:45:22 -0400
Received: from gateway20.websitewelcome.com ([192.185.64.36]:28800 "EHLO
        gateway20.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726557AbfG2WpW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 18:45:22 -0400
Received: from cm17.websitewelcome.com (cm17.websitewelcome.com [100.42.49.20])
        by gateway20.websitewelcome.com (Postfix) with ESMTP id 80237400C7334
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2019 16:41:52 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id sEOPh0D2990onsEOPhrmPa; Mon, 29 Jul 2019 17:45:21 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=zaDytdFiyu2qWXH/FTLAoV3j6tXv4LBM8gG34JeGLb0=; b=pXoEJNpyHl3pbgqf6vpRJ0GNNF
        elsgvlGEc32g8YonBvOeGZMhZ+RY8uCfVxzmc5BZwKm1FlBV9Q4D3jjNVCnEWu+/gU6ev6LYVhROk
        y8eAU7ZuJVU2+KBRY5KzP7iriTCr5UMIgs69+mPsgdy37zm+tc6Sulkj+e0zXoRNIUl5t0tAJDZzL
        ElAtEItTw3tyvm+ZekK7IriSDYVjmx/pxPBBb8uTs7IsfWNu7xkLbsiyevK8GQzQ4+fuZTTGxR6Ys
        BAJoWkXw+B3FLSlx8QFi202Iy29Z6v1744dxCeB6wNJ7ydtLaNyOjPBf8WvFFh4JBahXOBZZJCr6h
        SUW3GyVw==;
Received: from [187.192.11.120] (port=60892 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.92)
        (envelope-from <gustavo@embeddedor.com>)
        id 1hsEOO-002DfF-FW; Mon, 29 Jul 2019 17:45:20 -0500
Date:   Mon, 29 Jul 2019 17:45:19 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Kees Cook <keescook@chromium.org>
Subject: [PATCH] HSI: ssi_protocol: Mark expected switch fall-throughs
Message-ID: <20190729224519.GA23078@embeddedor>
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
X-Source-IP: 187.192.11.120
X-Source-L: No
X-Exim-ID: 1hsEOO-002DfF-FW
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [187.192.11.120]:60892
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 38
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mark switch cases where we are expecting to fall through.

This patch fixes the following warning (Building: arm):

drivers/hsi/clients/ssi_protocol.c: In function ‘ssip_set_rxstate’:
drivers/hsi/clients/ssi_protocol.c:291:6: warning: this statement may fall through [-Wimplicit-fallthrough=]
   if (atomic_read(&ssi->tx_usecnt))
      ^
drivers/hsi/clients/ssi_protocol.c:294:2: note: here
  case RECEIVING:
  ^~~~

drivers/hsi/clients/ssi_protocol.c: In function ‘ssip_keep_alive’:
drivers/hsi/clients/ssi_protocol.c:466:7: warning: this statement may fall through [-Wimplicit-fallthrough=]
    if (atomic_read(&ssi->tx_usecnt) == 0)
       ^
drivers/hsi/clients/ssi_protocol.c:472:3: note: here
   case SEND_IDLE:
   ^~~~

Notice that, in this particular case, the code comment is
modified in accordance with what GCC is expecting to find.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/hsi/clients/ssi_protocol.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/hsi/clients/ssi_protocol.c b/drivers/hsi/clients/ssi_protocol.c
index 9aeed98b87a1..504d00ec1ea7 100644
--- a/drivers/hsi/clients/ssi_protocol.c
+++ b/drivers/hsi/clients/ssi_protocol.c
@@ -290,7 +290,7 @@ static void ssip_set_rxstate(struct ssi_protocol *ssi, unsigned int state)
 		/* CMT speech workaround */
 		if (atomic_read(&ssi->tx_usecnt))
 			break;
-		/* Otherwise fall through */
+		/* Else, fall through */
 	case RECEIVING:
 		mod_timer(&ssi->keep_alive, jiffies +
 						msecs_to_jiffies(SSIP_KATOUT));
@@ -465,9 +465,10 @@ static void ssip_keep_alive(struct timer_list *t)
 		case SEND_READY:
 			if (atomic_read(&ssi->tx_usecnt) == 0)
 				break;
+			/* Fall through */
 			/*
-			 * Fall through. Workaround for cmt-speech
-			 * in that case we relay on audio timers.
+			 * Workaround for cmt-speech in that case
+			 * we relay on audio timers.
 			 */
 		case SEND_IDLE:
 			spin_unlock(&ssi->lock);
-- 
2.22.0

