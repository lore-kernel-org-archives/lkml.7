Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6041CA9EA0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 01:56:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 910492064A
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 01:56:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b="DpcUbxTW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387854AbfJWBz5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 21:55:57 -0400
Received: from mx0a-00190b01.pphosted.com ([67.231.149.131]:30260 "EHLO
        mx0a-00190b01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1733083AbfJWBz5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 21:55:57 -0400
Received: from pps.filterd (m0122332.ppops.net [127.0.0.1])
        by mx0a-00190b01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x9N1rNVh029351;
        Wed, 23 Oct 2019 02:55:41 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=jan2016.eng;
 bh=nksER0KqvgDe+8BGIyptDyrjqneiS3g2E6F9bokhk5E=;
 b=DpcUbxTWhuNgcA24dOLORYy4UfHsuF0UPAAg4UdqQD8iMrET/qG6InS6en4YLKW4x5Vt
 /0rZs4qsBgVuock8sNZpBRyIw+pP5U9nntENrgV3nDuxA221Ssq+UYhHbUS+Y1wyMRsP
 a+IwxImeDAA8B2/CDKUb2nWj6o24vAWmCfB9Jo0o6q2oDWC8w+Kzf3zsclfKIjdywB3l
 IrAfWr+i38x/8AMgVMlXqG9hRKA8Ruqj30TBHKzwQZZl3s8HTeZFTEUIfDACeKllio74
 /1S0Lg502sBAVHi1g5A00pCEZ3ifd42DAaHWX+tHJyAlyhBzh/buWrjk9G38294Dn95t zA== 
Received: from prod-mail-ppoint1 (prod-mail-ppoint1.akamai.com [184.51.33.18] (may be forged))
        by mx0a-00190b01.pphosted.com with ESMTP id 2vqthjjek1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 23 Oct 2019 02:55:41 +0100
Received: from pps.filterd (prod-mail-ppoint1.akamai.com [127.0.0.1])
        by prod-mail-ppoint1.akamai.com (8.16.0.27/8.16.0.27) with SMTP id x9N1lCuB024927;
        Tue, 22 Oct 2019 21:55:40 -0400
Received: from email.msg.corp.akamai.com ([172.27.123.33])
        by prod-mail-ppoint1.akamai.com with ESMTP id 2vqwtwq07e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 22 Oct 2019 21:55:39 -0400
Received: from USMA1EX-CAS2.msg.corp.akamai.com (172.27.123.31) by
 usma1ex-dag1mb6.msg.corp.akamai.com (172.27.123.65) with Microsoft SMTP
 Server (TLS) id 15.0.1473.3; Tue, 22 Oct 2019 21:55:39 -0400
Received: from igorcastle.kendall.corp.akamai.com (172.29.170.135) by
 USMA1EX-CAS2.msg.corp.akamai.com (172.27.123.31) with Microsoft SMTP Server
 id 15.0.1473.3 via Frontend Transport; Tue, 22 Oct 2019 21:55:39 -0400
Received: by igorcastle.kendall.corp.akamai.com (Postfix, from userid 29659)
        id 5028461E43; Tue, 22 Oct 2019 21:55:37 -0400 (EDT)
From:   Igor Lubashev <ilubashe@akamai.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
CC:     Igor Lubashev <ilubashe@akamai.com>, Jiri Olsa <jolsa@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/3] perf top: Allow running without stdin
Date:   Tue, 22 Oct 2019 21:54:51 -0400
Message-ID: <1571795693-23558-2-git-send-email-ilubashe@akamai.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1571795693-23558-1-git-send-email-ilubashe@akamai.com>
References: <1571795693-23558-1-git-send-email-ilubashe@akamai.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-10-22_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910230015
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-23_01:2019-10-22,2019-10-23 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0
 priorityscore=1501 malwarescore=0 mlxlogscore=999 bulkscore=0 phishscore=0
 adultscore=0 suspectscore=0 impostorscore=0 clxscore=1015
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1910230016
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow perf top --stdio to run without access to stdin.
This lets perf top to run in a batch mode until interrupted.

The following now works as expected:

  $ perf top < /dev/null

Signed-off-by: Igor Lubashev <ilubashe@akamai.com>
---
 tools/perf/builtin-top.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index d96f24c8770d..fbc0dc135b8a 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -665,6 +665,7 @@ static void display_setup_sig(void)
 static void *display_thread(void *arg)
 {
 	struct pollfd stdin_poll = { .fd = 0, .events = POLLIN };
+	nfds_t nfds = 1;
 	struct termios save;
 	struct perf_top *top = arg;
 	int delay_msecs, c;
@@ -684,7 +685,8 @@ static void *display_thread(void *arg)
 	delay_msecs = top->delay_secs * MSEC_PER_SEC;
 	set_term_quiet_input(&save);
 	/* trash return*/
-	getc(stdin);
+	if (getc(stdin) == EOF)
+		nfds = 0;
 
 	while (!done) {
 		perf_top__print_sym_table(top);
@@ -692,7 +694,7 @@ static void *display_thread(void *arg)
 		 * Either timeout expired or we got an EINTR due to SIGWINCH,
 		 * refresh screen in both cases.
 		 */
-		switch (poll(&stdin_poll, 1, delay_msecs)) {
+		switch (poll(&stdin_poll, nfds, delay_msecs)) {
 		case 0:
 			continue;
 		case -1:
@@ -701,6 +703,10 @@ static void *display_thread(void *arg)
 			__fallthrough;
 		default:
 			c = getc(stdin);
+			if (c == EOF) {
+				nfds = 0;
+				continue;
+			}
 			tcsetattr(0, TCSAFLUSH, &save);
 
 			if (perf_top__handle_keypress(top, c))
-- 
2.7.4

