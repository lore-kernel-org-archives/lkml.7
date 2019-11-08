Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 159DAFA372C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 19:10:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E371D21D82
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 19:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573240230;
	bh=nLOcwWJWwhXvTCEzjBYbp64HImRzY0owBgLtbidwXq0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=dDy0g9s+jS8gXqhP+2fPxOHJlkcoj6VbsUp3FmqO/Xq9jlR3zuLVirIneMv7SHFIz
	 lTHzg/0R5mKAngNMeOTqYxmOlZuBPYcIIEruUf09Y5VTZnJcjzs8nDA7ukQPOrx02q
	 h+N5fAAHYnwpkszi00qiQObgYOUh1pTSKcn0mTjk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391889AbfKHTK2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 14:10:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:42656 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390609AbfKHTKY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 14:10:24 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 27F3721D7E;
        Fri,  8 Nov 2019 19:10:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573240223;
        bh=nLOcwWJWwhXvTCEzjBYbp64HImRzY0owBgLtbidwXq0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EMmGoyqqT7V4KH8tvi6yolBG0rxdcB2o8nAWvFm2t5XKJLsblem6kfpVBIKVNmetT
         AUvlZdECnfXsmdDO8+x9toyQ9QsoQa0uc9ehupTLfZ0ZXOo9mWf55R6wGskPgMgN0r
         UHbvnFB6w7sSYYvdUxP1ANWSM++JdFfv9FULUoqA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Doug Berger <opendmb@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.3 132/140] net: bcmgenet: reset 40nm EPHY on energy detect
Date:   Fri,  8 Nov 2019 19:51:00 +0100
Message-Id: <20191108174912.945797377@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191108174900.189064908@linuxfoundation.org>
References: <20191108174900.189064908@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Doug Berger <opendmb@gmail.com>

[ Upstream commit 25382b991d252aed961cd434176240f9de6bb15f ]

The EPHY integrated into the 40nm Set-Top Box devices can falsely
detect energy when connected to a disabled peer interface. When the
peer interface is enabled the EPHY will detect and report the link
as active, but on occasion may get into a state where it is not
able to exchange data with the connected GENET MAC. This issue has
not been observed when the link parameters are auto-negotiated;
however, it has been observed with a manually configured link.

It has been empirically determined that issuing a soft reset to the
EPHY when energy is detected prevents it from getting into this bad
state.

Fixes: 1c1008c793fa ("net: bcmgenet: add main driver file")
Signed-off-by: Doug Berger <opendmb@gmail.com>
Acked-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/broadcom/genet/bcmgenet.c |    9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

--- a/drivers/net/ethernet/broadcom/genet/bcmgenet.c
+++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
@@ -2018,6 +2018,8 @@ static void bcmgenet_link_intr_enable(st
 	 */
 	if (priv->internal_phy) {
 		int0_enable |= UMAC_IRQ_LINK_EVENT;
+		if (GENET_IS_V1(priv) || GENET_IS_V2(priv) || GENET_IS_V3(priv))
+			int0_enable |= UMAC_IRQ_PHY_DET_R;
 	} else if (priv->ext_phy) {
 		int0_enable |= UMAC_IRQ_LINK_EVENT;
 	} else if (priv->phy_interface == PHY_INTERFACE_MODE_MOCA) {
@@ -2616,9 +2618,14 @@ static void bcmgenet_irq_task(struct wor
 	priv->irq0_stat = 0;
 	spin_unlock_irq(&priv->lock);
 
+	if (status & UMAC_IRQ_PHY_DET_R &&
+	    priv->dev->phydev->autoneg != AUTONEG_ENABLE)
+		phy_init_hw(priv->dev->phydev);
+
 	/* Link UP/DOWN event */
 	if (status & UMAC_IRQ_LINK_EVENT)
 		phy_mac_interrupt(priv->dev->phydev);
+
 }
 
 /* bcmgenet_isr1: handle Rx and Tx priority queues */
@@ -2713,7 +2720,7 @@ static irqreturn_t bcmgenet_isr0(int irq
 	}
 
 	/* all other interested interrupts handled in bottom half */
-	status &= UMAC_IRQ_LINK_EVENT;
+	status &= (UMAC_IRQ_LINK_EVENT | UMAC_IRQ_PHY_DET_R);
 	if (status) {
 		/* Save irq status for bottom-half processing. */
 		spin_lock_irqsave(&priv->lock, flags);


