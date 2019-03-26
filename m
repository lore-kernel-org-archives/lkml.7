Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCC9CC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 00:48:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90F182075D
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 00:48:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="mFrsXwTF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730649AbfCZAsb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 20:48:31 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:54300 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727501AbfCZAsa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 20:48:30 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.27/8.16.0.27) with SMTP id x2Q0mE3A024961
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 17:48:29 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=Myil2ba+E2pkq2/jD17tcUuCboQ84Sa9IA+VNfehhnY=;
 b=mFrsXwTFOsgvkhh3OYkNHMjjHvwKCKGtZvj9ZFtAWXpYFdS//LvbGvfcJ9JRUoLBnd2B
 A9xqy8FmhgdrC69YlwLrIqEMZ2Wee0HpFp70CRvGkJe5//u1TPy99+KWcYrkQGP7CcS5
 3h1GvPjcAEPQnyCuESmQ8Dd9VufMaI6g+Pw= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by m0001303.ppops.net with ESMTP id 2rf14y2g97-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 17:48:29 -0700
Received: from mx-out.facebook.com (2620:10d:c0a1:3::13) by
 mail.thefacebook.com (2620:10d:c021:18::171) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5;
 Mon, 25 Mar 2019 17:48:28 -0700
Received: by dev082.prn2.facebook.com (Postfix, from userid 572249)
        id 5FF283703672; Mon, 25 Mar 2019 17:48:27 -0700 (PDT)
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
Subject: [PATCH v2 bpf-next 13/21] selftests/bpf: Test bpf_sysctl_{get,set}_new_value helpers
Date:   Mon, 25 Mar 2019 17:43:39 -0700
Message-ID: <84d3819c51f2c100ab5064f5752a2ee2862fea87.1553560621.git.rdna@fb.com>
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

Test that new value provided by user space on sysctl write can be read
by bpf_sysctl_get_new_value and overridden by bpf_sysctl_set_new_value.

  # ./test_sysctl
  ...
  Test case: sysctl_get_new_value sysctl:read EINVAL .. [PASS]
  Test case: sysctl_get_new_value sysctl:write ok .. [PASS]
  Test case: sysctl_get_new_value sysctl:write ok long .. [PASS]
  Test case: sysctl_get_new_value sysctl:write E2BIG .. [PASS]
  Test case: sysctl_set_new_value sysctl:read EINVAL .. [PASS]
  Test case: sysctl_set_new_value sysctl:write ok .. [PASS]
  Summary: 22 PASSED, 0 FAILED

Signed-off-by: Andrey Ignatov <rdna@fb.com>
---
 tools/testing/selftests/bpf/test_sysctl.c | 222 ++++++++++++++++++++++
 1 file changed, 222 insertions(+)

diff --git a/tools/testing/selftests/bpf/test_sysctl.c b/tools/testing/selftests/bpf/test_sysctl.c
index 9fb6560fa775..95437b72404f 100644
--- a/tools/testing/selftests/bpf/test_sysctl.c
+++ b/tools/testing/selftests/bpf/test_sysctl.c
@@ -536,6 +536,228 @@ static struct sysctl_test tests[] = {
 		.newval = "600", /* same as default, should fail anyway */
 		.result = OP_EPERM,
 	},
