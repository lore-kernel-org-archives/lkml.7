Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3705FC43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 15:53:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07F2A20663
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 15:53:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727010AbfCFPxW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 10:53:22 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45276 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726606AbfCFPvM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 10:51:12 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7D1B63089EC5;
        Wed,  6 Mar 2019 15:51:11 +0000 (UTC)
Received: from virtlab420.virt.lab.eng.bos.redhat.com (virtlab420.virt.lab.eng.bos.redhat.com [10.19.152.148])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D571F1001DF7;
        Wed,  6 Mar 2019 15:51:09 +0000 (UTC)
From:   Nitesh Narayan Lal <nitesh@redhat.com>
To:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, pbonzini@redhat.com, lcapitulino@redhat.com,
        pagupta@redhat.com, wei.w.wang@intel.com, yang.zhang.wz@gmail.com,
        riel@surriel.com, david@redhat.com, mst@redhat.com,
        dodgen@google.com, konrad.wilk@oracle.com, dhildenb@redhat.com,
        aarcange@redhat.com, alexander.duyck@gmail.com
Subject: [RFC][Patch v9 1/6] KVM: Guest free page hinting support
Date:   Wed,  6 Mar 2019 10:50:43 -0500
Message-Id: <20190306155048.12868-2-nitesh@redhat.com>
In-Reply-To: <20190306155048.12868-1-nitesh@redhat.com>
References: <20190306155048.12868-1-nitesh@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Wed, 06 Mar 2019 15:51:11 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the following:
1. Functional skeleton for the guest implementation. It enables the
guest to maintain the PFN of head buddy free pages of order
FREE_PAGE_HINTING_MIN_ORDER (currently defined as MAX_ORDER - 1)
in a per-cpu array.
Guest uses guest_free_page_enqueue() to enqueue the free pages post buddy
merging to the above mentioned per-cpu array.
guest_free_page_try_hinting() is used to initiate hinting operation once
the collected entries of the per-cpu array reaches or exceeds
HINTING_THRESHOLD (128). Having larger array size(MAX_FGPT_ENTRIES = 256)
than HINTING_THRESHOLD allows us to capture more pages specifically when
guest_free_page_enqueue() is called from free_pcppages_bulk().
For now guest_free_page_hinting() just resets the array index to continue
capturing of the freed pages.
2. Enables the support for x86 architecture.

Signed-off-by: Nitesh Narayan Lal <nitesh@redhat.com>
---
 arch/x86/Kbuild              |  2 +-
 arch/x86/kvm/Kconfig         |  8 +++
 arch/x86/kvm/Makefile        |  2 +
 include/linux/page_hinting.h | 15 ++++++
 mm/page_alloc.c              |  5 ++
 virt/kvm/page_hinting.c      | 98 ++++++++++++++++++++++++++++++++++++
 6 files changed, 129 insertions(+), 1 deletion(-)
 create mode 100644 include/linux/page_hinting.h
 create mode 100644 virt/kvm/page_hinting.c

diff --git a/arch/x86/Kbuild b/arch/x86/Kbuild
index c625f57472f7..3244df4ee311 100644
--- a/arch/x86/Kbuild
+++ b/arch/x86/Kbuild
@@ -2,7 +2,7 @@ obj-y += entry/
 
 obj-$(CONFIG_PERF_EVENTS) += events/
 
-obj-$(CONFIG_KVM) += kvm/
+obj-$(subst m,y,$(CONFIG_KVM)) += kvm/
 
 # Xen paravirtualization support
 obj-$(CONFIG_XEN) += xen/
diff --git a/arch/x86/kvm/Kconfig b/arch/x86/kvm/Kconfig
index 72fa955f4a15..2fae31459706 100644
--- a/arch/x86/kvm/Kconfig
+++ b/arch/x86/kvm/Kconfig
@@ -96,6 +96,14 @@ config KVM_MMU_AUDIT
 	 This option adds a R/W kVM module parameter 'mmu_audit', which allows
 	 auditing of KVM MMU events at runtime.
 
+# KVM_FREE_PAGE_HINTING will allow the guest to report the free pages to the
+# host in regular interval of time.
+config KVM_FREE_PAGE_HINTING
+       def_bool y
+       depends on KVM
+       select VIRTIO
+       select VIRTIO_BALLOON
+
 # OK, it's a little counter-intuitive to do this, but it puts it neatly under
 # the virtualization menu.
 source "drivers/vhost/Kconfig"
diff --git a/arch/x86/kvm/Makefile b/arch/x86/kvm/Makefile
index 69b3a7c30013..78640a80501e 100644
--- a/arch/x86/kvm/Makefile
+++ b/arch/x86/kvm/Makefile
@@ -16,6 +16,8 @@ kvm-y			+= x86.o mmu.o emulate.o i8259.o irq.o lapic.o \
 			   i8254.o ioapic.o irq_comm.o cpuid.o pmu.o mtrr.o \
 			   hyperv.o page_track.o debugfs.o
 
+obj-$(CONFIG_KVM_FREE_PAGE_HINTING)    += $(KVM)/page_hinting.o
+
 kvm-intel-y		+= vmx/vmx.o vmx/vmenter.o vmx/pmu_intel.o vmx/vmcs12.o vmx/evmcs.o vmx/nested.o
 kvm-amd-y		+= svm.o pmu_amd.o
 
