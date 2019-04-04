Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D0C6C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:36:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9CF9205F4
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:36:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554370590;
	bh=Q2h3aC1LFV/OMNug+ftgeLvbBsBaCBSDPMKm3wseYm4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=UYzNOc0bZ1VdudKMbfKvvAgKfHCVcRc5wX1W8ONPiXXUJm5zg7qTwidK+FG7doY53
	 7LhP+QaEIJNXvGkBbhyR5Ih2nvboQ17ZDo3luu7IPt7hpb5iU91mMgom/80AuxX1d3
	 xQa0yLuDhrlxnb9OtfcnlBeSB87e2zzKzPNi/4Xs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732191AbfDDJFo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 05:05:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:43840 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731960AbfDDJFk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 05:05:40 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DEAA121855;
        Thu,  4 Apr 2019 09:05:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554368739;
        bh=Q2h3aC1LFV/OMNug+ftgeLvbBsBaCBSDPMKm3wseYm4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LRehPuGmVntDiHHyJqyejcLLIPYX8jyhay/5YXTVNsXvXDQrf/2jrH+wrWGWpAzv5
         /OqLzC8t7wxiwykJxuogFRZ19eNjCHa5GyaUDx1PM8QfUHtlVZsyFTm/fvRp8joj8u
         Iyb31wJjnF4kS1tkO4tKW3DE9+Zh2vO01FejENjA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Roger Quadros <rogerq@ti.com>,
        Sekhar Nori <nsekhar@ti.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 152/187] usb: dwc3: gadget: Fix OTG events when gadget driver isnt loaded
Date:   Thu,  4 Apr 2019 10:48:09 +0200
Message-Id: <20190404084610.283046710@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190404084603.119654039@linuxfoundation.org>
References: <20190404084603.119654039@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 169e3b68cadb5775daca009ced4faf01ffd97dcf ]

On v3.10a in dual-role mode, if port is in device mode
and gadget driver isn't loaded, the OTG event interrupts don't
come through.

It seems that if the core is configured to be OTG2.0 only,
then we can't leave the DCFG.DEVSPD at Super-speed (default)
if we expect OTG to work properly. It must be set to High-speed.

Fix this issue by configuring DCFG.DEVSPD to the supported
maximum speed at gadget init. Device tree still needs to provide
correct supported maximum speed for this to work.

This issue wasn't present on v2.40a but is seen on v3.10a.
It doesn't cause any side effects on v2.40a.

Signed-off-by: Roger Quadros <rogerq@ti.com>
Signed-off-by: Sekhar Nori <nsekhar@ti.com>
Signed-off-by: Felipe Balbi <felipe.balbi@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/dwc3/gadget.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 700fb626ad03..524104eed8a7 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -3233,6 +3233,8 @@ int dwc3_gadget_init(struct dwc3 *dwc)
 		goto err4;
 	}
 
+	dwc3_gadget_set_speed(&dwc->gadget, dwc->maximum_speed);
+
 	return 0;
 
 err4:
-- 
2.19.1



