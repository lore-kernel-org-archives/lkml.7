Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25A01C282DA
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 19:38:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6B382146F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 19:38:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="ItVFlieI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731985AbfDETgy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 15:36:54 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:53430 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731904AbfDETgv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 15:36:51 -0400
Received: from pps.filterd (m0044008.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x35JaZiu001683
        for <linux-kernel@vger.kernel.org>; Fri, 5 Apr 2019 12:36:50 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=clCvtB27loPFKIXw2dF+DIT7A6l5dTRKzIuFge6QA/I=;
 b=ItVFlieI3Dxv+aZTk+HY0qSyg83jrXybt1dj8r7uYyzS6Vt0sS/b4SYOZZNWGzeDYeX3
 8Gix95ObzW4nZpTCy/9Po29dyqmLbnepMDf164z5B7telFqD7g8e3BM/9J7H+9FBxBj+
 o5E/UV3jPMxM7yalctOw/zS6lkE5wyzIsps= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2rp890h8pw-19
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2019 12:36:50 -0700
Received: from mx-out.facebook.com (2620:10d:c0a1:3::13) by
 mail.thefacebook.com (2620:10d:c021:18::173) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5;
 Fri, 5 Apr 2019 12:36:38 -0700
Received: by dev082.prn2.facebook.com (Postfix, from userid 572249)
        id 745103701752; Fri,  5 Apr 2019 12:36:36 -0700 (PDT)
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
Subject: [PATCH v3 bpf-next 07/21] bpf: Sync bpf.h to tools/
Date:   Fri, 5 Apr 2019 12:35:29 -0700
Message-ID: <702fe4b9a2b32e69afe07d2f29be18b0c2f31c5c.1554485409.git.rdna@fb.com>
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

Sync BPF_PROG_TYPE_CGROUP_SYSCTL related bpf UAPI changes to tools/.

Signed-off-by: Andrey Ignatov <rdna@fb.com>
---
 tools/include/uapi/linux/bpf.h | 90 +++++++++++++++++++++++++++++++++-
 1 file changed, 89 insertions(+), 1 deletion(-)

diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 837024512baf..01faa286bb3c 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -166,6 +166,7 @@ enum bpf_prog_type {
 	BPF_PROG_TYPE_LIRC_MODE2,
 	BPF_PROG_TYPE_SK_REUSEPORT,
 	BPF_PROG_TYPE_FLOW_DISSECTOR,
+	BPF_PROG_TYPE_CGROUP_SYSCTL,
 };
 
 enum bpf_attach_type {
@@ -187,6 +188,7 @@ enum bpf_attach_type {
 	BPF_CGROUP_UDP6_SENDMSG,
 	BPF_LIRC_MODE2,
 	BPF_FLOW_DISSECTOR,
+	BPF_CGROUP_SYSCTL,
 	__MAX_BPF_ATTACH_TYPE
 };
 
@@ -2477,6 +2479,75 @@ union bpf_attr {
  * 	Return
  * 		0 if iph and th are a valid SYN cookie ACK, or a negative error
  * 		otherwise.
+ *
+ * int bpf_sysctl_get_name(struct bpf_sysctl *ctx, char *buf, size_t buf_len, u64 flags)
+ *	Description
+ *		Get name of sysctl in /proc/sys/ and copy it into provided by
+ *		program buffer *buf* of size *buf_len*.
+ *
+ *		The buffer is always NUL terminated, unless it's zero-sized.
+ *
+ *		If *flags* is zero, full name (e.g. "net/ipv4/tcp_mem") is
+ *		copied. Use **BPF_F_SYSCTL_BASE_NAME** flag to copy base name
+ *		only (e.g. "tcp_mem").
+ *	Return
+ *		Number of character copied (not including the trailing NUL).
+ *
+ *		**-E2BIG** if the buffer wasn't big enough (*buf* will contain
+ *		truncated name in this case).
+ *
+ * int bpf_sysctl_get_current_value(struct bpf_sysctl *ctx, char *buf, size_t buf_len)
+ *	Description
+ *		Get current value of sysctl as it is presented in /proc/sys
+ *		(incl. newline, etc), and copy it as a string into provided
+ *		by program buffer *buf* of size *buf_len*.
+ *
+ *		The whole value is copied, no matter what file position user
+ *		space issued e.g. sys_read at.
+ *
+ *		The buffer is always NUL terminated, unless it's zero-sized.
+ *	Return
+ *		Number of character copied (not including the trailing NUL).
+ *
+ *		**-E2BIG** if the buffer wasn't big enough (*buf* will contain
+ *		truncated name in this case).
+ *
+ *		**-EINVAL** if current value was unavailable, e.g. because
+ *		sysctl is uninitialized and read returns -EIO for it.
+ *
+ * int bpf_sysctl_get_new_value(struct bpf_sysctl *ctx, char *buf, size_t buf_len)
+ *	Description
+ *		Get new value being written by user space to sysctl (before
+ *		the actual write happens) and copy it as a string into
+ *		provided by program buffer *buf* of size *buf_len*.
+ *
+ *		User space may write new value at file position > 0.
+ *
+ *		The buffer is always NUL terminated, unless it's zero-sized.
+ *	Return
+ *		Number of character copied (not including the trailing NUL).
+ *
+ *		**-E2BIG** if the buffer wasn't big enough (*buf* will contain
+ *		truncated name in this case).
+ *
+ *		**-EINVAL** if sysctl is being read.
+ *
+ * int bpf_sysctl_set_new_value(struct bpf_sysctl *ctx, const char *buf, size_t buf_len)
+ *	Description
+ *		Override new value being written by user space to sysctl with
+ *		value provided by program in buffer *buf* of size *buf_len*.
+ *
+ *		*buf* should contain a string in same form as provided by user
+ *		space on sysctl write.
+ *
+ *		User space may write new value at file position > 0. To override
+ *		the whole sysctl value file position should be set to zero.
+ *	Return
+ *		0 on success.
+ *
+ *		**-E2BIG** if the *buf_len* is too big.
+ *
+ *		**-EINVAL** if sysctl is being read.
  */
 #define __BPF_FUNC_MAPPER(FN)		\
 	FN(unspec),			\
