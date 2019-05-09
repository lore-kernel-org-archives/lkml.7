Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1585C04AB2
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 17:28:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9328A21019
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 17:28:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="UUhgHrqU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726993AbfEIR17 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 13:27:59 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:43818 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726698AbfEIR17 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 13:27:59 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x49HJRsh151800;
        Thu, 9 May 2019 17:27:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2018-07-02;
 bh=iWLMbsiTJyORKcVPc67NdIhjZ2dc7OJHEnWet4Ub5Kw=;
 b=UUhgHrqUJgZ3v9UuVkW2DqgDOyDIWCs+T4FiLAWvwDYYvcQRUMbYqDwbOKwEuEd1zlA4
 78TMJzClr18NPm5bRYYUEW5YqF0rwhRxrWUL9aUqWa7fAlCV6p9FZifQ6IIvxx3MH40R
 e99M9cLzy3zKhdV/WINfvGwqfnMpaXnPdvJkXrck7RIQsPe3RTXUyUQh4OUvQm/YBVsA
 uRo+4Pu8nZAjKvzHeQdidgFZ/qIGFw+RPvjsNULDAJe5anjEIHqLkB36jCM39vLIEGDO
 c1s5XVLXyP2UqMqApeSVTaNa1Mxdcde4yjccnHI09DrN9f2u5E5KQAXcV+EwrdhG7DzN FA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 2s94bgcep8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 09 May 2019 17:27:44 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x49HP7IS119737;
        Thu, 9 May 2019 17:25:43 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 2scpy5t22t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 09 May 2019 17:25:43 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x49HPhCr019337;
        Thu, 9 May 2019 17:25:43 GMT
Received: from aa1-ca-oracle-com.ca.oracle.com (/10.156.75.204)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 09 May 2019 10:25:42 -0700
From:   Ankur Arora <ankur.a.arora@oracle.com>
To:     linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org
Cc:     jgross@suse.com, pbonzini@redhat.com, boris.ostrovsky@oracle.com,
        konrad.wilk@oracle.com, sstabellini@kernel.org,
        joao.m.martins@oracle.com, ankur.a.arora@oracle.com
Subject: [RFC PATCH 10/16] xen/balloon: support ballooning in xenhost_t
Date:   Thu,  9 May 2019 10:25:34 -0700
Message-Id: <20190509172540.12398-11-ankur.a.arora@oracle.com>
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

Xen ballooning uses hollow struct pages (with the underlying GFNs being
populated/unpopulated via hypercalls) which are used by the grant logic
to map grants from other domains.

This patch allows the default xenhost to provide an alternate ballooning
allocation mechanism. This is expected to be useful for local xenhosts
(type xenhost_r0) because unlike Xen, where there is an external
hypervisor which can change the memory underneath a GFN, that is not
possible when the hypervisor is running in the same address space
as the entity doing the ballooning.

Co-developed-by: Ankur Arora <ankur.a.arora@oracle.com>
Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 arch/x86/xen/enlighten_hvm.c       |  7 +++++++
 arch/x86/xen/enlighten_pv.c        |  8 ++++++++
 drivers/xen/balloon.c              | 19 ++++++++++++++++---
 drivers/xen/grant-table.c          |  4 ++--
 drivers/xen/privcmd.c              |  4 ++--
 drivers/xen/xen-selfballoon.c      |  2 ++
 drivers/xen/xenbus/xenbus_client.c |  6 +++---
 drivers/xen/xlate_mmu.c            |  4 ++--
 include/xen/balloon.h              |  4 ++--
 include/xen/xenhost.h              | 19 +++++++++++++++++++
 10 files changed, 63 insertions(+), 14 deletions(-)

