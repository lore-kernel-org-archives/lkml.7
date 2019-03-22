Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F1B9C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 13:13:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E10EE2183E
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 13:13:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553260409;
	bh=GUs/bBEqIHE7eZEBIkCWSAhuwUcNWNOx0v5uJpAMLPY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gQAdjil6j+kLktPKTM37s88P0L2JMuqaWU7w13dB3gH53KOqhca7BtVVQ7iG0++Ti
	 U9xH4vT8Y3tm2Ezz8Mg5nv82RSDMEFQSTmLnYOGvUl7eN/upn4rcD851jyVu4tcxOA
	 m36Ff6GKJKvq2O8ebGGgn+UyoCN4+Ou4Wvo+RW20=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730181AbfCVNN1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 09:13:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:58496 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729511AbfCVLa3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 07:30:29 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E439A218B0;
        Fri, 22 Mar 2019 11:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553254228;
        bh=GUs/bBEqIHE7eZEBIkCWSAhuwUcNWNOx0v5uJpAMLPY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KEUfj3rhWlV72iijgWza6kz7MVtnOybaKRtE4sjVSRIa9dpM0Rm/LS9rbs1L8PbSQ
         fAGgF1WV7RenHHXk0iRZ2rtJaKuBzpJ/vz6O5FZLYtyYj7wsLUQJOJQ57uSdUyTY3o
         tlQwefMOylFTpRuWKtBxVddOyLDHNonJIff8OBzo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Alexander Onnasch <alexander.onnasch@landisgyr.com>,
        Rajasingh Thavamani <T.Rajasingh@landisgyr.com>,
        Andrew Lunn <andrew@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.4 071/230] net: phy: Micrel KSZ8061: link failure after cable connect
Date:   Fri, 22 Mar 2019 12:13:29 +0100
Message-Id: <20190322111241.663131674@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111236.796964179@linuxfoundation.org>
References: <20190322111236.796964179@linuxfoundation.org>
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

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Rajasingh Thavamani <T.Rajasingh@landisgyr.com>

[ Upstream commit 232ba3a51cc224b339c7114888ed7f0d4d95695e ]

With Micrel KSZ8061 PHY, the link may occasionally not come up after
Ethernet cable connect. The vendor's (Microchip, former Micrel) errata
sheet 80000688A.pdf descripes the problem and possible workarounds in
detail, see below.
The batch implements workaround 1, which permanently fixes the issue.

DESCRIPTION
Link-up may not occur properly when the Ethernet cable is initially
connected. This issue occurs more commonly when the cable is connected
slowly, but it may occur any time a cable is connected. This issue occurs
in the auto-negotiation circuit, and will not occur if auto-negotiation
is disabled (which requires that the two link partners be set to the
same speed and duplex).

END USER IMPLICATIONS
When this issue occurs, link is not established. Subsequent cable
plug/unplaug cycle will not correct the issue.

WORk AROUND
There are four approaches to work around this issue:
1. This issue can be prevented by setting bit 15 in MMD device address 1,
   register 2, prior to connecting the cable or prior to setting the
   Restart Auto-negotiation bit in register 0h. The MMD registers are
   accessed via the indirect access registers Dh and Eh, or via the Micrel
   EthUtil utility as shown here:
   . if using the EthUtil utility (usually with a Micrel KSZ8061
     Evaluation Board), type the following commands:
     > address 1
     > mmd 1
     > iw 2 b61a
   . Alternatively, write the following registers to write to the
     indirect MMD register:
     Write register Dh, data 0001h
     Write register Eh, data 0002h
     Write register Dh, data 4001h
     Write register Eh, data B61Ah
2. The issue can be avoided by disabling auto-negotiation in the KSZ8061,
   either by the strapping option, or by clearing bit 12 in register 0h.
   Care must be taken to ensure that the KSZ8061 and the link partner
   will link with the same speed and duplex. Note that the KSZ8061
   defaults to full-duplex when auto-negotiation is off, but other
   devices may default to half-duplex in the event of failed
   auto-negotiation.
3. The issue can be avoided by connecting the cable prior to powering-up
   or resetting the KSZ8061, and leaving it plugged in thereafter.
4. If the above measures are not taken and the problem occurs, link can
   be recovered by setting the Restart Auto-Negotiation bit in
   register 0h, or by resetting or power cycling the device. Reset may
   be either hardware reset or software reset (register 0h, bit 15).

PLAN
This errata will not be corrected in the future revision.

Fixes: 7ab59dc15e2f ("drivers/net/phy/micrel_phy: Add support for new PHYs")
Signed-off-by: Alexander Onnasch <alexander.onnasch@landisgyr.com>
Signed-off-by: Rajasingh Thavamani <T.Rajasingh@landisgyr.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/phy/micrel.c |   14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

--- a/drivers/net/phy/micrel.c
+++ b/drivers/net/phy/micrel.c
@@ -28,6 +28,7 @@
 #include <linux/micrel_phy.h>
 #include <linux/of.h>
 #include <linux/clk.h>
+#include <uapi/linux/mdio.h>
 
 /* Operation Mode Strap Override */
 #define MII_KSZPHY_OMSO				0x16
@@ -287,6 +288,17 @@ static int kszphy_config_init(struct phy
 	return 0;
 }
 
+static int ksz8061_config_init(struct phy_device *phydev)
+{
+	int ret;
+
+	ret = phy_write_mmd(phydev, MDIO_MMD_PMAPMD, MDIO_DEVID1, 0xB61A);
+	if (ret)
+		return ret;
+
+	return kszphy_config_init(phydev);
+}
+
 static int ksz9021_load_values_from_of(struct phy_device *phydev,
 				       const struct device_node *of_node,
 				       u16 reg,
@@ -771,7 +783,7 @@ static struct phy_driver ksphy_driver[]
 	.phy_id_mask	= 0x00fffff0,
 	.features	= (PHY_BASIC_FEATURES | SUPPORTED_Pause),
 	.flags		= PHY_HAS_MAGICANEG | PHY_HAS_INTERRUPT,
-	.config_init	= kszphy_config_init,
+	.config_init	= ksz8061_config_init,
 	.config_aneg	= genphy_config_aneg,
 	.read_status	= genphy_read_status,
 	.ack_interrupt	= kszphy_ack_interrupt,


