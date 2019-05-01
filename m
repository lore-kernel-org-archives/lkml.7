Return-Path: <SRS0=0OOB=TB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 731E7C43219
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 15:39:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C3BD21670
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 15:39:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726985AbfEAPji (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 May 2019 11:39:38 -0400
Received: from gateway31.websitewelcome.com ([192.185.143.51]:19723 "EHLO
        gateway31.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726345AbfEAPji (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 May 2019 11:39:38 -0400
Received: from cm17.websitewelcome.com (cm17.websitewelcome.com [100.42.49.20])
        by gateway31.websitewelcome.com (Postfix) with ESMTP id 66C7F1D81B
        for <linux-kernel@vger.kernel.org>; Wed,  1 May 2019 10:39:37 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id LrKbhTgYT90onLrKbhc3Me; Wed, 01 May 2019 10:39:37 -0500
X-Authority-Reason: nr=8
Received: from [189.250.119.203] (port=32788 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1hLrKa-001Vu7-Gn; Wed, 01 May 2019 10:39:36 -0500
Date:   Wed, 1 May 2019 10:39:34 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arvid Brodin <arvid.brodin@enea.com>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] usb: isp1760-hcd: Fix fall-through annotations
Message-ID: <20190501153934.GA20025@embeddedor>
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
X-Source-IP: 189.250.119.203
X-Source-L: No
X-Exim-ID: 1hLrKa-001Vu7-Gn
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.119.203]:32788
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 11
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to enabling -Wimplicit-fallthrough, mark switch
cases where we are expecting to fall through.

This patch fixes the following warning:

drivers/usb/isp1760/isp1760-hcd.c: In function ‘collect_qtds’:
drivers/usb/isp1760/isp1760-hcd.c:788:6: warning: this statement may fall through [-Wimplicit-fallthrough=]
      mem_reads8(hcd->regs, qtd->payload_addr,
      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
        qtd->data_buffer,
        ~~~~~~~~~~~~~~~~~
        qtd->actual_length);
        ~~~~~~~~~~~~~~~~~~~
drivers/usb/isp1760/isp1760-hcd.c:792:5: note: here
     case OUT_PID:
     ^~~~

Warning level 3 was used: -Wimplicit-fallthrough=3

Notice that, in this particular case, the code comments are modified
in accordance with what GCC is expecting to find.

This patch is part of the ongoing efforts to enable
-Wimplicit-fallthrough.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
Notice that this code has been out there since 2011, and who
introduced the question mark was the original developer.

It'd be good if someone can confirm that the fall-through
has been intentional all this time.
	
Thanks
--
Gustavo

 drivers/usb/isp1760/isp1760-hcd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/isp1760/isp1760-hcd.c b/drivers/usb/isp1760/isp1760-hcd.c
index 8142c6b4c4cf..320fc4739835 100644
--- a/drivers/usb/isp1760/isp1760-hcd.c
+++ b/drivers/usb/isp1760/isp1760-hcd.c
@@ -788,11 +788,11 @@ static void collect_qtds(struct usb_hcd *hcd, struct isp1760_qh *qh,
 					mem_reads8(hcd->regs, qtd->payload_addr,
 							qtd->data_buffer,
 							qtd->actual_length);
-					/* Fall through (?) */
+					/* Fall through */
 				case OUT_PID:
 					qtd->urb->actual_length +=
 							qtd->actual_length;
-					/* Fall through ... */
+					/* Fall through */
 				case SETUP_PID:
 					break;
 				}
-- 
2.21.0

