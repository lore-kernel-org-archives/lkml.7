Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7691AC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 00:49:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 376852075D
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 00:49:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="meKOOx3n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731096AbfCZAtS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 20:49:18 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:54660 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731074AbfCZAtQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 20:49:16 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2Q0jHxl031016
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 17:49:15 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=Ivsr1bvZaLONb1cCzecvgOITEbmuxhP62SpGoLjL76Y=;
 b=meKOOx3n72kTqGe5pijkaP8/b+Gb0zXKP52auCIQ04PpHXbdIeoiXJwC2lpSpEXXprft
 Z5laVd1GLwtVYZDm5CmDs77i++OjbAD1+X+SQFCu2W+FBCsiZ0VCButZ58O4issABiRJ
 G9+++WebM7yMj72w18y8EpcAjZXssxW++uQ= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2rf47k9dva-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 17:49:15 -0700
Received: from mx-out.facebook.com (2620:10d:c081:10::13) by
 mail.thefacebook.com (2620:10d:c081:35::125) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5;
 Mon, 25 Mar 2019 17:49:09 -0700
Received: by dev082.prn2.facebook.com (Postfix, from userid 572249)
        id 9CDD537036A2; Mon, 25 Mar 2019 17:49:08 -0700 (PDT)
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
Subject: [PATCH v2 bpf-next 19/21] selftests/bpf: Test ARG_PTR_TO_LONG arg type
Date:   Mon, 25 Mar 2019 17:43:45 -0700
Message-ID: <dfa816a042195c5f9995363f54352b49b28f8048.1553560621.git.rdna@fb.com>
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

Test that verifier handles new argument types properly, including
uninitialized or partially initialized value, misaligned stack access,
etc.

Example of output:
  #456/p ARG_PTR_TO_LONG uninitialized OK
  #457/p ARG_PTR_TO_LONG half-uninitialized OK
  #458/p ARG_PTR_TO_LONG misaligned OK
  #459/p ARG_PTR_TO_LONG size < sizeof(long) OK
  #460/p ARG_PTR_TO_LONG initialized OK

Signed-off-by: Andrey Ignatov <rdna@fb.com>
---
 .../testing/selftests/bpf/verifier/int_ptr.c  | 160 ++++++++++++++++++
 1 file changed, 160 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/verifier/int_ptr.c

