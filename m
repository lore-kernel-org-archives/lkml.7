Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB035C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:12:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A95AB2184D
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:12:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552410741;
	bh=KHrh7oLVWgWzzIPspY+2+7Cu5s3//46tCOi4tWc20bI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Qr+wHNTFoSCF5tUyRU1a0/M20GL1XxDF9ABKaXS+uaLK86xPQMhbZpVF9CLWD5e3s
	 g+6I1x3YPWUdH1SCfQGX9KR/1gF6aS37sXx9uwfLQMNYMeiOaJeYMhIJjxZC+QrWHs
	 Q/psumzUXGIviz/XNJO2CCMomDSogv3fOHS5XD+Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727404AbfCLRMU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 13:12:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:46500 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727271AbfCLRMF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 13:12:05 -0400
Received: from localhost (unknown [104.133.8.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CAC7E214AF;
        Tue, 12 Mar 2019 17:12:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552410723;
        bh=KHrh7oLVWgWzzIPspY+2+7Cu5s3//46tCOi4tWc20bI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UrEl+JVwvLHp9NAu86Nq107/LZY3dIuTEceLoPgmVFq4he7xKHd8PHZY4Xs9h3Ac8
         D57xR8CrAtkgHsB34/cWT1EM3yAArRCPUcvzCCP1Cbd7MPcd6iFbW1zzHVpXmbra18
         mKPKJdX1knhV4/ESB3JSZcqtH5i3hzD1Fl0SvKWQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Feras Daoud <ferasda@mellanox.com>,
        Erez Shitrit <erezsh@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 023/171] IB/ipoib: Fix for use-after-free in ipoib_cm_tx_start
Date:   Tue, 12 Mar 2019 10:06:43 -0700
Message-Id: <20190312170349.966693387@linuxfoundation.org>
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

[ Upstream commit 6ab4aba00f811a5265acc4d3eb1863bb3ca60562 ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/ulp/ipoib/ipoib.h    | 1 -
 drivers/infiniband/ulp/ipoib/ipoib_cm.c | 3 +--
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/infiniband/ulp/ipoib/ipoib.h b/drivers/infiniband/ulp/ipoib/ipoib.h
index 1da119d901a9..73e808c1e6ad 100644
--- a/drivers/infiniband/ulp/ipoib/ipoib.h
+++ b/drivers/infiniband/ulp/ipoib/ipoib.h
@@ -248,7 +248,6 @@ struct ipoib_cm_tx {
 	struct list_head     list;
 	struct net_device   *dev;
 	struct ipoib_neigh  *neigh;
-	struct ipoib_path   *path;
 	struct ipoib_tx_buf *tx_ring;
 	unsigned int	     tx_head;
 	unsigned int	     tx_tail;
diff --git a/drivers/infiniband/ulp/ipoib/ipoib_cm.c b/drivers/infiniband/ulp/ipoib/ipoib_cm.c
index 0428e01e8f69..aa9dcfc36cd3 100644
--- a/drivers/infiniband/ulp/ipoib/ipoib_cm.c
+++ b/drivers/infiniband/ulp/ipoib/ipoib_cm.c
@@ -1312,7 +1312,6 @@ struct ipoib_cm_tx *ipoib_cm_create_tx(struct net_device *dev, struct ipoib_path
 
 	neigh->cm = tx;
 	tx->neigh = neigh;
-	tx->path = path;
 	tx->dev = dev;
 	list_add(&tx->list, &priv->cm.start_list);
 	set_bit(IPOIB_FLAG_INITIALIZED, &tx->flags);
@@ -1371,7 +1370,7 @@ static void ipoib_cm_tx_start(struct work_struct *work)
 				neigh->daddr + QPN_AND_OPTIONS_OFFSET);
 			goto free_neigh;
 		}
-		memcpy(&pathrec, &p->path->pathrec, sizeof(pathrec));
+		memcpy(&pathrec, &path->pathrec, sizeof(pathrec));
 
 		spin_unlock_irqrestore(&priv->lock, flags);
 		netif_tx_unlock_bh(dev);
-- 
2.19.1



