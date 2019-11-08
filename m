Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B89C8C5DF60
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 18:56:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 903F921D7F
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 18:56:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573239402;
	bh=qUcFqg4z4RqZDCWvaRajjLuuMCMBmoZryKmlMQxGVYg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=cu9vVIT5I2Xk//UoE8klakMY3TLFw1cWp5SJCWUXLDq5G2sTlaJ20oYCN5QkZYi6s
	 o1oJFqtF0RVtUYTaLb5nY7BV9txM8BJ++DHZwiHkm+i+io6uKd+DvNw2k9oazknbq7
	 kQUkDZw+uaQO+AQjufOAd2ge5EMyMTzDsOfU4KRg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732592AbfKHS4k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 13:56:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:54222 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732476AbfKHS4f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 13:56:35 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 422462178F;
        Fri,  8 Nov 2019 18:56:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573239394;
        bh=qUcFqg4z4RqZDCWvaRajjLuuMCMBmoZryKmlMQxGVYg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZtHZqRfaKFY3y8tP6xku1VTcCQq4Nq0lk+iBZP3BDJNBbm5fPdcMcXxKBXfUVpGU5
         ktm7LmGvQq8zF1itfOz6kmy0X63rKsDS4GMC03ZIHcU8Lj8Z36uDXw04gj2LQqK5Gt
         OksjGEv3xDIlwb90Cbdosz3pW3m9WAO3avHlPz4Y=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Doug Berger <opendmb@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.9 25/34] net: bcmgenet: reset 40nm EPHY on energy detect
Date:   Fri,  8 Nov 2019 19:50:32 +0100
Message-Id: <20191108174645.891678120@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191108174618.266472504@linuxfoundation.org>
References: <20191108174618.266472504@linuxfoundation.org>
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
 drivers/net/ethernet/broadcom/genet/bcmgenet.c |    9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

--- a/drivers/net/ethernet/broadcom/genet/bcmgenet.c
+++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
@@ -1914,6 +1914,8 @@ static void bcmgenet_link_intr_enable(st
 	 */
 	if (priv->internal_phy) {
 		int0_enable |= UMAC_IRQ_LINK_EVENT;
+		if (GENET_IS_V1(priv) || GENET_IS_V2(priv) || GENET_IS_V3(priv))
+			int0_enable |= UMAC_IRQ_PHY_DET_R;
 	} else if (priv->ext_phy) {
 		int0_enable |= UMAC_IRQ_LINK_EVENT;
 	} else if (priv->phy_interface == PHY_INTERFACE_MODE_MOCA) {
@@ -2531,6 +2533,10 @@ static void bcmgenet_irq_task(struct wor
 		bcmgenet_power_up(priv, GENET_POWER_WOL_MAGIC);
 	}
 
+	if (status & UMAC_IRQ_PHY_DET_R &&
+	    priv->dev->phydev->autoneg != AUTONEG_ENABLE)
+		phy_init_hw(priv->dev->phydev);
+
 	/* Link UP/DOWN event */
 	if (status & UMAC_IRQ_LINK_EVENT)
 		phy_mac_interrupt(priv->phydev,
@@ -2627,8 +2633,7 @@ static irqreturn_t bcmgenet_isr0(int irq
 	}
 
 	/* all other interested interrupts handled in bottom half */
-	status &= (UMAC_IRQ_LINK_EVENT |
-		   UMAC_IRQ_MPD_R);
+	status &= (UMAC_IRQ_LINK_EVENT | UMAC_IRQ_MPD_R | UMAC_IRQ_PHY_DET_R);
 	if (status) {
 		/* Save irq status for bottom-half processing. */
 		spin_lock_irqsave(&priv->lock, flags);


