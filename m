Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD22CCA9EAF
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 08:40:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A051920874
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 08:40:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726347AbfJ3Ika (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 04:40:30 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:5960 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726028AbfJ3Ik3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 04:40:29 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x9U8c6e1025635;
        Wed, 30 Oct 2019 04:38:45 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2vy6j519kq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 30 Oct 2019 04:38:44 -0400
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x9U8ciIo027923;
        Wed, 30 Oct 2019 04:38:44 -0400
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com [169.47.144.26])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2vy6j519jp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 30 Oct 2019 04:38:44 -0400
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
        by ppma04wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x9U8UsRA005183;
        Wed, 30 Oct 2019 08:38:42 GMT
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com [9.57.198.26])
        by ppma04wdc.us.ibm.com with ESMTP id 2vxwh541jy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 30 Oct 2019 08:38:42 +0000
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com [9.57.199.111])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x9U8cdkE14942778
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 30 Oct 2019 08:38:39 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5F311AC05E;
        Wed, 30 Oct 2019 08:38:39 +0000 (GMT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4BE12AC059;
        Wed, 30 Oct 2019 08:38:34 +0000 (GMT)
Received: from localhost.localdomain.com (unknown [9.102.3.6])
        by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed, 30 Oct 2019 08:38:34 +0000 (GMT)
From:   Chandan Rajendra <chandanrlinux@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Chandan Rajendra <chandanrlinux@gmail.com>,
        ravi.bangoria@linux.ibm.com, peterz@infradead.org,
        mingo@redhat.com, acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, rostedt@goodmis.org, tstoyanov@vmware.com,
        gregkh@linuxfoundation.org, kstewart@linuxfoundation.org,
        tglx@linutronix.de, chandan@linux.ibm.com
Subject: [PATCH] perf script: Fix obtaining next event
Date:   Wed, 30 Oct 2019 14:10:32 +0530
Message-Id: <20191030084032.31503-1-chandanrlinux@gmail.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-10-30_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=878 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1910300086
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current code segfaults when perf.data file contains two or more
events. This happens due to incorrect pointer arithmetic being performed
in trace_find_next_event().

tep_handle->events is an array of pointers to 'struct tep_event'. The
pointer arithmetic interprets tep_handle->events as an array of 'struct
tep_event' elements.

This commit replaces the usage of pointer arithmetic with calls to
tep_get_event().

Fixes: bb3dd7e ("tools lib traceevent, perf tools: Move struct tep_handler definition in a local header file")
Signed-off-by: Chandan Rajendra <chandanrlinux@gmail.com>
---
 tools/perf/util/trace-event-parse.c | 24 +++++++-----------------
 1 file changed, 7 insertions(+), 17 deletions(-)

diff --git a/tools/perf/util/trace-event-parse.c b/tools/perf/util/trace-event-parse.c
index 5d6bfc70b210..7bf423a3631e 100644
--- a/tools/perf/util/trace-event-parse.c
+++ b/tools/perf/util/trace-event-parse.c
@@ -176,31 +176,21 @@ int parse_event_file(struct tep_handle *pevent,
 struct tep_event *trace_find_next_event(struct tep_handle *pevent,
 					struct tep_event *event)
 {
-	static int idx;
+	int idx;
 	int events_count;
-	struct tep_event *all_events;
 
-	all_events = tep_get_first_event(pevent);
 	events_count = tep_get_events_count(pevent);
-	if (!pevent || !all_events || events_count < 1)
+	if (!pevent || events_count < 1)
 		return NULL;
 
-	if (!event) {
-		idx = 0;
-		return all_events;
-	}
+	if (!event)
+		return tep_get_event(pevent, 0);
 
-	if (idx < events_count && event == (all_events + idx)) {
-		idx++;
-		if (idx == events_count)
-			return NULL;
-		return (all_events + idx);
+	for (idx = 0; idx < events_count - 1; idx++) {
+		if (event == tep_get_event(pevent, idx))
+			return tep_get_event(pevent, idx + 1);
 	}
 
-	for (idx = 1; idx < events_count; idx++) {
-		if (event == (all_events + (idx - 1)))
-			return (all_events + idx);
-	}
 	return NULL;
 }
 
-- 
2.19.1

