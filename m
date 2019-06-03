Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB58DC28CC6
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 09:11:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8A5727E57
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 09:11:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559553083;
	bh=PD4CptU2Vt4m1JwNNMcDEx3asmgxekhmtKo8ZN4gv3Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zZTUSqoxsOCGfD7Y0XA+OiGRhNerTrb/aXrC3Ma2DQYPoPqx3wjjoQExi42SSG34k
	 P12YinqEe7YD4IwfCzEXx4AfFyjKDiu9fywgtysF6+N6BcFLUAHYLiX4AAM1pioTcy
	 ufcOkHLVuLclEr8+P6p2R1KibVk3FC1cRk6ysMK0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728376AbfFCJLX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 05:11:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:56348 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727795AbfFCJLU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 05:11:20 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A47B127E5D;
        Mon,  3 Jun 2019 09:11:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559553080;
        bh=PD4CptU2Vt4m1JwNNMcDEx3asmgxekhmtKo8ZN4gv3Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GIXgsLg9W4qfjdwK5MezGrfgsi/tRUXFyRug7/v0HX2R6jDrA0+gkx8zKEAumtxR6
         y+Cnseq94idpfJzjr0Z1x1+HDPFo/VeW5dDk6YLQabzlvfcCFdvpOgmDBK813r48rz
         IarXWGNdiVF+Ff4IAcUTGrrCkNxAqKnHSXdW/EC0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Jisheng Zhang <Jisheng.Zhang@synaptics.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.0 13/36] net: mvneta: Fix err code path of probe
Date:   Mon,  3 Jun 2019 11:09:01 +0200
Message-Id: <20190603090521.834779449@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190603090520.998342694@linuxfoundation.org>
References: <20190603090520.998342694@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jisheng Zhang <Jisheng.Zhang@synaptics.com>

[ Upstream commit d484e06e25ebb937d841dac02ac1fe76ec7d4ddd ]

Fix below issues in err code path of probe:
1. we don't need to unregister_netdev() because the netdev isn't
registered.
2. when register_netdev() fails, we also need to destroy bm pool for
HWBM case.

Fixes: dc35a10f68d3 ("net: mvneta: bm: add support for hardware buffer management")
Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/marvell/mvneta.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

--- a/drivers/net/ethernet/marvell/mvneta.c
+++ b/drivers/net/ethernet/marvell/mvneta.c
@@ -4619,7 +4619,7 @@ static int mvneta_probe(struct platform_
 	err = register_netdev(dev);
 	if (err < 0) {
 		dev_err(&pdev->dev, "failed to register\n");
-		goto err_free_stats;
+		goto err_netdev;
 	}
 
 	netdev_info(dev, "Using %s mac address %pM\n", mac_from,
@@ -4630,14 +4630,12 @@ static int mvneta_probe(struct platform_
 	return 0;
 
 err_netdev:
-	unregister_netdev(dev);
 	if (pp->bm_priv) {
 		mvneta_bm_pool_destroy(pp->bm_priv, pp->pool_long, 1 << pp->id);
 		mvneta_bm_pool_destroy(pp->bm_priv, pp->pool_short,
 				       1 << pp->id);
 		mvneta_bm_put(pp->bm_priv);
 	}
-err_free_stats:
 	free_percpu(pp->stats);
 err_free_ports:
 	free_percpu(pp->ports);