diff --git a/tools/testing/selftests/bpf/verifier/int_ptr.c b/tools/testing/selftests/bpf/verifier/int_ptr.c
new file mode 100644
index 000000000000..ca3b4729df66
--- /dev/null
+++ b/tools/testing/selftests/bpf/verifier/int_ptr.c
@@ -0,0 +1,160 @@
+{
+	"ARG_PTR_TO_LONG uninitialized",
+	.insns = {
+		/* bpf_strtoul arg1 (buf) */
+		BPF_MOV64_REG(BPF_REG_7, BPF_REG_10),
+		BPF_ALU64_IMM(BPF_ADD, BPF_REG_7, -8),
+		BPF_MOV64_IMM(BPF_REG_0, 0x00303036),
+		BPF_STX_MEM(BPF_DW, BPF_REG_7, BPF_REG_0, 0),
+
+		BPF_MOV64_REG(BPF_REG_1, BPF_REG_7),
+
+		/* bpf_strtoul arg2 (buf_len) */
+		BPF_MOV64_IMM(BPF_REG_2, 4),
+
+		/* bpf_strtoul arg3 (flags) */
+		BPF_MOV64_IMM(BPF_REG_3, 0),
+
+		/* bpf_strtoul arg4 (res) */
+		BPF_ALU64_IMM(BPF_ADD, BPF_REG_7, -8),
+		BPF_MOV64_REG(BPF_REG_4, BPF_REG_7),
+
+		/* bpf_strtoul() */
+		BPF_EMIT_CALL(BPF_FUNC_strtoul),
+
+		BPF_MOV64_IMM(BPF_REG_0, 1),
+		BPF_EXIT_INSN(),
+	},
+	.result = REJECT,
+	.prog_type = BPF_PROG_TYPE_CGROUP_SYSCTL,
+	.errstr = "invalid indirect read from stack off -16+0 size 8",
+},
+{
+	"ARG_PTR_TO_LONG half-uninitialized",
+	.insns = {
+		/* bpf_strtoul arg1 (buf) */
+		BPF_MOV64_REG(BPF_REG_7, BPF_REG_10),
+		BPF_ALU64_IMM(BPF_ADD, BPF_REG_7, -8),
+		BPF_MOV64_IMM(BPF_REG_0, 0x00303036),
+		BPF_STX_MEM(BPF_DW, BPF_REG_7, BPF_REG_0, 0),
+
+		BPF_MOV64_REG(BPF_REG_1, BPF_REG_7),
+
+		/* bpf_strtoul arg2 (buf_len) */
+		BPF_MOV64_IMM(BPF_REG_2, 4),
+
+		/* bpf_strtoul arg3 (flags) */
+		BPF_MOV64_IMM(BPF_REG_3, 0),
+
+		/* bpf_strtoul arg4 (res) */
+		BPF_ALU64_IMM(BPF_ADD, BPF_REG_7, -8),
+		BPF_STX_MEM(BPF_W, BPF_REG_7, BPF_REG_0, 0),
+		BPF_MOV64_REG(BPF_REG_4, BPF_REG_7),
+
+		/* bpf_strtoul() */
+		BPF_EMIT_CALL(BPF_FUNC_strtoul),
+
+		BPF_MOV64_IMM(BPF_REG_0, 1),
+		BPF_EXIT_INSN(),
+	},
+	.result = REJECT,
+	.prog_type = BPF_PROG_TYPE_CGROUP_SYSCTL,
+	.errstr = "invalid indirect read from stack off -16+4 size 8",
+},
+{
+	"ARG_PTR_TO_LONG misaligned",
+	.insns = {
+		/* bpf_strtoul arg1 (buf) */
+		BPF_MOV64_REG(BPF_REG_7, BPF_REG_10),
+		BPF_ALU64_IMM(BPF_ADD, BPF_REG_7, -8),
+		BPF_MOV64_IMM(BPF_REG_0, 0x00303036),
+		BPF_STX_MEM(BPF_DW, BPF_REG_7, BPF_REG_0, 0),
+
+		BPF_MOV64_REG(BPF_REG_1, BPF_REG_7),
+
+		/* bpf_strtoul arg2 (buf_len) */
+		BPF_MOV64_IMM(BPF_REG_2, 4),
+
+		/* bpf_strtoul arg3 (flags) */
+		BPF_MOV64_IMM(BPF_REG_3, 0),
+
+		/* bpf_strtoul arg4 (res) */
+		BPF_ALU64_IMM(BPF_ADD, BPF_REG_7, -12),
+		BPF_MOV64_IMM(BPF_REG_0, 0),
+		BPF_STX_MEM(BPF_W, BPF_REG_7, BPF_REG_0, 0),
+		BPF_STX_MEM(BPF_DW, BPF_REG_7, BPF_REG_0, 4),
+		BPF_MOV64_REG(BPF_REG_4, BPF_REG_7),
+
+		/* bpf_strtoul() */
+		BPF_EMIT_CALL(BPF_FUNC_strtoul),
+
+		BPF_MOV64_IMM(BPF_REG_0, 1),
+		BPF_EXIT_INSN(),
+	},
+	.result = REJECT,
+	.prog_type = BPF_PROG_TYPE_CGROUP_SYSCTL,
+	.errstr = "misaligned stack access off (0x0; 0x0)+-20+0 size 8",
+},
+{
+	"ARG_PTR_TO_LONG size < sizeof(long)",
+	.insns = {
+		/* bpf_strtoul arg1 (buf) */
+		BPF_MOV64_REG(BPF_REG_7, BPF_REG_10),
+		BPF_ALU64_IMM(BPF_ADD, BPF_REG_7, -16),
+		BPF_MOV64_IMM(BPF_REG_0, 0x00303036),
+		BPF_STX_MEM(BPF_DW, BPF_REG_7, BPF_REG_0, 0),
+
+		BPF_MOV64_REG(BPF_REG_1, BPF_REG_7),
+
+		/* bpf_strtoul arg2 (buf_len) */
+		BPF_MOV64_IMM(BPF_REG_2, 4),
+
+		/* bpf_strtoul arg3 (flags) */
+		BPF_MOV64_IMM(BPF_REG_3, 0),
+
+		/* bpf_strtoul arg4 (res) */
+		BPF_ALU64_IMM(BPF_ADD, BPF_REG_7, 12),
+		BPF_STX_MEM(BPF_W, BPF_REG_7, BPF_REG_0, 0),
+		BPF_MOV64_REG(BPF_REG_4, BPF_REG_7),
+
+		/* bpf_strtoul() */
+		BPF_EMIT_CALL(BPF_FUNC_strtoul),
+
+		BPF_MOV64_IMM(BPF_REG_0, 1),
+		BPF_EXIT_INSN(),
+	},
+	.result = REJECT,
+	.prog_type = BPF_PROG_TYPE_CGROUP_SYSCTL,
+	.errstr = "invalid stack type R4 off=-4 access_size=8",
+},
+{
+	"ARG_PTR_TO_LONG initialized",
+	.insns = {
+		/* bpf_strtoul arg1 (buf) */
+		BPF_MOV64_REG(BPF_REG_7, BPF_REG_10),
+		BPF_ALU64_IMM(BPF_ADD, BPF_REG_7, -8),
+		BPF_MOV64_IMM(BPF_REG_0, 0x00303036),
+		BPF_STX_MEM(BPF_DW, BPF_REG_7, BPF_REG_0, 0),
+
+		BPF_MOV64_REG(BPF_REG_1, BPF_REG_7),
+
+		/* bpf_strtoul arg2 (buf_len) */
+		BPF_MOV64_IMM(BPF_REG_2, 4),
+
+		/* bpf_strtoul arg3 (flags) */
+		BPF_MOV64_IMM(BPF_REG_3, 0),
+
+		/* bpf_strtoul arg4 (res) */
+		BPF_ALU64_IMM(BPF_ADD, BPF_REG_7, -8),
+		BPF_STX_MEM(BPF_DW, BPF_REG_7, BPF_REG_0, 0),
+		BPF_MOV64_REG(BPF_REG_4, BPF_REG_7),
+
+		/* bpf_strtoul() */
+		BPF_EMIT_CALL(BPF_FUNC_strtoul),
+
+		BPF_MOV64_IMM(BPF_REG_0, 1),
+		BPF_EXIT_INSN(),
+	},
+	.result = ACCEPT,
+	.prog_type = BPF_PROG_TYPE_CGROUP_SYSCTL,
+},
-- 
2.17.1

