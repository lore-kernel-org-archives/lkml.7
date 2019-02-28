Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F52FC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 05:08:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6D4E2171F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 05:08:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="iD84Zm1T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731098AbfB1FIx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 00:08:53 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:48266 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725899AbfB1FGx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 00:06:53 -0500
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1S53Kde016111
        for <linux-kernel@vger.kernel.org>; Wed, 27 Feb 2019 21:06:52 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=tFVVChH7wjw/HyGjWwqnrnZMAP7HYyt8faJwZcmAEfc=;
 b=iD84Zm1TwWdjW8OrJmthymi8mnw+F0WfQwblCE0cvmgk4dfpImG67SYMD4ZHxFAtPu5h
 RMtRUqVrXCaJ7Wg/B08BwNciE8Uthqa726E8gkO5YKoy1fMsB3TpmdqXbkUYoI73OxXs
 ot5ADM8F5oZ6b130XkR7+fK6Mq9KV6HzPu0= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2qx7ej08sp-7
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 27 Feb 2019 21:06:52 -0800
Received: from mx-out.facebook.com (2620:10d:c081:10::13) by
 mail.thefacebook.com (2620:10d:c081:35::125) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1531.3;
 Wed, 27 Feb 2019 21:06:50 -0800
Received: by devbig006.ftw2.facebook.com (Postfix, from userid 4523)
        id 2575962E2B4A; Wed, 27 Feb 2019 21:06:49 -0800 (PST)
Smtp-Origin-Hostprefix: devbig
From:   Song Liu <songliubraving@fb.com>
Smtp-Origin-Hostname: devbig006.ftw2.facebook.com
To:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <ast@kernel.org>, <daniel@iogearbox.net>, <kernel-team@fb.com>,
        <peterz@infradead.org>, <acme@redhat.com>, <jolsa@kernel.org>,
        <namhyung@kernel.org>, Song Liu <songliubraving@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH v5 perf,bpf 01/15] perf, bpf: consider events with attr.bpf_event as side-band events
Date:   Wed, 27 Feb 2019 21:06:29 -0800
Message-ID: <20190228050643.958685-2-songliubraving@fb.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190228050643.958685-1-songliubraving@fb.com>
References: <20190228050643.958685-1-songliubraving@fb.com>
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-28_02:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Events with bpf_event should be considered as side-band event, as they
carry information about BPF programs.

Fixes: 6ee52e2a3fe4 ("perf, bpf: Introduce PERF_RECORD_BPF_EVENT")
Signed-off-by: Song Liu <songliubraving@fb.com>
---
 kernel/events/core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 795bfab6f8a3..6a17584810ca 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -4238,7 +4238,8 @@ static bool is_sb_event(struct perf_event *event)
 	if (attr->mmap || attr->mmap_data || attr->mmap2 ||
 	    attr->comm || attr->comm_exec ||
 	    attr->task || attr->ksymbol ||
-	    attr->context_switch)
+	    attr->context_switch ||
+	    attr->bpf_event)
 		return true;
 	return false;
 }
-- 
2.17.1

