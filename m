Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D402C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 00:46:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DB852075D
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 00:46:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="mZFqqLvO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730605AbfCZAqt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 20:46:49 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:60584 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726616AbfCZAqs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 20:46:48 -0400
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2Q0kMII002992
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 17:46:47 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=pl12/NdtlfR2RoVDCaaGk0KA4kUGev5LOjeLWus4P3w=;
 b=mZFqqLvOBhvvd3F2tk138fXqWG3nZojtPTr2W7G/qVUP4YqbHRY0RR5GU9QKApfuDloW
 hkomYKE7OcnA6CR+tccCqLRs/cTKKFL8qL0dO5Zz1I9YyxbQTdDAfJt4b9UkIJNDDifP
 u00NhoWVaK4ikg6kX7XnQ/5APoXSWO3S4Xg= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2rf9u68014-13
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 17:46:47 -0700
Received: from mx-out.facebook.com (2620:10d:c0a1:3::13) by
 mail.thefacebook.com (2620:10d:c021:18::174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5;
 Mon, 25 Mar 2019 17:46:12 -0700
Received: by dev082.prn2.facebook.com (Postfix, from userid 572249)
        id 330903703672; Mon, 25 Mar 2019 17:46:11 -0700 (PDT)
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
Subject: [PATCH v2 bpf-next 06/21] bpf: Add file_pos field to bpf_sysctl ctx
Date:   Mon, 25 Mar 2019 17:43:32 -0700
Message-ID: <e878479c95541bce3dd3a317b286f1d6e833c7fd.1553560620.git.rdna@fb.com>
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

Add file_pos field to bpf_sysctl context to read and write sysctl file
position at which sysctl is being accessed (read or written).

The field can be used to e.g. override whole sysctl value on write to
sysctl even when sys_write is called by user space with file_pos > 0. Or
BPF program may reject such accesses.

Signed-off-by: Andrey Ignatov <rdna@fb.com>
---
 fs/proc/proc_sysctl.c      |  2 +-
 include/linux/bpf-cgroup.h |  9 ++++---
 include/linux/filter.h     |  3 +++
 include/uapi/linux/bpf.h   |  3 +++
 kernel/bpf/cgroup.c        | 54 +++++++++++++++++++++++++++++++++++---
 5 files changed, 63 insertions(+), 8 deletions(-)

diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
index 4d1ab22774f7..8371bbca1105 100644
--- a/fs/proc/proc_sysctl.c
+++ b/fs/proc/proc_sysctl.c
@@ -590,7 +590,7 @@ static ssize_t proc_sys_call_handler(struct file *filp, void __user *buf,
 		goto out;
 
 	error = BPF_CGROUP_RUN_PROG_SYSCTL(head, table, write, buf, &count,
-					   &new_buf);
+					   ppos, &new_buf);
 	if (error)
 		goto out;
 
diff --git a/include/linux/bpf-cgroup.h b/include/linux/bpf-cgroup.h
index 1e97271f9a10..cb3c6b3b89c8 100644
--- a/include/linux/bpf-cgroup.h
+++ b/include/linux/bpf-cgroup.h
@@ -114,7 +114,8 @@ int __cgroup_bpf_check_dev_permission(short dev_type, u32 major, u32 minor,
 int __cgroup_bpf_run_filter_sysctl(struct ctl_table_header *head,
 				   struct ctl_table *table, int write,
 				   void __user *buf, size_t *pcount,
-				   void **new_buf, enum bpf_attach_type type);
+				   loff_t *ppos, void **new_buf,
+				   enum bpf_attach_type type);
 
 static inline enum bpf_cgroup_storage_type cgroup_storage_type(
 	struct bpf_map *map)
@@ -262,12 +263,12 @@ int bpf_percpu_cgroup_storage_update(struct bpf_map *map, void *key,
 })
 
 
-#define BPF_CGROUP_RUN_PROG_SYSCTL(head, table, write, buf, count, nbuf)       \
+#define BPF_CGROUP_RUN_PROG_SYSCTL(head, table, write, buf, count, pos, nbuf)  \
 ({									       \
 	int __ret = 0;							       \
 	if (cgroup_bpf_enabled)						       \
 		__ret = __cgroup_bpf_run_filter_sysctl(head, table, write,     \
-						       buf, count, nbuf,       \
+						       buf, count, pos, nbuf,  \
 						       BPF_CGROUP_SYSCTL);     \
 	__ret;								       \
 })
