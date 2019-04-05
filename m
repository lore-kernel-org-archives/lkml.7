Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDECDC282CE
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 23:56:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADA7720B1F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 23:56:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="CPLzAUnK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726606AbfDEX4p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 19:56:45 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:47600 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725973AbfDEX4l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 19:56:41 -0400
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x35Nsnxo022650;
        Fri, 5 Apr 2019 16:56:18 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=facebook;
 bh=tCTVtGQN9fNMBhQBg/1ZtHa/rhayiJ6+l+OhZ3BsKwc=;
 b=CPLzAUnK/96rKk1LZMe4UK4PZ6BcM5MBRyqYBBSGxXEKN+/HYnkwBHId6GeqrU0VVAlF
 V1wv8LkHNxa7Y+7EmhXe3EutfEgeJkkyN/Mq87SpqTmA1swvAI77JS75bZQsK5OBn09n
 UFE4VIQraNqBEk5REKTqRY59YWcPzLDywkg= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2rp9r5hnpf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 05 Apr 2019 16:56:18 -0700
Received: from mmullins-1.thefacebook.com (2620:10d:c0a1:3::13) by
 mail.thefacebook.com (2620:10d:c021:18::176) with Microsoft SMTP Server id
 15.1.1713.5; Fri, 5 Apr 2019 16:56:15 -0700
From:   Matt Mullins <mmullins@fb.com>
To:     <hall@fb.com>, <mmullins@fb.com>, <ast@kernel.org>,
        <bpf@vger.kernel.org>, <netdev@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, "Yonghong Song" <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Andrey Ignatov <rdna@fb.com>,
        Quentin Monnet <quentin.monnet@netronome.com>
Subject: [PATCH bpf-next v2 4/5] tools: sync bpf.h
Date:   Fri, 5 Apr 2019 16:55:05 -0700
Message-ID: <20190405235506.29236-5-mmullins@fb.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190405235506.29236-1-mmullins@fb.com>
References: <20190405235506.29236-1-mmullins@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [2620:10d:c0a1:3::13]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-05_17:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds BPF_PROG_TYPE_RAW_TRACEPOINT_WRITABLE, and fixes up the

	error: enumeration value ‘BPF_PROG_TYPE_RAW_TRACEPOINT_WRITABLE’ not handled in switch [-Werror=switch-enum]

build errors it would otherwise cause in libbpf.

Signed-off-by: Matt Mullins <mmullins@fb.com>
---
 tools/include/uapi/linux/bpf.h | 1 +
 tools/lib/bpf/libbpf.c         | 1 +
 tools/lib/bpf/libbpf_probes.c  | 1 +
 3 files changed, 3 insertions(+)

diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 3c38ac9a92a7..c5335d53ce82 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -166,6 +166,7 @@ enum bpf_prog_type {
 	BPF_PROG_TYPE_LIRC_MODE2,
 	BPF_PROG_TYPE_SK_REUSEPORT,
 	BPF_PROG_TYPE_FLOW_DISSECTOR,
+	BPF_PROG_TYPE_RAW_TRACEPOINT_WRITABLE,
 };
 
 enum bpf_attach_type {
diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index d5b830d60601..9b6ce703c057 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -1681,6 +1681,7 @@ static bool bpf_prog_type__needs_kver(enum bpf_prog_type type)
 	case BPF_PROG_TYPE_UNSPEC:
 	case BPF_PROG_TYPE_TRACEPOINT:
 	case BPF_PROG_TYPE_RAW_TRACEPOINT:
+	case BPF_PROG_TYPE_RAW_TRACEPOINT_WRITABLE:
 	case BPF_PROG_TYPE_PERF_EVENT:
 		return false;
 	case BPF_PROG_TYPE_KPROBE:
diff --git a/tools/lib/bpf/libbpf_probes.c b/tools/lib/bpf/libbpf_probes.c
index 8c3a1c04dcb2..26eff2f39bed 100644
--- a/tools/lib/bpf/libbpf_probes.c
+++ b/tools/lib/bpf/libbpf_probes.c
@@ -93,6 +93,7 @@ probe_load(enum bpf_prog_type prog_type, const struct bpf_insn *insns,
 	case BPF_PROG_TYPE_CGROUP_DEVICE:
 	case BPF_PROG_TYPE_SK_MSG:
 	case BPF_PROG_TYPE_RAW_TRACEPOINT:
+	case BPF_PROG_TYPE_RAW_TRACEPOINT_WRITABLE:
 	case BPF_PROG_TYPE_LWT_SEG6LOCAL:
 	case BPF_PROG_TYPE_LIRC_MODE2:
 	case BPF_PROG_TYPE_SK_REUSEPORT:
-- 
2.17.1

