Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44C24C282CE
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 19:39:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 131FD20863
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 19:39:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="Wl85TsaI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732231AbfDETjM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 15:39:12 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:34090 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731896AbfDETgq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 15:36:46 -0400
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.27/8.16.0.27) with SMTP id x35Jahfj015755
        for <linux-kernel@vger.kernel.org>; Fri, 5 Apr 2019 12:36:45 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=Rs9aC4INCN0Ckm8XaMAHgUlhKH7k4XDjyx5oxEZ4TL4=;
 b=Wl85TsaIxs/L1fcvBhGLqvGopf35JXf7m2Mc842bEeEXcgxrcQGpHbpT8ebkR6oJLhj/
 e7ZmFCkxCEppqR82tTD/LLrp3eKZHB7dQESstrknZNy4htmiBUlDKybXtWyYgZAUDb9k
 ZZj2HWNi7g/MGqqvgfcdNZqg+ezAQb24iAM= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by m0089730.ppops.net with ESMTP id 2rpchfr612-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2019 12:36:45 -0700
Received: from mx-out.facebook.com (2620:10d:c0a1:3::13) by
 mail.thefacebook.com (2620:10d:c021:18::175) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5;
 Fri, 5 Apr 2019 12:36:30 -0700
Received: by dev082.prn2.facebook.com (Postfix, from userid 572249)
        id 90ED93701752; Fri,  5 Apr 2019 12:36:27 -0700 (PDT)
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
Subject: [PATCH v3 bpf-next 03/21] bpf: Introduce bpf_sysctl_get_name helper
Date:   Fri, 5 Apr 2019 12:35:25 -0700
Message-ID: <2d86e38658fbb0d0e9384692a72b2a5acf239ae0.1554485409.git.rdna@fb.com>
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

Add bpf_sysctl_get_name() helper to copy sysctl name (/proc/sys/ entry)
into provided by BPF_PROG_TYPE_CGROUP_SYSCTL program buffer.

By default full name (w/o /proc/sys/) is copied, e.g. "net/ipv4/tcp_mem".

If BPF_F_SYSCTL_BASE_NAME flag is set, only base name will be copied,
e.g. "tcp_mem".

Documentation for the new helper is provided in bpf.h UAPI.

Signed-off-by: Andrey Ignatov <rdna@fb.com>
---
 include/uapi/linux/bpf.h | 22 ++++++++++++-
 kernel/bpf/cgroup.c      | 70 +++++++++++++++++++++++++++++++++++++++-
 2 files changed, 90 insertions(+), 2 deletions(-)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 4cfda9c16327..c9e8a1f22c14 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -2479,6 +2479,22 @@ union bpf_attr {
  * 	Return
  * 		0 if iph and th are a valid SYN cookie ACK, or a negative error
  * 		otherwise.
+ *
+ * int bpf_sysctl_get_name(struct bpf_sysctl *ctx, char *buf, size_t buf_len, u64 flags)
+ *	Description
+ *		Get name of sysctl in /proc/sys/ and copy it into provided by
+ *		program buffer *buf* of size *buf_len*.
+ *
+ *		The buffer is always NUL terminated, unless it's zero-sized.
+ *
+ *		If *flags* is zero, full name (e.g. "net/ipv4/tcp_mem") is
+ *		copied. Use **BPF_F_SYSCTL_BASE_NAME** flag to copy base name
+ *		only (e.g. "tcp_mem").
+ *	Return
+ *		Number of character copied (not including the trailing NUL).
+ *
+ *		**-E2BIG** if the buffer wasn't big enough (*buf* will contain
+ *		truncated name in this case).
  */
 #define __BPF_FUNC_MAPPER(FN)		\
 	FN(unspec),			\
