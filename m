Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81EECC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:35:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FABB2183E
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:35:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553254544;
	bh=/VHEmSXJH5EWDWyB4njcj71Ii8FB504e/hjraB1uXU8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gPawnTD7nPTwvPQHobI1yTvwnFrBS+Lq5LcrT9yMjc4/1/7TuTI1yyCtOTLHu/qnT
	 cZyWapOPZUlMTgfQ0PP3Rtw6j30t3zXwG3EymsSnER1iHO4ZYjorqSEVJP5gbw8eRr
	 0KARKN28lPwflRiLYPavg5ZiN2qldIJw57+XqnXM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730045AbfCVLfn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 07:35:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:36556 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730012AbfCVLfh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 07:35:37 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0AE04218B0;
        Fri, 22 Mar 2019 11:35:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553254536;
        bh=/VHEmSXJH5EWDWyB4njcj71Ii8FB504e/hjraB1uXU8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=D4maTIWNP804DFeV2kzP7K3xq+mWGPag8c7NUa53XjSJQjP2W4Zk1v6h1iOJ9iYXE
         7kIDYY1IzoFBeZhsRz4iVbAhUaPGgl3fEAo4u9VSUH7ycAcIoy8cyxNRhMGbmHBXct
         XS+ggPd4LU75PHVzNmyzdynBM/ZYbNyIHSJ2avZI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 166/230] net: systemport: Fix reception of BPDUs
Date:   Fri, 22 Mar 2019 12:15:04 +0100
Message-Id: <20190322111248.382124788@linuxfoundation.org>
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

[ Upstream commit a40061ea2e39494104602b3048751341bda374a1 ]

SYSTEMPORT has its RXCHK parser block that attempts to validate the
packet structures, unfortunately setting the L2 header check bit will
cause Bridge PDUs (BPDUs) to be incorrectly rejected because they look
like LLC/SNAP packets with a non-IPv4 or non-IPv6 Ethernet Type.

Fixes: 4e8aedfe78c7 ("net: systemport: Turn on offloads by default")
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/broadcom/bcmsysport.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/broadcom/bcmsysport.c b/drivers/net/ethernet/broadcom/bcmsysport.c
index 143b9a384af8..53b3c1a5851c 100644
--- a/drivers/net/ethernet/broadcom/bcmsysport.c
+++ b/drivers/net/ethernet/broadcom/bcmsysport.c
@@ -126,6 +126,10 @@ static int bcm_sysport_set_rx_csum(struct net_device *dev,
 
 	priv->rx_chk_en = !!(wanted & NETIF_F_RXCSUM);
 	reg = rxchk_readl(priv, RXCHK_CONTROL);
+	/* Clear L2 header checks, which would prevent BPDUs
+	 * from being received.
+	 */
+	reg &= ~RXCHK_L2_HDR_DIS;
 	if (priv->rx_chk_en)
 		reg |= RXCHK_EN;
 	else
-- 
2.19.1



