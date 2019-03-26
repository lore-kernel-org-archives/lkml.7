Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1105C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 00:47:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3A6520879
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 00:47:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="I37xfFO+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730877AbfCZArW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 20:47:22 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:49720 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726186AbfCZArU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 20:47:20 -0400
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.27/8.16.0.27) with SMTP id x2Q0ijNO016005
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 17:47:20 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=6UbTFLUkcgxLYeGzHk48r1CygFdthoR8zb7gl0ih+X4=;
 b=I37xfFO+hZaFhvhbXUfoDruf0l1bvIJtrvTx72EyroLoIPrDJVb0v2rhZIycbz+6/DdL
 giz84RyZrWv8/aUzfZTS4hyGiYt4QZsclcEH5nVsNDl42SpM2lYufkTRuewBq5skOoHb
 LyYDC5z4ayOEEJcT6koVcTT8VU8LkBqRJec= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by m0089730.ppops.net with ESMTP id 2rf3rm9jrm-7
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 17:47:20 -0700
Received: from mx-out.facebook.com (2620:10d:c081:10::13) by
 mail.thefacebook.com (2620:10d:c081:35::129) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5;
 Mon, 25 Mar 2019 17:47:18 -0700
Received: by dev082.prn2.facebook.com (Postfix, from userid 572249)
        id E70653703672; Mon, 25 Mar 2019 17:47:14 -0700 (PDT)
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
Subject: [PATCH v2 bpf-next 10/21] selftests/bpf: Test BPF_CGROUP_SYSCTL
Date:   Mon, 25 Mar 2019 17:43:36 -0700
Message-ID: <a2e42fb49cb4acec8cd3f9fa9d7a21c80c357226.1553560621.git.rdna@fb.com>
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

Add unit test for BPF_PROG_TYPE_CGROUP_SYSCTL program type.

Test that program can allow/deny access.
Test both valid and invalid accesses to ctx->write.

Example of output:
  # ./test_sysctl
  Test case: sysctl wrong attach_type .. [PASS]
  Test case: sysctl:read allow all .. [PASS]
  Test case: sysctl:read deny all .. [PASS]
  Test case: ctx:write sysctl:read read ok .. [PASS]
  Test case: ctx:write sysctl:write read ok .. [PASS]
  Test case: ctx:write sysctl:read write reject .. [PASS]
  Summary: 6 PASSED, 0 FAILED

Signed-off-by: Andrey Ignatov <rdna@fb.com>
---
 tools/testing/selftests/bpf/Makefile      |   3 +-
 tools/testing/selftests/bpf/test_sysctl.c | 291 ++++++++++++++++++++++
 2 files changed, 293 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/bpf/test_sysctl.c

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 77b73b892136..d3132f16faed 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -23,7 +23,7 @@ TEST_GEN_PROGS = test_verifier test_tag test_maps test_lru_map test_lpm_map test
 	test_align test_verifier_log test_dev_cgroup test_tcpbpf_user \
 	test_sock test_btf test_sockmap test_lirc_mode2_user get_cgroup_id_user \
 	test_socket_cookie test_cgroup_storage test_select_reuseport test_section_names \
