Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11D0BC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 00:49:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4A092075D
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 00:49:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="lq0671KF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731071AbfCZAtM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 20:49:12 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:32770 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730581AbfCZAtK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 20:49:10 -0400
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2Q0n9hp004965
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 17:49:09 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=Kfgdiw0N0Ypg6QcWV61Xva6GTIepKvXJkp6LkDXTPpk=;
 b=lq0671KFUxEx61WTEg5DLrBqRfG8fOTr+/G6r55OKzkRC0EQMnPQYbBuj6ELhJwSFA38
 qsvsRLqjcXVb38/qSoAsBZGmWydYgx2IYaLUrU0kgIsZTOtUc4sNRRtlYr8uLEP5MlmB
 wvpfJZBC3zVktukNw61RipwppR1uySXODVU= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2rf9u68085-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 17:49:09 -0700
Received: from mx-out.facebook.com (2620:10d:c0a1:3::13) by
 mail.thefacebook.com (2620:10d:c021:18::174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5;
 Mon, 25 Mar 2019 17:49:08 -0700
Received: by dev082.prn2.facebook.com (Postfix, from userid 572249)
        id 9668B37036A2; Mon, 25 Mar 2019 17:49:06 -0700 (PDT)
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
Subject: [PATCH v2 bpf-next 18/21] selftests/bpf: Add sysctl and strtoX helpers to bpf_helpers.h
Date:   Mon, 25 Mar 2019 17:43:44 -0700
Message-ID: <f309d72d1d3226a07bf64bccfb07ddb6be3463f8.1553560621.git.rdna@fb.com>
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

Add bpf_sysctl_* and bpf_strtoX helpers to bpf_helpers.h.

Signed-off-by: Andrey Ignatov <rdna@fb.com>
---
 tools/testing/selftests/bpf/bpf_helpers.h | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/tools/testing/selftests/bpf/bpf_helpers.h b/tools/testing/selftests/bpf/bpf_helpers.h
index 97d140961438..1082f3c0e7df 100644
--- a/tools/testing/selftests/bpf/bpf_helpers.h
+++ b/tools/testing/selftests/bpf/bpf_helpers.h
@@ -192,6 +192,25 @@ static int (*bpf_skb_ecn_set_ce)(void *ctx) =
 static int (*bpf_tcp_check_syncookie)(struct bpf_sock *sk,
 	    void *ip, int ip_len, void *tcp, int tcp_len) =
 	(void *) BPF_FUNC_tcp_check_syncookie;
+static int (*bpf_sysctl_get_name)(void *ctx, char *buf,
+				  unsigned long long buf_len,
+				  unsigned long long flags) =
+	(void *) BPF_FUNC_sysctl_get_name;
+static int (*bpf_sysctl_get_current_value)(void *ctx, char *buf,
+					   unsigned long long buf_len) =
+	(void *) BPF_FUNC_sysctl_get_current_value;
+static int (*bpf_sysctl_get_new_value)(void *ctx, char *buf,
+				       unsigned long long buf_len) =
+	(void *) BPF_FUNC_sysctl_get_new_value;
+static int (*bpf_sysctl_set_new_value)(void *ctx, const char *buf,
+				       unsigned long long buf_len) =
+	(void *) BPF_FUNC_sysctl_set_new_value;
+static int (*bpf_strtol)(const char *buf, unsigned long long buf_len,
+			 unsigned long long flags, long *res) =
+	(void *) BPF_FUNC_strtol;
+static int (*bpf_strtoul)(const char *buf, unsigned long long buf_len,
+			  unsigned long long flags, unsigned long *res) =
+	(void *) BPF_FUNC_strtoul;
 
 /* llvm builtin functions that eBPF C program may use to
  * emit BPF_LD_ABS and BPF_LD_IND instructions
-- 
2.17.1

