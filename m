Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E9E0C606BD
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 15:16:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39A3721707
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 15:16:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562599004;
	bh=zFGpaQDY28hd0kihpRdDINnjf9kJUVoI7m9MTXvqEPw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=YoEumewpG4FW6nI4s9s/vBbrK3hoWqEYno6rCi8g94FYvNR6u6i3l7xxGyNNuZ/Nx
	 MplrWM7Eig4ZIV6hnI6Hx8y7LPT17C7ACuTpfrBIejY8FaheYsn2JJArXgJTnr3EuX
	 +63IBCU+ruadQL05wYKm6lCXgVjtwMBN0DIUS1T0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732638AbfGHPQm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 11:16:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:39768 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732622AbfGHPQk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 11:16:40 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 33CC8216C4;
        Mon,  8 Jul 2019 15:16:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562598999;
        bh=zFGpaQDY28hd0kihpRdDINnjf9kJUVoI7m9MTXvqEPw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hR7TEIx1ibCT/caML09jbF0ttUsiLN6WKUo+OvY1tLoY1BZ8bkHlKyFvEUd9zlWNN
         RcNHS2+ndQAzYXxmbunSmAgqMdAanbeX1t5LjLXGWSTDzW4af8XfHaSnmc6Vs4zcsQ
         ZmhpNWFPN9Sb5jRSBv4RbbqcM29UMiFRbf07+6R0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>,
        YueHaibing <yuehaibing@huawei.com>,
        Jiri Pirko <jiri@mellanox.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.4 45/73] bonding: Always enable vlan tx offload
Date:   Mon,  8 Jul 2019 17:12:55 +0200
Message-Id: <20190708150523.783932913@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190708150513.136580595@linuxfoundation.org>
References: <20190708150513.136580595@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: YueHaibing <yuehaibing@huawei.com>

[ Upstream commit 30d8177e8ac776d89d387fad547af6a0f599210e ]

We build vlan on top of bonding interface, which vlan offload
is off, bond mode is 802.3ad (LACP) and xmit_hash_policy is
BOND_XMIT_POLICY_ENCAP34.

Because vlan tx offload is off, vlan tci is cleared and skb push
the vlan header in validate_xmit_vlan() while sending from vlan
devices. Then in bond_xmit_hash, __skb_flow_dissect() fails to
get information from protocol headers encapsulated within vlan,
because 'nhoff' is points to IP header, so bond hashing is based
on layer 2 info, which fails to distribute packets across slaves.

This patch always enable bonding's vlan tx offload, pass the vlan
packets to the slave devices with vlan tci, let them to handle
vlan implementation.

Fixes: 278339a42a1b ("bonding: propogate vlan_features to bonding master")
Suggested-by: Jiri Pirko <jiri@resnulli.us>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Acked-by: Jiri Pirko <jiri@mellanox.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/bonding/bond_main.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -4164,13 +4164,13 @@ void bond_setup(struct net_device *bond_
 	bond_dev->features |= NETIF_F_NETNS_LOCAL;
 
 	bond_dev->hw_features = BOND_VLAN_FEATURES |
-				NETIF_F_HW_VLAN_CTAG_TX |
 				NETIF_F_HW_VLAN_CTAG_RX |
 				NETIF_F_HW_VLAN_CTAG_FILTER;
 
 	bond_dev->hw_features &= ~(NETIF_F_ALL_CSUM & ~NETIF_F_HW_CSUM);
 	bond_dev->hw_features |= NETIF_F_GSO_ENCAP_ALL;
 	bond_dev->features |= bond_dev->hw_features;
+	bond_dev->features |= NETIF_F_HW_VLAN_CTAG_TX;
 }
 
 /* Destroy a bonding device.


