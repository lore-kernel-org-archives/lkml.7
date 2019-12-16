Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 052B0C43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 13:46:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D74E220409
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 13:46:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727995AbfLPNqP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 08:46:15 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:40592 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727826AbfLPNqP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 08:46:15 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBGDcWru076427
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2019 08:46:13 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2wwe8ab57m-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2019 08:46:13 -0500
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <tmricht@linux.ibm.com>;
        Mon, 16 Dec 2019 13:46:12 -0000
Received: from b06avi18626390.portsmouth.uk.ibm.com (9.149.26.192)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 16 Dec 2019 13:46:09 -0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xBGDjOoG42140074
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 16 Dec 2019 13:45:24 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7407F4C050;
        Mon, 16 Dec 2019 13:46:07 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 311524C044;
        Mon, 16 Dec 2019 13:46:07 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 16 Dec 2019 13:46:07 +0000 (GMT)
From:   Thomas Richter <tmricht@linux.ibm.com>
To:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org
Cc:     gor@linux.ibm.com, sumanthk@llinux.ibm.com,
        heiko.carstens@de.ibm.com, Thomas Richter <tmricht@linux.ibm.com>
Subject: [PATCH] perf probe: Add ustring support for perf probe command
Date:   Mon, 16 Dec 2019 14:45:55 +0100
X-Mailer: git-send-email 2.17.1
X-TM-AS-GCONF: 00
x-cbid: 19121613-0016-0000-0000-000002D564E6
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19121613-0017-0000-0000-0000333798F4
Message-Id: <20191216134556.45064-1-tmricht@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-16_05:2019-12-16,2019-12-16 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 phishscore=0 lowpriorityscore=0 malwarescore=0 priorityscore=1501
 adultscore=0 mlxscore=0 clxscore=1015 mlxlogscore=999 spamscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912160122
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel commit 88903c464321 ("tracing/probe: Add ustring type for user-space string")
adds support for user-space strings when type ustring is specified.

Here is an example using command line setup of the kprobe.

Function to probe:
  struct filename *
  getname_flags(const char __user *filename, int flags, int *empty)

Setup:
  # cd /sys/kernel/debug/tracing/
  # echo 'p:tmr1 getname_flags +0(%r2):ustring' > kprobe_events
  # cat events/kprobes/tmr1/format | fgrep print
  print fmt: "(%lx) arg1=\"%s\"", REC->__probe_ip, REC->arg1
  # echo 1 > events/kprobes/tmr1/enable
  # touch /tmp/111
  # echo 0 > events/kprobes/tmr1/enable
  # cat trace|fgrep /tmp/111
  touch-5846  [005] d..2 255520.717960: tmr1:\
	  (getname_flags+0x0/0x400) arg1="/tmp/111"

Doing the same with the perf tool fails. First using string succeeds:
 # perf probe "vfs_getname=getname_flags:72 pathname=filename:string"
 Added new event:
   probe:vfs_getname (on getname_flags:72 with pathname=filename:string)
   ....
 # perf probe -d probe:vfs_getname
 Removed event: probe:vfs_getname

Using ustring fails (output before):
 # perf probe "vfs_getname=getname_flags:72 pathname=filename:ustring"
 Failed to write event: Invalid argument
   Error: Failed to add events.
 #

Fix this by added type 'ustring' in function convert_variable_type().

Using ustring succeeds (output after):
 # ./perf probe "vfs_getname=getname_flags:72 pathname=filename:ustring"
 Added new event:
   probe:vfs_getname (on getname_flags:72 with pathname=filename:ustring)

 You can now use it in all perf tools, such as:

	perf record -e probe:vfs_getname -aR sleep 1

 #

Note: This issue also exists on x86, it is not s390 specific.

Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
---
 tools/perf/util/probe-finder.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/probe-finder.c b/tools/perf/util/probe-finder.c
index c470c49a804f..1c817add6ca4 100644
--- a/tools/perf/util/probe-finder.c
+++ b/tools/perf/util/probe-finder.c
@@ -303,7 +303,8 @@ static int convert_variable_type(Dwarf_Die *vr_die,
 	char prefix;
 
 	/* TODO: check all types */
-	if (cast && strcmp(cast, "string") != 0 && strcmp(cast, "x") != 0 &&
+	if (cast && strcmp(cast, "string") != 0 && strcmp(cast, "ustring") &&
+	    strcmp(cast, "x") != 0 &&
 	    strcmp(cast, "s") != 0 && strcmp(cast, "u") != 0) {
 		/* Non string type is OK */
 		/* and respect signedness/hexadecimal cast */
-- 
2.21.0

