Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6541C04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 11:32:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FC4B20818
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 11:32:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557919964;
	bh=HZn80yW1KMV5AsYLespaT2hnbht7qg6UOiGB/yOZGmI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=p/uH7xxWk1cDd5fQqgnfElBCemv67xx0oa32FfFBZgAv6N6qjkLyiTOCBjviP+VEK
	 DVqWQ6L7PnoMw4rCYuEs9hBCXS/pjzhFOeuItLLfUjRAgEr268RiY1FwybgLO+3ZQp
	 9dGXxG/yJAsWk/QaXsvyL76U/l7YjKSFU+T1bikw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733071AbfEOLcn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 07:32:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:44532 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733038AbfEOLcl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 07:32:41 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0AD202053B;
        Wed, 15 May 2019 11:32:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557919960;
        bh=HZn80yW1KMV5AsYLespaT2hnbht7qg6UOiGB/yOZGmI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dOwzZ/5Fz13c2EOmyZHqgxfJvYYI5/TXf1Wdi+nmFdK/SAJN6CJc8hfjj1Hn44vyy
         /jIKZydNFy+bFui/xZPH1uVc/jcMTItR7Y5GYnh1ToZuLsV7y0qQ1xgBkRIm6IkUVK
         bFaqujxOPMEb/zsuhTolCuv4FoXijH8pTmGq+UYw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Harini Katakam <harini.katakam@xilinx.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.1 21/46] net: macb: Change interrupt and napi enable order in open
Date:   Wed, 15 May 2019 12:56:45 +0200
Message-Id: <20190515090624.035657060@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190515090616.670410738@linuxfoundation.org>
References: <20190515090616.670410738@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Harini Katakam <harini.katakam@xilinx.com>

[ Upstream commit 0504453139ef5a593c9587e1e851febee859c7d8 ]

Current order in open:
-> Enable interrupts (macb_init_hw)
-> Enable NAPI
-> Start PHY

Sequence of RX handling:
-> RX interrupt occurs
-> Interrupt is cleared and interrupt bits disabled in handler
-> NAPI is scheduled
-> In NAPI, RX budget is processed and RX interrupts are re-enabled

With the above, on QEMU or fixed link setups (where PHY state doesn't
matter), there's a chance macb RX interrupt occurs before NAPI is
enabled. This will result in NAPI being scheduled before it is enabled.
Fix this macb open by changing the order.

Fixes: ae1f2a56d273 ("net: macb: Added support for many RX queues")
Signed-off-by: Harini Katakam <harini.katakam@xilinx.com>
Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/cadence/macb_main.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -2461,12 +2461,12 @@ static int macb_open(struct net_device *
 		goto pm_exit;
 	}
 
-	bp->macbgem_ops.mog_init_rings(bp);
-	macb_init_hw(bp);
-
 	for (q = 0, queue = bp->queues; q < bp->num_queues; ++q, ++queue)
 		napi_enable(&queue->napi);
 
+	bp->macbgem_ops.mog_init_rings(bp);
+	macb_init_hw(bp);
+
 	/* schedule a link state check */
 	phy_start(dev->phydev);
 


