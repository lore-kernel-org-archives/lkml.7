Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A08F3C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 12:55:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E606208E4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 12:55:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552049717;
	bh=V36gT4x2aE+TqTvMGhxtoMMhS7SEdmtePx9BPdJ1bIs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=05jerjrczgvqiHPVPwg4ZL/pkEyZtHG9KmPXCaOfY1Uh1c89HnseDXEitRB4o+9oJ
	 Xm2f2Oph5qtZUlokq49L5QO7lgSVMq42TUHhv6ArDXsbqbVNJRjOxtWNeCnm2XMjSx
	 2fcY86cDfSTLqkr7/j5gAf7Ua7YAS47hKychuxgs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727028AbfCHMzQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 07:55:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:59162 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727452AbfCHMzL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 07:55:11 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6D0F02085A;
        Fri,  8 Mar 2019 12:55:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552049709;
        bh=V36gT4x2aE+TqTvMGhxtoMMhS7SEdmtePx9BPdJ1bIs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=05vP5hUNCI1ilj9ovmyemrRndNenmjEyfk3UwL6vnkkot09xP8qJzXzDaFzHjOMeA
         Co8T+pm2SwDhtIYCqJtAmCKLTLqcpreLAPi0iYXg577w1UdmKV66tZmSyUnqkUYxHN
         K75ivgtn9LQNcjWSRhRVoCiPOsw4dFbdlZj1TqPc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Alexander Onnasch <alexander.onnasch@landisgyr.com>,
        Rajasingh Thavamani <T.Rajasingh@landisgyr.com>,
        Andrew Lunn <andrew@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.20 40/76] net: phy: Micrel KSZ8061: link failure after cable connect
Date:   Fri,  8 Mar 2019 13:49:52 +0100
Message-Id: <20190308124916.237710706@linuxfoundation.org>
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
 drivers/net/phy/micrel.c |   13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

--- a/drivers/net/phy/micrel.c
+++ b/drivers/net/phy/micrel.c
@@ -339,6 +339,17 @@ static int ksz8041_config_aneg(struct ph
 	return genphy_config_aneg(phydev);
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
@@ -1044,7 +1055,7 @@ static struct phy_driver ksphy_driver[]
 	.phy_id_mask	= MICREL_PHY_ID_MASK,
 	.features	= PHY_BASIC_FEATURES,
 	.flags		= PHY_HAS_INTERRUPT,
-	.config_init	= kszphy_config_init,
+	.config_init	= ksz8061_config_init,
 	.ack_interrupt	= kszphy_ack_interrupt,
 	.config_intr	= kszphy_config_intr,
 	.suspend	= genphy_suspend,


