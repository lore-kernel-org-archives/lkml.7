Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3082C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:11:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81940218A1
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:11:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555355463;
	bh=RxmhoD7iN2p20KN+Q7FzLox2pJoY6NFWM2QIuenuGVQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qGOdzBCWCjrNaOjD558YQTCz1FIIPaL3oY+mnFN+maTHgzVtYXto4IJf+z+gdMGs3
	 HGGc5mb9nyeF9ms307ODdSMWWdfjpBbHvaHsPodwY09acJ9Dusci+rEcEBknZ7QXNR
	 9DRgysBkdFy098ziEKbvWhPsfUI1LUQSH3Mg2Z8Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731148AbfDOTLC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 15:11:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:47756 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731128AbfDOTK7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 15:10:59 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D3CA9218DA;
        Mon, 15 Apr 2019 19:10:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555355459;
        bh=RxmhoD7iN2p20KN+Q7FzLox2pJoY6NFWM2QIuenuGVQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2K5Q1bc1LR6jtBQmzrDdsntjXWg8TUhU8OK997IXlhJYRhF+cKSWZU0X8OHk9J6Wb
         od/Nmpfd35P7b3JUTslIVDCcaC1Uh5DhbZR4pbiJP89ll3AEDShEJhHKfJm2RwLLBl
         RLbW/cYsmraSnAdiSMk+nR/s89vOJ7RCvGigxLUw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        John Hurley <john.hurley@netronome.com>,
        Simon Horman <simon.horman@netronome.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.0 029/117] nfp: disable netpoll on representors
Date:   Mon, 15 Apr 2019 20:59:59 +0200
Message-Id: <20190415183746.370604794@linuxfoundation.org>
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

[ Upstream commit c3e1f7fff69c78169c8ac40cc74ac4307f74e36d ]

NFP reprs are software device on top of the PF's vNIC.
The comment above __dev_queue_xmit() sayeth:

 When calling this method, interrupts MUST be enabled.  This is because
 the BH enable code must have IRQs enabled so that it will not deadlock.

For netconsole we can't guarantee IRQ state, let's just
disable netpoll on representors to be on the safe side.

When the initial implementation of NFP reprs was added by the
commit 5de73ee46704 ("nfp: general representor implementation")
.ndo_poll_controller was required for netpoll to be enabled.

Fixes: ac3d9dd034e5 ("netpoll: make ndo_poll_controller() optional")
Signed-off-by: Jakub Kicinski <jakub.kicinski@netronome.com>
Reviewed-by: John Hurley <john.hurley@netronome.com>
Reviewed-by: Simon Horman <simon.horman@netronome.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/netronome/nfp/nfp_net_repr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/netronome/nfp/nfp_net_repr.c b/drivers/net/ethernet/netronome/nfp/nfp_net_repr.c
index 7d62e3698f08..73db94e55fd0 100644
--- a/drivers/net/ethernet/netronome/nfp/nfp_net_repr.c
+++ b/drivers/net/ethernet/netronome/nfp/nfp_net_repr.c
@@ -384,7 +384,7 @@ int nfp_repr_init(struct nfp_app *app, struct net_device *netdev,
 	netdev->features &= ~(NETIF_F_TSO | NETIF_F_TSO6);
 	netdev->gso_max_segs = NFP_NET_LSO_MAX_SEGS;
 
-	netdev->priv_flags |= IFF_NO_QUEUE;
+	netdev->priv_flags |= IFF_NO_QUEUE | IFF_DISABLE_NETPOLL;
 	netdev->features |= NETIF_F_LLTX;
 
 	if (nfp_app_has_tc(app)) {
-- 
2.19.1



