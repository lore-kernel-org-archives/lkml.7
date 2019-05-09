Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B540CC04AB2
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 17:26:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76F44217D8
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 17:26:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="wCNbEOUd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726959AbfEIR0G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 13:26:06 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:35216 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726927AbfEIR0D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 13:26:03 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x49HJSKw169534;
        Thu, 9 May 2019 17:25:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2018-07-02;
 bh=8eeODQeRuwFmGZ13uOTkhbpPMHGCcBqOBjA3QDlEv1g=;
 b=wCNbEOUdHJ8UsozLmEVCQ0dJGFhXGSCJArCTfyRrdJaXxGMzvSJ/xRrClddffLN/DWBd
 C4+I0u/cCKKVqxeIwroqWu+SxbephLrkHR9FLSUAmY+qz7Zc1XrPSTiQFw0B6q8ZgWeK
 OrZ3Gw9zGCOsu30hyxUiCnFeB6hBxXRisLuj/QNudKRMNajMOl+5WIHAaKePRnW54PXT
 jg5YYaJBwdaxRr4xdJszyXMebkum3dXhlQQfobGMBDsWQqLz+a/Wb5G5WtZzyqjyEUPQ
 0G6lN3j+A1Huc237lTDm+d/x/eOQ+TrynHGDBrSE7ihHlJWZckKbR8iS24vS6hmJagav DQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 2s94b14e3r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 09 May 2019 17:25:47 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x49HPhkW086661;
        Thu, 9 May 2019 17:25:46 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 2s94agwu3f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 09 May 2019 17:25:46 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x49HPjEO019355;
        Thu, 9 May 2019 17:25:45 GMT
Received: from aa1-ca-oracle-com.ca.oracle.com (/10.156.75.204)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 09 May 2019 10:25:45 -0700
From:   Ankur Arora <ankur.a.arora@oracle.com>
To:     linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org
Cc:     jgross@suse.com, pbonzini@redhat.com, boris.ostrovsky@oracle.com,
        konrad.wilk@oracle.com, sstabellini@kernel.org,
        joao.m.martins@oracle.com, ankur.a.arora@oracle.com
Subject: [RFC PATCH 13/16] drivers/xen: gnttab, evtchn, xenbus API changes
Date:   Thu,  9 May 2019 10:25:37 -0700
Message-Id: <20190509172540.12398-14-ankur.a.arora@oracle.com>
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

Mechanical changes, now most of these calls take xenhost_t *
as parameter.

Co-developed-by: Joao Martins <joao.m.martins@oracle.com>
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 drivers/xen/cpu_hotplug.c     | 14 ++++++-------
 drivers/xen/gntalloc.c        | 13 ++++++++----
 drivers/xen/gntdev.c          | 16 +++++++++++----
 drivers/xen/manage.c          | 37 ++++++++++++++++++-----------------
 drivers/xen/platform-pci.c    | 12 +++++++-----
 drivers/xen/sys-hypervisor.c  | 12 ++++++++----
 drivers/xen/xen-balloon.c     | 10 +++++++---
 drivers/xen/xenfs/xenstored.c |  7 ++++---
 8 files changed, 73 insertions(+), 48 deletions(-)

diff --git a/drivers/xen/cpu_hotplug.c b/drivers/xen/cpu_hotplug.c
index afeb94446d34..4a05bc028956 100644
--- a/drivers/xen/cpu_hotplug.c
+++ b/drivers/xen/cpu_hotplug.c
@@ -31,13 +31,13 @@ static void disable_hotplug_cpu(int cpu)
 	unlock_device_hotplug();
 }
 