diff --git a/arch/x86/xen/enlighten_hvm.c b/arch/x86/xen/enlighten_hvm.c
index efe483ceeb9a..a371bb9ee478 100644
--- a/arch/x86/xen/enlighten_hvm.c
+++ b/arch/x86/xen/enlighten_hvm.c
@@ -130,9 +130,16 @@ xenhost_ops_t xh_hvm_ops = {
 	.setup_shared_info = xen_hvm_init_shared_info,
 	.reset_shared_info = xen_hvm_reset_shared_info,
 	.probe_vcpu_id = xen_hvm_probe_vcpu_id,
+
+	/* We just use the default method of ballooning. */
+	.alloc_ballooned_pages = NULL,
+	.free_ballooned_pages = NULL,
 };
 
 xenhost_ops_t xh_hvm_nested_ops = {
+	/* Nested xenhosts, are disallowed ballooning */
+	.alloc_ballooned_pages = NULL,
+	.free_ballooned_pages = NULL,
 };
 
 static void __init init_hvm_pv_info(void)
diff --git a/arch/x86/xen/enlighten_pv.c b/arch/x86/xen/enlighten_pv.c
index 77b1a0d4aef2..2e94e02cdbb4 100644
--- a/arch/x86/xen/enlighten_pv.c
+++ b/arch/x86/xen/enlighten_pv.c
@@ -1247,11 +1247,19 @@ xenhost_ops_t xh_pv_ops = {
 	.reset_shared_info = xen_pv_reset_shared_info,
 
 	.probe_vcpu_id = xen_pv_probe_vcpu_id,
+
+	/* We just use the default method of ballooning. */
+	.alloc_ballooned_pages = NULL,
+	.free_ballooned_pages = NULL,
 };
 
 xenhost_ops_t xh_pv_nested_ops = {
 	.cpuid_base = xen_pv_nested_cpuid_base,
 	.setup_hypercall_page = NULL,
+
+	/* Nested xenhosts, are disallowed ballooning */
+	.alloc_ballooned_pages = NULL,
+	.free_ballooned_pages = NULL,
 };
 
 /* First C function to be called on Xen boot */
diff --git a/drivers/xen/balloon.c b/drivers/xen/balloon.c
index 5ef4d6ad920d..08becf574743 100644
--- a/drivers/xen/balloon.c
+++ b/drivers/xen/balloon.c
@@ -63,6 +63,7 @@
 #include <asm/tlb.h>
 
 #include <xen/interface/xen.h>
+#include <xen/xenhost.h>
 #include <asm/xen/hypervisor.h>
 #include <asm/xen/hypercall.h>
 
@@ -583,12 +584,21 @@ static int add_ballooned_pages(int nr_pages)
  * @pages: pages returned
  * @return 0 on success, error otherwise
  */
-int alloc_xenballooned_pages(int nr_pages, struct page **pages)
+int alloc_xenballooned_pages(xenhost_t *xh, int nr_pages, struct page **pages)
 {
 	int pgno = 0;
 	struct page *page;
 	int ret;
 
+	/*
+	 * xenmem transactions for remote xenhost are disallowed.
+	 */
+	if (xh->type == xenhost_r2)
+		return -EINVAL;
+
+	if (xh->ops->alloc_ballooned_pages)
+		return xh->ops->alloc_ballooned_pages(xh, nr_pages, pages);
+
 	mutex_lock(&balloon_mutex);
 
 	balloon_stats.target_unpopulated += nr_pages;
@@ -620,7 +630,7 @@ int alloc_xenballooned_pages(int nr_pages, struct page **pages)
 	return 0;
  out_undo:
 	mutex_unlock(&balloon_mutex);
-	free_xenballooned_pages(pgno, pages);
+	free_xenballooned_pages(xh, pgno, pages);
 	return ret;
 }
 EXPORT_SYMBOL(alloc_xenballooned_pages);
@@ -630,10 +640,13 @@ EXPORT_SYMBOL(alloc_xenballooned_pages);
  * @nr_pages: Number of pages
  * @pages: pages to return
  */
