Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DATE_IN_FUTURE_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A31C4C10F00
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 17:09:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B3652075C
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 17:09:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728388AbfC0RJc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 13:09:32 -0400
Received: from ex13-edg-ou-002.vmware.com ([208.91.0.190]:2369 "EHLO
        EX13-EDG-OU-002.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727534AbfC0RJb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 13:09:31 -0400
Received: from sc9-mailhost2.vmware.com (10.113.161.72) by
 EX13-EDG-OU-002.vmware.com (10.113.208.156) with Microsoft SMTP Server id
 15.0.1156.6; Wed, 27 Mar 2019 10:09:16 -0700
Received: from namit-esx4.eng.vmware.com (sc2-hs2-general-dhcp-219-51.eng.vmware.com [10.172.219.51])
        by sc9-mailhost2.vmware.com (Postfix) with ESMTP id EA139B212A;
        Wed, 27 Mar 2019 13:09:29 -0400 (EDT)
From:   Nadav Amit <namit@vmware.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>
CC:     "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        <virtualization@lists.linux-foundation.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>,
        "VMware, Inc." <pv-drivers@vmware.com>,
        Julien Freche <jfreche@vmware.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Nadav Amit <namit@vmware.com>
Subject: [PATCH v2 4/4] vmw_balloon: split refused pages
Date:   Thu, 28 Mar 2019 01:07:18 +0000
Message-ID: <20190328010718.2248-5-namit@vmware.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190328010718.2248-1-namit@vmware.com>
References: <20190328010718.2248-1-namit@vmware.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
Received-SPF: None (EX13-EDG-OU-002.vmware.com: namit@vmware.com does not
 designate permitted sender hosts)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The hypervisor might refuse to inflate pages. While the balloon driver
handles this scenario correctly, a refusal to inflate a 2MB pages might
cause the same page to be allocated again later just for its inflation
to be refused again. This wastes energy and time.

To avoid this situation, split the 2MB page to 4KB pages, and then try
to inflate each one individually. Most of the 4KB pages out of the 2MB
should be inflated successfully, and the balloon is likely to prevent
the scenario of repeated refused inflation.

Reviewed-by: Xavier Deguillard <xdeguillard@vmware.com>
Signed-off-by: Nadav Amit <namit@vmware.com>
---
 drivers/misc/vmw_balloon.c | 63 +++++++++++++++++++++++++++++++-------
 1 file changed, 52 insertions(+), 11 deletions(-)

diff --git a/drivers/misc/vmw_balloon.c b/drivers/misc/vmw_balloon.c
index 59d3c0202dcc..65ce8b41cd66 100644
--- a/drivers/misc/vmw_balloon.c
+++ b/drivers/misc/vmw_balloon.c
@@ -239,6 +239,7 @@ static DEFINE_STATIC_KEY_FALSE(balloon_stat_enabled);
 struct vmballoon_ctl {
 	struct list_head pages;
 	struct list_head refused_pages;
+	struct list_head prealloc_pages;
 	unsigned int n_refused_pages;
 	unsigned int n_pages;
 	enum vmballoon_page_size_type page_size;
@@ -668,15 +669,25 @@ static int vmballoon_alloc_page_list(struct vmballoon *b,
 	unsigned int i;
 
 	for (i = 0; i < req_n_pages; i++) {
-		if (ctl->page_size == VMW_BALLOON_2M_PAGE)
-			page = alloc_pages(__GFP_HIGHMEM|__GFP_NOWARN|
+		/*
+		 * First check if we happen to have pages that were allocated
+		 * before. This happens when 2MB page rejected during inflation
+		 * by the hypervisor, and then split into 4KB pages.
+		 */
+		if (!list_empty(&ctl->prealloc_pages)) {
+			page = list_first_entry(&ctl->prealloc_pages,
+						struct page, lru);
+			list_del(&page->lru);
+		} else {
+			if (ctl->page_size == VMW_BALLOON_2M_PAGE)
+				page = alloc_pages(__GFP_HIGHMEM|__GFP_NOWARN|
 					__GFP_NOMEMALLOC, VMW_BALLOON_2M_ORDER);
-		else
-			page = balloon_page_alloc();
+			else
+				page = balloon_page_alloc();
 
-		/* Update statistics */
-		vmballoon_stats_page_inc(b, VMW_BALLOON_PAGE_STAT_ALLOC,
-					 ctl->page_size);
+			vmballoon_stats_page_inc(b, VMW_BALLOON_PAGE_STAT_ALLOC,
+						 ctl->page_size);
+		}
 
 		if (page) {
 			vmballoon_mark_page_offline(page, ctl->page_size);
@@ -922,7 +933,8 @@ static void vmballoon_release_page_list(struct list_head *page_list,
 		__free_pages(page, vmballoon_page_order(page_size));
 	}
 
-	*n_pages = 0;
+	if (n_pages)
+		*n_pages = 0;
 }
 
 
@@ -1054,6 +1066,32 @@ static void vmballoon_dequeue_page_list(struct vmballoon *b,
 	*n_pages = i;
 }
 
+/**
+ * vmballoon_split_refused_pages() - Split the 2MB refused pages to 4k.
+ *
+ * If inflation of 2MB pages was denied by the hypervisor, it is likely to be
+ * due to one or few 4KB pages. These 2MB pages may keep being allocated and
+ * then being refused. To prevent this case, this function splits the refused
+ * pages into 4KB pages and adds them into @prealloc_pages list.
+ *
+ * @ctl: pointer for the %struct vmballoon_ctl, which defines the operation.
+ */
+static void vmballoon_split_refused_pages(struct vmballoon_ctl *ctl)
+{
+	struct page *page, *tmp;
+	unsigned int i, order;
+
+	order = vmballoon_page_order(ctl->page_size);
+
+	list_for_each_entry_safe(page, tmp, &ctl->refused_pages, lru) {
+		list_del(&page->lru);
+		split_page(page, order);
+		for (i = 0; i < (1 << order); i++)
+			list_add(&page[i].lru, &ctl->prealloc_pages);
+	}
+	ctl->n_refused_pages = 0;
+}
+
 /**
  * vmballoon_inflate() - Inflate the balloon towards its target size.
  *
@@ -1065,6 +1103,7 @@ static void vmballoon_inflate(struct vmballoon *b)
 	struct vmballoon_ctl ctl = {
 		.pages = LIST_HEAD_INIT(ctl.pages),
 		.refused_pages = LIST_HEAD_INIT(ctl.refused_pages),
+		.prealloc_pages = LIST_HEAD_INIT(ctl.prealloc_pages),
 		.page_size = b->max_page_size,
 		.op = VMW_BALLOON_INFLATE
 	};
@@ -1112,10 +1151,10 @@ static void vmballoon_inflate(struct vmballoon *b)
 				break;
 
 			/*
-			 * Ignore errors from locking as we now switch to 4k
-			 * pages and we might get different errors.
+			 * Split the refused pages to 4k. This will also empty
+			 * the refused pages list.
 			 */
-			vmballoon_release_refused_pages(b, &ctl);
+			vmballoon_split_refused_pages(&ctl);
 			ctl.page_size--;
 		}
 
@@ -1129,6 +1168,8 @@ static void vmballoon_inflate(struct vmballoon *b)
 	 */
 	if (ctl.n_refused_pages != 0)
 		vmballoon_release_refused_pages(b, &ctl);
+
+	vmballoon_release_page_list(&ctl.prealloc_pages, NULL, ctl.page_size);
 }
 
 /**
-- 
2.19.1