diff --git a/include/linux/page_hinting.h b/include/linux/page_hinting.h
new file mode 100644
index 000000000000..90254c582789
--- /dev/null
+++ b/include/linux/page_hinting.h
@@ -0,0 +1,15 @@
+#include <linux/gfp.h>
+/*
+ * Size of the array which is used to store the freed pages is defined by
+ * MAX_FGPT_ENTRIES.
+ */
+#define MAX_FGPT_ENTRIES	256
+/*
+ * Threshold value after which hinting needs to be initiated on the captured
+ * free pages.
+ */
+#define HINTING_THRESHOLD	128
+#define FREE_PAGE_HINTING_MIN_ORDER	(MAX_ORDER - 1)
+
+void guest_free_page_enqueue(struct page *page, int order);
+void guest_free_page_try_hinting(void);
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index d295c9bc01a8..684d047f33ee 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -67,6 +67,7 @@
 #include <linux/lockdep.h>
 #include <linux/nmi.h>
 #include <linux/psi.h>
+#include <linux/page_hinting.h>
 
 #include <asm/sections.h>
 #include <asm/tlbflush.h>
@@ -1194,9 +1195,11 @@ static void free_pcppages_bulk(struct zone *zone, int count,
 			mt = get_pageblock_migratetype(page);
 
 		__free_one_page(page, page_to_pfn(page), zone, 0, mt);
+		guest_free_page_enqueue(page, 0);
 		trace_mm_page_pcpu_drain(page, 0, mt);
 	}
 	spin_unlock(&zone->lock);
+	guest_free_page_try_hinting();
 }
 
 static void free_one_page(struct zone *zone,
@@ -1210,7 +1213,9 @@ static void free_one_page(struct zone *zone,
 		migratetype = get_pfnblock_migratetype(page, pfn);
 	}
 	__free_one_page(page, pfn, zone, order, migratetype);
+	guest_free_page_enqueue(page, order);
 	spin_unlock(&zone->lock);
+	guest_free_page_try_hinting();
 }
 
 static void __meminit __init_single_page(struct page *page, unsigned long pfn,
diff --git a/virt/kvm/page_hinting.c b/virt/kvm/page_hinting.c
new file mode 100644
index 000000000000..48b4b5e796b0
--- /dev/null
+++ b/virt/kvm/page_hinting.c
@@ -0,0 +1,98 @@
+#include <linux/mm.h>
+#include <linux/page_hinting.h>
+
+/*
+ * struct guest_free_pages- holds array of guest freed PFN's along with an
+ * index variable to track total freed PFN's.
+ * @free_pfn_arr: array to store the page frame number of all the pages which
+ * are freed by the guest.
+ * @guest_free_pages_idx: index to track the number entries stored in
+ * free_pfn_arr.
+ */
+struct guest_free_pages {
+	unsigned long free_page_arr[MAX_FGPT_ENTRIES];
+	int free_pages_idx;
+};
+
+DEFINE_PER_CPU(struct guest_free_pages, free_pages_obj);
+
+struct page *get_buddy_page(struct page *page)
+{
+	unsigned long pfn = page_to_pfn(page);
+	unsigned int order;
+
+	for (order = 0; order < MAX_ORDER; order++) {
+		struct page *page_head = page - (pfn & ((1 << order) - 1));
+
+		if (PageBuddy(page_head) && page_private(page_head) >= order)
+			return page_head;
+	}
+	return NULL;
+}
+
+static void guest_free_page_hinting(void)
+{
+	struct guest_free_pages *hinting_obj = &get_cpu_var(free_pages_obj);
+
+	hinting_obj->free_pages_idx = 0;
+	put_cpu_var(hinting_obj);
+}
+
+int if_exist(struct page *page)
+{
+	int i = 0;
+	struct guest_free_pages *hinting_obj = this_cpu_ptr(&free_pages_obj);
+
+	while (i < MAX_FGPT_ENTRIES) {
+		if (page_to_pfn(page) == hinting_obj->free_page_arr[i])
+			return 1;
+		i++;
+	}
+	return 0;
+}
+
+void guest_free_page_enqueue(struct page *page, int order)
+{
+	unsigned long flags;
+	struct guest_free_pages *hinting_obj;
+	int l_idx;
+
+	/*
+	 * use of global variables may trigger a race condition between irq and
+	 * process context causing unwanted overwrites. This will be replaced
+	 * with a better solution to prevent such race conditions.
+	 */
+	local_irq_save(flags);
+	hinting_obj = this_cpu_ptr(&free_pages_obj);
+	l_idx = hinting_obj->free_pages_idx;
+	if (l_idx != MAX_FGPT_ENTRIES) {
+		if (PageBuddy(page) && page_private(page) >=
+		    FREE_PAGE_HINTING_MIN_ORDER) {
+			hinting_obj->free_page_arr[l_idx] = page_to_pfn(page);
+			hinting_obj->free_pages_idx += 1;
+		} else {
+			struct page *buddy_page = get_buddy_page(page);
+
+			if (buddy_page && page_private(buddy_page) >=
+			    FREE_PAGE_HINTING_MIN_ORDER &&
+			    !if_exist(buddy_page)) {
+				unsigned long buddy_pfn =
+					page_to_pfn(buddy_page);
+
+				hinting_obj->free_page_arr[l_idx] =
+							buddy_pfn;
+				hinting_obj->free_pages_idx += 1;
+			}
+		}
+	}
+	local_irq_restore(flags);
+}
+
+void guest_free_page_try_hinting(void)
+{
+	struct guest_free_pages *hinting_obj;
+
+	hinting_obj = this_cpu_ptr(&free_pages_obj);
+	if (hinting_obj->free_pages_idx >= HINTING_THRESHOLD)
+		guest_free_page_hinting();
+}
-- 
2.17.2

