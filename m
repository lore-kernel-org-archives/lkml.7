Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39CDFC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 02:11:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7CEE20820
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 02:11:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sent.com header.i=@sent.com header.b="P/2vymj9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="8LiFw7Ip"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728173AbfDDCK5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 22:10:57 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:46577 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726528AbfDDCJr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 22:09:47 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id A41B922694;
        Wed,  3 Apr 2019 22:01:26 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Wed, 03 Apr 2019 22:01:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=from
        :to:cc:subject:date:message-id:in-reply-to:references:reply-to
        :mime-version:content-transfer-encoding; s=fm3; bh=6ZpqxtTHTHc65
        gkfR21N4lwZirSEr4tGkw1nMDmRxNg=; b=P/2vymj9CobgSqo/KRxkjY3P/RjnS
        mIIrbc/li7lTPkHRWM+arjKvaG0SeqSZSDBWZ/8MT2JovStY/VPvGUSvjmv6cY1N
        oggj1vnYt0MQ9DcGsCBFQqcA4r7fn64o5qgsoP6FUWPAoEf9GdNCnyhy8lUy2fjF
        rOSf/81l3/42yl3V9G8hB2Hz/L+ftlIsfQltHa3jAT3HfVT9Ah1zY2wgxdkC9eQ6
        IjpsyfKVK7jwi1pkmpWL5XhNJqjM2XzifAIGwGKnCtDFNB33J5LlFyiwfcWAzn2A
        s+zWWm43pwmspzERIz4UcYDrXj7jsvZ6vU9VxS06VPWowoFYhlGabCqUg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:reply-to:subject
        :to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=6ZpqxtTHTHc65gkfR21N4lwZirSEr4tGkw1nMDmRxNg=; b=8LiFw7Ip
        Wot0oSyhzmOsxW7f8bKtllJDgs5MI+TwfS97Ur3S+I3Mvx0k/sx/KU4W3PjumwmZ
        MHrkmvuXkfqzSzSTIlNOB/brsXAJSVappV/7vF28jDQis6Ec006ZtAhr1QqcWRJP
        kjh++V2ker12Az9NOFYKgiBrk8EukNLApg3sTWEUj8C3PLSYRuLC9PLVwf64hm6V
        z0xqmmRKnFkd5vVgRE9tXFVe9IElSEiouQTli5fa275eHrxcn2WSU9KW3uvjqFuo
        UgU46Xyg5sBIvx224RbGwqHtDJ8QnF+5A/Gy7lKU53UVrVraWDzOb8h+M6pETLsf
        f9PelGzAOtuGTw==
X-ME-Sender: <xms:dmWlXFaP28Q-EfUKyh8JBGGenuZvZhcbdohzzVjNNiYunfIHDRLHSw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduuddrtdeggdehudculddtuddrgedutddrtddtmd
    cutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvffufffkofgjfhhrggfgsedtkeertdertddt
    necuhfhrohhmpegkihcujggrnhcuoeiiihdrhigrnhesshgvnhhtrdgtohhmqeenucfkph
    epvdduiedrvddvkedrudduvddrvddvnecurfgrrhgrmhepmhgrihhlfhhrohhmpeiiihdr
    higrnhesshgvnhhtrdgtohhmnecuvehluhhsthgvrhfuihiivgepge
X-ME-Proxy: <xmx:dmWlXC7BF718WD1geqao7kKzjMOYgf4DN21pMSs5u88wD_ExxIPyQw>
    <xmx:dmWlXLI1ETSmEcrUNSA8neKiqOCLEjjovRqaWYwlRluVz1rYMWgxYw>
    <xmx:dmWlXNpdCryKN8HNkykQsn3nqYKpJ9Lze_MkqUvRKAc-tTmO2oOX2A>
    <xmx:dmWlXKhTOwf-nr576_nhpr0eNRDEsDpdmHxiiKJFtRNWJ3VpIAzi0A>
Received: from nvrsysarch5.nvidia.com (thunderhill.nvidia.com [216.228.112.22])
        by mail.messagingengine.com (Postfix) with ESMTPA id D5C6C10310;
        Wed,  3 Apr 2019 22:01:24 -0400 (EDT)
From:   Zi Yan <zi.yan@sent.com>
To:     Dave Hansen <dave.hansen@linux.intel.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Keith Busch <keith.busch@intel.com>,
        Fengguang Wu <fengguang.wu@intel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     Daniel Jordan <daniel.m.jordan@oracle.com>,
        Michal Hocko <mhocko@kernel.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>,
        John Hubbard <jhubbard@nvidia.com>,
        Mark Hairgrove <mhairgrove@nvidia.com>,
        Nitin Gupta <nigupta@nvidia.com>,
        Javier Cabezas <jcabezas@nvidia.com>,
        David Nellans <dnellans@nvidia.com>, Zi Yan <ziy@nvidia.com>
