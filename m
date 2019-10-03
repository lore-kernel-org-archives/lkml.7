Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A51B2C10F14
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 16:01:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AE97222CC
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 16:01:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570118502;
	bh=kkSBR+c0g8g/8nWU/VkMes6KGJAkUReibvt3+FKxTc4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=S4cfBMYGrvAwvkbgWIcsKkwNbPd2f4nabXnULG45WcZVIIChVr75hpfk6SJHIek5l
	 LNNNDlAQZbzST7pSyMiW9qHEIo7eU/3RS9fjA70c8QY1Pj3DWIhd4f94cCcniQ+UHl
	 klCBzLWKOLkxuMWZxMmxEIl7mo07jVRhb+I5beqU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731882AbfJCQBl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 12:01:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:46074 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731860AbfJCQBj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 12:01:39 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 18226207FF;
        Thu,  3 Oct 2019 16:01:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570118498;
        bh=kkSBR+c0g8g/8nWU/VkMes6KGJAkUReibvt3+FKxTc4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OkyOh6eW7Xwj63Uuhn9vKFBdfwJxqYsOoF/Ltqs/5mo9X+A/ipcmVswhWmDf08hEL
         vB3Y7m4+L/WZzlujsnxjoOavaA0kqs6F4w+WwQkW/ZjVnmQY3bKy15XnlYttUfJYPF
         hSjmHHFuWHK5lZdrXoOSVISX6rnP5RaEF0ZzEMvk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Benoit <benoit.sansoni@gmail.com>,
        Stephen Hemminger <stephen@networkplumber.org>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.9 031/129] skge: fix checksum byte order
Date:   Thu,  3 Oct 2019 17:52:34 +0200
Message-Id: <20191003154333.372124180@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191003154318.081116689@linuxfoundation.org>
References: <20191003154318.081116689@linuxfoundation.org>
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
@@ -3114,7 +3114,7 @@ static struct sk_buff *skge_rx_get(struc
 	skb_put(skb, len);
 
 	if (dev->features & NETIF_F_RXCSUM) {
-		skb->csum = csum;
+		skb->csum = le16_to_cpu(csum);
 		skb->ip_summed = CHECKSUM_COMPLETE;
 	}
 


