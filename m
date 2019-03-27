Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E02CC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 16:47:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E53C20645
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 16:47:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="YLNUhCKD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727777AbfC0QrM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 12:47:12 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:51466 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727218AbfC0QrM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 12:47:12 -0400
Received: from pps.filterd (m0001255.ppops.net [127.0.0.1])
        by mx0b-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2RGlAWR000545
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2019 09:47:11 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=facebook;
 bh=wlF/xNy0lr3+jLQV4/jmBbIEnyHIzvY5oveOCmDZ5Sg=;
 b=YLNUhCKDlxVDouEiXNgeR/b62OIyJrCJB5ZKuai+2Chd8H7OxQup1pyvY+Ikh7UsZxlB
 ekuTqolMuNRIMhMYt+RaUTSBHD00ceDREBmknh98+dg1Ix0FO6GX0iBzE+k8Kl+sUncq
 cOEzKG2MzH2i8NmWXHecA/iAoY8JLmSm04w= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0b-00082601.pphosted.com with ESMTP id 2rfvk5mdat-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2019 09:47:10 -0700
Received: from mx-out.facebook.com (2620:10d:c0a1:3::13) by
 mail.thefacebook.com (2620:10d:c021:18::175) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5;
 Wed, 27 Mar 2019 09:47:07 -0700
Received: by devbig006.ftw2.facebook.com (Postfix, from userid 4523)
        id 70C8B62E1450; Wed, 27 Mar 2019 09:47:06 -0700 (PDT)
Smtp-Origin-Hostprefix: devbig
From:   Song Liu <songliubraving@fb.com>
Smtp-Origin-Hostname: devbig006.ftw2.facebook.com
To:     <linux-kernel@vger.kernel.org>
CC:     <kernel-team@fb.com>, Song Liu <songliubraving@fb.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH] perf: fix help message of perf-record --no-bpf-event
Date:   Wed, 27 Mar 2019 09:46:55 -0700
Message-ID: <20190327164655.2572381-1-songliubraving@fb.com>
X-Mailer: git-send-email 2.17.1
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-27_11:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It should be "do not record bpf events".

Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Signed-off-by: Song Liu <songliubraving@fb.com>
---
 tools/perf/builtin-record.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 4e2d953d4bc5..70f9bc3c4294 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -1903,7 +1903,8 @@ static struct option __record_options[] = {
 	OPT_BOOLEAN(0, "tail-synthesize", &record.opts.tail_synthesize,
 		    "synthesize non-sample events at the end of output"),
 	OPT_BOOLEAN(0, "overwrite", &record.opts.overwrite, "use overwrite mode"),
-	OPT_BOOLEAN(0, "no-bpf-event", &record.opts.no_bpf_event, "record bpf events"),
+	OPT_BOOLEAN(0, "no-bpf-event", &record.opts.no_bpf_event,
+		    "do not record bpf events"),
 	OPT_BOOLEAN(0, "strict-freq", &record.opts.strict_freq,
 		    "Fail if the specified frequency can't be used"),
 	OPT_CALLBACK('F', "freq", &record.opts, "freq or 'max'",
-- 
2.17.1

