Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1DB7C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 22:33:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFDF42073D
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 22:33:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="x3zO7znl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728857AbfLJWdU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 17:33:20 -0500
Received: from pandora.armlinux.org.uk ([78.32.30.218]:58808 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727683AbfLJWdS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 17:33:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
        Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:Reply-To:Content-ID
        :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
        Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=l5nCDL9ygOAUkfMI19xtYeqlPRqrJq8DhttmTEm6aW8=; b=x3zO7znlJD+0Desk5TPJUwH4zH
        8sLQF0FvCKSQ68+jTwttTyTuVtF5Fu0u7j9GaxohPhKKNlvDBe/GN7ePxHHCYfkf3YwURFsll0r/r
        ZzFm9YrCZJ2s5VYHMXNTDBH9YFG9iKFXyhUyKoc7ZWrL9xfhE1xnZtq72n7bdEb6FbtCNWuhjnc0y
        Agt7gLeB0/UZFgZu8oyy0kchCihvxbfFM7ZeeaUww/TnCBl7vq1rj3s2BSXHOWlVh3+FS6q2wfHpA
        7lXs3Dudp2TDEuzWX2TlG8N6KGEA5kRR0sRmV+OHJKsm1LRWPIe+B+miJTz8Wm9jDgMArS3LOYD0v
        F1Oa54Mw==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([2001:4d48:ad52:3201:222:68ff:fe15:37dd]:42694 helo=rmk-PC.armlinux.org.uk)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <rmk@armlinux.org.uk>)
        id 1ieo42-0004Lp-6r; Tue, 10 Dec 2019 22:33:06 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <rmk@armlinux.org.uk>)
        id 1ieo41-00023K-2O; Tue, 10 Dec 2019 22:33:05 +0000
From:   Russell King <rmk+kernel@armlinux.org.uk>
To:     "David S. Miller" <davem@davemloft.net>
Cc:     Antoine Tenart <antoine.tenart@bootlin.com>,
        Willy Tarreau <w@1wt.eu>, Andrew Lunn <andrew@lunn.ch>,
        Thomas Bogendoerfer <tbogendoerfer@suse.de>,
        maxime.chevallier@bootlin.com, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Subject: [PATCH] net: marvell: mvpp2: phylink requires the link interrupt
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1ieo41-00023K-2O@rmk-PC.armlinux.org.uk>
Date:   Tue, 10 Dec 2019 22:33:05 +0000
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

phylink requires the MAC to report when its link status changes when
operating in inband modes.  Failure to report link status changes
means that phylink has no idea when the link events happen, which
results in either the network interface's carrier remaining up or
remaining permanently down.

For example, with a fiber module, if the interface is brought up and
link is initially established, taking the link down at the far end
will cut the optical power.  The SFP module's LOS asserts, we
deactivate the link, and the network interface reports no carrier.

When the far end is brought back up, the SFP module's LOS deasserts,
but the MAC may be slower to establish link.  If this happens (which
in my tests is a certainty) then phylink never hears that the MAC
has established link with the far end, and the network interface is
stuck reporting no carrier.  This means the interface is
non-functional.

Avoiding the link interrupt when we have phylink is basically not
an option, so remove the !port->phylink from the test.

Tested-by: Sven Auhagen <sven.auhagen@voleatech.de>
Tested-by: Antoine Tenart <antoine.tenart@bootlin.com>
Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
index 111b3b8239e1..ef44c6979a31 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
@@ -3674,7 +3674,7 @@ static int mvpp2_open(struct net_device *dev)
 		valid = true;
 	}
 
-	if (priv->hw_version == MVPP22 && port->link_irq && !port->phylink) {
+	if (priv->hw_version == MVPP22 && port->link_irq) {
 		err = request_irq(port->link_irq, mvpp2_link_status_isr, 0,
 				  dev->name, port);
 		if (err) {
-- 
2.20.1

