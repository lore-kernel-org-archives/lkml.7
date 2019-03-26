Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA40FC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 00:49:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89A9C2075D
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 00:49:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="iPOE2l4+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727329AbfCZAtD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 20:49:03 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:44388 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730643AbfCZAsd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 20:48:33 -0400
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2Q0gjaM028203
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 17:48:32 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=4VrPtQnEt3D3vdcprFfLTA17V/fa01Rm50bzi1Imjrg=;
 b=iPOE2l4+W3+6IHx7E4eJ1joHCjQfkhRjEvneWNgJmMCQC5iTezbMp0d//nrDnvKt8dSK
 9JYGFaLSlgiHUb0W3LAmSoFHMyRTCfvsVPfx1rywD1g2Xn7d6nucJT/Fm/rjfW1iTK6g
 THdLeHH8tIQqr7evcUAl2iFfg4pA/AKnO+I= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2rf9m0r1hg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 17:48:32 -0700
Received: from mx-out.facebook.com (2620:10d:c081:10::13) by
 mail.thefacebook.com (2620:10d:c081:35::126) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5;
 Mon, 25 Mar 2019 17:48:31 -0700
Received: by dev082.prn2.facebook.com (Postfix, from userid 572249)
        id F358237036A2; Mon, 25 Mar 2019 17:48:30 -0700 (PDT)
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
Subject: [PATCH v2 bpf-next 14/21] selftests/bpf: Test file_pos field in bpf_sysctl ctx
Date:   Mon, 25 Mar 2019 17:43:40 -0700
Message-ID: <e0962475f4258c0903c253a9451545904c440b95.1553560621.git.rdna@fb.com>
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

Test access to file_pos field of bpf_sysctl context, both read (incl.
narrow read) and write.

  # ./test_sysctl
  ...
  Test case: ctx:file_pos sysctl:read read ok .. [PASS]
  Test case: ctx:file_pos sysctl:read read ok narrow .. [PASS]
  Test case: ctx:file_pos sysctl:read write ok .. [PASS]
  ...

Signed-off-by: Andrey Ignatov <rdna@fb.com>
---
 tools/testing/selftests/bpf/test_sysctl.c | 64 +++++++++++++++++++++++
 1 file changed, 64 insertions(+)

diff --git a/tools/testing/selftests/bpf/test_sysctl.c b/tools/testing/selftests/bpf/test_sysctl.c
index 95437b72404f..43008aae32d3 100644
--- a/tools/testing/selftests/bpf/test_sysctl.c
+++ b/tools/testing/selftests/bpf/test_sysctl.c
@@ -30,6 +30,7 @@ struct sysctl_test {
 	const char *sysctl;
 	int open_flags;
 	const char *newval;
+	const char *oldval;
 	enum {
 		LOAD_REJECT,
 		ATTACH_REJECT,
@@ -130,6 +131,64 @@ static struct sysctl_test tests[] = {
 		.open_flags = O_RDONLY,
 		.result = LOAD_REJECT,
 	},
+	{
+		.descr = "ctx:file_pos sysctl:read read ok",
+		.insns = {
+			/* If (file_pos == X) */
+			BPF_LDX_MEM(BPF_W, BPF_REG_7, BPF_REG_1,
+				    offsetof(struct bpf_sysctl, file_pos)),
+			BPF_JMP_IMM(BPF_JNE, BPF_REG_7, 0, 2),
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
+		.descr = "ctx:file_pos sysctl:read read ok narrow",
+		.insns = {
+			/* If (file_pos == X) */
+			BPF_LDX_MEM(BPF_B, BPF_REG_7, BPF_REG_1,
+				    offsetof(struct bpf_sysctl, file_pos)),
+			BPF_JMP_IMM(BPF_JNE, BPF_REG_7, 0, 2),
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
+		.descr = "ctx:file_pos sysctl:read write ok",
+		.insns = {
+			/* file_pos = X */
+			BPF_MOV64_IMM(BPF_REG_0, 2),
+			BPF_STX_MEM(BPF_W, BPF_REG_1, BPF_REG_0,
+				    offsetof(struct bpf_sysctl, file_pos)),
+			BPF_MOV64_IMM(BPF_REG_0, 1),
+			BPF_EXIT_INSN(),
+		},
+		.attach_type = BPF_CGROUP_SYSCTL,
+		.sysctl = "kernel/ostype",
+		.open_flags = O_RDONLY,
+		.oldval = "nux\n",
+		.result = SUCCESS,
+	},
 	{
 		.descr = "sysctl_get_name sysctl_value:base ok",
 		.insns = {
@@ -848,6 +907,11 @@ static int access_sysctl(const char *sysctl_path,
 
 		if (read(fd, buf, sizeof(buf)) == -1)
 			goto err;
+		if (test->oldval &&
+		    strncmp(buf, test->oldval, strlen(test->oldval))) {
+			log_err("Read value %s != %s", buf, test->oldval);
+			goto err;
+		}
 	} else if (test->open_flags == O_WRONLY) {
 		if (!test->newval) {
 			log_err("New value for sysctl is not set");
-- 
2.17.1

