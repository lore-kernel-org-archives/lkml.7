Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAECFC282DA
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:47:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66B792063F
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:47:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YTr6Bzso"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727399AbfDSSrJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 14:47:09 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:45826 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727606AbfDSSrH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 14:47:07 -0400
Received: by mail-pf1-f196.google.com with SMTP id e24so2885456pfi.12
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2019 11:47:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=ZqDJUmRQOI970mqgznMp//BPfDHtx3IDfJKG+qCEt+s=;
        b=YTr6BzsoCUtNjoc9zKtqCZlOZq1NNgC9BcUTj2qdIvf9zLdydhKrFdJVpUVJ2tLgZi
         LxlxixaJXyMkjBxJQW8lMO7BQTmAjRq4dxOEjPfPxDaHKeytQjBKGOxX5hVm6ZMnMVaT
         AOAqZXh/tRJsUHHx3Z+wC+QiI2hTh6Qvqnvv8hM+8eYls0h9hHIgTmaaivKsq64/srnC
         w0XIfdpTvGJVCfaC1sqjfUazDl4h0ChcFvu9GtFNg1xAuEgwP2gkXbKJHN8S9JbrqRBF
         FlSFSk5xd6DeebfSYhZHhFl6M9hyrbKutSf4maw55jRJC9OQqKX+oLGCKatS3uwvF/U+
         FWFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ZqDJUmRQOI970mqgznMp//BPfDHtx3IDfJKG+qCEt+s=;
        b=VGgEbf8E5DqdAmJcE1AXRqsHl3clC2/HASVamd0Dpa5SyLhx5hm2eiLlx09nsDgy/r
         C5qdXhRl4cNiDQ4kWlZxHTzpECodMAywl89FmeX2mijMZVssibHpcTPriWFVNc5sTlj6
         isB20MKyTCXfk3/08jRt+5ZW2eeCcCK9eqF+FAGZR9X4qzAInyLfMYpBppSSF7mmnuw+
         GtYcNap7K30jTrn+99fVMAjIW06+1L2bgieP3EF1DG7NPfmGJdWecmWvviOfPC50vfA9
         T2n3n/hcuSbhAnLLudm5PfWawIFer3SKd621FqtPiUBR/jfXbiTrUewzXdrSEHPKlMPO
         ydzQ==
X-Gm-Message-State: APjAAAXu1+GbjUC1NJo3wPXDz6izqu/ubkUhAoe427BaC7oppvhy8uQ3
        Thhd6WpHJsmtnwi+ZZ3hCFfVDR8kE/g=
X-Google-Smtp-Source: APXvYqxSr5AX4ja+Verb5kEG+U3M0KaRTGjsEVbEESHLHmFe8iUZKvNAh3cSZnTxEBHX0/7lZ8s/gg==
X-Received: by 2002:a62:5144:: with SMTP id f65mr3889011pfb.13.1555680138029;
        Fri, 19 Apr 2019 06:22:18 -0700 (PDT)
Received: from hfq-skylake.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.googlemail.com with ESMTPSA id r11sm5546297pga.87.2019.04.19.06.22.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Apr 2019 06:22:17 -0700 (PDT)
From:   Fuqian Huang <huangfq.daxian@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Fuqian Huang <huangfq.daxian@gmail.com>
Subject: [PATCH] Fix some misuses of %x
Date:   Fri, 19 Apr 2019 21:21:58 +0800
Message-Id: <20190419132158.32420-1-huangfq.daxian@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pointers should be printed with %p or %px rather than
cast to long or unsigned long type and printed with %x.
Change %x to %p to print pointers.

Signed-off-by: Fuqian Huang <huangfq.daxian@gmail.com>
---
 drivers/atm/iphase.c               | 4 ++--
 drivers/misc/genwqe/card_debugfs.c | 4 ++--
 drivers/net/hippi/rrunner.c        | 4 ++--
 kernel/cgroup/debug.c              | 8 ++++----
 net/ax25/af_ax25.c                 | 4 ++--
 sound/isa/gus/gus_mem.c            | 2 +-
 6 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/atm/iphase.c b/drivers/atm/iphase.c
index 82532c299bb5..5278c57dce73 100644
--- a/drivers/atm/iphase.c
+++ b/drivers/atm/iphase.c
@@ -2826,8 +2826,8 @@ static int ia_ioctl(struct atm_dev *dev, unsigned int cmd, void __user *arg)
          case 0x6:
          {  
              ia_cmds.status = 0; 
-             printk("skb = 0x%lx\n", (long)skb_peek(&iadev->tx_backlog));
-             printk("rtn_q: 0x%lx\n",(long)ia_deque_rtn_q(&iadev->tx_return_q));
+             printk("skb = 0x%p\n", skb_peek(&iadev->tx_backlog));
+             printk("rtn_q: 0x%p\n",ia_deque_rtn_q(&iadev->tx_return_q));
          }
              break;
          case 0x8:
