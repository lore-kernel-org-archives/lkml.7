Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D87A9C32750
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 02:32:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A287120842
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 02:32:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565749945;
	bh=QByntpCTKCXY11dSE5ZXEeDqtNWp0L6eYuNcYYUszME=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1GTwGqiJkw3Cva/ImNSgNXwYjwMOYHI21FJv8FmL6htuzG7WMuE8cjqVI7brIIzsI
	 jai8qm9YDd8WdhTsTyUS2qctzLI4VyLgYmDiJS2n+aij4Tq61TsawG24ZRcMJD0Nro
	 qv4cpgeG5tTWviz5ycKJDFtVePsxsGb0u+eamDX4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728998AbfHNCQS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 22:16:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:47750 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728955AbfHNCQL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 22:16:11 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 89A7E2133F;
        Wed, 14 Aug 2019 02:16:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565748971;
        bh=QByntpCTKCXY11dSE5ZXEeDqtNWp0L6eYuNcYYUszME=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zcZ98fGlfdFjmlzpnIvpAK+qK5BDK1Cg/KGIW+suQrGXG9xF7A6v9KPC502y4Smtv
         Rhi20tXBBqnrLIbzKggIdajVIePdrVEbq/pG+saPYHtVCi7J2zzJFl3K4PT1nxROvC
         ivURh+wfz6gYfOaVXASgJ4DaCwEDAjXsUoBJ/5ms=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
        Willem de Bruijn <willemb@google.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Sasha Levin <sashal@kernel.org>, linux-can@vger.kernel.org,
        netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 13/68] can: dev: call netif_carrier_off() in register_candev()
Date:   Tue, 13 Aug 2019 22:14:51 -0400
Message-Id: <20190814021548.16001-13-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190814021548.16001-1-sashal@kernel.org>
References: <20190814021548.16001-1-sashal@kernel.org>
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
index c05e4d50d43d7..bd127ce3aba24 100644
--- a/drivers/net/can/dev.c
+++ b/drivers/net/can/dev.c
@@ -1260,6 +1260,8 @@ int register_candev(struct net_device *dev)
 		return -EINVAL;
 
 	dev->rtnl_link_ops = &can_link_ops;
+	netif_carrier_off(dev);
+
 	return register_netdev(dev);
 }
 EXPORT_SYMBOL_GPL(register_candev);
-- 
2.20.1

