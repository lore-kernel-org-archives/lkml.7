Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93F9FC282DC
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 19:38:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 505F72146F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 19:38:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="Sr9r4bfH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732197AbfDETiA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 15:38:00 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:44148 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732026AbfDETg6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 15:36:58 -0400
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x35JWYq9028104
        for <linux-kernel@vger.kernel.org>; Fri, 5 Apr 2019 12:36:58 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=0DipYnreK6y9qvxuVL79aoo8YWq9tRY/xF9uWa/OP0k=;
 b=Sr9r4bfHVAo6bb617kDwMxLdsEG/SmQB+vnGh+Bz/AHhWWrmbYFTnDJaYW4r9fybeRsj
 vumMp8W1OYZBxVVySah8W/R7grupL8X8zcwwyfTrt44CJvvEahQVGECgMxZdl98+QIfH
 5z/Rnnf9WlnnxHceV+5Gb9Obk7SAJeoF6Zw= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2rpbqc0c4t-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2019 12:36:58 -0700
Received: from mx-out.facebook.com (2620:10d:c0a1:3::13) by
 mail.thefacebook.com (2620:10d:c021:18::176) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5;
 Fri, 5 Apr 2019 12:36:47 -0700
Received: by dev082.prn2.facebook.com (Postfix, from userid 572249)
        id 9638D3701752; Fri,  5 Apr 2019 12:36:45 -0700 (PDT)
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
Subject: [PATCH v3 bpf-next 11/21] selftests/bpf: Test bpf_sysctl_get_name helper
Date:   Fri, 5 Apr 2019 12:35:33 -0700
Message-ID: <8e23b79817a73a728b8835fc25dfa74cdae8c7d9.1554485409.git.rdna@fb.com>
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

Test w/ and w/o BPF_F_SYSCTL_BASE_NAME, buffers with enough space and
too small buffers to get E2BIG and truncated result, etc.

  # ./test_sysctl
  ...
  Test case: sysctl_get_name sysctl_value:base ok .. [PASS]
  Test case: sysctl_get_name sysctl_value:base E2BIG truncated .. [PASS]
  Test case: sysctl_get_name sysctl:full ok .. [PASS]
  Test case: sysctl_get_name sysctl:full E2BIG truncated .. [PASS]
  Test case: sysctl_get_name sysctl:full E2BIG truncated small .. [PASS]
  Summary: 11 PASSED, 0 FAILED

Signed-off-by: Andrey Ignatov <rdna@fb.com>
---
 tools/testing/selftests/bpf/test_sysctl.c | 222 ++++++++++++++++++++++
 1 file changed, 222 insertions(+)

diff --git a/tools/testing/selftests/bpf/test_sysctl.c b/tools/testing/selftests/bpf/test_sysctl.c
index 6d0ab09789ad..2e7ef04503a8 100644
--- a/tools/testing/selftests/bpf/test_sysctl.c
+++ b/tools/testing/selftests/bpf/test_sysctl.c
@@ -128,6 +128,228 @@ static struct sysctl_test tests[] = {
 		.open_flags = O_RDONLY,
 		.result = LOAD_REJECT,
 	},
