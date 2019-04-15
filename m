Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24D26C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:19:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD2A520643
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:19:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555355958;
	bh=wFGRlW35c4TQOwq1DEPPuQUSDXU3LPxT3+0/hYnVxQQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=bVVtnF9lOqCYRhAb0tp5wCqptbp4oIS7Q0KkZGjUmZ4akyUJlbZxe4FgpcEnefdxU
	 j//Dquz8NWWUHHmtHUcBeXYtrt0woywMXIa8kd0jJ8jJVA5ni1AoQodo7wyURLAny4
	 qpwgWMlqHZtEnKrD0oJS4OZX4pguq16xPX5wXZ6Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728323AbfDOTTR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 15:19:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:47188 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731076AbfDOTKl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 15:10:41 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 011D920880;
        Mon, 15 Apr 2019 19:10:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555355440;
        bh=wFGRlW35c4TQOwq1DEPPuQUSDXU3LPxT3+0/hYnVxQQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UW/gv4QKMXLZhDKzhg2ttO4EaqvmesgUokZFU8rcy/kKug3hQVc44wXAEuob6m7lD
         ihGoSF7NwzK3MZ7vijkLMq/CwnNnzzpvq017l9FfIQJfXZvWmNOjcL7ycgckQ3AMPy
         rtZkaliFuVOUVUwpzfCAw0RbF/O2elb6hGg17cmg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        John Hurley <john.hurley@netronome.com>,
        Simon Horman <simon.horman@netronome.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.0 028/117] nfp: validate the return code from dev_queue_xmit()
Date:   Mon, 15 Apr 2019 20:59:58 +0200
Message-Id: <20190415183746.316249454@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190415183744.887851196@linuxfoundation.org>
References: <20190415183744.887851196@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit c8ba5b91a04e3e2643e48501c114108802f21cda ]

dev_queue_xmit() may return error codes as well as netdev_tx_t,
and it always consumes the skb.  Make sure we always return a
correct netdev_tx_t value.

Fixes: eadfa4c3be99 ("nfp: add stats and xmit helpers for representors")
Signed-off-by: Jakub Kicinski <jakub.kicinski@netronome.com>
Reviewed-by: John Hurley <john.hurley@netronome.com>
Reviewed-by: Simon Horman <simon.horman@netronome.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/netronome/nfp/nfp_net_repr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/netronome/nfp/nfp_net_repr.c b/drivers/net/ethernet/netronome/nfp/nfp_net_repr.c
index 69d7aebda09b..7d62e3698f08 100644
--- a/drivers/net/ethernet/netronome/nfp/nfp_net_repr.c
+++ b/drivers/net/ethernet/netronome/nfp/nfp_net_repr.c
@@ -196,7 +196,7 @@ static netdev_tx_t nfp_repr_xmit(struct sk_buff *skb, struct net_device *netdev)
 	ret = dev_queue_xmit(skb);
 	nfp_repr_inc_tx_stats(netdev, len, ret);
 
-	return ret;
+	return NETDEV_TX_OK;
 }
 
 static int nfp_repr_stop(struct net_device *netdev)
-- 
2.19.1



