Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6E81C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:29:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F63221904
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:29:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556126981;
	bh=dE4gCNF5HGvBIyUyJb9tlX9kzkGySHIhQzpWNAhy+ck=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=i1JvUqhLMgyHWP+7Ok6anG6QTs1E9kQiFObpqSpgQL/P5+/z5sSHHSmC5vUxskXla
	 m43EMFsqn6/CPV/jSaZbqm5uGMZKtohv2WKDYTS6OJCgq9Tu2u5IP/4xIVLDhi3URe
	 ttTFNQvieBMqCHTAwYrZldJX1WjDB7PtYSSC9A5w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390852AbfDXR3k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 13:29:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:55910 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390832AbfDXR3g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 13:29:36 -0400
Received: from localhost (62-193-50-229.as16211.net [62.193.50.229])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7782620811;
        Wed, 24 Apr 2019 17:29:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556126976;
        bh=dE4gCNF5HGvBIyUyJb9tlX9kzkGySHIhQzpWNAhy+ck=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Hdv1op8dh+ycmbyG0u8EF7cq7Q+gjR8XVGONW02N0rR4LNL3qd3VSFfojAEpA9uD6
         3+LTlLe98PUUO6RntxzScofpN9S6v5bz0E8IuVTRo/XfOVvHbp8p6hXrhvA+CnklHk
         BfKJTTbKkMJeLYOxKrPnFrcUx2J6NT5KfQQ+tqjc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Matteo Croce <mcroce@redhat.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.19 15/96] net: thunderx: dont allow jumbo frames with XDP
Date:   Wed, 24 Apr 2019 19:09:20 +0200
Message-Id: <20190424170920.797308250@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190424170919.829037226@linuxfoundation.org>
References: <20190424170919.829037226@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matteo Croce <mcroce@redhat.com>

[ Upstream commit 1f227d16083b2e280b7dde4ca78883d75593f2fd ]

The thunderx driver forbids to load an eBPF program if the MTU is too high,
but this can be circumvented by loading the eBPF, then raising the MTU.

Fix this by limiting the MTU if an eBPF program is already loaded.

Fixes: 05c773f52b96e ("net: thunderx: Add basic XDP support")
Signed-off-by: Matteo Croce <mcroce@redhat.com>
Acked-by: Jesper Dangaard Brouer <brouer@redhat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/cavium/thunder/nicvf_main.c |    9 +++++++++
 1 file changed, 9 insertions(+)

--- a/drivers/net/ethernet/cavium/thunder/nicvf_main.c
+++ b/drivers/net/ethernet/cavium/thunder/nicvf_main.c
@@ -1554,6 +1554,15 @@ static int nicvf_change_mtu(struct net_d
 	struct nicvf *nic = netdev_priv(netdev);
 	int orig_mtu = netdev->mtu;
 
+	/* For now just support only the usual MTU sized frames,
+	 * plus some headroom for VLAN, QinQ.
+	 */
+	if (nic->xdp_prog && new_mtu > MAX_XDP_MTU) {
+		netdev_warn(netdev, "Jumbo frames not yet supported with XDP, current MTU %d.\n",
+			    netdev->mtu);
+		return -EINVAL;
+	}
+
 	netdev->mtu = new_mtu;
 
 	if (!netif_running(netdev))


