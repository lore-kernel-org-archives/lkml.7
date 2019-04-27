Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A794EC43219
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 15:19:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77784206A3
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 15:19:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728135AbfD0PTZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 11:19:25 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:34128 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727661AbfD0PPh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 11:15:37 -0400
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1hKP38-0000z8-35; Sat, 27 Apr 2019 16:15:34 +0100
Received: from ben by deadeye with local (Exim 4.92)
        (envelope-from <ben@decadent.org.uk>)
        id 1hKP2j-0004T5-Ez; Sat, 27 Apr 2019 16:15:09 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Leon Romanovsky" <leonro@mellanox.com>,
        "Jason Gunthorpe" <jgg@mellanox.com>,
        "Erez Shitrit" <erezsh@mellanox.com>,
        "Feras Daoud" <ferasda@mellanox.com>
Date:   Sat, 27 Apr 2019 16:13:09 +0100
Message-ID: <lsq.1556377989.472733141@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 068/202] IB/ipoib: Fix for use-after-free in
 ipoib_cm_tx_start
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

From: Feras Daoud <ferasda@mellanox.com>

commit 6ab4aba00f811a5265acc4d3eb1863bb3ca60562 upstream.

The following BUG was reported by kasan:

 BUG: KASAN: use-after-free in ipoib_cm_tx_start+0x430/0x1390 [ib_ipoib]
 Read of size 80 at addr ffff88034c30bcd0 by task kworker/u16:1/24020

 Workqueue: ipoib_wq ipoib_cm_tx_start [ib_ipoib]
 Call Trace:
  dump_stack+0x9a/0xeb
  print_address_description+0xe3/0x2e0
  kasan_report+0x18a/0x2e0
  ? ipoib_cm_tx_start+0x430/0x1390 [ib_ipoib]
  memcpy+0x1f/0x50
  ipoib_cm_tx_start+0x430/0x1390 [ib_ipoib]
  ? kvm_clock_read+0x1f/0x30
  ? ipoib_cm_skb_reap+0x610/0x610 [ib_ipoib]
  ? __lock_is_held+0xc2/0x170
  ? process_one_work+0x880/0x1960
  ? process_one_work+0x912/0x1960
  process_one_work+0x912/0x1960
  ? wq_pool_ids_show+0x310/0x310
  ? lock_acquire+0x145/0x440
  worker_thread+0x87/0xbb0
  ? process_one_work+0x1960/0x1960
  kthread+0x314/0x3d0
  ? kthread_create_worker_on_cpu+0xc0/0xc0
  ret_from_fork+0x3a/0x50

 Allocated by task 0:
  kasan_kmalloc+0xa0/0xd0
  kmem_cache_alloc_trace+0x168/0x3e0
  path_rec_create+0xa2/0x1f0 [ib_ipoib]
  ipoib_start_xmit+0xa98/0x19e0 [ib_ipoib]
  dev_hard_start_xmit+0x159/0x8d0
  sch_direct_xmit+0x226/0xb40
  __dev_queue_xmit+0x1d63/0x2950
  neigh_update+0x889/0x1770
  arp_process+0xc47/0x21f0
  arp_rcv+0x462/0x760
  __netif_receive_skb_core+0x1546/0x2da0
  netif_receive_skb_internal+0xf2/0x590
  napi_gro_receive+0x28e/0x390
  ipoib_ib_handle_rx_wc_rss+0x873/0x1b60 [ib_ipoib]
  ipoib_rx_poll_rss+0x17d/0x320 [ib_ipoib]
  net_rx_action+0x427/0xe30
  __do_softirq+0x28e/0xc42

 Freed by task 26680:
  __kasan_slab_free+0x11d/0x160
  kfree+0xf5/0x360
  ipoib_flush_paths+0x532/0x9d0 [ib_ipoib]
  ipoib_set_mode_rss+0x1ad/0x560 [ib_ipoib]
  set_mode+0xc8/0x150 [ib_ipoib]
  kernfs_fop_write+0x279/0x440
  __vfs_write+0xd8/0x5c0
  vfs_write+0x15e/0x470
  ksys_write+0xb8/0x180
  do_syscall_64+0x9b/0x420
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

 The buggy address belongs to the object at ffff88034c30bcc8
                which belongs to the cache kmalloc-512 of size 512
 The buggy address is located 8 bytes inside of
                512-byte region [ffff88034c30bcc8, ffff88034c30bec8)
 The buggy address belongs to the page:

The following race between change mode and xmit flow is the reason for
this use-after-free:

Change mode     Send packet 1 to GID XX      Send packet 2 to GID XX
     |                    |                             |
   start                  |                             |
     |                    |                             |
     |                    |                             |
     |         Create new path for GID XX               |
     |           and update neigh path                  |
     |                    |                             |
     |                    |                             |
     |                    |                             |
 flush_paths              |                             |
                          |                             |
               queue_work(cm.start_task)                |
                          |                 Path for GID XX not found
                          |                      create new path
                          |
                          |
               start_task runs with old
                    released path

There is no locking to protect the lifetime of the path through the
ipoib_cm_tx struct, so delete it entirely and always use the newly looked
up path under the priv->lock.

Fixes: 546481c2816e ("IB/ipoib: Fix memory corruption in ipoib cm mode connect flow")
Signed-off-by: Feras Daoud <ferasda@mellanox.com>
Reviewed-by: Erez Shitrit <erezsh@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
[bwh: Backported to 3.16: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/infiniband/ulp/ipoib/ipoib.h    | 1 -
 drivers/infiniband/ulp/ipoib/ipoib_cm.c | 3 +--
 2 files changed, 1 insertion(+), 3 deletions(-)

--- a/drivers/infiniband/ulp/ipoib/ipoib.h
+++ b/drivers/infiniband/ulp/ipoib/ipoib.h
@@ -228,7 +228,6 @@ struct ipoib_cm_tx {
 	struct list_head     list;
 	struct net_device   *dev;
 	struct ipoib_neigh  *neigh;
-	struct ipoib_path   *path;
 	struct ipoib_cm_tx_buf *tx_ring;
 	unsigned	     tx_head;
 	unsigned	     tx_tail;
--- a/drivers/infiniband/ulp/ipoib/ipoib_cm.c
+++ b/drivers/infiniband/ulp/ipoib/ipoib_cm.c
@@ -1279,7 +1279,6 @@ struct ipoib_cm_tx *ipoib_cm_create_tx(s
 
 	neigh->cm = tx;
 	tx->neigh = neigh;
-	tx->path = path;
 	tx->dev = dev;
 	list_add(&tx->list, &priv->cm.start_list);
 	set_bit(IPOIB_FLAG_INITIALIZED, &tx->flags);
@@ -1338,7 +1337,7 @@ static void ipoib_cm_tx_start(struct wor
 				neigh->daddr + QPN_AND_OPTIONS_OFFSET);
 			goto free_neigh;
 		}
-		memcpy(&pathrec, &p->path->pathrec, sizeof pathrec);
+		memcpy(&pathrec, &path->pathrec, sizeof(pathrec));
 
 		spin_unlock_irqrestore(&priv->lock, flags);
 		netif_tx_unlock_bh(dev);

