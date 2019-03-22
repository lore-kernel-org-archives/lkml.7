Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 456F3C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:45:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03603218E2
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:45:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553258758;
	bh=1AY8tnWhdVNkTs7FRfBfGY7EwiIQieqjyMY6W8FeaP0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qesZlr3fmHKKXIDEB2EZ57YBBV74ccdpzQZ7cRjunk7KOMsMJ+EOnOcKYokWpJqIR
	 +PVyTRvmp3aMUV7C6Y/qZRf7jV3++1FNev5W+s4tCWry9NXFXDEhjE1O6BHI0Hr5x0
	 TmCDRAH9zSzlZFM0XuDt/qf9Z6nTC2/lCB24CckM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388029AbfCVMAE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 08:00:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:37122 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729875AbfCVMAD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 08:00:03 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E85F721934;
        Fri, 22 Mar 2019 12:00:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553256002;
        bh=1AY8tnWhdVNkTs7FRfBfGY7EwiIQieqjyMY6W8FeaP0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QVUNE41QgiBtXnE5ddhHFJIjvmQa93UdM5WrWASGo6rb3kyYRQxg5dTjSiYFfR8Qz
         r4FMRYJMnJeoQDcnuvGZRI7MG8RDCJAsIjYjUxrKqRou1wWmeDh3A1LC0WGWrsWzFV
         R7x2ndZ5NTMt9MqUE3em9k5Pp8ez/nFyzYfHCMFo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 079/280] net: systemport: Fix reception of BPDUs
Date:   Fri, 22 Mar 2019 12:13:52 +0100
Message-Id: <20190322111310.808447095@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111306.356185024@linuxfoundation.org>
References: <20190322111306.356185024@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

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
index fc16b2b0d0e9..0bdbc72605e1 100644
--- a/drivers/net/ethernet/broadcom/bcmsysport.c
+++ b/drivers/net/ethernet/broadcom/bcmsysport.c
@@ -134,6 +134,10 @@ static int bcm_sysport_set_rx_csum(struct net_device *dev,
 
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



