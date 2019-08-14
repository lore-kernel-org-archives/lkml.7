Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 436E4C433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 02:30:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1142920679
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 02:30:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565749858;
	bh=74kf31WKB8TAzNkFDtwz19nehlsq6lwa1J68G1k6gpA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vTs5MHNmEeH2PMq3GHKGUFYkDpVNVN5UhOx94HF9sTKvER8uY60Q7tB2ptGndSYRh
	 xVJHHBcQoCADvvmd4Ss+2Xn6D5wqoEk7k267Y02kHiV9uJoce9bVmNoNHYmXEbOOCN
	 DyRWZ1QeSyFM3FP7oKIPExxRUH6YnBVsBGJ8YcWg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729232AbfHNCQz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 22:16:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:48208 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729174AbfHNCQt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 22:16:49 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 50CBF2084D;
        Wed, 14 Aug 2019 02:16:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565749008;
        bh=74kf31WKB8TAzNkFDtwz19nehlsq6lwa1J68G1k6gpA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CGhjkweVp9giWDSYcRZSuiCbMzWEvbyhAF/VFWlGfB75ciDwvy+aDWAT8VXS0Vcws
         vwVgARLIICR71QomNrVFoiNudqc2VlICYLBon4pnhWlizmUHCuxZzX0NZNY5p1cuOE
         rHqYDZqE38N3rv5Ml26VoT1U1Jhh2nVp2gMe8VvU=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jia-Ju Bai <baijiaju1990@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 33/68] net: phy: phy_led_triggers: Fix a possible null-pointer dereference in phy_led_trigger_change_speed()
Date:   Tue, 13 Aug 2019 22:15:11 -0400
Message-Id: <20190814021548.16001-33-sashal@kernel.org>
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
index 491efc1bf5c48..7278eca70f9f3 100644
--- a/drivers/net/phy/phy_led_triggers.c
+++ b/drivers/net/phy/phy_led_triggers.c
@@ -58,8 +58,9 @@ void phy_led_trigger_change_speed(struct phy_device *phy)
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

