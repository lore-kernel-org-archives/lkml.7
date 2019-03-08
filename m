Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE56CC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 13:06:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BFC820661
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 13:06:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552050407;
	bh=oloH9UZT6paXQhhxoO2ysRPdbWuSj/G1Dat8h3Bg3iQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=UiZUxHR2caaVvXiijueDzmdH4NRBUuHtb0Mko3vvMB5HfR+AhEzfJ959h+o706Yr5
	 1fl3TPS1llXysfOGkLfVQ9jAahCTiJBIlGUoUiswNHQIfDo8wWkdeNDXNPTJlfCtQ4
	 FHh0WJATCeimeHfMTVTa6cBF5tgJnrY9WRTACX7s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727641AbfCHNGp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 08:06:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:59222 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727468AbfCHMzO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 07:55:14 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2D99C2085A;
        Fri,  8 Mar 2019 12:55:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552049713;
        bh=oloH9UZT6paXQhhxoO2ysRPdbWuSj/G1Dat8h3Bg3iQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DM6D0LTh/k+tUksc8vQbGCfB/nw/JmuTDjcR0skNjOtqSnRdUOwiT9N7Wi2aepVid
         WO2KkI4gpb2JEDWoRAJn7Po7P/5WSMwCBOf3/RRZwVR6LPPcqz0H/7/1arcAHQdwBc
         js7WYdVhZvR+9CK7F7jWgm2uB7l82HbuMsbJqSss=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Heiner Kallweit <hkallweit1@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.20 41/76] net: phy: phylink: fix uninitialized variable in phylink_get_mac_state
Date:   Fri,  8 Mar 2019 13:49:53 +0100
Message-Id: <20190308124916.271984388@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190308124914.789210760@linuxfoundation.org>
References: <20190308124914.789210760@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Heiner Kallweit <hkallweit1@gmail.com>

[ Upstream commit d25ed413d5e51644e18f66e34eec049f17a7abcb ]

When debugging an issue I found implausible values in state->pause.
Reason in that state->pause isn't initialized and later only single
bits are changed. Also the struct itself isn't initialized in
phylink_resolve(). So better initialize state->pause and other
not yet initialized fields.

v2:
- use right function name in subject
v3:
- initialize additional fields

Fixes: 9525ae83959b ("phylink: add phylink infrastructure")
Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/phy/phylink.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/drivers/net/phy/phylink.c
+++ b/drivers/net/phy/phylink.c
@@ -321,6 +321,10 @@ static int phylink_get_mac_state(struct
 	linkmode_zero(state->lp_advertising);
 	state->interface = pl->link_config.interface;
 	state->an_enabled = pl->link_config.an_enabled;
+	state->speed = SPEED_UNKNOWN;
+	state->duplex = DUPLEX_UNKNOWN;
+	state->pause = MLO_PAUSE_NONE;
+	state->an_complete = 0;
 	state->link = 1;
 
 	return pl->ops->mac_link_state(ndev, state);


