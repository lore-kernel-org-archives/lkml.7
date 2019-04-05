Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBABAC282CE
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 19:37:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80BD72175B
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 19:37:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="VTzl8nLl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732138AbfDEThT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 15:37:19 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:43356 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732079AbfDEThG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 15:37:06 -0400
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x35JYoYs030009
        for <linux-kernel@vger.kernel.org>; Fri, 5 Apr 2019 12:37:05 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=VZIUeklEc9+7ZpKI4F/1YhhzVBgHbgk0H0/shcH1LJ0=;
 b=VTzl8nLluucjm9tbj/SKLci+p13ipx7R8Bh4y5qJkoRlGyJrQJgEPXSGMq2al6vIi6+6
 3LYmROJJ9iRCe0Y4GMB/qMV+CvMNpuCpsK0TFGglma1uin4vaNsws6M6v/qGXJoW/2xi
 t0b4TXDNjV7jTbR8IB/WXsgSjIjJLvR7bv0= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2rp9r5gvm3-7
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2019 12:37:04 -0700
Received: from mx-out.facebook.com (2620:10d:c081:10::13) by
 mail.thefacebook.com (2620:10d:c081:35::125) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5;
 Fri, 5 Apr 2019 12:37:02 -0700
Received: by dev082.prn2.facebook.com (Postfix, from userid 572249)
        id CED7A3701752; Fri,  5 Apr 2019 12:37:00 -0700 (PDT)
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
Subject: [PATCH v3 bpf-next 21/21] selftests/bpf: C based test for sysctl and strtoX
Date:   Fri, 5 Apr 2019 12:35:43 -0700
Message-ID: <beee9ba7460596a420b5b3444fddd76726e3d6f5.1554485410.git.rdna@fb.com>
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

Add C based test for a few bpf_sysctl_* helpers and bpf_strtoul.

Make sure that sysctl can be identified by name and that multiple
integers can be parsed from sysctl value with bpf_strtoul.

net/ipv4/tcp_mem is chosen as a testing sysctl, it contains 3 unsigned
longs, they all are parsed and compared (val[0] < val[1] < val[2]).

Example of output:
  # ./test_sysctl
  ...
  Test case: C prog: deny all writes .. [PASS]
  Test case: C prog: deny access by name .. [PASS]
  Test case: C prog: read tcp_mem .. [PASS]
  Summary: 39 PASSED, 0 FAILED

Signed-off-by: Andrey Ignatov <rdna@fb.com>
---
 .../selftests/bpf/progs/test_sysctl_prog.c    | 70 +++++++++++++++++++
 tools/testing/selftests/bpf/test_sysctl.c     | 57 ++++++++++++++-
 2 files changed, 126 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/bpf/progs/test_sysctl_prog.c

diff --git a/tools/testing/selftests/bpf/progs/test_sysctl_prog.c b/tools/testing/selftests/bpf/progs/test_sysctl_prog.c
new file mode 100644
index 000000000000..a295cad805d7
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_sysctl_prog.c
@@ -0,0 +1,70 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (c) 2019 Facebook
+
+#include <stdint.h>
+#include <string.h>
+
+#include <linux/stddef.h>
+#include <linux/bpf.h>
+
+#include "bpf_helpers.h"
+#include "bpf_util.h"
+
+/* Max supported length of a string with unsigned long in base 10 (pow2 - 1). */
+#define MAX_ULONG_STR_LEN 0xF
+
+/* Max supported length of sysctl value string (pow2). */
+#define MAX_VALUE_STR_LEN 0x40
+
+static __always_inline int is_tcp_mem(struct bpf_sysctl *ctx)
+{
+	char tcp_mem_name[] = "net/ipv4/tcp_mem";
+	unsigned char i;
+	char name[64];
+	int ret;
+
+	memset(name, 0, sizeof(name));
+	ret = bpf_sysctl_get_name(ctx, name, sizeof(name), 0);
+	if (ret < 0 || ret != sizeof(tcp_mem_name) - 1)
+		return 0;
+
+#pragma clang loop unroll(full)
+	for (i = 0; i < sizeof(tcp_mem_name); ++i)
+		if (name[i] != tcp_mem_name[i])
+			return 0;
+
+	return 1;
+}
+
+SEC("cgroup/sysctl")
+int sysctl_tcp_mem(struct bpf_sysctl *ctx)
+{
+	unsigned long tcp_mem[3] = {0, 0, 0};
+	char value[MAX_VALUE_STR_LEN];
+	unsigned char i, off = 0;
+	int ret;
+
+	if (ctx->write)
+		return 0;
+
+	if (!is_tcp_mem(ctx))
+		return 0;
+
+	ret = bpf_sysctl_get_current_value(ctx, value, MAX_VALUE_STR_LEN);
+	if (ret < 0 || ret >= MAX_VALUE_STR_LEN)
+		return 0;
+
+#pragma clang loop unroll(full)
+	for (i = 0; i < ARRAY_SIZE(tcp_mem); ++i) {
+		ret = bpf_strtoul(value + off, MAX_ULONG_STR_LEN, 0,
+				  tcp_mem + i);
+		if (ret <= 0 || ret > MAX_ULONG_STR_LEN)
+			return 0;
+		off += ret & MAX_ULONG_STR_LEN;
+	}
+
+
+	return tcp_mem[0] < tcp_mem[1] && tcp_mem[1] < tcp_mem[2];
+}
+
+char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/test_sysctl.c b/tools/testing/selftests/bpf/test_sysctl.c
index 885675480af9..a3bebd7c68dd 100644
--- a/tools/testing/selftests/bpf/test_sysctl.c
+++ b/tools/testing/selftests/bpf/test_sysctl.c
@@ -11,6 +11,7 @@
 #include <linux/filter.h>
 
 #include <bpf/bpf.h>
