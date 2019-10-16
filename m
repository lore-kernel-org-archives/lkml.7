Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8162AFA372B
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 22:14:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F4FB21D7A
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 22:14:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407391AbfJPWOS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 18:14:18 -0400
Received: from mga05.intel.com ([192.55.52.43]:35629 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2407371AbfJPWOL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 18:14:11 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Oct 2019 15:14:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,305,1566889200"; 
   d="scan'208";a="195725844"
Received: from viggo.jf.intel.com (HELO localhost.localdomain) ([10.54.77.144])
  by fmsmga007.fm.intel.com with ESMTP; 16 Oct 2019 15:14:10 -0700
Subject: [PATCH 1/4] node: Define and export memory migration path
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, dan.j.williams@intel.com,
        Dave Hansen <dave.hansen@linux.intel.com>,
        keith.busch@intel.com
From:   Dave Hansen <dave.hansen@linux.intel.com>
Date:   Wed, 16 Oct 2019 15:11:49 -0700
References: <20191016221148.F9CCD155@viggo.jf.intel.com>
In-Reply-To: <20191016221148.F9CCD155@viggo.jf.intel.com>
Message-Id: <20191016221149.74AE222C@viggo.jf.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


From: Keith Busch <keith.busch@intel.com>

Prepare for the kernel to auto-migrate pages to other memory nodes
with a user defined node migration table. This allows creating single
migration target for each NUMA node to enable the kernel to do NUMA
page migrations instead of simply reclaiming colder pages. A node
with no target is a "terminal node", so reclaim acts normally there.
The migration target does not fundamentally _need_ to be a single node,
but this implementation starts there to limit complexity.

If you consider the migration path as a graph, cycles (loops) in the
graph are disallowed.  This avoids wasting resources by constantly
migrating (A->B, B->A, A->B ...).  The expectation is that cycles will
never be allowed, and this rule is enforced if the user tries to make
such a cycle.

Signed-off-by: Keith Busch <keith.busch@intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
---

 b/drivers/base/node.c  |   73 +++++++++++++++++++++++++++++++++++++++++++++++++
 b/include/linux/node.h |    6 ++++
 2 files changed, 79 insertions(+)

diff -puN drivers/base/node.c~0003-node-Define-and-export-memory-migration-path drivers/base/node.c
--- a/drivers/base/node.c~0003-node-Define-and-export-memory-migration-path	2019-10-16 15:06:55.895952599 -0700
+++ b/drivers/base/node.c	2019-10-16 15:06:55.902952599 -0700
@@ -101,6 +101,10 @@ static const struct attribute_group *nod
 	NULL,
 };
 
+#define TERMINAL_NODE -1
+static int node_migration[MAX_NUMNODES] = {[0 ...  MAX_NUMNODES - 1] = TERMINAL_NODE};
+static DEFINE_SPINLOCK(node_migration_lock);
+
 static void node_remove_accesses(struct node *node)
 {
 	struct node_access_nodes *c, *cnext;
@@ -530,6 +534,74 @@ static ssize_t node_read_distance(struct
 }
 static DEVICE_ATTR(distance, S_IRUGO, node_read_distance, NULL);
 
+static ssize_t migration_path_show(struct device *dev,
+				   struct device_attribute *attr,
+				   char *buf)
+{
+	return sprintf(buf, "%d\n", node_migration[dev->id]);
+}
+
+static ssize_t migration_path_store(struct device *dev,
+				    struct device_attribute *attr,
+				    const char *buf, size_t count)
+{
+	int i, err, nid = dev->id;
+	nodemask_t visited = NODE_MASK_NONE;
+	long next;
+
+	err = kstrtol(buf, 0, &next);
+	if (err)
+		return -EINVAL;
+
+	if (next < 0) {
+		spin_lock(&node_migration_lock);
+		WRITE_ONCE(node_migration[nid], TERMINAL_NODE);
+		spin_unlock(&node_migration_lock);
+		return count;
+	}
+	if (next >= MAX_NUMNODES || !node_online(next))
+		return -EINVAL;
+
+	/*
+	 * Follow the entire migration path from 'nid' through the point where
+	 * we hit a TERMINAL_NODE.
+	 *
+	 * Don't allow loops migration cycles in the path.
+	 */
+	node_set(nid, visited);
+	spin_lock(&node_migration_lock);
+	for (i = next; node_migration[i] != TERMINAL_NODE;
+	     i = node_migration[i]) {
+		/* Fail if we have visited this node already */
+		if (node_test_and_set(i, visited)) {
+			spin_unlock(&node_migration_lock);
+			return -EINVAL;
+		}
+	}
+	WRITE_ONCE(node_migration[nid], next);
+	spin_unlock(&node_migration_lock);
+
+	return count;
+}
+static DEVICE_ATTR_RW(migration_path);
+
+/**
+ * next_migration_node() - Get the next node in the migration path
+ * @current_node: The starting node to lookup the next node
+ *
+ * @returns: node id for next memory node in the migration path hierarchy from
+ * 	     @current_node; -1 if @current_node is terminal or its migration
+ * 	     node is not online.
+ */
+int next_migration_node(int current_node)
+{
+	int nid = READ_ONCE(node_migration[current_node]);
+
+	if (nid >= 0 && node_online(nid))
+		return nid;
+	return TERMINAL_NODE;
+}
+
 static struct attribute *node_dev_attrs[] = {
 	&dev_attr_cpumap.attr,
 	&dev_attr_cpulist.attr,
@@ -537,6 +609,7 @@ static struct attribute *node_dev_attrs[
 	&dev_attr_numastat.attr,
 	&dev_attr_distance.attr,
 	&dev_attr_vmstat.attr,
+	&dev_attr_migration_path.attr,
 	NULL
 };
 ATTRIBUTE_GROUPS(node_dev);
diff -puN include/linux/node.h~0003-node-Define-and-export-memory-migration-path include/linux/node.h
--- a/include/linux/node.h~0003-node-Define-and-export-memory-migration-path	2019-10-16 15:06:55.898952599 -0700
+++ b/include/linux/node.h	2019-10-16 15:06:55.902952599 -0700
@@ -134,6 +134,7 @@ static inline int register_one_node(int
 	return error;
 }
 
+extern int next_migration_node(int current_node);
 extern void unregister_one_node(int nid);
 extern int register_cpu_under_node(unsigned int cpu, unsigned int nid);
 extern int unregister_cpu_under_node(unsigned int cpu, unsigned int nid);
@@ -186,6 +187,11 @@ static inline void register_hugetlbfs_wi
 						node_registration_func_t unreg)
 {
 }
+
+static inline int next_migration_node(int current_node)
+{
+	return -1;
+}
 #endif
 
 #define to_node(device) container_of(device, struct node, dev)
_
