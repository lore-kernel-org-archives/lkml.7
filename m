Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87E16C5B57D
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 00:41:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53402218AD
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 00:41:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b="ebhomM77"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727103AbfGCAl5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 20:41:57 -0400
Received: from mx0a-00190b01.pphosted.com ([67.231.149.131]:34124 "EHLO
        mx0a-00190b01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726430AbfGCAl4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 20:41:56 -0400
Received: from pps.filterd (m0050093.ppops.net [127.0.0.1])
        by m0050093.ppops.net-00190b01. (8.16.0.27/8.16.0.27) with SMTP id x63075lj032474;
        Wed, 3 Jul 2019 01:11:16 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=jan2016.eng;
 bh=dQnGPKV3yYltUgfU2I+Fw3Qje3Qs8IZ53UNxxwHARwA=;
 b=ebhomM77vVDM11MEiu4z/6eNRpizeKNIUe3nNpL36L1ZrENcDzq+p8c1NW8j2q5nHrRN
 uwMN3ZdFGfzITCLytCecvWIxDEN8m1xlZIfgMyhke4FtFswH/9Lg/1xNmaH8Y+CvV+gi
 y/zOtqdu/BC0Ci4APgRUJr5MPCPcG1G9BRAdxhZXsxHbgcFsUn17s0PYHsuv8u3B9+1p
 bmkypYpqpLjRpvEnH6LgXbL8XLXIGcwsh1SFqxmpO9JcL1J9dQyyaKhTfticDYPNzJ1H
 o4bJfQ84+kuPQlyPT18/dIA8i5xTyz7wnGCXSgWcxOX9NYhuV1LSdmBMRYfhZgka0U85 5Q== 
Received: from prod-mail-ppoint3 (prod-mail-ppoint3.akamai.com [96.6.114.86] (may be forged))
        by m0050093.ppops.net-00190b01. with ESMTP id 2tg2tkusbn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 03 Jul 2019 01:11:15 +0100
Received: from pps.filterd (prod-mail-ppoint3.akamai.com [127.0.0.1])
        by prod-mail-ppoint3.akamai.com (8.16.0.27/8.16.0.27) with SMTP id x6302MSR021891;
        Tue, 2 Jul 2019 20:11:14 -0400
Received: from email.msg.corp.akamai.com ([172.27.123.34])
        by prod-mail-ppoint3.akamai.com with ESMTP id 2te3b09eb1-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 02 Jul 2019 20:11:13 -0400
Received: from usma1ex-cas4.msg.corp.akamai.com (172.27.123.57) by
 usma1ex-dag1mb4.msg.corp.akamai.com (172.27.123.104) with Microsoft SMTP
 Server (TLS) id 15.0.1473.3; Tue, 2 Jul 2019 20:10:49 -0400
Received: from igorcastle.kendall.corp.akamai.com (172.29.170.135) by
 usma1ex-cas4.msg.corp.akamai.com (172.27.123.57) with Microsoft SMTP Server
 id 15.0.1473.3 via Frontend Transport; Tue, 2 Jul 2019 17:10:49 -0700
Received: by igorcastle.kendall.corp.akamai.com (Postfix, from userid 29659)
        id A83D461E4A; Tue,  2 Jul 2019 20:10:47 -0400 (EDT)
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
Subject: [PATCH 1/3] perf: Add capability-related utilities
Date:   Tue, 2 Jul 2019 20:10:03 -0400
Message-ID: <1562112605-6235-2-git-send-email-ilubashe@akamai.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1562112605-6235-1-git-send-email-ilubashe@akamai.com>
References: <1562112605-6235-1-git-send-email-ilubashe@akamai.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-02_12:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1907020268
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-02_12:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1907020269
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add utilities to help checking capabilities of the running process.
Make perf link with libcap.

Signed-off-by: Igor Lubashev <ilubashe@akamai.com>
---
 tools/perf/Makefile.config         |  2 +-
 tools/perf/util/Build              |  1 +
 tools/perf/util/cap.c              | 24 ++++++++++++++++++++++++
 tools/perf/util/cap.h              | 10 ++++++++++
 tools/perf/util/event.h            |  1 +
 tools/perf/util/python-ext-sources |  1 +
 tools/perf/util/util.c             |  9 +++++++++
 7 files changed, 47 insertions(+), 1 deletion(-)
 create mode 100644 tools/perf/util/cap.c
 create mode 100644 tools/perf/util/cap.h

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 85fbcd265351..21470a50ed39 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -259,7 +259,7 @@ CXXFLAGS += -Wno-strict-aliasing
 # adding assembler files missing the .GNU-stack linker note.
 LDFLAGS += -Wl,-z,noexecstack
 
-EXTLIBS = -lpthread -lrt -lm -ldl
+EXTLIBS = -lpthread -lrt -lm -ldl -lcap
 
 ifeq ($(FEATURES_DUMP),)
 include $(srctree)/tools/build/Makefile.feature
diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index 6d5bbc8b589b..9cc6e9b34ebd 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -1,6 +1,7 @@
 perf-y += annotate.o
 perf-y += block-range.o
 perf-y += build-id.o
+perf-y += cap.o
 perf-y += config.o
 perf-y += ctype.o
 perf-y += db-export.o
diff --git a/tools/perf/util/cap.c b/tools/perf/util/cap.c
new file mode 100644
index 000000000000..c42ea32663cf
--- /dev/null
+++ b/tools/perf/util/cap.c
@@ -0,0 +1,24 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Capability utilities
+ */
+#include "cap.h"
+#include <stdbool.h>
+#include <sys/capability.h>
+
+bool perf_cap__capable(cap_value_t cap)
+{
+	cap_flag_value_t val;
+	cap_t caps = cap_get_proc();
+
+	if (!caps)
+		return false;
+
+	if (cap_get_flag(caps, cap, CAP_EFFECTIVE, &val) != 0)
+		val = CAP_CLEAR;
+
+	if (cap_free(caps) != 0)
+		return false;
+
+	return val == CAP_SET;
+}
diff --git a/tools/perf/util/cap.h b/tools/perf/util/cap.h
new file mode 100644
index 000000000000..5521de78b228
--- /dev/null
+++ b/tools/perf/util/cap.h
@@ -0,0 +1,10 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __PERF_CAP_H
+#define __PERF_CAP_H
+
+#include <stdbool.h>
+#include <sys/capability.h>
+
+bool perf_cap__capable(cap_value_t cap);
+
+#endif /* __PERF_CAP_H */
diff --git a/tools/perf/util/event.h b/tools/perf/util/event.h
index 9e999550f247..013d9e28fcac 100644
--- a/tools/perf/util/event.h
+++ b/tools/perf/util/event.h
@@ -849,6 +849,7 @@ void  cpu_map_data__synthesize(struct cpu_map_data *data, struct cpu_map *map,
 void event_attr_init(struct perf_event_attr *attr);
 
 int perf_event_paranoid(void);
+bool perf_event_paranoid_check(int max_level);
 
 extern int sysctl_perf_event_max_stack;
 extern int sysctl_perf_event_max_contexts_per_stack;
diff --git a/tools/perf/util/python-ext-sources b/tools/perf/util/python-ext-sources
index 7aa0ea64544e..4545eaf018b5 100644
--- a/tools/perf/util/python-ext-sources
+++ b/tools/perf/util/python-ext-sources
@@ -6,6 +6,7 @@
 #
 
 util/python.c
+util/cap.c
 util/ctype.c
 util/evlist.c
 util/evsel.c
diff --git a/tools/perf/util/util.c b/tools/perf/util/util.c
index d388f80d8703..cde538ec727d 100644
--- a/tools/perf/util/util.c
+++ b/tools/perf/util/util.c
@@ -16,10 +16,12 @@
 #include <string.h>
 #include <errno.h>
 #include <limits.h>
+#include <linux/capability.h>
 #include <linux/kernel.h>
 #include <linux/log2.h>
 #include <linux/time64.h>
 #include <unistd.h>
+#include "cap.h"
 #include "strlist.h"
 #include "string2.h"
 
@@ -456,6 +458,13 @@ int perf_event_paranoid(void)
 
 	return value;
 }
+
+bool perf_event_paranoid_check(int max_level)
+{
+	return perf_cap__capable(CAP_SYS_ADMIN) ||
+			perf_event_paranoid() <= max_level;
+}
+
 static int
 fetch_ubuntu_kernel_version(unsigned int *puint)
 {
-- 
2.7.4

