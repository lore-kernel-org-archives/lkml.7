Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8F4BC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 14:51:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93C5620850
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 14:51:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727550AbfCROvG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 10:51:06 -0400
Received: from gateway31.websitewelcome.com ([192.185.143.43]:34011 "EHLO
        gateway31.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726701AbfCROvG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 10:51:06 -0400
Received: from cm13.websitewelcome.com (cm13.websitewelcome.com [100.42.49.6])
        by gateway31.websitewelcome.com (Postfix) with ESMTP id D8EBE444EF
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2019 09:51:04 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id 5tbUhXQuNYTGM5tbUhkfKe; Mon, 18 Mar 2019 09:51:04 -0500
X-Authority-Reason: nr=8
Received: from [189.250.104.39] (port=37488 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1h5tas-0049al-Id; Mon, 18 Mar 2019 09:51:03 -0500
Date:   Mon, 18 Mar 2019 09:50:24 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Richard Leitner <richard.leitner@skidata.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Marco Felsch <m.felsch@pengutronix.de>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] usb: usb251xb: Remove unnecessary comparison of unsigned
 integer with >= 0
Message-ID: <20190318145024.GA572@embeddedor>
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
X-Source-IP: 189.250.104.39
X-Source-L: No
X-Exim-ID: 1h5tas-0049al-Id
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.104.39]:37488
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 5
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no need to compare *port* with >= 0 because such comparison
of an unsigned value is always true.

Fix this by removing such comparison.

Addresses-Coverity-ID: 1443949 ("Unsigned compared against 0")
Fixes: 02a50b875046 ("usb: usb251xb: add usb data lane port swap feature")
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/usb/misc/usb251xb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/misc/usb251xb.c b/drivers/usb/misc/usb251xb.c
index 4d72b7d1d383..2c8e2cad7e10 100644
--- a/drivers/usb/misc/usb251xb.c
+++ b/drivers/usb/misc/usb251xb.c
@@ -547,7 +547,7 @@ static int usb251xb_get_ofdata(struct usb251xb *hub,
 	 */
 	hub->port_swap = USB251XB_DEF_PORT_SWAP;
 	of_property_for_each_u32(np, "swap-dx-lanes", prop, p, port) {
-		if ((port >= 0) && (port <= data->port_cnt))
+		if (port <= data->port_cnt)
 			hub->port_swap |= BIT(port);
 	}
 
-- 
2.21.0

