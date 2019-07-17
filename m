Return-Path: <SRS0=Ncac=VO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4123FC7618F
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 18:16:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F066421849
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 18:16:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b="KVJR3PnB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388957AbfGQSQu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 14:16:50 -0400
Received: from mx0b-00190b01.pphosted.com ([67.231.157.127]:30232 "EHLO
        mx0b-00190b01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727286AbfGQSQu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 14:16:50 -0400
Received: from pps.filterd (m0122330.ppops.net [127.0.0.1])
        by mx0b-00190b01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6HI7jMx014943;
        Wed, 17 Jul 2019 19:16:31 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=jan2016.eng;
 bh=kNrrgDyv5tzQGL0dQcW1y9uDTJw/uB719If7Z2ZV22k=;
 b=KVJR3PnBZxzOh+wflRSxGyKvTVgd5Q2dQYLBUAG2j+0pUyjv3dDIdZxytJiHHRJSOTiQ
 hA4LlTIxaa8OqW37RLRZuo7Z6Nruv0SO6FE+hYgGlWhBoBiTu3FVfrdvYonlFJLKIjUA
 pn0FmJCgOmTHUhyR8XdGXYI6uVnOxdQlGDe6CgEuspCebnidIM/JSt3OiqMrepbYaVRS
 osO0VKjJgeeHNJ9D/UXnVG1sQgHC2y3eVR3vqaAWMIMmbkb6WYkvSC7F21YNnMf07G7t
 AYnxWa8YOC5F5CoJoBMDCluX97vn+xmsM5JVEKA0GOHR0Obe99A0Gmd11kGW6tgP2f+L fw== 
Received: from prod-mail-ppoint3 (prod-mail-ppoint3.akamai.com [96.6.114.86] (may be forged))
        by mx0b-00190b01.pphosted.com with ESMTP id 2tshpnmtem-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 17 Jul 2019 19:16:31 +0100
Received: from pps.filterd (prod-mail-ppoint3.akamai.com [127.0.0.1])
        by prod-mail-ppoint3.akamai.com (8.16.0.27/8.16.0.27) with SMTP id x6HI1q1w002792;
        Wed, 17 Jul 2019 14:16:30 -0400
Received: from email.msg.corp.akamai.com ([172.27.123.53])
        by prod-mail-ppoint3.akamai.com with ESMTP id 2tqan1genp-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 17 Jul 2019 14:16:29 -0400
Received: from USMA1EX-CAS1.msg.corp.akamai.com (172.27.123.30) by
 usma1ex-dag1mb2.msg.corp.akamai.com (172.27.123.102) with Microsoft SMTP
 Server (TLS) id 15.0.1473.3; Wed, 17 Jul 2019 14:16:23 -0400
Received: from igorcastle.kendall.corp.akamai.com (172.29.170.135) by
 USMA1EX-CAS1.msg.corp.akamai.com (172.27.123.30) with Microsoft SMTP Server
 id 15.0.1473.3 via Frontend Transport; Wed, 17 Jul 2019 14:16:23 -0400
Received: by igorcastle.kendall.corp.akamai.com (Postfix, from userid 29659)
        id E441261E9A; Wed, 17 Jul 2019 14:16:21 -0400 (EDT)
From:   Igor Lubashev <ilubashe@akamai.com>
To:     <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexey Budankov <alexey.budankov@linux.intel.com>
CC:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Igor Lubashev <ilubashe@akamai.com>
Subject: [PATCH 4/3] perf: Use CAP_SYS_ADMIN instead of euid==0 with ftrace
Date:   Wed, 17 Jul 2019 14:15:59 -0400
Message-ID: <1563387359-27694-1-git-send-email-ilubashe@akamai.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1562112605-6235-1-git-send-email-ilubashe@akamai.com>
References: <1562112605-6235-1-git-send-email-ilubashe@akamai.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-17_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1907170206
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-17_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1907170208
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel requires CAP_SYS_ADMIN instead of euid==0 to mount debugfs for ftrace.
Make perf require the same.

Signed-off-by: Igor Lubashev <ilubashe@akamai.com>
---
 tools/perf/builtin-ftrace.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
index 9c228c55e1fb..2f632b11ebba 100644
--- a/tools/perf/builtin-ftrace.c
+++ b/tools/perf/builtin-ftrace.c
@@ -13,6 +13,7 @@
 #include <signal.h>
 #include <fcntl.h>
 #include <poll.h>
+#include <linux/capability.h>
 
 #include "debug.h"
 #include <subcmd/parse-options.h>
@@ -21,6 +22,7 @@
 #include "target.h"
 #include "cpumap.h"
 #include "thread_map.h"
+#include "util/cap.h"
 #include "util/config.h"
 
 
@@ -281,7 +283,7 @@ static int __cmd_ftrace(struct perf_ftrace *ftrace, int argc, const char **argv)
 		.events = POLLIN,
 	};
 
-	if (geteuid() != 0) {
+	if (!perf_cap__capable(CAP_SYS_ADMIN)) {
 		pr_err("ftrace only works for root!\n");
 		return -1;
 	}
-- 
2.7.4