-static int vcpu_online(unsigned int cpu)
+static int vcpu_online(xenhost_t *xh, unsigned int cpu)
 {
 	int err;
 	char dir[16], state[16];
 
 	sprintf(dir, "cpu/%u", cpu);
-	err = xenbus_scanf(xh_default, XBT_NIL, dir, "availability", "%15s", state);
+	err = xenbus_scanf(xh, XBT_NIL, dir, "availability", "%15s", state);
 	if (err != 1) {
 		if (!xen_initial_domain())
 			pr_err("Unable to read cpu state\n");
@@ -52,12 +52,12 @@ static int vcpu_online(unsigned int cpu)
 	pr_err("unknown state(%s) on CPU%d\n", state, cpu);
 	return -EINVAL;
 }
-static void vcpu_hotplug(unsigned int cpu)
+static void vcpu_hotplug(xenhost_t *xh, unsigned int cpu)
 {
 	if (!cpu_possible(cpu))
 		return;
 
-	switch (vcpu_online(cpu)) {
+	switch (vcpu_online(xh, cpu)) {
 	case 1:
 		enable_hotplug_cpu(cpu);
 		break;
@@ -78,7 +78,7 @@ static void handle_vcpu_hotplug_event(struct xenbus_watch *watch,
 	cpustr = strstr(path, "cpu/");
 	if (cpustr != NULL) {
 		sscanf(cpustr, "cpu/%u", &cpu);
-		vcpu_hotplug(cpu);
+		vcpu_hotplug(watch->xh, cpu);
 	}
 }
 
@@ -93,7 +93,7 @@ static int setup_cpu_watcher(struct notifier_block *notifier,
 	(void)register_xenbus_watch(xh_default, &cpu_watch);
 
 	for_each_possible_cpu(cpu) {
-		if (vcpu_online(cpu) == 0) {
+		if (vcpu_online(cpu_watch.xh, cpu) == 0) {
 			(void)cpu_down(cpu);
 			set_cpu_present(cpu, false);
 		}
@@ -114,7 +114,7 @@ static int __init setup_vcpu_hotplug_event(void)
 #endif
 		return -ENODEV;
 
-	register_xenstore_notifier(&xsn_cpu);
+	register_xenstore_notifier(xh_default, &xsn_cpu);
 
 	return 0;
 }
diff --git a/drivers/xen/gntalloc.c b/drivers/xen/gntalloc.c
index e07823886fa8..a490e4e8c854 100644
--- a/drivers/xen/gntalloc.c
+++ b/drivers/xen/gntalloc.c
@@ -79,6 +79,8 @@ static LIST_HEAD(gref_list);
 static DEFINE_MUTEX(gref_mutex);
 static int gref_size;
 
+static xenhost_t *xh;
+
 struct notify_info {
 	uint16_t pgoff:12;    /* Bits 0-11: Offset of the byte to clear */
 	uint16_t flags:2;     /* Bits 12-13: Unmap notification flags */
@@ -144,7 +146,7 @@ static int add_grefs(struct ioctl_gntalloc_alloc_gref *op,
 		}
 
 		/* Grant foreign access to the page. */
-		rc = gnttab_grant_foreign_access(op->domid,
+		rc = gnttab_grant_foreign_access(xh, op->domid,
 						 xen_page_to_gfn(gref->page),
 						 readonly);
 		if (rc < 0)
@@ -196,13 +198,13 @@ static void __del_gref(struct gntalloc_gref *gref)
 	gref->notify.flags = 0;
 
 	if (gref->gref_id) {
-		if (gnttab_query_foreign_access(gref->gref_id))
+		if (gnttab_query_foreign_access(xh, gref->gref_id))
 			return;
 
-		if (!gnttab_end_foreign_access_ref(gref->gref_id, 0))
+		if (!gnttab_end_foreign_access_ref(xh, gref->gref_id, 0))
 			return;
 
-		gnttab_free_grant_reference(gref->gref_id);
+		gnttab_free_grant_reference(xh, gref->gref_id);
 	}
 
 	gref_size--;
@@ -586,6 +588,9 @@ static int __init gntalloc_init(void)
 	if (!xen_domain())
 		return -ENODEV;
 
+	/* Limit to default xenhost for now. */
+	xh = xh_default;
+
 	err = misc_register(&gntalloc_miscdev);
 	if (err != 0) {
 		pr_err("Could not register misc gntalloc device\n");
diff --git a/drivers/xen/gntdev.c b/drivers/xen/gntdev.c
index 0f0c951cd5b1..40a42abe2dd0 100644
--- a/drivers/xen/gntdev.c
+++ b/drivers/xen/gntdev.c
@@ -67,6 +67,8 @@ static atomic_t pages_mapped = ATOMIC_INIT(0);
 static int use_ptemod;
 #define populate_freeable_maps use_ptemod
 
+static xenhost_t *xh;
+
 static int unmap_grant_pages(struct gntdev_grant_map *map,
 			     int offset, int pages);
 
@@ -114,7 +116,7 @@ static void gntdev_free_map(struct gntdev_grant_map *map)
 	} else
 #endif
 	if (map->pages)
-		gnttab_free_pages(map->count, map->pages);
+		gnttab_free_pages(xh, map->count, map->pages);
 
 #ifdef CONFIG_XEN_GRANT_DMA_ALLOC
 	kfree(map->frames);
@@ -183,7 +185,7 @@ struct gntdev_grant_map *gntdev_alloc_map(struct gntdev_priv *priv, int count,
 		add->dma_bus_addr = args.dev_bus_addr;
 	} else
 #endif
-	if (gnttab_alloc_pages(count, add->pages))
+	if (gnttab_alloc_pages(xh, count, add->pages))
 		goto err;
 
 	for (i = 0; i < count; i++) {
@@ -339,7 +341,7 @@ int gntdev_map_grant_pages(struct gntdev_grant_map *map)
 	}
 
 	pr_debug("map %d+%d\n", map->index, map->count);
-	err = gnttab_map_refs(map->map_ops, use_ptemod ? map->kmap_ops : NULL,
+	err = gnttab_map_refs(xh, map->map_ops, use_ptemod ? map->kmap_ops : NULL,
 			map->pages, map->count);
 	if (err)
 		return err;
@@ -385,6 +387,7 @@ static int __unmap_grant_pages(struct gntdev_grant_map *map, int offset,
 	unmap_data.kunmap_ops = use_ptemod ? map->kunmap_ops + offset : NULL;
 	unmap_data.pages = map->pages + offset;
 	unmap_data.count = pages;
+	unmap_data.xh = xh;
 
 	err = gnttab_unmap_refs_sync(&unmap_data);
 	if (err)
@@ -877,7 +880,7 @@ static int gntdev_copy(struct gntdev_copy_batch *batch)
 {
 	unsigned int i;
 
-	gnttab_batch_copy(batch->ops, batch->nr_ops);
+	gnttab_batch_copy(xh, batch->ops, batch->nr_ops);
 	gntdev_put_pages(batch);
 
 	/*
@@ -1210,8 +1213,13 @@ static int __init gntdev_init(void)
 	if (!xen_domain())
 		return -ENODEV;
 
+	/*
+	 * Use for mappings grants related to the default xenhost.
+	 */
+	xh = xh_default;
 	use_ptemod = !xen_feature(XENFEAT_auto_translated_physmap);
 
+
 	err = misc_register(&gntdev_miscdev);
 	if (err != 0) {
 		pr_err("Could not register gntdev device\n");
diff --git a/drivers/xen/manage.c b/drivers/xen/manage.c
index 9a69d955dd5c..1655d0a039fd 100644
--- a/drivers/xen/manage.c
+++ b/drivers/xen/manage.c
@@ -227,14 +227,14 @@ static void shutdown_handler(struct xenbus_watch *watch,
 		return;
 
  again:
-	err = xenbus_transaction_start(xh_default, &xbt);
+	err = xenbus_transaction_start(watch->xh, &xbt);
 	if (err)
 		return;
 
-	str = (char *)xenbus_read(xh_default, xbt, "control", "shutdown", NULL);
+	str = (char *)xenbus_read(watch->xh, xbt, "control", "shutdown", NULL);
 	/* Ignore read errors and empty reads. */
 	if (XENBUS_IS_ERR_READ(str)) {
-		xenbus_transaction_end(xh_default, xbt, 1);
+		xenbus_transaction_end(watch->xh, xbt, 1);
 		return;
 	}
 
@@ -245,9 +245,9 @@ static void shutdown_handler(struct xenbus_watch *watch,
 
 	/* Only acknowledge commands which we are prepared to handle. */
 	if (idx < ARRAY_SIZE(shutdown_handlers))
-		xenbus_write(xh_default, xbt, "control", "shutdown", "");
+		xenbus_write(watch->xh, xbt, "control", "shutdown", "");
 
-	err = xenbus_transaction_end(xh_default, xbt, 0);
+	err = xenbus_transaction_end(watch->xh, xbt, 0);
 	if (err == -EAGAIN) {
 		kfree(str);
 		goto again;
@@ -272,10 +272,10 @@ static void sysrq_handler(struct xenbus_watch *watch, const char *path,
 	int err;
 
  again:
-	err = xenbus_transaction_start(xh_default, &xbt);
+	err = xenbus_transaction_start(watch->xh, &xbt);
 	if (err)
 		return;
-	err = xenbus_scanf(xh_default, xbt, "control", "sysrq", "%c", &sysrq_key);
+	err = xenbus_scanf(watch->xh, xbt, "control", "sysrq", "%c", &sysrq_key);
 	if (err < 0) {
 		/*
 		 * The Xenstore watch fires directly after registering it and
@@ -287,21 +287,21 @@ static void sysrq_handler(struct xenbus_watch *watch, const char *path,
 		if (err != -ENOENT && err != -ERANGE)
 			pr_err("Error %d reading sysrq code in control/sysrq\n",
 			       err);
-		xenbus_transaction_end(xh_default, xbt, 1);
+		xenbus_transaction_end(watch->xh, xbt, 1);
 		return;
 	}
 
 	if (sysrq_key != '\0') {
-		err = xenbus_printf(xh_default, xbt, "control", "sysrq", "%c", '\0');
+		err = xenbus_printf(watch->xh, xbt, "control", "sysrq", "%c", '\0');
 		if (err) {
 			pr_err("%s: Error %d writing sysrq in control/sysrq\n",
 			       __func__, err);
-			xenbus_transaction_end(xh_default, xbt, 1);
+			xenbus_transaction_end(watch->xh, xbt, 1);
 			return;
 		}
 	}
 
-	err = xenbus_transaction_end(xh_default, xbt, 0);
+	err = xenbus_transaction_end(watch->xh, xbt, 0);
 	if (err == -EAGAIN)
 		goto again;
 
@@ -324,14 +324,14 @@ static struct notifier_block xen_reboot_nb = {
 	.notifier_call = poweroff_nb,
 };
 
-static int setup_shutdown_watcher(void)
+static int setup_shutdown_watcher(xenhost_t *xh)
 {
 	int err;
 	int idx;
 #define FEATURE_PATH_SIZE (SHUTDOWN_CMD_SIZE + sizeof("feature-"))
 	char node[FEATURE_PATH_SIZE];
 
-	err = register_xenbus_watch(xh_default, &shutdown_watch);
+	err = register_xenbus_watch(xh, &shutdown_watch);
 	if (err) {
 		pr_err("Failed to set shutdown watcher\n");
 		return err;
@@ -339,7 +339,7 @@ static int setup_shutdown_watcher(void)
 
 
 #ifdef CONFIG_MAGIC_SYSRQ
-	err = register_xenbus_watch(xh_default, &sysrq_watch);
+	err = register_xenbus_watch(xh, &sysrq_watch);
 	if (err) {
 		pr_err("Failed to set sysrq watcher\n");
 		return err;
@@ -351,7 +351,7 @@ static int setup_shutdown_watcher(void)
 			continue;
 		snprintf(node, FEATURE_PATH_SIZE, "feature-%s",
 			 shutdown_handlers[idx].command);
-		err = xenbus_printf(xh_default, XBT_NIL, "control", node, "%u", 1);
+		err = xenbus_printf(xh, XBT_NIL, "control", node, "%u", 1);
 		if (err) {
 			pr_err("%s: Error %d writing %s\n", __func__,
 				err, node);
@@ -364,9 +364,9 @@ static int setup_shutdown_watcher(void)
 
 static int shutdown_event(struct notifier_block *notifier,
 			  unsigned long event,
-			  void *data)
+			  void *xh)
 {
-	setup_shutdown_watcher();
+	setup_shutdown_watcher((xenhost_t *) xh);
 	return NOTIFY_DONE;
 }
 
@@ -378,7 +378,8 @@ int xen_setup_shutdown_event(void)
 
 	if (!xen_domain())
 		return -ENODEV;
-	register_xenstore_notifier(&xenstore_notifier);
+
+	register_xenstore_notifier(xh_default, &xenstore_notifier);
 	register_reboot_notifier(&xen_reboot_nb);
 
 	return 0;
diff --git a/drivers/xen/platform-pci.c b/drivers/xen/platform-pci.c
index 5d7dcad0b0a0..8fdb01c4a610 100644
--- a/drivers/xen/platform-pci.c
+++ b/drivers/xen/platform-pci.c
@@ -154,18 +154,20 @@ static int platform_pci_probe(struct pci_dev *pdev,
 		}
 	}
 
-	max_nr_gframes = gnttab_max_grant_frames();
+	max_nr_gframes = gnttab_max_grant_frames(xh_default);
 	grant_frames = alloc_xen_mmio(PAGE_SIZE * max_nr_gframes);
-	ret = gnttab_setup_auto_xlat_frames(grant_frames);
+	ret = gnttab_setup_auto_xlat_frames(xh_default, grant_frames);
 	if (ret)
 		goto out;
-	ret = gnttab_init();
+
+	/* HVM only, we don't need xh_remote */
+	ret = gnttab_init(xh_default);
 	if (ret)
 		goto grant_out;
-	xenbus_probe(NULL);
+	__xenbus_probe(xh_default->xenstore_private);
 	return 0;
 grant_out:
-	gnttab_free_auto_xlat_frames();
+	gnttab_free_auto_xlat_frames(xh_default);
 out:
 	pci_release_region(pdev, 0);
 mem_out:
diff --git a/drivers/xen/sys-hypervisor.c b/drivers/xen/sys-hypervisor.c
index 005a898e7a23..d69c0790692c 100644
--- a/drivers/xen/sys-hypervisor.c
+++ b/drivers/xen/sys-hypervisor.c
@@ -14,6 +14,7 @@
 #include <linux/err.h>
 
 #include <xen/interface/xen.h>
+#include <xen/xenhost.h>
 #include <asm/xen/hypervisor.h>
 #include <asm/xen/hypercall.h>
 
@@ -141,15 +142,15 @@ static ssize_t uuid_show_fallback(struct hyp_sysfs_attr *attr, char *buffer)
 {
 	char *vm, *val;
 	int ret;
-	extern int xenstored_ready;
 
+	/* Disable for now: xenstored_ready is private to xenbus
 	if (!xenstored_ready)
-		return -EBUSY;
+		return -EBUSY;*/
 
-	vm = xenbus_read(XBT_NIL, "vm", "", NULL);
+	vm = xenbus_read(xh_default, XBT_NIL, "vm", "", NULL);
 	if (IS_ERR(vm))
 		return PTR_ERR(vm);
-	val = xenbus_read(XBT_NIL, vm, "uuid", NULL);
+	val = xenbus_read(xh_default, XBT_NIL, vm, "uuid", NULL);
 	kfree(vm);
 	if (IS_ERR(val))
 		return PTR_ERR(val);
@@ -602,6 +603,9 @@ static struct kobj_type hyp_sysfs_kobj_type = {
 	.sysfs_ops = &hyp_sysfs_ops,
 };
 
+/*
+ * For now, default xenhost only.
+ */
 static int __init hypervisor_subsys_init(void)
 {
 	if (!xen_domain())
diff --git a/drivers/xen/xen-balloon.c b/drivers/xen/xen-balloon.c
index d34d9b1af7a8..9d448dd7ff17 100644
--- a/drivers/xen/xen-balloon.c
+++ b/drivers/xen/xen-balloon.c
@@ -40,6 +40,7 @@
 
 #include <xen/xen.h>
 #include <xen/interface/xen.h>
+#include <xen/xenhost.h>
 #include <xen/balloon.h>
 #include <xen/xenbus.h>
 #include <xen/features.h>
@@ -99,11 +100,11 @@ static struct xenbus_watch target_watch = {
 
 static int balloon_init_watcher(struct notifier_block *notifier,
 				unsigned long event,
-				void *data)
+				void *xh)
 {
 	int err;
 
-	err = register_xenbus_watch(xh_default, &target_watch);
+	err = register_xenbus_watch(xh, &target_watch);
 	if (err)
 		pr_err("Failed to set balloon watcher\n");
 
@@ -120,7 +121,10 @@ void xen_balloon_init(void)
 
 	register_xen_selfballooning(&balloon_dev);
 
-	register_xenstore_notifier(&xenstore_notifier);
+	/*
+	 * ballooning is only concerned with the default xenhost.
+	 */
+	register_xenstore_notifier(xh_default, &xenstore_notifier);
 }
 EXPORT_SYMBOL_GPL(xen_balloon_init);
 
diff --git a/drivers/xen/xenfs/xenstored.c b/drivers/xen/xenfs/xenstored.c
index f59235f9f8a2..1d66974ae730 100644
--- a/drivers/xen/xenfs/xenstored.c
+++ b/drivers/xen/xenfs/xenstored.c
@@ -8,6 +8,7 @@
 #include <xen/xenbus.h>
 
 #include "xenfs.h"
+#include "../xenbus/xenbus.h" /* FIXME */
 
 static ssize_t xsd_read(struct file *file, char __user *buf,
 			    size_t size, loff_t *off)
@@ -25,7 +26,7 @@ static int xsd_release(struct inode *inode, struct file *file)
 static int xsd_kva_open(struct inode *inode, struct file *file)
 {
 	file->private_data = (void *)kasprintf(GFP_KERNEL, "0x%p",
-					       xen_store_interface);
+					       xs_priv(xh_default)->store_interface);
 	if (!file->private_data)
 		return -ENOMEM;
 	return 0;
@@ -39,7 +40,7 @@ static int xsd_kva_mmap(struct file *file, struct vm_area_struct *vma)
 		return -EINVAL;
 
 	if (remap_pfn_range(vma, vma->vm_start,
-			    virt_to_pfn(xen_store_interface),
+			    virt_to_pfn(xs_priv(xh_default)->store_interface),
 			    size, vma->vm_page_prot))
 		return -EAGAIN;
 
@@ -56,7 +57,7 @@ const struct file_operations xsd_kva_file_ops = {
 static int xsd_port_open(struct inode *inode, struct file *file)
 {
 	file->private_data = (void *)kasprintf(GFP_KERNEL, "%d",
-					       xen_store_evtchn);
+					       xs_priv(xh_default)->store_evtchn);
 	if (!file->private_data)
 		return -ENOMEM;
 	return 0;
-- 
2.20.1

