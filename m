Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADB70C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 18:04:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D40D20652
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 18:04:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556129096;
	bh=Mst9FKAmdbTVd4vQCX0yBQTTGi+be1XhGTN4ftWbWOg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=YRfN+Sy9SL56IFxNg9kK6q7WqAv2Bw0sf/7eafPAVQngAW7NI2pF9nU3m1QtuA1rQ
	 itSgUEHW0/edy0vAYEQTnJND3D2qA4Ei5gmuHp1Npgf+AenRBkavGE2iH866Ce0UzG
	 3v+8YANL9PIY1P/2d8qNNdgiWpjEHl/6qxjS4wF8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389846AbfDXSEz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 14:04:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:44228 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388150AbfDXRTC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 13:19:02 -0400
Received: from localhost (62-193-50-229.as16211.net [62.193.50.229])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D020621908;
        Wed, 24 Apr 2019 17:19:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556126342;
        bh=Mst9FKAmdbTVd4vQCX0yBQTTGi+be1XhGTN4ftWbWOg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ofKsS85aeIINuT7GxVxTRF+oILbPw/gNfM6MCiT4h1l+/oCWKK5bT5DruC0hDYRkT
         r12LEADPgfsg221fT6QmeFxbPKsq6mFAiBeSs/YLAcgWd0wwkEISbkx3EtptWBbs/A
         1mADWIe9jq3uTXQAVho+UiZ1vKY2z85zB+6RI7gY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jianlin Shi <jishi@redhat.com>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.4 078/168] ipv6: sit: reset ip header pointer in ipip6_rcv
Date:   Wed, 24 Apr 2019 19:08:42 +0200
Message-Id: <20190424170928.549924609@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190424170923.452349382@linuxfoundation.org>
References: <20190424170923.452349382@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>

[ Upstream commit bb9bd814ebf04f579be466ba61fc922625508807 ]

ipip6 tunnels run iptunnel_pull_header on received skbs. This can
determine the following use-after-free accessing iph pointer since
the packet will be 'uncloned' running pskb_expand_head if it is a
cloned gso skb (e.g if the packet has been sent though a veth device)

[  706.369655] BUG: KASAN: use-after-free in ipip6_rcv+0x1678/0x16e0 [sit]
[  706.449056] Read of size 1 at addr ffffe01b6bd855f5 by task ksoftirqd/1/=
[  706.669494] Hardware name: HPE ProLiant m400 Server/ProLiant m400 Server, BIOS U02 08/19/2016
[  706.771839] Call trace:
[  706.801159]  dump_backtrace+0x0/0x2f8
[  706.845079]  show_stack+0x24/0x30
[  706.884833]  dump_stack+0xe0/0x11c
[  706.925629]  print_address_description+0x68/0x260
[  706.982070]  kasan_report+0x178/0x340
[  707.025995]  __asan_report_load1_noabort+0x30/0x40
[  707.083481]  ipip6_rcv+0x1678/0x16e0 [sit]
[  707.132623]  tunnel64_rcv+0xd4/0x200 [tunnel4]
[  707.185940]  ip_local_deliver_finish+0x3b8/0x988
[  707.241338]  ip_local_deliver+0x144/0x470
[  707.289436]  ip_rcv_finish+0x43c/0x14b0
[  707.335447]  ip_rcv+0x628/0x1138
[  707.374151]  __netif_receive_skb_core+0x1670/0x2600
[  707.432680]  __netif_receive_skb+0x28/0x190
[  707.482859]  process_backlog+0x1d0/0x610
[  707.529913]  net_rx_action+0x37c/0xf68
[  707.574882]  __do_softirq+0x288/0x1018
[  707.619852]  run_ksoftirqd+0x70/0xa8
[  707.662734]  smpboot_thread_fn+0x3a4/0x9e8
[  707.711875]  kthread+0x2c8/0x350
[  707.750583]  ret_from_fork+0x10/0x18

