Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC2B4C43215
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 15:22:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C932F206D8
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 15:22:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727047AbfKUPWm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 10:22:42 -0500
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:35953 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726822AbfKUPWl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 10:22:41 -0500
X-Originating-IP: 153.3.140.100
Received: from localhost.localdomain.localdomain (unknown [153.3.140.100])
        (Authenticated sender: fly@kernel.page)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id 0D51E1C000C;
        Thu, 21 Nov 2019 15:22:32 +0000 (UTC)
From:   Pengfei Li <fly@kernel.page>
To:     akpm@linux-foundation.org
Cc:     mgorman@techsingularity.net, mhocko@kernel.org, vbabka@suse.cz,
        cl@linux.com, iamjoonsoo.kim@lge.com, guro@fb.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Pengfei Li <fly@kernel.page>
Subject: [RFC v1 18/19] kernel, sysctl: cleanup numa_zonelist_order
Date:   Thu, 21 Nov 2019 23:18:10 +0800
Message-Id: <20191121151811.49742-19-fly@kernel.page>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191121151811.49742-1-fly@kernel.page>
References: <20191121151811.49742-1-fly@kernel.page>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a cleanup patch.

Rename numa_zonelist_order to numa_nodelist_order, and clean up
some zonelist_xxx accordingly.

Signed-off-by: Pengfei Li <fly@kernel.page>
---
 include/linux/mmzone.h |  6 +++---
 kernel/sysctl.c        |  8 ++++----
 mm/page_alloc.c        | 16 ++++++++--------
 3 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index f1a492c13037..0423a84dfd7d 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -959,10 +959,10 @@ int sysctl_min_unmapped_ratio_sysctl_handler(struct ctl_table *, int,
 int sysctl_min_slab_ratio_sysctl_handler(struct ctl_table *, int,
 			void __user *, size_t *, loff_t *);
 
-extern int numa_zonelist_order_handler(struct ctl_table *, int,
+extern int numa_nodelist_order_handler(struct ctl_table *, int,
 			void __user *, size_t *, loff_t *);
-extern char numa_zonelist_order[];
-#define NUMA_ZONELIST_ORDER_LEN	16
+extern char numa_nodelist_order[];
+#define NUMA_NODELIST_ORDER_LEN	16
 
 #ifndef CONFIG_NEED_MULTIPLE_NODES
 
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 50373984a5e2..040c0c561399 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -1648,11 +1648,11 @@ static struct ctl_table vm_table[] = {
 #endif
 #ifdef CONFIG_NUMA
 	{
-		.procname	= "numa_zonelist_order",
-		.data		= &numa_zonelist_order,
-		.maxlen		= NUMA_ZONELIST_ORDER_LEN,
+		.procname	= "numa_nodelist_order",
+		.data		= &numa_nodelist_order,
+		.maxlen		= NUMA_NODELIST_ORDER_LEN,
 		.mode		= 0644,
-		.proc_handler	= numa_zonelist_order_handler,
+		.proc_handler	= numa_nodelist_order_handler,
 	},
 #endif
 #if (defined(CONFIG_X86_32) && !defined(CONFIG_UML))|| \
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 146abe537300..bc24e614c296 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -5479,7 +5479,7 @@ static inline void set_last_nlist_entry(struct nlist_entry *entry)
 
 #ifdef CONFIG_NUMA
 
-static int __parse_numa_zonelist_order(char *s)
+static int __parse_numa_nodelist_order(char *s)
 {
 	/*
 	 * We used to support different zonlists modes but they turned
@@ -5488,27 +5488,27 @@ static int __parse_numa_zonelist_order(char *s)
 	 * not fail it silently
 	 */
 	if (!(*s == 'd' || *s == 'D' || *s == 'n' || *s == 'N')) {
-		pr_warn("Ignoring unsupported numa_zonelist_order value:  %s\n", s);
+		pr_warn("Ignoring unsupported numa_nodelist_order value:  %s\n", s);
 		return -EINVAL;
 	}
 	return 0;
 }
 
-static __init int setup_numa_zonelist_order(char *s)
+static __init int setup_numa_nodelist_order(char *s)
 {
 	if (!s)
 		return 0;
 
-	return __parse_numa_zonelist_order(s);
+	return __parse_numa_nodelist_order(s);
 }
-early_param("numa_zonelist_order", setup_numa_zonelist_order);
+early_param("numa_nodelist_order", setup_numa_nodelist_order);
 
-char numa_zonelist_order[] = "Node";
+char numa_nodelist_order[] = "Node";
 
 /*
  * sysctl handler for numa_zonelist_order
  */
-int numa_zonelist_order_handler(struct ctl_table *table, int write,
+int numa_nodelist_order_handler(struct ctl_table *table, int write,
 		void __user *buffer, size_t *length,
 		loff_t *ppos)
 {
@@ -5521,7 +5521,7 @@ int numa_zonelist_order_handler(struct ctl_table *table, int write,
 	if (IS_ERR(str))
 		return PTR_ERR(str);
 
-	ret = __parse_numa_zonelist_order(str);
+	ret = __parse_numa_nodelist_order(str);
 	kfree(str);
 	return ret;
 }
-- 
2.23.0

