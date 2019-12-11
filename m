Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B998EC43603
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 15:54:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 820612073B
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 15:54:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576079676;
	bh=aeJN9iD2dFfWHJYWyfxdk8+zHVMsBoio6kyTZ0brv3I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rVlC8jjAqa0it3oHaujypgwFrp2ZKRkjHDZAgt6m9dGUJpu3e2wYgrhbnRavOewcI
	 jNWPT2Tw3Pqa6OQlTVjtXNOCVkX63HFlzrw4/4YR5Rl1sQ0jL+dboSm8rcl6GXo+r7
	 cuQpeGin+VLrlgFhJKhiq3kDeZ3cZ2fhf/2pG+H4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732015AbfLKPR2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 10:17:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:44820 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731391AbfLKPRY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 10:17:24 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5B2DB2073D;
        Wed, 11 Dec 2019 15:17:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576077443;
        bh=aeJN9iD2dFfWHJYWyfxdk8+zHVMsBoio6kyTZ0brv3I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JUrYAt6Si/Ej0BPborKQZj5QXIHgI4/9xTDoRH8yWCaIA43iVPJ+plrTc1X7S51Eo
         FmCjASuwdz8PZu2R3xRm2/lHi2YPPP4K4Jtx+wyurQvH4tNuT/hqEwcsrDQduXpkaB
         YuYfc5dVkCS5Agyyoyts5Hexo1cEVMflx937sphQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 042/243] net: ethernet: ti: cpts: correct debug for expired txq skb
Date:   Wed, 11 Dec 2019 16:03:24 +0100
Message-Id: <20191211150341.984159300@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191211150339.185439726@linuxfoundation.org>
References: <20191211150339.185439726@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>

[ Upstream commit d0e14c4d9bcef0d4aa1057d2959adaa6f18d4a17 ]

The msgtype and seqid that is smth that belongs to event for
comparison but not for staled txq skb.

Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/ti/cpts.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/ti/cpts.c b/drivers/net/ethernet/ti/cpts.c
index 4f644ac314fe8..d7543811dfae2 100644
--- a/drivers/net/ethernet/ti/cpts.c
+++ b/drivers/net/ethernet/ti/cpts.c
@@ -119,9 +119,7 @@ static bool cpts_match_tx_ts(struct cpts *cpts, struct cpts_event *event)
 
 		if (time_after(jiffies, skb_cb->tmo)) {
 			/* timeout any expired skbs over 1s */
-			dev_dbg(cpts->dev,
-				"expiring tx timestamp mtype %u seqid %04x\n",
-				mtype, seqid);
+			dev_dbg(cpts->dev, "expiring tx timestamp from txq\n");
 			__skb_unlink(skb, &cpts->txq);
 			dev_consume_skb_any(skb);
 		}
-- 
2.20.1



