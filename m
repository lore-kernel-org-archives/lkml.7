Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UPPERCASE_50_75,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D894BC282DA
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 19:37:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83A2A2175B
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 19:37:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="P5mNrVMP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732098AbfDEThG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 15:37:06 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:59898 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731653AbfDEThC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 15:37:02 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x35JaFoa014466
        for <linux-kernel@vger.kernel.org>; Fri, 5 Apr 2019 12:37:00 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=FAqSp+GSeMwf8e8fjbSsVnxQY/uGTQn8oQie5r38KXE=;
 b=P5mNrVMPjGVV7S9kV/EURngZUA+WMoHsKahG2Au0OVawM10XO74g8STRYAVnT9mYK6Nl
 deEHeSWSBMnUI+qAjrZhNZiHtUkMwEJs4QbhZbXZ5yQdJ1kA81DZkks5y61r2BUVBGjC
 HRVlYu9l5eNfyfo5eeWmejTtS/Cfhhnb3N0= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2rp6mfsjpq-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2019 12:37:00 -0700
Received: from mx-out.facebook.com (2620:10d:c081:10::13) by
 mail.thefacebook.com (2620:10d:c081:35::128) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5;
 Fri, 5 Apr 2019 12:36:59 -0700
Received: by dev082.prn2.facebook.com (Postfix, from userid 572249)
        id 5181B3701752; Fri,  5 Apr 2019 12:36:59 -0700 (PDT)
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
Subject: [PATCH v3 bpf-next 20/21] selftests/bpf: Test bpf_strtol and bpf_strtoul helpers
Date:   Fri, 5 Apr 2019 12:35:42 -0700
Message-ID: <9f56d40ad80b775efb339b45f98b27c8110b41da.1554485410.git.rdna@fb.com>
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

Test that bpf_strtol and  bpf_strtoul helpers can be used to convert
provided buffer to long or unsigned long correspondingly and return both
correct result and number of consumed bytes, or proper errno.

Example of output:
  # ./test_sysctl
  ..
  Test case: bpf_strtoul one number string .. [PASS]
  Test case: bpf_strtoul multi number string .. [PASS]
  Test case: bpf_strtoul buf_len = 0, reject .. [PASS]
  Test case: bpf_strtoul supported base, ok .. [PASS]
  Test case: bpf_strtoul unsupported base, EINVAL .. [PASS]
  Test case: bpf_strtoul buf with spaces only, EINVAL .. [PASS]
  Test case: bpf_strtoul negative number, EINVAL .. [PASS]
  Test case: bpf_strtol negative number, ok .. [PASS]
  Test case: bpf_strtol hex number, ok .. [PASS]
  Test case: bpf_strtol max long .. [PASS]
  Test case: bpf_strtol overflow, ERANGE .. [PASS]
  Summary: 36 PASSED, 0 FAILED

Signed-off-by: Andrey Ignatov <rdna@fb.com>
---
 tools/testing/selftests/bpf/test_sysctl.c | 485 ++++++++++++++++++++++
 1 file changed, 485 insertions(+)

diff --git a/tools/testing/selftests/bpf/test_sysctl.c b/tools/testing/selftests/bpf/test_sysctl.c
index 43008aae32d3..885675480af9 100644
--- a/tools/testing/selftests/bpf/test_sysctl.c
+++ b/tools/testing/selftests/bpf/test_sysctl.c
@@ -817,6 +817,491 @@ static struct sysctl_test tests[] = {
 		.newval = "606",
 		.result = SUCCESS,
 	},