Subject: [RFC PATCH 07/25] mm: migrate: Add copy_page_dma to use DMA Engine to copy pages.
Date:   Wed,  3 Apr 2019 19:00:28 -0700
Message-Id: <20190404020046.32741-8-zi.yan@sent.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190404020046.32741-1-zi.yan@sent.com>
References: <20190404020046.32741-1-zi.yan@sent.com>
Reply-To: ziy@nvidia.com
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zi Yan <ziy@nvidia.com>

vm.use_all_dma_chans will grab all usable DMA channels
vm.limit_dma_chans will limit how many DMA channels in use

Signed-off-by: Zi Yan <ziy@nvidia.com>
---
 include/linux/highmem.h      |   1 +
 include/linux/sched/sysctl.h |   3 +
 kernel/sysctl.c              |  19 +++
 mm/copy_page.c               | 291 +++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 314 insertions(+)

diff --git a/include/linux/highmem.h b/include/linux/highmem.h
index 0f50dc5..119bb39 100644
--- a/include/linux/highmem.h
+++ b/include/linux/highmem.h
@@ -277,5 +277,6 @@ static inline void copy_highpage(struct page *to, struct page *from)
 #endif
 
 int copy_page_multithread(struct page *to, struct page *from, int nr_pages);
+int copy_page_dma(struct page *to, struct page *from, int nr_pages);
 
 #endif /* _LINUX_HIGHMEM_H */
diff --git a/include/linux/sched/sysctl.h b/include/linux/sched/sysctl.h
index 99ce6d7..ce11241 100644
--- a/include/linux/sched/sysctl.h
+++ b/include/linux/sched/sysctl.h
@@ -90,4 +90,7 @@ extern int sched_energy_aware_handler(struct ctl_table *table, int write,
 				 loff_t *ppos);
 #endif
 
+extern int sysctl_dma_page_migration(struct ctl_table *table, int write,
+				 void __user *buffer, size_t *lenp,
+				 loff_t *ppos);
 #endif /* _LINUX_SCHED_SYSCTL_H */
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 0eae0b8..b8712eb 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -103,6 +103,8 @@
 
 extern int accel_page_copy;
 extern unsigned int limit_mt_num;
+extern int use_all_dma_chans;
+extern int limit_dma_chans;
 
 /* External variables not in a header file. */
 extern int suid_dumpable;
@@ -1451,6 +1453,23 @@ static struct ctl_table vm_table[] = {
 		.extra1		= &zero,
 	},
 	 {
+		.procname	= "use_all_dma_chans",
+		.data		= &use_all_dma_chans,
+		.maxlen		= sizeof(use_all_dma_chans),
+		.mode		= 0644,
+		.proc_handler	= sysctl_dma_page_migration,
+		.extra1		= &zero,
+		.extra2		= &one,
+	 },
+	 {
+		.procname	= "limit_dma_chans",
+		.data		= &limit_dma_chans,
+		.maxlen		= sizeof(limit_dma_chans),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec,
+		.extra1		= &zero,
+	 },
+	 {
 		.procname	= "hugetlb_shm_group",
 		.data		= &sysctl_hugetlb_shm_group,
 		.maxlen		= sizeof(gid_t),
diff --git a/mm/copy_page.c b/mm/copy_page.c
index 6665e3d..5e7a797 100644
--- a/mm/copy_page.c
+++ b/mm/copy_page.c
@@ -126,3 +126,294 @@ int copy_page_multithread(struct page *to, struct page *from, int nr_pages)
 
 	return err;
 }
