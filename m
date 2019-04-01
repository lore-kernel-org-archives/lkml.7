Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 886AFC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 18:12:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58D882070D
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 18:12:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554142325;
	bh=3gs1w23AZ4jROHwWbXsmIARBfyK/qMGWiQ/BadcbLO4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=feu+MGnmLutArOS6BhkriBWYcUhNvuO/ecoMEtdvUVX6jZ3YrCfNBkjQ1w8ZAwg7V
	 h+xnKDON6rEvpEnYyjzTJRU73vbNzIWtEQOpflO21/WWC2c+Jts2MSWGwSVpkzxrLP
	 X3hR0SYrc2NOjFCLVSqSI1v/BM5GEkPJpfYgovw4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728868AbfDARFM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:05:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:50024 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728838AbfDARFG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:05:06 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9EC0D21925;
        Mon,  1 Apr 2019 17:05:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554138306;
        bh=3gs1w23AZ4jROHwWbXsmIARBfyK/qMGWiQ/BadcbLO4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=td7vesEZKpYsr+IKwyxxGB8i4lg+lk6p/OcSCJ1CiFJ4J+4hKftAnUdmautockYVY
         J+KvnuIPPxgEOUTkUezOcWN08I0eLK4FDUNUJfIT7mvmNG9wHH16MAg5Te71j6Bf5g
         uMCFrtV2yl+saZU2RG1rbJ6zoUyKzmwiIS8FfMAE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, David Ahern <dsahern@gmail.com>,
        Sabrina Dubroca <sd@queasysnail.net>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.0 027/146] vrf: prevent adding upper devices
Date:   Mon,  1 Apr 2019 19:00:39 +0200
Message-Id: <20190401170050.826935337@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190401170048.449559024@linuxfoundation.org>
References: <20190401170048.449559024@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

5.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sabrina Dubroca <sd@queasysnail.net>

[ Upstream commit 1017e0987117c32783ba7c10fe2e7ff1456ba1dc ]

VRF devices don't work with upper devices. Currently, it's possible to
add a VRF device to a bridge or team, and to create macvlan, macsec, or
ipvlan devices on top of a VRF (bond and vlan are prevented respectively
by the lack of an ndo_set_mac_address op and the NETIF_F_VLAN_CHALLENGED
feature flag).

Fix this by setting the IFF_NO_RX_HANDLER flag (introduced in commit
f5426250a6ec ("net: introduce IFF_NO_RX_HANDLER")).

Cc: David Ahern <dsahern@gmail.com>
Fixes: 193125dbd8eb ("net: Introduce VRF device driver")
Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
Acked-by: David Ahern <dsahern@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/vrf.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/net/vrf.c
+++ b/drivers/net/vrf.c
@@ -1273,6 +1273,7 @@ static void vrf_setup(struct net_device
 
 	/* default to no qdisc; user can add if desired */
 	dev->priv_flags |= IFF_NO_QUEUE;
+	dev->priv_flags |= IFF_NO_RX_HANDLER;
 
 	dev->min_mtu = 0;
 	dev->max_mtu = 0;


