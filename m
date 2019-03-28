Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,LOTS_OF_MONEY,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DBD9C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 10:09:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BD9321773
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 10:09:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=dlink.ru header.i=@dlink.ru header.b="nK9ykCLZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727068AbfC1KJQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 06:09:16 -0400
Received: from mail.dlink.ru ([178.170.168.18]:38234 "EHLO fd.dlink.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725846AbfC1KJP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 06:09:15 -0400
X-Greylist: delayed 342 seconds by postgrey-1.27 at vger.kernel.org; Thu, 28 Mar 2019 06:09:12 EDT
Received: by fd.dlink.ru (Postfix, from userid 5000)
        id 0DE5D1B211ED; Thu, 28 Mar 2019 13:03:27 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 fd.dlink.ru 0DE5D1B211ED
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dlink.ru; s=mail;
        t=1553767408; bh=5Zd/isHLUJrFma/K6aiBcSJykCsUi5+ERJrOUicOw/w=;
        h=Date:From:Subject:To:Cc;
        b=nK9ykCLZ774pT3OcvJtIqHquuSiOCuZtPQPXpH/ytxpyrKXyhVeW2EvNzxIkkRV7V
         yDWO+mEd0RpFSRfXkJu8e94uW+KPrAH8fRWyjjUCSbO3Bt3n2RBdmXXRJbK80D0vF8
         ke36LmkgF1nXi4LZEzuU/CKerKfush9Fb0aUm/Tw=
Received: from mail.rzn.dlink.ru (mail.rzn.dlink.ru [178.170.168.13])
        by fd.dlink.ru (Postfix) with ESMTP id 837491B20234;
        Thu, 28 Mar 2019 13:03:22 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 fd.dlink.ru 837491B20234
Received: from mail.rzn.dlink.ru (localhost [127.0.0.1])
        by mail.rzn.dlink.ru (Postfix) with ESMTP id AD0BD1B20297;
        Thu, 28 Mar 2019 13:03:20 +0300 (MSK)
Received: from [10.8.8.64] (unknown [185.212.149.39])
        by mail.rzn.dlink.ru (Postfix) with ESMTPSA;
        Thu, 28 Mar 2019 13:03:20 +0300 (MSK)
Date:   Thu, 28 Mar 2019 13:03:19 +0300
From:   Alexander Lobakin <alobakin@dlink.ru>
Subject: [BUG] net: core: netif_receive_skb_list() crash on non-standard
 ptypes forwarding
To:     Edward Cree <ecree@solarflare.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Jiri Pirko <jiri@mellanox.com>,
        Ido Schimmel <idosch@mellanox.com>,
        Petr Machata <petrm@mellanox.com>,
        Alexander Duyck <alexander.h.duyck@intel.com>,
        Amritha Nambiar <amritha.nambiar@intel.com>,
        Li RongQing <lirongqing@baidu.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Message-Id: <1553767399.1271.1@dlink.ru>
X-Mailer: geary/3.32.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Edward,

Seems like I've found another poisoned skb->next crash with
netif_receive_skb_list().
This is similar to the one than has been already fixed in 22f6bbb7bcfc
("net: use skb_list_del_init() to remove from RX sublists"). This one=20
however
applies only to non-standard ptypes (in my case -- ETH_P_XDSA).

I use simple VLAN NAT setup through nft. After switching my in-dev=20
driver to
netif_receive_skb_list(), system started to crash on forwarding:

[ 88.606777] CPU 0 Unable to handle kernel paging request at virtual=20
address 0000000e, epc =3D=3D 80687078, ra =3D=3D 8052cc7c
[ 88.618666] Oops[#1]:
[ 88.621196] CPU: 0 PID: 0 Comm: swapper Not tainted=20
5.1.0-rc2-dlink-00206-g4192a172-dirty #1473
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
[ 88.716407] Process swapper (pid: 0, threadinfo=3D(ptrval),=20
task=3D(ptrval), tls=3D00000000)
[ 88.725219] Stack : 85f61c28 00000000 0000000e 80780000 87c0ddf0=20
85cff080 80790000 8052cc7c
[ 88.734529] 87cabf00 00000000 00000001 85f5fb40 807b0000 864d7850=20
87cabf00 807d0000
[ 88.743839] 864d7800 8655f600 00000000 85cff080 87c1c000 0000006a=20
00000000 8052d96c
[ 88.753149] 807a0000 8057adb8 87c0dcc8 87c0dc50 85cfff08 00000558=20
87cabf00 85f58c50
[ 88.762460] 00000002 85f58c00 864d7800 80543308 fffffff4 00000001=20
85f58c00 864d7800
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
[ 88.876462] Code: afb10014 8c8200a0 00803025 <9443000c> 94a20468=20
00000000 10620042 00a08025 9605046a
[ 88.887332]
[ 88.888982] ---[ end trace eb863d007da11cf1 ]---
[ 88.894122] Kernel panic - not syncing: Fatal exception in interrupt
[ 88.901202] ---[ end Kernel panic - not syncing: Fatal exception in=20
interrupt ]---

Some additional debug have showed that skb->next is poisoned on=20
dsa_switch_rcv()
-- ETH_P_XDSA ptype .func() callback. So when skb enters=20
dev_hard_start_xmit(),
function tries to "schedule" backpointer to list_head for transmitting.

Here's a working possible fix for that, not sure if it can break=20
anything
though.

diff --git a/net/core/dev.c b/net/core/dev.c
index 2b67f2aa59dd..fdcff29df915 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -5014,8 +5014,10 @@ static inline void=20
__netif_receive_skb_list_ptype(struct list_head *head,
 	if (pt_prev->list_func !=3D NULL)
 		pt_prev->list_func(head, pt_prev, orig_dev);
 	else
-		list_for_each_entry_safe(skb, next, head, list)
+		list_for_each_entry_safe(skb, next, head, list) {
+			skb_list_del_init(skb);
 			pt_prev->func(skb, skb->dev, pt_prev, orig_dev);
+		}
 }

 static void __netif_receive_skb_list_core(struct list_head *head, bool=20
pfmemalloc)

Maybe you could look into this and find another/better solution (or I=20
could
submit this one if that's pretty enough).

BTW, great work with netif_receive_skb_list() -- I've got 70 Mbps gain=20
(~15%)
on my setup in comparsion to napi_gro_receive().

Thanks,
Alexander.

Regards,
=E1=9A=B7 =E1=9B=96 =E1=9A=A2 =E1=9A=A6 =E1=9A=A0 =E1=9A=B1

=

