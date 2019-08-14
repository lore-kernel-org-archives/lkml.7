Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC9E8C433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 02:12:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8F4C20842
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 02:12:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565748728;
	bh=b9YsOGq9IPX5jQ7sZyT5oZdJJGKhSKjn7KgXPVwm4ls=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=UKMJmPABDHPoMK69L2EAGpeWYith5mlRstScTBev4xTdwOpVwl/1YqmCBBjJgLnJi
	 VOor0sU13BqbPtC4RpH20tVi5rRSZm8S415EUphd2Woez6Xu+uaohudeBEip0/AGJO
	 +4ClpSxJR0RkfajlgrYO2JMoKQASfcRgPQEEReyY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727820AbfHNCMH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 22:12:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:44200 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727703AbfHNCMB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 22:12:01 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DFAA52084F;
        Wed, 14 Aug 2019 02:11:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565748720;
        bh=b9YsOGq9IPX5jQ7sZyT5oZdJJGKhSKjn7KgXPVwm4ls=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0AhGT+4CQAs7zN0J6NUQGcidiQvHwPkPbZOwt0sFmgUt5o0kPAnB1E7RifQ+E1IY4
         segnnH9yo6B8/tRH/eo9OQVQkJ5vtVJOtX5yNv08g9HxjB2Pvv18cqenlsxkBHa4X9
         UCa5iIKDgPa049wRyslqr1unzkgKfRsdJPDo5smQ=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
        Willem de Bruijn <willemb@google.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Sasha Levin <sashal@kernel.org>, linux-can@vger.kernel.org,
        netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.2 037/123] can: dev: call netif_carrier_off() in register_candev()
Date:   Tue, 13 Aug 2019 22:09:21 -0400
Message-Id: <20190814021047.14828-37-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190814021047.14828-1-sashal@kernel.org>
References: <20190814021047.14828-1-sashal@kernel.org>
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
index b6b93a2d93a59..483d270664cc8 100644
--- a/drivers/net/can/dev.c
+++ b/drivers/net/can/dev.c
@@ -1249,6 +1249,8 @@ int register_candev(struct net_device *dev)
 		return -EINVAL;
 
 	dev->rtnl_link_ops = &can_link_ops;
+	netif_carrier_off(dev);
+
 	return register_netdev(dev);
 }
 EXPORT_SYMBOL_GPL(register_candev);
-- 
2.20.1

