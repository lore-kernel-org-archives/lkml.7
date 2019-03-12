Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19426C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:59:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC8AC214AF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:59:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552413570;
	bh=ro9cEYAGLr0Sa9QLR8AYpVlHxpZq8aRB5g06Hc6whwg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zs3ZoYhJP1H0PRb3BxjjHZB5aGJFTBls0HHQTgyUHT56p8T5SrAqWCZc9Im7IydCh
	 9cMSD1u6searUTLxAzHyiFNImlDwO0fOdKd9Z6fO2qjt3kN+zyMABzq6gaVF+w9QyU
	 hr80ixsRV0XHfmdHNoaNAKYoWlixUdvvONTeRf/s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728799AbfCLR73 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 13:59:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:50668 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727961AbfCLRNd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 13:13:33 -0400
Received: from localhost (unknown [104.133.8.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6192B2087C;
        Tue, 12 Mar 2019 17:13:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552410811;
        bh=ro9cEYAGLr0Sa9QLR8AYpVlHxpZq8aRB5g06Hc6whwg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OAun8yGKmwGCXewJyqyD7dnTGEc3xNhRK8v7QQe3Q6TssuL4D6TqfVABo6LabtEL2
         12LjSoxTSRD+u7myZalHJWPPbEKgHPyy7T0HHYUohmmhtBrM5X8T2/0G5b1K1vWwgd
         GMLJbdzeI43sN/wKkj0wP9IRylXg2/kT8BF8L938=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Marek Majkowski <marek@cloudflare.com>,
        Jakub Sitnicki <jakub@cloudflare.com>,
        Song Liu <songliubraving@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH 4.20 163/171] sk_msg: Always cancel strp work before freeing the psock
Date:   Tue, 12 Mar 2019 10:09:03 -0700
Message-Id: <20190312170401.422407341@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190312170347.868927101@linuxfoundation.org>
References: <20190312170347.868927101@linuxfoundation.org>
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

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jakub Sitnicki <jakub@cloudflare.com>

commit 1d79895aef18fa05789995d86d523c9b2ee58a02 upstream.

Despite having stopped the parser, we still need to deinitialize it
by calling strp_done so that it cancels its work. Otherwise the worker
thread can run after we have freed the parser, and attempt to access
its workqueue resulting in a use-after-free:

==================================================================
BUG: KASAN: use-after-free in pwq_activate_delayed_work+0x1b/0x1d0
Read of size 8 at addr ffff888069975240 by task kworker/u2:2/93

CPU: 0 PID: 93 Comm: kworker/u2:2 Not tainted 5.0.0-rc2-00335-g28f9d1a3d4fe-dirty #14
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-2.fc27 04/01/2014
Workqueue:            (null) (kstrp)
Call Trace:
 print_address_description+0x6e/0x2b0
 ? pwq_activate_delayed_work+0x1b/0x1d0
 kasan_report+0xfd/0x177
 ? pwq_activate_delayed_work+0x1b/0x1d0
 ? pwq_activate_delayed_work+0x1b/0x1d0
 pwq_activate_delayed_work+0x1b/0x1d0
 ? process_one_work+0x4aa/0x660
 pwq_dec_nr_in_flight+0x9b/0x100
 worker_thread+0x82/0x680
 ? process_one_work+0x660/0x660
 kthread+0x1b9/0x1e0
 ? __kthread_create_on_node+0x250/0x250
 ret_from_fork+0x1f/0x30

Allocated by task 111:
 sk_psock_init+0x3c/0x1b0
 sock_map_link.isra.2+0x103/0x4b0
 sock_map_update_common+0x94/0x270
 sock_map_update_elem+0x145/0x160
 __se_sys_bpf+0x152e/0x1e10
 do_syscall_64+0xb2/0x3e0
 entry_SYSCALL_64_after_hwframe+0x44/0xa9

Freed by task 112:
 kfree+0x7f/0x140
 process_one_work+0x40b/0x660
 worker_thread+0x82/0x680
 kthread+0x1b9/0x1e0
 ret_from_fork+0x1f/0x30

The buggy address belongs to the object at ffff888069975180
 which belongs to the cache kmalloc-512 of size 512
The buggy address is located 192 bytes inside of
 512-byte region [ffff888069975180, ffff888069975380)
The buggy address belongs to the page:
page:ffffea0001a65d00 count:1 mapcount:0 mapping:ffff88806d401280 index:0x0 compound_mapcount: 0
flags: 0x4000000000010200(slab|head)
raw: 4000000000010200 dead000000000100 dead000000000200 ffff88806d401280
raw: 0000000000000000 00000000800c000c 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff888069975100: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff888069975180: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff888069975200: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                           ^
 ffff888069975280: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888069975300: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================

Reported-by: Marek Majkowski <marek@cloudflare.com>
Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
Link: https://lore.kernel.org/netdev/CAJPywTLwgXNEZ2dZVoa=udiZmtrWJ0q5SuBW64aYs0Y1khXX3A@mail.gmail.com
Acked-by: Song Liu <songliubraving@fb.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/core/skmsg.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/net/core/skmsg.c
+++ b/net/core/skmsg.c
@@ -545,8 +545,7 @@ static void sk_psock_destroy_deferred(st
 	struct sk_psock *psock = container_of(gc, struct sk_psock, gc);
 
 	/* No sk_callback_lock since already detached. */
-	if (psock->parser.enabled)
-		strp_done(&psock->parser.strp);
+	strp_done(&psock->parser.strp);
 
 	cancel_work_sync(&psock->work);
 


