Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF52AC43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 18:15:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2787205F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 18:15:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561054523;
	bh=kf5RJKWA5oYAEDvJIm7IBbDOlA6XZbgSYxy+jrbqXkI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=DeFak/IxHNlx2kDZFjnnx2+Wm2rHMCHUjYtJuTIENEKBx9pNV2U0yv8mV3W7TQ0KQ
	 W1bwFpzYdf7/whCIWmFFcPOMlFZRlIjJq/htfIfqeI0DNSA4JN/X5UkYNE0zvtqBQf
	 /5gOHnT3q7Ng65ILd9quBJEIHobTkVmXOfTeT7Qw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729585AbfFTSPW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 14:15:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:44036 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729567AbfFTSPU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 14:15:20 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7E5412082C;
        Thu, 20 Jun 2019 18:15:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561054519;
        bh=kf5RJKWA5oYAEDvJIm7IBbDOlA6XZbgSYxy+jrbqXkI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ev/5+A6tdlUcLttKx4oMPtm5KcoWocf12B9FXrR0NYVTRnlpKYNE6hPSywq4fDLHc
         8r7F2Uura2O0VCJNloJkN0Rkngfb456ifRdFGBmtJbXBSSTHpiBblRzP2qQbvwzQMo
         CWTdsP+XeqfX+n6JlkI11M2hYALR/8ATBIqx7VRA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Ioana Radulescu <ruxandra.radulescu@nxp.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.1 57/98] dpaa2-eth: Use PTR_ERR_OR_ZERO where appropriate
Date:   Thu, 20 Jun 2019 19:57:24 +0200
Message-Id: <20190620174351.929436971@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190620174349.443386789@linuxfoundation.org>
References: <20190620174349.443386789@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit bd8460fa4de46e9d6177af4fe33bf0763a7af4b7 ]

Use PTR_ERR_OR_ZERO instead of PTR_ERR in cases where
zero is a valid input. Reported by smatch.

Signed-off-by: Ioana Radulescu <ruxandra.radulescu@nxp.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c b/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c
index 57cbaa38d247..df371c81a706 100644
--- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c
+++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c
@@ -1966,7 +1966,7 @@ alloc_channel(struct dpaa2_eth_priv *priv)
 
 	channel->dpcon = setup_dpcon(priv);
 	if (IS_ERR_OR_NULL(channel->dpcon)) {
-		err = PTR_ERR(channel->dpcon);
+		err = PTR_ERR_OR_ZERO(channel->dpcon);
 		goto err_setup;
 	}
 
@@ -2022,7 +2022,7 @@ static int setup_dpio(struct dpaa2_eth_priv *priv)
 		/* Try to allocate a channel */
 		channel = alloc_channel(priv);
 		if (IS_ERR_OR_NULL(channel)) {
-			err = PTR_ERR(channel);
+			err = PTR_ERR_OR_ZERO(channel);
 			if (err != -EPROBE_DEFER)
 				dev_info(dev,
 					 "No affine channel for cpu %d and above\n", i);
-- 
2.20.1



