Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79F64C4360F
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 00:46:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 084932075D
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 00:46:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="pqcaWKrN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730801AbfCZAqF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 20:46:05 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:49570 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730402AbfCZAqC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 20:46:02 -0400
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.27/8.16.0.27) with SMTP id x2Q0jDkD016639
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 17:46:00 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=zMtgSHxa3Xff4QlzrEp1ejr0M55IgSwCcXBhAaNt+lw=;
 b=pqcaWKrNb/p5dbwmPJ5vJb3sjFvTPp3iqJNwl/bNbJO7SUjjYmA0ecLr6m2WLpYh633E
 lTxjGoY2W37+uvGnWuuu0SoisBuQw5PPEiwUWOOny5eWPucYPLuaq3bX6u1R6vfbHjfK
 F3d2pA8m0psQHdIIb+3CPPj9/Jzj+v8vXXE= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by m0089730.ppops.net with ESMTP id 2rf3rm9jnn-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 17:46:00 -0700
Received: from mx-out.facebook.com (2620:10d:c081:10::13) by
 mail.thefacebook.com (2620:10d:c081:35::127) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5;
 Mon, 25 Mar 2019 17:45:59 -0700
Received: by dev082.prn2.facebook.com (Postfix, from userid 572249)
        id 0099C3703672; Mon, 25 Mar 2019 17:45:58 -0700 (PDT)
Smtp-Origin-Hostprefix: dev
From:   Andrey Ignatov <rdna@fb.com>
Smtp-Origin-Hostname: dev082.prn2.facebook.com
To:     <netdev@vger.kernel.org>
CC:     Andrey Ignatov <rdna@fb.com>, <ast@kernel.org>,
        <daniel@iogearbox.net>, <guro@fb.com>, <kernel-team@fb.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
Smtp-Origin-Cluster: prn2c23
Subject: [PATCH v2 bpf-next 05/21] bpf: Introduce bpf_sysctl_{get,set}_new_value helpers
Date:   Mon, 25 Mar 2019 17:43:31 -0700
Message-ID: <1b3f7545f3d14e2277a3206eef2c3fea6329245d.1553560620.git.rdna@fb.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1553560620.git.rdna@fb.com>
References: <cover.1553560620.git.rdna@fb.com>
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-26_01:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add helpers to work with new value being written to sysctl by user
space.

bpf_sysctl_get_new_value() copies value being written to sysctl into
provided buffer.

bpf_sysctl_set_new_value() overrides new value being written by user
space with a one from provided buffer. Buffer should contain string
representation of the value, similar to what can be seen in /proc/sys/.

Both helpers can be used only on sysctl write.

File position matters and can be managed by an interface that will be
introduced separately. E.g. if user space calls sys_write to a file in
/proc/sys/ at file position = X, where X > 0, then the value set by
bpf_sysctl_set_new_value() will be written starting from X. If program
wants to override whole value with specified buffer, file position has
to be set to zero.

Documentation for the new helpers is provided in bpf.h UAPI.

Signed-off-by: Andrey Ignatov <rdna@fb.com>
---
 fs/proc/proc_sysctl.c      | 22 ++++++++---
 include/linux/bpf-cgroup.h |  8 ++--
 include/linux/filter.h     |  3 ++
 include/uapi/linux/bpf.h   | 38 +++++++++++++++++-
 kernel/bpf/cgroup.c        | 81 +++++++++++++++++++++++++++++++++++++-
 5 files changed, 142 insertions(+), 10 deletions(-)

diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
index 72f4a096c146..4d1ab22774f7 100644
--- a/fs/proc/proc_sysctl.c
+++ b/fs/proc/proc_sysctl.c
@@ -570,8 +570,8 @@ static ssize_t proc_sys_call_handler(struct file *filp, void __user *buf,
 	struct inode *inode = file_inode(filp);
 	struct ctl_table_header *head = grab_header(inode);
 	struct ctl_table *table = PROC_I(inode)->sysctl_entry;
+	void *new_buf = NULL;
 	ssize_t error;
-	size_t res;
 
 	if (IS_ERR(head))
 		return PTR_ERR(head);
@@ -589,15 +589,27 @@ static ssize_t proc_sys_call_handler(struct file *filp, void __user *buf,
 	if (!table->proc_handler)
 		goto out;
 
-	error = BPF_CGROUP_RUN_PROG_SYSCTL(head, table, write);
+	error = BPF_CGROUP_RUN_PROG_SYSCTL(head, table, write, buf, &count,
+					   &new_buf);
 	if (error)
 		goto out;
 
 	/* careful: calling conventions are nasty here */
-	res = count;
-	error = table->proc_handler(table, write, buf, &res, ppos);
+	if (new_buf) {
+		mm_segment_t old_fs;
+
+		old_fs = get_fs();
+		set_fs(KERNEL_DS);
+		error = table->proc_handler(table, write, (void __user *)new_buf,
+					    &count, ppos);
+		set_fs(old_fs);
+		kfree(new_buf);
+	} else {
+		error = table->proc_handler(table, write, buf, &count, ppos);
+	}
+
 	if (!error)
-		error = res;
+		error = count;
 out:
 	sysctl_head_finish(head);
 
diff --git a/include/linux/bpf-cgroup.h b/include/linux/bpf-cgroup.h
index b1c45da20a26..1e97271f9a10 100644
--- a/include/linux/bpf-cgroup.h
+++ b/include/linux/bpf-cgroup.h
@@ -113,7 +113,8 @@ int __cgroup_bpf_check_dev_permission(short dev_type, u32 major, u32 minor,
 
 int __cgroup_bpf_run_filter_sysctl(struct ctl_table_header *head,
 				   struct ctl_table *table, int write,
-				   enum bpf_attach_type type);
+				   void __user *buf, size_t *pcount,
+				   void **new_buf, enum bpf_attach_type type);
 
 static inline enum bpf_cgroup_storage_type cgroup_storage_type(
 	struct bpf_map *map)
@@ -261,11 +262,12 @@ int bpf_percpu_cgroup_storage_update(struct bpf_map *map, void *key,
 })
 
 
-#define BPF_CGROUP_RUN_PROG_SYSCTL(head, table, write)			       \
+#define BPF_CGROUP_RUN_PROG_SYSCTL(head, table, write, buf, count, nbuf)       \
 ({									       \
 	int __ret = 0;							       \
 	if (cgroup_bpf_enabled)						       \
 		__ret = __cgroup_bpf_run_filter_sysctl(head, table, write,     \
+						       buf, count, nbuf,       \
 						       BPF_CGROUP_SYSCTL);     \
 	__ret;								       \
 })
@@ -338,7 +340,7 @@ static inline int bpf_percpu_cgroup_storage_update(struct bpf_map *map,
 #define BPF_CGROUP_RUN_PROG_UDP6_SENDMSG_LOCK(sk, uaddr, t_ctx) ({ 0; })
 #define BPF_CGROUP_RUN_PROG_SOCK_OPS(sock_ops) ({ 0; })
 #define BPF_CGROUP_RUN_PROG_DEVICE_CGROUP(type,major,minor,access) ({ 0; })
-#define BPF_CGROUP_RUN_PROG_SYSCTL(head, table, write) ({ 0; })
+#define BPF_CGROUP_RUN_PROG_SYSCTL(head,table,write,buf,count,nbuf) ({ 0; })
 
 #define for_each_cgroup_storage_type(stype) for (; false; )
 
diff --git a/include/linux/filter.h b/include/linux/filter.h
index f254ff92819f..a23653f9460c 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -1184,6 +1184,9 @@ struct bpf_sysctl_kern {
 	struct ctl_table *table;
 	void *cur_val;
 	size_t cur_len;
+	void *new_val;
+	size_t new_len;
+	int new_updated;
 	int write;
 };
 
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 481e66cce8dc..fed5b605449a 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -2514,6 +2514,40 @@ union bpf_attr {
  *
  *		**-EINVAL** if current value was unavailable, e.g. because
  *		sysctl is uninitialized and read returns -EIO for it.
+ *
+ * int bpf_sysctl_get_new_value(struct bpf_sysctl *ctx, char *buf, size_t buf_len)
+ *	Description
+ *		Get new value being written by user space to sysctl (before
+ *		the actual write happens) and copy it as a string into
+ *		provided by program buffer *buf* of size *buf_len*.
+ *
+ *		User space may write new value at file position > 0.
+ *
+ *		The buffer is always NUL terminated, unless it's zero-sized.
+ *	Return
+ *		Number of character copied (not including the trailing NUL).
+ *
+ *		**-E2BIG** if the buffer wasn't big enough (*buf* will contain
+ *		truncated name in this case).
+ *
+ *		**-EINVAL** if sysctl is being read.
+ *
+ * int bpf_sysctl_set_new_value(struct bpf_sysctl *ctx, const char *buf, size_t buf_len)
+ *	Description
+ *		Override new value being written by user space to sysctl with
+ *		value provided by program in buffer *buf* of size *buf_len*.
+ *
+ *		*buf* should contain a string in same form as provided by user
+ *		space on sysctl write.
+ *
+ *		User space may write new value at file position > 0. To override
+ *		the whole sysctl value file position should be set to zero.
+ *	Return
+ *		0 on success.
+ *
+ *		**-E2BIG** if the *buf_len* is too big.
+ *
+ *		**-EINVAL** if sysctl is being read.
  */
 #define __BPF_FUNC_MAPPER(FN)		\
 	FN(unspec),			\
@@ -2618,7 +2652,9 @@ union bpf_attr {
 	FN(skc_lookup_tcp),		\
 	FN(tcp_check_syncookie),	\
 	FN(sysctl_get_name),		\
-	FN(sysctl_get_current_value),
+	FN(sysctl_get_current_value),	\
+	FN(sysctl_get_new_value),	\
+	FN(sysctl_set_new_value),
 
 /* integer value in 'imm' field of BPF_CALL instruction selects which helper
  * function eBPF program intends to call
diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
index c6b2cf29a54b..ba4e21986760 100644
--- a/kernel/bpf/cgroup.c
+++ b/kernel/bpf/cgroup.c
@@ -778,6 +778,13 @@ const struct bpf_verifier_ops cg_dev_verifier_ops = {
  * @head: sysctl table header
  * @table: sysctl table
  * @write: sysctl is being read (= 0) or written (= 1)
+ * @buf: pointer to buffer passed by user space
+ * @pcount: value-result argument: value is size of buffer pointed to by @buf,
+ *	result is size of @new_buf if program set new value, initial value
+ *	otherwise
+ * @new_buf: pointer to pointer to new buffer that will be allocated if program
+ *	overrides new value provided by user space on sysctl write
+ *	NOTE: it's caller responsibility to free *new_buf if it was set
  * @type: type of program to be executed
  *
  * Program is run when sysctl is being accessed, either read or written, and
@@ -788,7 +795,8 @@ const struct bpf_verifier_ops cg_dev_verifier_ops = {
  */
 int __cgroup_bpf_run_filter_sysctl(struct ctl_table_header *head,
 				   struct ctl_table *table, int write,
-				   enum bpf_attach_type type)
+				   void __user *buf, size_t *pcount,
+				   void **new_buf, enum bpf_attach_type type)
 {
 	struct bpf_sysctl_kern ctx = {
 		.head = head,
@@ -796,6 +804,9 @@ int __cgroup_bpf_run_filter_sysctl(struct ctl_table_header *head,
 		.write = write,
 		.cur_val = NULL,
 		.cur_len = PAGE_SIZE,
+		.new_val = NULL,
+		.new_len = 0,
+		.new_updated = 0,
 	};
 	struct cgroup *cgrp;
 	int ret;
@@ -818,6 +829,18 @@ int __cgroup_bpf_run_filter_sysctl(struct ctl_table_header *head,
 		ctx.cur_len = 0;
 	}
 
+	if (write && buf && *pcount) {
+		/* BPF program should be able to override new value with a
+		 * buffer bigger than provided by user.
+		 */
+		ctx.new_val = kmalloc_track_caller(PAGE_SIZE, GFP_KERNEL);
+		ctx.new_len = min(PAGE_SIZE, *pcount);
+		if (!ctx.new_val ||
+		    copy_from_user(ctx.new_val, buf, ctx.new_len))
+			/* Let BPF program decide how to proceed. */
+			ctx.new_len = 0;
+	}
+
 	rcu_read_lock();
 	cgrp = task_dfl_cgroup(current);
 	ret = BPF_PROG_RUN_ARRAY(cgrp->bpf.effective[type], &ctx, BPF_PROG_RUN);
@@ -825,6 +848,13 @@ int __cgroup_bpf_run_filter_sysctl(struct ctl_table_header *head,
 
 	kfree(ctx.cur_val);
 
+	if (ret == 1 && ctx.new_updated) {
+		*new_buf = ctx.new_val;
+		*pcount = ctx.new_len;
+	} else {
+		kfree(ctx.new_val);
+	}
+
 	return ret == 1 ? 0 : -EPERM;
 }
 EXPORT_SYMBOL(__cgroup_bpf_run_filter_sysctl);
@@ -932,6 +962,51 @@ static const struct bpf_func_proto bpf_sysctl_get_current_value_proto = {
 	.arg3_type	= ARG_CONST_SIZE,
 };
 
+BPF_CALL_3(bpf_sysctl_get_new_value, struct bpf_sysctl_kern *, ctx, char *, buf,
+	   size_t, buf_len)
+{
+	if (!ctx->write) {
+		if (buf && buf_len)
+			memset(buf, '\0', buf_len);
+		return -EINVAL;
+	}
+	return copy_sysctl_value(buf, buf_len, ctx->new_val, ctx->new_len);
+}
+
+static const struct bpf_func_proto bpf_sysctl_get_new_value_proto = {
+	.func		= bpf_sysctl_get_new_value,
+	.gpl_only	= false,
+	.ret_type	= RET_INTEGER,
+	.arg1_type	= ARG_PTR_TO_CTX,
+	.arg2_type	= ARG_PTR_TO_UNINIT_MEM,
+	.arg3_type	= ARG_CONST_SIZE,
+};
+
+BPF_CALL_3(bpf_sysctl_set_new_value, struct bpf_sysctl_kern *, ctx,
+	   const char *, buf, size_t, buf_len)
+{
+	if (!ctx->write || !ctx->new_val || !ctx->new_len || !buf || !buf_len)
+		return -EINVAL;
+
+	if (buf_len > PAGE_SIZE - 1)
+		return -E2BIG;
+
+	memcpy(ctx->new_val, buf, buf_len);
+	ctx->new_len = buf_len;
+	ctx->new_updated = 1;
+
+	return 0;
+}
+
+static const struct bpf_func_proto bpf_sysctl_set_new_value_proto = {
+	.func		= bpf_sysctl_set_new_value,
+	.gpl_only	= false,
+	.ret_type	= RET_INTEGER,
+	.arg1_type	= ARG_PTR_TO_CTX,
+	.arg2_type	= ARG_PTR_TO_MEM,
+	.arg3_type	= ARG_CONST_SIZE,
+};
+
 static const struct bpf_func_proto *
 sysctl_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 {
@@ -940,6 +1015,10 @@ sysctl_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 		return &bpf_sysctl_get_name_proto;
 	case BPF_FUNC_sysctl_get_current_value:
 		return &bpf_sysctl_get_current_value_proto;
+	case BPF_FUNC_sysctl_get_new_value:
+		return &bpf_sysctl_get_new_value_proto;
+	case BPF_FUNC_sysctl_set_new_value:
+		return &bpf_sysctl_set_new_value_proto;
 	default:
 		return cgroup_base_func_proto(func_id, prog);
 	}
-- 
2.17.1

