Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6539CC5B57D
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 01:16:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 398B6206A3
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 01:16:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b="GI9/HJ/s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727241AbfGCBQt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 21:16:49 -0400
Received: from mx0b-00190b01.pphosted.com ([67.231.157.127]:40998 "EHLO
        mx0b-00190b01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726150AbfGCBQt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 21:16:49 -0400
Received: from pps.filterd (m0050102.ppops.net [127.0.0.1])
        by m0050102.ppops.net-00190b01. (8.16.0.27/8.16.0.27) with SMTP id x6306Stb031558;
        Wed, 3 Jul 2019 01:10:51 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=jan2016.eng;
 bh=vhdroY72bGDWw4TJQf6mIBF5mLDW5ZnW83laxKxW0O8=;
 b=GI9/HJ/sX4q65adr3ojIlYnaH7gx7z+Ol2AoDu5eGNYHByt9LnkLbniiMaDeL+9m9Nhw
 lmxlKqixFxa00vLIEOQ42tZpkckrTuKUU1zF2hPvoDd24c0DAhivRPrqE72kGeYl9VoL
 1IrXJja+WDpCIhT7xTWIBcM1/vzXqIZzjtS/WJxNlFI7vigBFmM1VLB0q/moIVHhRFMR
 0IimNoPKlBO8WztjzZp2mvLLPY+/zONnUwtQ7NBoJQP30wNcKOo8vlDA4HvDlHZN4MX7
 MqNnmQsxzh5+/sW7Djx8iIFyKDxGg45C6lxmx94s291Ebkp5JvUjxmwAAViVbR8pwt2P 8A== 
Received: from prod-mail-ppoint2 (prod-mail-ppoint2.akamai.com [184.51.33.19] (may be forged))
        by m0050102.ppops.net-00190b01. with ESMTP id 2tg8vp231q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 03 Jul 2019 01:10:51 +0100
Received: from pps.filterd (prod-mail-ppoint2.akamai.com [127.0.0.1])
        by prod-mail-ppoint2.akamai.com (8.16.0.27/8.16.0.27) with SMTP id x6302JOx014179;
        Tue, 2 Jul 2019 20:10:50 -0400
Received: from email.msg.corp.akamai.com ([172.27.123.30])
        by prod-mail-ppoint2.akamai.com with ESMTP id 2te3awrp2k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 02 Jul 2019 20:10:50 -0400
Received: from USMA1EX-CAS2.msg.corp.akamai.com (172.27.123.31) by
 usma1ex-dag1mb1.msg.corp.akamai.com (172.27.123.101) with Microsoft SMTP
 Server (TLS) id 15.0.1473.3; Tue, 2 Jul 2019 20:10:49 -0400
Received: from igorcastle.kendall.corp.akamai.com (172.29.170.135) by
 USMA1EX-CAS2.msg.corp.akamai.com (172.27.123.31) with Microsoft SMTP Server
 id 15.0.1473.3 via Frontend Transport; Tue, 2 Jul 2019 20:10:49 -0400
Received: by igorcastle.kendall.corp.akamai.com (Postfix, from userid 29659)
        id A68C461E45; Tue,  2 Jul 2019 20:10:47 -0400 (EDT)
From:   Igor Lubashev <ilubashe@akamai.com>
To:     <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
CC:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        <linux-arm-kernel@lists.infradead.org>,
        James Morris <jmorris@namei.org>,
        Igor Lubashev <ilubashe@akamai.com>
Subject: [PATCH 3/3] perf: Use CAP_SYSLOG with kptr_restrict checks
Date:   Tue, 2 Jul 2019 20:10:05 -0400
Message-ID: <1562112605-6235-4-git-send-email-ilubashe@akamai.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1562112605-6235-1-git-send-email-ilubashe@akamai.com>
References: <1562112605-6235-1-git-send-email-ilubashe@akamai.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-02_12:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1907020268
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-02_12:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1907020269
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel is using CAP_SYSLOG capcbility instead of uid==0 and euid==0 when
checking kptr_restrict. Make perf do the same.

Also, the kernel is a more restrictive than "no restrictions" in case of
kptr_restrict==0, so add the same logic to perf.

Signed-off-by: Igor Lubashev <ilubashe@akamai.com>
---
 tools/perf/util/symbol.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index 5cbad55cd99d..fd68dae3f58e 100644
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
@@ -889,7 +892,11 @@ bool symbol__restricted_filename(const char *filename,
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
@@ -2100,9 +2107,9 @@ static bool symbol__read_kptr_restrict(void)
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

