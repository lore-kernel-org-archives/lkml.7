Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9B64C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 00:47:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98F972075D
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 00:47:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="i90g7W47"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730691AbfCZArD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 20:47:03 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:44092 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727157AbfCZArD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 20:47:03 -0400
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2Q0gm9n028214
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 17:47:01 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=LqoNkyxn56eVAax1rKXdZxQVND7mNDAx0heeuE74jV4=;
 b=i90g7W475QHKRW1yXmjxx0+U8Ku4r8gl5EGStgn4CvJjfXOjX564DCmPU9rXVkbzLbsh
 HWlzoLBIrYOhc2/0ALIw1pln0ItCsCY8dFYGTNcmDwL1Cs/Y9qpuc3hUwpSmIvWl0EFE
 qMe4XXoLgnXiwJE+mxO1FHdf0FwG3doo+Eo= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2rf9m0r1d2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 17:47:01 -0700
Received: from mx-out.facebook.com (2620:10d:c0a1:3::13) by
 mail.thefacebook.com (2620:10d:c021:18::174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5;
 Mon, 25 Mar 2019 17:47:01 -0700
Received: by dev082.prn2.facebook.com (Postfix, from userid 572249)
        id 229673703672; Mon, 25 Mar 2019 17:47:00 -0700 (PDT)
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
Subject: [PATCH v2 bpf-next 08/21] libbpf: Support sysctl hook
Date:   Mon, 25 Mar 2019 17:43:34 -0700
Message-ID: <18239b9f9a93233b129be5145c1a2e80751c25fa.1553560621.git.rdna@fb.com>
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

Support BPF_PROG_TYPE_CGROUP_SYSCTL program in libbpf: identifying
program and attach types by section name, probe.

Signed-off-by: Andrey Ignatov <rdna@fb.com>
---
 tools/lib/bpf/libbpf.c        | 3 +++
 tools/lib/bpf/libbpf_probes.c | 1 +
 2 files changed, 4 insertions(+)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 5e977d2688da..70900012eb8c 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -1689,6 +1689,7 @@ static bool bpf_prog_type__needs_kver(enum bpf_prog_type type)
 	case BPF_PROG_TYPE_TRACEPOINT:
 	case BPF_PROG_TYPE_RAW_TRACEPOINT:
 	case BPF_PROG_TYPE_PERF_EVENT:
+	case BPF_PROG_TYPE_CGROUP_SYSCTL:
 		return false;
 	case BPF_PROG_TYPE_KPROBE:
 	default:
@@ -2626,6 +2627,8 @@ static const struct {
 						BPF_CGROUP_UDP4_SENDMSG),
 	BPF_EAPROG_SEC("cgroup/sendmsg6",	BPF_PROG_TYPE_CGROUP_SOCK_ADDR,
 						BPF_CGROUP_UDP6_SENDMSG),
+	BPF_EAPROG_SEC("cgroup/sysctl",		BPF_PROG_TYPE_CGROUP_SYSCTL,
+						BPF_CGROUP_SYSCTL),
 };
 
 #undef BPF_PROG_SEC_IMPL
diff --git a/tools/lib/bpf/libbpf_probes.c b/tools/lib/bpf/libbpf_probes.c
index 8c3a1c04dcb2..0f25541632e3 100644
--- a/tools/lib/bpf/libbpf_probes.c
+++ b/tools/lib/bpf/libbpf_probes.c
@@ -97,6 +97,7 @@ probe_load(enum bpf_prog_type prog_type, const struct bpf_insn *insns,
 	case BPF_PROG_TYPE_LIRC_MODE2:
 	case BPF_PROG_TYPE_SK_REUSEPORT:
 	case BPF_PROG_TYPE_FLOW_DISSECTOR:
+	case BPF_PROG_TYPE_CGROUP_SYSCTL:
 	default:
 		break;
 	}
-- 
2.17.1

