Return-Path: <SRS0=Ymnc=YU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA0D1CA9EBD
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Oct 2019 21:03:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3DF92064A
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Oct 2019 21:03:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572210198;
	bh=99Y5+JPsjc5OFuA/1Rpq9820qIfZaSVHVwyJSPxXNgA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=et5oyomP0vr1la4QEfliInu0Cn8Fy47jJ/XRqvPwN/re8G4NSE9YfBg0hKWIcnrfn
	 kLL/DQR7gWjPwVHEA0tVWojwfxbDkzenCsIzvUV+k/07d2gPNI7GdcTBDOGRiad12p
	 Xy2VW0ctKKA4TPYvKEJSACENKWFFrpBkCrVcef2Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728278AbfJ0VDR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Oct 2019 17:03:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:48352 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728216AbfJ0VDI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Oct 2019 17:03:08 -0400
Received: from localhost (100.50.158.77.rev.sfr.net [77.158.50.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1F4EE20873;
        Sun, 27 Oct 2019 21:03:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572210187;
        bh=99Y5+JPsjc5OFuA/1Rpq9820qIfZaSVHVwyJSPxXNgA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Jv1AEcHUvGMdI1BKAYEtW+4MtaHmf5XrI1+uKJcQuv+sd6KjKJnDbXtHJ2XKMYSvO
         xmJYdU9doaFE4MXamOWDNWchC8qMHJpA+uVujPvbiMUCZqrbM6J3wdwLZ/4bz/Dhjb
         cqNEhdUrTSihRb6LzrXMC168UbvX3SBT8r2EJmi8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH 4.4 20/41] usb: udc: lpc32xx: fix bad bit shift operation
Date:   Sun, 27 Oct 2019 22:00:58 +0100
Message-Id: <20191027203116.981208973@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191027203056.220821342@linuxfoundation.org>
References: <20191027203056.220821342@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gustavo A. R. Silva <gustavo@embeddedor.com>

commit b987b66ac3a2bc2f7b03a0ba48a07dc553100c07 upstream.

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
Link: https://lore.kernel.org/r/20191014191830.GA10721@embeddedor
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/gadget/udc/lpc32xx_udc.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/drivers/usb/gadget/udc/lpc32xx_udc.c
+++ b/drivers/usb/gadget/udc/lpc32xx_udc.c
@@ -1225,11 +1225,11 @@ static void udc_pop_fifo(struct lpc32xx_
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
 


