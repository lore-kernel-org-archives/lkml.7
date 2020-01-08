Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96BDEC00523
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 07:08:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52FA320692
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 07:08:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="DgXVQrea"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726598AbgAHHI3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 02:08:29 -0500
Received: from gateway31.websitewelcome.com ([192.185.143.40]:15769 "EHLO
        gateway31.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726079AbgAHHI2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 02:08:28 -0500
X-Greylist: delayed 1500 seconds by postgrey-1.27 at vger.kernel.org; Wed, 08 Jan 2020 02:08:28 EST
Received: from cm13.websitewelcome.com (cm13.websitewelcome.com [100.42.49.6])
        by gateway31.websitewelcome.com (Postfix) with ESMTP id 0A3FA247F5
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jan 2020 00:19:55 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id p4h9iQKS33Qi0p4h9iDq0b; Wed, 08 Jan 2020 00:19:55 -0600
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Type:MIME-Version:Message-ID:Subject:
        Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=UB0pNY3t0e/gnEfmmzpDKqL3cM/QaZd+sLLuuXXQRCw=; b=DgXVQrea59DMowvFywLtqiIdEn
        jyTyhiU+O8aCWP6jUswjqs8C1J9HyUhyjeXAumydC54/lCXNyxRx6nblE1EF/o/TIyCvp3sY8i9tQ
        WMC9zXm8QBurtar4MkcdjtIQLu/5JjUOrac/Sst+PR+PeLxCXEZQGIEaCW8keA2QVF2b+gYtjWyq6
        XQBKD576Jd3N0h+Bd8sh98oYeXw+KoL0w6Ig6R+mbalECvDvCFTQaiP79CSk/pSL9+YH/tYUKIeoM
        jq3RbpU8AC7H0RafpZeEnfpXb//wkqjmwFdMvx+oU4dRKK+sGZZ6JEsEEEQRevR0DGIH763sTmoUb
        89kFPttw==;
Received: from [189.152.215.240] (port=53698 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.92)
        (envelope-from <gustavo@embeddedor.com>)
        id 1ip4h7-002N98-Fw; Wed, 08 Jan 2020 00:19:53 -0600
Date:   Wed, 8 Jan 2020 00:21:51 -0600
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Claudiu Manoil <claudiu.manoil@nxp.com>,
        "David S. Miller" <davem@davemloft.net>,
        Vladimir Oltean <vladimir.oltean@nxp.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH net-next] enetc: enetc_pci_mdio: Fix inconsistent IS_ERR and
 PTR_ERR
Message-ID: <20200108062151.GA2614@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.152.215.240
X-Source-L: No
X-Exim-ID: 1ip4h7-002N98-Fw
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.152.215.240]:53698
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 5
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix inconsistent IS_ERR and PTR_ERR in enetc_pci_mdio_probe().

The proper pointer to be passed as argument is hw.

This bug was detected with the help of Coccinelle.

Fixes: 6517798dd343 ("enetc: Make MDIO accessors more generic and export to include/linux/fsl")
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/net/ethernet/freescale/enetc/enetc_pci_mdio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pci_mdio.c b/drivers/net/ethernet/freescale/enetc/enetc_pci_mdio.c
index 87c0e969da40..ebc635f8a4cc 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pci_mdio.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pci_mdio.c
@@ -27,7 +27,7 @@ static int enetc_pci_mdio_probe(struct pci_dev *pdev,
 	}
 
 	hw = enetc_hw_alloc(dev, port_regs);
-	if (IS_ERR(enetc_hw_alloc)) {
+	if (IS_ERR(hw)) {
 		err = PTR_ERR(hw);
 		goto err_hw_alloc;
 	}
-- 
2.23.0

