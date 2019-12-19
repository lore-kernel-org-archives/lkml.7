Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD2E3C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 19:08:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76F15222C2
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 19:08:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576782539;
	bh=TsvhNeAS7QpjrVGbREBFkeHb/CNC3NqL0b7YAKujFZ4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=J30KpnEOBesMq6SfUUF9HsWmgcH2j01KUo76eqZvEkDo4/x+/9T3iQ1NnU+PkeW8f
	 aUnol643noegDZHMsEnl2Dg6BY3Jk9WYd0EiBKM3P1/b1F9wtWFoXPqR6a+rg1qxWZ
	 npzff2saK9fB21dgVWaNWOg8C0qJ7LDzaXta/qlA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728507AbfLSSlR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 13:41:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:60188 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728493AbfLSSlN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 13:41:13 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 89EA6206D7;
        Thu, 19 Dec 2019 18:41:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576780873;
        bh=TsvhNeAS7QpjrVGbREBFkeHb/CNC3NqL0b7YAKujFZ4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=V0wQghgzG+ML5tFxcXHoeug07yUTGDNOkJE0jcxdNclnnNonlFpJElZuiJZ8Q3W/t
         0c2htEgZF2r920JaksdscKgi3NnGHfRiMn3XkZTJXCgHXc0jmYGXlJ1rNWRrK+dzaC
         vx4Q2CmA3bTfxusxVtqPW9n8QyVS25QnldOKeU6I=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.4 150/162] net: ethernet: ti: cpsw: fix extra rx interrupt
Date:   Thu, 19 Dec 2019 19:34:18 +0100
Message-Id: <20191219183216.904800822@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191219183150.477687052@linuxfoundation.org>
References: <20191219183150.477687052@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Grygorii Strashko <grygorii.strashko@ti.com>

[ Upstream commit 51302f77bedab8768b761ed1899c08f89af9e4e2 ]

Now RX interrupt is triggered twice every time, because in
cpsw_rx_interrupt() it is asked first and then disabled. So there will be
pending interrupt always, when RX interrupt is enabled again in NAPI
handler.

Fix it by first disabling IRQ and then do ask.

Fixes: 870915feabdc ("drivers: net: cpsw: remove disable_irq/enable_irq as irq can be masked from cpsw itself")
Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/ti/cpsw.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/ethernet/ti/cpsw.c
+++ b/drivers/net/ethernet/ti/cpsw.c
@@ -777,8 +777,8 @@ static irqreturn_t cpsw_rx_interrupt(int
 {
 	struct cpsw_priv *priv = dev_id;
 
-	cpdma_ctlr_eoi(priv->dma, CPDMA_EOI_RX);
 	writel(0, &priv->wr_regs->rx_en);
+	cpdma_ctlr_eoi(priv->dma, CPDMA_EOI_RX);
 
 	if (priv->quirk_irq) {
 		disable_irq_nosync(priv->irqs_table[0]);


