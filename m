Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,LOTS_OF_MONEY,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92772C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:06:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D1EC218FE
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:06:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555355179;
	bh=ZS7FLf9cbVINjyPbMeGHbcf2qteSLJnOVxOc9ZsFlJk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1jA56/q2vVgPoUgZXxGyyc68n8GQtIDs8FhK1Um7NlN4gnVN/UdIYuiM3U2VGAF/Q
	 PiwoFYnDEJedlsxdJGMoD6nnG3KIHQ9P1bXTgOn/LTBLhQAKCEAoNda/uyieRfUDv6
	 jDx+/yE1ssGXtGImsP3VZG+LFc+z+xhRUzINCx0E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729890AbfDOTGS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 15:06:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:40474 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729827AbfDOTGN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 15:06:13 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A1AAE218FC;
        Mon, 15 Apr 2019 19:06:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555355172;
        bh=ZS7FLf9cbVINjyPbMeGHbcf2qteSLJnOVxOc9ZsFlJk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RqKeDEs8CUjkmNms5/55LcmnW6285vJrmNg5hefGGys2QZN7Q+kV51qO0mR/gXHOD
         oQVWVdoZCKmsOsO/KB9lvlfgxxGCyIpNw6I2azcdNAiC83TEuKPyMigmGPEcH6V6jD
         Ty+hY/0qM08gpd3EzwJoxYLdgrdMpIb1IoTP5lRI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Edward Cree <ecree@solarflare.com>,
        Alexander Lobakin <alobakin@dlink.ru>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 032/101] net: core: netif_receive_skb_list: unlist skb before passing to pt->func
Date:   Mon, 15 Apr 2019 20:58:30 +0200
Message-Id: <20190415183742.146134138@linuxfoundation.org>
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

[ Upstream commit 9a5a90d167b0e5fe3d47af16b68fd09ce64085cd ]

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
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/core/dev.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index 5c8c0a572ee9..d47554307a6d 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -4959,8 +4959,10 @@ static inline void __netif_receive_skb_list_ptype(struct list_head *head,
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
2.19.1



