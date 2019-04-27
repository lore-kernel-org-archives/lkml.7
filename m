Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39766C43219
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 15:25:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0ED38206A3
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 15:25:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728368AbfD0PY7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 11:24:59 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:33404 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727437AbfD0PPZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 11:15:25 -0400
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1hKP2w-0000zL-2d; Sat, 27 Apr 2019 16:15:22 +0100
Received: from ben by deadeye with local (Exim 4.92)
        (envelope-from <ben@decadent.org.uk>)
        id 1hKP2m-0004as-IW; Sat, 27 Apr 2019 16:15:12 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Kal Conley" <kal.conley@dectris.com>,
        "Andrey Konovalov" <andreyknvl@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        "Christoph Paasch" <cpaasch@apple.com>
Date:   Sat, 27 Apr 2019 16:13:09 +0100
Message-ID: <lsq.1556377989.690361921@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 151/202] net/packet: Set __GFP_NOWARN upon allocation
 in alloc_pg_vec
In-Reply-To: <lsq.1556377988.384060557@decadent.org.uk>
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.66-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Christoph Paasch <cpaasch@apple.com>

commit 398f0132c14754fcd03c1c4f8e7176d001ce8ea1 upstream.

Since commit fc62814d690c ("net/packet: fix 4gb buffer limit due to overflow check")
one can now allocate packet ring buffers >= UINT_MAX. However, syzkaller
found that that triggers a warning:

[   21.100000] WARNING: CPU: 2 PID: 2075 at mm/page_alloc.c:4584 __alloc_pages_nod0
[   21.101490] Modules linked in:
[   21.101921] CPU: 2 PID: 2075 Comm: syz-executor.0 Not tainted 5.0.0 #146
[   21.102784] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 0.5.1 01/01/2011
[   21.103887] RIP: 0010:__alloc_pages_nodemask+0x2a0/0x630
[   21.104640] Code: fe ff ff 65 48 8b 04 25 c0 de 01 00 48 05 90 0f 00 00 41 bd 01 00 00 00 48 89 44 24 48 e9 9c fe 3
[   21.107121] RSP: 0018:ffff88805e1cf920 EFLAGS: 00010246
[   21.107819] RAX: 0000000000000000 RBX: ffffffff85a488a0 RCX: 0000000000000000
[   21.108753] RDX: 0000000000000000 RSI: dffffc0000000000 RDI: 0000000000000000
[   21.109699] RBP: 1ffff1100bc39f28 R08: ffffed100bcefb67 R09: ffffed100bcefb67
[   21.110646] R10: 0000000000000001 R11: ffffed100bcefb66 R12: 000000000000000d
[   21.111623] R13: 0000000000000000 R14: ffff88805e77d888 R15: 000000000000000d
[   21.112552] FS:  00007f7c7de05700(0000) GS:ffff88806d100000(0000) knlGS:0000000000000000
[   21.113612] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   21.114405] CR2: 000000000065c000 CR3: 000000005e58e006 CR4: 00000000001606e0
[   21.115367] Call Trace:
[   21.115705]  ? __alloc_pages_slowpath+0x21c0/0x21c0
[   21.116362]  alloc_pages_current+0xac/0x1e0
[   21.116923]  kmalloc_order+0x18/0x70
[   21.117393]  kmalloc_order_trace+0x18/0x110
[   21.117949]  packet_set_ring+0x9d5/0x1770
[   21.118524]  ? packet_rcv_spkt+0x440/0x440
[   21.119094]  ? lock_downgrade+0x620/0x620
[   21.119646]  ? __might_fault+0x177/0x1b0
[   21.120177]  packet_setsockopt+0x981/0x2940
[   21.120753]  ? __fget+0x2fb/0x4b0
[   21.121209]  ? packet_release+0xab0/0xab0
[   21.121740]  ? sock_has_perm+0x1cd/0x260
[   21.122297]  ? selinux_secmark_relabel_packet+0xd0/0xd0
[   21.123013]  ? __fget+0x324/0x4b0
[   21.123451]  ? selinux_netlbl_socket_setsockopt+0x101/0x320
[   21.124186]  ? selinux_netlbl_sock_rcv_skb+0x3a0/0x3a0
[   21.124908]  ? __lock_acquire+0x529/0x3200
[   21.125453]  ? selinux_socket_setsockopt+0x5d/0x70
[   21.126075]  ? __sys_setsockopt+0x131/0x210
[   21.126533]  ? packet_release+0xab0/0xab0
[   21.127004]  __sys_setsockopt+0x131/0x210
[   21.127449]  ? kernel_accept+0x2f0/0x2f0
[   21.127911]  ? ret_from_fork+0x8/0x50
[   21.128313]  ? do_raw_spin_lock+0x11b/0x280
[   21.128800]  __x64_sys_setsockopt+0xba/0x150
[   21.129271]  ? lockdep_hardirqs_on+0x37f/0x560
[   21.129769]  do_syscall_64+0x9f/0x450
[   21.130182]  entry_SYSCALL_64_after_hwframe+0x49/0xbe

We should allocate with __GFP_NOWARN to handle this.

Cc: Kal Conley <kal.conley@dectris.com>
Cc: Andrey Konovalov <andreyknvl@google.com>
Fixes: fc62814d690c ("net/packet: fix 4gb buffer limit due to overflow check")
Signed-off-by: Christoph Paasch <cpaasch@apple.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 net/packet/af_packet.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -3828,7 +3828,7 @@ static struct pgv *alloc_pg_vec(struct t
 	struct pgv *pg_vec;
 	int i;
 
-	pg_vec = kcalloc(block_nr, sizeof(struct pgv), GFP_KERNEL);
+	pg_vec = kcalloc(block_nr, sizeof(struct pgv), GFP_KERNEL | __GFP_NOWARN);
 	if (unlikely(!pg_vec))
 		goto out;
 