@@ -2579,7 +2650,11 @@ union bpf_attr {
 	FN(skb_ecn_set_ce),		\
 	FN(get_listener_sock),		\
 	FN(skc_lookup_tcp),		\
-	FN(tcp_check_syncookie),
+	FN(tcp_check_syncookie),	\
+	FN(sysctl_get_name),		\
+	FN(sysctl_get_current_value),	\
+	FN(sysctl_get_new_value),	\
+	FN(sysctl_set_new_value),
 
 /* integer value in 'imm' field of BPF_CALL instruction selects which helper
  * function eBPF program intends to call
@@ -2646,6 +2721,9 @@ enum bpf_func_id {
 #define BPF_F_ADJ_ROOM_ENCAP_L4_GRE	(1ULL << 3)
 #define BPF_F_ADJ_ROOM_ENCAP_L4_UDP	(1ULL << 4)
 
+/* BPF_FUNC_sysctl_get_name flags. */
+#define BPF_F_SYSCTL_BASE_NAME		(1ULL << 0)
+
 /* Mode for BPF_FUNC_skb_adjust_room helper. */
 enum bpf_adj_room_mode {
 	BPF_ADJ_ROOM_NET,
@@ -3275,4 +3353,14 @@ struct bpf_line_info {
 struct bpf_spin_lock {
 	__u32	val;
 };
+
+struct bpf_sysctl {
+	__u32	write;		/* Sysctl is being read (= 0) or written (= 1).
+				 * Allows 1,2,4-byte read, but no write.
+				 */
+	__u32	file_pos;	/* Sysctl file position to read from, write to.
+				 * Allows 1,2,4-byte read an 4-byte write.
+				 */
+};
+
 #endif /* _UAPI__LINUX_BPF_H__ */
-- 
2.17.1

