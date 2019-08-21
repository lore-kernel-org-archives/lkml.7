Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E853C3A589
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 02:37:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04A7522D6D
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 02:37:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="bolcoLQX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726944AbfHUChB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 22:37:01 -0400
Received: from gateway30.websitewelcome.com ([192.185.151.58]:24274 "EHLO
        gateway30.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726193AbfHUChA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 22:37:00 -0400
X-Greylist: delayed 1229 seconds by postgrey-1.27 at vger.kernel.org; Tue, 20 Aug 2019 22:37:00 EDT
Received: from cm16.websitewelcome.com (cm16.websitewelcome.com [100.42.49.19])
        by gateway30.websitewelcome.com (Postfix) with ESMTP id EDD8C5211
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2019 21:16:30 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id 0GAoiclmv4FKp0GAoiiPd8; Tue, 20 Aug 2019 21:16:30 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Type:MIME-Version:Message-ID:Subject:
        Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=0+iQb8olkCCmveYCwGlywQYawyBRRIxSwndogIaqQ6w=; b=bolcoLQXm633fxCXN8Eio23eEC
        vMRn+bUr57rvQjBO+vW+4MDADvf6Vtbs0oJsayU6/GKalI+UthEDpUA6+3YDs2//IOIJqFXtP0Nex
        MzWHCtKAzAv6vypR8dw1ivprC3VY3MsTARtSBeLCPJPYjQwgUSXISEGXmhzZpulvDBVGrKKXGC/aH
        S/qcBA7iWs1hsDssQN7QwXHedaFlIGAJ0muKOv59tE3yucp06E5bKmwnu9YPluMpNAGexzuHvTCGW
        3y4WTwrk8gTmXLloBIZrJ3RdVg+Kd0dOLZX1vVByjCDUt/VMejgKcqoE5WLQaRd52HzzXYg5XGVaf
        3Tmgr3/A==;
Received: from [187.192.11.120] (port=52370 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.92)
        (envelope-from <gustavo@embeddedor.com>)
        id 1i0GAn-001KA5-4q; Tue, 20 Aug 2019 21:16:29 -0500
Date:   Tue, 20 Aug 2019 21:16:27 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Sylvain Lemieux <slemieux.tyco@gmail.com>
Cc:     linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] usb: udc: lpc32xx: silence fall-through warning
Message-ID: <20190821021627.GA2679@embeddedor>
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
X-Source-IP: 187.192.11.120
X-Source-L: No
X-Exim-ID: 1i0GAn-001KA5-4q
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [187.192.11.120]:52370
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 7
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Silence the following fall-through warning by adding a break statement:

drivers/usb/gadget/udc/lpc32xx_udc.c:2230:3: warning: this statement may
fall through [-Wimplicit-fallthrough=]

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/usb/gadget/udc/lpc32xx_udc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/udc/lpc32xx_udc.c b/drivers/usb/gadget/udc/lpc32xx_udc.c
index e3f67023d935..606c8bc52db5 100644
--- a/drivers/usb/gadget/udc/lpc32xx_udc.c
+++ b/drivers/usb/gadget/udc/lpc32xx_udc.c
@@ -2264,7 +2264,7 @@ static void udc_handle_ep0_setup(struct lpc32xx_udc *udc)
 		default:
 			break;
 		}
-
+		break;
 
 	case USB_REQ_SET_ADDRESS:
 		if (reqtype == (USB_TYPE_STANDARD | USB_RECIP_DEVICE)) {
-- 
2.23.0

