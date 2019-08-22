Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20F8DC3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 17:11:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5BF5233FE
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 17:11:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566493918;
	bh=ugLRNjODFh7NeHT6ZUhx8WzYAdA9XRdwr1KBbcJHyaw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=nG9JBjsny3cIOg0J/+WRWEANCz1HpbINYNLjIcTzjYkKEYmU5HEjqgPJ7WFKk3FWm
	 XNRp11exG4+hBwSYwlbKfTEAaWeW34hf6EIqDjp5YL/FQ2Epvz1Xqz7boToU4W56/P
	 ZgpHASKBWb4+sCH+X4BO2fq7swyY5SGoxXCTEB8I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387568AbfHVRL4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 13:11:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:59460 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390702AbfHVRJN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 13:09:13 -0400
Received: from sasha-vm.mshome.net (wsip-184-188-36-2.sd.sd.cox.net [184.188.36.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B1979233FC;
        Thu, 22 Aug 2019 17:09:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566493753;
        bh=ugLRNjODFh7NeHT6ZUhx8WzYAdA9XRdwr1KBbcJHyaw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zoke+pYDUIgaJFrilzCkfHyZfxEixYhtmVrpKn8BM6uix6GzLI96qpEQa7amAZRVp
         +cMYrXZ4TCRaH0/qfcPJJXYF+dZkiv2ib2ASozv4kYbtabZAw0OrlvVD1ff+5PEImn
         aw8JLjc8iRobP0nZet8msKKE0BOlvHbHTizegKZI=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     YueHaibing <yuehaibing@huawei.com>,
        Jay Vosburgh <jay.vosburgh@canonical.com>,
        "David S . Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 5.2 108/135] bonding: Add vlan tx offload to hw_enc_features
Date:   Thu, 22 Aug 2019 13:07:44 -0400
Message-Id: <20190822170811.13303-109-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190822170811.13303-1-sashal@kernel.org>
References: <20190822170811.13303-1-sashal@kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.2.10-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-5.2.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 5.2.10-rc1
X-KernelTest-Deadline: 2019-08-24T17:07+00:00
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: YueHaibing <yuehaibing@huawei.com>

[ Upstream commit d595b03de2cb0bdf9bcdf35ff27840cc3a37158f ]

As commit 30d8177e8ac7 ("bonding: Always enable vlan tx offload")
said, we should always enable bonding's vlan tx offload, pass the
vlan packets to the slave devices with vlan tci, let them to handle
vlan implementation.

Now if encapsulation protocols like VXLAN is used, skb->encapsulation
may be set, then the packet is passed to vlan device which based on
bonding device. However in netif_skb_features(), the check of
hw_enc_features:

	 if (skb->encapsulation)
                 features &= dev->hw_enc_features;

clears NETIF_F_HW_VLAN_CTAG_TX/NETIF_F_HW_VLAN_STAG_TX. This results
in same issue in commit 30d8177e8ac7 like this:

vlan_dev_hard_start_xmit
  -->dev_queue_xmit
    -->validate_xmit_skb
      -->netif_skb_features //NETIF_F_HW_VLAN_CTAG_TX is cleared
      -->validate_xmit_vlan
        -->__vlan_hwaccel_push_inside //skb->tci is cleared
...
 --> bond_start_xmit
   --> bond_xmit_hash //BOND_XMIT_POLICY_ENCAP34
     --> __skb_flow_dissect // nhoff point to IP header
        -->  case htons(ETH_P_8021Q)
             // skb_vlan_tag_present is false, so
             vlan = __skb_header_pointer(skb, nhoff, sizeof(_vlan),
             //vlan point to ip header wrongly

Fixes: b2a103e6d0af ("bonding: convert to ndo_fix_features")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Acked-by: Jay Vosburgh <jay.vosburgh@canonical.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/bonding/bond_main.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index b0aab3a0a1bfa..f183cadd14e3d 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -1113,6 +1113,8 @@ static void bond_compute_features(struct bonding *bond)
 done:
 	bond_dev->vlan_features = vlan_features;
 	bond_dev->hw_enc_features = enc_features | NETIF_F_GSO_ENCAP_ALL |
+				    NETIF_F_HW_VLAN_CTAG_TX |
+				    NETIF_F_HW_VLAN_STAG_TX |
 				    NETIF_F_GSO_UDP_L4;
 	bond_dev->gso_max_segs = gso_max_segs;
 	netif_set_gso_max_size(bond_dev, gso_max_size);
-- 
2.20.1

