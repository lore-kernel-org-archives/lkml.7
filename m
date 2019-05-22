Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4204EC282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 14:46:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2252420879
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 14:46:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729637AbfEVOqU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 10:46:20 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:35962 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729621AbfEVOqS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 10:46:18 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4MEhtij053426
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2019 10:46:17 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2sn85es43u-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2019 10:46:17 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <tmricht@linux.ibm.com>;
        Wed, 22 May 2019 15:46:15 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 22 May 2019 15:46:12 +0100
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x4MEkB0j49545378
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 May 2019 14:46:12 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D5BE311C05B;
        Wed, 22 May 2019 14:46:11 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 99DFD11C052;
        Wed, 22 May 2019 14:46:11 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 22 May 2019 14:46:11 +0000 (GMT)
From:   Thomas Richter <tmricht@linux.ibm.com>
To:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org
Cc:     brueckner@linux.vnet.ibm.com, heiko.carstens@de.ibm.com,
        Thomas Richter <tmricht@linux.ibm.com>
Subject: [PATCH 3/3] perf record: Fix s390 missing module symbol and warning for non-root users
Date:   Wed, 22 May 2019 16:46:01 +0200
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190522144601.50763-1-tmricht@linux.ibm.com>
References: <20190522144601.50763-1-tmricht@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19052214-0012-0000-0000-0000031E547A
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19052214-0013-0000-0000-000021570A1E
Message-Id: <20190522144601.50763-4-tmricht@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-22_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905220104
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Command 'perf record' and 'perf report' on a system without kernel
debuginfo packages uses /proc/kallsyms and /proc/modules to find
addresses for kernel and module symbols. On x86 this works for root
and non-root users.

On s390, when invoked as non-root user, many of the following warnings
are shown and module symbols are missing:

    proc/{kallsyms,modules} inconsistency while looking for
        "[sha1_s390]" module!

Command 'perf record' creates a list of module start addresses by
parsing the output of /proc/modules and creates a PERF_RECORD_MMAP
record for the kernel and each module. The following function call
sequence is executed:

  machine__create_kernel_maps
    machine__create_module
      modules__parse
        machine__create_module --> for each line in /proc/modules
          arch__fix_module_text_start

Function arch__fix_module_text_start() is s390 specific. It opens
file /sys/module/<name>/sections/.text to extract the module's .text
section start address. On s390 the module loader prepends a header
before the first section, whereas on x86 the module's text section
address is identical the the module's load address.

However module section files are root readable only. For non-root the
read operation fails and machine__create_module() returns an error.
Command perf record does not generate any PERF_RECORD_MMAP record
for loaded modules. Later command perf report complains about missing
module maps.

To fix this function arch__fix_module_text_start() always returns
success. For root users there is no change, for non-root users
the module's load address is used as module's text start address
(the prepended header then counts as part of the text section).

This enable non-root users to use module symbols and avoid the
warning when perf report is executed.

Output before:
 [tmricht@m83lp54 perf]$ ./perf report -D | fgrep MMAP
 0 0x168 [0x50]: PERF_RECORD_MMAP ... x [kernel.kallsyms]_text

Output after:
 [tmricht@m83lp54 perf]$ ./perf report -D | fgrep MMAP
 0 0x168 [0x50]: PERF_RECORD_MMAP ... x [kernel.kallsyms]_text
 0 0x1b8 [0x98]: PERF_RECORD_MMAP ... x /lib/modules/.../autofs4.ko.xz
 0 0x250 [0xa8]: PERF_RECORD_MMAP ... x /lib/modules/.../sha_common.ko.xz
 0 0x2f8 [0x98]: PERF_RECORD_MMAP ... x /lib/modules/.../des_generic.ko.xz

Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
Reviewed-by: Hendrik Brueckner <brueckner@linux.ibm.com>
---
 tools/perf/arch/s390/util/machine.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/tools/perf/arch/s390/util/machine.c b/tools/perf/arch/s390/util/machine.c
index 0b2054007314..a19690a17291 100644
--- a/tools/perf/arch/s390/util/machine.c
+++ b/tools/perf/arch/s390/util/machine.c
@@ -5,16 +5,19 @@
 #include "util.h"
 #include "machine.h"
 #include "api/fs/fs.h"
+#include "debug.h"
 
 int arch__fix_module_text_start(u64 *start, const char *name)
 {
+	u64 m_start = *start;
 	char path[PATH_MAX];
 
 	snprintf(path, PATH_MAX, "module/%.*s/sections/.text",
 				(int)strlen(name) - 2, name + 1);
-
-	if (sysfs__read_ull(path, (unsigned long long *)start) < 0)
-		return -1;
+	if (sysfs__read_ull(path, (unsigned long long *)start) < 0) {
+		pr_debug2("Using module %s start:%#lx\n", path, m_start);
+		*start = m_start;
+	}
 
 	return 0;
 }
-- 
2.19.1