+	{
+		"bpf_strtoul one number string",
+		.insns = {
+			/* arg1 (buf) */
+			BPF_MOV64_REG(BPF_REG_7, BPF_REG_10),
+			BPF_ALU64_IMM(BPF_ADD, BPF_REG_7, -8),
+			BPF_MOV64_IMM(BPF_REG_0, 0x00303036),
+			BPF_STX_MEM(BPF_DW, BPF_REG_7, BPF_REG_0, 0),
+
+			BPF_MOV64_REG(BPF_REG_1, BPF_REG_7),
+
+			/* arg2 (buf_len) */
+			BPF_MOV64_IMM(BPF_REG_2, 4),
+
+			/* arg3 (flags) */
+			BPF_MOV64_IMM(BPF_REG_3, 0),
+
+			/* arg4 (res) */
+			BPF_ALU64_IMM(BPF_ADD, BPF_REG_7, -8),
+			BPF_STX_MEM(BPF_DW, BPF_REG_7, BPF_REG_0, 0),
+			BPF_MOV64_REG(BPF_REG_4, BPF_REG_7),
+
+			BPF_EMIT_CALL(BPF_FUNC_strtoul),
+
+			/* if (ret == expected && */
+			BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 3, 4),
+			/*     res == expected) */
+			BPF_LDX_MEM(BPF_DW, BPF_REG_9, BPF_REG_7, 0),
+			BPF_JMP_IMM(BPF_JNE, BPF_REG_9, 600, 2),
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
+		.sysctl = "net/ipv4/route/mtu_expires",
+		.open_flags = O_RDONLY,
+		.result = SUCCESS,
+	},
+	{
+		"bpf_strtoul multi number string",
+		.insns = {
+			/* arg1 (buf) */
+			BPF_MOV64_REG(BPF_REG_7, BPF_REG_10),
+			BPF_ALU64_IMM(BPF_ADD, BPF_REG_7, -8),
+			/* "600 602\0" */
+			BPF_LD_IMM64(BPF_REG_0, 0x0032303620303036ULL),
+			BPF_STX_MEM(BPF_DW, BPF_REG_7, BPF_REG_0, 0),
+			BPF_MOV64_REG(BPF_REG_1, BPF_REG_7),
+
+			/* arg2 (buf_len) */
+			BPF_MOV64_IMM(BPF_REG_2, 8),
+
+			/* arg3 (flags) */
+			BPF_MOV64_IMM(BPF_REG_3, 0),
+
+			/* arg4 (res) */
+			BPF_ALU64_IMM(BPF_ADD, BPF_REG_7, -8),
+			BPF_STX_MEM(BPF_DW, BPF_REG_7, BPF_REG_0, 0),
+			BPF_MOV64_REG(BPF_REG_4, BPF_REG_7),
+
+			BPF_EMIT_CALL(BPF_FUNC_strtoul),
+
+			/* if (ret == expected && */
+			BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 3, 18),
+			/*     res == expected) */
+			BPF_LDX_MEM(BPF_DW, BPF_REG_9, BPF_REG_7, 0),
+			BPF_JMP_IMM(BPF_JNE, BPF_REG_9, 600, 16),
+
+			/*     arg1 (buf) */
+			BPF_MOV64_REG(BPF_REG_7, BPF_REG_10),
+			BPF_ALU64_IMM(BPF_ADD, BPF_REG_7, -8),
+			BPF_ALU64_REG(BPF_ADD, BPF_REG_7, BPF_REG_0),
+			BPF_MOV64_REG(BPF_REG_1, BPF_REG_7),
+
+			/*     arg2 (buf_len) */
+			BPF_MOV64_IMM(BPF_REG_2, 8),
+			BPF_ALU64_REG(BPF_SUB, BPF_REG_2, BPF_REG_0),
+
+			/*     arg3 (flags) */
+			BPF_MOV64_IMM(BPF_REG_3, 0),
+
+			/*     arg4 (res) */
+			BPF_MOV64_REG(BPF_REG_7, BPF_REG_10),
+			BPF_ALU64_IMM(BPF_ADD, BPF_REG_7, -16),
+			BPF_MOV64_REG(BPF_REG_4, BPF_REG_7),
+
+			BPF_EMIT_CALL(BPF_FUNC_strtoul),
+
+			/*     if (ret == expected && */
+			BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 4, 4),
+			/*         res == expected) */
+			BPF_LDX_MEM(BPF_DW, BPF_REG_9, BPF_REG_7, 0),
+			BPF_JMP_IMM(BPF_JNE, BPF_REG_9, 602, 2),
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
+		"bpf_strtoul buf_len = 0, reject",
+		.insns = {
+			/* arg1 (buf) */
+			BPF_MOV64_REG(BPF_REG_7, BPF_REG_10),
+			BPF_ALU64_IMM(BPF_ADD, BPF_REG_7, -8),
+			BPF_MOV64_IMM(BPF_REG_0, 0x00303036),
+			BPF_STX_MEM(BPF_DW, BPF_REG_7, BPF_REG_0, 0),
+
+			BPF_MOV64_REG(BPF_REG_1, BPF_REG_7),
+
+			/* arg2 (buf_len) */
+			BPF_MOV64_IMM(BPF_REG_2, 0),
+
+			/* arg3 (flags) */
+			BPF_MOV64_IMM(BPF_REG_3, 0),
+
+			/* arg4 (res) */
+			BPF_ALU64_IMM(BPF_ADD, BPF_REG_7, -8),
+			BPF_STX_MEM(BPF_DW, BPF_REG_7, BPF_REG_0, 0),
+			BPF_MOV64_REG(BPF_REG_4, BPF_REG_7),
+
+			BPF_EMIT_CALL(BPF_FUNC_strtoul),
+
+			BPF_MOV64_IMM(BPF_REG_0, 1),
+			BPF_EXIT_INSN(),
+		},
+		.attach_type = BPF_CGROUP_SYSCTL,
+		.sysctl = "net/ipv4/route/mtu_expires",
+		.open_flags = O_RDONLY,
+		.result = LOAD_REJECT,
+	},
+	{
+		"bpf_strtoul supported base, ok",
+		.insns = {
+			/* arg1 (buf) */
+			BPF_MOV64_REG(BPF_REG_7, BPF_REG_10),
+			BPF_ALU64_IMM(BPF_ADD, BPF_REG_7, -8),
+			BPF_MOV64_IMM(BPF_REG_0, 0x00373730),
+			BPF_STX_MEM(BPF_DW, BPF_REG_7, BPF_REG_0, 0),
+
+			BPF_MOV64_REG(BPF_REG_1, BPF_REG_7),
+
+			/* arg2 (buf_len) */
+			BPF_MOV64_IMM(BPF_REG_2, 4),
+
+			/* arg3 (flags) */
+			BPF_MOV64_IMM(BPF_REG_3, 8),
+
+			/* arg4 (res) */
+			BPF_ALU64_IMM(BPF_ADD, BPF_REG_7, -8),
+			BPF_STX_MEM(BPF_DW, BPF_REG_7, BPF_REG_0, 0),
+			BPF_MOV64_REG(BPF_REG_4, BPF_REG_7),
+
+			BPF_EMIT_CALL(BPF_FUNC_strtoul),
+
+			/* if (ret == expected && */
+			BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 3, 4),
+			/*     res == expected) */
+			BPF_LDX_MEM(BPF_DW, BPF_REG_9, BPF_REG_7, 0),
+			BPF_JMP_IMM(BPF_JNE, BPF_REG_9, 63, 2),
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
+		.sysctl = "net/ipv4/route/mtu_expires",
+		.open_flags = O_RDONLY,
+		.result = SUCCESS,
+	},
+	{
+		"bpf_strtoul unsupported base, EINVAL",
+		.insns = {
+			/* arg1 (buf) */
+			BPF_MOV64_REG(BPF_REG_7, BPF_REG_10),
+			BPF_ALU64_IMM(BPF_ADD, BPF_REG_7, -8),
+			BPF_MOV64_IMM(BPF_REG_0, 0x00303036),
+			BPF_STX_MEM(BPF_DW, BPF_REG_7, BPF_REG_0, 0),
+
+			BPF_MOV64_REG(BPF_REG_1, BPF_REG_7),
+
+			/* arg2 (buf_len) */
+			BPF_MOV64_IMM(BPF_REG_2, 4),
+
+			/* arg3 (flags) */
+			BPF_MOV64_IMM(BPF_REG_3, 3),
+
+			/* arg4 (res) */
+			BPF_ALU64_IMM(BPF_ADD, BPF_REG_7, -8),
+			BPF_STX_MEM(BPF_DW, BPF_REG_7, BPF_REG_0, 0),
+			BPF_MOV64_REG(BPF_REG_4, BPF_REG_7),
+
+			BPF_EMIT_CALL(BPF_FUNC_strtoul),
+
+			/* if (ret == expected) */
+			BPF_JMP_IMM(BPF_JNE, BPF_REG_0, -EINVAL, 2),
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
+		.sysctl = "net/ipv4/route/mtu_expires",
+		.open_flags = O_RDONLY,
+		.result = SUCCESS,
+	},
+	{
+		"bpf_strtoul buf with spaces only, EINVAL",
+		.insns = {
+			/* arg1 (buf) */
+			BPF_MOV64_REG(BPF_REG_7, BPF_REG_10),
+			BPF_ALU64_IMM(BPF_ADD, BPF_REG_7, -8),
+			BPF_MOV64_IMM(BPF_REG_0, 0x090a0c0d),
+			BPF_STX_MEM(BPF_DW, BPF_REG_7, BPF_REG_0, 0),
+
+			BPF_MOV64_REG(BPF_REG_1, BPF_REG_7),
+
+			/* arg2 (buf_len) */
+			BPF_MOV64_IMM(BPF_REG_2, 4),
+
+			/* arg3 (flags) */
+			BPF_MOV64_IMM(BPF_REG_3, 0),
+
+			/* arg4 (res) */
+			BPF_ALU64_IMM(BPF_ADD, BPF_REG_7, -8),
+			BPF_STX_MEM(BPF_DW, BPF_REG_7, BPF_REG_0, 0),
+			BPF_MOV64_REG(BPF_REG_4, BPF_REG_7),
+
+			BPF_EMIT_CALL(BPF_FUNC_strtoul),
+
+			/* if (ret == expected) */
+			BPF_JMP_IMM(BPF_JNE, BPF_REG_0, -EINVAL, 2),
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
+		.sysctl = "net/ipv4/route/mtu_expires",
+		.open_flags = O_RDONLY,
+		.result = SUCCESS,
+	},
+	{
+		"bpf_strtoul negative number, EINVAL",
+		.insns = {
+			/* arg1 (buf) */
+			BPF_MOV64_REG(BPF_REG_7, BPF_REG_10),
+			BPF_ALU64_IMM(BPF_ADD, BPF_REG_7, -8),
+			BPF_MOV64_IMM(BPF_REG_0, 0x00362d0a), /* " -6\0" */
+			BPF_STX_MEM(BPF_DW, BPF_REG_7, BPF_REG_0, 0),
+
+			BPF_MOV64_REG(BPF_REG_1, BPF_REG_7),
+
+			/* arg2 (buf_len) */
+			BPF_MOV64_IMM(BPF_REG_2, 4),
+
+			/* arg3 (flags) */
+			BPF_MOV64_IMM(BPF_REG_3, 0),
+
+			/* arg4 (res) */
+			BPF_ALU64_IMM(BPF_ADD, BPF_REG_7, -8),
+			BPF_STX_MEM(BPF_DW, BPF_REG_7, BPF_REG_0, 0),
+			BPF_MOV64_REG(BPF_REG_4, BPF_REG_7),
+
+			BPF_EMIT_CALL(BPF_FUNC_strtoul),
+
+			/* if (ret == expected) */
+			BPF_JMP_IMM(BPF_JNE, BPF_REG_0, -EINVAL, 2),
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
+		.sysctl = "net/ipv4/route/mtu_expires",
+		.open_flags = O_RDONLY,
+		.result = SUCCESS,
+	},
+	{
+		"bpf_strtol negative number, ok",
+		.insns = {
+			/* arg1 (buf) */
+			BPF_MOV64_REG(BPF_REG_7, BPF_REG_10),
+			BPF_ALU64_IMM(BPF_ADD, BPF_REG_7, -8),
+			BPF_MOV64_IMM(BPF_REG_0, 0x00362d0a), /* " -6\0" */
+			BPF_STX_MEM(BPF_DW, BPF_REG_7, BPF_REG_0, 0),
+
+			BPF_MOV64_REG(BPF_REG_1, BPF_REG_7),
+
+			/* arg2 (buf_len) */
+			BPF_MOV64_IMM(BPF_REG_2, 4),
+
+			/* arg3 (flags) */
+			BPF_MOV64_IMM(BPF_REG_3, 10),
+
+			/* arg4 (res) */
+			BPF_ALU64_IMM(BPF_ADD, BPF_REG_7, -8),
+			BPF_STX_MEM(BPF_DW, BPF_REG_7, BPF_REG_0, 0),
+			BPF_MOV64_REG(BPF_REG_4, BPF_REG_7),
+
+			BPF_EMIT_CALL(BPF_FUNC_strtol),
+
+			/* if (ret == expected && */
+			BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 3, 4),
+			/*     res == expected) */
+			BPF_LDX_MEM(BPF_DW, BPF_REG_9, BPF_REG_7, 0),
+			BPF_JMP_IMM(BPF_JNE, BPF_REG_9, -6, 2),
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
+		.sysctl = "net/ipv4/route/mtu_expires",
+		.open_flags = O_RDONLY,
+		.result = SUCCESS,
+	},
+	{
+		"bpf_strtol hex number, ok",
+		.insns = {
+			/* arg1 (buf) */
+			BPF_MOV64_REG(BPF_REG_7, BPF_REG_10),
+			BPF_ALU64_IMM(BPF_ADD, BPF_REG_7, -8),
+			BPF_MOV64_IMM(BPF_REG_0, 0x65667830), /* "0xfe" */
+			BPF_STX_MEM(BPF_DW, BPF_REG_7, BPF_REG_0, 0),
+
+			BPF_MOV64_REG(BPF_REG_1, BPF_REG_7),
+
+			/* arg2 (buf_len) */
+			BPF_MOV64_IMM(BPF_REG_2, 4),
+
+			/* arg3 (flags) */
+			BPF_MOV64_IMM(BPF_REG_3, 0),
+
+			/* arg4 (res) */
+			BPF_ALU64_IMM(BPF_ADD, BPF_REG_7, -8),
+			BPF_STX_MEM(BPF_DW, BPF_REG_7, BPF_REG_0, 0),
+			BPF_MOV64_REG(BPF_REG_4, BPF_REG_7),
+
+			BPF_EMIT_CALL(BPF_FUNC_strtol),
+
+			/* if (ret == expected && */
+			BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 4, 4),
+			/*     res == expected) */
+			BPF_LDX_MEM(BPF_DW, BPF_REG_9, BPF_REG_7, 0),
+			BPF_JMP_IMM(BPF_JNE, BPF_REG_9, 254, 2),
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
+		.sysctl = "net/ipv4/route/mtu_expires",
+		.open_flags = O_RDONLY,
+		.result = SUCCESS,
+	},
+	{
+		"bpf_strtol max long",
+		.insns = {
+			/* arg1 (buf) 9223372036854775807 */
+			BPF_MOV64_REG(BPF_REG_7, BPF_REG_10),
+			BPF_ALU64_IMM(BPF_ADD, BPF_REG_7, -24),
+			BPF_LD_IMM64(BPF_REG_0, 0x3032373333323239ULL),
+			BPF_STX_MEM(BPF_DW, BPF_REG_7, BPF_REG_0, 0),
+			BPF_LD_IMM64(BPF_REG_0, 0x3537373435383633ULL),
+			BPF_STX_MEM(BPF_DW, BPF_REG_7, BPF_REG_0, 8),
+			BPF_LD_IMM64(BPF_REG_0, 0x0000000000373038ULL),
+			BPF_STX_MEM(BPF_DW, BPF_REG_7, BPF_REG_0, 16),
+
+			BPF_MOV64_REG(BPF_REG_1, BPF_REG_7),
+
+			/* arg2 (buf_len) */
+			BPF_MOV64_IMM(BPF_REG_2, 19),
+
+			/* arg3 (flags) */
+			BPF_MOV64_IMM(BPF_REG_3, 0),
+
+			/* arg4 (res) */
+			BPF_ALU64_IMM(BPF_ADD, BPF_REG_7, -8),
+			BPF_STX_MEM(BPF_DW, BPF_REG_7, BPF_REG_0, 0),
+			BPF_MOV64_REG(BPF_REG_4, BPF_REG_7),
+
+			BPF_EMIT_CALL(BPF_FUNC_strtol),
+
+			/* if (ret == expected && */
+			BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 19, 6),
+			/*     res == expected) */
+			BPF_LD_IMM64(BPF_REG_8, 0x7fffffffffffffffULL),
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
+		.sysctl = "net/ipv4/route/mtu_expires",
+		.open_flags = O_RDONLY,
+		.result = SUCCESS,
+	},
+	{
+		"bpf_strtol overflow, ERANGE",
+		.insns = {
+			/* arg1 (buf) 9223372036854775808 */
+			BPF_MOV64_REG(BPF_REG_7, BPF_REG_10),
+			BPF_ALU64_IMM(BPF_ADD, BPF_REG_7, -24),
+			BPF_LD_IMM64(BPF_REG_0, 0x3032373333323239ULL),
+			BPF_STX_MEM(BPF_DW, BPF_REG_7, BPF_REG_0, 0),
+			BPF_LD_IMM64(BPF_REG_0, 0x3537373435383633ULL),
+			BPF_STX_MEM(BPF_DW, BPF_REG_7, BPF_REG_0, 8),
+			BPF_LD_IMM64(BPF_REG_0, 0x0000000000383038ULL),
+			BPF_STX_MEM(BPF_DW, BPF_REG_7, BPF_REG_0, 16),
+
+			BPF_MOV64_REG(BPF_REG_1, BPF_REG_7),
+
+			/* arg2 (buf_len) */
+			BPF_MOV64_IMM(BPF_REG_2, 19),
+
+			/* arg3 (flags) */
+			BPF_MOV64_IMM(BPF_REG_3, 0),
+
+			/* arg4 (res) */
+			BPF_ALU64_IMM(BPF_ADD, BPF_REG_7, -8),
+			BPF_STX_MEM(BPF_DW, BPF_REG_7, BPF_REG_0, 0),
+			BPF_MOV64_REG(BPF_REG_4, BPF_REG_7),
+
+			BPF_EMIT_CALL(BPF_FUNC_strtol),
+
+			/* if (ret == expected) */
+			BPF_JMP_IMM(BPF_JNE, BPF_REG_0, -ERANGE, 2),
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
+		.sysctl = "net/ipv4/route/mtu_expires",
+		.open_flags = O_RDONLY,
+		.result = SUCCESS,
+	},
 };
 
 static size_t probe_prog_length(const struct bpf_insn *fp)
-- 
2.17.1

