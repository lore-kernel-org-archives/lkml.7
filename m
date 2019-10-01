Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91063C352AA
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 16:41:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C3D720B7C
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 16:41:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569948061;
	bh=tIbenjcvZqPaNdBtku31+1LasH3s1munDjqFxyHW7Yw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=eZK50VwEOMYXp2kKMHT0EXxZqGAjSMBSSqLATaU7ddqCLgEWh4Ei0fP3XuJKhMtr+
	 /s9bG3tXdp+06YyLGUz6CfSDHHuybh0TWHyQM+lRS0OZOTe75qvzk4bBSHg2UTUtTM
	 9i3wcy8LrtOsMlvUbO4KxpcsDEvWT5M0HhqbNYgs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730499AbfJAQlA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 12:41:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:52338 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730416AbfJAQkz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 12:40:55 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8AD79205C9;
        Tue,  1 Oct 2019 16:40:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569948054;
        bh=tIbenjcvZqPaNdBtku31+1LasH3s1munDjqFxyHW7Yw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wCoFRTSJcWRTh6BIXDnBWis1naWIMqMZOBr8YPoxRPrgF4QftgxS1V5Z5ozO/j4nn
         poueld2uU60M0AJtw45ZGYACf2juH8esy7nNukcPu68jyb8j4+2NtpgLSYnOVB+cda
         Yz2qfz1dw6vrInYaLwv4rmeiQFEu8T40/pW1aub4=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Xin Long <lucien.xin@gmail.com>, Xiumei Mu <xmu@redhat.com>,
        Fei Liu <feliu@redhat.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.3 56/71] macsec: drop skb sk before calling gro_cells_receive
Date:   Tue,  1 Oct 2019 12:39:06 -0400
Message-Id: <20191001163922.14735-56-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191001163922.14735-1-sashal@kernel.org>
References: <20191001163922.14735-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xin Long <lucien.xin@gmail.com>

[ Upstream commit ba56d8ce38c8252fff5b745db3899cf092578ede ]

Fei Liu reported a crash when doing netperf on a topo of macsec
dev over veth:

  [  448.919128] refcount_t: underflow; use-after-free.
  [  449.090460] Call trace:
  [  449.092895]  refcount_sub_and_test+0xb4/0xc0
  [  449.097155]  tcp_wfree+0x2c/0x150
  [  449.100460]  ip_rcv+0x1d4/0x3a8
  [  449.103591]  __netif_receive_skb_core+0x554/0xae0
  [  449.108282]  __netif_receive_skb+0x28/0x78
  [  449.112366]  netif_receive_skb_internal+0x54/0x100
  [  449.117144]  napi_gro_complete+0x70/0xc0
  [  449.121054]  napi_gro_flush+0x6c/0x90
  [  449.124703]  napi_complete_done+0x50/0x130
  [  449.128788]  gro_cell_poll+0x8c/0xa8
  [  449.132351]  net_rx_action+0x16c/0x3f8
  [  449.136088]  __do_softirq+0x128/0x320

The issue was caused by skb's true_size changed without its sk's
sk_wmem_alloc increased in tcp/skb_gro_receive(). Later when the
skb is being freed and the skb's truesize is subtracted from its
sk's sk_wmem_alloc in tcp_wfree(), underflow occurs.

macsec is calling gro_cells_receive() to receive a packet, which
actually requires skb->sk to be NULL. However when macsec dev is
over veth, it's possible the skb->sk is still set if the skb was
not unshared or expanded from the peer veth.

ip_rcv() is calling skb_orphan() to drop the skb's sk for tproxy,
but it is too late for macsec's calling gro_cells_receive(). So
fix it by dropping the skb's sk earlier on rx path of macsec.

Fixes: 5491e7c6b1a9 ("macsec: enable GRO and RPS on macsec devices")
Reported-by: Xiumei Mu <xmu@redhat.com>
Reported-by: Fei Liu <feliu@redhat.com>
Signed-off-by: Xin Long <lucien.xin@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/macsec.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/macsec.c b/drivers/net/macsec.c
index 8f46aa1ddec01..cb7637364b40d 100644
--- a/drivers/net/macsec.c
+++ b/drivers/net/macsec.c
@@ -1235,6 +1235,7 @@ static rx_handler_result_t macsec_handle_frame(struct sk_buff **pskb)
 		macsec_rxsa_put(rx_sa);
 	macsec_rxsc_put(rx_sc);
 
+	skb_orphan(skb);
 	ret = gro_cells_receive(&macsec->gro_cells, skb);
 	if (ret == NET_RX_SUCCESS)
 		count_rx(dev, skb->len);
-- 
2.20.1

