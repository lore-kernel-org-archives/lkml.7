Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26CF8C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 16:04:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F026A2077B
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 16:04:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727436AbfCTQEe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 12:04:34 -0400
Received: from gateway32.websitewelcome.com ([192.185.145.119]:30151 "EHLO
        gateway32.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726403AbfCTQEd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 12:04:33 -0400
Received: from cm11.websitewelcome.com (cm11.websitewelcome.com [100.42.49.5])
        by gateway32.websitewelcome.com (Postfix) with ESMTP id 2CEFCB7A1C
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2019 11:04:33 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id 6dhhhOIexdnCe6dhhhGNKc; Wed, 20 Mar 2019 11:04:33 -0500
X-Authority-Reason: nr=8
Received: from [189.250.104.39] (port=52026 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1h6dgV-001L1l-3E; Wed, 20 Mar 2019 11:04:32 -0500
Date:   Wed, 20 Mar 2019 11:03:18 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Cliff Whickman <cpw@sgi.com>, Robin Holt <robinmholt@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Kees Cook <keescook@chromium.org>
Subject: [PATCH] sgi-xpc: mark expected switch fall-through
Message-ID: <20190320160318.GA20599@embeddedor>
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
X-Source-IP: 189.250.104.39
X-Source-L: No
X-Exim-ID: 1h6dgV-001L1l-3E
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.104.39]:52026
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 5
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to enabling -Wimplicit-fallthrough, mark switch
cases where we are expecting to fall through.

This patch fixes the following warning:

drivers/misc/sgi-xp/xpc_uv.c: In function ‘xpc_handle_activate_mq_msg_uv’:
drivers/misc/sgi-xp/xpc_uv.c:573:3: warning: this statement may fall through [-Wimplicit-fallthrough=]
   xpc_wakeup_channel_mgr(part);
   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/misc/sgi-xp/xpc_uv.c:575:2: note: here
  case XPC_ACTIVATE_MQ_MSG_MARK_ENGAGED_UV:
  ^~~~

Warning level 3 was used: -Wimplicit-fallthrough=3

This patch is part of the ongoing efforts to enable
-Wimplicit-fallthrough.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/misc/sgi-xp/xpc_uv.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/misc/sgi-xp/xpc_uv.c b/drivers/misc/sgi-xp/xpc_uv.c
index 9e443df44b3b..0c6de97dd347 100644
--- a/drivers/misc/sgi-xp/xpc_uv.c
+++ b/drivers/misc/sgi-xp/xpc_uv.c
@@ -572,6 +572,7 @@ xpc_handle_activate_mq_msg_uv(struct xpc_partition *part,
 
 		xpc_wakeup_channel_mgr(part);
 	}
+		/* fall through */
 	case XPC_ACTIVATE_MQ_MSG_MARK_ENGAGED_UV:
 		spin_lock_irqsave(&part_uv->flags_lock, irq_flags);
 		part_uv->flags |= XPC_P_ENGAGED_UV;
-- 
2.21.0

