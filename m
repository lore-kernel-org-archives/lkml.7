Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E7EAC4CECE
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 19:41:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2D1E2089C
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 19:41:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="T+ZcWALc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388928AbfJNTln (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 15:41:43 -0400
Received: from gateway34.websitewelcome.com ([192.185.149.46]:37074 "EHLO
        gateway34.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730254AbfJNTln (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 15:41:43 -0400
X-Greylist: delayed 1367 seconds by postgrey-1.27 at vger.kernel.org; Mon, 14 Oct 2019 15:41:41 EDT
Received: from cm13.websitewelcome.com (cm13.websitewelcome.com [100.42.49.6])
        by gateway34.websitewelcome.com (Postfix) with ESMTP id F2DD111EDDA4
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2019 14:18:52 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id K5roiAb0q3Qi0K5roigJxJ; Mon, 14 Oct 2019 14:18:52 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Type:MIME-Version:Message-ID:Subject:
        Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Z6hy7j2bf2J0P83dPxoUJpQb5DqOP18QhotJKCAr1Fk=; b=T+ZcWALctqO2RNH+PdtNf3wdXf
        xxQgqYhkamefp5TT7wBcrfhixu+fVcq+nWT3UGYiz9SXenkq8HXJdIbENEk7rb3aO6vbUhf3FQEUD
        3lho4t1+FKXgfExwK3Sa8WOLN+lHYRy9JW0rusqrsypXCnDr85+YlMQrgLPSZGeQm7dglGByDvSwu
        CNie5O6UWiNqGYUQdItd/UAgmCW+jxofPvvcoR4FrCDdxS7qdIQw3WMHzBJiSBxvppEe05VZXqGeI
        hVkmz3Y0QhmmNNG7XVU9Tl5siVzjJQ65elzEAg+anzaXbUjns60laMlVoq9zvajdpAZF092P8/yWp
        xk7s8JqQ==;
Received: from [187.192.22.73] (port=54766 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.92)
        (envelope-from <gustavo@embeddedor.com>)
        id 1iK5rm-000wQV-S6; Mon, 14 Oct 2019 14:18:51 -0500
Date:   Mon, 14 Oct 2019 14:18:30 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Sylvain Lemieux <slemieux.tyco@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, Roland Stigge <stigge@antcom.de>
Cc:     linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] usb: udc: lpc32xx: fix bad bit shift operation
Message-ID: <20191014191830.GA10721@embeddedor>
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
X-Source-IP: 187.192.22.73
X-Source-L: No
X-Exim-ID: 1iK5rm-000wQV-S6
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [187.192.22.73]:54766
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 9
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It seems that the right variable to use in this case is *i*, instead of
*n*, otherwise there is an undefined behavior when right shifiting by more
than 31 bits when multiplying n by 8; notice that *n* can take values
equal or greater than 4 (4, 8, 16, ...).

Also, notice that under the current conditions (bl = 3), we are skiping
the handling of bytes 3, 7, 31... So, fix this by updating this logic
and limit *bl* up to 4 instead of up to 3.

This fix is based on function udc_stuff_fifo().

Addresses-Coverity-ID: 1454834 ("Bad bit shift operation")
Fixes: 24a28e428351 ("USB: gadget driver for LPC32xx")
Cc: stable@vger.kernel.org
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/usb/gadget/udc/lpc32xx_udc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/gadget/udc/lpc32xx_udc.c b/drivers/usb/gadget/udc/lpc32xx_udc.c
index 2b1f3cc7819b..bf6c81e2f8cc 100644
--- a/drivers/usb/gadget/udc/lpc32xx_udc.c
+++ b/drivers/usb/gadget/udc/lpc32xx_udc.c
@@ -1177,11 +1177,11 @@ static void udc_pop_fifo(struct lpc32xx_udc *udc, u8 *data, u32 bytes)
 			tmp = readl(USBD_RXDATA(udc->udp_baseaddr));
 
 			bl = bytes - n;
-			if (bl > 3)
-				bl = 3;
+			if (bl > 4)
+				bl = 4;
 
 			for (i = 0; i < bl; i++)
-				data[n + i] = (u8) ((tmp >> (n * 8)) & 0xFF);
+				data[n + i] = (u8) ((tmp >> (i * 8)) & 0xFF);
 		}
 		break;
 
-- 
2.23.0

