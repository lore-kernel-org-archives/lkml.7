Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F53AC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:42:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E13F0206DF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:42:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552412576;
	bh=R0IzdxrpEg9vMTIINCYzZz97S0hIR87h3zsaiSmzAOc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=SlmXD6IuDwFBnMSdWSxEp0kmTRR9FCV4HFfUgPBNZfdTAZ9jUA9jm81WtSjjCKDcc
	 F8+ZOXPtBNN4JIArlbWN2KllYKZLKvjdjSBJk3hyTKl3yCLQgad3fKREYO7hH7iuDQ
	 4i3NVmjdPLxoGwdoDtyvv6w53xpyTiKG/0EAE+ys=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729138AbfCLRmy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 13:42:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:57126 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728908AbfCLRPx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 13:15:53 -0400
Received: from localhost (unknown [104.133.8.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E6B652183F;
        Tue, 12 Mar 2019 17:15:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552410953;
        bh=R0IzdxrpEg9vMTIINCYzZz97S0hIR87h3zsaiSmzAOc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dTRJPVUqj3w39kChgOK0Don8H4WBrRC6qkmQgg+zg2sGXm/k70S+jhXRKXnfWaVga
         F7GPmqJVt+0+MsajNXNg4ppGvSudTDymLks9lKcJ9Vbt3qDGjBzTyIXrUCRO/IYDGw
         kiaPqfRjaoT/Ki686f64DDkozAnwDQRuFfH5xJ8U=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Heiner Kallweit <hkallweit1@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 021/135] net: phy: phylink: fix uninitialized variable in phylink_get_mac_state
Date:   Tue, 12 Mar 2019 10:07:48 -0700
Message-Id: <20190312170343.049007666@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190312170341.127810985@linuxfoundation.org>
References: <20190312170341.127810985@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -333,6 +333,10 @@ static int phylink_get_mac_state(struct
 	linkmode_zero(state->lp_advertising);
 	state->interface = pl->link_config.interface;
 	state->an_enabled = pl->link_config.an_enabled;
+	state->speed = SPEED_UNKNOWN;
+	state->duplex = DUPLEX_UNKNOWN;
+	state->pause = MLO_PAUSE_NONE;
+	state->an_complete = 0;
 	state->link = 1;
 
 	return pl->ops->mac_link_state(ndev, state);


