Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E36DC43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 18:00:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B02F2083B
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 18:00:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561053626;
	bh=snxNge4y/YgYh8pt7CvjFkx+Ubop37dNmgxP6d0bU7k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=MMPeeLEZwLNNyPHDOlBaPFoIRsfEV0LHfgvWpNWr70ZytIqTyzUJ+wzq4yKLku4ay
	 WLKO/EqKcQ0btTocoRGrATBnepT1qj5iCQN4msKFe/45FV2VOBfyPq2SgqMaOjg4W3
	 w+A33XXC+4w9EVu/fcqh+K+rVgdfrE2Ql9ijfnXg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726952AbfFTSAZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 14:00:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:49036 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726931AbfFTSAW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 14:00:22 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0EB18208CA;
        Thu, 20 Jun 2019 18:00:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561053621;
        bh=snxNge4y/YgYh8pt7CvjFkx+Ubop37dNmgxP6d0bU7k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AE7c/MPRVBh9I8/xKabc9J2EAr01m7yTKidDo3zw0p2znpdAHB3DIp7U6ek6X9FvX
         1Q/v20y3flUT1F6/UcNV8+uzwjHgCZOxO4dsHUamIFmBN7z8jrdB1zXMCARXOimPAr
         LtA4lvLmX4R0+8VUX1OmiYYdLQyRRAugYVb/OdwA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Oliver Zweigle <Oliver.Zweigle@faro.com>,
        Bernd Eckstein <3ernd.Eckstein@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 53/84] usbnet: ipheth: fix racing condition
Date:   Thu, 20 Jun 2019 19:56:50 +0200
Message-Id: <20190620174346.904349990@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190620174337.538228162@linuxfoundation.org>
References: <20190620174337.538228162@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 94d250fae48e6f873d8362308f5c4d02cd1b1fd2 ]

Fix a racing condition in ipheth.c that can lead to slow performance.

Bug: In ipheth_tx(), netif_wake_queue() may be called on the callback
ipheth_sndbulk_callback(), _before_ netif_stop_queue() is called.
When this happens, the queue is stopped longer than it needs to be,
thus reducing network performance.

Fix: Move netif_stop_queue() in front of usb_submit_urb(). Now the order
is always correct. In case, usb_submit_urb() fails, the queue is woken up
again as callback will not fire.

Testing: This racing condition is usually not noticeable, as it has to
occur very frequently to slowdown the network. The callback from the USB
is usually triggered slow enough, so the situation does not appear.
However, on a Ubuntu Linux on VMWare Workstation, running on Windows 10,
the we loose the race quite often and the following speedup can be noticed:

Without this patch: Download:  4.10 Mbit/s, Upload:  4.01 Mbit/s
With this patch:    Download: 36.23 Mbit/s, Upload: 17.61 Mbit/s

Signed-off-by: Oliver Zweigle <Oliver.Zweigle@faro.com>
Signed-off-by: Bernd Eckstein <3ernd.Eckstein@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/usb/ipheth.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/usb/ipheth.c b/drivers/net/usb/ipheth.c
index 01f95d192d25..2b16a5fed9de 100644
--- a/drivers/net/usb/ipheth.c
+++ b/drivers/net/usb/ipheth.c
@@ -437,17 +437,18 @@ static int ipheth_tx(struct sk_buff *skb, struct net_device *net)
 			  dev);
 	dev->tx_urb->transfer_flags |= URB_NO_TRANSFER_DMA_MAP;
 
+	netif_stop_queue(net);
 	retval = usb_submit_urb(dev->tx_urb, GFP_ATOMIC);
 	if (retval) {
 		dev_err(&dev->intf->dev, "%s: usb_submit_urb: %d\n",
 			__func__, retval);
 		dev->net->stats.tx_errors++;
 		dev_kfree_skb_any(skb);
+		netif_wake_queue(net);
 	} else {
 		dev->net->stats.tx_packets++;
 		dev->net->stats.tx_bytes += skb->len;
 		dev_consume_skb_any(skb);
-		netif_stop_queue(net);
 	}
 
 	return NETDEV_TX_OK;
-- 
2.20.1



