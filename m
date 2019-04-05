Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D46CC282CE
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 19:36:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0A232175B
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 19:36:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="BimkukN+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731925AbfDETgr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 15:36:47 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:53378 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731887AbfDETgn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 15:36:43 -0400
Received: from pps.filterd (m0044008.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x35JaZii001683
        for <linux-kernel@vger.kernel.org>; Fri, 5 Apr 2019 12:36:41 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=HdyuvDJwCH5HBZI/dLkP91IsqupO3P08P9d7urpY23Y=;
 b=BimkukN+o4S26Af11R7NrmiNk9uBDKPJeocrPL5PyCbCdkL9eHvUx6P7LKUOLME23eCb
 h3PbLyR3X1hGX3FHV3H8Ec28kssjPo1ZzGVOJ/YFPuX797pETO00PWYsF9zTEsiYhik8
 N1XHtmeyqkGHxP1PEtYSJ8Zu9qTSNTp6j0k= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2rp890h8pw-7
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2019 12:36:41 -0700
Received: from mx-out.facebook.com (2620:10d:c0a1:3::13) by
 mail.thefacebook.com (2620:10d:c021:18::173) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5;
 Fri, 5 Apr 2019 12:36:26 -0700
Received: by dev082.prn2.facebook.com (Postfix, from userid 572249)
        id 4D18B3701752; Fri,  5 Apr 2019 12:36:25 -0700 (PDT)
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
Subject: [PATCH v3 bpf-next 02/21] bpf: Sysctl hook
Date:   Fri, 5 Apr 2019 12:35:24 -0700
Message-ID: <fa56a873cb76394f49996fb0d191f8c434ac8885.1554485409.git.rdna@fb.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1554485409.git.rdna@fb.com>
References: <cover.1554485409.git.rdna@fb.com>
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-05_15:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Containerized applications may run as root and it may create problems
for whole host. Specifically such applications may change a sysctl and
affect applications in other containers.

Furthermore in existing infrastructure it may not be possible to just
completely disable writing to sysctl, instead such a process should be
gradual with ability to log what sysctl are being changed by a
container, investigate, limit the set of writable sysctl to currently
used ones (so that new ones can not be changed) and eventually reduce
this set to zero.

The patch introduces new program type BPF_PROG_TYPE_CGROUP_SYSCTL and
attach type BPF_CGROUP_SYSCTL to solve these problems on cgroup basis.

New program type has access to following minimal context:
	struct bpf_sysctl {
		__u32	write;
	};

Where @write indicates whether sysctl is being read (= 0) or written (=
1).

Helpers to access sysctl name and value will be introduced separately.

BPF_CGROUP_SYSCTL attach point is added to sysctl code right before
passing control to ctl_table->proc_handler so that BPF program can
either allow or deny access to sysctl.

Suggested-by: Roman Gushchin <guro@fb.com>
Signed-off-by: Andrey Ignatov <rdna@fb.com>
---
 fs/proc/proc_sysctl.c      |  5 +++
 include/linux/bpf-cgroup.h | 18 ++++++++
 include/linux/bpf_types.h  |  1 +
 include/linux/filter.h     |  8 ++++
 include/uapi/linux/bpf.h   |  9 ++++
 kernel/bpf/cgroup.c        | 92 ++++++++++++++++++++++++++++++++++++++
 kernel/bpf/syscall.c       |  7 +++
 kernel/bpf/verifier.c      |  1 +
 8 files changed, 141 insertions(+)

diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
index 4d598a399bbf..72f4a096c146 100644
--- a/fs/proc/proc_sysctl.c
+++ b/fs/proc/proc_sysctl.c
@@ -13,6 +13,7 @@
 #include <linux/namei.h>
 #include <linux/mm.h>
 #include <linux/module.h>
+#include <linux/bpf-cgroup.h>
 #include "internal.h"
 
 static const struct dentry_operations proc_sys_dentry_operations;
@@ -588,6 +589,10 @@ static ssize_t proc_sys_call_handler(struct file *filp, void __user *buf,
 	if (!table->proc_handler)
 		goto out;
 
+	error = BPF_CGROUP_RUN_PROG_SYSCTL(head, table, write);
+	if (error)
+		goto out;
+
 	/* careful: calling conventions are nasty here */
 	res = count;
 	error = table->proc_handler(table, write, buf, &res, ppos);
diff --git a/include/linux/bpf-cgroup.h b/include/linux/bpf-cgroup.h
index a4c644c1c091..b1c45da20a26 100644
--- a/include/linux/bpf-cgroup.h
+++ b/include/linux/bpf-cgroup.h
@@ -17,6 +17,8 @@ struct bpf_map;
 struct bpf_prog;
 struct bpf_sock_ops_kern;
 struct bpf_cgroup_storage;
+struct ctl_table;
+struct ctl_table_header;
 
 #ifdef CONFIG_CGROUP_BPF
 
@@ -109,6 +111,10 @@ int __cgroup_bpf_run_filter_sock_ops(struct sock *sk,
 int __cgroup_bpf_check_dev_permission(short dev_type, u32 major, u32 minor,
 				      short access, enum bpf_attach_type type);
 
+int __cgroup_bpf_run_filter_sysctl(struct ctl_table_header *head,
+				   struct ctl_table *table, int write,
+				   enum bpf_attach_type type);
+
 static inline enum bpf_cgroup_storage_type cgroup_storage_type(
 	struct bpf_map *map)
 {
@@ -253,6 +259,17 @@ int bpf_percpu_cgroup_storage_update(struct bpf_map *map, void *key,
 									      \
 	__ret;								      \
 })
+
+
+#define BPF_CGROUP_RUN_PROG_SYSCTL(head, table, write)			       \
+({									       \
+	int __ret = 0;							       \
+	if (cgroup_bpf_enabled)						       \
+		__ret = __cgroup_bpf_run_filter_sysctl(head, table, write,     \
+						       BPF_CGROUP_SYSCTL);     \
+	__ret;								       \
+})
+
 int cgroup_bpf_prog_attach(const union bpf_attr *attr,
 			   enum bpf_prog_type ptype, struct bpf_prog *prog);
 int cgroup_bpf_prog_detach(const union bpf_attr *attr,
@@ -321,6 +338,7 @@ static inline int bpf_percpu_cgroup_storage_update(struct bpf_map *map,
 #define BPF_CGROUP_RUN_PROG_UDP6_SENDMSG_LOCK(sk, uaddr, t_ctx) ({ 0; })
 #define BPF_CGROUP_RUN_PROG_SOCK_OPS(sock_ops) ({ 0; })
 #define BPF_CGROUP_RUN_PROG_DEVICE_CGROUP(type,major,minor,access) ({ 0; })
+#define BPF_CGROUP_RUN_PROG_SYSCTL(head, table, write) ({ 0; })
 
 #define for_each_cgroup_storage_type(stype) for (; false; )
 
diff --git a/include/linux/bpf_types.h b/include/linux/bpf_types.h
index 08bf2f1fe553..d26991a16894 100644
--- a/include/linux/bpf_types.h
+++ b/include/linux/bpf_types.h
@@ -28,6 +28,7 @@ BPF_PROG_TYPE(BPF_PROG_TYPE_RAW_TRACEPOINT, raw_tracepoint)
 #endif
 #ifdef CONFIG_CGROUP_BPF
 BPF_PROG_TYPE(BPF_PROG_TYPE_CGROUP_DEVICE, cg_dev)
+BPF_PROG_TYPE(BPF_PROG_TYPE_CGROUP_SYSCTL, cg_sysctl)
 #endif
 #ifdef CONFIG_BPF_LIRC_MODE2
 BPF_PROG_TYPE(BPF_PROG_TYPE_LIRC_MODE2, lirc_mode2)
diff --git a/include/linux/filter.h b/include/linux/filter.h
index 6074aa064b54..a17732057880 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -33,6 +33,8 @@ struct bpf_prog_aux;
 struct xdp_rxq_info;
 struct xdp_buff;
 struct sock_reuseport;
+struct ctl_table;
+struct ctl_table_header;
 
 /* ArgX, context and stack frame pointer register positions. Note,
  * Arg1, Arg2, Arg3, etc are used as argument mappings of function
@@ -1177,4 +1179,10 @@ struct bpf_sock_ops_kern {
 					 */
 };
 
+struct bpf_sysctl_kern {
+	struct ctl_table_header *head;
+	struct ctl_table *table;
+	int write;
+};
+
 #endif /* __LINUX_FILTER_H__ */
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 837024512baf..4cfda9c16327 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -166,6 +166,7 @@ enum bpf_prog_type {
 	BPF_PROG_TYPE_LIRC_MODE2,
 	BPF_PROG_TYPE_SK_REUSEPORT,
 	BPF_PROG_TYPE_FLOW_DISSECTOR,
+	BPF_PROG_TYPE_CGROUP_SYSCTL,
 };
 
 enum bpf_attach_type {
@@ -187,6 +188,7 @@ enum bpf_attach_type {
 	BPF_CGROUP_UDP6_SENDMSG,
 	BPF_LIRC_MODE2,
 	BPF_FLOW_DISSECTOR,
+	BPF_CGROUP_SYSCTL,
 	__MAX_BPF_ATTACH_TYPE
 };
 
@@ -3275,4 +3277,11 @@ struct bpf_line_info {
 struct bpf_spin_lock {
 	__u32	val;
 };
+
+struct bpf_sysctl {
+	__u32	write;		/* Sysctl is being read (= 0) or written (= 1).
+				 * Allows 1,2,4-byte read, but no write.
+				 */
+};
+
 #endif /* _UAPI__LINUX_BPF_H__ */
diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
index f6cd38746df2..610491b5f0aa 100644
--- a/kernel/bpf/cgroup.c
+++ b/kernel/bpf/cgroup.c
@@ -11,7 +11,9 @@
 #include <linux/kernel.h>
 #include <linux/atomic.h>
 #include <linux/cgroup.h>
+#include <linux/filter.h>
 #include <linux/slab.h>
+#include <linux/sysctl.h>
 #include <linux/bpf.h>
 #include <linux/bpf-cgroup.h>
 #include <net/sock.h>
@@ -768,3 +770,93 @@ const struct bpf_verifier_ops cg_dev_verifier_ops = {
 	.get_func_proto		= cgroup_dev_func_proto,
 	.is_valid_access	= cgroup_dev_is_valid_access,
 };
+
+/**
+ * __cgroup_bpf_run_filter_sysctl - Run a program on sysctl
+ *
+ * @head: sysctl table header
+ * @table: sysctl table
+ * @write: sysctl is being read (= 0) or written (= 1)
+ * @type: type of program to be executed
+ *
+ * Program is run when sysctl is being accessed, either read or written, and
+ * can allow or deny such access.
+ *
+ * This function will return %-EPERM if an attached program is found and
+ * returned value != 1 during execution. In all other cases 0 is returned.
+ */
+int __cgroup_bpf_run_filter_sysctl(struct ctl_table_header *head,
+				   struct ctl_table *table, int write,
+				   enum bpf_attach_type type)
+{
+	struct bpf_sysctl_kern ctx = {
+		.head = head,
+		.table = table,
+		.write = write,
+	};
+	struct cgroup *cgrp;
+	int ret;
+
+	rcu_read_lock();
+	cgrp = task_dfl_cgroup(current);
+	ret = BPF_PROG_RUN_ARRAY(cgrp->bpf.effective[type], &ctx, BPF_PROG_RUN);
+	rcu_read_unlock();
+
+	return ret == 1 ? 0 : -EPERM;
+}
+EXPORT_SYMBOL(__cgroup_bpf_run_filter_sysctl);
+
+static const struct bpf_func_proto *
+sysctl_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
+{
+	return cgroup_base_func_proto(func_id, prog);
+}
+
+static bool sysctl_is_valid_access(int off, int size, enum bpf_access_type type,
+				   const struct bpf_prog *prog,
+				   struct bpf_insn_access_aux *info)
+{
+	const int size_default = sizeof(__u32);
+
+	if (off < 0 || off + size > sizeof(struct bpf_sysctl) ||
+	    off % size || type != BPF_READ)
+		return false;
+
+	switch (off) {
+	case offsetof(struct bpf_sysctl, write):
+		bpf_ctx_record_field_size(info, size_default);
+		return bpf_ctx_narrow_access_ok(off, size, size_default);
+	default:
+		return false;
+	}
+}
+
+static u32 sysctl_convert_ctx_access(enum bpf_access_type type,
+				     const struct bpf_insn *si,
+				     struct bpf_insn *insn_buf,
+				     struct bpf_prog *prog, u32 *target_size)
+{
+	struct bpf_insn *insn = insn_buf;
+
+	switch (si->off) {
+	case offsetof(struct bpf_sysctl, write):
+		*insn++ = BPF_LDX_MEM(
+			BPF_SIZE(si->code), si->dst_reg, si->src_reg,
+			bpf_target_off(struct bpf_sysctl_kern, write,
+				       FIELD_SIZEOF(struct bpf_sysctl_kern,
+						    write),
+				       target_size));
+		break;
+	}
+
+	return insn - insn_buf;
+}
+
+const struct bpf_verifier_ops cg_sysctl_verifier_ops = {
+	.get_func_proto		= sysctl_func_proto,
+	.is_valid_access	= sysctl_is_valid_access,
+	.convert_ctx_access	= sysctl_convert_ctx_access,
+};
+
+const struct bpf_prog_ops cg_sysctl_prog_ops = {
+};
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 1d65e56594db..0b8cefcc1f38 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -1828,6 +1828,9 @@ static int bpf_prog_attach(const union bpf_attr *attr)
 	case BPF_FLOW_DISSECTOR:
 		ptype = BPF_PROG_TYPE_FLOW_DISSECTOR;
 		break;
+	case BPF_CGROUP_SYSCTL:
+		ptype = BPF_PROG_TYPE_CGROUP_SYSCTL;
+		break;
 	default:
 		return -EINVAL;
 	}
@@ -1906,6 +1909,9 @@ static int bpf_prog_detach(const union bpf_attr *attr)
 		return lirc_prog_detach(attr);
 	case BPF_FLOW_DISSECTOR:
 		return skb_flow_dissector_bpf_prog_detach(attr);
+	case BPF_CGROUP_SYSCTL:
+		ptype = BPF_PROG_TYPE_CGROUP_SYSCTL;
+		break;
 	default:
 		return -EINVAL;
 	}
@@ -1939,6 +1945,7 @@ static int bpf_prog_query(const union bpf_attr *attr,
 	case BPF_CGROUP_UDP6_SENDMSG:
 	case BPF_CGROUP_SOCK_OPS:
 	case BPF_CGROUP_DEVICE:
+	case BPF_CGROUP_SYSCTL:
 		break;
 	case BPF_LIRC_MODE2:
 		return lirc_prog_query(attr, uattr);
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 48718e1da16d..56baf21b57c2 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -5219,6 +5219,7 @@ static int check_return_code(struct bpf_verifier_env *env)
 	case BPF_PROG_TYPE_CGROUP_SOCK_ADDR:
 	case BPF_PROG_TYPE_SOCK_OPS:
 	case BPF_PROG_TYPE_CGROUP_DEVICE:
+	case BPF_PROG_TYPE_CGROUP_SYSCTL:
 		break;
 	default:
 		return 0;
-- 
2.17.1

