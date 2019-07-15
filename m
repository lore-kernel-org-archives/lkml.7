Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16064C7618B
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 05:13:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCA20214C6
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 05:13:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563167614;
	bh=BBnueE/U29m6p1IALEJOU3fzZPOV+KZGT85BBOX9OVE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=SS9O9Ns8iXrFsPHc7mzjVMzdG5GCp0tqBnQQfyUHZKlEf24wGFTdz43lnPJCDRpfV
	 GzuyT1SYy9QnArpLBC/iZjPqq0OaEd38OAnn6eFEBGcUozPKENmQK9sQHooy/BbzoQ
	 R9g+vuur+GmGXfl80moGF7ck/d5kLbmD2e40Zp6o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729321AbfGOFNd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 01:13:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:47750 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729302AbfGOFNd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 01:13:33 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 853B320C01;
        Mon, 15 Jul 2019 05:13:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563167612;
        bh=BBnueE/U29m6p1IALEJOU3fzZPOV+KZGT85BBOX9OVE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1Jl9oy6FRjltpx0aaSuUMJXEMQecEwLjcL/GiAxI8lInp4+DuY0VTePdm3HipGsh+
         0eKr7ZZq79gNRHzuVDkRGj4W9ixfvbAy4zM5GbksUO0W89GWH4Ga1qyYSCkWx6/lqt
         nL6yW9y0D2lLXEr2dBvaKEB0qxdO9KuBaeUI7Zlc=
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
Subject: [RFC PATCH v2 13/15] tracing: of: Add cpumask property support
Date:   Mon, 15 Jul 2019 14:13:27 +0900
Message-Id: <156316760712.23477.13986980388044489506.stgit@devnote2>
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

Add cpumask property for tracing. Note that this property accepts
a string cpumask, not a digit number.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 kernel/trace/trace.c    |   41 ++++++++++++++++++++++++++++-------------
 kernel/trace/trace_of.c |   14 ++++++++++++++
 2 files changed, 42 insertions(+), 13 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 6f50c58a3ad4..251d9de14b12 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -4437,20 +4437,12 @@ tracing_cpumask_read(struct file *filp, char __user *ubuf,
 	return count;
 }
 
-static ssize_t
-tracing_cpumask_write(struct file *filp, const char __user *ubuf,
-		      size_t count, loff_t *ppos)
+int tracing_set_cpumask(struct trace_array *tr, cpumask_var_t tracing_cpumask_new)
 {
-	struct trace_array *tr = file_inode(filp)->i_private;
-	cpumask_var_t tracing_cpumask_new;
-	int err, cpu;
-
-	if (!alloc_cpumask_var(&tracing_cpumask_new, GFP_KERNEL))
-		return -ENOMEM;
+	int cpu;
 
-	err = cpumask_parse_user(ubuf, count, tracing_cpumask_new);
-	if (err)
-		goto err_unlock;
+	if (!tr)
+		return -EINVAL;
 
 	local_irq_disable();
 	arch_spin_lock(&tr->max_lock);
@@ -4474,11 +4466,34 @@ tracing_cpumask_write(struct file *filp, const char __user *ubuf,
 	local_irq_enable();
 
 	cpumask_copy(tr->tracing_cpumask, tracing_cpumask_new);
+
+	return 0;
+}
+
+static ssize_t
+tracing_cpumask_write(struct file *filp, const char __user *ubuf,
+		      size_t count, loff_t *ppos)
+{
+	struct trace_array *tr = file_inode(filp)->i_private;
+	cpumask_var_t tracing_cpumask_new;
+	int err;
+
+	if (!alloc_cpumask_var(&tracing_cpumask_new, GFP_KERNEL))
+		return -ENOMEM;
+
+	err = cpumask_parse_user(ubuf, count, tracing_cpumask_new);
+	if (err)
+		goto err_free;
+
+	err = tracing_set_cpumask(tr, tracing_cpumask_new);
+	if (err)
+		goto err_free;
+
 	free_cpumask_var(tracing_cpumask_new);
 
 	return count;
 
-err_unlock:
+err_free:
 	free_cpumask_var(tracing_cpumask_new);
 
 	return err;
diff --git a/kernel/trace/trace_of.c b/kernel/trace/trace_of.c
index 7fe81c25dc59..14d6c9a8fd81 100644
--- a/kernel/trace/trace_of.c
+++ b/kernel/trace/trace_of.c
@@ -22,6 +22,8 @@ extern void __init trace_init_tracepoint_printk(void);
 extern ssize_t tracing_resize_ring_buffer(struct trace_array *tr,
 					  unsigned long size, int cpu_id);
 extern struct trace_array *trace_array_create(const char *name);
+extern int tracing_set_cpumask(struct trace_array *tr,
+			       cpumask_var_t tracing_cpumask_new);
 
 static void __init
 trace_of_set_instance_options(struct trace_array *tr, struct device_node *node)
@@ -59,6 +61,18 @@ trace_of_set_instance_options(struct trace_array *tr, struct device_node *node)
 			pr_err("Failed to resize trace buffer to %d KB\n",
 				v >> 10);
 	}
+
+	err = of_property_read_string(node, "cpumask", &p);
+	if (!err) {
+		cpumask_var_t new_mask;
+
+		if (alloc_cpumask_var(&new_mask, GFP_KERNEL)) {
+			if (cpumask_parse(p, new_mask) < 0 ||
+			    tracing_set_cpumask(tr, new_mask) < 0)
+				pr_err("Failed to set new CPU mask %s\n", p);
+			free_cpumask_var(new_mask);
+		}
+	}
 }
 
 static void __init