@@ -2581,7 +2597,8 @@ union bpf_attr {
 	FN(skb_ecn_set_ce),		\
 	FN(get_listener_sock),		\
 	FN(skc_lookup_tcp),		\
-	FN(tcp_check_syncookie),
+	FN(tcp_check_syncookie),	\
+	FN(sysctl_get_name),
 
 /* integer value in 'imm' field of BPF_CALL instruction selects which helper
  * function eBPF program intends to call
@@ -2648,6 +2665,9 @@ enum bpf_func_id {
 #define BPF_F_ADJ_ROOM_ENCAP_L4_GRE	(1ULL << 3)
 #define BPF_F_ADJ_ROOM_ENCAP_L4_UDP	(1ULL << 4)
 
+/* BPF_FUNC_sysctl_get_name flags. */
+#define BPF_F_SYSCTL_BASE_NAME		(1ULL << 0)
+
 /* Mode for BPF_FUNC_skb_adjust_room helper. */
 enum bpf_adj_room_mode {
 	BPF_ADJ_ROOM_NET,
diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
index 610491b5f0aa..a68387043244 100644
--- a/kernel/bpf/cgroup.c
+++ b/kernel/bpf/cgroup.c
@@ -14,6 +14,7 @@
 #include <linux/filter.h>
 #include <linux/slab.h>
 #include <linux/sysctl.h>
+#include <linux/string.h>
 #include <linux/bpf.h>
 #include <linux/bpf-cgroup.h>
 #include <net/sock.h>
@@ -806,10 +807,77 @@ int __cgroup_bpf_run_filter_sysctl(struct ctl_table_header *head,
 }
 EXPORT_SYMBOL(__cgroup_bpf_run_filter_sysctl);
 
+static ssize_t sysctl_cpy_dir(const struct ctl_dir *dir, char **bufp,
+			      size_t *lenp)
+{
+	ssize_t tmp_ret = 0, ret;
+
+	if (dir->header.parent) {
+		tmp_ret = sysctl_cpy_dir(dir->header.parent, bufp, lenp);
+		if (tmp_ret < 0)
+			return tmp_ret;
+	}
+
+	ret = strscpy(*bufp, dir->header.ctl_table[0].procname, *lenp);
+	if (ret < 0)
+		return ret;
+	*bufp += ret;
+	*lenp -= ret;
+	ret += tmp_ret;
+
+	/* Avoid leading slash. */
+	if (!ret)
+		return ret;
+
+	tmp_ret = strscpy(*bufp, "/", *lenp);
+	if (tmp_ret < 0)
+		return tmp_ret;
+	*bufp += tmp_ret;
+	*lenp -= tmp_ret;
+
+	return ret + tmp_ret;
+}
+
+BPF_CALL_4(bpf_sysctl_get_name, struct bpf_sysctl_kern *, ctx, char *, buf,
+	   size_t, buf_len, u64, flags)
+{
+	ssize_t tmp_ret = 0, ret;
+
+	if (!buf)
+		return -EINVAL;
+
+	if (!(flags & BPF_F_SYSCTL_BASE_NAME)) {
+		if (!ctx->head)
+			return -EINVAL;
+		tmp_ret = sysctl_cpy_dir(ctx->head->parent, &buf, &buf_len);
+		if (tmp_ret < 0)
+			return tmp_ret;
+	}
+
+	ret = strscpy(buf, ctx->table->procname, buf_len);
+
+	return ret < 0 ? ret : tmp_ret + ret;
+}
+
+static const struct bpf_func_proto bpf_sysctl_get_name_proto = {
+	.func		= bpf_sysctl_get_name,
+	.gpl_only	= false,
+	.ret_type	= RET_INTEGER,
+	.arg1_type	= ARG_PTR_TO_CTX,
+	.arg2_type	= ARG_PTR_TO_MEM,
+	.arg3_type	= ARG_CONST_SIZE,
+	.arg4_type	= ARG_ANYTHING,
+};
+
 static const struct bpf_func_proto *
 sysctl_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 {
-	return cgroup_base_func_proto(func_id, prog);
+	switch (func_id) {
+	case BPF_FUNC_sysctl_get_name:
+		return &bpf_sysctl_get_name_proto;
+	default:
+		return cgroup_base_func_proto(func_id, prog);
+	}
 }
 
 static bool sysctl_is_valid_access(int off, int size, enum bpf_access_type type,
-- 
2.17.1

