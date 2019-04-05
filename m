Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5418CC282DA
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 19:37:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00AA42175B
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 19:37:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="mxlHEkU9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732069AbfDEThD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 15:37:03 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:59886 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732030AbfDEThB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 15:37:01 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x35JaEAE014421
        for <linux-kernel@vger.kernel.org>; Fri, 5 Apr 2019 12:36:59 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=qJo5YKzGVSBuaVtoXMS7LuoANnu+paOm7UcT3Ea3c48=;
 b=mxlHEkU95MBXJ2feoL1b1MXUYvlr0x7OtKYTr/DcZnot9K6+B00vCMP2uCVN7bE8Z5zM
 CPDsC8aW8R3Yggx7Wi8+wfuEKkDFwQqMr+JgBrhx5GywrjQrMlyWNCIigOMOsq7Phza7
 IHA+RMAgmZ+heyEQHM35zZu91eqyL+eJU6o= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2rp6mfsjp4-15
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2019 12:36:59 -0700
Received: from mx-out.facebook.com (2620:10d:c0a1:3::13) by
 mail.thefacebook.com (2620:10d:c021:18::174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5;
 Fri, 5 Apr 2019 12:36:55 -0700
Received: by dev082.prn2.facebook.com (Postfix, from userid 572249)
        id 47FD53701752; Fri,  5 Apr 2019 12:36:53 -0700 (PDT)
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
Subject: [PATCH v3 bpf-next 16/21] bpf: Introduce bpf_strtol and bpf_strtoul helpers
Date:   Fri, 5 Apr 2019 12:35:38 -0700
Message-ID: <262aa717e722829d12b338caface14179d3eda17.1554485410.git.rdna@fb.com>
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

Add bpf_strtol and bpf_strtoul to convert a string to long and unsigned
long correspondingly. It's similar to user space strtol(3) and
strtoul(3) with a few changes to the API:

* instead of NUL-terminated C string the helpers expect buffer and
  buffer length;

* resulting long or unsigned long is returned in a separate
  result-argument;

* return value is used to indicate success or failure, on success number
  of consumed bytes is returned that can be used to identify position to
  read next if the buffer is expected to contain multiple integers;

* instead of *base* argument, *flags* is used that provides base in 5
  LSB, other bits are reserved for future use;

* number of supported bases is limited.

Documentation for the new helpers is provided in bpf.h UAPI.

The helpers are made available to BPF_PROG_TYPE_CGROUP_SYSCTL programs to
be able to convert string input to e.g. "ulongvec" output.

E.g. "net/ipv4/tcp_mem" consists of three ulong integers. They can be
parsed by calling to bpf_strtoul three times.

Implementation notes:

Implementation includes "../../lib/kstrtox.h" to reuse integer parsing
functions. It's done exactly same way as fs/proc/base.c already does.

Unfortunately existing kstrtoX function can't be used directly since
they fail if any invalid character is present right after integer in the
string. Existing simple_strtoX functions can't be used either since
they're obsolete and don't handle overflow properly.

Signed-off-by: Andrey Ignatov <rdna@fb.com>
---
 include/linux/bpf.h      |   2 +
 include/uapi/linux/bpf.h |  51 ++++++++++++++-
 kernel/bpf/cgroup.c      |   4 ++
 kernel/bpf/helpers.c     | 131 +++++++++++++++++++++++++++++++++++++++
 4 files changed, 187 insertions(+), 1 deletion(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 986f89d9de63..d38cc6215df7 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -933,6 +933,8 @@ extern const struct bpf_func_proto bpf_sk_redirect_map_proto;
 extern const struct bpf_func_proto bpf_spin_lock_proto;
 extern const struct bpf_func_proto bpf_spin_unlock_proto;
 extern const struct bpf_func_proto bpf_get_local_storage_proto;
+extern const struct bpf_func_proto bpf_strtol_proto;
+extern const struct bpf_func_proto bpf_strtoul_proto;
 
 /* Shared helpers among cBPF and eBPF. */
 void bpf_user_rnd_init_once(void);
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 01faa286bb3c..6611f5ce276c 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -2548,6 +2548,53 @@ union bpf_attr {
  *		**-E2BIG** if the *buf_len* is too big.
  *
  *		**-EINVAL** if sysctl is being read.
+ *
+ * int bpf_strtol(const char *buf, size_t buf_len, u64 flags, long *res)
+ *	Description
+ *		Convert the initial part of the string from buffer *buf* of
+ *		size *buf_len* to a long integer according to the given base
+ *		and save the result in *res*.
+ *
+ *		The string may begin with an arbitrary amount of white space
+ *		(as determined by isspace(3)) followed by a single optional '-'
+ *		sign.
+ *
+ *		Five least significant bits of *flags* encode base, other bits
+ *		are currently unused.
+ *
+ *		Base must be either 8, 10, 16 or 0 to detect it automatically
+ *		similar to user space strtol(3).
+ *	Return
+ *		Number of characters consumed on success. Must be positive but
+ *		no more than buf_len.
+ *
+ *		**-EINVAL** if no valid digits were found or unsupported base
+ *		was provided.
+ *
+ *		**-ERANGE** if resulting value was out of range.
+ *
+ * int bpf_strtoul(const char *buf, size_t buf_len, u64 flags, unsigned long *res)
+ *	Description
+ *		Convert the initial part of the string from buffer *buf* of
+ *		size *buf_len* to an unsigned long integer according to the
+ *		given base and save the result in *res*.
+ *
+ *		The string may begin with an arbitrary amount of white space
+ *		(as determined by isspace(3)).
+ *
+ *		Five least significant bits of *flags* encode base, other bits
+ *		are currently unused.
+ *
+ *		Base must be either 8, 10, 16 or 0 to detect it automatically
+ *		similar to user space strtoul(3).
+ *	Return
+ *		Number of characters consumed on success. Must be positive but
+ *		no more than buf_len.
+ *
+ *		**-EINVAL** if no valid digits were found or unsupported base
+ *		was provided.
+ *
+ *		**-ERANGE** if resulting value was out of range.
  */
 #define __BPF_FUNC_MAPPER(FN)		\
 	FN(unspec),			\
@@ -2654,7 +2701,9 @@ union bpf_attr {
 	FN(sysctl_get_name),		\
 	FN(sysctl_get_current_value),	\
 	FN(sysctl_get_new_value),	\
-	FN(sysctl_set_new_value),
+	FN(sysctl_set_new_value),	\
+	FN(strtol),			\
+	FN(strtoul),
 
 /* integer value in 'imm' field of BPF_CALL instruction selects which helper
  * function eBPF program intends to call
diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
index b2adf22139b3..789d4ab2336e 100644
--- a/kernel/bpf/cgroup.c
+++ b/kernel/bpf/cgroup.c
@@ -1016,6 +1016,10 @@ static const struct bpf_func_proto *
 sysctl_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 {
 	switch (func_id) {
+	case BPF_FUNC_strtol:
+		return &bpf_strtol_proto;
+	case BPF_FUNC_strtoul:
+		return &bpf_strtoul_proto;
 	case BPF_FUNC_sysctl_get_name:
 		return &bpf_sysctl_get_name_proto;
 	case BPF_FUNC_sysctl_get_current_value:
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index a411fc17d265..4266ffde07ca 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -18,6 +18,9 @@
 #include <linux/sched.h>
 #include <linux/uidgid.h>
 #include <linux/filter.h>
+#include <linux/ctype.h>
+
+#include "../../lib/kstrtox.h"
 
 /* If kernel subsystem is allowing eBPF programs to call this function,
  * inside its own verifier_ops->get_func_proto() callback it should return
@@ -363,4 +366,132 @@ const struct bpf_func_proto bpf_get_local_storage_proto = {
 	.arg2_type	= ARG_ANYTHING,
 };
 #endif
+
+#define BPF_STRTOX_BASE_MASK 0x1F
+
+static int __bpf_strtoull(const char *buf, size_t buf_len, u64 flags,
+			  unsigned long long *res, bool *is_negative)
+{
+	unsigned int base = flags & BPF_STRTOX_BASE_MASK;
+	const char *cur_buf = buf;
+	size_t cur_len = buf_len;
+	unsigned int consumed;
+	size_t val_len;
+	char str[64];
+
+	if (!buf || !buf_len || !res || !is_negative)
+		return -EINVAL;
+
+	if (base != 0 && base != 8 && base != 10 && base != 16)
+		return -EINVAL;
+
+	if (flags & ~BPF_STRTOX_BASE_MASK)
+		return -EINVAL;
+
+	while (cur_buf < buf + buf_len && isspace(*cur_buf))
+		++cur_buf;
+
+	*is_negative = (cur_buf < buf + buf_len && *cur_buf == '-');
+	if (*is_negative)
+		++cur_buf;
+
+	consumed = cur_buf - buf;
+	cur_len -= consumed;
+	if (!cur_len)
+		return -EINVAL;
+
+	cur_len = min(cur_len, sizeof(str) - 1);
+	memcpy(str, cur_buf, cur_len);
+	str[cur_len] = '\0';
+	cur_buf = str;
+
+	cur_buf = _parse_integer_fixup_radix(cur_buf, &base);
+	val_len = _parse_integer(cur_buf, base, res);
+
+	if (val_len & KSTRTOX_OVERFLOW)
+		return -ERANGE;
+
+	if (val_len == 0)
+		return -EINVAL;
+
+	cur_buf += val_len;
+	consumed += cur_buf - str;
+
+	return consumed;
+}
+
+static int __bpf_strtoll(const char *buf, size_t buf_len, u64 flags,
+			 long long *res)
+{
+	unsigned long long _res;
+	bool is_negative;
+	int err;
+
+	err = __bpf_strtoull(buf, buf_len, flags, &_res, &is_negative);
+	if (err < 0)
+		return err;
+	if (is_negative) {
+		if ((long long)-_res > 0)
+			return -ERANGE;
+		*res = -_res;
+	} else {
+		if ((long long)_res < 0)
+			return -ERANGE;
+		*res = _res;
+	}
+	return err;
+}
+
+BPF_CALL_4(bpf_strtol, const char *, buf, size_t, buf_len, u64, flags,
+	   long *, res)
+{
+	long long _res;
+	int err;
+
+	err = __bpf_strtoll(buf, buf_len, flags, &_res);
+	if (err < 0)
+		return err;
+	if (_res != (long)_res)
+		return -ERANGE;
+	*res = _res;
+	return err;
+}
+
+const struct bpf_func_proto bpf_strtol_proto = {
+	.func		= bpf_strtol,
+	.gpl_only	= false,
+	.ret_type	= RET_INTEGER,
+	.arg1_type	= ARG_PTR_TO_MEM,
+	.arg2_type	= ARG_CONST_SIZE,
+	.arg3_type	= ARG_ANYTHING,
+	.arg4_type	= ARG_PTR_TO_LONG,
+};
+
+BPF_CALL_4(bpf_strtoul, const char *, buf, size_t, buf_len, u64, flags,
+	   unsigned long *, res)
+{
+	unsigned long long _res;
+	bool is_negative;
+	int err;
+
+	err = __bpf_strtoull(buf, buf_len, flags, &_res, &is_negative);
+	if (err < 0)
+		return err;
+	if (is_negative)
+		return -EINVAL;
+	if (_res != (unsigned long)_res)
+		return -ERANGE;
+	*res = _res;
+	return err;
+}
+
+const struct bpf_func_proto bpf_strtoul_proto = {
+	.func		= bpf_strtoul,
+	.gpl_only	= false,
+	.ret_type	= RET_INTEGER,
+	.arg1_type	= ARG_PTR_TO_MEM,
+	.arg2_type	= ARG_CONST_SIZE,
+	.arg3_type	= ARG_ANYTHING,
+	.arg4_type	= ARG_PTR_TO_LONG,
+};
 #endif
-- 
2.17.1

