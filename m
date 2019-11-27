Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F0A6C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 21:26:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE3B221556
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 21:26:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574889966;
	bh=hiiQw4GIooAvk2r6v2UyMwi5UDbrlJKGpCYFPYlAAqM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=JLmEIeSwQcOeJpzIUkS9RvQDsOv1UM8s2EhjsIiFk/3SlF/MlsBJioGZZz/fJDo99
	 W8rtjhcRQesNqnLEg2e4+R8HANeYX/YH0tcpmlk/SezhGAkCnH1JC6RTFJCvZA84fT
	 +6SY5MO5+IFlibVIUxYc98au7OfEazZ+/PbG+31Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731663AbfK0VBF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 16:01:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:53100 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731653AbfK0VBC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 16:01:02 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EC0932086A;
        Wed, 27 Nov 2019 21:01:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574888461;
        bh=hiiQw4GIooAvk2r6v2UyMwi5UDbrlJKGpCYFPYlAAqM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=R/VMtjrtEJqY5jFfpZtYMo3ATyi6eIBHOO8FJgZGAekzpN112BrxnpL22xMz30imX
         NzNrcJpOqqqZwDXyLrv61My4EUt62KxR3kmPKvEUmq3L9vAEkUaNd2T/CHy0yQTkux
         95WmDW0jyY7krPwTk4nYqy6sn3Ki1xbPskCCo37U=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tristram Ha <Tristram.Ha@microchip.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 141/306] net: ethernet: cadence: fix socket buffer corruption problem
Date:   Wed, 27 Nov 2019 21:29:51 +0100
Message-Id: <20191127203125.628204748@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191127203114.766709977@linuxfoundation.org>
References: <20191127203114.766709977@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tristram Ha <Tristram.Ha@microchip.com>

[ Upstream commit 899ecaedd15599c22553d158f53b127cc1632dc2 ]

Socket buffer is not re-created when headroom is 2 and tailroom is 1.

Signed-off-by: Tristram Ha <Tristram.Ha@microchip.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/cadence/macb_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 74eeb3a985bf1..f175b20ac510a 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -1721,7 +1721,7 @@ static int macb_pad_and_fcs(struct sk_buff **skb, struct net_device *ndev)
 			padlen = 0;
 		/* No room for FCS, need to reallocate skb. */
 		else
-			padlen = ETH_FCS_LEN - tailroom;
+			padlen = ETH_FCS_LEN;
 	} else {
 		/* Add room for FCS. */
 		padlen += ETH_FCS_LEN;
-- 
2.20.1