+	{
+		.descr = "sysctl_get_new_value sysctl:read EINVAL",
+		.insns = {
+			/* sysctl_get_new_value arg2 (buf) */
+			BPF_MOV64_REG(BPF_REG_7, BPF_REG_10),
+			BPF_ALU64_IMM(BPF_ADD, BPF_REG_7, -8),
+			BPF_MOV64_IMM(BPF_REG_0, 0),
+			BPF_STX_MEM(BPF_DW, BPF_REG_7, BPF_REG_0, 0),
+
+			BPF_MOV64_REG(BPF_REG_2, BPF_REG_7),
+
+			/* sysctl_get_new_value arg3 (buf_len) */
+			BPF_MOV64_IMM(BPF_REG_3, 8),
+
+			/* sysctl_get_new_value(ctx, buf, buf_len) */
+			BPF_EMIT_CALL(BPF_FUNC_sysctl_get_new_value),
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
+		.sysctl = "net/ipv4/tcp_mem",
+		.open_flags = O_RDONLY,
+		.result = SUCCESS,
+	},
+	{
+		.descr = "sysctl_get_new_value sysctl:write ok",
+		.insns = {
+			/* sysctl_get_new_value arg2 (buf) */
+			BPF_MOV64_REG(BPF_REG_7, BPF_REG_10),
+			BPF_ALU64_IMM(BPF_ADD, BPF_REG_7, -8),
+
+			BPF_MOV64_REG(BPF_REG_2, BPF_REG_7),
+
+			/* sysctl_get_new_value arg3 (buf_len) */
+			BPF_MOV64_IMM(BPF_REG_3, 4),
+
+			/* sysctl_get_new_value(ctx, buf, buf_len) */
+			BPF_EMIT_CALL(BPF_FUNC_sysctl_get_new_value),
+
+			/* if (ret == expected && */
+			BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 3, 4),
+
+			/*     buf[0:4] == "606\0") */
+			BPF_LDX_MEM(BPF_W, BPF_REG_9, BPF_REG_7, 0),
+			BPF_JMP_IMM(BPF_JNE, BPF_REG_9, 0x00363036, 2),
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
+		.newval = "606",
+		.result = OP_EPERM,
+	},
+	{
+		.descr = "sysctl_get_new_value sysctl:write ok long",
+		.insns = {
+			/* sysctl_get_new_value arg2 (buf) */
+			BPF_MOV64_REG(BPF_REG_7, BPF_REG_10),
+			BPF_ALU64_IMM(BPF_ADD, BPF_REG_7, -24),
+
+			BPF_MOV64_REG(BPF_REG_2, BPF_REG_7),
+
+			/* sysctl_get_new_value arg3 (buf_len) */
+			BPF_MOV64_IMM(BPF_REG_3, 24),
+
+			/* sysctl_get_new_value(ctx, buf, buf_len) */
+			BPF_EMIT_CALL(BPF_FUNC_sysctl_get_new_value),
+
+			/* if (ret == expected && */
+			BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 23, 14),
+
+			/*     buf[0:8] == "3000000 " && */
+			BPF_LD_IMM64(BPF_REG_8, 0x2030303030303033ULL),
+			BPF_LDX_MEM(BPF_DW, BPF_REG_9, BPF_REG_7, 0),
+			BPF_JMP_REG(BPF_JNE, BPF_REG_8, BPF_REG_9, 10),
+
+			/*     buf[8:16] == "4000000 " && */
+			BPF_LD_IMM64(BPF_REG_8, 0x2030303030303034ULL),
+			BPF_LDX_MEM(BPF_DW, BPF_REG_9, BPF_REG_7, 8),
+			BPF_JMP_REG(BPF_JNE, BPF_REG_8, BPF_REG_9, 6),
+
+			/*     buf[16:24] == "6000000\0") */
+			BPF_LD_IMM64(BPF_REG_8, 0x0030303030303036ULL),
+			BPF_LDX_MEM(BPF_DW, BPF_REG_9, BPF_REG_7, 16),
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
+		.sysctl = "net/ipv4/tcp_mem",
+		.open_flags = O_WRONLY,
+		.newval = "3000000 4000000 6000000",
+		.result = OP_EPERM,
+	},
+	{
+		.descr = "sysctl_get_new_value sysctl:write E2BIG",
+		.insns = {
+			/* sysctl_get_new_value arg2 (buf) */
+			BPF_MOV64_REG(BPF_REG_7, BPF_REG_10),
+			BPF_ALU64_IMM(BPF_ADD, BPF_REG_7, -8),
+			BPF_MOV64_IMM(BPF_REG_0, 0),
+			BPF_STX_MEM(BPF_B, BPF_REG_7, BPF_REG_0, 3),
+
+			BPF_MOV64_REG(BPF_REG_2, BPF_REG_7),
+
+			/* sysctl_get_new_value arg3 (buf_len) */
+			BPF_MOV64_IMM(BPF_REG_3, 3),
+
+			/* sysctl_get_new_value(ctx, buf, buf_len) */
+			BPF_EMIT_CALL(BPF_FUNC_sysctl_get_new_value),
+
+			/* if (ret == expected && */
+			BPF_JMP_IMM(BPF_JNE, BPF_REG_0, -E2BIG, 4),
+
+			/*     buf[0:3] == "60\0") */
+			BPF_LDX_MEM(BPF_W, BPF_REG_9, BPF_REG_7, 0),
+			BPF_JMP_IMM(BPF_JNE, BPF_REG_9, 0x003036, 2),
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
+		.newval = "606",
+		.result = OP_EPERM,
+	},
+	{
+		.descr = "sysctl_set_new_value sysctl:read EINVAL",
+		.insns = {
+			/* sysctl_set_new_value arg2 (buf) */
+			BPF_MOV64_REG(BPF_REG_7, BPF_REG_10),
+			BPF_ALU64_IMM(BPF_ADD, BPF_REG_7, -8),
+			BPF_MOV64_IMM(BPF_REG_0, 0x00303036),
+			BPF_STX_MEM(BPF_DW, BPF_REG_7, BPF_REG_0, 0),
+
+			BPF_MOV64_REG(BPF_REG_2, BPF_REG_7),
+
+			/* sysctl_set_new_value arg3 (buf_len) */
+			BPF_MOV64_IMM(BPF_REG_3, 3),
+
+			/* sysctl_set_new_value(ctx, buf, buf_len) */
+			BPF_EMIT_CALL(BPF_FUNC_sysctl_set_new_value),
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
+		.descr = "sysctl_set_new_value sysctl:write ok",
+		.fixup_value_insn = 2,
+		.insns = {
+			/* sysctl_set_new_value arg2 (buf) */
+			BPF_MOV64_REG(BPF_REG_7, BPF_REG_10),
+			BPF_ALU64_IMM(BPF_ADD, BPF_REG_7, -8),
+			BPF_MOV64_IMM(BPF_REG_0, FIXUP_SYSCTL_VALUE),
+			BPF_STX_MEM(BPF_DW, BPF_REG_7, BPF_REG_0, 0),
+
+			BPF_MOV64_REG(BPF_REG_2, BPF_REG_7),
+
+			/* sysctl_set_new_value arg3 (buf_len) */
+			BPF_MOV64_IMM(BPF_REG_3, 3),
+
+			/* sysctl_set_new_value(ctx, buf, buf_len) */
+			BPF_EMIT_CALL(BPF_FUNC_sysctl_set_new_value),
+
+			/* if (ret == expected) */
+			BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 2),
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
+		.open_flags = O_WRONLY,
+		.newval = "606",
+		.result = SUCCESS,
+	},
 };
 
 static size_t probe_prog_length(const struct bpf_insn *fp)
-- 
2.17.1

