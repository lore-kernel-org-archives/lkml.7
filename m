Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47A8AC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 00:47:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 033812075D
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 00:47:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="Qf7NHUTK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730955AbfCZArc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 20:47:32 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:38976 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730907AbfCZAr0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 20:47:26 -0400
Received: from pps.filterd (m0001255.ppops.net [127.0.0.1])
        by mx0b-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2Q0fSeT021673
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 17:47:25 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=GVfKN49pJOegMRBDynII4vIYwjEz62xrTp0TmjJW8tM=;
 b=Qf7NHUTKiDHn1JQe+wgn9NpIUZOoDQGKcVcIrCNO5ES3bONPxzU4BbKVwYju5KRwD1C3
 uCFTdHw6cNPezyjB0R50qXay4dDDw+UEDCM8XGV0EI1Y/NB3lm2AFjKobPlK018rDqr3
 Eb8886Y+hUc6gOt0VwtmcTBd0nTnuLnMoFo= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0b-00082601.pphosted.com with ESMTP id 2rf30shu8v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 17:47:25 -0700
Received: from mx-out.facebook.com (2620:10d:c0a1:3::13) by
 mail.thefacebook.com (2620:10d:c021:18::173) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5;
 Mon, 25 Mar 2019 17:47:24 -0700
Received: by dev082.prn2.facebook.com (Postfix, from userid 572249)
        id 2C3E93703672; Mon, 25 Mar 2019 17:47:21 -0700 (PDT)
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
Subject: [PATCH v2 bpf-next 12/21] selftests/bpf: Test sysctl_get_current_value helper
Date:   Mon, 25 Mar 2019 17:43:38 -0700
Message-ID: <1dffd761fc7094a77b66a4ba5d4fe4b820c5bfdb.1553560621.git.rdna@fb.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1553560620.git.rdna@fb.com>
References: <cover.1553560620.git.rdna@fb.com>
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-25_13:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Test sysctl_get_current_value on sysctl read and write, buffers with
enough space and too small buffers to get E2BIG and truncated result,
etc.

  # ./test_sysctl
  ...
  Test case: sysctl_get_current_value sysctl:read ok, gt .. [PASS]
  Test case: sysctl_get_current_value sysctl:read ok, eq .. [PASS]
  Test case: sysctl_get_current_value sysctl:read E2BIG truncated ..  [PASS]
  Test case: sysctl_get_current_value sysctl:read EINVAL .. [PASS]
  Test case: sysctl_get_current_value sysctl:write ok .. [PASS]
  Summary: 16 PASSED, 0 FAILED

Signed-off-by: Andrey Ignatov <rdna@fb.com>
---
 tools/testing/selftests/bpf/test_sysctl.c | 228 ++++++++++++++++++++++
 1 file changed, 228 insertions(+)

diff --git a/tools/testing/selftests/bpf/test_sysctl.c b/tools/testing/selftests/bpf/test_sysctl.c
index 2e7ef04503a8..9fb6560fa775 100644
--- a/tools/testing/selftests/bpf/test_sysctl.c
+++ b/tools/testing/selftests/bpf/test_sysctl.c
@@ -18,11 +18,13 @@
 
 #define CG_PATH			"/foo"
 #define MAX_INSNS		512
