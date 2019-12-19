Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6384FC43603
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 18:59:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29D24206EC
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 18:59:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576781999;
	bh=smHb2yJslfRp7JzvVGL6X+y/C/ALUdM8xW4zzojIxAU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Wq85dYwaEmj/FBW1AmdygFO2PCn016kbxgKBqIHPk/ohqF1Dngpl1RFCpsfCIQiRq
	 cqTcTuQjRezDxlCWClwM0tuexXwaOodruc6VbSbVorE5Kg3UCFAb20dU3Gz07nUuXK
	 LUrXrXubLe10DeioiK3prEpc3AMTTjMAA3fsoMWI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730396AbfLSS75 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 13:59:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:47374 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730279AbfLSSwm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 13:52:42 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 304EA227BF;
        Thu, 19 Dec 2019 18:52:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576781561;
        bh=smHb2yJslfRp7JzvVGL6X+y/C/ALUdM8xW4zzojIxAU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SWL4DoTEyr4qu7mJL72S6ltkdAS0MhVBnfvOWRsmRAsrhbGe8gknDvLKg3GKaeZn3
         XeaZT8R6yIQtlijTz9M5lNCG+xxjD9pg3SldZf1UtUduagZc8V7xZx46JcCFdX+Wqp
         r+2dLBPAexIHJtVvd5qH2RDOpTJ/s0QMJ/cYrTpw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mian Yousaf Kaukab <ykaukab@suse.de>,
        Andrew Lunn <andrew@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.19 07/47] net: thunderx: start phy before starting autonegotiation
Date:   Thu, 19 Dec 2019 19:34:21 +0100
Message-Id: <20191219182902.771900337@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191219182857.659088743@linuxfoundation.org>
References: <20191219182857.659088743@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mian Yousaf Kaukab <ykaukab@suse.de>

[ Upstream commit a350d2e7adbb57181d33e3aa6f0565632747feaa ]

Since commit 2b3e88ea6528 ("net: phy: improve phy state checking")
phy_start_aneg() expects phy state to be >= PHY_UP. Call phy_start()
before calling phy_start_aneg() during probe so that autonegotiation
is initiated.

As phy_start() takes care of calling phy_start_aneg(), drop the explicit
call to phy_start_aneg().

Network fails without this patch on Octeon TX.

Fixes: 2b3e88ea6528 ("net: phy: improve phy state checking")
Signed-off-by: Mian Yousaf Kaukab <ykaukab@suse.de>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/cavium/thunder/thunder_bgx.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/ethernet/cavium/thunder/thunder_bgx.c
+++ b/drivers/net/ethernet/cavium/thunder/thunder_bgx.c
@@ -1118,7 +1118,7 @@ static int bgx_lmac_enable(struct bgx *b
 				       phy_interface_mode(lmac->lmac_type)))
 			return -ENODEV;
 
-		phy_start_aneg(lmac->phydev);
+		phy_start(lmac->phydev);
 		return 0;
 	}
 


