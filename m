Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E3A7C4CECE
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 05:57:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E760F2067B
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 05:57:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404519AbfJQF5h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 01:57:37 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:46046 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2403772AbfJQF5g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 01:57:36 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x9H5vAqC046641
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2019 01:57:35 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2vpgyxacxf-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2019 01:57:35 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <huntbag@linux.vnet.ibm.com>;
        Thu, 17 Oct 2019 06:57:33 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 17 Oct 2019 06:57:29 +0100
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x9H5vSgb45154526
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Oct 2019 05:57:29 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D5C354204B;
        Thu, 17 Oct 2019 05:57:28 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D29204203F;
        Thu, 17 Oct 2019 05:57:27 +0000 (GMT)
Received: from ltc-wspoon6.aus.stglabs.ibm.com (unknown [9.40.193.95])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 17 Oct 2019 05:57:27 +0000 (GMT)
From:   Abhishek Goel <huntbag@linux.vnet.ibm.com>
To:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     shuah@kernel.org, trenn@suse.com, ego@linux.vnet.ibm.com,
        Abhishek Goel <huntbag@linux.vnet.ibm.com>
Subject: [PATCH v3] cpupower : Handle set and info subcommands correctly
Date:   Thu, 17 Oct 2019 00:56:39 -0500
X-Mailer: git-send-email 2.17.1
X-TM-AS-GCONF: 00
x-cbid: 19101705-0008-0000-0000-00000322C958
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19101705-0009-0000-0000-00004A41E58B
Message-Id: <20191017055639.13428-1-huntbag@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-10-17_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1910170048
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cpupower tool has set and info options which are being used only by
x86 machines. This patch removes support for these two subcommands
from cpupower utility for POWER. Thus, these two subcommands will now be
available only for intel.
This removes the ambiguous error message while using set option in case
of using non-intel systems.

Without this patch on a POWER system:

root@ubuntu:~# cpupower info
System does not support Intel's performance bias setting

root@ubuntu:~# cpupower set -b 10
Error setting perf-bias value on CPU

With this patch on a POWER box:

root@ubuntu:~# cpupower info
Subcommand not supported on POWER

Same result for set subcommand.
This patch does not affect results on a intel box.

Signed-off-by: Abhishek Goel <huntbag@linux.vnet.ibm.com>
Acked-by: Thomas Renninger <trenn@suse.de>
---

v1 -> v2 : Instead of bailing out early in set and info commands, in V2,
           we are cutting out support for these two commands for non-intel
           systems.
v2 -> v3 : Using architecture identification in subcommands to make
           decision instead of cutting out support altogether

 tools/power/cpupower/utils/cpupower-info.c | 9 +++++++++
 tools/power/cpupower/utils/cpupower-set.c  | 9 +++++++++
 2 files changed, 18 insertions(+)

diff --git a/tools/power/cpupower/utils/cpupower-info.c b/tools/power/cpupower/utils/cpupower-info.c
index 4c9d342b70ff..d3755ea70d4d 100644
--- a/tools/power/cpupower/utils/cpupower-info.c
+++ b/tools/power/cpupower/utils/cpupower-info.c
@@ -10,6 +10,7 @@
 #include <errno.h>
 #include <string.h>
 #include <getopt.h>
+#include <sys/utsname.h>
 
 #include "helpers/helpers.h"
 #include "helpers/sysfs.h"
@@ -30,6 +31,7 @@ int cmd_info(int argc, char **argv)
 	extern char *optarg;
 	extern int optind, opterr, optopt;
 	unsigned int cpu;
+	struct utsname uts;
 
 	union {
 		struct {
@@ -39,6 +41,13 @@ int cmd_info(int argc, char **argv)
 	} params = {};
 	int ret = 0;
 
+	ret = uname(&uts);
+	if (!ret && (!strcmp(uts.machine, "ppc64le") ||
+		     !strcmp(uts.machine, "ppc64"))) {
+		fprintf(stderr, _("Subcommand not supported on POWER.\n"));
+		return ret;
+	}
+
 	setlocale(LC_ALL, "");
 	textdomain(PACKAGE);
 
diff --git a/tools/power/cpupower/utils/cpupower-set.c b/tools/power/cpupower/utils/cpupower-set.c
index 3cd95c6cb974..3cca6f715dd9 100644
--- a/tools/power/cpupower/utils/cpupower-set.c
+++ b/tools/power/cpupower/utils/cpupower-set.c
@@ -10,6 +10,7 @@
 #include <errno.h>
 #include <string.h>
 #include <getopt.h>
+#include <sys/utsname.h>
 
 #include "helpers/helpers.h"
 #include "helpers/sysfs.h"
@@ -31,6 +32,7 @@ int cmd_set(int argc, char **argv)
 	extern char *optarg;
 	extern int optind, opterr, optopt;
 	unsigned int cpu;
+	struct utsname uts;
 
 	union {
 		struct {
@@ -41,6 +43,13 @@ int cmd_set(int argc, char **argv)
 	int perf_bias = 0;
 	int ret = 0;
 
+	ret = uname(&uts);
+	if (!ret && (!strcmp(uts.machine, "ppc64le") ||
+		     !strcmp(uts.machine, "ppc64"))) {
+		fprintf(stderr, _("Subcommand not supported on POWER.\n"));
+		return ret;
+	}
+
 	setlocale(LC_ALL, "");
 	textdomain(PACKAGE);
 
-- 
2.17.1