+#define FIXUP_SYSCTL_VALUE	0
 
 char bpf_log_buf[BPF_LOG_BUF_SIZE];
 
 struct sysctl_test {
 	const char *descr;
+	size_t fixup_value_insn;
 	struct bpf_insn	insns[MAX_INSNS];
 	enum bpf_attach_type attach_type;
 	const char *sysctl;
@@ -350,6 +352,190 @@ static struct sysctl_test tests[] = {
 		.open_flags = O_RDONLY,
 		.result = SUCCESS,
 	},
+	{
+		.descr = "sysctl_get_current_value sysctl:read ok, gt",
+		.insns = {
+			/* sysctl_get_current_value arg2 (buf) */
+			BPF_MOV64_REG(BPF_REG_7, BPF_REG_10),
+			BPF_ALU64_IMM(BPF_ADD, BPF_REG_7, -8),
+			BPF_MOV64_REG(BPF_REG_2, BPF_REG_7),
+
+			/* sysctl_get_current_value arg3 (buf_len) */
+			BPF_MOV64_IMM(BPF_REG_3, 8),
+
+			/* sysctl_get_current_value(ctx, buf, buf_len) */
+			BPF_EMIT_CALL(BPF_FUNC_sysctl_get_current_value),
+
+			/* if (ret == expected && */
+			BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 6, 6),
+
+			/*     buf[0:6] == "Linux\n\0") */
+			BPF_LD_IMM64(BPF_REG_8, 0x000a78756e694cULL),
+			BPF_LDX_MEM(BPF_DW, BPF_REG_9, BPF_REG_7, 0),
+			BPF_JMP_REG(BPF_JNE, BPF_REG_8, BPF_REG_9, 2),
+
+			/* return ALLOW; */
+			BPF_MOV64_IMM(BPF_REG_0, 1),
+			BPF_JMP_A(1),
+
+			/* else return DENY; */
+			BPF_MOV64_IMM(BPF_REG_0, 0),
+			BPF_EXIT_INSN(),
+		},
+		.attach_type = BPF_CGROUP_SYSCTL,
+		.sysctl = "kernel/ostype",
+		.open_flags = O_RDONLY,
+		.result = SUCCESS,
+	},
+	{
+		.descr = "sysctl_get_current_value sysctl:read ok, eq",
+		.insns = {
+			/* sysctl_get_current_value arg2 (buf) */
+			BPF_MOV64_REG(BPF_REG_7, BPF_REG_10),
+			BPF_ALU64_IMM(BPF_ADD, BPF_REG_7, -8),
+			BPF_MOV64_IMM(BPF_REG_0, 0),
+			BPF_STX_MEM(BPF_B, BPF_REG_7, BPF_REG_0, 7),
+
+			BPF_MOV64_REG(BPF_REG_2, BPF_REG_7),
+
+			/* sysctl_get_current_value arg3 (buf_len) */
+			BPF_MOV64_IMM(BPF_REG_3, 7),
+
+			/* sysctl_get_current_value(ctx, buf, buf_len) */
+			BPF_EMIT_CALL(BPF_FUNC_sysctl_get_current_value),
+
+			/* if (ret == expected && */
+			BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 6, 6),
+
+			/*     buf[0:6] == "Linux\n\0") */
+			BPF_LD_IMM64(BPF_REG_8, 0x000a78756e694cULL),
+			BPF_LDX_MEM(BPF_DW, BPF_REG_9, BPF_REG_7, 0),
+			BPF_JMP_REG(BPF_JNE, BPF_REG_8, BPF_REG_9, 2),
+
+			/* return ALLOW; */
+			BPF_MOV64_IMM(BPF_REG_0, 1),
+			BPF_JMP_A(1),
+
+			/* else return DENY; */
+			BPF_MOV64_IMM(BPF_REG_0, 0),
+			BPF_EXIT_INSN(),
+		},
+		.attach_type = BPF_CGROUP_SYSCTL,
+		.sysctl = "kernel/ostype",
+		.open_flags = O_RDONLY,
+		.result = SUCCESS,
+	},
+	{
+		.descr = "sysctl_get_current_value sysctl:read E2BIG truncated",
+		.insns = {
+			/* sysctl_get_current_value arg2 (buf) */
+			BPF_MOV64_REG(BPF_REG_7, BPF_REG_10),
+			BPF_ALU64_IMM(BPF_ADD, BPF_REG_7, -8),
+			BPF_MOV64_IMM(BPF_REG_0, 0),
+			BPF_STX_MEM(BPF_H, BPF_REG_7, BPF_REG_0, 6),
+
+			BPF_MOV64_REG(BPF_REG_2, BPF_REG_7),
+
+			/* sysctl_get_current_value arg3 (buf_len) */
+			BPF_MOV64_IMM(BPF_REG_3, 6),
+
+			/* sysctl_get_current_value(ctx, buf, buf_len) */
+			BPF_EMIT_CALL(BPF_FUNC_sysctl_get_current_value),
+
+			/* if (ret == expected && */
+			BPF_JMP_IMM(BPF_JNE, BPF_REG_0, -E2BIG, 6),
+
+			/*     buf[0:6] == "Linux\0") */
+			BPF_LD_IMM64(BPF_REG_8, 0x000078756e694cULL),
+			BPF_LDX_MEM(BPF_DW, BPF_REG_9, BPF_REG_7, 0),
+			BPF_JMP_REG(BPF_JNE, BPF_REG_8, BPF_REG_9, 2),
+
+			/* return ALLOW; */
+			BPF_MOV64_IMM(BPF_REG_0, 1),
+			BPF_JMP_A(1),
+
+			/* else return DENY; */
+			BPF_MOV64_IMM(BPF_REG_0, 0),
+			BPF_EXIT_INSN(),
+		},
+		.attach_type = BPF_CGROUP_SYSCTL,
+		.sysctl = "kernel/ostype",
+		.open_flags = O_RDONLY,
+		.result = SUCCESS,
+	},
+	{
+		.descr = "sysctl_get_current_value sysctl:read EINVAL",
+		.insns = {
+			/* sysctl_get_current_value arg2 (buf) */
+			BPF_MOV64_REG(BPF_REG_7, BPF_REG_10),
+			BPF_ALU64_IMM(BPF_ADD, BPF_REG_7, -8),
+
+			BPF_MOV64_REG(BPF_REG_2, BPF_REG_7),
+
+			/* sysctl_get_current_value arg3 (buf_len) */
+			BPF_MOV64_IMM(BPF_REG_3, 8),
+
+			/* sysctl_get_current_value(ctx, buf, buf_len) */
+			BPF_EMIT_CALL(BPF_FUNC_sysctl_get_current_value),
+
+			/* if (ret == expected && */
+			BPF_JMP_IMM(BPF_JNE, BPF_REG_0, -EINVAL, 4),
+
+			/*     buf[0:8] is NUL-filled) */
+			BPF_LDX_MEM(BPF_DW, BPF_REG_9, BPF_REG_7, 0),
+			BPF_JMP_IMM(BPF_JNE, BPF_REG_9, 0, 2),
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
+		.sysctl = "net/ipv6/conf/lo/stable_secret", /* -EIO */
+		.open_flags = O_RDONLY,
+		.result = OP_EPERM,
+	},
+	{
+		.descr = "sysctl_get_current_value sysctl:write ok",
+		.fixup_value_insn = 6,
+		.insns = {
+			/* sysctl_get_current_value arg2 (buf) */
+			BPF_MOV64_REG(BPF_REG_7, BPF_REG_10),
+			BPF_ALU64_IMM(BPF_ADD, BPF_REG_7, -8),
+
+			BPF_MOV64_REG(BPF_REG_2, BPF_REG_7),
+
+			/* sysctl_get_current_value arg3 (buf_len) */
+			BPF_MOV64_IMM(BPF_REG_3, 8),
+
+			/* sysctl_get_current_value(ctx, buf, buf_len) */
+			BPF_EMIT_CALL(BPF_FUNC_sysctl_get_current_value),
+
+			/* if (ret == expected && */
+			BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 4, 6),
+
+			/*     buf[0:4] == expected) */
+			BPF_LD_IMM64(BPF_REG_8, FIXUP_SYSCTL_VALUE),
+			BPF_LDX_MEM(BPF_DW, BPF_REG_9, BPF_REG_7, 0),
+			BPF_JMP_REG(BPF_JNE, BPF_REG_8, BPF_REG_9, 2),
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
+		.sysctl = "net/ipv4/route/mtu_expires",
+		.open_flags = O_WRONLY,
+		.newval = "600", /* same as default, should fail anyway */
+		.result = OP_EPERM,
+	},
 };
 
 static size_t probe_prog_length(const struct bpf_insn *fp)
