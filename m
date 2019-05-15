Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4751AC04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 11:52:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F20B2053B
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 11:52:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557921130;
	bh=4JxzwN2a1o2kg6uRsp45EYLhVpN8h3hrHMF1ffUAT0U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=LnjQJnWmbTdhohraCDaEQ72d/eqML6zjNMm7gfWwKq0pUn8jffj909DWaZfle7odG
	 CmufkwTqXGlaKcwE/GoVRnAl6KPBJ8y3eqhBgYOPgj/z0WUSsG6eF8BldC7/4ohwwK
	 Snk/zfRA4vBGrvzhxhRBAM+J9QmLKUn+OPUfZb08=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731460AbfEOLwI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 07:52:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:58626 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731140AbfEOLUq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 07:20:46 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7D9D5206BF;
        Wed, 15 May 2019 11:20:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557919246;
        bh=4JxzwN2a1o2kg6uRsp45EYLhVpN8h3hrHMF1ffUAT0U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hoPADSxIKCr9IOBARk+Zi7TK3vdtDuhqYAFaxZ1fmUVzttXr6bslunWbHuerHYFN/
         NJFRfZp0VdKM6izVpTCtx33+T8dzS3aBSYRo58ZQplIB0u+LySaWhtiMHN0E1zkymy
         QF3GTbmxv5EvouBM66WmQy7tfsfvQ5f6x3qi2dtM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Corentin Labbe <clabbe@baylibre.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 105/115] net: ethernet: stmmac: dwmac-sun8i: enable support of unicast filtering
Date:   Wed, 15 May 2019 12:56:25 +0200
Message-Id: <20190515090706.763684483@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190515090659.123121100@linuxfoundation.org>
References: <20190515090659.123121100@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Corentin Labbe <clabbe@baylibre.com>

[ Upstream commit d4c26eb6e721683a0f93e346ce55bc8dc3cbb175 ]

When adding more MAC addresses to a dwmac-sun8i interface, the device goes
directly in promiscuous mode.
This is due to IFF_UNICAST_FLT missing flag.

So since the hardware support unicast filtering, let's add IFF_UNICAST_FLT.

Fixes: 9f93ac8d4085 ("net-next: stmmac: Add dwmac-sun8i")
Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
@@ -858,6 +858,8 @@ static struct mac_device_info *sun8i_dwm
 	mac->mac = &sun8i_dwmac_ops;
 	mac->dma = &sun8i_dwmac_dma_ops;
 
+	priv->dev->priv_flags |= IFF_UNICAST_FLT;
+
 	/* The loopback bit seems to be re-set when link change
 	 * Simply mask it each time
 	 * Speed 10/100/1000 are set in BIT(2)/BIT(3)