-	test_netcnt test_tcpnotify_user test_sock_fields
+	test_netcnt test_tcpnotify_user test_sock_fields test_sysctl
 
 BPF_OBJ_FILES = $(patsubst %.c,%.o, $(notdir $(wildcard progs/*.c)))
 TEST_GEN_FILES = $(BPF_OBJ_FILES)
@@ -93,6 +93,7 @@ $(OUTPUT)/get_cgroup_id_user: cgroup_helpers.c
 $(OUTPUT)/test_cgroup_storage: cgroup_helpers.c
 $(OUTPUT)/test_netcnt: cgroup_helpers.c
 $(OUTPUT)/test_sock_fields: cgroup_helpers.c
+$(OUTPUT)/test_sysctl: cgroup_helpers.c
 
 .PHONY: force
 
diff --git a/tools/testing/selftests/bpf/test_sysctl.c b/tools/testing/selftests/bpf/test_sysctl.c
new file mode 100644
index 000000000000..6d0ab09789ad
--- /dev/null
+++ b/tools/testing/selftests/bpf/test_sysctl.c
@@ -0,0 +1,291 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (c) 2019 Facebook
+
+#include <fcntl.h>
+#include <stdint.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+
+#include <linux/filter.h>
+
+#include <bpf/bpf.h>
+
+#include "bpf_rlimit.h"
+#include "bpf_util.h"
+#include "cgroup_helpers.h"
+
+#define CG_PATH			"/foo"
+#define MAX_INSNS		512
+
+char bpf_log_buf[BPF_LOG_BUF_SIZE];
+
+struct sysctl_test {
+	const char *descr;
+	struct bpf_insn	insns[MAX_INSNS];
+	enum bpf_attach_type attach_type;
+	const char *sysctl;
+	int open_flags;
+	const char *newval;
+	enum {
+		LOAD_REJECT,
+		ATTACH_REJECT,
+		OP_EPERM,
+		SUCCESS,
+	} result;
+};
+
+static struct sysctl_test tests[] = {
+	{
+		.descr = "sysctl wrong attach_type",
+		.insns = {
+			BPF_MOV64_IMM(BPF_REG_0, 1),
+			BPF_EXIT_INSN(),
+		},
+		.attach_type = 0,
+		.sysctl = "kernel/ostype",
+		.open_flags = O_RDONLY,
+		.result = ATTACH_REJECT,
+	},
+	{
+		.descr = "sysctl:read allow all",
+		.insns = {
+			BPF_MOV64_IMM(BPF_REG_0, 1),
+			BPF_EXIT_INSN(),
+		},
+		.attach_type = BPF_CGROUP_SYSCTL,
+		.sysctl = "kernel/ostype",
+		.open_flags = O_RDONLY,
+		.result = SUCCESS,
+	},
+	{
+		.descr = "sysctl:read deny all",
+		.insns = {
+			BPF_MOV64_IMM(BPF_REG_0, 0),
+			BPF_EXIT_INSN(),
+		},
+		.attach_type = BPF_CGROUP_SYSCTL,
+		.sysctl = "kernel/ostype",
+		.open_flags = O_RDONLY,
+		.result = OP_EPERM,
+	},
+	{
+		.descr = "ctx:write sysctl:read read ok",
+		.insns = {
+			/* If (write) */
+			BPF_LDX_MEM(BPF_W, BPF_REG_7, BPF_REG_1,
+				    offsetof(struct bpf_sysctl, write)),
+			BPF_JMP_IMM(BPF_JNE, BPF_REG_7, 1, 2),
+
+			/* return DENY; */
+			BPF_MOV64_IMM(BPF_REG_0, 0),
+			BPF_JMP_A(1),
+
+			/* else return ALLOW; */
+			BPF_MOV64_IMM(BPF_REG_0, 1),
+			BPF_EXIT_INSN(),
+		},
+		.attach_type = BPF_CGROUP_SYSCTL,
+		.sysctl = "kernel/ostype",
+		.open_flags = O_RDONLY,
+		.result = SUCCESS,
+	},
+	{
+		.descr = "ctx:write sysctl:write read ok",
+		.insns = {
+			/* If (write) */
+			BPF_LDX_MEM(BPF_B, BPF_REG_7, BPF_REG_1,
+				    offsetof(struct bpf_sysctl, write)),
+			BPF_JMP_IMM(BPF_JNE, BPF_REG_7, 1, 2),
+
+			/* return DENY; */
+			BPF_MOV64_IMM(BPF_REG_0, 0),
+			BPF_JMP_A(1),
+
+			/* else return ALLOW; */
+			BPF_MOV64_IMM(BPF_REG_0, 1),
+			BPF_EXIT_INSN(),
+		},
+		.attach_type = BPF_CGROUP_SYSCTL,
+		.sysctl = "kernel/domainname",
+		.open_flags = O_WRONLY,
+		.newval = "(none)", /* same as default, should fail anyway */
+		.result = OP_EPERM,
+	},
+	{
+		.descr = "ctx:write sysctl:read write reject",
+		.insns = {
+			/* write = X */
+			BPF_MOV64_IMM(BPF_REG_0, 0),
+			BPF_STX_MEM(BPF_W, BPF_REG_1, BPF_REG_0,
+				    offsetof(struct bpf_sysctl, write)),
+			BPF_MOV64_IMM(BPF_REG_0, 1),
+			BPF_EXIT_INSN(),
+		},
+		.attach_type = BPF_CGROUP_SYSCTL,
+		.sysctl = "kernel/ostype",
+		.open_flags = O_RDONLY,
+		.result = LOAD_REJECT,
+	},
+};
+
+static size_t probe_prog_length(const struct bpf_insn *fp)
+{
+	size_t len;
+
+	for (len = MAX_INSNS - 1; len > 0; --len)
+		if (fp[len].code != 0 || fp[len].imm != 0)
+			break;
+	return len + 1;
+}
+
+static int load_sysctl_prog(struct sysctl_test *test, const char *sysctl_path)
+{
+	struct bpf_insn *prog = test->insns;
+	struct bpf_load_program_attr attr;
+	int ret;
+
+	memset(&attr, 0, sizeof(struct bpf_load_program_attr));
+	attr.prog_type = BPF_PROG_TYPE_CGROUP_SYSCTL;
+	attr.insns = prog;
+	attr.insns_cnt = probe_prog_length(attr.insns);
+	attr.license = "GPL";
+
+	ret = bpf_load_program_xattr(&attr, bpf_log_buf, BPF_LOG_BUF_SIZE);
+	if (ret < 0 && test->result != LOAD_REJECT) {
+		log_err(">>> Loading program error.\n"
+			">>> Verifier output:\n%s\n-------\n", bpf_log_buf);
+	}
+
+	return ret;
+}
+
+static int access_sysctl(const char *sysctl_path,
+			 const struct sysctl_test *test)
+{
+	int err = 0;
+	int fd;
+
+	fd = open(sysctl_path, test->open_flags | O_CLOEXEC);
+	if (fd < 0)
+		return fd;
+
+	if (test->open_flags == O_RDONLY) {
+		char buf[128];
+
+		if (read(fd, buf, sizeof(buf)) == -1)
+			goto err;
+	} else if (test->open_flags == O_WRONLY) {
+		if (!test->newval) {
+			log_err("New value for sysctl is not set");
+			goto err;
+		}
+		if (write(fd, test->newval, strlen(test->newval)) == -1)
+			goto err;
+	} else {
+		log_err("Unexpected sysctl access: neither read nor write");
+		goto err;
+	}
+
+	goto out;
+err:
+	err = -1;
+out:
+	close(fd);
+	return err;
+}
+
+static int run_test_case(int cgfd, struct sysctl_test *test)
+{
+	enum bpf_attach_type atype = test->attach_type;
+	char sysctl_path[128];
+	int progfd = -1;
+	int err = 0;
+
+	printf("Test case: %s .. ", test->descr);
+
+	snprintf(sysctl_path, sizeof(sysctl_path), "/proc/sys/%s",
+		 test->sysctl);
+
+	progfd = load_sysctl_prog(test, sysctl_path);
+	if (progfd < 0) {
+		if (test->result == LOAD_REJECT)
+			goto out;
+		else
+			goto err;
+	}
+
+	if (bpf_prog_attach(progfd, cgfd, atype, BPF_F_ALLOW_OVERRIDE) == -1) {
+		if (test->result == ATTACH_REJECT)
+			goto out;
+		else
+			goto err;
+	}
+
+	if (access_sysctl(sysctl_path, test) == -1) {
+		if (test->result == OP_EPERM && errno == EPERM)
+			goto out;
+		else
+			goto err;
+	}
+
+	if (test->result != SUCCESS) {
+		log_err("Unexpected failure");
+		goto err;
+	}
+
+	goto out;
+err:
+	err = -1;
+out:
+	/* Detaching w/o checking return code: best effort attempt. */
+	if (progfd != -1)
+		bpf_prog_detach(cgfd, atype);
+	close(progfd);
+	printf("[%s]\n", err ? "FAIL" : "PASS");
+	return err;
+}
+
+static int run_tests(int cgfd)
+{
+	int passes = 0;
+	int fails = 0;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(tests); ++i) {
+		if (run_test_case(cgfd, &tests[i]))
+			++fails;
+		else
+			++passes;
+	}
+	printf("Summary: %d PASSED, %d FAILED\n", passes, fails);
+	return fails ? -1 : 0;
+}
+
+int main(int argc, char **argv)
+{
+	int cgfd = -1;
+	int err = 0;
+
+	if (setup_cgroup_environment())
+		goto err;
+
+	cgfd = create_and_get_cgroup(CG_PATH);
+	if (cgfd < 0)
+		goto err;
+
+	if (join_cgroup(CG_PATH))
+		goto err;
+
+	if (run_tests(cgfd))
+		goto err;
+
+	goto out;
+err:
+	err = -1;
+out:
+	close(cgfd);
+	cleanup_cgroup_environment();
+	return err;
+}
-- 
2.17.1

