Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 811F6C04AB1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 17:26:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 240C7216C4
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 17:26:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="5VXqG9w6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727016AbfEIR0k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 13:26:40 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:42406 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726747AbfEIR0i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 13:26:38 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x49HJOwV151549;
        Thu, 9 May 2019 17:25:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2018-07-02;
 bh=UbPcnD6D6e3Eh92jCR1E4okj/kRSBROYdT8U3cfcw0w=;
 b=5VXqG9w6DSUZIaSV+vjgWmXpjbTmI6/CuLneUPjy8E0P0qoMdcSFEIKmp+acINNjpRnp
 ZjfHC6HnNognmTUhTZrqCoDctmiowR3WPJqjR5ctqHk1v5rzc2P4o7vrh7cS6jQJ1MxC
 gml3w17CnC2TJXLUlMCdb/PTvbPn6c2zRVlvETp8h5BIC9gbCkOV62a+7kLROqb8dVLY
 MChpLB277WR7eee63248zk7cn3N7wIpDDAzZzdCsxVfYi9kjJTwsToVsLdp3GRQ9BrTc
 2dczzmK28KZS3ZG/DXj7sUsG5bfNW2fz7TrIAm7LJquxc9UF8GxG8aaoNWY1sr4CaaaK dg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 2s94bgceek-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 09 May 2019 17:25:45 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x49HNxrG109635;
        Thu, 9 May 2019 17:25:45 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 2sagyvcg65-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 09 May 2019 17:25:44 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x49HPi42013393;
        Thu, 9 May 2019 17:25:44 GMT
Received: from aa1-ca-oracle-com.ca.oracle.com (/10.156.75.204)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 09 May 2019 10:25:43 -0700
From:   Ankur Arora <ankur.a.arora@oracle.com>
To:     linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org
Cc:     jgross@suse.com, pbonzini@redhat.com, boris.ostrovsky@oracle.com,
        konrad.wilk@oracle.com, sstabellini@kernel.org,
        joao.m.martins@oracle.com, ankur.a.arora@oracle.com
Subject: [RFC PATCH 11/16] xen/grant-table: make grant-table xenhost aware
Date:   Thu,  9 May 2019 10:25:35 -0700
Message-Id: <20190509172540.12398-12-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190509172540.12398-1-ankur.a.arora@oracle.com>
References: <20190509172540.12398-1-ankur.a.arora@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9252 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1905090100
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9252 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1905090100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Largely mechanical changes: the exported grant table symbols now take
xenhost_t * as a parameter. Also, move the grant table global state
inside xenhost_t.

If there's more than one xenhost, then initialize both.

Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 arch/x86/xen/grant-table.c |  71 +++--
 drivers/xen/grant-table.c  | 611 +++++++++++++++++++++----------------
 include/xen/grant_table.h  |  72 ++---
 include/xen/xenhost.h      |  11 +
 4 files changed, 443 insertions(+), 322 deletions(-)

diff --git a/arch/x86/xen/grant-table.c b/arch/x86/xen/grant-table.c
index ecb0d5450334..8f4b071427f9 100644
--- a/arch/x86/xen/grant-table.c
+++ b/arch/x86/xen/grant-table.c
@@ -23,48 +23,54 @@
 
 #include <asm/pgtable.h>
 
-static struct gnttab_vm_area {
+struct gnttab_vm_area {
 	struct vm_struct *area;
 	pte_t **ptes;
-} gnttab_shared_vm_area, gnttab_status_vm_area;
+};
 
-int arch_gnttab_map_shared(unsigned long *frames, unsigned long nr_gframes,
-			   unsigned long max_nr_gframes,
-			   void **__shared)
+int arch_gnttab_map_shared(xenhost_t *xh, unsigned long *frames,
+				unsigned long nr_gframes,
+				unsigned long max_nr_gframes,
+				void **__shared)
 {
 	void *shared = *__shared;
 	unsigned long addr;
 	unsigned long i;
 
 	if (shared == NULL)
-		*__shared = shared = gnttab_shared_vm_area.area->addr;
+		*__shared = shared = ((struct gnttab_vm_area *)
+					xh->gnttab_shared_vm_area)->area->addr;
 
 	addr = (unsigned long)shared;
 
 	for (i = 0; i < nr_gframes; i++) {
-		set_pte_at(&init_mm, addr, gnttab_shared_vm_area.ptes[i],
-			   mfn_pte(frames[i], PAGE_KERNEL));
+		set_pte_at(&init_mm, addr,
+			((struct gnttab_vm_area *) xh->gnttab_shared_vm_area)->ptes[i],
+			mfn_pte(frames[i], PAGE_KERNEL));
 		addr += PAGE_SIZE;
 	}
 
 	return 0;
 }
 
