Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26F90C3A5A6
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 01:40:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E74A820679
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 01:40:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b="LW6iKhCZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728974AbfH0Bk3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 21:40:29 -0400
Received: from mx0b-00190b01.pphosted.com ([67.231.157.127]:19382 "EHLO
        mx0b-00190b01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728571AbfH0Bk2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 21:40:28 -0400
Received: from pps.filterd (m0050102.ppops.net [127.0.0.1])
        by m0050102.ppops.net-00190b01. (8.16.0.42/8.16.0.42) with SMTP id x7R1c3lC007643;
        Tue, 27 Aug 2019 02:39:52 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=jan2016.eng;
 bh=i/fS3kaYLIQIoeCLN0aSMpme087olJ0xn55iGTg1BP8=;
 b=LW6iKhCZiAvAnOiHuw4pHX6jL6VhNewE78rlc3fFfJ1m+M5QK0EewhhRWARmG+BetR22
 3ZPz4GqktmSKFceOOhbAy34Cnp4/e1ET8uMq2sWFpI95riJsvnhfS0WOQ1HCOjW7IpFx
 /+4RyH7r+PVZ0VPoKRrqUiGe/EZPAeWBf+/5kb05ngCGslJlOFrQDqFJfBXTP0vDLtUc
 sB+JANrth4txHMgtAZGJTB51KgqtRYOIIpCooKmTe5KiW7GZA3a/Qt6UPR3ISQ6JN5XC
 YO+zEESr6YQdHMTFV69RnTRK1+iwl6zxGNre6+Ah2u/MDD5bM82E+rp4UNAt1Z44JyZg 6A== 
Received: from prod-mail-ppoint4 (prod-mail-ppoint4.akamai.com [96.6.114.87] (may be forged))
        by m0050102.ppops.net-00190b01. with ESMTP id 2ujwcyjmgy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 27 Aug 2019 02:39:52 +0100
Received: from pps.filterd (prod-mail-ppoint4.akamai.com [127.0.0.1])
        by prod-mail-ppoint4.akamai.com (8.16.0.27/8.16.0.27) with SMTP id x7R1VoC5014957;
        Mon, 26 Aug 2019 21:39:51 -0400
Received: from email.msg.corp.akamai.com ([172.27.123.53])
        by prod-mail-ppoint4.akamai.com with ESMTP id 2uk0k0bb1t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 26 Aug 2019 21:39:51 -0400
Received: from usma1ex-cas5.msg.corp.akamai.com (172.27.123.53) by
 usma1ex-dag1mb1.msg.corp.akamai.com (172.27.123.101) with Microsoft SMTP
 Server (TLS) id 15.0.1473.3; Mon, 26 Aug 2019 21:39:50 -0400
Received: from igorcastle.kendall.corp.akamai.com (172.29.170.135) by
 usma1ex-cas5.msg.corp.akamai.com (172.27.123.53) with Microsoft SMTP Server
 id 15.0.1473.3 via Frontend Transport; Mon, 26 Aug 2019 18:39:44 -0700
Received: by igorcastle.kendall.corp.akamai.com (Postfix, from userid 29659)
        id 4CBF064C11; Mon, 26 Aug 2019 21:39:42 -0400 (EDT)
From:   Igor Lubashev <ilubashe@akamai.com>
To:     Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
CC:     Igor Lubashev <ilubashe@akamai.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        James Morris <jmorris@namei.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Suzuki Poulouse <suzuki.poulose@arm.com>,
        <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH 5/5] perf: warn that perf_event_paranoid can restrict kernel symbols
Date:   Mon, 26 Aug 2019 21:39:16 -0400
Message-ID: <1566869956-7154-6-git-send-email-ilubashe@akamai.com>
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
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0
 lowpriorityscore=0 clxscore=1015 adultscore=0 priorityscore=1501
 malwarescore=0 phishscore=0 impostorscore=0 bulkscore=0 mlxlogscore=999
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1906280000 definitions=main-1908270015
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Warn that /proc/sys/kernel/perf_event_paranoid can also restrict kernel
symbols.

Signed-off-by: Igor Lubashev <ilubashe@akamai.com>
---
 tools/perf/builtin-record.c | 2 +-
 tools/perf/builtin-top.c    | 2 +-
 tools/perf/builtin-trace.c  | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index f71631f2bcb5..18505d92ff69 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -2372,7 +2372,7 @@ int cmd_record(int argc, const char **argv)
 	if (symbol_conf.kptr_restrict && !perf_evlist__exclude_kernel(rec->evlist))
 		pr_warning(
 "WARNING: Kernel address maps (/proc/{kallsyms,modules}) are restricted,\n"
-"check /proc/sys/kernel/kptr_restrict.\n\n"
+"check /proc/sys/kernel/kptr_restrict and /proc/sys/kernel/perf_event_paranoid.\n\n"
 "Samples in kernel functions may not be resolved if a suitable vmlinux\n"
 "file is not found in the buildid cache or in the vmlinux path.\n\n"
 "Samples in kernel modules won't be resolved at all.\n\n"
diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index 5970723cd55a..29e910fb2d9a 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -770,7 +770,7 @@ static void perf_event__process_sample(struct perf_tool *tool,
 		if (!perf_evlist__exclude_kernel(top->session->evlist)) {
 			ui__warning(
 "Kernel address maps (/proc/{kallsyms,modules}) are restricted.\n\n"
-"Check /proc/sys/kernel/kptr_restrict.\n\n"
+"Check /proc/sys/kernel/kptr_restrict and /proc/sys/kernel/perf_event_paranoid.\n\n"
 "Kernel%s samples will not be resolved.\n",
 			  al.map && map__has_symbols(al.map) ?
 			  " modules" : "");
diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index bc44ed29e05a..9443b8e05810 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -1381,7 +1381,7 @@ static char *trace__machine__resolve_kernel_addr(void *vmachine, unsigned long l
 
 	if (symbol_conf.kptr_restrict) {
 		pr_warning("Kernel address maps (/proc/{kallsyms,modules}) are restricted.\n\n"
-			   "Check /proc/sys/kernel/kptr_restrict.\n\n"
+			   "Check /proc/sys/kernel/kptr_restrict and /proc/sys/kernel/perf_event_paranoid.\n\n"
 			   "Kernel samples will not be resolved.\n");
 		machine->kptr_restrict_warned = true;
 		return NULL;
-- 
2.7.4