@@ -340,7 +341,7 @@ static inline int bpf_percpu_cgroup_storage_update(struct bpf_map *map,
 #define BPF_CGROUP_RUN_PROG_UDP6_SENDMSG_LOCK(sk, uaddr, t_ctx) ({ 0; })
 #define BPF_CGROUP_RUN_PROG_SOCK_OPS(sock_ops) ({ 0; })
 #define BPF_CGROUP_RUN_PROG_DEVICE_CGROUP(type,major,minor,access) ({ 0; })
-#define BPF_CGROUP_RUN_PROG_SYSCTL(head,table,write,buf,count,nbuf) ({ 0; })
+#define BPF_CGROUP_RUN_PROG_SYSCTL(head,table,write,buf,count,pos,nbuf) ({ 0; })
 
 #define for_each_cgroup_storage_type(stype) for (; false; )
 
diff --git a/include/linux/filter.h b/include/linux/filter.h
index a23653f9460c..fb0edad75971 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -1188,6 +1188,9 @@ struct bpf_sysctl_kern {
 	size_t new_len;
 	int new_updated;
 	int write;
+	loff_t *ppos;
+	/* Temporary "register" for indirect stores to ppos. */
+	u64 tmp_reg;
 };
 
 #endif /* __LINUX_FILTER_H__ */
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index fed5b605449a..01faa286bb3c 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -3358,6 +3358,9 @@ struct bpf_sysctl {
 	__u32	write;		/* Sysctl is being read (= 0) or written (= 1).
 				 * Allows 1,2,4-byte read, but no write.
 				 */
+	__u32	file_pos;	/* Sysctl file position to read from, write to.
+				 * Allows 1,2,4-byte read an 4-byte write.
+				 */
 };
 
 #endif /* _UAPI__LINUX_BPF_H__ */
diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
index ba4e21986760..b2adf22139b3 100644
--- a/kernel/bpf/cgroup.c
+++ b/kernel/bpf/cgroup.c
@@ -782,6 +782,9 @@ const struct bpf_verifier_ops cg_dev_verifier_ops = {
  * @pcount: value-result argument: value is size of buffer pointed to by @buf,
  *	result is size of @new_buf if program set new value, initial value
  *	otherwise
+ * @ppos: value-result argument: value is position at which read from or write
+ *	to sysctl is happening, result is new position if program overrode it,
+ *	initial value otherwise
  * @new_buf: pointer to pointer to new buffer that will be allocated if program
  *	overrides new value provided by user space on sysctl write
  *	NOTE: it's caller responsibility to free *new_buf if it was set
@@ -796,12 +799,14 @@ const struct bpf_verifier_ops cg_dev_verifier_ops = {
 int __cgroup_bpf_run_filter_sysctl(struct ctl_table_header *head,
 				   struct ctl_table *table, int write,
 				   void __user *buf, size_t *pcount,
-				   void **new_buf, enum bpf_attach_type type)
+				   loff_t *ppos, void **new_buf,
+				   enum bpf_attach_type type)
 {
 	struct bpf_sysctl_kern ctx = {
 		.head = head,
 		.table = table,
 		.write = write,
+		.ppos = ppos,
 		.cur_val = NULL,
 		.cur_len = PAGE_SIZE,
 		.new_val = NULL,
@@ -1030,14 +1035,22 @@ static bool sysctl_is_valid_access(int off, int size, enum bpf_access_type type,
 {
 	const int size_default = sizeof(__u32);
 
-	if (off < 0 || off + size > sizeof(struct bpf_sysctl) ||
-	    off % size || type != BPF_READ)
+	if (off < 0 || off + size > sizeof(struct bpf_sysctl) || off % size)
 		return false;
 
 	switch (off) {
 	case offsetof(struct bpf_sysctl, write):
+		if (type != BPF_READ)
+			return false;
 		bpf_ctx_record_field_size(info, size_default);
 		return bpf_ctx_narrow_access_ok(off, size, size_default);
+	case offsetof(struct bpf_sysctl, file_pos):
+		if (type == BPF_READ) {
+			bpf_ctx_record_field_size(info, size_default);
+			return bpf_ctx_narrow_access_ok(off, size, size_default);
+		} else {
+			return size == size_default;
+		}
 	default:
 		return false;
 	}
@@ -1059,6 +1072,41 @@ static u32 sysctl_convert_ctx_access(enum bpf_access_type type,
 						    write),
 				       target_size));
 		break;
+	case offsetof(struct bpf_sysctl, file_pos):
+		/* ppos is a pointer so it should be accessed via indirect
+		 * loads and stores. Also for stores additional temporary
+		 * register is used since neither src_reg nor dst_reg can be
+		 * overridden.
+		 */
+		if (type == BPF_WRITE) {
+			int treg = BPF_REG_9;
+
+			if (si->src_reg == treg || si->dst_reg == treg)
+				--treg;
+			if (si->src_reg == treg || si->dst_reg == treg)
+				--treg;
+			*insn++ = BPF_STX_MEM(
+				BPF_DW, si->dst_reg, treg,
+				offsetof(struct bpf_sysctl_kern, tmp_reg));
+			*insn++ = BPF_LDX_MEM(
+				BPF_FIELD_SIZEOF(struct bpf_sysctl_kern, ppos),
+				treg, si->dst_reg,
+				offsetof(struct bpf_sysctl_kern, ppos));
+			*insn++ = BPF_STX_MEM(
+				BPF_SIZEOF(u32), treg, si->src_reg, 0);
+			*insn++ = BPF_LDX_MEM(
+				BPF_DW, treg, si->dst_reg,
+				offsetof(struct bpf_sysctl_kern, tmp_reg));
+		} else {
+			*insn++ = BPF_LDX_MEM(
+				BPF_FIELD_SIZEOF(struct bpf_sysctl_kern, ppos),
+				si->dst_reg, si->src_reg,
+				offsetof(struct bpf_sysctl_kern, ppos));
+			*insn++ = BPF_LDX_MEM(
+				BPF_SIZE(si->code), si->dst_reg, si->dst_reg, 0);
+		}
+		*target_size = sizeof(u32);
+		break;
 	}
 
 	return insn - insn_buf;
-- 
2.17.1

