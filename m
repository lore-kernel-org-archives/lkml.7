Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04F5EC10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:25:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBA9A20651
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:25:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555356324;
	bh=jkeuBbZtAWfTA82nwl/ZM6RQXsKBPB11gvVO6OjH0vU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ErfN8UL9gV6+kQ9kJD3/rSi1PzDql+44b0bMGcaZEDupwv73Y7lMltyW/k0onstIx
	 ac/cUoMyMzJ5yVyRvSSTr6QaSKOiIJtOtskOptBHm55cY+j+wlcWb19biQVtCY0xtN
	 43zn3C0xz09f7nbPvVYxXAGVzWChoGeFNVqtivxo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730486AbfDOTZX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 15:25:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:39362 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728676AbfDOTFg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 15:05:36 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EEDBE20880;
        Mon, 15 Apr 2019 19:05:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555355135;
        bh=jkeuBbZtAWfTA82nwl/ZM6RQXsKBPB11gvVO6OjH0vU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Go9zhcKojPUu3i6FPALfHuEna/feKX03LNsAvrDZPdSoFTDl5u80ClPlgZBhCEtrc
         JpIhBiannM/MGNQ9YDJTcdTS8oZiNbQrNXtU5+aYxKWL4H+2EZlM659XdJ4ChVkaJO
         WwQzTJsxqTTm9TBWlzIGzJ9gDvsd2WO1/7mILH+s=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        John Hurley <john.hurley@netronome.com>,
        Simon Horman <simon.horman@netronome.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 026/101] nfp: validate the return code from dev_queue_xmit()
Date:   Mon, 15 Apr 2019 20:58:24 +0200
Message-Id: <20190415183741.788299852@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190415183740.341577907@linuxfoundation.org>
References: <20190415183740.341577907@linuxfoundation.org>
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
index 18a09cdcd9c6..e0d73b385563 100644
--- a/drivers/net/ethernet/netronome/nfp/nfp_net_repr.c
+++ b/drivers/net/ethernet/netronome/nfp/nfp_net_repr.c
@@ -225,7 +225,7 @@ static netdev_tx_t nfp_repr_xmit(struct sk_buff *skb, struct net_device *netdev)
 	ret = dev_queue_xmit(skb);
 	nfp_repr_inc_tx_stats(netdev, len, ret);
 
-	return ret;
+	return NETDEV_TX_OK;
 }
 
 static int nfp_repr_stop(struct net_device *netdev)
-- 
2.19.1



