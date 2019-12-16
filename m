Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FD52C43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 17:51:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D1A2206EC
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 17:51:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576518703;
	bh=6xX4GUpXtBOhRworb/C4nNl8y/xDjDpnXdqXg5c/DNI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rfSCFZtW5aJAeAWyacsUsnpT4Rm9Kx74QUu4WIbDlvvlYv26wC2xmkc36v1eKuif1
	 mz2ThA/aW74z/oXdbGotD6p7CkpgHGbGHEvKckBc636olj8hJRHmd6psf4VlVAPCTS
	 Him4T7VaSkTLR1Nmcfv7wdkD51ds9pbSopOdT/yc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727120AbfLPRvm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 12:51:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:41986 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727035AbfLPRvk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 12:51:40 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9A4DF20717;
        Mon, 16 Dec 2019 17:51:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576518700;
        bh=6xX4GUpXtBOhRworb/C4nNl8y/xDjDpnXdqXg5c/DNI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MxHilmdwXOJkBpbBIK7DxTikC9K0F8klEYkk2DjnUC4kbr5dTieACJxyAxA8vjMUN
         /2/PScPSjko8cJP5jLmj78NUBcIoiYdut/PeW9VO6aHRrwX0J5c4h9G2a8LcxwTvQT
         qI8cCZjITgSHw+qEOFZQvPujxFwAeEAQXXLRbg8M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 031/267] net: ethernet: ti: cpts: correct debug for expired txq skb
Date:   Mon, 16 Dec 2019 18:45:57 +0100
Message-Id: <20191216174852.348367061@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191216174848.701533383@linuxfoundation.org>
References: <20191216174848.701533383@linuxfoundation.org>
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
index 7d1281d812480..23c953496a0d1 100644
--- a/drivers/net/ethernet/ti/cpts.c
+++ b/drivers/net/ethernet/ti/cpts.c
@@ -116,9 +116,7 @@ static bool cpts_match_tx_ts(struct cpts *cpts, struct cpts_event *event)
 				mtype, seqid);
 		} else if (time_after(jiffies, skb_cb->tmo)) {
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