@@ -362,6 +548,27 @@ static size_t probe_prog_length(const struct bpf_insn *fp)
 	return len + 1;
 }
 
+static int fixup_sysctl_value(const char *buf, size_t buf_len,
+			      struct bpf_insn *prog, size_t insn_num)
+{
+	uint32_t value_num = 0;
+	uint8_t c, i;
+
+	if (buf_len > sizeof(value_num)) {
+		log_err("Value is too big (%zd) to use in fixup", buf_len);
+		return -1;
+	}
+
+	for (i = 0; i < buf_len; ++i) {
+		c = buf[i];
+		value_num |= (c << i * 8);
+	}
+
+	prog[insn_num].imm = value_num;
+
+	return 0;
+}
+
 static int load_sysctl_prog(struct sysctl_test *test, const char *sysctl_path)
 {
 	struct bpf_insn *prog = test->insns;
@@ -374,6 +581,27 @@ static int load_sysctl_prog(struct sysctl_test *test, const char *sysctl_path)
 	attr.insns_cnt = probe_prog_length(attr.insns);
 	attr.license = "GPL";
 
+	if (test->fixup_value_insn) {
+		char buf[128];
+		ssize_t len;
+		int fd;
+
+		fd = open(sysctl_path, O_RDONLY | O_CLOEXEC);
+		if (fd < 0) {
+			log_err("open(%s) failed", sysctl_path);
+			return -1;
+		}
+		len = read(fd, buf, sizeof(buf));
+		if (len == -1) {
+			log_err("read(%s) failed", sysctl_path);
+			close(fd);
+			return -1;
+		}
+		close(fd);
+		if (fixup_sysctl_value(buf, len, prog, test->fixup_value_insn))
+			return -1;
+	}
+
 	ret = bpf_load_program_xattr(&attr, bpf_log_buf, BPF_LOG_BUF_SIZE);
 	if (ret < 0 && test->result != LOAD_REJECT) {
 		log_err(">>> Loading program error.\n"
-- 
2.17.1

