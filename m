Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E657C04A6B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 14:37:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F28B21479
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 14:37:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557153425;
	bh=rLDf/z599L+TxF1cg/rwNNt0iqybU0xScUBZmXOil6A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=HEfXRc8dyg2FVxT3PSKWVRn6iOfqQdydSsZyofbm32Y8rvPjgBFMdOgaAlWZY3T6D
	 vewmUpnxwtq25ihMLG7fZ/VwxWNpQUYhVtTH79J1GEvvBuJCVff7nuuJOFNbBSFqfm
	 mvGlW57orhCec3cNIibJgwwOn78BzElCI7kFtLGQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727317AbfEFOhE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 10:37:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:57596 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727291AbfEFOhC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 10:37:02 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 47F49206A3;
        Mon,  6 May 2019 14:37:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557153421;
        bh=rLDf/z599L+TxF1cg/rwNNt0iqybU0xScUBZmXOil6A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=q5VXfRvNZhuykYh2ikc+ZKwpZ+Or7MkpIKsUMTQLlxKYW1Ry+EckhJGaP5tj+j/RM
         AQYHKyqFohPRKfrHgO/iCYtJlawVvxnL8yub5GlvkTDdMLfmAY7rhPtqXBqVNbml9d
         4pFkqfumNpbLizuQZvUpcdnq5ScDPjIaWotN1rh0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Stefan Assmann <sassmann@kpanic.de>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        "Sasha Levin (Microsoft)" <sashal@kernel.org>
Subject: [PATCH 5.0 042/122] i40e: fix WoL support check
Date:   Mon,  6 May 2019 16:31:40 +0200
Message-Id: <20190506143058.693436013@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190506143054.670334917@linuxfoundation.org>
References: <20190506143054.670334917@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit f669d24f3dd00beab452c0fc9257f6a942ffca9b ]

The current check for WoL on i40e is broken. Code comment says only
magic packet is supported, so only check for that.

Fixes: 540a152da762 (i40e/ixgbe/igb: fail on new WoL flag setting WAKE_MAGICSECURE)

Signed-off-by: Stefan Assmann <sassmann@kpanic.de>
Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Signed-off-by: Sasha Levin (Microsoft) <sashal@kernel.org>
---
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
index a6bc7847346b..5d544e661445 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
@@ -2378,8 +2378,7 @@ static int i40e_set_wol(struct net_device *netdev, struct ethtool_wolinfo *wol)
 		return -EOPNOTSUPP;
 
 	/* only magic packet is supported */
-	if (wol->wolopts && (wol->wolopts != WAKE_MAGIC)
-			  | (wol->wolopts != WAKE_FILTER))
+	if (wol->wolopts & ~WAKE_MAGIC)
 		return -EOPNOTSUPP;
 
 	/* is this a new value? */
-- 
2.20.1



