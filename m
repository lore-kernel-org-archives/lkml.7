Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F1A2C3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 07:54:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6675F2186A
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 07:54:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566892459;
	bh=tBPZC6mCiWD6n1scrwgRNNIljCMIUEPvwRa4pmU0U9A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=17HeWRrzzGnrVYguhvgRd1ds9x/7XFyXjhnhLZzBTOxveBhxOqGFgAsu88rNBsX48
	 0ulT+ZU+6iO5yj6emljM6oZ047E4vgTjc8OLqv91rWIL9bSn9vIsLWf125aBxdzwGE
	 A9F0i88qLmgBs4++qrB6qOH7mFA8CkE6pgbMQ0c4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730010AbfH0HyS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 03:54:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:45774 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729374AbfH0HyK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 03:54:10 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 61678217F5;
        Tue, 27 Aug 2019 07:54:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566892449;
        bh=tBPZC6mCiWD6n1scrwgRNNIljCMIUEPvwRa4pmU0U9A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=U7EIaAY2cIgTzV4/02m6rR7wFzd1Yib8Fcn63rMqnTDvczWk39PwdxJIy9H9zrAdt
         7Qeoqq6efq7A/2rPDeZfJfbK2yCeyrAWyvThIK0pgQnY1wWz6MQVCciENPR6ddkXIZ
         K/M3577k08nVEFG5mf+YnnPSqItsKpYsovgbvHU0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
        Willem de Bruijn <willemb@google.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 07/62] can: dev: call netif_carrier_off() in register_candev()
Date:   Tue, 27 Aug 2019 09:50:12 +0200
Message-Id: <20190827072700.663445408@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190827072659.803647352@linuxfoundation.org>
References: <20190827072659.803647352@linuxfoundation.org>
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
index 7d61d8801220e..d92113db4fb97 100644
--- a/drivers/net/can/dev.c
+++ b/drivers/net/can/dev.c
@@ -1217,6 +1217,8 @@ int register_candev(struct net_device *dev)
 		return -EINVAL;
 
 	dev->rtnl_link_ops = &can_link_ops;
+	netif_carrier_off(dev);
+
 	return register_netdev(dev);
 }
 EXPORT_SYMBOL_GPL(register_candev);
-- 
2.20.1