+/* ======================== DMA copy page ======================== */
+#include <linux/dmaengine.h>
+#include <linux/dma-mapping.h>
+
+#define NUM_AVAIL_DMA_CHAN 16
+
+
+int use_all_dma_chans = 0;
+int limit_dma_chans = NUM_AVAIL_DMA_CHAN;
+
+
+struct dma_chan *copy_chan[NUM_AVAIL_DMA_CHAN] = {0};
+struct dma_device *copy_dev[NUM_AVAIL_DMA_CHAN] = {0};
+
+
+
+#ifdef CONFIG_PROC_SYSCTL
+extern int proc_dointvec_minmax(struct ctl_table *table, int write,
+		  void __user *buffer, size_t *lenp, loff_t *ppos);
+int sysctl_dma_page_migration(struct ctl_table *table, int write,
+				 void __user *buffer, size_t *lenp,
+				 loff_t *ppos)
+{
+	int err = 0;
+	int use_all_dma_chans_prior_val = use_all_dma_chans;
+	dma_cap_mask_t copy_mask;
+
+	if (write && !capable(CAP_SYS_ADMIN))
+		return -EPERM;
+
+	err = proc_dointvec_minmax(table, write, buffer, lenp, ppos);
+
+	if (err < 0)
+		return err;
+	if (write) {
+		/* Grab all DMA channels  */
+		if (use_all_dma_chans_prior_val == 0 && use_all_dma_chans == 1) {
+			int i;
+
+			dma_cap_zero(copy_mask);
+			dma_cap_set(DMA_MEMCPY, copy_mask);
+
+			dmaengine_get();
+			for (i = 0; i < NUM_AVAIL_DMA_CHAN; ++i) {
+				if (!copy_chan[i]) {
+					copy_chan[i] = dma_request_channel(copy_mask, NULL, NULL);
+				}
+				if (!copy_chan[i]) {
+					pr_err("%s: cannot grab channel: %d\n", __func__, i);
+					continue;
+				}
+
+				copy_dev[i] = copy_chan[i]->device;
+
+				if (!copy_dev[i]) {
+					pr_err("%s: no device: %d\n", __func__, i);
+					continue;
+				}
+			}
+
+		}
+		/* Release all DMA channels  */
+		else if (use_all_dma_chans_prior_val == 1 && use_all_dma_chans == 0) {
+			int i;
+
+			for (i = 0; i < NUM_AVAIL_DMA_CHAN; ++i) {
+				if (copy_chan[i]) {
+					dma_release_channel(copy_chan[i]);
+					copy_chan[i] = NULL;
+					copy_dev[i] = NULL;
+				}
+			}
+
+			dmaengine_put();
+		}
+
+		if (err)
+			use_all_dma_chans = use_all_dma_chans_prior_val;
+	}
+	return err;
+}
+
+#endif
+
+static int copy_page_dma_once(struct page *to, struct page *from, int nr_pages)
+{
+	static struct dma_chan *copy_chan = NULL;
+	struct dma_device *device = NULL;
+	struct dma_async_tx_descriptor *tx = NULL;
+	dma_cookie_t cookie;
+	enum dma_ctrl_flags flags = 0;
+	struct dmaengine_unmap_data *unmap = NULL;
+	dma_cap_mask_t mask;
+	int ret_val = 0;
+
+
+	dma_cap_zero(mask);
+	dma_cap_set(DMA_MEMCPY, mask);
+
+	dmaengine_get();
+
+	copy_chan = dma_request_channel(mask, NULL, NULL);
+
+	if (!copy_chan) {
+		pr_err("%s: cannot get a channel\n", __func__);
+		ret_val = -1;
+		goto no_chan;
+	}
+
+	device = copy_chan->device;
+
+	if (!device) {
+		pr_err("%s: cannot get a device\n", __func__);
+		ret_val = -2;
+		goto release;
+	}
+
+	unmap = dmaengine_get_unmap_data(device->dev, 2, GFP_NOWAIT);
+
+	if (!unmap) {
+		pr_err("%s: cannot get unmap data\n", __func__);
+		ret_val = -3;
+		goto release;
+	}
+
+	unmap->to_cnt = 1;
+	unmap->addr[0] = dma_map_page(device->dev, from, 0, PAGE_SIZE*nr_pages,
+					  DMA_TO_DEVICE);
+	unmap->from_cnt = 1;
+	unmap->addr[1] = dma_map_page(device->dev, to, 0, PAGE_SIZE*nr_pages,
+					  DMA_FROM_DEVICE);
+	unmap->len = PAGE_SIZE*nr_pages;
+
+	tx = device->device_prep_dma_memcpy(copy_chan,
+						unmap->addr[1],
+						unmap->addr[0], unmap->len,
+						flags);
+
+	if (!tx) {
+		pr_err("%s: null tx descriptor\n", __func__);
+		ret_val = -4;
+		goto unmap_dma;
+	}
+
+	cookie = tx->tx_submit(tx);
+
+	if (dma_submit_error(cookie)) {
+		pr_err("%s: submission error\n", __func__);
+		ret_val = -5;
+		goto unmap_dma;
+	}
+
+	if (dma_sync_wait(copy_chan, cookie) != DMA_COMPLETE) {
+		pr_err("%s: dma does not complete properly\n", __func__);
+		ret_val = -6;
+	}
+
+unmap_dma:
+	dmaengine_unmap_put(unmap);
+release:
+	if (copy_chan) {
+		dma_release_channel(copy_chan);
+	}
+no_chan:
+	dmaengine_put();
+
+	return ret_val;
+}
+
+static int copy_page_dma_always(struct page *to, struct page *from, int nr_pages)
+{
+	struct dma_async_tx_descriptor *tx[NUM_AVAIL_DMA_CHAN] = {0};
+	dma_cookie_t cookie[NUM_AVAIL_DMA_CHAN];
+	enum dma_ctrl_flags flags[NUM_AVAIL_DMA_CHAN] = {0};
+	struct dmaengine_unmap_data *unmap[NUM_AVAIL_DMA_CHAN] = {0};
+	int ret_val = 0;
+	int total_available_chans = NUM_AVAIL_DMA_CHAN;
+	int i;
+	size_t page_offset;
+
+	for (i = 0; i < NUM_AVAIL_DMA_CHAN; ++i) {
+		if (!copy_chan[i]) {
+			total_available_chans = i;
+		}
+	}
+	if (total_available_chans != NUM_AVAIL_DMA_CHAN) {
+		pr_err("%d channels are missing", NUM_AVAIL_DMA_CHAN - total_available_chans);
+	}
+
+	total_available_chans = min_t(int, total_available_chans, limit_dma_chans);
+
+	/* round down to closest 2^x value  */
+	total_available_chans = 1<<ilog2(total_available_chans);
+
+	if ((nr_pages != 1) && (nr_pages % total_available_chans != 0))
+		return -5;
+
+	for (i = 0; i < total_available_chans; ++i) {
+		unmap[i] = dmaengine_get_unmap_data(copy_dev[i]->dev, 2, GFP_NOWAIT);
+		if (!unmap[i]) {
+			pr_err("%s: no unmap data at chan %d\n", __func__, i);
+			ret_val = -3;
+			goto unmap_dma;
+		}
+	}
+
+	for (i = 0; i < total_available_chans; ++i) {
+		if (nr_pages == 1) {
+			page_offset = PAGE_SIZE / total_available_chans;
+
+			unmap[i]->to_cnt = 1;
+			unmap[i]->addr[0] = dma_map_page(copy_dev[i]->dev, from, page_offset*i,
+							  page_offset,
+							  DMA_TO_DEVICE);
+			unmap[i]->from_cnt = 1;
+			unmap[i]->addr[1] = dma_map_page(copy_dev[i]->dev, to, page_offset*i,
+							  page_offset,
+							  DMA_FROM_DEVICE);
+			unmap[i]->len = page_offset;
+		} else {
+			page_offset = nr_pages / total_available_chans;
+
+			unmap[i]->to_cnt = 1;
+			unmap[i]->addr[0] = dma_map_page(copy_dev[i]->dev,
+								from + page_offset*i,
+								0,
+								PAGE_SIZE*page_offset,
+								DMA_TO_DEVICE);
+			unmap[i]->from_cnt = 1;
+			unmap[i]->addr[1] = dma_map_page(copy_dev[i]->dev,
+								to + page_offset*i,
+								0,
+								PAGE_SIZE*page_offset,
+								DMA_FROM_DEVICE);
+			unmap[i]->len = PAGE_SIZE*page_offset;
+		}
+	}
+
+	for (i = 0; i < total_available_chans; ++i) {
+		tx[i] = copy_dev[i]->device_prep_dma_memcpy(copy_chan[i],
+							unmap[i]->addr[1],
+							unmap[i]->addr[0],
+							unmap[i]->len,
+							flags[i]);
+		if (!tx[i]) {
+			pr_err("%s: no tx descriptor at chan %d\n", __func__, i);
+			ret_val = -4;
+			goto unmap_dma;
+		}
+	}
+
+	for (i = 0; i < total_available_chans; ++i) {
+		cookie[i] = tx[i]->tx_submit(tx[i]);
+
+		if (dma_submit_error(cookie[i])) {
+			pr_err("%s: submission error at chan %d\n", __func__, i);
+			ret_val = -5;
+			goto unmap_dma;
+		}
+
+		dma_async_issue_pending(copy_chan[i]);
+	}
+
+	for (i = 0; i < total_available_chans; ++i) {
+		if (dma_sync_wait(copy_chan[i], cookie[i]) != DMA_COMPLETE) {
+			ret_val = -6;
+			pr_err("%s: dma does not complete at chan %d\n", __func__, i);
+		}
+	}
+
+unmap_dma:
+
+	for (i = 0; i < total_available_chans; ++i) {
+		if (unmap[i])
+			dmaengine_unmap_put(unmap[i]);
+	}
+
+	return ret_val;
+}
+
+int copy_page_dma(struct page *to, struct page *from, int nr_pages)
+{
+	BUG_ON(hpage_nr_pages(from) != nr_pages);
+	BUG_ON(hpage_nr_pages(to) != nr_pages);
+
+	if (!use_all_dma_chans) {
+		return copy_page_dma_once(to, from, nr_pages);
+	}
+
+	return copy_page_dma_always(to, from, nr_pages);
+}
-- 
2.7.4

