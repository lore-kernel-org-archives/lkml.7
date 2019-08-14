Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACF30C433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 02:35:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A9B52085A
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 02:35:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565750150;
	bh=+U60twviNfO6eXyzcfXAa1yYbK17knaDCcj3fyQ0ht8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zADHUFV4kF2huu33GFXa1LqBwCtstAwq2Vk+7LICMumvIhX53bF6JtyguWRwqI0bQ
	 /lU9lg9YNYiktx+lKBgdsoEReGtTStbLGNibmzwLUVz5nSu49CrR1Gp4Kt8vQby7bB
	 tL3z45w1YZFXSuYM21bME45YH0KX1e/3NQwEkcAI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729159AbfHNCft (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 22:35:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:45366 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728236AbfHNCNW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 22:13:22 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 910BD2133F;
        Wed, 14 Aug 2019 02:13:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565748801;
        bh=+U60twviNfO6eXyzcfXAa1yYbK17knaDCcj3fyQ0ht8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Dg4E8OsSvhAYMH15AxbsPLEE4ni/vn+rcZJo8qAVnyZxcJjrCxgq4mxWE7lLtibof
         A3rEBLhbbD5VrTFY+5/tvyjZ+4TH9rg43QhOGh+3z8HVICbyqhN06zFTmvVo966N66
         tF7aXPWhWK2sc4dPwlg6tUnA5xMycoLvd3lZLa/8=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jia-Ju Bai <baijiaju1990@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.2 070/123] net: phy: phy_led_triggers: Fix a possible null-pointer dereference in phy_led_trigger_change_speed()
Date:   Tue, 13 Aug 2019 22:09:54 -0400
Message-Id: <20190814021047.14828-70-sashal@kernel.org>
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

From: Jia-Ju Bai <baijiaju1990@gmail.com>

[ Upstream commit 271da132e29b5341c31eca6ba6a72ea1302ebac8 ]

In phy_led_trigger_change_speed(), there is an if statement on line 48
to check whether phy->last_triggered is NULL:
    if (!phy->last_triggered)

When phy->last_triggered is NULL, it is used on line 52:
    led_trigger_event(&phy->last_triggered->trigger, LED_OFF);

Thus, a possible null-pointer dereference may occur.

To fix this bug, led_trigger_event(&phy->last_triggered->trigger,
LED_OFF) is called when phy->last_triggered is not NULL.

This bug is found by a static analysis tool STCheck written by
the OSLAB group in Tsinghua University.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/phy/phy_led_triggers.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/phy_led_triggers.c b/drivers/net/phy/phy_led_triggers.c
index b86a4b2116f81..59a94e07e7c55 100644
--- a/drivers/net/phy/phy_led_triggers.c
+++ b/drivers/net/phy/phy_led_triggers.c
@@ -48,8 +48,9 @@ void phy_led_trigger_change_speed(struct phy_device *phy)
 		if (!phy->last_triggered)
 			led_trigger_event(&phy->led_link_trigger->trigger,
 					  LED_FULL);
+		else
+			led_trigger_event(&phy->last_triggered->trigger, LED_OFF);
 
-		led_trigger_event(&phy->last_triggered->trigger, LED_OFF);
 		led_trigger_event(&plt->trigger, LED_FULL);
 		phy->last_triggered = plt;
 	}
-- 
2.20.1

