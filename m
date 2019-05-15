Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2E51C04E84
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 11:28:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 678902084A
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 11:28:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557919695;
	bh=PczNOFJktXN3VBGMmm6fxJmj8u3wVCD0yPxlwkl9P4Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=FP/rKP2cb36siaKn1MQIW2n75Hvgp9sXg0lrgJNwLqDf2Gsrhownx+nXVYEer5e3X
	 OoAo6vmeEh2yGQyJSLmWbWyco8pPmxFVx3yxr5IVpp5miMYRGotrDKMQTj0vQ9peRS
	 JvWw9g+h1HgRsj7ZMLC2dHdp+kwuhp/DXi3C2cXQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732358AbfEOL2O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 07:28:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:39142 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731652AbfEOL2J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 07:28:09 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 40C172168B;
        Wed, 15 May 2019 11:28:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557919688;
        bh=PczNOFJktXN3VBGMmm6fxJmj8u3wVCD0yPxlwkl9P4Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ducOcRVgfBLvaiCceH0eqda57oHj2JB7FfVmvKW1XNXKxTdLYlyAdd+xqf1+TDjYV
         soEnzngMSjXkVKYmZmI7vHRMO8WnZxYtIkJuPHZHcP5gou6+0Os+uStG78i8shmi6s
         YqRkR/TBIcre3QQt8Ic+afCATrM3aM3jZuInEBIU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Claudiu Manoil <claudiu.manoil@nxp.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.0 056/137] ocelot: Dont sleep in atomic context (irqs_disabled())
Date:   Wed, 15 May 2019 12:55:37 +0200
Message-Id: <20190515090657.560828436@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190515090651.633556783@linuxfoundation.org>
References: <20190515090651.633556783@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit a8fd48b50deaa20808bbf0f6685f6f1acba6a64c ]

Preemption disabled at:
 [<ffff000008cabd54>] dev_set_rx_mode+0x1c/0x38
 Call trace:
 [<ffff00000808a5c0>] dump_backtrace+0x0/0x3d0
 [<ffff00000808a9a4>] show_stack+0x14/0x20
 [<ffff000008e6c0c0>] dump_stack+0xac/0xe4
 [<ffff0000080fe76c>] ___might_sleep+0x164/0x238
 [<ffff0000080fe890>] __might_sleep+0x50/0x88
 [<ffff0000082261e4>] kmem_cache_alloc+0x17c/0x1d0
 [<ffff000000ea0ae8>] ocelot_set_rx_mode+0x108/0x188 [mscc_ocelot_common]
 [<ffff000008cabcf0>] __dev_set_rx_mode+0x58/0xa0
 [<ffff000008cabd5c>] dev_set_rx_mode+0x24/0x38

Fixes: a556c76adc05 ("net: mscc: Add initial Ocelot switch support")

Signed-off-by: Claudiu Manoil <claudiu.manoil@nxp.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/mscc/ocelot.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mscc/ocelot.c b/drivers/net/ethernet/mscc/ocelot.c
index 215a45374d7b0..0ef95abde6bb0 100644
--- a/drivers/net/ethernet/mscc/ocelot.c
+++ b/drivers/net/ethernet/mscc/ocelot.c
@@ -613,7 +613,7 @@ static int ocelot_mact_mc_add(struct ocelot_port *port,
 			      struct netdev_hw_addr *hw_addr)
 {
 	struct ocelot *ocelot = port->ocelot;
-	struct netdev_hw_addr *ha = kzalloc(sizeof(*ha), GFP_KERNEL);
+	struct netdev_hw_addr *ha = kzalloc(sizeof(*ha), GFP_ATOMIC);
 
 	if (!ha)
 		return -ENOMEM;
-- 
2.20.1



