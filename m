Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F064C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 15:52:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29CBE20663
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 15:52:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730216AbfCFPvi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 10:51:38 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56926 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730137AbfCFPvd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 10:51:33 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B4A3DE6A88;
        Wed,  6 Mar 2019 15:51:32 +0000 (UTC)
Received: from virtlab420.virt.lab.eng.bos.redhat.com (virtlab420.virt.lab.eng.bos.redhat.com [10.19.152.148])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3078A1001DCE;
        Wed,  6 Mar 2019 15:51:31 +0000 (UTC)
From:   Nitesh Narayan Lal <nitesh@redhat.com>
To:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, pbonzini@redhat.com, lcapitulino@redhat.com,
        pagupta@redhat.com, wei.w.wang@intel.com, yang.zhang.wz@gmail.com,
        riel@surriel.com, david@redhat.com, mst@redhat.com,
        dodgen@google.com, konrad.wilk@oracle.com, dhildenb@redhat.com,
        aarcange@redhat.com, alexander.duyck@gmail.com
Subject: [RFC][Patch v9 6/6] KVM: Adding tracepoints for guest free page hinting
Date:   Wed,  6 Mar 2019 10:50:48 -0500
Message-Id: <20190306155048.12868-7-nitesh@redhat.com>
In-Reply-To: <20190306155048.12868-1-nitesh@redhat.com>
References: <20190306155048.12868-1-nitesh@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Wed, 06 Mar 2019 15:51:32 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch enables to track the pages freed by the guest and
the pages isolated by the page hinting code through kernel
tracepoints.

Signed-off-by: Nitesh Narayan Lal <nitesh@redhat.com>
---
 include/trace/events/kmem.h | 62 +++++++++++++++++++++++++++++++++++++
 virt/kvm/page_hinting.c     | 12 +++++++
 2 files changed, 74 insertions(+)

diff --git a/include/trace/events/kmem.h b/include/trace/events/kmem.h
index eb57e3037deb..0bef31484cf8 100644
--- a/include/trace/events/kmem.h
+++ b/include/trace/events/kmem.h
@@ -315,6 +315,68 @@ TRACE_EVENT(mm_page_alloc_extfrag,
 		__entry->change_ownership)
 );
 
+TRACE_EVENT(guest_free_page,
+	    TP_PROTO(unsigned long pfn, unsigned int order),
+
+	TP_ARGS(pfn, order),
+
+	TP_STRUCT__entry(
+		__field(unsigned long, pfn)
+		__field(unsigned int, order)
+	),
+
+	TP_fast_assign(
+		__entry->pfn            = pfn;
+		__entry->order          = order;
+	),
+
+	TP_printk("pfn=%lu order=%d",
+		  __entry->pfn,
+		  __entry->order)
+);
+
+TRACE_EVENT(guest_isolated_page,
+	    TP_PROTO(unsigned long pfn, unsigned int order),
+
+	TP_ARGS(pfn, order),
+
+	TP_STRUCT__entry(
+		__field(unsigned long, pfn)
+		__field(unsigned int, order)
+	),
+
+	TP_fast_assign(
+		__entry->pfn            = pfn;
+		__entry->order          = order;
+	),
+
+	TP_printk("pfn=%lu order=%u",
+		  __entry->pfn,
+		  __entry->order)
+);
+
+TRACE_EVENT(guest_captured_page,
+	    TP_PROTO(unsigned long pfn, unsigned int order, int idx),
+
+	TP_ARGS(pfn, order, idx),
+
+	TP_STRUCT__entry(
+		__field(unsigned long, pfn)
+		__field(unsigned int, order)
+		__field(int, idx)
+	),
+
+	TP_fast_assign(
+		__entry->pfn		= pfn;
+		__entry->order		= order;
+		__entry->idx		= idx;
+	),
+
+	TP_printk("pfn=%lu order=%u array_index=%d",
+		  __entry->pfn,
+		  __entry->order,
+		  __entry->idx)
+);
 #endif /* _TRACE_KMEM_H */
 
 /* This part must be outside protection */
diff --git a/virt/kvm/page_hinting.c b/virt/kvm/page_hinting.c
index 5980682e0b86..dc72f1947751 100644
--- a/virt/kvm/page_hinting.c
+++ b/virt/kvm/page_hinting.c
@@ -4,6 +4,7 @@
 #include <linux/kvm_host.h>
 #include <linux/kernel.h>
 #include <linux/sort.h>
+#include <trace/events/kmem.h>
 
 /*
  * struct guest_free_pages- holds array of guest freed PFN's along with an
@@ -178,6 +179,8 @@ static void guest_free_page_hinting(void)
 
 				ret = __isolate_free_page(page, buddy_order);
 				if (ret) {
+					trace_guest_isolated_page(pfn,
+								  buddy_order);
 					isolated_pages_obj[hyp_idx].pfn = pfn;
 					isolated_pages_obj[hyp_idx].order =
 								buddy_order;
@@ -198,6 +201,8 @@ static void guest_free_page_hinting(void)
 					unsigned long buddy_pfn =
 						page_to_pfn(buddy_page);
 
+					trace_guest_isolated_page(buddy_pfn,
+								  buddy_order);
 					isolated_pages_obj[hyp_idx].pfn =
 								buddy_pfn;
 					isolated_pages_obj[hyp_idx].order =
@@ -255,9 +260,12 @@ void guest_free_page_enqueue(struct page *page, int order)
 	local_irq_save(flags);
 	hinting_obj = this_cpu_ptr(&free_pages_obj);
 	l_idx = hinting_obj->free_pages_idx;
+	trace_guest_free_page(page_to_pfn(page), order);
 	if (l_idx != MAX_FGPT_ENTRIES) {
 		if (PageBuddy(page) && page_private(page) >=
 		    FREE_PAGE_HINTING_MIN_ORDER) {
+			trace_guest_captured_page(page_to_pfn(page), order,
+						  l_idx);
 			hinting_obj->free_page_arr[l_idx] = page_to_pfn(page);
 			hinting_obj->free_pages_idx += 1;
 		} else {
@@ -268,7 +276,11 @@ void guest_free_page_enqueue(struct page *page, int order)
 			    !if_exist(buddy_page)) {
 				unsigned long buddy_pfn =
 					page_to_pfn(buddy_page);
+				unsigned int buddy_order =
+					page_private(buddy_page);
 
+				trace_guest_captured_page(buddy_pfn,
+							  buddy_order, l_idx);
 				hinting_obj->free_page_arr[l_idx] =
 							buddy_pfn;
 				hinting_obj->free_pages_idx += 1;
-- 
2.17.2