+#include <bpf/libbpf.h>
 
 #include "bpf_rlimit.h"
 #include "bpf_util.h"
@@ -26,6 +27,7 @@ struct sysctl_test {
 	const char *descr;
 	size_t fixup_value_insn;
 	struct bpf_insn	insns[MAX_INSNS];
+	const char *prog_file;
 	enum bpf_attach_type attach_type;
 	const char *sysctl;
 	int open_flags;
@@ -1302,6 +1304,31 @@ static struct sysctl_test tests[] = {
 		.open_flags = O_RDONLY,
 		.result = SUCCESS,
 	},
+	{
+		"C prog: deny all writes",
+		.prog_file = "./test_sysctl_prog.o",
+		.attach_type = BPF_CGROUP_SYSCTL,
+		.sysctl = "net/ipv4/tcp_mem",
+		.open_flags = O_WRONLY,
+		.newval = "123 456 789",
+		.result = OP_EPERM,
+	},
+	{
+		"C prog: deny access by name",
+		.prog_file = "./test_sysctl_prog.o",
+		.attach_type = BPF_CGROUP_SYSCTL,
+		.sysctl = "net/ipv4/route/mtu_expires",
+		.open_flags = O_RDONLY,
+		.result = OP_EPERM,
+	},
+	{
+		"C prog: read tcp_mem",
+		.prog_file = "./test_sysctl_prog.o",
+		.attach_type = BPF_CGROUP_SYSCTL,
+		.sysctl = "net/ipv4/tcp_mem",
+		.open_flags = O_RDONLY,
+		.result = SUCCESS,
+	},
 };
 
 static size_t probe_prog_length(const struct bpf_insn *fp)
@@ -1335,7 +1362,8 @@ static int fixup_sysctl_value(const char *buf, size_t buf_len,
 	return 0;
 }
 
-static int load_sysctl_prog(struct sysctl_test *test, const char *sysctl_path)
+static int load_sysctl_prog_insns(struct sysctl_test *test,
+				  const char *sysctl_path)
 {
 	struct bpf_insn *prog = test->insns;
 	struct bpf_load_program_attr attr;
@@ -1377,6 +1405,33 @@ static int load_sysctl_prog(struct sysctl_test *test, const char *sysctl_path)
 	return ret;
 }
 
+static int load_sysctl_prog_file(struct sysctl_test *test)
+{
+	struct bpf_prog_load_attr attr;
+	struct bpf_object *obj;
+	int prog_fd;
+
+	memset(&attr, 0, sizeof(struct bpf_prog_load_attr));
+	attr.file = test->prog_file;
+	attr.prog_type = BPF_PROG_TYPE_CGROUP_SYSCTL;
+
+	if (bpf_prog_load_xattr(&attr, &obj, &prog_fd)) {
+		if (test->result != LOAD_REJECT)
+			log_err(">>> Loading program (%s) error.\n",
+				test->prog_file);
+		return -1;
+	}
+
+	return prog_fd;
+}
+
+static int load_sysctl_prog(struct sysctl_test *test, const char *sysctl_path)
+{
+		return test->prog_file
+			? load_sysctl_prog_file(test)
+			: load_sysctl_prog_insns(test, sysctl_path);
+}
+
 static int access_sysctl(const char *sysctl_path,
 			 const struct sysctl_test *test)
 {
-- 
2.17.1

