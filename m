Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34679C282DA
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 19:36:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF3D921773
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 19:36:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="euAJzk7c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732024AbfDETg6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 15:36:58 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:48164 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731986AbfDETgz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 15:36:55 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x35JXsrE020902
        for <linux-kernel@vger.kernel.org>; Fri, 5 Apr 2019 12:36:54 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=cxdmKji8Yh7fIjPXx1c0mYfiywZ72tTdA4s4N8tQkRE=;
 b=euAJzk7cdO4qOMfk2BxDwPaye4Xg6feF46BfBQHzABlj5lIsfNO61ZcOIloNOANHbdbK
 zadRx1mVS3n62atwqlcsHPXdgAzKwEJOYIYrBOHcN7P/Y8crNh1nioW3WVu0zRwnh/4f
 08uvpDXAAH6lkghRdcDIdO2Ct00saC5sfgY= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2rp47j1ysx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2019 12:36:53 -0700
Received: from mx-out.facebook.com (2620:10d:c0a1:3::13) by
 mail.thefacebook.com (2620:10d:c021:18::175) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5;
 Fri, 5 Apr 2019 12:36:53 -0700
Received: by dev082.prn2.facebook.com (Postfix, from userid 572249)
        id 0167C3701752; Fri,  5 Apr 2019 12:36:51 -0700 (PDT)
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
Subject: [PATCH v3 bpf-next 15/21] bpf: Introduce ARG_PTR_TO_{INT,LONG} arg types
Date:   Fri, 5 Apr 2019 12:35:37 -0700
Message-ID: <7f6dd906560abf1fa0fb746bd19cd20760c63e9e.1554485410.git.rdna@fb.com>
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

Currently the way to pass result from BPF helper to BPF program is to
provide memory area defined by pointer and size: func(void *, size_t).

It works great for generic use-case, but for simple types, such as int,
it's overkill and consumes two arguments when it could use just one.

Introduce new argument types ARG_PTR_TO_INT and ARG_PTR_TO_LONG to be
able to pass result from helper to program via pointer to int and long
correspondingly: func(int *) or func(long *).

New argument types are similar to ARG_PTR_TO_MEM with the following
differences:
* they don't require corresponding ARG_CONST_SIZE argument, predefined
  access sizes are used instead (32bit for int, 64bit for long);
* it's possible to use more than one such an argument in a helper;
* provided pointers have to be aligned.

It's easy to introduce similar ARG_PTR_TO_CHAR and ARG_PTR_TO_SHORT
argument types. It's not done due to lack of use-case though.

Signed-off-by: Andrey Ignatov <rdna@fb.com>
---
 include/linux/bpf.h   |  2 ++
 kernel/bpf/verifier.c | 29 +++++++++++++++++++++++++++++
 2 files changed, 31 insertions(+)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index a445194b5fb6..986f89d9de63 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -195,6 +195,8 @@ enum bpf_arg_type {
 	ARG_ANYTHING,		/* any (initialized) argument is ok */
 	ARG_PTR_TO_SPIN_LOCK,	/* pointer to bpf_spin_lock */
 	ARG_PTR_TO_SOCK_COMMON,	/* pointer to sock_common */
+	ARG_PTR_TO_INT,		/* pointer to int */
+	ARG_PTR_TO_LONG,	/* pointer to long */
 };
 
 /* type of values returned from helper functions */
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 56baf21b57c2..6ff5c0e048b1 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -2433,6 +2433,22 @@ static bool arg_type_is_mem_size(enum bpf_arg_type type)
 	       type == ARG_CONST_SIZE_OR_ZERO;
 }
 
+static bool arg_type_is_int_ptr(enum bpf_arg_type type)
+{
+	return type == ARG_PTR_TO_INT ||
+	       type == ARG_PTR_TO_LONG;
+}
+
+static int int_ptr_type_to_size(enum bpf_arg_type type)
+{
+	if (type == ARG_PTR_TO_INT)
+		return sizeof(u32);
+	else if (type == ARG_PTR_TO_LONG)
+		return sizeof(u64);
+
+	return -EINVAL;
+}
+
 static int check_func_arg(struct bpf_verifier_env *env, u32 regno,
 			  enum bpf_arg_type arg_type,
 			  struct bpf_call_arg_meta *meta)
@@ -2525,6 +2541,12 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 regno,
 			 type != expected_type)
 			goto err_type;
 		meta->raw_mode = arg_type == ARG_PTR_TO_UNINIT_MEM;
+	} else if (arg_type_is_int_ptr(arg_type)) {
+		expected_type = PTR_TO_STACK;
+		if (!type_is_pkt_pointer(type) &&
+		    type != PTR_TO_MAP_VALUE &&
+		    type != expected_type)
+			goto err_type;
 	} else {
 		verbose(env, "unsupported arg_type %d\n", arg_type);
 		return -EFAULT;
@@ -2606,6 +2628,13 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 regno,
 		err = check_helper_mem_access(env, regno - 1,
 					      reg->umax_value,
 					      zero_size_allowed, meta);
+	} else if (arg_type_is_int_ptr(arg_type)) {
+		int size = int_ptr_type_to_size(arg_type);
+
+		err = check_helper_mem_access(env, regno, size, false, meta);
+		if (err)
+			return err;
+		err = check_ptr_alignment(env, reg, 0, size, true);
 	}
 
 	return err;
-- 
2.17.1

