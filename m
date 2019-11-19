Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D157C432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 05:21:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55DEC2231C
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 05:21:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574140864;
	bh=RqNSZ4ShTGo3Yr+zq9uP/VvURI8M9/4ycc+vUOEsjo4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rHmY27GXaSnMlLwq+71WhAqo8YsAR4HcXsmLft7wj1djWlA6pviJ33YBywzRuT9Nx
	 zux38YrzMO+LNljU/iKHuyHUhmO9acpEZKntVUdRM6d8AJjS+h22g5bLJb5+1KsevH
	 gxV1qXBt4DJXr5O1u/cp/l0emxDpFOOVYjx4aAHI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727135AbfKSFVD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 00:21:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:35464 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727099AbfKSFVA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 00:21:00 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 79F1722317;
        Tue, 19 Nov 2019 05:20:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574140860;
        bh=RqNSZ4ShTGo3Yr+zq9uP/VvURI8M9/4ycc+vUOEsjo4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=e780kXj38jWDdm0fGqYyr23LKEHqfQY64wd0WFQC5WrrkjuisesAMG9Mx0HuJyiyP
         ciRIiS0wWfx8zamuPYzvQfTbIH31XVrnkMkyP1JtbAfVng5XzXOt+5bhjCuCSzoHyy
         BYMwapAZng8H9OedbtXY+yVeTrYBXe53NvPsJXWk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ioana Ciornei <ioana.ciornei@nxp.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.3 11/48] dpaa2-eth: free already allocated channels on probe defer
Date:   Tue, 19 Nov 2019 06:19:31 +0100
Message-Id: <20191119050957.779532912@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191119050946.745015350@linuxfoundation.org>
References: <20191119050946.745015350@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ioana Ciornei <ioana.ciornei@nxp.com>

[ Upstream commit 5aa4277d4368c099223bbcd3a9086f3351a12ce9 ]

The setup_dpio() function tries to allocate a number of channels equal
to the number of CPUs online. When there are not enough DPCON objects
already probed, the function will return EPROBE_DEFER. When this
happens, the already allocated channels are not freed. This results in
the incapacity of properly probing the next time around.
Fix this by freeing the channels on the error path.

Fixes: d7f5a9d89a55 ("dpaa2-eth: defer probe on object allocate")
Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c |   10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

--- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c
+++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c
@@ -2166,8 +2166,16 @@ err_set_cdan:
 err_service_reg:
 	free_channel(priv, channel);
 err_alloc_ch:
-	if (err == -EPROBE_DEFER)
+	if (err == -EPROBE_DEFER) {
+		for (i = 0; i < priv->num_channels; i++) {
+			channel = priv->channel[i];
+			nctx = &channel->nctx;
+			dpaa2_io_service_deregister(channel->dpio, nctx, dev);
+			free_channel(priv, channel);
+		}
+		priv->num_channels = 0;
 		return err;
+	}
 
 	if (cpumask_empty(&priv->dpio_cpumask)) {
 		dev_err(dev, "No cpu with an affine DPIO/DPCON\n");


