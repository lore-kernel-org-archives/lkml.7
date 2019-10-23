Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E85F7CA9EB9
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 01:56:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF2BF20679
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 01:56:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b="YX7sWPJf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387979AbfJWBz6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 21:55:58 -0400
Received: from mx0a-00190b01.pphosted.com ([67.231.149.131]:65440 "EHLO
        mx0a-00190b01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730121AbfJWBz5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 21:55:57 -0400
Received: from pps.filterd (m0050093.ppops.net [127.0.0.1])
        by m0050093.ppops.net-00190b01. (8.16.0.42/8.16.0.42) with SMTP id x9N1rTKi005114;
        Wed, 23 Oct 2019 02:55:41 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=jan2016.eng;
 bh=88d6uOobOlkC3W2zdU9dP/pzc0ViYbS9kMBUXxMm6tM=;
 b=YX7sWPJfqVcJ7xkV+XLkmSOhaOIuNYWbK1C09zxbjDgzvvhaL1TVumx27eumwF0krP2w
 5MtiCKLhdEg9LYzUpyOy1alzh9vZC50KYiPbFJ5qUYa2z1dJi5GxKPZBVzCw1p1x+Ilh
 6oNYrqhpCMfUt6BKnAxqpxGFE3nOmVVGXFBKbkkS3r8wGtvcJa8DvBLv/ia8+4IoYooS
 mSocaFbGMu5gfAxR2gE/ahlWQiDTqhboy5q9hgKz1q9IKNRTXK1xKSo6tM8YoIn3MbHq
 qQ3FIkDcn+bTLHVLgOhN0bptIvFml/SVbuK4nuNylxBzjTUdxbGqClX5rQAFrVbSn9Mh oQ== 
Received: from prod-mail-ppoint1 (prod-mail-ppoint1.akamai.com [184.51.33.18] (may be forged))
        by m0050093.ppops.net-00190b01. with ESMTP id 2vsyugbfp5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 23 Oct 2019 02:55:41 +0100
Received: from pps.filterd (prod-mail-ppoint1.akamai.com [127.0.0.1])
        by prod-mail-ppoint1.akamai.com (8.16.0.27/8.16.0.27) with SMTP id x9N1lFqg024955;
        Tue, 22 Oct 2019 21:55:40 -0400
Received: from email.msg.corp.akamai.com ([172.27.123.34])
        by prod-mail-ppoint1.akamai.com with ESMTP id 2vqwtwq07f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 22 Oct 2019 21:55:39 -0400
Received: from USMA1EX-CAS3.msg.corp.akamai.com (172.27.123.32) by
 usma1ex-dag1mb2.msg.corp.akamai.com (172.27.123.102) with Microsoft SMTP
 Server (TLS) id 15.0.1473.3; Tue, 22 Oct 2019 21:55:39 -0400
Received: from igorcastle.kendall.corp.akamai.com (172.29.170.135) by
 USMA1EX-CAS3.msg.corp.akamai.com (172.27.123.32) with Microsoft SMTP Server
 id 15.0.1473.3 via Frontend Transport; Tue, 22 Oct 2019 21:55:39 -0400
Received: by igorcastle.kendall.corp.akamai.com (Postfix, from userid 29659)
        id 5135F61E60; Tue, 22 Oct 2019 21:55:37 -0400 (EDT)
From:   Igor Lubashev <ilubashe@akamai.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
CC:     Igor Lubashev <ilubashe@akamai.com>, Jiri Olsa <jolsa@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/3] perf kvm: Allow running without stdin
Date:   Tue, 22 Oct 2019 21:54:52 -0400
Message-ID: <1571795693-23558-3-git-send-email-ilubashe@akamai.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1571795693-23558-1-git-send-email-ilubashe@akamai.com>
References: <1571795693-23558-1-git-send-email-ilubashe@akamai.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-10-22_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=995
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910230015
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-23_01:2019-10-22,2019-10-23 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 clxscore=1015
 priorityscore=1501 malwarescore=0 mlxscore=0 bulkscore=0 mlxlogscore=978
 adultscore=0 suspectscore=0 impostorscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1908290000
 definitions=main-1910230016
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow perf kvm --stdio to run without access to stdin.
This lets perf kvm to run in a batch mode until interrupted.

The following now works as expected:

  $ perf kvm top --stdio < /dev/null

Signed-off-by: Igor Lubashev <ilubashe@akamai.com>
---
 tools/perf/builtin-kvm.c | 33 ++++++++++++++++++++-------------
 1 file changed, 20 insertions(+), 13 deletions(-)

diff --git a/tools/perf/builtin-kvm.c b/tools/perf/builtin-kvm.c
index 858da896b518..5217aa3596c7 100644
--- a/tools/perf/builtin-kvm.c
+++ b/tools/perf/builtin-kvm.c
@@ -930,18 +930,20 @@ static int fd_set_nonblock(int fd)
 
 static int perf_kvm__handle_stdin(void)
 {
-	int c;
-
-	c = getc(stdin);
-	if (c == 'q')
+	switch (getc(stdin)) {
+	case 'q':
+		done = 1;
 		return 1;
-
-	return 0;
+	case EOF:
+		return 0;
+	default:
+		return 1;
+	}
 }
 
 static int kvm_events_live_report(struct perf_kvm_stat *kvm)
 {
-	int nr_stdin, ret, err = -EINVAL;
+	int nr_stdin = -1, ret, err = -EINVAL;
 	struct termios save;
 
 	/* live flag must be set first */
@@ -972,13 +974,16 @@ static int kvm_events_live_report(struct perf_kvm_stat *kvm)
 	if (evlist__add_pollfd(kvm->evlist, kvm->timerfd) < 0)
 		goto out;
 
-	nr_stdin = evlist__add_pollfd(kvm->evlist, fileno(stdin));
-	if (nr_stdin < 0)
-		goto out;
-
 	if (fd_set_nonblock(fileno(stdin)) != 0)
 		goto out;
 
+	/* add stdin, if it is connected */
+	if (getc(stdin) != EOF) {
+		nr_stdin = evlist__add_pollfd(kvm->evlist, fileno(stdin));
+		if (nr_stdin < 0)
+			goto out;
+	}
+
 	/* everything is good - enable the events and process */
 	evlist__enable(kvm->evlist);
 
@@ -994,8 +999,10 @@ static int kvm_events_live_report(struct perf_kvm_stat *kvm)
 		if (err)
 			goto out;
 
-		if (fda->entries[nr_stdin].revents & POLLIN)
-			done = perf_kvm__handle_stdin();
+		if (nr_stdin >= 0 && fda->entries[nr_stdin].revents & POLLIN) {
+			if (!perf_kvm__handle_stdin())
+				fda->entries[nr_stdin].events = 0;
+		}
 
 		if (!rc && !done)
 			err = fdarray__poll(fda, 100);
-- 
2.7.4

