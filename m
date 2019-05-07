Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ACB0C004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 18:24:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1000B20675
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 18:24:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726963AbfEGSYN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 14:24:13 -0400
Received: from gateway33.websitewelcome.com ([192.185.145.190]:39615 "EHLO
        gateway33.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726564AbfEGSYN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 14:24:13 -0400
Received: from cm16.websitewelcome.com (cm16.websitewelcome.com [100.42.49.19])
        by gateway33.websitewelcome.com (Postfix) with ESMTP id 6474F8EE16
        for <linux-kernel@vger.kernel.org>; Tue,  7 May 2019 13:24:12 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id O4lAhB03K4FKpO4lAhaKPy; Tue, 07 May 2019 13:24:12 -0500
X-Authority-Reason: nr=8
Received: from [189.250.119.7] (port=44628 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1hO4l9-000Qgk-Ct; Tue, 07 May 2019 13:24:11 -0500
Date:   Tue, 7 May 2019 13:24:09 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Kees Cook <keescook@chromium.org>
Subject: [PATCH] Input: libps2 - mark expected switch fall-through
Message-ID: <20190507182409.GA11027@embeddedor>
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
X-Source-IP: 189.250.119.7
X-Source-L: No
X-Exim-ID: 1hO4l9-000Qgk-Ct
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.119.7]:44628
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 3
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to enabling -Wimplicit-fallthrough, mark switch
cases where we are expecting to fall through.

This patch fixes the following warning:

drivers/input/serio/libps2.c: In function ‘ps2_handle_ack’:
drivers/input/serio/libps2.c:407:6: warning: this statement may fall through [-Wimplicit-fallthrough=]
   if (ps2dev->flags & PS2_FLAG_NAK) {
      ^
drivers/input/serio/libps2.c:417:2: note: here
  case 0x00:
  ^~~~

Warning level 3 was used: -Wimplicit-fallthrough=3

This patch is part of the ongoing efforts to enable
-Wimplicit-fallthrough.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/input/serio/libps2.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/input/serio/libps2.c b/drivers/input/serio/libps2.c
index e6a07e68d1ff..22b8e05aa36c 100644
--- a/drivers/input/serio/libps2.c
+++ b/drivers/input/serio/libps2.c
@@ -409,6 +409,7 @@ bool ps2_handle_ack(struct ps2dev *ps2dev, u8 data)
 			ps2dev->nak = PS2_RET_ERR;
 			break;
 		}
+		/* Fall through */
 
 	/*
 	 * Workaround for mice which don't ACK the Get ID command.
-- 
2.21.0