diff --git a/drivers/misc/genwqe/card_debugfs.c b/drivers/misc/genwqe/card_debugfs.c
index 7c713e01d198..6f7e39f07811 100644
--- a/drivers/misc/genwqe/card_debugfs.c
+++ b/drivers/misc/genwqe/card_debugfs.c
@@ -227,7 +227,7 @@ static int ddcb_info_show(struct seq_file *s, void *unused)
 	seq_puts(s, "DDCB QUEUE:\n");
 	seq_printf(s, "  ddcb_max:            %d\n"
 		   "  ddcb_daddr:          %016llx - %016llx\n"
-		   "  ddcb_vaddr:          %016llx\n"
+		   "  ddcb_vaddr:          %p\n"
 		   "  ddcbs_in_flight:     %u\n"
 		   "  ddcbs_max_in_flight: %u\n"
 		   "  ddcbs_completed:     %u\n"
@@ -237,7 +237,7 @@ static int ddcb_info_show(struct seq_file *s, void *unused)
 		   queue->ddcb_max, (long long)queue->ddcb_daddr,
 		   (long long)queue->ddcb_daddr +
 		   (queue->ddcb_max * DDCB_LENGTH),
-		   (long long)queue->ddcb_vaddr, queue->ddcbs_in_flight,
+		   queue->ddcb_vaddr, queue->ddcbs_in_flight,
 		   queue->ddcbs_max_in_flight, queue->ddcbs_completed,
 		   queue->return_on_busy, queue->wait_on_busy,
 		   cd->irqs_processed);
diff --git a/drivers/net/hippi/rrunner.c b/drivers/net/hippi/rrunner.c
index 029206e4da3b..0f7025f3a384 100644
--- a/drivers/net/hippi/rrunner.c
+++ b/drivers/net/hippi/rrunner.c
@@ -1298,11 +1298,11 @@ static void rr_dump(struct net_device *dev)
 	if (rrpriv->tx_skbuff[cons]){
 		len = min_t(int, 0x80, rrpriv->tx_skbuff[cons]->len);
 		printk("skbuff for cons %i is valid - dumping data (0x%x bytes - skbuff len 0x%x)\n", cons, len, rrpriv->tx_skbuff[cons]->len);
-		printk("mode 0x%x, size 0x%x,\n phys %08Lx, skbuff-addr %08lx, truesize 0x%x\n",
+		printk("mode 0x%x, size 0x%x,\n phys %08Lx, skbuff-addr %p, truesize 0x%x\n",
 		       rrpriv->tx_ring[cons].mode,
 		       rrpriv->tx_ring[cons].size,
 		       (unsigned long long) rrpriv->tx_ring[cons].addr.addrlo,
-		       (unsigned long)rrpriv->tx_skbuff[cons]->data,
+		       rrpriv->tx_skbuff[cons]->data,
 		       (unsigned int)rrpriv->tx_skbuff[cons]->truesize);
 		for (i = 0; i < len; i++){
 			if (!(i & 7))
diff --git a/kernel/cgroup/debug.c b/kernel/cgroup/debug.c
index 5f1b87330bee..80aa3f027ac3 100644
--- a/kernel/cgroup/debug.c
+++ b/kernel/cgroup/debug.c
@@ -64,8 +64,8 @@ static int current_css_set_read(struct seq_file *seq, void *v)
 		css = cset->subsys[ss->id];
 		if (!css)
 			continue;
-		seq_printf(seq, "%2d: %-4s\t- %lx[%d]\n", ss->id, ss->name,
-			  (unsigned long)css, css->id);
+		seq_printf(seq, "%2d: %-4s\t- %p[%d]\n", ss->id, ss->name,
+			  css, css->id);
 	}
 	rcu_read_unlock();
 	spin_unlock_irq(&css_set_lock);
@@ -224,8 +224,8 @@ static int cgroup_subsys_states_read(struct seq_file *seq, void *v)
 		if (css->parent)
 			snprintf(pbuf, sizeof(pbuf) - 1, " P=%d",
 				 css->parent->id);
-		seq_printf(seq, "%2d: %-4s\t- %lx[%d] %d%s\n", ss->id, ss->name,
-			  (unsigned long)css, css->id,
+		seq_printf(seq, "%2d: %-4s\t- %p[%d] %d%s\n", ss->id, ss->name,
+			  css, css->id,
 			  atomic_read(&css->online_cnt), pbuf);
 	}
 
diff --git a/net/ax25/af_ax25.c b/net/ax25/af_ax25.c
index 5d01edf8d819..90c2831297dd 100644
--- a/net/ax25/af_ax25.c
+++ b/net/ax25/af_ax25.c
@@ -1888,8 +1888,8 @@ static int ax25_info_show(struct seq_file *seq, void *v)
 	 * magic dev src_addr dest_addr,digi1,digi2,.. st vs vr va t1 t1 t2 t2 t3 t3 idle idle n2 n2 rtt window paclen Snd-Q Rcv-Q inode
 	 */
 
-	seq_printf(seq, "%8.8lx %s %s%s ",
-		   (long) ax25,
+	seq_printf(seq, "%p %s %s%s ",
+		   ax25,
 		   ax25->ax25_dev == NULL? "???" : ax25->ax25_dev->dev->name,
 		   ax2asc(buf, &ax25->source_addr),
 		   ax25->iamdigi? "*":"");
diff --git a/sound/isa/gus/gus_mem.c b/sound/isa/gus/gus_mem.c
index 4ac76f46dd76..63e790fbf066 100644
--- a/sound/isa/gus/gus_mem.c
+++ b/sound/isa/gus/gus_mem.c
@@ -306,7 +306,7 @@ static void snd_gf1_mem_info_read(struct snd_info_entry *entry,
 	used = 0;
 	for (block = alloc->first, i = 0; block; block = block->next, i++) {
 		used += block->size;
-		snd_iprintf(buffer, "Block %i at 0x%lx onboard 0x%x size %i (0x%x):\n", i, (long) block, block->ptr, block->size, block->size);
+		snd_iprintf(buffer, "Block %i at 0x%p onboard 0x%x size %i (0x%x):\n", i, block, block->ptr, block->size, block->size);
 		if (block->share ||
 		    block->share_id[0] || block->share_id[1] ||
 		    block->share_id[2] || block->share_id[3])
-- 
2.11.0