[  707.811302] Allocated by task 16982:
[  707.854182]  kasan_kmalloc.part.1+0x40/0x108
[  707.905405]  kasan_kmalloc+0xb4/0xc8
[  707.948291]  kasan_slab_alloc+0x14/0x20
[  707.994309]  __kmalloc_node_track_caller+0x158/0x5e0
[  708.053902]  __kmalloc_reserve.isra.8+0x54/0xe0
[  708.108280]  __alloc_skb+0xd8/0x400
[  708.150139]  sk_stream_alloc_skb+0xa4/0x638
[  708.200346]  tcp_sendmsg_locked+0x818/0x2b90
[  708.251581]  tcp_sendmsg+0x40/0x60
[  708.292376]  inet_sendmsg+0xf0/0x520
[  708.335259]  sock_sendmsg+0xac/0xf8
[  708.377096]  sock_write_iter+0x1c0/0x2c0
[  708.424154]  new_sync_write+0x358/0x4a8
[  708.470162]  __vfs_write+0xc4/0xf8
[  708.510950]  vfs_write+0x12c/0x3d0
[  708.551739]  ksys_write+0xcc/0x178
[  708.592533]  __arm64_sys_write+0x70/0xa0
[  708.639593]  el0_svc_handler+0x13c/0x298
[  708.686646]  el0_svc+0x8/0xc

[  708.739019] Freed by task 17:
[  708.774597]  __kasan_slab_free+0x114/0x228
[  708.823736]  kasan_slab_free+0x10/0x18
[  708.868703]  kfree+0x100/0x3d8
[  708.905320]  skb_free_head+0x7c/0x98
[  708.948204]  skb_release_data+0x320/0x490
[  708.996301]  pskb_expand_head+0x60c/0x970
[  709.044399]  __iptunnel_pull_header+0x3b8/0x5d0
[  709.098770]  ipip6_rcv+0x41c/0x16e0 [sit]
[  709.146873]  tunnel64_rcv+0xd4/0x200 [tunnel4]
[  709.200195]  ip_local_deliver_finish+0x3b8/0x988
[  709.255596]  ip_local_deliver+0x144/0x470
[  709.303692]  ip_rcv_finish+0x43c/0x14b0
[  709.349705]  ip_rcv+0x628/0x1138
[  709.388413]  __netif_receive_skb_core+0x1670/0x2600
[  709.446943]  __netif_receive_skb+0x28/0x190
[  709.497120]  process_backlog+0x1d0/0x610
[  709.544169]  net_rx_action+0x37c/0xf68
[  709.589131]  __do_softirq+0x288/0x1018

[  709.651938] The buggy address belongs to the object at ffffe01b6bd85580
                which belongs to the cache kmalloc-1024 of size 1024
[  709.804356] The buggy address is located 117 bytes inside of
                1024-byte region [ffffe01b6bd85580, ffffe01b6bd85980)
[  709.946340] The buggy address belongs to the page:
[  710.003824] page:ffff7ff806daf600 count:1 mapcount:0 mapping:ffffe01c4001f600 index:0x0
[  710.099914] flags: 0xfffff8000000100(slab)
[  710.149059] raw: 0fffff8000000100 dead000000000100 dead000000000200 ffffe01c4001f600
[  710.242011] raw: 0000000000000000 0000000000380038 00000001ffffffff 0000000000000000
[  710.334966] page dumped because: kasan: bad access detected

Fix it resetting iph pointer after iptunnel_pull_header

Fixes: a09a4c8dd1ec ("tunnels: Remove encapsulation offloads on decap")
Tested-by: Jianlin Shi <jishi@redhat.com>
Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv6/sit.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/net/ipv6/sit.c
+++ b/net/ipv6/sit.c
@@ -693,6 +693,10 @@ static int ipip6_rcv(struct sk_buff *skb
 		if (iptunnel_pull_header(skb, 0, htons(ETH_P_IPV6)))
 			goto out;
 
+		/* skb can be uncloned in iptunnel_pull_header, so
+		 * old iph is no longer valid
+		 */
+		iph = (const struct iphdr *)skb_mac_header(skb);
 		err = IP_ECN_decapsulate(iph, skb);
 		if (unlikely(err)) {
 			if (log_ecn_error)