-int arch_gnttab_map_status(uint64_t *frames, unsigned long nr_gframes,
-			   unsigned long max_nr_gframes,
-			   grant_status_t **__shared)
+int arch_gnttab_map_status(xenhost_t *xh, uint64_t *frames,
+				unsigned long nr_gframes,
+				unsigned long max_nr_gframes,
+				grant_status_t **__shared)
 {
 	grant_status_t *shared = *__shared;
 	unsigned long addr;
 	unsigned long i;
 
 	if (shared == NULL)
-		*__shared = shared = gnttab_status_vm_area.area->addr;
+		*__shared = shared = ((struct gnttab_vm_area *)
+					xh->gnttab_status_vm_area)->area->addr;
 
 	addr = (unsigned long)shared;
 
 	for (i = 0; i < nr_gframes; i++) {
-		set_pte_at(&init_mm, addr, gnttab_status_vm_area.ptes[i],
+		set_pte_at(&init_mm, addr, ((struct gnttab_vm_area *)
+				xh->gnttab_status_vm_area)->ptes[i],
 			   mfn_pte(frames[i], PAGE_KERNEL));
 		addr += PAGE_SIZE;
 	}
@@ -72,16 +78,17 @@ int arch_gnttab_map_status(uint64_t *frames, unsigned long nr_gframes,
 	return 0;
 }
 
-void arch_gnttab_unmap(void *shared, unsigned long nr_gframes)
+void arch_gnttab_unmap(xenhost_t *xh, void *shared, unsigned long nr_gframes)
 {
 	pte_t **ptes;
 	unsigned long addr;
 	unsigned long i;
 
-	if (shared == gnttab_status_vm_area.area->addr)
-		ptes = gnttab_status_vm_area.ptes;
+	if (shared == ((struct gnttab_vm_area *)
+			xh->gnttab_status_vm_area)->area->addr)
+		ptes = ((struct gnttab_vm_area *) xh->gnttab_status_vm_area)->ptes;
 	else
-		ptes = gnttab_shared_vm_area.ptes;
+		ptes = ((struct gnttab_vm_area *) xh->gnttab_shared_vm_area)->ptes;
 
 	addr = (unsigned long)shared;
 
@@ -112,14 +119,15 @@ static void arch_gnttab_vfree(struct gnttab_vm_area *area)
 	kfree(area->ptes);
 }
 
-int arch_gnttab_init(unsigned long nr_shared, unsigned long nr_status)
+int arch_gnttab_init(xenhost_t *xh, unsigned long nr_shared, unsigned long nr_status)
 {
 	int ret;
 
 	if (!xen_pv_domain())
 		return 0;
 
-	ret = arch_gnttab_valloc(&gnttab_shared_vm_area, nr_shared);
+	ret = arch_gnttab_valloc((struct gnttab_vm_area *)
+				xh->gnttab_shared_vm_area, nr_shared);
 	if (ret < 0)
 		return ret;
 
@@ -127,13 +135,15 @@ int arch_gnttab_init(unsigned long nr_shared, unsigned long nr_status)
 	 * Always allocate the space for the status frames in case
 	 * we're migrated to a host with V2 support.
 	 */
-	ret = arch_gnttab_valloc(&gnttab_status_vm_area, nr_status);
+	ret = arch_gnttab_valloc((struct gnttab_vm_area *)
+				xh->gnttab_status_vm_area, nr_status);
 	if (ret < 0)
 		goto err;
 
 	return 0;
 err:
-	arch_gnttab_vfree(&gnttab_shared_vm_area);
+	arch_gnttab_vfree((struct gnttab_vm_area *)
+				xh->gnttab_shared_vm_area);
 	return -ENOMEM;
 }
 
@@ -142,16 +152,25 @@ int arch_gnttab_init(unsigned long nr_shared, unsigned long nr_status)
 #include <xen/xen-ops.h>
 static int __init xen_pvh_gnttab_setup(void)
 {
+	xenhost_t **xh;
+	int err;
+
 	if (!xen_pvh_domain())
 		return -ENODEV;
 
-	xen_auto_xlat_grant_frames.count = gnttab_max_grant_frames();
+	for_each_xenhost(xh) {
+		struct grant_frames *gf = (struct grant_frames *) (*xh)->auto_xlat_grant_frames;
 
-	return xen_xlate_map_ballooned_pages(&xen_auto_xlat_grant_frames.pfn,
-					     &xen_auto_xlat_grant_frames.vaddr,
-					     xen_auto_xlat_grant_frames.count);
+		gf->count = gnttab_max_grant_frames(*xh);
+
+		err = xen_xlate_map_ballooned_pages(&gf->pfn, &gf->vaddr, gf->count);
+		if (err)
+			return err;
+	}
+
+	return 0;
 }
 /* Call it _before_ __gnttab_init as we need to initialize the
- * xen_auto_xlat_grant_frames first. */
+ * auto_xlat_grant_frames first. */
 core_initcall(xen_pvh_gnttab_setup);
 #endif
diff --git a/drivers/xen/grant-table.c b/drivers/xen/grant-table.c
index ec90769907a4..959b81ade113 100644
--- a/drivers/xen/grant-table.c
+++ b/drivers/xen/grant-table.c
@@ -72,21 +72,10 @@
 #define NR_RESERVED_ENTRIES 8
 #define GNTTAB_LIST_END 0xffffffff
 
-static grant_ref_t **gnttab_list;
-static unsigned int nr_grant_frames;
-static int gnttab_free_count;
-static grant_ref_t gnttab_free_head;
 static DEFINE_SPINLOCK(gnttab_list_lock);
-struct grant_frames xen_auto_xlat_grant_frames;
 static unsigned int xen_gnttab_version;
 module_param_named(version, xen_gnttab_version, uint, 0);
 
-static union {
-	struct grant_entry_v1 *v1;
-	union grant_entry_v2 *v2;
-	void *addr;
-} gnttab_shared;
-
 /*This is a structure of function pointers for grant table*/
 struct gnttab_ops {
 	/*
@@ -103,12 +92,12 @@ struct gnttab_ops {
 	 * nr_gframes is the number of frames to map grant table. Returning
 	 * GNTST_okay means success and negative value means failure.
 	 */
-	int (*map_frames)(xen_pfn_t *frames, unsigned int nr_gframes);
+	int (*map_frames)(xenhost_t *xh, xen_pfn_t *frames, unsigned int nr_gframes);
 	/*
 	 * Release a list of frames which are mapped in map_frames for grant
 	 * entry status.
 	 */
-	void (*unmap_frames)(void);
+	void (*unmap_frames)(xenhost_t *xh);
 	/*
 	 * Introducing a valid entry into the grant table, granting the frame of
 	 * this grant entry to domain for accessing or transfering. Ref
@@ -116,7 +105,7 @@ struct gnttab_ops {
 	 * granted domain, frame is the page frame to be granted, and flags is
 	 * status of the grant entry to be updated.
 	 */
-	void (*update_entry)(grant_ref_t ref, domid_t domid,
+	void (*update_entry)(xenhost_t *xh, grant_ref_t ref, domid_t domid,
 			     unsigned long frame, unsigned flags);
 	/*
 	 * Stop granting a grant entry to domain for accessing. Ref parameter is
@@ -126,7 +115,7 @@ struct gnttab_ops {
 	 * directly and don't tear down the grant access. Otherwise, stop grant
 	 * access for this entry and return success(==1).
 	 */
-	int (*end_foreign_access_ref)(grant_ref_t ref, int readonly);
+	int (*end_foreign_access_ref)(xenhost_t *xh, grant_ref_t ref, int readonly);
 	/*
 	 * Stop granting a grant entry to domain for transfer. Ref parameter is
 	 * reference of a grant entry whose grant transfer will be stopped. If
@@ -134,14 +123,14 @@ struct gnttab_ops {
 	 * failure(==0). Otherwise, wait for the transfer to complete and then
 	 * return the frame.
 	 */
-	unsigned long (*end_foreign_transfer_ref)(grant_ref_t ref);
+	unsigned long (*end_foreign_transfer_ref)(xenhost_t *xh, grant_ref_t ref);
 	/*
 	 * Query the status of a grant entry. Ref parameter is reference of
 	 * queried grant entry, return value is the status of queried entry.
 	 * Detailed status(writing/reading) can be gotten from the return value
 	 * by bit operations.
 	 */
-	int (*query_foreign_access)(grant_ref_t ref);
+	int (*query_foreign_access)(xenhost_t *xh, grant_ref_t ref);
 };
 
 struct unmap_refs_callback_data {
@@ -149,85 +138,105 @@ struct unmap_refs_callback_data {
 	int result;
 };
 
-static const struct gnttab_ops *gnttab_interface;
+struct gnttab_private {
+	const struct gnttab_ops *gnttab_interface;
+	grant_status_t *grstatus;
+	grant_ref_t gnttab_free_head;
+	unsigned int nr_grant_frames;
+	int gnttab_free_count;
+	struct gnttab_free_callback *gnttab_free_callback_list;
+	struct grant_frames auto_xlat_grant_frames;
+	grant_ref_t **gnttab_list;
 
-/* This reflects status of grant entries, so act as a global value. */
-static grant_status_t *grstatus;
+	union {
+		struct grant_entry_v1 *v1;
+		union grant_entry_v2 *v2;
+		void *addr;
+	} gnttab_shared;
+};
 
-static struct gnttab_free_callback *gnttab_free_callback_list;
+#define gt_priv(xh) ((struct gnttab_private *) (xh)->gnttab_private)
 
-static int gnttab_expand(unsigned int req_entries);
+static int gnttab_expand(xenhost_t *xh, unsigned int req_entries);
 
 #define RPP (PAGE_SIZE / sizeof(grant_ref_t))
 #define SPP (PAGE_SIZE / sizeof(grant_status_t))
 
-static inline grant_ref_t *__gnttab_entry(grant_ref_t entry)
+static inline grant_ref_t *__gnttab_entry(xenhost_t *xh, grant_ref_t entry)
 {
-	return &gnttab_list[(entry) / RPP][(entry) % RPP];
+	struct gnttab_private *gt = gt_priv(xh);
+
+	return &gt->gnttab_list[(entry) / RPP][(entry) % RPP];
 }
 /* This can be used as an l-value */
-#define gnttab_entry(entry) (*__gnttab_entry(entry))
+#define gnttab_entry(xh, entry) (*__gnttab_entry(xh, entry))
 
-static int get_free_entries(unsigned count)
+static int get_free_entries(xenhost_t *xh, unsigned count)
 {
 	unsigned long flags;
 	int ref, rc = 0;
 	grant_ref_t head;
+	struct gnttab_private *gt = gt_priv(xh);
 
 	spin_lock_irqsave(&gnttab_list_lock, flags);
 
-	if ((gnttab_free_count < count) &&
-	    ((rc = gnttab_expand(count - gnttab_free_count)) < 0)) {
+	if ((gt->gnttab_free_count < count) &&
+	    ((rc = gnttab_expand(xh, count - gt->gnttab_free_count)) < 0)) {
 		spin_unlock_irqrestore(&gnttab_list_lock, flags);
 		return rc;
 	}
 
-	ref = head = gnttab_free_head;
-	gnttab_free_count -= count;
+	ref = head = gt->gnttab_free_head;
+	gt->gnttab_free_count -= count;
 	while (count-- > 1)
-		head = gnttab_entry(head);
-	gnttab_free_head = gnttab_entry(head);
-	gnttab_entry(head) = GNTTAB_LIST_END;
+		head = gnttab_entry(xh, head);
+	gt->gnttab_free_head = gnttab_entry(xh, head);
+	gnttab_entry(xh, head) = GNTTAB_LIST_END;
 
 	spin_unlock_irqrestore(&gnttab_list_lock, flags);
 
 	return ref;
 }
 
-static void do_free_callbacks(void)
+static void do_free_callbacks(xenhost_t *xh)
 {
 	struct gnttab_free_callback *callback, *next;
+	struct gnttab_private *gt = gt_priv(xh);
 
-	callback = gnttab_free_callback_list;
-	gnttab_free_callback_list = NULL;
+	callback = gt->gnttab_free_callback_list;
+	gt->gnttab_free_callback_list = NULL;
 
 	while (callback != NULL) {
 		next = callback->next;
-		if (gnttab_free_count >= callback->count) {
+		if (gt->gnttab_free_count >= callback->count) {
 			callback->next = NULL;
 			callback->fn(callback->arg);
 		} else {
-			callback->next = gnttab_free_callback_list;
-			gnttab_free_callback_list = callback;
+			callback->next = gt->gnttab_free_callback_list;
+			gt->gnttab_free_callback_list = callback;
 		}
 		callback = next;
 	}
 }
 
-static inline void check_free_callbacks(void)
+static inline void check_free_callbacks(xenhost_t *xh)
 {
-	if (unlikely(gnttab_free_callback_list))
-		do_free_callbacks();
+	struct gnttab_private *gt = gt_priv(xh);
+
+	if (unlikely(gt->gnttab_free_callback_list))
+		do_free_callbacks(xh);
 }
 
-static void put_free_entry(grant_ref_t ref)
+static void put_free_entry(xenhost_t *xh, grant_ref_t ref)
 {
 	unsigned long flags;
+	struct gnttab_private *gt = gt_priv(xh);
+
 	spin_lock_irqsave(&gnttab_list_lock, flags);
-	gnttab_entry(ref) = gnttab_free_head;
-	gnttab_free_head = ref;
-	gnttab_free_count++;
-	check_free_callbacks();
+	gnttab_entry(xh, ref) = gt->gnttab_free_head;
+	gt->gnttab_free_head = ref;
+	gt->gnttab_free_count++;
+	check_free_callbacks(xh);
 	spin_unlock_irqrestore(&gnttab_list_lock, flags);
 }
 
@@ -242,72 +251,85 @@ static void put_free_entry(grant_ref_t ref)
  *  3. Write memory barrier (WMB).
  *  4. Write ent->flags, inc. valid type.
  */
-static void gnttab_update_entry_v1(grant_ref_t ref, domid_t domid,
+static void gnttab_update_entry_v1(xenhost_t *xh, grant_ref_t ref, domid_t domid,
 				   unsigned long frame, unsigned flags)
 {
-	gnttab_shared.v1[ref].domid = domid;
-	gnttab_shared.v1[ref].frame = frame;
+	struct gnttab_private *gt = gt_priv(xh);
+
+	gt->gnttab_shared.v1[ref].domid = domid;
+	gt->gnttab_shared.v1[ref].frame = frame;
 	wmb();
-	gnttab_shared.v1[ref].flags = flags;
+	gt->gnttab_shared.v1[ref].flags = flags;
 }
 
-static void gnttab_update_entry_v2(grant_ref_t ref, domid_t domid,
+static void gnttab_update_entry_v2(xenhost_t *xh, grant_ref_t ref, domid_t domid,
 				   unsigned long frame, unsigned int flags)
 {
-	gnttab_shared.v2[ref].hdr.domid = domid;
-	gnttab_shared.v2[ref].full_page.frame = frame;
+	struct gnttab_private *gt = gt_priv(xh);
+
+	gt->gnttab_shared.v2[ref].hdr.domid = domid;
+	gt->gnttab_shared.v2[ref].full_page.frame = frame;
 	wmb();	/* Hypervisor concurrent accesses. */
-	gnttab_shared.v2[ref].hdr.flags = GTF_permit_access | flags;
+	gt->gnttab_shared.v2[ref].hdr.flags = GTF_permit_access | flags;
 }
 
 /*
  * Public grant-issuing interface functions
  */
-void gnttab_grant_foreign_access_ref(grant_ref_t ref, domid_t domid,
+void gnttab_grant_foreign_access_ref(xenhost_t *xh, grant_ref_t ref, domid_t domid,
 				     unsigned long frame, int readonly)
 {
-	gnttab_interface->update_entry(ref, domid, frame,
+	struct gnttab_private *gt = gt_priv(xh);
+
+	gt->gnttab_interface->update_entry(xh, ref, domid, frame,
 			   GTF_permit_access | (readonly ? GTF_readonly : 0));
 }
 EXPORT_SYMBOL_GPL(gnttab_grant_foreign_access_ref);
 
-int gnttab_grant_foreign_access(domid_t domid, unsigned long frame,
+int gnttab_grant_foreign_access(xenhost_t *xh, domid_t domid, unsigned long frame,
 				int readonly)
 {
 	int ref;
 
-	ref = get_free_entries(1);
+	ref = get_free_entries(xh, 1);
 	if (unlikely(ref < 0))
 		return -ENOSPC;
 
-	gnttab_grant_foreign_access_ref(ref, domid, frame, readonly);
+	gnttab_grant_foreign_access_ref(xh, ref, domid, frame, readonly);
 
 	return ref;
 }
 EXPORT_SYMBOL_GPL(gnttab_grant_foreign_access);
 
-static int gnttab_query_foreign_access_v1(grant_ref_t ref)
+static int gnttab_query_foreign_access_v1(xenhost_t *xh, grant_ref_t ref)
 {
-	return gnttab_shared.v1[ref].flags & (GTF_reading|GTF_writing);
+	struct gnttab_private *gt = gt_priv(xh);
+
+	return gt->gnttab_shared.v1[ref].flags & (GTF_reading|GTF_writing);
 }
 
-static int gnttab_query_foreign_access_v2(grant_ref_t ref)
+static int gnttab_query_foreign_access_v2(xenhost_t *xh, grant_ref_t ref)
 {
-	return grstatus[ref] & (GTF_reading|GTF_writing);
+	struct gnttab_private *gt = gt_priv(xh);
+
+	return gt->grstatus[ref] & (GTF_reading|GTF_writing);
 }
 
-int gnttab_query_foreign_access(grant_ref_t ref)
+int gnttab_query_foreign_access(xenhost_t *xh, grant_ref_t ref)
 {
-	return gnttab_interface->query_foreign_access(ref);
+	struct gnttab_private *gt = gt_priv(xh);
+
+	return gt->gnttab_interface->query_foreign_access(xh, ref);
 }
 EXPORT_SYMBOL_GPL(gnttab_query_foreign_access);
 
-static int gnttab_end_foreign_access_ref_v1(grant_ref_t ref, int readonly)
+static int gnttab_end_foreign_access_ref_v1(xenhost_t *xh, grant_ref_t ref, int readonly)
 {
+	struct gnttab_private *gt = gt_priv(xh);
 	u16 flags, nflags;
 	u16 *pflags;
 
-	pflags = &gnttab_shared.v1[ref].flags;
+	pflags = &gt->gnttab_shared.v1[ref].flags;
 	nflags = *pflags;
 	do {
 		flags = nflags;
@@ -318,11 +340,13 @@ static int gnttab_end_foreign_access_ref_v1(grant_ref_t ref, int readonly)
 	return 1;
 }
 
-static int gnttab_end_foreign_access_ref_v2(grant_ref_t ref, int readonly)
+static int gnttab_end_foreign_access_ref_v2(xenhost_t *xh, grant_ref_t ref, int readonly)
 {
-	gnttab_shared.v2[ref].hdr.flags = 0;
+	struct gnttab_private *gt = gt_priv(xh);
+
+	gt->gnttab_shared.v2[ref].hdr.flags = 0;
 	mb();	/* Concurrent access by hypervisor. */
-	if (grstatus[ref] & (GTF_reading|GTF_writing)) {
+	if (gt->grstatus[ref] & (GTF_reading|GTF_writing)) {
 		return 0;
 	} else {
 		/*
@@ -341,14 +365,16 @@ static int gnttab_end_foreign_access_ref_v2(grant_ref_t ref, int readonly)
 	return 1;
 }
 
-static inline int _gnttab_end_foreign_access_ref(grant_ref_t ref, int readonly)
+static inline int _gnttab_end_foreign_access_ref(xenhost_t *xh, grant_ref_t ref, int readonly)
 {
-	return gnttab_interface->end_foreign_access_ref(ref, readonly);
+	struct gnttab_private *gt = gt_priv(xh);
+
+	return gt->gnttab_interface->end_foreign_access_ref(xh, ref, readonly);
 }
 
-int gnttab_end_foreign_access_ref(grant_ref_t ref, int readonly)
+int gnttab_end_foreign_access_ref(xenhost_t *xh, grant_ref_t ref, int readonly)
 {
-	if (_gnttab_end_foreign_access_ref(ref, readonly))
+	if (_gnttab_end_foreign_access_ref(xh, ref, readonly))
 		return 1;
 	pr_warn("WARNING: g.e. %#x still in use!\n", ref);
 	return 0;
@@ -361,6 +387,7 @@ struct deferred_entry {
 	bool ro;
 	uint16_t warn_delay;
 	struct page *page;
+	xenhost_t *xh;
 };
 static LIST_HEAD(deferred_list);
 static void gnttab_handle_deferred(struct timer_list *);
@@ -382,8 +409,8 @@ static void gnttab_handle_deferred(struct timer_list *unused)
 			break;
 		list_del(&entry->list);
 		spin_unlock_irqrestore(&gnttab_list_lock, flags);
-		if (_gnttab_end_foreign_access_ref(entry->ref, entry->ro)) {
-			put_free_entry(entry->ref);
+		if (_gnttab_end_foreign_access_ref(entry->xh, entry->ref, entry->ro)) {
+			put_free_entry(entry->xh, entry->ref);
 			if (entry->page) {
 				pr_debug("freeing g.e. %#x (pfn %#lx)\n",
 					 entry->ref, page_to_pfn(entry->page));
@@ -411,7 +438,7 @@ static void gnttab_handle_deferred(struct timer_list *unused)
 	spin_unlock_irqrestore(&gnttab_list_lock, flags);
 }
 
-static void gnttab_add_deferred(grant_ref_t ref, bool readonly,
+static void gnttab_add_deferred(xenhost_t *xh, grant_ref_t ref, bool readonly,
 				struct page *page)
 {
 	struct deferred_entry *entry = kmalloc(sizeof(*entry), GFP_ATOMIC);
@@ -423,6 +450,7 @@ static void gnttab_add_deferred(grant_ref_t ref, bool readonly,
 		entry->ref = ref;
 		entry->ro = readonly;
 		entry->page = page;
+		entry->xh = xh;
 		entry->warn_delay = 60;
 		spin_lock_irqsave(&gnttab_list_lock, flags);
 		list_add_tail(&entry->list, &deferred_list);
@@ -437,46 +465,49 @@ static void gnttab_add_deferred(grant_ref_t ref, bool readonly,
 	       what, ref, page ? page_to_pfn(page) : -1);
 }
 
-void gnttab_end_foreign_access(grant_ref_t ref, int readonly,
+void gnttab_end_foreign_access(xenhost_t *xh, grant_ref_t ref, int readonly,
 			       unsigned long page)
 {
-	if (gnttab_end_foreign_access_ref(ref, readonly)) {
-		put_free_entry(ref);
+	if (gnttab_end_foreign_access_ref(xh, ref, readonly)) {
+		put_free_entry(xh, ref);
 		if (page != 0)
 			put_page(virt_to_page(page));
 	} else
-		gnttab_add_deferred(ref, readonly,
+		gnttab_add_deferred(xh, ref, readonly,
 				    page ? virt_to_page(page) : NULL);
 }
 EXPORT_SYMBOL_GPL(gnttab_end_foreign_access);
 
-int gnttab_grant_foreign_transfer(domid_t domid, unsigned long pfn)
+int gnttab_grant_foreign_transfer(xenhost_t *xh, domid_t domid, unsigned long pfn)
 {
 	int ref;
 
-	ref = get_free_entries(1);
+	ref = get_free_entries(xh, 1);
 	if (unlikely(ref < 0))
 		return -ENOSPC;
-	gnttab_grant_foreign_transfer_ref(ref, domid, pfn);
+	gnttab_grant_foreign_transfer_ref(xh, ref, domid, pfn);
 
 	return ref;
 }
 EXPORT_SYMBOL_GPL(gnttab_grant_foreign_transfer);
 
-void gnttab_grant_foreign_transfer_ref(grant_ref_t ref, domid_t domid,
+void gnttab_grant_foreign_transfer_ref(xenhost_t *xh, grant_ref_t ref, domid_t domid,
 				       unsigned long pfn)
 {
-	gnttab_interface->update_entry(ref, domid, pfn, GTF_accept_transfer);
+	struct gnttab_private *gt = gt_priv(xh);
+
+	gt->gnttab_interface->update_entry(xh, ref, domid, pfn, GTF_accept_transfer);
 }
 EXPORT_SYMBOL_GPL(gnttab_grant_foreign_transfer_ref);
 
-static unsigned long gnttab_end_foreign_transfer_ref_v1(grant_ref_t ref)
+static unsigned long gnttab_end_foreign_transfer_ref_v1(xenhost_t *xh, grant_ref_t ref)
 {
+	struct gnttab_private *gt = gt_priv(xh);
 	unsigned long frame;
 	u16           flags;
 	u16          *pflags;
 
-	pflags = &gnttab_shared.v1[ref].flags;
+	pflags = &gt->gnttab_shared.v1[ref].flags;
 
 	/*
 	 * If a transfer is not even yet started, try to reclaim the grant
@@ -495,19 +526,20 @@ static unsigned long gnttab_end_foreign_transfer_ref_v1(grant_ref_t ref)
 	}
 
 	rmb();	/* Read the frame number /after/ reading completion status. */
-	frame = gnttab_shared.v1[ref].frame;
+	frame = gt->gnttab_shared.v1[ref].frame;
 	BUG_ON(frame == 0);
 
 	return frame;
 }
 
-static unsigned long gnttab_end_foreign_transfer_ref_v2(grant_ref_t ref)
+static unsigned long gnttab_end_foreign_transfer_ref_v2(xenhost_t *xh, grant_ref_t ref)
 {
 	unsigned long frame;
 	u16           flags;
 	u16          *pflags;
+	struct gnttab_private *gt = gt_priv(xh);
 
-	pflags = &gnttab_shared.v2[ref].hdr.flags;
+	pflags = &gt->gnttab_shared.v2[ref].hdr.flags;
 
 	/*
 	 * If a transfer is not even yet started, try to reclaim the grant
@@ -526,34 +558,39 @@ static unsigned long gnttab_end_foreign_transfer_ref_v2(grant_ref_t ref)
 	}
 
 	rmb();  /* Read the frame number /after/ reading completion status. */
-	frame = gnttab_shared.v2[ref].full_page.frame;
+	frame = gt->gnttab_shared.v2[ref].full_page.frame;
 	BUG_ON(frame == 0);
 
 	return frame;
 }
 
-unsigned long gnttab_end_foreign_transfer_ref(grant_ref_t ref)
+unsigned long gnttab_end_foreign_transfer_ref(xenhost_t *xh, grant_ref_t ref)
 {
-	return gnttab_interface->end_foreign_transfer_ref(ref);
+	struct gnttab_private *gt = gt_priv(xh);
+
+	return gt->gnttab_interface->end_foreign_transfer_ref(xh, ref);
 }
 EXPORT_SYMBOL_GPL(gnttab_end_foreign_transfer_ref);
 
-unsigned long gnttab_end_foreign_transfer(grant_ref_t ref)
+unsigned long gnttab_end_foreign_transfer(xenhost_t *xh, grant_ref_t ref)
 {
-	unsigned long frame = gnttab_end_foreign_transfer_ref(ref);
-	put_free_entry(ref);
+	unsigned long frame = gnttab_end_foreign_transfer_ref(xh, ref);
+
+	put_free_entry(xh, ref);
+
 	return frame;
 }
 EXPORT_SYMBOL_GPL(gnttab_end_foreign_transfer);
 
-void gnttab_free_grant_reference(grant_ref_t ref)
+void gnttab_free_grant_reference(xenhost_t *xh, grant_ref_t ref)
 {
-	put_free_entry(ref);
+	put_free_entry(xh, ref);
 }
 EXPORT_SYMBOL_GPL(gnttab_free_grant_reference);
 
-void gnttab_free_grant_references(grant_ref_t head)
+void gnttab_free_grant_references(xenhost_t *xh, grant_ref_t head)
 {
+	struct gnttab_private *gt = gt_priv(xh);
 	grant_ref_t ref;
 	unsigned long flags;
 	int count = 1;
@@ -561,21 +598,21 @@ void gnttab_free_grant_references(grant_ref_t head)
 		return;
 	spin_lock_irqsave(&gnttab_list_lock, flags);
 	ref = head;
-	while (gnttab_entry(ref) != GNTTAB_LIST_END) {
-		ref = gnttab_entry(ref);
+	while (gnttab_entry(xh, ref) != GNTTAB_LIST_END) {
+		ref = gnttab_entry(xh, ref);
 		count++;
 	}
-	gnttab_entry(ref) = gnttab_free_head;
-	gnttab_free_head = head;
-	gnttab_free_count += count;
-	check_free_callbacks();
+	gnttab_entry(xh, ref) = gt->gnttab_free_head;
+	gt->gnttab_free_head = head;
+	gt->gnttab_free_count += count;
+	check_free_callbacks(xh);
 	spin_unlock_irqrestore(&gnttab_list_lock, flags);
 }
 EXPORT_SYMBOL_GPL(gnttab_free_grant_references);
 
-int gnttab_alloc_grant_references(u16 count, grant_ref_t *head)
+int gnttab_alloc_grant_references(xenhost_t *xh, u16 count, grant_ref_t *head)
 {
-	int h = get_free_entries(count);
+	int h = get_free_entries(xh, count);
 
 	if (h < 0)
 		return -ENOSPC;
@@ -586,40 +623,41 @@ int gnttab_alloc_grant_references(u16 count, grant_ref_t *head)
 }
 EXPORT_SYMBOL_GPL(gnttab_alloc_grant_references);
 
-int gnttab_empty_grant_references(const grant_ref_t *private_head)
+int gnttab_empty_grant_references(xenhost_t *xh, const grant_ref_t *private_head)
 {
 	return (*private_head == GNTTAB_LIST_END);
 }
 EXPORT_SYMBOL_GPL(gnttab_empty_grant_references);
 
-int gnttab_claim_grant_reference(grant_ref_t *private_head)
+int gnttab_claim_grant_reference(xenhost_t *xh, grant_ref_t *private_head)
 {
 	grant_ref_t g = *private_head;
 	if (unlikely(g == GNTTAB_LIST_END))
 		return -ENOSPC;
-	*private_head = gnttab_entry(g);
+	*private_head = gnttab_entry(xh, g);
 	return g;
 }
 EXPORT_SYMBOL_GPL(gnttab_claim_grant_reference);
 
-void gnttab_release_grant_reference(grant_ref_t *private_head,
+void gnttab_release_grant_reference(xenhost_t *xh, grant_ref_t *private_head,
 				    grant_ref_t release)
 {
-	gnttab_entry(release) = *private_head;
+	gnttab_entry(xh, release) = *private_head;
 	*private_head = release;
 }
 EXPORT_SYMBOL_GPL(gnttab_release_grant_reference);
 
-void gnttab_request_free_callback(struct gnttab_free_callback *callback,
+void gnttab_request_free_callback(xenhost_t *xh, struct gnttab_free_callback *callback,
 				  void (*fn)(void *), void *arg, u16 count)
 {
 	unsigned long flags;
 	struct gnttab_free_callback *cb;
+	struct gnttab_private *gt = gt_priv(xh);
 
 	spin_lock_irqsave(&gnttab_list_lock, flags);
 
 	/* Check if the callback is already on the list */
-	cb = gnttab_free_callback_list;
+	cb = gt->gnttab_free_callback_list;
 	while (cb) {
 		if (cb == callback)
 			goto out;
@@ -629,21 +667,23 @@ void gnttab_request_free_callback(struct gnttab_free_callback *callback,
 	callback->fn = fn;
 	callback->arg = arg;
 	callback->count = count;
-	callback->next = gnttab_free_callback_list;
-	gnttab_free_callback_list = callback;
-	check_free_callbacks();
+	callback->next = gt->gnttab_free_callback_list;
+	gt->gnttab_free_callback_list = callback;
+	check_free_callbacks(xh);
 out:
 	spin_unlock_irqrestore(&gnttab_list_lock, flags);
 }
 EXPORT_SYMBOL_GPL(gnttab_request_free_callback);
 
-void gnttab_cancel_free_callback(struct gnttab_free_callback *callback)
+void gnttab_cancel_free_callback(xenhost_t *xh, struct gnttab_free_callback *callback)
 {
 	struct gnttab_free_callback **pcb;
 	unsigned long flags;
+	struct gnttab_private *gt = gt_priv(xh);
+
 
 	spin_lock_irqsave(&gnttab_list_lock, flags);
-	for (pcb = &gnttab_free_callback_list; *pcb; pcb = &(*pcb)->next) {
+	for (pcb = &gt->gnttab_free_callback_list; *pcb; pcb = &(*pcb)->next) {
 		if (*pcb == callback) {
 			*pcb = callback->next;
 			break;
@@ -653,75 +693,78 @@ void gnttab_cancel_free_callback(struct gnttab_free_callback *callback)
 }
 EXPORT_SYMBOL_GPL(gnttab_cancel_free_callback);
 
-static unsigned int gnttab_frames(unsigned int frames, unsigned int align)
+static unsigned int gnttab_frames(xenhost_t *xh, unsigned int frames, unsigned int align)
 {
-	return (frames * gnttab_interface->grefs_per_grant_frame + align - 1) /
+	struct gnttab_private *gt = gt_priv(xh);
+
+	return (frames * gt->gnttab_interface->grefs_per_grant_frame + align - 1) /
 	       align;
 }
 
-static int grow_gnttab_list(unsigned int more_frames)
+static int grow_gnttab_list(xenhost_t *xh, unsigned int more_frames)
 {
 	unsigned int new_nr_grant_frames, extra_entries, i;
 	unsigned int nr_glist_frames, new_nr_glist_frames;
 	unsigned int grefs_per_frame;
+	struct gnttab_private *gt = gt_priv(xh);
 
-	BUG_ON(gnttab_interface == NULL);
-	grefs_per_frame = gnttab_interface->grefs_per_grant_frame;
+	BUG_ON(gt->gnttab_interface == NULL);
+	grefs_per_frame = gt->gnttab_interface->grefs_per_grant_frame;
 
-	new_nr_grant_frames = nr_grant_frames + more_frames;
+	new_nr_grant_frames = gt->nr_grant_frames + more_frames;
 	extra_entries = more_frames * grefs_per_frame;
 
-	nr_glist_frames = gnttab_frames(nr_grant_frames, RPP);
-	new_nr_glist_frames = gnttab_frames(new_nr_grant_frames, RPP);
+	nr_glist_frames = gnttab_frames(xh, gt->nr_grant_frames, RPP);
+	new_nr_glist_frames = gnttab_frames(xh, new_nr_grant_frames, RPP);
 	for (i = nr_glist_frames; i < new_nr_glist_frames; i++) {
-		gnttab_list[i] = (grant_ref_t *)__get_free_page(GFP_ATOMIC);
-		if (!gnttab_list[i])
+		gt->gnttab_list[i] = (grant_ref_t *)__get_free_page(GFP_ATOMIC);
+		if (!gt->gnttab_list[i])
 			goto grow_nomem;
 	}
 
 
-	for (i = grefs_per_frame * nr_grant_frames;
+	for (i = grefs_per_frame * gt->nr_grant_frames;
 	     i < grefs_per_frame * new_nr_grant_frames - 1; i++)
-		gnttab_entry(i) = i + 1;
+		gnttab_entry(xh, i) = i + 1;
 
-	gnttab_entry(i) = gnttab_free_head;
-	gnttab_free_head = grefs_per_frame * nr_grant_frames;
-	gnttab_free_count += extra_entries;
+	gnttab_entry(xh, i) = gt->gnttab_free_head;
+	gt->gnttab_free_head = grefs_per_frame * gt->nr_grant_frames;
+	gt->gnttab_free_count += extra_entries;
 
-	nr_grant_frames = new_nr_grant_frames;
+	gt->nr_grant_frames = new_nr_grant_frames;
 
-	check_free_callbacks();
+	check_free_callbacks(xh);
 
 	return 0;
 
 grow_nomem:
 	while (i-- > nr_glist_frames)
-		free_page((unsigned long) gnttab_list[i]);
+		free_page((unsigned long) gt->gnttab_list[i]);
 	return -ENOMEM;
 }
 
-static unsigned int __max_nr_grant_frames(void)
+static unsigned int __max_nr_grant_frames(xenhost_t *xh)
 {
 	struct gnttab_query_size query;
 	int rc;
 
 	query.dom = DOMID_SELF;
 
-	rc = HYPERVISOR_grant_table_op(GNTTABOP_query_size, &query, 1);
+	rc = hypervisor_grant_table_op(xh, GNTTABOP_query_size, &query, 1);
 	if ((rc < 0) || (query.status != GNTST_okay))
 		return 4; /* Legacy max supported number of frames */
 
 	return query.max_nr_frames;
 }
 
-unsigned int gnttab_max_grant_frames(void)
+unsigned int gnttab_max_grant_frames(xenhost_t *xh)
 {
-	unsigned int xen_max = __max_nr_grant_frames();
+	unsigned int xen_max = __max_nr_grant_frames(xh);
 	static unsigned int boot_max_nr_grant_frames;
 
 	/* First time, initialize it properly. */
 	if (!boot_max_nr_grant_frames)
-		boot_max_nr_grant_frames = __max_nr_grant_frames();
+		boot_max_nr_grant_frames = __max_nr_grant_frames(xh);
 
 	if (xen_max > boot_max_nr_grant_frames)
 		return boot_max_nr_grant_frames;
@@ -729,14 +772,15 @@ unsigned int gnttab_max_grant_frames(void)
 }
 EXPORT_SYMBOL_GPL(gnttab_max_grant_frames);
 
-int gnttab_setup_auto_xlat_frames(phys_addr_t addr)
+int gnttab_setup_auto_xlat_frames(xenhost_t *xh, phys_addr_t addr)
 {
+	struct gnttab_private *gt = gt_priv(xh);
 	xen_pfn_t *pfn;
-	unsigned int max_nr_gframes = __max_nr_grant_frames();
+	unsigned int max_nr_gframes = __max_nr_grant_frames(xh);
 	unsigned int i;
 	void *vaddr;
 
-	if (xen_auto_xlat_grant_frames.count)
+	if (gt->auto_xlat_grant_frames.count)
 		return -EINVAL;
 
 	vaddr = xen_remap(addr, XEN_PAGE_SIZE * max_nr_gframes);
@@ -753,24 +797,26 @@ int gnttab_setup_auto_xlat_frames(phys_addr_t addr)
 	for (i = 0; i < max_nr_gframes; i++)
 		pfn[i] = XEN_PFN_DOWN(addr) + i;
 
-	xen_auto_xlat_grant_frames.vaddr = vaddr;
-	xen_auto_xlat_grant_frames.pfn = pfn;
-	xen_auto_xlat_grant_frames.count = max_nr_gframes;
+	gt->auto_xlat_grant_frames.vaddr = vaddr;
+	gt->auto_xlat_grant_frames.pfn = pfn;
+	gt->auto_xlat_grant_frames.count = max_nr_gframes;
 
 	return 0;
 }
 EXPORT_SYMBOL_GPL(gnttab_setup_auto_xlat_frames);
 
-void gnttab_free_auto_xlat_frames(void)
+void gnttab_free_auto_xlat_frames(xenhost_t *xh)
 {
-	if (!xen_auto_xlat_grant_frames.count)
+	struct gnttab_private *gt = gt_priv(xh);
+
+	if (!gt->auto_xlat_grant_frames.count)
 		return;
-	kfree(xen_auto_xlat_grant_frames.pfn);
-	xen_unmap(xen_auto_xlat_grant_frames.vaddr);
+	kfree(gt->auto_xlat_grant_frames.pfn);
+	xen_unmap(gt->auto_xlat_grant_frames.vaddr);
 
-	xen_auto_xlat_grant_frames.pfn = NULL;
-	xen_auto_xlat_grant_frames.count = 0;
-	xen_auto_xlat_grant_frames.vaddr = NULL;
+	gt->auto_xlat_grant_frames.pfn = NULL;
+	gt->auto_xlat_grant_frames.count = 0;
+	gt->auto_xlat_grant_frames.vaddr = NULL;
 }
 EXPORT_SYMBOL_GPL(gnttab_free_auto_xlat_frames);
 
@@ -800,17 +846,17 @@ EXPORT_SYMBOL_GPL(gnttab_pages_set_private);
  * @nr_pages: number of pages to alloc
  * @pages: returns the pages
  */
-int gnttab_alloc_pages(int nr_pages, struct page **pages)
+int gnttab_alloc_pages(xenhost_t *xh, int nr_pages, struct page **pages)
 {
 	int ret;
 
-	ret = alloc_xenballooned_pages(xh_default, nr_pages, pages);
+	ret = alloc_xenballooned_pages(xh, nr_pages, pages);
 	if (ret < 0)
 		return ret;
 
 	ret = gnttab_pages_set_private(nr_pages, pages);
 	if (ret < 0)
-		gnttab_free_pages(nr_pages, pages);
+		gnttab_free_pages(xh, nr_pages, pages);
 
 	return ret;
 }
@@ -836,10 +882,10 @@ EXPORT_SYMBOL_GPL(gnttab_pages_clear_private);
  * @nr_pages; number of pages to free
  * @pages: the pages
  */
-void gnttab_free_pages(int nr_pages, struct page **pages)
+void gnttab_free_pages(xenhost_t *xh, int nr_pages, struct page **pages)
 {
 	gnttab_pages_clear_private(nr_pages, pages);
-	free_xenballooned_pages(xh_default, nr_pages, pages);
+	free_xenballooned_pages(xh, nr_pages, pages);
 }
 EXPORT_SYMBOL_GPL(gnttab_free_pages);
 
@@ -848,12 +894,15 @@ EXPORT_SYMBOL_GPL(gnttab_free_pages);
  * gnttab_dma_alloc_pages - alloc DMAable pages suitable for grant mapping into
  * @args: arguments to the function
  */
-int gnttab_dma_alloc_pages(struct gnttab_dma_alloc_args *args)
+int gnttab_dma_alloc_pages(xenhost_t *xh, struct gnttab_dma_alloc_args *args)
 {
 	unsigned long pfn, start_pfn;
 	size_t size;
 	int i, ret;
 
+	if (xh->type != xenhost_r1)
+		return -EINVAL;
+
 	size = args->nr_pages << PAGE_SHIFT;
 	if (args->coherent)
 		args->vaddr = dma_alloc_coherent(args->dev, size,
@@ -903,11 +952,14 @@ EXPORT_SYMBOL_GPL(gnttab_dma_alloc_pages);
  * gnttab_dma_free_pages - free DMAable pages
  * @args: arguments to the function
  */
-int gnttab_dma_free_pages(struct gnttab_dma_alloc_args *args)
+int gnttab_dma_free_pages(xenhost_t *xh, struct gnttab_dma_alloc_args *args)
 {
 	size_t size;
 	int i, ret;
 
+	if (xh->type != xenhost_r1)
+		return -EINVAL;
+
 	gnttab_pages_clear_private(args->nr_pages, args->pages);
 
 	for (i = 0; i < args->nr_pages; i++)
@@ -939,13 +991,13 @@ EXPORT_SYMBOL_GPL(gnttab_dma_free_pages);
 /* Handling of paged out grant targets (GNTST_eagain) */
 #define MAX_DELAY 256
 static inline void
-gnttab_retry_eagain_gop(unsigned int cmd, void *gop, int16_t *status,
+gnttab_retry_eagain_gop(xenhost_t *xh, unsigned int cmd, void *gop, int16_t *status,
 						const char *func)
 {
 	unsigned delay = 1;
 
 	do {
-		BUG_ON(HYPERVISOR_grant_table_op(cmd, gop, 1));
+		BUG_ON(hypervisor_grant_table_op(xh, cmd, gop, 1));
 		if (*status == GNTST_eagain)
 			msleep(delay++);
 	} while ((*status == GNTST_eagain) && (delay < MAX_DELAY));
@@ -956,28 +1008,28 @@ gnttab_retry_eagain_gop(unsigned int cmd, void *gop, int16_t *status,
 	}
 }
 
-void gnttab_batch_map(struct gnttab_map_grant_ref *batch, unsigned count)
+void gnttab_batch_map(xenhost_t *xh, struct gnttab_map_grant_ref *batch, unsigned count)
 {
 	struct gnttab_map_grant_ref *op;
 
-	if (HYPERVISOR_grant_table_op(GNTTABOP_map_grant_ref, batch, count))
+	if (hypervisor_grant_table_op(xh, GNTTABOP_map_grant_ref, batch, count))
 		BUG();
 	for (op = batch; op < batch + count; op++)
 		if (op->status == GNTST_eagain)
-			gnttab_retry_eagain_gop(GNTTABOP_map_grant_ref, op,
+			gnttab_retry_eagain_gop(xh, GNTTABOP_map_grant_ref, op,
 						&op->status, __func__);
 }
 EXPORT_SYMBOL_GPL(gnttab_batch_map);
 
-void gnttab_batch_copy(struct gnttab_copy *batch, unsigned count)
+void gnttab_batch_copy(xenhost_t *xh, struct gnttab_copy *batch, unsigned count)
 {
 	struct gnttab_copy *op;
 
-	if (HYPERVISOR_grant_table_op(GNTTABOP_copy, batch, count))
+	if (hypervisor_grant_table_op(xh, GNTTABOP_copy, batch, count))
 		BUG();
 	for (op = batch; op < batch + count; op++)
 		if (op->status == GNTST_eagain)
-			gnttab_retry_eagain_gop(GNTTABOP_copy, op,
+			gnttab_retry_eagain_gop(xh, GNTTABOP_copy, op,
 						&op->status, __func__);
 }
 EXPORT_SYMBOL_GPL(gnttab_batch_copy);
@@ -1030,13 +1082,13 @@ void gnttab_foreach_grant(struct page **pages,
 	}
 }
 
-int gnttab_map_refs(struct gnttab_map_grant_ref *map_ops,
+int gnttab_map_refs(xenhost_t *xh, struct gnttab_map_grant_ref *map_ops,
 		    struct gnttab_map_grant_ref *kmap_ops,
 		    struct page **pages, unsigned int count)
 {
 	int i, ret;
 
-	ret = HYPERVISOR_grant_table_op(GNTTABOP_map_grant_ref, map_ops, count);
+	ret = hypervisor_grant_table_op(xh, GNTTABOP_map_grant_ref, map_ops, count);
 	if (ret)
 		return ret;
 
@@ -1059,7 +1111,7 @@ int gnttab_map_refs(struct gnttab_map_grant_ref *map_ops,
 
 		case GNTST_eagain:
 			/* Retry eagain maps */
-			gnttab_retry_eagain_gop(GNTTABOP_map_grant_ref,
+			gnttab_retry_eagain_gop(xh, GNTTABOP_map_grant_ref,
 						map_ops + i,
 						&map_ops[i].status, __func__);
 			/* Test status in next loop iteration. */
@@ -1075,14 +1127,14 @@ int gnttab_map_refs(struct gnttab_map_grant_ref *map_ops,
 }
 EXPORT_SYMBOL_GPL(gnttab_map_refs);
 
-int gnttab_unmap_refs(struct gnttab_unmap_grant_ref *unmap_ops,
+int gnttab_unmap_refs(xenhost_t *xh, struct gnttab_unmap_grant_ref *unmap_ops,
 		      struct gnttab_unmap_grant_ref *kunmap_ops,
 		      struct page **pages, unsigned int count)
 {
 	unsigned int i;
 	int ret;
 
-	ret = HYPERVISOR_grant_table_op(GNTTABOP_unmap_grant_ref, unmap_ops, count);
+	ret = hypervisor_grant_table_op(xh, GNTTABOP_unmap_grant_ref, unmap_ops, count);
 	if (ret)
 		return ret;
 
@@ -1122,7 +1174,7 @@ static void __gnttab_unmap_refs_async(struct gntab_unmap_queue_data* item)
 		}
 	}
 
-	ret = gnttab_unmap_refs(item->unmap_ops, item->kunmap_ops,
+	ret = gnttab_unmap_refs(item->xh, item->unmap_ops, item->kunmap_ops,
 				item->pages, item->count);
 	item->done(ret, item);
 }
@@ -1159,37 +1211,43 @@ int gnttab_unmap_refs_sync(struct gntab_unmap_queue_data *item)
 }
 EXPORT_SYMBOL_GPL(gnttab_unmap_refs_sync);
 
-static unsigned int nr_status_frames(unsigned int nr_grant_frames)
+static unsigned int nr_status_frames(xenhost_t *xh, unsigned int nr_grant_frames)
 {
-	BUG_ON(gnttab_interface == NULL);
-	return gnttab_frames(nr_grant_frames, SPP);
+	struct gnttab_private *gt = gt_priv(xh);
+
+	BUG_ON(gt->gnttab_interface == NULL);
+	return gnttab_frames(xh, nr_grant_frames, SPP);
 }
 
-static int gnttab_map_frames_v1(xen_pfn_t *frames, unsigned int nr_gframes)
+static int gnttab_map_frames_v1(xenhost_t *xh, xen_pfn_t *frames, unsigned int nr_gframes)
 {
 	int rc;
+	struct gnttab_private *gt = gt_priv(xh);
 
-	rc = arch_gnttab_map_shared(frames, nr_gframes,
-				    gnttab_max_grant_frames(),
-				    &gnttab_shared.addr);
+	rc = arch_gnttab_map_shared(xh, frames, nr_gframes,
+				    gnttab_max_grant_frames(xh),
+				    &gt->gnttab_shared.addr);
 	BUG_ON(rc);
 
 	return 0;
 }
 
-static void gnttab_unmap_frames_v1(void)
+static void gnttab_unmap_frames_v1(xenhost_t *xh)
 {
-	arch_gnttab_unmap(gnttab_shared.addr, nr_grant_frames);
+	struct gnttab_private *gt = gt_priv(xh);
+
+	arch_gnttab_unmap(xh, gt->gnttab_shared.addr, gt->nr_grant_frames);
 }
 
-static int gnttab_map_frames_v2(xen_pfn_t *frames, unsigned int nr_gframes)
+static int gnttab_map_frames_v2(xenhost_t *xh, xen_pfn_t *frames, unsigned int nr_gframes)
 {
 	uint64_t *sframes;
 	unsigned int nr_sframes;
 	struct gnttab_get_status_frames getframes;
 	int rc;
+	struct gnttab_private *gt = gt_priv(xh);
 
-	nr_sframes = nr_status_frames(nr_gframes);
+	nr_sframes = nr_status_frames(xh, nr_gframes);
 
 	/* No need for kzalloc as it is initialized in following hypercall
 	 * GNTTABOP_get_status_frames.
@@ -1202,7 +1260,7 @@ static int gnttab_map_frames_v2(xen_pfn_t *frames, unsigned int nr_gframes)
 	getframes.nr_frames  = nr_sframes;
 	set_xen_guest_handle(getframes.frame_list, sframes);
 
-	rc = HYPERVISOR_grant_table_op(GNTTABOP_get_status_frames,
+	rc = hypervisor_grant_table_op(xh, GNTTABOP_get_status_frames,
 				       &getframes, 1);
 	if (rc == -ENOSYS) {
 		kfree(sframes);
@@ -1211,38 +1269,41 @@ static int gnttab_map_frames_v2(xen_pfn_t *frames, unsigned int nr_gframes)
 
 	BUG_ON(rc || getframes.status);
 
-	rc = arch_gnttab_map_status(sframes, nr_sframes,
-				    nr_status_frames(gnttab_max_grant_frames()),
-				    &grstatus);
+	rc = arch_gnttab_map_status(xh, sframes, nr_sframes,
+				    nr_status_frames(xh, gnttab_max_grant_frames(xh)),
+				    &gt->grstatus);
 	BUG_ON(rc);
 	kfree(sframes);
 
-	rc = arch_gnttab_map_shared(frames, nr_gframes,
-				    gnttab_max_grant_frames(),
-				    &gnttab_shared.addr);
+	rc = arch_gnttab_map_shared(xh, frames, nr_gframes,
+				    gnttab_max_grant_frames(xh),
+				    &gt->gnttab_shared.addr);
 	BUG_ON(rc);
 
 	return 0;
 }
 
-static void gnttab_unmap_frames_v2(void)
+static void gnttab_unmap_frames_v2(xenhost_t *xh)
 {
-	arch_gnttab_unmap(gnttab_shared.addr, nr_grant_frames);
-	arch_gnttab_unmap(grstatus, nr_status_frames(nr_grant_frames));
+	struct gnttab_private *gt = gt_priv(xh);
+
+	arch_gnttab_unmap(xh, gt->gnttab_shared.addr, gt->nr_grant_frames);
+	arch_gnttab_unmap(xh, gt->grstatus, nr_status_frames(xh, gt->nr_grant_frames));
 }
 
-static int gnttab_map(unsigned int start_idx, unsigned int end_idx)
+static int gnttab_map(xenhost_t *xh, unsigned int start_idx, unsigned int end_idx)
 {
 	struct gnttab_setup_table setup;
 	xen_pfn_t *frames;
 	unsigned int nr_gframes = end_idx + 1;
+	struct gnttab_private *gt = gt_priv(xh);
 	int rc;
 
-	if (xen_feature(XENFEAT_auto_translated_physmap)) {
+	if (__xen_feature(xh, XENFEAT_auto_translated_physmap)) {
 		struct xen_add_to_physmap xatp;
 		unsigned int i = end_idx;
 		rc = 0;
-		BUG_ON(xen_auto_xlat_grant_frames.count < nr_gframes);
+		BUG_ON(gt->auto_xlat_grant_frames.count < nr_gframes);
 		/*
 		 * Loop backwards, so that the first hypercall has the largest
 		 * index, ensuring that the table will grow only once.
@@ -1251,8 +1312,8 @@ static int gnttab_map(unsigned int start_idx, unsigned int end_idx)
 			xatp.domid = DOMID_SELF;
 			xatp.idx = i;
 			xatp.space = XENMAPSPACE_grant_table;
-			xatp.gpfn = xen_auto_xlat_grant_frames.pfn[i];
-			rc = HYPERVISOR_memory_op(XENMEM_add_to_physmap, &xatp);
+			xatp.gpfn = gt->auto_xlat_grant_frames.pfn[i];
+			rc = hypervisor_memory_op(xh, XENMEM_add_to_physmap, &xatp);
 			if (rc != 0) {
 				pr_warn("grant table add_to_physmap failed, err=%d\n",
 					rc);
@@ -1274,7 +1335,7 @@ static int gnttab_map(unsigned int start_idx, unsigned int end_idx)
 	setup.nr_frames  = nr_gframes;
 	set_xen_guest_handle(setup.frame_list, frames);
 
-	rc = HYPERVISOR_grant_table_op(GNTTABOP_setup_table, &setup, 1);
+	rc = hypervisor_grant_table_op(xh, GNTTABOP_setup_table, &setup, 1);
 	if (rc == -ENOSYS) {
 		kfree(frames);
 		return -ENOSYS;
@@ -1282,7 +1343,7 @@ static int gnttab_map(unsigned int start_idx, unsigned int end_idx)
 
 	BUG_ON(rc || setup.status);
 
-	rc = gnttab_interface->map_frames(frames, nr_gframes);
+	rc = gt->gnttab_interface->map_frames(xh, frames, nr_gframes);
 
 	kfree(frames);
 
@@ -1313,13 +1374,13 @@ static const struct gnttab_ops gnttab_v2_ops = {
 	.query_foreign_access		= gnttab_query_foreign_access_v2,
 };
 
-static bool gnttab_need_v2(void)
+static bool gnttab_need_v2(xenhost_t *xh)
 {
 #ifdef CONFIG_X86
 	uint32_t base, width;
 
 	if (xen_pv_domain()) {
-		base = xenhost_cpuid_base(xh_default);
+		base = xenhost_cpuid_base(xh);
 		if (cpuid_eax(base) < 5)
 			return false;	/* Information not available, use V1. */
 		width = cpuid_ebx(base + 5) &
@@ -1330,12 +1391,13 @@ static bool gnttab_need_v2(void)
 	return !!(max_possible_pfn >> 32);
 }
 
-static void gnttab_request_version(void)
+static void gnttab_request_version(xenhost_t *xh)
 {
 	long rc;
 	struct gnttab_set_version gsv;
+	struct gnttab_private *gt = gt_priv(xh);
 
-	if (gnttab_need_v2())
+	if (gnttab_need_v2(xh))
 		gsv.version = 2;
 	else
 		gsv.version = 1;
@@ -1344,139 +1406,162 @@ static void gnttab_request_version(void)
 	if (xen_gnttab_version >= 1 && xen_gnttab_version <= 2)
 		gsv.version = xen_gnttab_version;
 
-	rc = HYPERVISOR_grant_table_op(GNTTABOP_set_version, &gsv, 1);
+	rc = hypervisor_grant_table_op(xh, GNTTABOP_set_version, &gsv, 1);
 	if (rc == 0 && gsv.version == 2)
-		gnttab_interface = &gnttab_v2_ops;
+		gt->gnttab_interface = &gnttab_v2_ops;
 	else
-		gnttab_interface = &gnttab_v1_ops;
+		gt->gnttab_interface = &gnttab_v1_ops;
+
 	pr_info("Grant tables using version %d layout\n",
-		gnttab_interface->version);
+		gt->gnttab_interface->version);
 }
 
-static int gnttab_setup(void)
+static int gnttab_setup(xenhost_t *xh)
 {
 	unsigned int max_nr_gframes;
+	struct gnttab_private *gt = gt_priv(xh);
 
-	max_nr_gframes = gnttab_max_grant_frames();
-	if (max_nr_gframes < nr_grant_frames)
+	max_nr_gframes = gnttab_max_grant_frames(xh);
+	if (max_nr_gframes < gt->nr_grant_frames)
 		return -ENOSYS;
 
-	if (xen_feature(XENFEAT_auto_translated_physmap) && gnttab_shared.addr == NULL) {
-		gnttab_shared.addr = xen_auto_xlat_grant_frames.vaddr;
-		if (gnttab_shared.addr == NULL) {
+	if (__xen_feature(xh, XENFEAT_auto_translated_physmap) && gt->gnttab_shared.addr == NULL) {
+		gt->gnttab_shared.addr = gt->auto_xlat_grant_frames.vaddr;
+		if (gt->gnttab_shared.addr == NULL) {
 			pr_warn("gnttab share frames (addr=0x%08lx) is not mapped!\n",
-				(unsigned long)xen_auto_xlat_grant_frames.vaddr);
+				(unsigned long)gt->auto_xlat_grant_frames.vaddr);
 			return -ENOMEM;
 		}
 	}
-	return gnttab_map(0, nr_grant_frames - 1);
+	return gnttab_map(xh, 0, gt->nr_grant_frames - 1);
 }
 
 int gnttab_resume(void)
 {
-	gnttab_request_version();
-	return gnttab_setup();
+	xenhost_t **xh;
+	for_each_xenhost(xh) {
+		int err;
+
+		gnttab_request_version(*xh);
+		err = gnttab_setup(*xh);
+		if (err)
+			return err;
+	}
+	return 0;
 }
 
 int gnttab_suspend(void)
 {
-	if (!xen_feature(XENFEAT_auto_translated_physmap))
-		gnttab_interface->unmap_frames();
+	xenhost_t **xh;
+	struct gnttab_private *gt;
+	
+	for_each_xenhost(xh) {
+		gt = gt_priv(*xh);
+
+		if (!__xen_feature((*xh), XENFEAT_auto_translated_physmap))
+			gt->gnttab_interface->unmap_frames(*xh);
+		return 0;
+	}
 	return 0;
 }
 
-static int gnttab_expand(unsigned int req_entries)
+static int gnttab_expand(xenhost_t *xh, unsigned int req_entries)
 {
 	int rc;
 	unsigned int cur, extra;
+	struct gnttab_private *gt = gt_priv(xh);
 
-	BUG_ON(gnttab_interface == NULL);
-	cur = nr_grant_frames;
-	extra = ((req_entries + gnttab_interface->grefs_per_grant_frame - 1) /
-		 gnttab_interface->grefs_per_grant_frame);
-	if (cur + extra > gnttab_max_grant_frames()) {
+	BUG_ON(gt->gnttab_interface == NULL);
+	cur = gt->nr_grant_frames;
+	extra = ((req_entries + gt->gnttab_interface->grefs_per_grant_frame - 1) /
+		 gt->gnttab_interface->grefs_per_grant_frame);
+	if (cur + extra > gnttab_max_grant_frames(xh)) {
 		pr_warn_ratelimited("xen/grant-table: max_grant_frames reached"
 				    " cur=%u extra=%u limit=%u"
 				    " gnttab_free_count=%u req_entries=%u\n",
-				    cur, extra, gnttab_max_grant_frames(),
-				    gnttab_free_count, req_entries);
+				    cur, extra, gnttab_max_grant_frames(xh),
+				    gt->gnttab_free_count, req_entries);
 		return -ENOSPC;
 	}
 
-	rc = gnttab_map(cur, cur + extra - 1);
+	rc = gnttab_map(xh, cur, cur + extra - 1);
 	if (rc == 0)
-		rc = grow_gnttab_list(extra);
+		rc = grow_gnttab_list(xh, extra);
 
 	return rc;
 }
 
-int gnttab_init(void)
+int gnttab_init(xenhost_t *xh)
 {
 	int i;
 	unsigned long max_nr_grant_frames;
 	unsigned int max_nr_glist_frames, nr_glist_frames;
 	unsigned int nr_init_grefs;
 	int ret;
+	struct gnttab_private *gt = gt_priv(xh);
 
-	gnttab_request_version();
-	max_nr_grant_frames = gnttab_max_grant_frames();
-	nr_grant_frames = 1;
+	gnttab_request_version(xh);
+	max_nr_grant_frames = gnttab_max_grant_frames(xh);
+	gt->nr_grant_frames = 1;
 
 	/* Determine the maximum number of frames required for the
 	 * grant reference free list on the current hypervisor.
 	 */
-	BUG_ON(gnttab_interface == NULL);
+	BUG_ON(gt->gnttab_interface == NULL);
 	max_nr_glist_frames = (max_nr_grant_frames *
-			       gnttab_interface->grefs_per_grant_frame / RPP);
+			       gt->gnttab_interface->grefs_per_grant_frame / RPP);
 
-	gnttab_list = kmalloc_array(max_nr_glist_frames,
+	gt->gnttab_list = kmalloc_array(max_nr_glist_frames,
 				    sizeof(grant_ref_t *),
 				    GFP_KERNEL);
-	if (gnttab_list == NULL)
+	if (gt->gnttab_list == NULL)
 		return -ENOMEM;
 
-	nr_glist_frames = gnttab_frames(nr_grant_frames, RPP);
+	nr_glist_frames = gnttab_frames(xh, gt->nr_grant_frames, RPP);
 	for (i = 0; i < nr_glist_frames; i++) {
-		gnttab_list[i] = (grant_ref_t *)__get_free_page(GFP_KERNEL);
-		if (gnttab_list[i] == NULL) {
+		gt->gnttab_list[i] = (grant_ref_t *)__get_free_page(GFP_KERNEL);
+		if (gt->gnttab_list[i] == NULL) {
 			ret = -ENOMEM;
 			goto ini_nomem;
 		}
 	}
 
-	ret = arch_gnttab_init(max_nr_grant_frames,
-			       nr_status_frames(max_nr_grant_frames));
+	ret = arch_gnttab_init(xh, max_nr_grant_frames,
+			       nr_status_frames(xh, max_nr_grant_frames));
 	if (ret < 0)
 		goto ini_nomem;
 
-	if (gnttab_setup() < 0) {
+	if (gnttab_setup(xh) < 0) {
 		ret = -ENODEV;
 		goto ini_nomem;
 	}
 
-	nr_init_grefs = nr_grant_frames *
-			gnttab_interface->grefs_per_grant_frame;
+	nr_init_grefs = gt->nr_grant_frames *
+			gt->gnttab_interface->grefs_per_grant_frame;
 
 	for (i = NR_RESERVED_ENTRIES; i < nr_init_grefs - 1; i++)
-		gnttab_entry(i) = i + 1;
+		gnttab_entry(xh, i) = i + 1;
 
-	gnttab_entry(nr_init_grefs - 1) = GNTTAB_LIST_END;
-	gnttab_free_count = nr_init_grefs - NR_RESERVED_ENTRIES;
-	gnttab_free_head  = NR_RESERVED_ENTRIES;
+	gnttab_entry(xh, nr_init_grefs - 1) = GNTTAB_LIST_END;
+	gt->gnttab_free_count = nr_init_grefs - NR_RESERVED_ENTRIES;
+	gt->gnttab_free_head  = NR_RESERVED_ENTRIES;
 
 	printk("Grant table initialized\n");
 	return 0;
 
  ini_nomem:
 	for (i--; i >= 0; i--)
-		free_page((unsigned long)gnttab_list[i]);
-	kfree(gnttab_list);
+		free_page((unsigned long)gt->gnttab_list[i]);
+	kfree(gt->gnttab_list);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(gnttab_init);
 
 static int __gnttab_init(void)
 {
+	xenhost_t **xh;
+	int err;
+
 	if (!xen_domain())
 		return -ENODEV;
 
@@ -1484,8 +1569,14 @@ static int __gnttab_init(void)
 	if (xen_hvm_domain() && !xen_pvh_domain())
 		return 0;
 
-	return gnttab_init();
+	for_each_xenhost(xh) {
+		err = gnttab_init(*xh);
+		if (err)
+			return err;
+	}
+	
+	return 0;
 }
 /* Starts after core_initcall so that xen_pvh_gnttab_setup can be called
- * beforehand to initialize xen_auto_xlat_grant_frames. */
+ * beforehand to initialize auto_xlat_grant_frames. */
 core_initcall_sync(__gnttab_init);
diff --git a/include/xen/grant_table.h b/include/xen/grant_table.h
index 9bc5bc07d4d3..827b790199fb 100644
--- a/include/xen/grant_table.h
+++ b/include/xen/grant_table.h
@@ -74,15 +74,16 @@ struct gntab_unmap_queue_data
 	struct gnttab_unmap_grant_ref *unmap_ops;
 	struct gnttab_unmap_grant_ref *kunmap_ops;
 	struct page **pages;
+	xenhost_t *xh;
 	unsigned int count;
 	unsigned int age;
 };
 
-int gnttab_init(void);
+int gnttab_init(xenhost_t *xh);
 int gnttab_suspend(void);
 int gnttab_resume(void);
 
-int gnttab_grant_foreign_access(domid_t domid, unsigned long frame,
+int gnttab_grant_foreign_access(xenhost_t *xh, domid_t domid, unsigned long frame,
 				int readonly);
 
 /*
@@ -90,7 +91,7 @@ int gnttab_grant_foreign_access(domid_t domid, unsigned long frame,
  * longer in use.  Return 1 if the grant entry was freed, 0 if it is still in
  * use.
  */
-int gnttab_end_foreign_access_ref(grant_ref_t ref, int readonly);
+int gnttab_end_foreign_access_ref(xenhost_t *xh, grant_ref_t ref, int readonly);
 
 /*
  * Eventually end access through the given grant reference, and once that
@@ -98,49 +99,49 @@ int gnttab_end_foreign_access_ref(grant_ref_t ref, int readonly);
  * immediately iff the grant entry is not in use, otherwise it will happen
  * some time later.  page may be 0, in which case no freeing will occur.
  */
-void gnttab_end_foreign_access(grant_ref_t ref, int readonly,
+void gnttab_end_foreign_access(xenhost_t *xh, grant_ref_t ref, int readonly,
 			       unsigned long page);
 
-int gnttab_grant_foreign_transfer(domid_t domid, unsigned long pfn);
+int gnttab_grant_foreign_transfer(xenhost_t *xh, domid_t domid, unsigned long pfn);
 
-unsigned long gnttab_end_foreign_transfer_ref(grant_ref_t ref);
-unsigned long gnttab_end_foreign_transfer(grant_ref_t ref);
+unsigned long gnttab_end_foreign_transfer_ref(xenhost_t *xh, grant_ref_t ref);
+unsigned long gnttab_end_foreign_transfer(xenhost_t *xh, grant_ref_t ref);
 
-int gnttab_query_foreign_access(grant_ref_t ref);
+int gnttab_query_foreign_access(xenhost_t *xh, grant_ref_t ref);
 
 /*
  * operations on reserved batches of grant references
  */
-int gnttab_alloc_grant_references(u16 count, grant_ref_t *pprivate_head);
+int gnttab_alloc_grant_references(xenhost_t *xh, u16 count, grant_ref_t *pprivate_head);
 
-void gnttab_free_grant_reference(grant_ref_t ref);
+void gnttab_free_grant_reference(xenhost_t *xh, grant_ref_t ref);
 
-void gnttab_free_grant_references(grant_ref_t head);
+void gnttab_free_grant_references(xenhost_t *xh, grant_ref_t head);
 
-int gnttab_empty_grant_references(const grant_ref_t *pprivate_head);
+int gnttab_empty_grant_references(xenhost_t *xh, const grant_ref_t *pprivate_head);
 
-int gnttab_claim_grant_reference(grant_ref_t *pprivate_head);
+int gnttab_claim_grant_reference(xenhost_t *xh, grant_ref_t *pprivate_head);
 
-void gnttab_release_grant_reference(grant_ref_t *private_head,
+void gnttab_release_grant_reference(xenhost_t *xh, grant_ref_t *private_head,
 				    grant_ref_t release);
 
-void gnttab_request_free_callback(struct gnttab_free_callback *callback,
+void gnttab_request_free_callback(xenhost_t *xh, struct gnttab_free_callback *callback,
 				  void (*fn)(void *), void *arg, u16 count);
-void gnttab_cancel_free_callback(struct gnttab_free_callback *callback);
+void gnttab_cancel_free_callback(xenhost_t *xh, struct gnttab_free_callback *callback);
 
-void gnttab_grant_foreign_access_ref(grant_ref_t ref, domid_t domid,
+void gnttab_grant_foreign_access_ref(xenhost_t *xh, grant_ref_t ref, domid_t domid,
 				     unsigned long frame, int readonly);
 
 /* Give access to the first 4K of the page */
 static inline void gnttab_page_grant_foreign_access_ref_one(
-	grant_ref_t ref, domid_t domid,
+	xenhost_t *xh, grant_ref_t ref, domid_t domid,
 	struct page *page, int readonly)
 {
-	gnttab_grant_foreign_access_ref(ref, domid, xen_page_to_gfn(page),
+	gnttab_grant_foreign_access_ref(xh, ref, domid, xen_page_to_gfn(page),
 					readonly);
 }
 
-void gnttab_grant_foreign_transfer_ref(grant_ref_t, domid_t domid,
+void gnttab_grant_foreign_transfer_ref(xenhost_t *xh, grant_ref_t, domid_t domid,
 				       unsigned long pfn);
 
 static inline void
@@ -174,29 +175,28 @@ gnttab_set_unmap_op(struct gnttab_unmap_grant_ref *unmap, phys_addr_t addr,
 	unmap->dev_bus_addr = 0;
 }
 
-int arch_gnttab_init(unsigned long nr_shared, unsigned long nr_status);
-int arch_gnttab_map_shared(xen_pfn_t *frames, unsigned long nr_gframes,
+int arch_gnttab_init(xenhost_t *xh, unsigned long nr_shared, unsigned long nr_status);
+int arch_gnttab_map_shared(xenhost_t *xh, xen_pfn_t *frames, unsigned long nr_gframes,
 			   unsigned long max_nr_gframes,
 			   void **__shared);
-int arch_gnttab_map_status(uint64_t *frames, unsigned long nr_gframes,
+int arch_gnttab_map_status(xenhost_t *xh, uint64_t *frames, unsigned long nr_gframes,
 			   unsigned long max_nr_gframes,
 			   grant_status_t **__shared);
-void arch_gnttab_unmap(void *shared, unsigned long nr_gframes);
+void arch_gnttab_unmap(xenhost_t *xh, void *shared, unsigned long nr_gframes);
 
 struct grant_frames {
 	xen_pfn_t *pfn;
 	unsigned int count;
 	void *vaddr;
 };
-extern struct grant_frames xen_auto_xlat_grant_frames;
-unsigned int gnttab_max_grant_frames(void);
-int gnttab_setup_auto_xlat_frames(phys_addr_t addr);
-void gnttab_free_auto_xlat_frames(void);
+unsigned int gnttab_max_grant_frames(xenhost_t *xh);
+int gnttab_setup_auto_xlat_frames(xenhost_t *xh, phys_addr_t addr);
+void gnttab_free_auto_xlat_frames(xenhost_t *xh);
 
 #define gnttab_map_vaddr(map) ((void *)(map.host_virt_addr))
 
-int gnttab_alloc_pages(int nr_pages, struct page **pages);
-void gnttab_free_pages(int nr_pages, struct page **pages);
+int gnttab_alloc_pages(xenhost_t *xh, int nr_pages, struct page **pages);
+void gnttab_free_pages(xenhost_t *xh, int nr_pages, struct page **pages);
 
 #ifdef CONFIG_XEN_GRANT_DMA_ALLOC
 struct gnttab_dma_alloc_args {
@@ -212,17 +212,17 @@ struct gnttab_dma_alloc_args {
 	dma_addr_t dev_bus_addr;
 };
 
-int gnttab_dma_alloc_pages(struct gnttab_dma_alloc_args *args);
-int gnttab_dma_free_pages(struct gnttab_dma_alloc_args *args);
+int gnttab_dma_alloc_pages(xenhost_t *xh, struct gnttab_dma_alloc_args *args);
+int gnttab_dma_free_pages(xenhost_t *xh, struct gnttab_dma_alloc_args *args);
 #endif
 
 int gnttab_pages_set_private(int nr_pages, struct page **pages);
 void gnttab_pages_clear_private(int nr_pages, struct page **pages);
 
-int gnttab_map_refs(struct gnttab_map_grant_ref *map_ops,
+int gnttab_map_refs(xenhost_t *xh, struct gnttab_map_grant_ref *map_ops,
 		    struct gnttab_map_grant_ref *kmap_ops,
 		    struct page **pages, unsigned int count);
-int gnttab_unmap_refs(struct gnttab_unmap_grant_ref *unmap_ops,
+int gnttab_unmap_refs(xenhost_t *xh, struct gnttab_unmap_grant_ref *unmap_ops,
 		      struct gnttab_unmap_grant_ref *kunmap_ops,
 		      struct page **pages, unsigned int count);
 void gnttab_unmap_refs_async(struct gntab_unmap_queue_data* item);
@@ -238,8 +238,8 @@ int gnttab_unmap_refs_sync(struct gntab_unmap_queue_data *item);
  * Return value in each iand every status field of the batch guaranteed
  * to not be GNTST_eagain.
  */
-void gnttab_batch_map(struct gnttab_map_grant_ref *batch, unsigned count);
-void gnttab_batch_copy(struct gnttab_copy *batch, unsigned count);
+void gnttab_batch_map(xenhost_t *xh, struct gnttab_map_grant_ref *batch, unsigned count);
+void gnttab_batch_copy(xenhost_t *xh, struct gnttab_copy *batch, unsigned count);
 
 
 struct xen_page_foreign {
diff --git a/include/xen/xenhost.h b/include/xen/xenhost.h
index 9e08627a9e3e..acee0c7872b6 100644
--- a/include/xen/xenhost.h
+++ b/include/xen/xenhost.h
@@ -129,6 +129,17 @@ typedef struct {
 		const struct evtchn_ops *evtchn_ops;
 		int **evtchn_to_irq;
 	};
+
+	/* grant table private state */
+	struct {
+		/* private to drivers/xen/grant-table.c */
+		void *gnttab_private;
+
+		/* x86/xen/grant-table.c */
+		void *gnttab_shared_vm_area;
+		void *gnttab_status_vm_area;
+		void *auto_xlat_grant_frames;
+	};
 } xenhost_t;
 
 typedef struct xenhost_ops {
-- 
2.20.1

