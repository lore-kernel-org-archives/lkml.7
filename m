Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FFE2C282CE
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 19:37:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF71F2175B
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 19:37:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="Q0FnL+xC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732055AbfDEThB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 15:37:01 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:48180 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732025AbfDETg7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 15:36:59 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x35JY6wT021350
        for <linux-kernel@vger.kernel.org>; Fri, 5 Apr 2019 12:36:58 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=Kfgdiw0N0Ypg6QcWV61Xva6GTIepKvXJkp6LkDXTPpk=;
 b=Q0FnL+xCvjTphZrkSyRqEvObvehE0jDeYpR3qwEZbLbhooi3+mZ45ObFSkOj4TceyZ3L
 eP/RFOoTn8nW/7xIOD5X3KrVVc+8IzVNYpIszE5n+nbHUQg0HoQODvgaUcqOlwzCdB/A
 GIxQf0tC0D1NqVjHsWHpRF2E9TcnmUK8XlI= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2rp47j1yt2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2019 12:36:57 -0700
Received: from mx-out.facebook.com (2620:10d:c0a1:3::13) by
 mail.thefacebook.com (2620:10d:c021:18::175) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5;
 Fri, 5 Apr 2019 12:36:57 -0700
Received: by dev082.prn2.facebook.com (Postfix, from userid 572249)
        id A270B3701752; Fri,  5 Apr 2019 12:36:55 -0700 (PDT)
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
Subject: [PATCH v3 bpf-next 18/21] selftests/bpf: Add sysctl and strtoX helpers to bpf_helpers.h
Date:   Fri, 5 Apr 2019 12:35:40 -0700
Message-ID: <53074461c8826dec9fb5d4846a3de851f3fc2aac.1554485410.git.rdna@fb.com>
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

