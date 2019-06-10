Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47B56C43218
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 23:42:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17B10206C3
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 23:42:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="G2n7rLzo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390720AbfFJXmi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 19:42:38 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:57040 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2390561AbfFJXmh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 19:42:37 -0400
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.27/8.16.0.27) with SMTP id x5ANeA8a019595
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2019 16:42:36 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=facebook;
 bh=oqb7c3IIXxTrw4Z8HL3sKceCO7WSZyT9TurhXG3Xe24=;
 b=G2n7rLzohWrVjBIXVpBtPT3bmx42YOAXJ7JCxt9cUbBdF4KlaN4VyCcTKtjTDEguRzmI
 VRhLIqFvqwhC4lTms4T77pHXLj4yf85zr3hz4bv7CE5uimHEfEHLD41ZQyg70afcThe5
 Qw1oUQp1PlQUtLNtj9X2qZviSMR45klnHRI= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by m0089730.ppops.net with ESMTP id 2t1u4qsdch-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2019 16:42:36 -0700
Received: from mx-out.facebook.com (2620:10d:c081:10::13) by
 mail.thefacebook.com (2620:10d:c081:35::130) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5;
 Mon, 10 Jun 2019 16:42:34 -0700
Received: by devbig006.ftw2.facebook.com (Postfix, from userid 4523)
        id 10ECF62E2020; Mon, 10 Jun 2019 16:42:33 -0700 (PDT)
Smtp-Origin-Hostprefix: devbig
From:   Song Liu <songliubraving@fb.com>
Smtp-Origin-Hostname: devbig006.ftw2.facebook.com
To:     <linux-kernel@vger.kernel.org>
CC:     <kernel-team@fb.com>, <davidca@fb.com>,
        Song Liu <songliubraving@fb.com>,
        Milian Wolff <milian.wolff@kdab.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH] perf script/intel-pt: set synth_opts.callchain for use_browser > 0
Date:   Mon, 10 Jun 2019 16:42:16 -0700
Message-ID: <20190610234216.2849236-1-songliubraving@fb.com>
X-Mailer: git-send-email 2.17.1
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-10_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=967 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906100160
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, intel_pt_process_auxtrace_info() sets synth_opts.callchain for
use_browser != -1, which is not accurate after we set use_browser to 0 in
cmd_script(). As a result, the following commands sees a lot more errors
like:

  perf record -e intel_pt//u -C 10 -- sleep 3
  perf script

  ...
  instruction trace error type 1 time ...
  ...

This patch fixes this by checking use_browser > 0 instead.

Fixes: c1c9b9695cc8 ("perf script: Allow extended console debug output")
Reported-by: David Carrillo Cisneros <davidca@fb.com>
Cc: Milian Wolff <milian.wolff@kdab.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Signed-off-by: Song Liu <songliubraving@fb.com>
---
 tools/perf/util/intel-pt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/intel-pt.c b/tools/perf/util/intel-pt.c
index 6d288237887b..15692c104ca8 100644
--- a/tools/perf/util/intel-pt.c
+++ b/tools/perf/util/intel-pt.c
@@ -2588,7 +2588,7 @@ int intel_pt_process_auxtrace_info(union perf_event *event,
 	} else {
 		itrace_synth_opts__set_default(&pt->synth_opts,
 				session->itrace_synth_opts->default_no_sample);
-		if (use_browser != -1) {
+		if (use_browser > 0) {
 			pt->synth_opts.branches = false;
 			pt->synth_opts.callchain = true;
 		}
-- 
2.17.1

