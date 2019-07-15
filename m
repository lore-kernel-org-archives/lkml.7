Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F18CC7618A
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 05:13:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC25F214C6
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 05:13:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563167636;
	bh=ocyiAOK0maQsf4fwTu8SJPmes1IFrUNDDImmcOcRzgA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zg1GrY3VCKogIeguVasaduznC9IOORBklFoMthKNnMrzFYW2szKXTPO6Xi1hkVsLI
	 IylKxYUivmQf/74kRrjLGgVV4yuG4X7khtGEpiiXFUwASFYyKA/l9xMLnYhcZuVzki
	 q1T0uA3tL65PrXkOIB9w69a7zfg/SRZJ89DxKSn8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729341AbfGOFNy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 01:13:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:48000 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725954AbfGOFNy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 01:13:54 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1B49320C01;
        Mon, 15 Jul 2019 05:13:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563167633;
        bh=ocyiAOK0maQsf4fwTu8SJPmes1IFrUNDDImmcOcRzgA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0x4zRBJlyB4qhsMWQFX5X9YGqw/D4bFrU2lVuxZ18vOI870Ns8x+Cy7SA6r9IL8hj
         E9sW4Jk3T4+JpuYRB/ZAXjk1CYHDFC7HOc6lZOjtu1sMS9OMS/gSEDQpiCTI/2Nm5G
         ZRSURX++24TWnkTD1COM1xgO4jaCq2vngbJu/jbI=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Tim Bird <Tim.Bird@sony.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [RFC PATCH v2 15/15] tracing: of: Add function-graph tracer option properties
Date:   Mon, 15 Jul 2019 14:13:48 +0900
Message-Id: <156316762864.23477.2115123246398911458.stgit@devnote2>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <156316746861.23477.5815110570539190650.stgit@devnote2>
References: <156316746861.23477.5815110570539190650.stgit@devnote2>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add following function-graph tracer related options
 - fgraph-filters : string array of filter
 - fgraph-notraces : string array of notrace-filter
 - fgraph-max-depth : u32 value of max depth

Note that these properties are available on ftrace root node
only, because these filters are globally applied.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 kernel/trace/ftrace.c   |   85 ++++++++++++++++++++++++++++++-----------------
 kernel/trace/trace_of.c |   68 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 123 insertions(+), 30 deletions(-)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 5c3eadb143ed..7bc60ac4583e 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -1241,7 +1241,7 @@ static void clear_ftrace_mod_list(struct list_head *head)
 	mutex_unlock(&ftrace_lock);
 }
 
-static void free_ftrace_hash(struct ftrace_hash *hash)
+void free_ftrace_hash(struct ftrace_hash *hash)
 {
 	if (!hash || hash == EMPTY_HASH)
 		return;
@@ -4895,7 +4895,7 @@ __setup("ftrace_filter=", set_ftrace_filter);
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
 static char ftrace_graph_buf[FTRACE_FILTER_SIZE] __initdata;
 static char ftrace_graph_notrace_buf[FTRACE_FILTER_SIZE] __initdata;
-static int ftrace_graph_set_hash(struct ftrace_hash *hash, char *buffer);
+int ftrace_graph_set_hash(struct ftrace_hash *hash, char *buffer);
 
 static int __init set_graph_function(char *str)
 {
@@ -5224,6 +5224,26 @@ __ftrace_graph_open(struct inode *inode, struct file *file,
 	return ret;
 }
 
+struct ftrace_hash *ftrace_graph_copy_hash(bool enable)
+{
+	struct ftrace_hash *hash;
+
+	mutex_lock(&graph_lock);
+
+	if (enable)
+		hash = rcu_dereference_protected(ftrace_graph_hash,
+					lockdep_is_held(&graph_lock));
+	else
+		hash = rcu_dereference_protected(ftrace_graph_notrace_hash,
+					lockdep_is_held(&graph_lock));
+
+	hash = alloc_and_copy_ftrace_hash(FTRACE_HASH_DEFAULT_BITS, hash);
+
+	mutex_unlock(&graph_lock);
+
+	return hash;
+}
+
 static int
 ftrace_graph_open(struct inode *inode, struct file *file)
 {
@@ -5280,11 +5300,40 @@ ftrace_graph_notrace_open(struct inode *inode, struct file *file)
 	return ret;
 }
 
+int ftrace_graph_apply_hash(struct ftrace_hash *hash, bool enable)
+{
+	struct ftrace_hash *old_hash, *new_hash;
+
+	new_hash = __ftrace_hash_move(hash);
+	if (!new_hash)
+		return -ENOMEM;
+
+	mutex_lock(&graph_lock);
+
+	if (enable) {
+		old_hash = rcu_dereference_protected(ftrace_graph_hash,
+				lockdep_is_held(&graph_lock));
+		rcu_assign_pointer(ftrace_graph_hash, new_hash);
+	} else {
+		old_hash = rcu_dereference_protected(ftrace_graph_notrace_hash,
+				lockdep_is_held(&graph_lock));
+		rcu_assign_pointer(ftrace_graph_notrace_hash, new_hash);
+	}
+
+	mutex_unlock(&graph_lock);
+
+	/* Wait till all users are no longer using the old hash */
+	synchronize_rcu();
+
+	free_ftrace_hash(old_hash);
+
+	return 0;
+}
+
 static int
 ftrace_graph_release(struct inode *inode, struct file *file)
 {
 	struct ftrace_graph_data *fgd;
-	struct ftrace_hash *old_hash, *new_hash;
 	struct trace_parser *parser;
 	int ret = 0;
 
@@ -5309,41 +5358,17 @@ ftrace_graph_release(struct inode *inode, struct file *file)
 
 		trace_parser_put(parser);
 
-		new_hash = __ftrace_hash_move(fgd->new_hash);
-		if (!new_hash) {
-			ret = -ENOMEM;
-			goto out;
-		}
-
-		mutex_lock(&graph_lock);
-
-		if (fgd->type == GRAPH_FILTER_FUNCTION) {
-			old_hash = rcu_dereference_protected(ftrace_graph_hash,
-					lockdep_is_held(&graph_lock));
-			rcu_assign_pointer(ftrace_graph_hash, new_hash);
-		} else {
-			old_hash = rcu_dereference_protected(ftrace_graph_notrace_hash,
-					lockdep_is_held(&graph_lock));
-			rcu_assign_pointer(ftrace_graph_notrace_hash, new_hash);
-		}
-
-		mutex_unlock(&graph_lock);
-
-		/* Wait till all users are no longer using the old hash */
-		synchronize_rcu();
-
-		free_ftrace_hash(old_hash);
+		ret = ftrace_graph_apply_hash(fgd->new_hash,
+					fgd->type == GRAPH_FILTER_FUNCTION);
 	}
 
- out:
 	free_ftrace_hash(fgd->new_hash);
 	kfree(fgd);
 
 	return ret;
 }
 
-static int
-ftrace_graph_set_hash(struct ftrace_hash *hash, char *buffer)
+int ftrace_graph_set_hash(struct ftrace_hash *hash, char *buffer)
 {
 	struct ftrace_glob func_g;
 	struct dyn_ftrace *rec;
diff --git a/kernel/trace/trace_of.c b/kernel/trace/trace_of.c
index 1ee6fab918f5..d78a082b1752 100644
--- a/kernel/trace/trace_of.c
+++ b/kernel/trace/trace_of.c
@@ -75,6 +75,71 @@ trace_of_set_instance_options(struct trace_array *tr, struct device_node *node)
 	}
 }
 
