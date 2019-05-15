Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CCDCC04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 11:30:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06CE72084A
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 11:30:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557919850;
	bh=A5n4mTZtTb5EEfrTR3AlfarJ5yVRdt4gFPUi2LZqFk4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=yqMfqA+9IF2NSQIiinnEp5ryl79F5fVpXMdno67JOYbUG3A4iyVfNJ6Em5jph1aYR
	 tGZ15bK5D8kaUQWK322hj9oGaRgDgHSlqh7pGOQbxrgE2gyUfytmg0qzuU1g6BMM0h
	 hTmeRCOEtfXzKf3VKMrQ/eOIjArxCWC221WmzEUs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732787AbfEOLat (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 07:30:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:42308 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732766AbfEOLam (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 07:30:42 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 35A2820843;
        Wed, 15 May 2019 11:30:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557919841;
        bh=A5n4mTZtTb5EEfrTR3AlfarJ5yVRdt4gFPUi2LZqFk4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vO3RnjZYHACO5+TldRahTeO0EiRn9ACQodE0t6zNFSZTDidut5rOH9ymeLgEP0QF5
         KEwbLIwl2JDY8L+eZ7JBwz5DjiZph/pwyYqtOEXBREffXWh8sXlmN7uA8CnQ9Sm9+G
         50oKzH3E7G2uH6HwVIPG6aBDMnkYE+DBnDT26z+M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Thomas Bogendoerfer <tbogendoerfer@suse.de>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.0 113/137] net: seeq: fix crash caused by not set dev.parent
Date:   Wed, 15 May 2019 12:56:34 +0200
Message-Id: <20190515090701.794869633@linuxfoundation.org>
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

From: Thomas Bogendoerfer <tbogendoerfer@suse.de>

[ Upstream commit 5afcd14cfc7fed1bcc8abcee2cef82732772bfc2 ]

The old MIPS implementation of dma_cache_sync() didn't use the dev argument,
but commit c9eb6172c328 ("dma-mapping: turn dma_cache_sync into a
dma_map_ops method") changed that, so we now need to set dev.parent.

Signed-off-by: Thomas Bogendoerfer <tbogendoerfer@suse.de>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/seeq/sgiseeq.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/net/ethernet/seeq/sgiseeq.c
+++ b/drivers/net/ethernet/seeq/sgiseeq.c
@@ -735,6 +735,7 @@ static int sgiseeq_probe(struct platform
 	}
 
 	platform_set_drvdata(pdev, dev);
+	SET_NETDEV_DEV(dev, &pdev->dev);
 	sp = netdev_priv(dev);
 
 	/* Make private data page aligned */