-void free_xenballooned_pages(int nr_pages, struct page **pages)
+void free_xenballooned_pages(xenhost_t *xh, int nr_pages, struct page **pages)
 {
 	int i;
 
+	if (xh->ops->free_ballooned_pages)
+		return xh->ops->free_ballooned_pages(xh, nr_pages, pages);
+
 	mutex_lock(&balloon_mutex);
 
 	for (i = 0; i < nr_pages; i++) {
diff --git a/drivers/xen/grant-table.c b/drivers/xen/grant-table.c
index 98af259d0d4f..ec90769907a4 100644
--- a/drivers/xen/grant-table.c
+++ b/drivers/xen/grant-table.c
@@ -804,7 +804,7 @@ int gnttab_alloc_pages(int nr_pages, struct page **pages)
 {
 	int ret;
 
-	ret = alloc_xenballooned_pages(nr_pages, pages);
+	ret = alloc_xenballooned_pages(xh_default, nr_pages, pages);
 	if (ret < 0)
 		return ret;
 
@@ -839,7 +839,7 @@ EXPORT_SYMBOL_GPL(gnttab_pages_clear_private);
 void gnttab_free_pages(int nr_pages, struct page **pages)
 {
 	gnttab_pages_clear_private(nr_pages, pages);
-	free_xenballooned_pages(nr_pages, pages);
+	free_xenballooned_pages(xh_default, nr_pages, pages);
 }
 EXPORT_SYMBOL_GPL(gnttab_free_pages);
 
diff --git a/drivers/xen/privcmd.c b/drivers/xen/privcmd.c
index b5541f862720..88cd99e4f5c1 100644
--- a/drivers/xen/privcmd.c
+++ b/drivers/xen/privcmd.c
@@ -427,7 +427,7 @@ static int alloc_empty_pages(struct vm_area_struct *vma, int numpgs)
 	if (pages == NULL)
 		return -ENOMEM;
 
-	rc = alloc_xenballooned_pages(numpgs, pages);
+	rc = alloc_xenballooned_pages(xh_default, numpgs, pages);
 	if (rc != 0) {
 		pr_warn("%s Could not alloc %d pfns rc:%d\n", __func__,
 			numpgs, rc);
@@ -928,7 +928,7 @@ static void privcmd_close(struct vm_area_struct *vma)
 
 	rc = xen_unmap_domain_gfn_range(vma, numgfns, pages);
 	if (rc == 0)
-		free_xenballooned_pages(numpgs, pages);
+		free_xenballooned_pages(xh_default, numpgs, pages);
 	else
 		pr_crit("unable to unmap MFN range: leaking %d pages. rc=%d\n",
 			numpgs, rc);
diff --git a/drivers/xen/xen-selfballoon.c b/drivers/xen/xen-selfballoon.c
index 246f6122c9ee..83a3995a33e3 100644
--- a/drivers/xen/xen-selfballoon.c
+++ b/drivers/xen/xen-selfballoon.c
@@ -74,6 +74,8 @@
 #include <linux/mman.h>
 #include <linux/workqueue.h>
 #include <linux/device.h>
+#include <xen/interface/xen.h>
+#include <xen/xenhost.h>
 #include <xen/balloon.h>
 #include <xen/tmem.h>
 #include <xen/xen.h>
diff --git a/drivers/xen/xenbus/xenbus_client.c b/drivers/xen/xenbus/xenbus_client.c
index f0cf47765726..5748fbaf0238 100644
--- a/drivers/xen/xenbus/xenbus_client.c
+++ b/drivers/xen/xenbus/xenbus_client.c
@@ -563,7 +563,7 @@ static int xenbus_map_ring_valloc_hvm(struct xenbus_device *dev,
 	if (!node)
 		return -ENOMEM;
 
-	err = alloc_xenballooned_pages(nr_pages, node->hvm.pages);
+	err = alloc_xenballooned_pages(xh_default, nr_pages, node->hvm.pages);
 	if (err)
 		goto out_err;
 
@@ -602,7 +602,7 @@ static int xenbus_map_ring_valloc_hvm(struct xenbus_device *dev,
 			 addr, nr_pages);
  out_free_ballooned_pages:
 	if (!leaked)
-		free_xenballooned_pages(nr_pages, node->hvm.pages);
+		free_xenballooned_pages(xh_default, nr_pages, node->hvm.pages);
  out_err:
 	kfree(node);
 	return err;
@@ -849,7 +849,7 @@ static int xenbus_unmap_ring_vfree_hvm(struct xenbus_device *dev, void *vaddr)
 			       info.addrs);
 	if (!rv) {
 		vunmap(vaddr);
-		free_xenballooned_pages(nr_pages, node->hvm.pages);
+		free_xenballooned_pages(xh_default, nr_pages, node->hvm.pages);
 	}
 	else
 		WARN(1, "Leaking %p, size %u page(s)\n", vaddr, nr_pages);
diff --git a/drivers/xen/xlate_mmu.c b/drivers/xen/xlate_mmu.c
index e7df65d32c91..f25a80a4076b 100644
--- a/drivers/xen/xlate_mmu.c
+++ b/drivers/xen/xlate_mmu.c
@@ -233,7 +233,7 @@ int __init xen_xlate_map_ballooned_pages(xen_pfn_t **gfns, void **virt,
 		kfree(pages);
 		return -ENOMEM;
 	}
-	rc = alloc_xenballooned_pages(nr_pages, pages);
+	rc = alloc_xenballooned_pages(xh_default, nr_pages, pages);
 	if (rc) {
 		pr_warn("%s Couldn't balloon alloc %ld pages rc:%d\n", __func__,
 			nr_pages, rc);
@@ -250,7 +250,7 @@ int __init xen_xlate_map_ballooned_pages(xen_pfn_t **gfns, void **virt,
 	if (!vaddr) {
 		pr_warn("%s Couldn't map %ld pages rc:%d\n", __func__,
 			nr_pages, rc);
-		free_xenballooned_pages(nr_pages, pages);
+		free_xenballooned_pages(xh_default, nr_pages, pages);
 		kfree(pages);
 		kfree(pfns);
 		return -ENOMEM;
diff --git a/include/xen/balloon.h b/include/xen/balloon.h
index 4914b93a23f2..e8fb5a5ef490 100644
--- a/include/xen/balloon.h
+++ b/include/xen/balloon.h
@@ -24,8 +24,8 @@ extern struct balloon_stats balloon_stats;
 
 void balloon_set_new_target(unsigned long target);
 
-int alloc_xenballooned_pages(int nr_pages, struct page **pages);
-void free_xenballooned_pages(int nr_pages, struct page **pages);
+int alloc_xenballooned_pages(xenhost_t *xh, int nr_pages, struct page **pages);
+void free_xenballooned_pages(xenhost_t *xh, int nr_pages, struct page **pages);
 
 struct device;
 #ifdef CONFIG_XEN_SELFBALLOONING
diff --git a/include/xen/xenhost.h b/include/xen/xenhost.h
index c9dabf739ff8..9e08627a9e3e 100644
--- a/include/xen/xenhost.h
+++ b/include/xen/xenhost.h
@@ -198,6 +198,25 @@ typedef struct xenhost_ops {
 	 * get accessed via pv_ops.irq.* and the evtchn logic.
 	 */
 	void (*probe_vcpu_id)(xenhost_t *xenhost, int cpu);
+
+	/*
+	 * We only want to do ballooning with the default xenhost -- two
+	 * hypervisors managing a guest's memory is unlikely to lead anywhere
+	 * good and xenballooned frames obtained from the default xenhost can
+	 * be just as well populated by the remote xenhost (which is what we
+	 * will need it for.)
+	 *
+	 * xenhost_r1: unchanged from before.
+	 * xenhost_r2: disallowed.
+	 * xenhost_r0: for a local xenhost, unlike Xen, there's no external entity
+	 *  which can remap pages, so the balloon alocation here just returns page-0.
+	 *  When the allocated page is used (in GNTTABOP_map_grant_ref), we fix this
+	 *  up by returning the correct page.
+	 */
+
+	int (*alloc_ballooned_pages)(xenhost_t *xh, int nr_pages, struct page **pages);
+	void (*free_ballooned_pages)(xenhost_t *xh, int nr_pages, struct page **pages);
+
 } xenhost_ops_t;
 
 extern xenhost_t *xh_default, *xh_remote;
-- 
2.20.1

