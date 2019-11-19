Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80725C432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 05:28:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 536F7208C3
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 05:28:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574141326;
	bh=uRxI4VmbW20DT+z3xkOGVS9S5XwYCJbyurnaAxCjgwo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ceVH0YvtZcJrm4xa2v/cwG5bIpFm2u8eDAHjkqACDnBgZsNbBDWOpFHpMM6HKEYJu
	 /KnGTKPOgWNuVa/1AEoO/fsw0GufG4sQzFzCLHyaPG1g2rTdilMqkAG+WC8YaazhyI
	 YCSmjNOloIJM4C5A7NAIFhuWQVm7wfpwHKRgOKJ8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727144AbfKSF2p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 00:28:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:47176 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728896AbfKSF2m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 00:28:42 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9790C208C3;
        Tue, 19 Nov 2019 05:28:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574141322;
        bh=uRxI4VmbW20DT+z3xkOGVS9S5XwYCJbyurnaAxCjgwo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NEBZuG6MveAlRQCUYFyPFryNHD8QQr2iwcC2272NTkdsR59zdDrpYz27Fbgn/OPj7
         UAjREi5dYoB17d6SIxBj9AS82tJFLOvSSexSUBUuj0LN7cJ6ZacvifhGX2DtN3GRj/
         stD4K2dSJbK0qSlijzVGrxCVYUD7L1R+etvKfL5E=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Stefan Wahren <stefan.wahren@i2se.com>,
        Raghuram Chary Jallipalli 
        <raghuramchary.jallipalli@microchip.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 121/422] net: lan78xx: Bail out if lan78xx_get_endpoints fails
Date:   Tue, 19 Nov 2019 06:15:18 +0100
Message-Id: <20191119051406.868997931@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191119051400.261610025@linuxfoundation.org>
References: <20191119051400.261610025@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stefan Wahren <stefan.wahren@i2se.com>

[ Upstream commit fa8cd98c06407b5798b927cd7fd14d30f360ed02 ]

We need to bail out if lan78xx_get_endpoints() fails, otherwise the
result is overwritten.

Fixes: 55d7de9de6c3 ("Microchip's LAN7800 family USB 2/3 to 10/100/1000 Ethernet")
Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
Reviewed-by: Raghuram Chary Jallipalli <raghuramchary.jallipalli@microchip.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/usb/lan78xx.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/usb/lan78xx.c b/drivers/net/usb/lan78xx.c
index 3a172fcb06fe0..50bf4b2080d5f 100644
--- a/drivers/net/usb/lan78xx.c
+++ b/drivers/net/usb/lan78xx.c
@@ -2950,6 +2950,11 @@ static int lan78xx_bind(struct lan78xx_net *dev, struct usb_interface *intf)
 	int i;
 
 	ret = lan78xx_get_endpoints(dev, intf);
+	if (ret) {
+		netdev_warn(dev->net, "lan78xx_get_endpoints failed: %d\n",
+			    ret);
+		return ret;
+	}
 
 	dev->data[0] = (unsigned long)kzalloc(sizeof(*pdata), GFP_KERNEL);
 
-- 
2.20.1



