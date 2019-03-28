Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,LOTS_OF_MONEY,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B248C4360F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 15:23:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E6C2217F9
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 15:23:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=dlink.ru header.i=@dlink.ru header.b="L9TFGHG7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727767AbfC1PXb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 11:23:31 -0400
Received: from fd.dlink.ru ([178.170.168.18]:38288 "EHLO fd.dlink.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726949AbfC1PX2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 11:23:28 -0400
Received: by fd.dlink.ru (Postfix, from userid 5000)
        id B74571B21152; Thu, 28 Mar 2019 18:23:25 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 fd.dlink.ru B74571B21152
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dlink.ru; s=mail;
        t=1553786605; bh=ETMOQfuVU2xsFh9GFRYjG9n/OctBeKibCsba98JEaBU=;
        h=From:To:Cc:Subject:Date;
        b=L9TFGHG7Zs7buDLy801QMgM2tOIraBrY+HISrZWoyJGTHfpkPAUQuj3B7qslGbPOa
         5HCrSKVtCwClKjIDh3YIhJGKlD/nBn16w6o6KU0yaTIIzzJra5l7oy7OrC4clYNmPV
         wMk0mg4u7yEZWBKbruSldo321ptY7oLv6AANfLOc=
Received: from mail.rzn.dlink.ru (mail.rzn.dlink.ru [178.170.168.13])
        by fd.dlink.ru (Postfix) with ESMTP id F23971B20234;
        Thu, 28 Mar 2019 18:23:19 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 fd.dlink.ru F23971B20234
Received: from mail.rzn.dlink.ru (localhost [127.0.0.1])
        by mail.rzn.dlink.ru (Postfix) with ESMTP id 4D1DE1B20311;
        Thu, 28 Mar 2019 18:23:19 +0300 (MSK)
Received: from localhost.localdomain (unknown [185.212.149.39])
        by mail.rzn.dlink.ru (Postfix) with ESMTPA;
        Thu, 28 Mar 2019 18:23:19 +0300 (MSK)
From:   Alexander Lobakin <alobakin@dlink.ru>
To:     "David S. Miller" <davem@davemloft.net>
Cc:     Edward Cree <ecree@solarflare.com>, Jiri Pirko <jiri@mellanox.com>,
        Ido Schimmel <idosch@mellanox.com>,
        Petr Machata <petrm@mellanox.com>,
        Alexander Duyck <alexander.h.duyck@intel.com>,
        Amritha Nambiar <amritha.nambiar@intel.com>,
        Li RongQing <lirongqing@baidu.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Alexander Lobakin <alobakin@dlink.ru>
Subject: [PATCH] net: core: netif_receive_skb_list: unlist skb before passing to pt->func
Date:   Thu, 28 Mar 2019 18:23:04 +0300
Message-Id: <20190328152304.8297-1-alobakin@dlink.ru>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

__netif_receive_skb_list_ptype() leaves skb->next poisoned before passing
it to pt_prev->func handler, what may produce (in certain cases, e.g. DSA
setup) crashes like:

[ 88.606777] CPU 0 Unable to handle kernel paging request at virtual address 0000000e, epc == 80687078, ra == 8052cc7c
[ 88.618666] Oops[#1]:
[ 88.621196] CPU: 0 PID: 0 Comm: swapper Not tainted 5.1.0-rc2-dlink-00206-g4192a172-dirty #1473
[ 88.630885] $ 0 : 00000000 10000400 00000002 864d7850
[ 88.636709] $ 4 : 87c0ddf0 864d7800 87c0ddf0 00000000
[ 88.642526] $ 8 : 00000000 49600000 00000001 00000001
[ 88.648342] $12 : 00000000 c288617b dadbee27 25d17c41
[ 88.654159] $16 : 87c0ddf0 85cff080 80790000 fffffffd
[ 88.659975] $20 : 80797b20 ffffffff 00000001 864d7800
[ 88.665793] $24 : 00000000 8011e658
[ 88.671609] $28 : 80790000 87c0dbc0 87cabf00 8052cc7c
[ 88.677427] Hi : 00000003
[ 88.680622] Lo : 7b5b4220
[ 88.683840] epc : 80687078 vlan_dev_hard_start_xmit+0x1c/0x1a0
[ 88.690532] ra : 8052cc7c dev_hard_start_xmit+0xac/0x188
[ 88.696734] Status: 10000404	IEp
[ 88.700422] Cause : 50000008 (ExcCode 02)
[ 88.704874] BadVA : 0000000e
[ 88.708069] PrId : 0001a120 (MIPS interAptiv (multi))
[ 88.713005] Modules linked in:
[ 88.716407] Process swapper (pid: 0, threadinfo=(ptrval), task=(ptrval), tls=00000000)
[ 88.725219] Stack : 85f61c28 00000000 0000000e 80780000 87c0ddf0 85cff080 80790000 8052cc7c
[ 88.734529] 87cabf00 00000000 00000001 85f5fb40 807b0000 864d7850 87cabf00 807d0000
[ 88.743839] 864d7800 8655f600 00000000 85cff080 87c1c000 0000006a 00000000 8052d96c
[ 88.753149] 807a0000 8057adb8 87c0dcc8 87c0dc50 85cfff08 00000558 87cabf00 85f58c50
[ 88.762460] 00000002 85f58c00 864d7800 80543308 fffffff4 00000001 85f58c00 864d7800
[ 88.771770] ...
[ 88.774483] Call Trace:
[ 88.777199] [<80687078>] vlan_dev_hard_start_xmit+0x1c/0x1a0
[ 88.783504] [<8052cc7c>] dev_hard_start_xmit+0xac/0x188
[ 88.789326] [<8052d96c>] __dev_queue_xmit+0x6e8/0x7d4
[ 88.794955] [<805a8640>] ip_finish_output2+0x238/0x4d0
[ 88.800677] [<805ab6a0>] ip_output+0xc8/0x140
[ 88.805526] [<805a68f4>] ip_forward+0x364/0x560
[ 88.810567] [<805a4ff8>] ip_rcv+0x48/0xe4
[ 88.815030] [<80528d44>] __netif_receive_skb_one_core+0x44/0x58
[ 88.821635] [<8067f220>] dsa_switch_rcv+0x108/0x1ac
[ 88.827067] [<80528f80>] __netif_receive_skb_list_core+0x228/0x26c
[ 88.833951] [<8052ed84>] netif_receive_skb_list+0x1d4/0x394
[ 88.840160] [<80355a88>] lunar_rx_poll+0x38c/0x828
[ 88.845496] [<8052fa78>] net_rx_action+0x14c/0x3cc
[ 88.850835] [<806ad300>] __do_softirq+0x178/0x338
[ 88.856077] [<8012a2d4>] irq_exit+0xbc/0x100
[ 88.860846] [<802f8b70>] plat_irq_dispatch+0xc0/0x144
[ 88.866477] [<80105974>] handle_int+0x14c/0x158
[ 88.871516] [<806acfb0>] r4k_wait+0x30/0x40
[ 88.876462] Code: afb10014 8c8200a0 00803025 <9443000c> 94a20468 00000000 10620042 00a08025 9605046a
[ 88.887332]
[ 88.888982] ---[ end trace eb863d007da11cf1 ]---
[ 88.894122] Kernel panic - not syncing: Fatal exception in interrupt
[ 88.901202] ---[ end Kernel panic - not syncing: Fatal exception in interrupt ]---

Fix this by pulling skb off the sublist and zeroing skb->next pointer
before calling ptype callback.

Fixes: 88eb1944e18c ("net: core: propagate SKB lists through packet_type lookup")
Reviewed-by: Edward Cree <ecree@solarflare.com>
Signed-off-by: Alexander Lobakin <alobakin@dlink.ru>
---
 net/core/dev.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index 2b67f2aa59dd..fdcff29df915 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -5014,8 +5014,10 @@ static inline void __netif_receive_skb_list_ptype(struct list_head *head,
 	if (pt_prev->list_func != NULL)
 		pt_prev->list_func(head, pt_prev, orig_dev);
 	else
-		list_for_each_entry_safe(skb, next, head, list)
+		list_for_each_entry_safe(skb, next, head, list) {
+			skb_list_del_init(skb);
 			pt_prev->func(skb, skb->dev, pt_prev, orig_dev);
+		}
 }
 
 static void __netif_receive_skb_list_core(struct list_head *head, bool pfmemalloc)
-- 
2.21.0

