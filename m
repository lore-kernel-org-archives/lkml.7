Return-Path: <SRS0=0OOB=TB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54277C43219
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 21:33:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 259FE20675
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 21:33:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726207AbfEAVdc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 May 2019 17:33:32 -0400
Received: from gateway33.websitewelcome.com ([192.185.145.216]:19284 "EHLO
        gateway33.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726088AbfEAVdb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 May 2019 17:33:31 -0400
Received: from cm13.websitewelcome.com (cm13.websitewelcome.com [100.42.49.6])
        by gateway33.websitewelcome.com (Postfix) with ESMTP id C7D7241906
        for <linux-kernel@vger.kernel.org>; Wed,  1 May 2019 16:33:30 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id Lwr4hoy4zYTGMLwr4hteTi; Wed, 01 May 2019 16:33:30 -0500
X-Authority-Reason: nr=8
Received: from [189.250.119.203] (port=56366 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1hLwr3-004Of0-QI; Wed, 01 May 2019 16:33:29 -0500
Date:   Wed, 1 May 2019 16:33:29 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Kees Cook <keescook@chromium.org>
Subject: [PATCH v2] USB: serial: io_edgeport: mark expected switch
 fall-throughs
Message-ID: <20190501213329.GA26972@embeddedor>
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
X-Exim-ID: 1hLwr3-004Of0-QI
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.119.203]:56366
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

This patch fixes the following warnings:

drivers/usb/serial/io_edgeport.c: In function ‘process_rcvd_data’:
drivers/usb/serial/io_edgeport.c:1750:7: warning: this statement may fall through [-Wimplicit-fallthrough=]
    if (bufferLength == 0) {
       ^
drivers/usb/serial/io_edgeport.c:1755:3: note: here
   case EXPECT_HDR2:
   ^~~~
drivers/usb/serial/io_edgeport.c:1810:8: warning: this statement may fall through [-Wimplicit-fallthrough=]
     if (bufferLength == 0) {
        ^
drivers/usb/serial/io_edgeport.c:1816:3: note: here
   case EXPECT_DATA: /* Expect data */
   ^~~~

Warning level 3 was used: -Wimplicit-fallthrough=3

Notice that, in this particular case, the code comments are modified
in accordance with what GCC is expecting to find.

This patch is part of the ongoing efforts to enable
-Wimplicit-fallthrough.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
Changes in v2:
 - Warning level 3 is now used: -Wimplicit-fallthrough=3
   instead of warning level 2.
 - All warnings in the switch statement are addressed now.

Notice that these are the last remaining fall-through warnings
in the USB subsystem. :)

Thanks
--
Gustavo

 drivers/usb/serial/io_edgeport.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/serial/io_edgeport.c b/drivers/usb/serial/io_edgeport.c
index 4ca31c0e4174..7ad10328f4e2 100644
--- a/drivers/usb/serial/io_edgeport.c
+++ b/drivers/usb/serial/io_edgeport.c
@@ -1751,7 +1751,7 @@ static void process_rcvd_data(struct edgeport_serial *edge_serial,
 				edge_serial->rxState = EXPECT_HDR2;
 				break;
 			}
-			/* otherwise, drop on through */
+			/* Fall through - otherwise, drop on through */
 		case EXPECT_HDR2:
 			edge_serial->rxHeader2 = *buffer;
 			++buffer;
@@ -1813,6 +1813,7 @@ static void process_rcvd_data(struct edgeport_serial *edge_serial,
 				}
 				/* Else, drop through */
 			}
+			/* Fall through */
 		case EXPECT_DATA: /* Expect data */
 			if (bufferLength < edge_serial->rxBytesRemaining) {
 				rxLen = bufferLength;
-- 
2.21.0

