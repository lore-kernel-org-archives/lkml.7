Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB9B4C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 00:45:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 712632080F
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 00:45:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="jLum8Qyn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730589AbfCZApm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 20:45:42 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:53414 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727328AbfCZApl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 20:45:41 -0400
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2Q0iPgC010592
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 17:45:40 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=mO5DVqwI0JJLsbB2La9m8oK/98/gdlRYfe+GgHEYOiw=;
 b=jLum8QyncHpbDDHf5exuVibWzIcsjaYNO1UGJPQcUdZ7JcMPS8fgFNMzHjpxyF5wJ9Rz
 CaZTsEd5h0Hf0CFStiPVp/8D5ikCJGkto3mI8Y+t6gc6nhXVbTGIwPYxvKnwROg4Y/Ez
 oJXBQGyr/A/F42NfCE128EJKghMouOTD0Zw= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2rf76ygkmp-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 17:45:40 -0700
Received: from mx-out.facebook.com (2620:10d:c081:10::13) by
 mail.thefacebook.com (2620:10d:c081:35::125) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5;
 Mon, 25 Mar 2019 17:45:40 -0700
Received: by dev082.prn2.facebook.com (Postfix, from userid 572249)
        id D7C473703672; Mon, 25 Mar 2019 17:45:39 -0700 (PDT)
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
Subject: [PATCH v2 bpf-next 04/21] bpf: Introduce bpf_sysctl_get_current_value helper
Date:   Mon, 25 Mar 2019 17:43:30 -0700
Message-ID: <f416fda6c1f87efabe7eb532e44884961fa7a32d.1553560620.git.rdna@fb.com>
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

Add bpf_sysctl_get_current_value() helper to copy current sysctl value
into provided by BPF_PROG_TYPE_CGROUP_SYSCTL program buffer.

It provides same string as user space can see by reading corresponding
file in /proc/sys/, including new line, etc.

Documentation for the new helper is provided in bpf.h UAPI.

Since current value is kept in ctl_table->data in a parsed form,
ctl_table->proc_handler() with write=0 is called to read that data and
convert it to a string. Such a string can later be parsed by a program
using helpers that will be introduced separately.

Unfortunately it's not trivial to provide API to access parsed data due to
variety of data representations (string, intvec, uintvec, ulongvec,
custom structures, even NULL, etc). Instead it's assumed that user know
how to handle specific sysctl they're interested in and appropriate
helpers can be used.

Since ctl_table->proc_handler() expects __user buffer, conversion to
__user happens for kernel allocated one where the value is stored.

Signed-off-by: Andrey Ignatov <rdna@fb.com>
---
 include/linux/filter.h   |  2 ++
 include/uapi/linux/bpf.h | 22 +++++++++++++-
 kernel/bpf/cgroup.c      | 65 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 88 insertions(+), 1 deletion(-)

diff --git a/include/linux/filter.h b/include/linux/filter.h
index a17732057880..f254ff92819f 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -1182,6 +1182,8 @@ struct bpf_sock_ops_kern {
 struct bpf_sysctl_kern {
 	struct ctl_table_header *head;
 	struct ctl_table *table;
+	void *cur_val;
+	size_t cur_len;
 	int write;
 };
 
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index c9e8a1f22c14..481e66cce8dc 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -2495,6 +2495,25 @@ union bpf_attr {
  *
  *		**-E2BIG** if the buffer wasn't big enough (*buf* will contain
  *		truncated name in this case).
+ *
+ * int bpf_sysctl_get_current_value(struct bpf_sysctl *ctx, char *buf, size_t buf_len)
+ *	Description
+ *		Get current value of sysctl as it is presented in /proc/sys
+ *		(incl. newline, etc), and copy it as a string into provided
+ *		by program buffer *buf* of size *buf_len*.
+ *
+ *		The whole value is copied, no matter what file position user
+ *		space issued e.g. sys_read at.
+ *
+ *		The buffer is always NUL terminated, unless it's zero-sized.
+ *	Return
+ *		Number of character copied (not including the trailing NUL).
+ *
+ *		**-E2BIG** if the buffer wasn't big enough (*buf* will contain
+ *		truncated name in this case).
+ *
+ *		**-EINVAL** if current value was unavailable, e.g. because
+ *		sysctl is uninitialized and read returns -EIO for it.
  */
 #define __BPF_FUNC_MAPPER(FN)		\
 	FN(unspec),			\