+	{
+		.descr = "sysctl_get_name sysctl_value:base ok",
+		.insns = {
+			/* sysctl_get_name arg2 (buf) */
+			BPF_MOV64_REG(BPF_REG_7, BPF_REG_10),
+			BPF_ALU64_IMM(BPF_ADD, BPF_REG_7, -8),
+			BPF_MOV64_IMM(BPF_REG_0, 0),
+			BPF_STX_MEM(BPF_DW, BPF_REG_7, BPF_REG_0, 0),
+
+			BPF_MOV64_REG(BPF_REG_2, BPF_REG_7),
+
+			/* sysctl_get_name arg3 (buf_len) */
+			BPF_MOV64_IMM(BPF_REG_3, 8),
+
+			/* sysctl_get_name arg4 (flags) */
+			BPF_MOV64_IMM(BPF_REG_4, BPF_F_SYSCTL_BASE_NAME),
+
+			/* sysctl_get_name(ctx, buf, buf_len, flags) */
+			BPF_EMIT_CALL(BPF_FUNC_sysctl_get_name),
+
+			/* if (ret == expected && */
+			BPF_JMP_IMM(BPF_JNE, BPF_REG_0, sizeof("tcp_mem") - 1, 6),
+			/*     buf == "tcp_mem\0") */
+			BPF_LD_IMM64(BPF_REG_8, 0x006d656d5f706374ULL),
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
+		.sysctl = "net/ipv4/tcp_mem",
+		.open_flags = O_RDONLY,
+		.result = SUCCESS,
+	},
+	{
+		.descr = "sysctl_get_name sysctl_value:base E2BIG truncated",
+		.insns = {
+			/* sysctl_get_name arg2 (buf) */
+			BPF_MOV64_REG(BPF_REG_7, BPF_REG_10),
+			BPF_ALU64_IMM(BPF_ADD, BPF_REG_7, -8),
+			BPF_MOV64_IMM(BPF_REG_0, 0),
+			BPF_STX_MEM(BPF_DW, BPF_REG_7, BPF_REG_0, 0),
+
+			BPF_MOV64_REG(BPF_REG_2, BPF_REG_7),
+
+			/* sysctl_get_name arg3 (buf_len) too small */
+			BPF_MOV64_IMM(BPF_REG_3, 7),
+
+			/* sysctl_get_name arg4 (flags) */
+			BPF_MOV64_IMM(BPF_REG_4, BPF_F_SYSCTL_BASE_NAME),
+
+			/* sysctl_get_name(ctx, buf, buf_len, flags) */
+			BPF_EMIT_CALL(BPF_FUNC_sysctl_get_name),
+
+			/* if (ret == expected && */
+			BPF_JMP_IMM(BPF_JNE, BPF_REG_0, -E2BIG, 6),
+
+			/*     buf[0:7] == "tcp_me\0") */
+			BPF_LD_IMM64(BPF_REG_8, 0x00656d5f706374ULL),
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
+		.sysctl = "net/ipv4/tcp_mem",
+		.open_flags = O_RDONLY,
+		.result = SUCCESS,
+	},
+	{
+		.descr = "sysctl_get_name sysctl:full ok",
+		.insns = {
+			/* sysctl_get_name arg2 (buf) */
+			BPF_MOV64_REG(BPF_REG_7, BPF_REG_10),
+			BPF_ALU64_IMM(BPF_ADD, BPF_REG_7, -24),
+			BPF_MOV64_IMM(BPF_REG_0, 0),
+			BPF_STX_MEM(BPF_DW, BPF_REG_7, BPF_REG_0, 0),
+			BPF_STX_MEM(BPF_DW, BPF_REG_7, BPF_REG_0, 8),
+			BPF_STX_MEM(BPF_DW, BPF_REG_7, BPF_REG_0, 16),
+
+			BPF_MOV64_REG(BPF_REG_2, BPF_REG_7),
+
+			/* sysctl_get_name arg3 (buf_len) */
+			BPF_MOV64_IMM(BPF_REG_3, 17),
+
+			/* sysctl_get_name arg4 (flags) */
+			BPF_MOV64_IMM(BPF_REG_4, 0),
+
+			/* sysctl_get_name(ctx, buf, buf_len, flags) */
+			BPF_EMIT_CALL(BPF_FUNC_sysctl_get_name),
+
+			/* if (ret == expected && */
+			BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 16, 14),
+
+			/*     buf[0:8] == "net/ipv4" && */
+			BPF_LD_IMM64(BPF_REG_8, 0x347670692f74656eULL),
+			BPF_LDX_MEM(BPF_DW, BPF_REG_9, BPF_REG_7, 0),
+			BPF_JMP_REG(BPF_JNE, BPF_REG_8, BPF_REG_9, 10),
+
+			/*     buf[8:16] == "/tcp_mem" && */
+			BPF_LD_IMM64(BPF_REG_8, 0x6d656d5f7063742fULL),
+			BPF_LDX_MEM(BPF_DW, BPF_REG_9, BPF_REG_7, 8),
+			BPF_JMP_REG(BPF_JNE, BPF_REG_8, BPF_REG_9, 6),
+
+			/*     buf[16:24] == "\0") */
+			BPF_LD_IMM64(BPF_REG_8, 0x0ULL),
+			BPF_LDX_MEM(BPF_DW, BPF_REG_9, BPF_REG_7, 16),
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
+		.sysctl = "net/ipv4/tcp_mem",
+		.open_flags = O_RDONLY,
+		.result = SUCCESS,
+	},
+	{
+		.descr = "sysctl_get_name sysctl:full E2BIG truncated",
+		.insns = {
+			/* sysctl_get_name arg2 (buf) */
+			BPF_MOV64_REG(BPF_REG_7, BPF_REG_10),
+			BPF_ALU64_IMM(BPF_ADD, BPF_REG_7, -16),
+			BPF_MOV64_IMM(BPF_REG_0, 0),
+			BPF_STX_MEM(BPF_DW, BPF_REG_7, BPF_REG_0, 0),
+			BPF_STX_MEM(BPF_DW, BPF_REG_7, BPF_REG_0, 8),
+
+			BPF_MOV64_REG(BPF_REG_2, BPF_REG_7),
+
+			/* sysctl_get_name arg3 (buf_len) */
+			BPF_MOV64_IMM(BPF_REG_3, 16),
+
+			/* sysctl_get_name arg4 (flags) */
+			BPF_MOV64_IMM(BPF_REG_4, 0),
+
+			/* sysctl_get_name(ctx, buf, buf_len, flags) */
+			BPF_EMIT_CALL(BPF_FUNC_sysctl_get_name),
+
+			/* if (ret == expected && */
+			BPF_JMP_IMM(BPF_JNE, BPF_REG_0, -E2BIG, 10),
+
+			/*     buf[0:8] == "net/ipv4" && */
+			BPF_LD_IMM64(BPF_REG_8, 0x347670692f74656eULL),
+			BPF_LDX_MEM(BPF_DW, BPF_REG_9, BPF_REG_7, 0),
+			BPF_JMP_REG(BPF_JNE, BPF_REG_8, BPF_REG_9, 6),
+
+			/*     buf[8:16] == "/tcp_me\0") */
+			BPF_LD_IMM64(BPF_REG_8, 0x00656d5f7063742fULL),
+			BPF_LDX_MEM(BPF_DW, BPF_REG_9, BPF_REG_7, 8),
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
+		.sysctl = "net/ipv4/tcp_mem",
+		.open_flags = O_RDONLY,
+		.result = SUCCESS,
+	},
+	{
+		.descr = "sysctl_get_name sysctl:full E2BIG truncated small",
+		.insns = {
+			/* sysctl_get_name arg2 (buf) */
+			BPF_MOV64_REG(BPF_REG_7, BPF_REG_10),
+			BPF_ALU64_IMM(BPF_ADD, BPF_REG_7, -8),
+			BPF_MOV64_IMM(BPF_REG_0, 0),
+			BPF_STX_MEM(BPF_DW, BPF_REG_7, BPF_REG_0, 0),
+
+			BPF_MOV64_REG(BPF_REG_2, BPF_REG_7),
+
+			/* sysctl_get_name arg3 (buf_len) */
+			BPF_MOV64_IMM(BPF_REG_3, 7),
+
+			/* sysctl_get_name arg4 (flags) */
+			BPF_MOV64_IMM(BPF_REG_4, 0),
+
+			/* sysctl_get_name(ctx, buf, buf_len, flags) */
+			BPF_EMIT_CALL(BPF_FUNC_sysctl_get_name),
+
+			/* if (ret == expected && */
+			BPF_JMP_IMM(BPF_JNE, BPF_REG_0, -E2BIG, 6),
+
+			/*     buf[0:8] == "net/ip\0") */
+			BPF_LD_IMM64(BPF_REG_8, 0x000070692f74656eULL),
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
+		.sysctl = "net/ipv4/tcp_mem",
+		.open_flags = O_RDONLY,
+		.result = SUCCESS,
+	},
 };
 
 static size_t probe_prog_length(const struct bpf_insn *fp)
-- 
2.17.1

