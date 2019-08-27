Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A211C3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 07:55:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FEBF21881
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 07:55:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566892550;
	bh=ptPOX0sb1/+pwsg+YZ+AfbBs90MYctvdO44FAZX2CiU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=uchioLuc9cN6wczN9uXHfG0AIv2f4B370e7s0uJfTU/z7MzPM/9qGtHZ6javCo/C6
	 Q7+JI8Mm8bdye6YJ5yJJuIp2RYu4TDS87tNhEfWsyKR4wgD4ldTTt43eADA5eW6gWm
	 SBEUtnrOgV+yS1wmEvvELB/sANToTtbqHhnOiqDo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729913AbfH0Hzs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 03:55:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:47642 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729585AbfH0Hzq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 03:55:46 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 158AC2173E;
        Tue, 27 Aug 2019 07:55:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566892544;
        bh=ptPOX0sb1/+pwsg+YZ+AfbBs90MYctvdO44FAZX2CiU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cpdPDl9WVKDm4EbhafTXvjY9oWVxdFOTipuBSfeQnu8VKF1WtPR8wP9nkYaCzH22C
         L+7z25b2rKq3f3ymIINFQSOyDhYOTFJvvu9qYpftLYqeleY+ACzDlEIAJroUOTHaRQ
         p2Z2RnzDv9AL+2tt5EsSgOftw+E3w97h5+phDewk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jia-Ju Bai <baijiaju1990@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 29/98] net: phy: phy_led_triggers: Fix a possible null-pointer dereference in phy_led_trigger_change_speed()
Date:   Tue, 27 Aug 2019 09:50:08 +0200
Message-Id: <20190827072719.751483136@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190827072718.142728620@linuxfoundation.org>
References: <20190827072718.142728620@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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



