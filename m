Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04FA9C43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 18:50:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDF8820B7C
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 18:50:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="Ez00x6Sf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726544AbfDZSui (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 14:50:38 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:46732 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726271AbfDZSui (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 14:50:38 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3QInm9q031543;
        Fri, 26 Apr 2019 11:50:16 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=facebook;
 bh=WPnoSl3ovZQ7FETcrkS1cZGMTC6OLbnm2YddtLDJ4As=;
 b=Ez00x6Sf0AexFdeevTJ3lzNZdZ5BnQqyLg9ByOlljBuHaVz2hErayOIKf4rnYMy9TT+H
 PPuleOlNQ2tBGUIdJ4kZj1Tuy8k6d4/iKyVgOO7MMeik2cKiffzFN0ZrZZcOk+V2EdEt
 4YBdkNWrUhH0Nb5SV1siXMA4MH08JCpuZvM= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2s3yc5hn4k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 26 Apr 2019 11:50:16 -0700
Received: from mmullins-1.thefacebook.com (2620:10d:c081:10::13) by
 mail.thefacebook.com (2620:10d:c081:35::125) with Microsoft SMTP Server id
 15.1.1713.5; Fri, 26 Apr 2019 11:50:15 -0700
From:   Matt Mullins <mmullins@fb.com>
To:     <hall@fb.com>, <mmullins@fb.com>, <ast@kernel.org>,
        <bpf@vger.kernel.org>, <netdev@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, "Yonghong Song" <yhs@fb.com>,
        Andrey Ignatov <rdna@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Quentin Monnet <quentin.monnet@netronome.com>
Subject: [PATCH bpf-next v5 4/5] tools: sync bpf.h
Date:   Fri, 26 Apr 2019 11:49:50 -0700
Message-ID: <20190426184951.21812-5-mmullins@fb.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190426184951.21812-1-mmullins@fb.com>
References: <20190426184951.21812-1-mmullins@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [2620:10d:c081:10::13]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-26_12:,,
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
Acked-by: Yonghong Song <yhs@fb.com>
---
 tools/include/uapi/linux/bpf.h | 10 +++++++++-
 tools/lib/bpf/libbpf.c         |  1 +
 tools/lib/bpf/libbpf_probes.c  |  1 +
 3 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 704bb69514a2..f7fa7a34a62d 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -168,6 +168,7 @@ enum bpf_prog_type {
 	BPF_PROG_TYPE_SK_REUSEPORT,
 	BPF_PROG_TYPE_FLOW_DISSECTOR,
 	BPF_PROG_TYPE_CGROUP_SYSCTL,
+	BPF_PROG_TYPE_RAW_TRACEPOINT_WRITABLE,
 };
 
 enum bpf_attach_type {
@@ -1737,12 +1738,19 @@ union bpf_attr {
  * 		error if an eBPF program tries to set a callback that is not
  * 		supported in the current kernel.
  *
- * 		The supported callback values that *argval* can combine are:
+ * 		*argval* is a flag array which can combine these flags:
  *
  * 		* **BPF_SOCK_OPS_RTO_CB_FLAG** (retransmission time out)
  * 		* **BPF_SOCK_OPS_RETRANS_CB_FLAG** (retransmission)
  * 		* **BPF_SOCK_OPS_STATE_CB_FLAG** (TCP state change)
  *
+ * 		Therefore, this function can be used to clear a callback flag by
+ * 		setting the appropriate bit to zero. e.g. to disable the RTO
+ * 		callback:
+ *
+ * 		**bpf_sock_ops_cb_flags_set(bpf_sock,**
+ * 			**bpf_sock->bpf_sock_ops_cb_flags & ~BPF_SOCK_OPS_RTO_CB_FLAG)**
+ *
  * 		Here are some examples of where one could call such eBPF
  * 		program:
  *
diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 9052061ba7fc..11a65db4b93f 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -2136,6 +2136,7 @@ static bool bpf_prog_type__needs_kver(enum bpf_prog_type type)
 	case BPF_PROG_TYPE_UNSPEC:
 	case BPF_PROG_TYPE_TRACEPOINT:
 	case BPF_PROG_TYPE_RAW_TRACEPOINT:
+	case BPF_PROG_TYPE_RAW_TRACEPOINT_WRITABLE:
 	case BPF_PROG_TYPE_PERF_EVENT:
 	case BPF_PROG_TYPE_CGROUP_SYSCTL:
 		return false;
diff --git a/tools/lib/bpf/libbpf_probes.c b/tools/lib/bpf/libbpf_probes.c
index 0f25541632e3..80ee922f290c 100644
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

