Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CE32C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:33:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57D4A218B0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:33:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553254413;
	bh=24wHugJs24qJpX/141yMWjLZH2oXIhh1jScx1Dj2VhE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=pQUgFFmwEYh1mi/YFHVvQq8x5qpTpCCvihQURD+SlrS+4SWjW3/hV8eGWwg5C2N6T
	 mWvFetCYgvbsZQy3wV9Oboq9rau1yUXtqarVjuTglno+iB6iBG9JvEIIF4SXJeujC0
	 VBPRXdaHvshJeASmyn0/KPh7dUM+pJW0Z2mOk4F4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730282AbfCVLdc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 07:33:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:33882 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729952AbfCVLd3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 07:33:29 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4D1D5218B0;
        Fri, 22 Mar 2019 11:33:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553254407;
        bh=24wHugJs24qJpX/141yMWjLZH2oXIhh1jScx1Dj2VhE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hKNcr5z6aFBQWQut5Kbs1nPtPlDcsFkSdioKHMOhH3NQEHdO7opfY7iLkBDdaUjgd
         tismxARFUDrkkz+Wzp/GJ44sSAo7QpIKMag98TqtMkf65fg4xq1yqIn33tHcCdjo5E
         b7LsXsqs3w1YAVBuzxLCs4ynBWsSu5SwLbn44cLk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, linmiaohe <linmiaohe@huawei.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.4 127/230] net: sit: fix UBSAN Undefined behaviour in check_6rd
Date:   Fri, 22 Mar 2019 12:14:25 +0100
Message-Id: <20190322111245.577916536@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111236.796964179@linuxfoundation.org>
References: <20190322111236.796964179@linuxfoundation.org>
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

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Miaohe Lin <linmiaohe@huawei.com>

[ Upstream commit a843dc4ebaecd15fca1f4d35a97210f72ea1473b ]

In func check_6rd,tunnel->ip6rd.relay_prefixlen may equal to
32,so UBSAN complain about it.

UBSAN: Undefined behaviour in net/ipv6/sit.c:781:47
shift exponent 32 is too large for 32-bit type 'unsigned int'
CPU: 6 PID: 20036 Comm: syz-executor.0 Not tainted 4.19.27 #2
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1ubuntu1
04/01/2014
Call Trace:
__dump_stack lib/dump_stack.c:77 [inline]
dump_stack+0xca/0x13e lib/dump_stack.c:113
ubsan_epilogue+0xe/0x81 lib/ubsan.c:159
__ubsan_handle_shift_out_of_bounds+0x293/0x2e8 lib/ubsan.c:425
check_6rd.constprop.9+0x433/0x4e0 net/ipv6/sit.c:781
try_6rd net/ipv6/sit.c:806 [inline]
ipip6_tunnel_xmit net/ipv6/sit.c:866 [inline]
sit_tunnel_xmit+0x141c/0x2720 net/ipv6/sit.c:1033
__netdev_start_xmit include/linux/netdevice.h:4300 [inline]
netdev_start_xmit include/linux/netdevice.h:4309 [inline]
xmit_one net/core/dev.c:3243 [inline]
dev_hard_start_xmit+0x17c/0x780 net/core/dev.c:3259
__dev_queue_xmit+0x1656/0x2500 net/core/dev.c:3829
neigh_output include/net/neighbour.h:501 [inline]
ip6_finish_output2+0xa36/0x2290 net/ipv6/ip6_output.c:120
ip6_finish_output+0x3e7/0xa20 net/ipv6/ip6_output.c:154
NF_HOOK_COND include/linux/netfilter.h:278 [inline]
ip6_output+0x1e2/0x720 net/ipv6/ip6_output.c:171
dst_output include/net/dst.h:444 [inline]
ip6_local_out+0x99/0x170 net/ipv6/output_core.c:176
ip6_send_skb+0x9d/0x2f0 net/ipv6/ip6_output.c:1697
ip6_push_pending_frames+0xc0/0x100 net/ipv6/ip6_output.c:1717
rawv6_push_pending_frames net/ipv6/raw.c:616 [inline]
rawv6_sendmsg+0x2435/0x3530 net/ipv6/raw.c:946
inet_sendmsg+0xf8/0x5c0 net/ipv4/af_inet.c:798
sock_sendmsg_nosec net/socket.c:621 [inline]
sock_sendmsg+0xc8/0x110 net/socket.c:631
___sys_sendmsg+0x6cf/0x890 net/socket.c:2114
__sys_sendmsg+0xf0/0x1b0 net/socket.c:2152
do_syscall_64+0xc8/0x580 arch/x86/entry/common.c:290
entry_SYSCALL_64_after_hwframe+0x49/0xbe

Signed-off-by: linmiaohe <linmiaohe@huawei.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv6/sit.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- a/net/ipv6/sit.c
+++ b/net/ipv6/sit.c
@@ -772,8 +772,9 @@ static bool check_6rd(struct ip_tunnel *
 		pbw0 = tunnel->ip6rd.prefixlen >> 5;
 		pbi0 = tunnel->ip6rd.prefixlen & 0x1f;
 
-		d = (ntohl(v6dst->s6_addr32[pbw0]) << pbi0) >>
-		    tunnel->ip6rd.relay_prefixlen;
+		d = tunnel->ip6rd.relay_prefixlen < 32 ?
+			(ntohl(v6dst->s6_addr32[pbw0]) << pbi0) >>
+		    tunnel->ip6rd.relay_prefixlen : 0;
 
 		pbi1 = pbi0 - tunnel->ip6rd.relay_prefixlen;
 		if (pbi1 > 0)


