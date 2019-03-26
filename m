Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7785CC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 00:48:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34AE82080F
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 00:48:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="CDyGMwo+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731063AbfCZAsx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 20:48:53 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:54916 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731029AbfCZAsr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 20:48:47 -0400
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2Q0goI7004068
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 17:48:46 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=DVgzsoFj87a97O+a8RXuJU2j5PZE9mdCuHqKcYdFeTk=;
 b=CDyGMwo+3Qp3PE4ZIks0nNf6/ZBgYAx4m6ar28kipdqTsf6TBh2qqAclFN72saZbskSm
 bFNQH+FYkiM6f1OstuRXQCcJw6hFLgFKAFog6xwdhb0VWGqgskJ25A4WbXdgKMZd5HPs
 uMb15jsk59NGyqa7oHYcLE+0Ic0pFYnCe0g= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2rf79egjv3-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 17:48:46 -0700
Received: from mx-out.facebook.com (2620:10d:c081:10::13) by
 mail.thefacebook.com (2620:10d:c081:35::128) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5;
 Mon, 25 Mar 2019 17:48:45 -0700
Received: by dev082.prn2.facebook.com (Postfix, from userid 572249)
        id 6C15537036A2; Mon, 25 Mar 2019 17:48:44 -0700 (PDT)
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
Subject: [PATCH v2 bpf-next 17/21] bpf: Sync bpf.h to tools/
Date:   Mon, 25 Mar 2019 17:43:43 -0700
Message-ID: <baf0d5a8cc6e4f91409a0d5bc76deabf6529a455.1553560621.git.rdna@fb.com>
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

Sync bpf_strtoX related bpf UAPI changes to tools/.

Signed-off-by: Andrey Ignatov <rdna@fb.com>
---
 tools/include/uapi/linux/bpf.h | 51 +++++++++++++++++++++++++++++++++-
 1 file changed, 50 insertions(+), 1 deletion(-)

diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 01faa286bb3c..6611f5ce276c 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -2548,6 +2548,53 @@ union bpf_attr {
  *		**-E2BIG** if the *buf_len* is too big.
  *
  *		**-EINVAL** if sysctl is being read.
+ *
+ * int bpf_strtol(const char *buf, size_t buf_len, u64 flags, long *res)
+ *	Description
+ *		Convert the initial part of the string from buffer *buf* of
+ *		size *buf_len* to a long integer according to the given base
+ *		and save the result in *res*.
+ *
+ *		The string may begin with an arbitrary amount of white space
+ *		(as determined by isspace(3)) followed by a single optional '-'
+ *		sign.
+ *
+ *		Five least significant bits of *flags* encode base, other bits
+ *		are currently unused.
+ *
+ *		Base must be either 8, 10, 16 or 0 to detect it automatically
+ *		similar to user space strtol(3).
+ *	Return
+ *		Number of characters consumed on success. Must be positive but
+ *		no more than buf_len.
+ *
+ *		**-EINVAL** if no valid digits were found or unsupported base
+ *		was provided.
+ *
+ *		**-ERANGE** if resulting value was out of range.
+ *
+ * int bpf_strtoul(const char *buf, size_t buf_len, u64 flags, unsigned long *res)
+ *	Description
+ *		Convert the initial part of the string from buffer *buf* of
+ *		size *buf_len* to an unsigned long integer according to the
+ *		given base and save the result in *res*.
+ *
+ *		The string may begin with an arbitrary amount of white space
+ *		(as determined by isspace(3)).
+ *
+ *		Five least significant bits of *flags* encode base, other bits
+ *		are currently unused.
+ *
+ *		Base must be either 8, 10, 16 or 0 to detect it automatically
+ *		similar to user space strtoul(3).
+ *	Return
+ *		Number of characters consumed on success. Must be positive but
+ *		no more than buf_len.
+ *
+ *		**-EINVAL** if no valid digits were found or unsupported base
+ *		was provided.
+ *
+ *		**-ERANGE** if resulting value was out of range.
  */
 #define __BPF_FUNC_MAPPER(FN)		\
 	FN(unspec),			\
@@ -2654,7 +2701,9 @@ union bpf_attr {
 	FN(sysctl_get_name),		\
 	FN(sysctl_get_current_value),	\
 	FN(sysctl_get_new_value),	\
-	FN(sysctl_set_new_value),
+	FN(sysctl_set_new_value),	\
+	FN(strtol),			\
+	FN(strtoul),
 
 /* integer value in 'imm' field of BPF_CALL instruction selects which helper
  * function eBPF program intends to call
-- 
2.17.1

