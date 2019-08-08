Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90E10C32754
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 19:11:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BCAA208C3
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 19:11:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565291498;
	bh=2N7kHPHpGsyEPaH5C63j1jxu1GHQKJ0tKBPUI2dspZ4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=kCIaNpAAjVAW6iAUAf1aBr7nsxcw2JXOEG0eww9guKF8OODh7fcxdaQXQ10iOTLSO
	 04JGyxT12bmP9dbDVcVk7DSJq0P/gLutYldpZenvUF3op7TlUjqILR2Elsj0LtcnB6
	 8yXLVksCobn7f7zrEgW2RKupwIMQeA5Thw7JmZis=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405517AbfHHTLf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 15:11:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:46146 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405497AbfHHTLb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 15:11:31 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E3018208C3;
        Thu,  8 Aug 2019 19:11:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565291491;
        bh=2N7kHPHpGsyEPaH5C63j1jxu1GHQKJ0tKBPUI2dspZ4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CqaFNQCofAtrXPAUVax34hW5+8zVcHcEAp/5E7KNlQaoDZugzZLGQryaBEeQiRtR3
         Q+E7/Lc+oFSS8W03qeCw5g77NJf0vWlBZrfs1vM3uytVEqwh3/2ZZJC8Hn5zlW9ZyM
         3x7r8RmvIr6rThJBYbDscoeCXoAFmEZ66XnPkXog=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Sudarsana Reddy Kalluru <skalluru@marvell.com>,
        Manish Chopra <manishc@marvell.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 27/33] bnx2x: Disable multi-cos feature.
Date:   Thu,  8 Aug 2019 21:05:34 +0200
Message-Id: <20190808190454.984476363@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190808190453.582417307@linuxfoundation.org>
References: <20190808190453.582417307@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sudarsana Reddy Kalluru <skalluru@marvell.com>

[ Upstream commit d1f0b5dce8fda09a7f5f04c1878f181d548e42f5 ]

Commit 3968d38917eb ("bnx2x: Fix Multi-Cos.") which enabled multi-cos
feature after prolonged time in driver added some regression causing
numerous issues (sudden reboots, tx timeout etc.) reported by customers.
We plan to backout this commit and submit proper fix once we have root
cause of issues reported with this feature enabled.

Fixes: 3968d38917eb ("bnx2x: Fix Multi-Cos.")
Signed-off-by: Sudarsana Reddy Kalluru <skalluru@marvell.com>
Signed-off-by: Manish Chopra <manishc@marvell.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c
+++ b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c
@@ -1934,7 +1934,7 @@ u16 bnx2x_select_queue(struct net_device
 	}
 
 	/* select a non-FCoE queue */
-	return fallback(dev, skb) % (BNX2X_NUM_ETH_QUEUES(bp) * bp->max_cos);
+	return fallback(dev, skb) % (BNX2X_NUM_ETH_QUEUES(bp));
 }
 
 void bnx2x_set_num_queues(struct bnx2x *bp)


