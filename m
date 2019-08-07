Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D1D3C433FF
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 03:36:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C8BE217D9
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 03:36:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b="MbHh8OQZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728270AbfHGDg4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 23:36:56 -0400
Received: from mx0b-00190b01.pphosted.com ([67.231.157.127]:61106 "EHLO
        mx0b-00190b01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727359AbfHGDgy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 23:36:54 -0400
Received: from pps.filterd (m0050096.ppops.net [127.0.0.1])
        by m0050096.ppops.net-00190b01. (8.16.0.42/8.16.0.42) with SMTP id x773VZ0V008716;
        Wed, 7 Aug 2019 04:36:33 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=jan2016.eng;
 bh=vffPYkazUX63OOelAC2TpHBENEYOaE8kM+STi98FHrY=;
 b=MbHh8OQZ7vnU2WY4jQW2VAFrFXutzTL7KDzMIVZSDcIl9ooCTNxYs3DjvZ/Bgu0WM2Z6
 3eU/pJUMLfCR8IIbSN9NCKrRlNXR1PL1BJNbtHCnoSebIJI8nJ157Psbzwyjt4C2ZLoT
 c6PnuUJOjwvhW10mUEsM9kEYZF+5QTwBJp6ELlG1gg6wOgYVc+wC+qLmwHC074lE7xKV
 sl/Joan0WwfusMkUnT8lYEw2Fdz0zTNSirFSZUP/G5wEBsFiG0GBqge0lbv8ITbr0/PW
 OaEDcr4gxR/EIY8o7IXM87ITvVK5Ff2SzZGAyQ9oBUjNtg9jOWkkKALCuEdESbMuvwPt JA== 
Received: from prod-mail-ppoint5 (prod-mail-ppoint5.akamai.com [184.51.33.60] (may be forged))
        by m0050096.ppops.net-00190b01. with ESMTP id 2u52p8ftgh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 07 Aug 2019 04:36:33 +0100
Received: from pps.filterd (prod-mail-ppoint5.akamai.com [127.0.0.1])
        by prod-mail-ppoint5.akamai.com (8.16.0.27/8.16.0.27) with SMTP id x773WhWs032205;
        Tue, 6 Aug 2019 20:36:32 -0700
Received: from email.msg.corp.akamai.com ([172.27.123.57])
        by prod-mail-ppoint5.akamai.com with ESMTP id 2u5888ebjv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 06 Aug 2019 20:36:32 -0700
Received: from USMA1EX-DAG1MB5.msg.corp.akamai.com (172.27.123.105) by
 usma1ex-dag3mb4.msg.corp.akamai.com (172.27.123.56) with Microsoft SMTP
 Server (TLS) id 15.0.1473.3; Tue, 6 Aug 2019 23:36:31 -0400
Received: from usma1ex-cas5.msg.corp.akamai.com (172.27.123.53) by
 usma1ex-dag1mb5.msg.corp.akamai.com (172.27.123.105) with Microsoft SMTP
 Server (TLS) id 15.0.1473.3; Tue, 6 Aug 2019 23:36:31 -0400
Received: from igorcastle.kendall.corp.akamai.com (172.29.170.135) by
 usma1ex-cas5.msg.corp.akamai.com (172.27.123.53) with Microsoft SMTP Server
 id 15.0.1473.3 via Frontend Transport; Tue, 6 Aug 2019 20:36:25 -0700
Received: by igorcastle.kendall.corp.akamai.com (Postfix, from userid 29659)
        id 0E51561D78; Tue,  6 Aug 2019 23:36:23 -0400 (EDT)
From:   Igor Lubashev <ilubashe@akamai.com>
To:     <linux-kernel@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>
CC:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        <linux-arm-kernel@lists.infradead.org>,
        James Morris <jmorris@namei.org>,
        Igor Lubashev <ilubashe@akamai.com>
Subject: [PATCH v2 3/4] perf: Use CAP_SYSLOG with kptr_restrict checks
Date:   Tue, 6 Aug 2019 23:35:56 -0400
Message-ID: <f739900dede057b83a6e6ac5dee5fffb67f16e97.1565146171.git.ilubashe@akamai.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1565146171.git.ilubashe@akamai.com>
References: <cover.1565146171.git.ilubashe@akamai.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-07_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1908070034
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:5.22.84,1.0.8
 definitions=2019-08-07_01:2019-08-05,2019-08-07 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 priorityscore=1501
 adultscore=0 lowpriorityscore=0 mlxscore=0 spamscore=0 mlxlogscore=999
 malwarescore=0 impostorscore=0 clxscore=1015 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1906280000
 definitions=main-1908070034
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel is using CAP_SYSLOG capability instead of uid==0 and euid==0 when
checking kptr_restrict. Make perf do the same.

Also, the kernel is a more restrictive than "no restrictions" in case of
kptr_restrict==0, so add the same logic to perf.

Signed-off-by: Igor Lubashev <ilubashe@akamai.com>
---
 tools/perf/util/symbol.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index 173f3378aaa0..046271103499 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -4,6 +4,7 @@
 #include <stdlib.h>
 #include <stdio.h>
 #include <string.h>
+#include <linux/capability.h>
 #include <linux/kernel.h>
 #include <linux/mman.h>
 #include <linux/time64.h>
@@ -15,8 +16,10 @@
 #include <inttypes.h>
 #include "annotate.h"
 #include "build-id.h"
+#include "cap.h"
 #include "util.h"
 #include "debug.h"
+#include "event.h"
 #include "machine.h"
 #include "map.h"
 #include "symbol.h"
@@ -890,7 +893,11 @@ bool symbol__restricted_filename(const char *filename,
 {
 	bool restricted = false;
 
-	if (symbol_conf.kptr_restrict) {
+	/* Per kernel/kallsyms.c:
+	 * we also restrict when perf_event_paranoid > 1 w/o CAP_SYSLOG
+	 */
+	if (symbol_conf.kptr_restrict ||
+	    (perf_event_paranoid() > 1 && !perf_cap__capable(CAP_SYSLOG))) {
 		char *r = realpath(filename, NULL);
 
 		if (r != NULL) {
@@ -2190,9 +2197,9 @@ static bool symbol__read_kptr_restrict(void)
 		char line[8];
 
 		if (fgets(line, sizeof(line), fp) != NULL)
-			value = ((geteuid() != 0) || (getuid() != 0)) ?
-					(atoi(line) != 0) :
-					(atoi(line) == 2);
+			value = perf_cap__capable(CAP_SYSLOG) ?
+					(atoi(line) >= 2) :
+					(atoi(line) != 0);
 
 		fclose(fp);
 	}
-- 
2.7.4