+#ifdef CONFIG_FUNCTION_GRAPH_TRACER
+extern unsigned int fgraph_max_depth;
+extern struct ftrace_hash *ftrace_graph_copy_hash(bool enable);
+extern int ftrace_graph_set_hash(struct ftrace_hash *hash, char *buffer);
+extern int ftrace_graph_apply_hash(struct ftrace_hash *hash, bool enable);
+extern void free_ftrace_hash(struct ftrace_hash *hash);
+
+static void __init
+trace_of_set_fgraph_filter(struct device_node *node, const char *property,
+			   bool enable)
+{
+	struct ftrace_hash *hash;
+	struct property *prop;
+	const char *p;
+	char buf[MAX_BUF_LEN];
+	int err;
+
+	if (!of_find_property(node, property, NULL))
+		return;
+
+	/* Get current filter hash */
+	hash = ftrace_graph_copy_hash(enable);
+	if (!hash) {
+		pr_err("Failed to copy hash\n");
+		return;
+	}
+
+	of_property_for_each_string(node, property, prop, p) {
+		if (strlcpy(buf, p, ARRAY_SIZE(buf)) >= ARRAY_SIZE(buf)) {
+			pr_err("filter string is too long: %s\n", p);
+			goto free_hash;
+		}
+		err = ftrace_graph_set_hash(hash, buf);
+		if (err) {
+			pr_err("Failed to add %s: %s\n", property, buf);
+			goto free_hash;
+		}
+	}
+
+	if (ftrace_graph_apply_hash(hash, enable) < 0) {
+		pr_err("Failed to apply new hash\n");
+		goto free_hash;
+	}
+
+	return;
+
+free_hash:
+	free_ftrace_hash(hash);
+}
+
+static void __init
+trace_of_set_fgraph_options(struct device_node *node)
+{
+	u32 v = 0;
+
+	trace_of_set_fgraph_filter(node, "fgraph-filters", true);
+	trace_of_set_fgraph_filter(node, "fgraph-notraces", false);
+
+	if (!of_property_read_u32_index(node, "fgraph-max-depth", 0, &v))
+		fgraph_max_depth = (unsigned int)v;
+}
+#else
+#define trace_of_set_fgraph_options(node) do {} while (0)
+#endif
+
 static void __init
 trace_of_set_ftrace_options(struct trace_array *tr, struct device_node *node)
 {
@@ -100,6 +165,9 @@ trace_of_set_ftrace_options(struct trace_array *tr, struct device_node *node)
 		if (tracing_alloc_snapshot() < 0)
 			pr_err("Failed to allocate snapshot buffer\n");
 
+	/* function graph filters are global settings. */
+	trace_of_set_fgraph_options(node);
+
 	trace_of_set_instance_options(tr, node);
 }
 

