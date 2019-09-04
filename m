Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 647E8C3A5A8
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 18:25:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32EF420870
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 18:25:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567621540;
	bh=+g2+1TXZMeEDdeX8VPRARnKKneMpEfXU54c/7gjeNnQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ncUB6PJBxs8S7zxWt1qN3oiXsiOgul3aqZW+Go92zBlWp8uyVn9FqEi8+DKFBn4pY
	 B5xFqKTfdZmZp2ZchMh0vY4ho4RqiF1y4I6Xitv/6tqNGErx3mEmdzM4sPsY2bDsOc
	 WVST4IEkvDfa8jXIOJk/wn0omui3rPKOPVfeV5RM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388531AbfIDSZj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 14:25:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:38808 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388277AbfIDR7t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 13:59:49 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4B2A923404;
        Wed,  4 Sep 2019 17:59:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567619988;
        bh=+g2+1TXZMeEDdeX8VPRARnKKneMpEfXU54c/7gjeNnQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tEF2io6by4kidvx1Sn5UNE56TiHwi6hS/CbFlvhrQqouZ6t0+lE0myz4D7OdCql6j
         FcZ2/Sx7YIMCyO/hQ1P9kH6CerhFRN1Fqy3SRL9wyTAye5PCmwUCuI/sW0RHshY2U2
         2LhYO772CKOddrDwodfD3BW3JUpYwtbmQVW3ju/8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
        Willem de Bruijn <willemb@google.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 06/83] can: dev: call netif_carrier_off() in register_candev()
Date:   Wed,  4 Sep 2019 19:52:58 +0200
Message-Id: <20190904175304.248865446@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190904175303.488266791@linuxfoundation.org>
References: <20190904175303.488266791@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit c63845609c4700488e5eacd6ab4d06d5d420e5ef ]

CONFIG_CAN_LEDS is deprecated. When trying to use the generic netdev
trigger as suggested, there's a small inconsistency with the link
property: The LED is on initially, stays on when the device is brought
up, and then turns off (as expected) when the device is brought down.

Make sure the LED always reflects the state of the CAN device.

Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Acked-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/can/dev.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/can/dev.c b/drivers/net/can/dev.c
index 214a48703a4e4..ffc5467a1ec2b 100644
--- a/drivers/net/can/dev.c
+++ b/drivers/net/can/dev.c
@@ -1095,6 +1095,8 @@ static struct rtnl_link_ops can_link_ops __read_mostly = {
 int register_candev(struct net_device *dev)
 {
 	dev->rtnl_link_ops = &can_link_ops;
+	netif_carrier_off(dev);
+
 	return register_netdev(dev);
 }
 EXPORT_SYMBOL_GPL(register_candev);
-- 
2.20.1



