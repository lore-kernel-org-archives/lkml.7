Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14212C43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 11:45:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D23C021670
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 11:45:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556624727;
	bh=S53BebHbGSeIxthhUe6WhoXyIFqrlIj9nmyLSVbw1UI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=H5fvkCl0VWcR+qklCB+xz/FGIpned1fcSOmW+Snr5b9/+TBGiIo0JZ68c3dIsFY8Q
	 CgmwYKqNda1SqH64EcVRsDYTRm6+04nIvoLq5ZsMJ2c08cKuJvAaJ0vMTsl29VUtc5
	 Ly5UHaWJ+k1v21ipkCWAIkIZb78xwzPZOeUsU3UU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730396AbfD3Lp0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 07:45:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:57590 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730381AbfD3LpY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 07:45:24 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 70D7021670;
        Tue, 30 Apr 2019 11:45:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556624723;
        bh=S53BebHbGSeIxthhUe6WhoXyIFqrlIj9nmyLSVbw1UI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YNaHGGhG6IlKRZT9JBKK7ZZhFwmLynruoymVJErSR0yAtLQTbuhSu6bMsAa3Y50z1
         ULv4ZD1t0YrWFbORPdhMb2/MDBFS6C2cKWoMbP2DbX9fWf0YrXrcvEoR3qIa23FgcE
         Jq7QsWNu3CVFmkA/uJyirn1Utcl2RGJrG4yF6l0M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 013/100] net: mvpp2: fix validate for PPv2.1
Date:   Tue, 30 Apr 2019 13:37:42 +0200
Message-Id: <20190430113609.226045703@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190430113608.616903219@linuxfoundation.org>
References: <20190430113608.616903219@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 8b318f30ab4ef9bbc1241e6f8c1db366dbd347f2 ]

The Phylink validate function is the Marvell PPv2 driver makes a check
on the GoP id. This is valid an has to be done when using PPv2.2 engines
but makes no sense when using PPv2.1. The check done when using an RGMII
interface makes sure the GoP id is not 0, but this breaks PPv2.1. Fixes
it.

Fixes: 0fb628f0f250 ("net: mvpp2: fix phylink handling of invalid PHY modes")
Signed-off-by: Antoine Tenart <antoine.tenart@bootlin.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
index 9988c89ed9fd..9b10abb604cb 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
@@ -4272,7 +4272,7 @@ static void mvpp2_phylink_validate(struct net_device *dev,
 	case PHY_INTERFACE_MODE_RGMII_ID:
 	case PHY_INTERFACE_MODE_RGMII_RXID:
 	case PHY_INTERFACE_MODE_RGMII_TXID:
-		if (port->gop_id == 0)
+		if (port->priv->hw_version == MVPP22 && port->gop_id == 0)
 			goto empty_set;
 		break;
 	default:
-- 
2.19.1



