Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60D20C282DD
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 20:59:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2962C2087F
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 20:59:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578430795;
	bh=f7riSQYSD9dq6KDWq8/8Vox2o1Mmr7zZUlnn9T8PxII=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=aSANg5xGqp2CZDb17v9eRRnxdL9zQBU8cji+aFxYo4rS5u62etuVeh5iRkzInL4ln
	 u38wnaJnnqmgxpEwImAHj8STRtVea3qZYWWJtSxXSjjddURyucQaG7bC+gUIWPcl2m
	 YF0lP3CAshqoWYMFHdx3wQ9OyZDzobBWREBZkv2o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727545AbgAGU7y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 15:59:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:33496 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728199AbgAGU7v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 15:59:51 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EEBDC2081E;
        Tue,  7 Jan 2020 20:59:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578430790;
        bh=f7riSQYSD9dq6KDWq8/8Vox2o1Mmr7zZUlnn9T8PxII=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AIt/TUtjmakvnriexr/RkdxsQ41PVFPbCepvVufgRW/lw2NKaYc+to8rIe3slsRcI
         QZfrOttrcfaCqpL6Hj3YfMUaneowi5BrLxub2bdsMgZqnYybD0Pueq9Hu880/XI+46
         JmuPUnn2rhZ9z6/8T+JZQdpc/YH47oLYIELRnjJg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>,
        Vinod Koul <vkoul@kernel.org>
Subject: [PATCH 5.4 098/191] dmaengine: dma-jz4780: Also break descriptor chains on JZ4725B
Date:   Tue,  7 Jan 2020 21:53:38 +0100
Message-Id: <20200107205338.236147396@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200107205332.984228665@linuxfoundation.org>
References: <20200107205332.984228665@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paul Cercueil <paul@crapouillou.net>

commit a40c94be2336f3002563c9ae16572143ae3422e2 upstream.

It turns out that the JZ4725B displays the same buggy behaviour as the
JZ4740 that was described in commit f4c255f1a747 ("dmaengine: dma-jz4780:
Break descriptor chains on JZ4740").

Work around it by using the same workaround previously used for the
JZ4740.

Fixes commit f4c255f1a747 ("dmaengine: dma-jz4780: Break descriptor
chains on JZ4740")

Cc: <stable@vger.kernel.org>
Signed-off-by: Paul Cercueil <paul@crapouillou.net>
Link: https://lore.kernel.org/r/20191210165545.59690-1-paul@crapouillou.net
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/dma/dma-jz4780.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/dma/dma-jz4780.c
+++ b/drivers/dma/dma-jz4780.c
@@ -1004,7 +1004,8 @@ static const struct jz4780_dma_soc_data
 static const struct jz4780_dma_soc_data jz4725b_dma_soc_data = {
 	.nb_channels = 6,
 	.transfer_ord_max = 5,
-	.flags = JZ_SOC_DATA_PER_CHAN_PM | JZ_SOC_DATA_NO_DCKES_DCKEC,
+	.flags = JZ_SOC_DATA_PER_CHAN_PM | JZ_SOC_DATA_NO_DCKES_DCKEC |
+		 JZ_SOC_DATA_BREAK_LINKS,
 };
 
 static const struct jz4780_dma_soc_data jz4770_dma_soc_data = {


