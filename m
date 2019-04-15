Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78FBFC10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:05:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4240E20880
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:05:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555355143;
	bh=61ZdLdaQjEQpnXiV8ADgXDCSlqvDd+0d/+axPK/rcso=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ZN4MzcgI2/lASqoYlfj7nn2lpgh1ZlnHyQS52OlJnYBaNNeXp84UAgzA2c7Qyx1Ak
	 pMqSnyehCd/JMdWLDoDnXm9W95El/cmjfVeialXfPtq/kZZvBl2Fi9UpAY9T/NiknL
	 pyTxAo3cM9Xq17dh0BWABUnL/ruMU/Ue8Lq31EDg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729759AbfDOTFm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 15:05:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:39446 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729735AbfDOTFi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 15:05:38 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 955D2218A1;
        Mon, 15 Apr 2019 19:05:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555355138;
        bh=61ZdLdaQjEQpnXiV8ADgXDCSlqvDd+0d/+axPK/rcso=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=phNDilDkbGoqZH7RdTmC9dOvkn6puKo07Wsz5nfo2g2QIZxr6H34meEweawJCuyYZ
         WX/TYliWbVj2+bUkkP+O70rxYJT8jYOmeQtVz5FV7sv4JM0mAwgK5HOusQqoObL8Sf
         I4gXsEqRWyVmxJwjoPW9HTauxQPKFFLQD2GrFPbw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        John Hurley <john.hurley@netronome.com>,
        Simon Horman <simon.horman@netronome.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 027/101] nfp: disable netpoll on representors
Date:   Mon, 15 Apr 2019 20:58:25 +0200
Message-Id: <20190415183741.841872183@linuxfoundation.org>
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
 drivers/net/ethernet/netronome/nfp/nfp_net_repr.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/netronome/nfp/nfp_net_repr.c b/drivers/net/ethernet/netronome/nfp/nfp_net_repr.c
index e0d73b385563..aa5869eb2e3f 100644
--- a/drivers/net/ethernet/netronome/nfp/nfp_net_repr.c
+++ b/drivers/net/ethernet/netronome/nfp/nfp_net_repr.c
@@ -329,6 +329,8 @@ int nfp_repr_init(struct nfp_app *app, struct net_device *netdev,
 
 	SWITCHDEV_SET_OPS(netdev, &nfp_port_switchdev_ops);
 
+	netdev->priv_flags |= IFF_DISABLE_NETPOLL;
+
 	if (nfp_app_has_tc(app)) {
 		netdev->features |= NETIF_F_HW_TC;
 		netdev->hw_features |= NETIF_F_HW_TC;
-- 
2.19.1



