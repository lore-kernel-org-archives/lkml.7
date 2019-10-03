Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A80E2C10F14
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 16:14:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7549920700
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 16:14:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570119295;
	bh=EYAALUMmZ9KHd4VSRCBYO6TuloHm/s5iluJ+FeyOCvc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hn6uB67vY3Qxw6EyCAU0Znpk4iH46PSc0YNJM3vUJe0ISnJRbCNkDG1mA1JWNJWu1
	 77xQEITiBLCkLRxTN08032kaMb5vgtUVbH/uEf26imx0VicM5Igu3bNEupA+9f26St
	 kIimr7Z6sjWI4yruE+Oumu1KfGtbiNtvZBz7UdDo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729379AbfJCQOy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 12:14:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:38546 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733287AbfJCQOx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 12:14:53 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 46DFD21783;
        Thu,  3 Oct 2019 16:14:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570119292;
        bh=EYAALUMmZ9KHd4VSRCBYO6TuloHm/s5iluJ+FeyOCvc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zx5sjDSBo7OOAYdwy9RWGdW4Bp/W5gHe4rZ2MK9KTU716DWzdi+LtfTAI2miIApZx
         bYsGBUt7A23QZqp2GY8xm8+3tLj4vT4m+mWydzgN3gKkIlISbqob/1uQ4y8zeoq+hl
         VKgkcwIrAw+BR7vfnUHA/wiqWPBB9l1sbSXwSN0k=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Benoit <benoit.sansoni@gmail.com>,
        Stephen Hemminger <stephen@networkplumber.org>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.19 012/211] skge: fix checksum byte order
Date:   Thu,  3 Oct 2019 17:51:18 +0200
Message-Id: <20191003154449.715411742@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191003154447.010950442@linuxfoundation.org>
References: <20191003154447.010950442@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stephen Hemminger <stephen@networkplumber.org>

[ Upstream commit 5aafeb74b5bb65b34cc87c7623f9fa163a34fa3b ]

Running old skge driver on PowerPC causes checksum errors
because hardware reported 1's complement checksum is in little-endian
byte order.

Reported-by: Benoit <benoit.sansoni@gmail.com>
Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/marvell/skge.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/ethernet/marvell/skge.c
+++ b/drivers/net/ethernet/marvell/skge.c
@@ -3122,7 +3122,7 @@ static struct sk_buff *skge_rx_get(struc
 	skb_put(skb, len);
 
 	if (dev->features & NETIF_F_RXCSUM) {
-		skb->csum = csum;
+		skb->csum = le16_to_cpu(csum);
 		skb->ip_summed = CHECKSUM_COMPLETE;
 	}
 