@@ -2598,7 +2617,8 @@ union bpf_attr {
 	FN(get_listener_sock),		\
 	FN(skc_lookup_tcp),		\
 	FN(tcp_check_syncookie),	\
-	FN(sysctl_get_name),
+	FN(sysctl_get_name),		\
+	FN(sysctl_get_current_value),
 
 /* integer value in 'imm' field of BPF_CALL instruction selects which helper
  * function eBPF program intends to call
diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
index a68387043244..c6b2cf29a54b 100644
--- a/kernel/bpf/cgroup.c
+++ b/kernel/bpf/cgroup.c
@@ -794,15 +794,37 @@ int __cgroup_bpf_run_filter_sysctl(struct ctl_table_header *head,
 		.head = head,
 		.table = table,
 		.write = write,
+		.cur_val = NULL,
+		.cur_len = PAGE_SIZE,
 	};
 	struct cgroup *cgrp;
 	int ret;
 
+	ctx.cur_val = kmalloc_track_caller(ctx.cur_len, GFP_KERNEL);
+	if (ctx.cur_val) {
+		mm_segment_t old_fs;
+		loff_t pos = 0;
+
+		old_fs = get_fs();
+		set_fs(KERNEL_DS);
+		if (table->proc_handler(table, 0, (void __user *)ctx.cur_val,
+					&ctx.cur_len, &pos)) {
+			/* Let BPF program decide how to proceed. */
+			ctx.cur_len = 0;
+		}
+		set_fs(old_fs);
+	} else {
+		/* Let BPF program decide how to proceed. */
+		ctx.cur_len = 0;
+	}
+
 	rcu_read_lock();
 	cgrp = task_dfl_cgroup(current);
 	ret = BPF_PROG_RUN_ARRAY(cgrp->bpf.effective[type], &ctx, BPF_PROG_RUN);
 	rcu_read_unlock();
 
+	kfree(ctx.cur_val);
+
 	return ret == 1 ? 0 : -EPERM;
 }
 EXPORT_SYMBOL(__cgroup_bpf_run_filter_sysctl);
@@ -869,12 +891,55 @@ static const struct bpf_func_proto bpf_sysctl_get_name_proto = {
 	.arg4_type	= ARG_ANYTHING,
 };
 
+static int copy_sysctl_value(char *dst, size_t dst_len, char *src,
+			     size_t src_len)
+{
+	if (!dst)
+		return -EINVAL;
+
+	if (!dst_len)
+		return -E2BIG;
+
+	if (!src || !src_len) {
+		memset(dst, 0, dst_len);
+		return -EINVAL;
+	}
+
+	memcpy(dst, src, min(dst_len, src_len));
+
+	if (dst_len > src_len) {
+		memset(dst + src_len, '\0', dst_len - src_len);
+		return src_len;
+	}
+
+	dst[dst_len - 1] = '\0';
+
+	return -E2BIG;
+}
+
+BPF_CALL_3(bpf_sysctl_get_current_value, struct bpf_sysctl_kern *, ctx,
+	   char *, buf, size_t, buf_len)
+{
+	return copy_sysctl_value(buf, buf_len, ctx->cur_val, ctx->cur_len);
+}
+
+static const struct bpf_func_proto bpf_sysctl_get_current_value_proto = {
+	.func		= bpf_sysctl_get_current_value,
+	.gpl_only	= false,
+	.ret_type	= RET_INTEGER,
+	.arg1_type	= ARG_PTR_TO_CTX,
+	.arg2_type	= ARG_PTR_TO_UNINIT_MEM,
+	.arg3_type	= ARG_CONST_SIZE,
+};
+
 static const struct bpf_func_proto *
 sysctl_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 {
 	switch (func_id) {
 	case BPF_FUNC_sysctl_get_name:
 		return &bpf_sysctl_get_name_proto;
+	case BPF_FUNC_sysctl_get_current_value:
+		return &bpf_sysctl_get_current_value_proto;
 	default:
 		return cgroup_base_func_proto(func_id, prog);
 	}
-- 
2.17.1

