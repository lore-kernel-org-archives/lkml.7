Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13109C433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 02:22:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D68B520842
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 02:22:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565749346;
	bh=ofRR4q194vxRJTR0/BHAGC0G9PhdVmLLiofeg9bAwpo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=H1GT7Opk+w73qVfvnnS7LhRNZvEtL7V8VTu6lqYz2voEjEBqZWQfCqkmQS6z+Nz2M
	 O5w7X4NA2XyQjZglasA9a3N/NUNjaP7PgPfRQJZNBV+y07PlsxjgV/m4eX85PRm4mV
	 5ZmWpWM7iyzc9jyd80dVwszZN+ezi2iQS4UH7NsQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729722AbfHNCWV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 22:22:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:49720 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728682AbfHNCSr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 22:18:47 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E19C720989;
        Wed, 14 Aug 2019 02:18:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565749126;
        bh=ofRR4q194vxRJTR0/BHAGC0G9PhdVmLLiofeg9bAwpo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eYTzak1qDEwoHFf1CzRU3tMVCmH0RhC4VdhqmUUmxb196iFXqsMHQFHGwXwj1hIqb
         2umkWIDbP3cgZ0CISEPPs9Y2DKZK7u3JcwSmsHYxDNxQEWu+ZaWi4lDNcciI+kizQj
         QJ45//GlwrFrk1ZIU4Nc/cdNMs4xDZqu+GGcCPeo=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
        Willem de Bruijn <willemb@google.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Sasha Levin <sashal@kernel.org>, linux-can@vger.kernel.org,
        netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 08/44] can: dev: call netif_carrier_off() in register_candev()
Date:   Tue, 13 Aug 2019 22:17:57 -0400
Message-Id: <20190814021834.16662-8-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190814021834.16662-1-sashal@kernel.org>
References: <20190814021834.16662-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>

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

