Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2A3FC282CE
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 19:36:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85C0E2146F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 19:36:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="BeP27YCs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731836AbfDETgb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 15:36:31 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:52654 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731183AbfDETg3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 15:36:29 -0400
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x35JYh9M004326
        for <linux-kernel@vger.kernel.org>; Fri, 5 Apr 2019 12:36:28 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=1OzIXCiyQ3ZJqmCdkZT3bEwg6Tmyss8qNl0BPBqkwsI=;
 b=BeP27YCsp0OR7Q5jBlbyU4LOZeMQVsACRnrV484/k/5h6weSzPFPakSdtxSg+ew6cLyB
 olk6LXAdlo5WCs7/SbKK0Hxeh5vJsJFZAB5rlbdA18mGs6Zuup9bc/Ao5Sd7+4xcjGid
 yDcDdljk2QuYvaRzmSJ2TLwdV4Fpc4fAobo= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2rpd598177-10
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2019 12:36:28 -0700
Received: from mx-out.facebook.com (2620:10d:c081:10::13) by
 mail.thefacebook.com (2620:10d:c081:35::127) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5;
 Fri, 5 Apr 2019 12:36:24 -0700
Received: by dev082.prn2.facebook.com (Postfix, from userid 572249)
        id 013A13701752; Fri,  5 Apr 2019 12:36:22 -0700 (PDT)
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
Subject: [PATCH v3 bpf-next 01/21] bpf: Add base proto function for cgroup-bpf programs
Date:   Fri, 5 Apr 2019 12:35:23 -0700
Message-ID: <caa3d6730845e22ab5fe70fb9da8e467b2d024db.1554485409.git.rdna@fb.com>
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

Currently kernel/bpf/cgroup.c contains only one program type and one
proto function cgroup_dev_func_proto(). It'd be useful to have base
proto function that can be reused for new cgroup-bpf program types
coming soon.

Introduce cgroup_base_func_proto().

Signed-off-by: Andrey Ignatov <rdna@fb.com>
---
 kernel/bpf/cgroup.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
index 4e807973aa80..f6cd38746df2 100644
--- a/kernel/bpf/cgroup.c
+++ b/kernel/bpf/cgroup.c
@@ -701,7 +701,7 @@ int __cgroup_bpf_check_dev_permission(short dev_type, u32 major, u32 minor,
 EXPORT_SYMBOL(__cgroup_bpf_check_dev_permission);
 
 static const struct bpf_func_proto *
-cgroup_dev_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
+cgroup_base_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 {
 	switch (func_id) {
 	case BPF_FUNC_map_lookup_elem:
@@ -725,6 +725,12 @@ cgroup_dev_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 	}
 }
 
+static const struct bpf_func_proto *
+cgroup_dev_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
+{
+	return cgroup_base_func_proto(func_id, prog);
+}
+
 static bool cgroup_dev_is_valid_access(int off, int size,
 				       enum bpf_access_type type,
 				       const struct bpf_prog *prog,
-- 
2.17.1

