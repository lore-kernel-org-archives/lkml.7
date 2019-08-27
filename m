Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84BA7C41514
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 01:40:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C8032080C
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 01:40:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b="MOzA8wnx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728691AbfH0BkP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 21:40:15 -0400
Received: from mx0a-00190b01.pphosted.com ([67.231.149.131]:28758 "EHLO
        mx0a-00190b01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728345AbfH0BkO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 21:40:14 -0400
Received: from pps.filterd (m0122332.ppops.net [127.0.0.1])
        by mx0a-00190b01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x7R1bkrg008703;
        Tue, 27 Aug 2019 02:39:48 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=jan2016.eng;
 bh=f/mlnpASr56fTSZ5OtsufOawpNk8bRy7Xrlqlzx/OIM=;
 b=MOzA8wnx3heltPi94muKsTcvnyJVZXnKe+cZVyNd3WBIhy8sZjVZs5x16/rrN6+zvq3g
 BqyPWwL4+7H+xb8ba9EdUZbSgqtt9MCk7s3W69OgqWdrpFU4PcSsOyGk5pnhClRuQtZ3
 ZWPuHcc4zunVI0GdtDh+qeJ2W6VJYyKSZ8J21RtoW/hA0G3tifq+Nca8RhCrRM/9Xfbh
 1Vru4bAwluj5vLM2v1vjTp7e2HH7yUS84CDwLVcEKcb0g+ErU28faDmpEYVE9CFtYjNM
 IFQA06Comb7JIOa9WplJfs6suKPuCK1WUIl5d4zaLjYp2iCJIhFY/zdmJz6KVwME7ydY Jw== 
Received: from prod-mail-ppoint8 (prod-mail-ppoint8.akamai.com [96.6.114.122] (may be forged))
        by mx0a-00190b01.pphosted.com with ESMTP id 2ujwcst98a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 27 Aug 2019 02:39:47 +0100
Received: from pps.filterd (prod-mail-ppoint8.akamai.com [127.0.0.1])
        by prod-mail-ppoint8.akamai.com (8.16.0.27/8.16.0.27) with SMTP id x7R1VkrU011780;
        Mon, 26 Aug 2019 21:39:46 -0400
Received: from email.msg.corp.akamai.com ([172.27.123.31])
        by prod-mail-ppoint8.akamai.com with ESMTP id 2uk0jvhdcg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 26 Aug 2019 21:39:46 -0400
Received: from USMA1EX-DAG1MB5.msg.corp.akamai.com (172.27.123.105) by
 usma1ex-dag3mb6.msg.corp.akamai.com (172.27.123.54) with Microsoft SMTP
 Server (TLS) id 15.0.1473.3; Mon, 26 Aug 2019 21:39:44 -0400
Received: from usma1ex-cas4.msg.corp.akamai.com (172.27.123.57) by
 usma1ex-dag1mb5.msg.corp.akamai.com (172.27.123.105) with Microsoft SMTP
 Server (TLS) id 15.0.1473.3; Mon, 26 Aug 2019 21:39:44 -0400
Received: from igorcastle.kendall.corp.akamai.com (172.29.170.135) by
 usma1ex-cas4.msg.corp.akamai.com (172.27.123.57) with Microsoft SMTP Server
 id 15.0.1473.3 via Frontend Transport; Mon, 26 Aug 2019 18:39:44 -0700
Received: by igorcastle.kendall.corp.akamai.com (Postfix, from userid 29659)
        id 4A68564C03; Mon, 26 Aug 2019 21:39:41 -0400 (EDT)
From:   Igor Lubashev <ilubashe@akamai.com>
To:     Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
CC:     Igor Lubashev <ilubashe@akamai.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        James Morris <jmorris@namei.org>,
        "Namhyung Kim" <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Suzuki Poulouse" <suzuki.poulose@arm.com>,
        <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH 3/5] perf util: kernel profiling is disallowed only when perf_event_paranoid > 1
Date:   Mon, 26 Aug 2019 21:39:14 -0400
Message-ID: <1566869956-7154-4-git-send-email-ilubashe@akamai.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1566869956-7154-1-git-send-email-ilubashe@akamai.com>
References: <1566869956-7154-1-git-send-email-ilubashe@akamai.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-26_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1908270014
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:5.22.84,1.0.8
 definitions=2019-08-26_08:2019-08-26,2019-08-26 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0
 priorityscore=1501 mlxscore=0 malwarescore=0 adultscore=0 phishscore=0
 mlxlogscore=999 clxscore=1015 lowpriorityscore=0 bulkscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1906280000 definitions=main-1908270015
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Perf was too restrictive about sysctl kernel.perf_event_paranoid. The
kernel only disallows profiling when perf_event_paranoid > 1. Make perf do
the same.

Signed-off-by: Igor Lubashev <ilubashe@akamai.com>
---
 tools/perf/util/evsel.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 0b3b5af33954..bfe6ed2abcc2 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -279,7 +279,7 @@ struct evsel *perf_evsel__new_idx(struct perf_event_attr *attr, int idx)
 
 static bool perf_event_can_profile_kernel(void)
 {
-	return perf_event_paranoid_check(-1);
+	return perf_event_paranoid_check(1);
 }
 
 struct evsel *perf_evsel__new_cycles(bool precise)
-- 
2.7.4

