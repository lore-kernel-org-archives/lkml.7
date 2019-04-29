Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9077C43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 07:50:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 984D32075E
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 07:50:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727543AbfD2Huo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 03:50:44 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:59510 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727362AbfD2Hun (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 03:50:43 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3T7oB1J065691
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2019 03:50:42 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2s5w7u8108-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2019 03:50:41 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <tmricht@linux.ibm.com>;
        Mon, 29 Apr 2019 08:50:40 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 29 Apr 2019 08:50:38 +0100
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x3T7obVR57409618
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 29 Apr 2019 07:50:37 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 47EBB11C052;
        Mon, 29 Apr 2019 07:50:37 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 022F711C050;
        Mon, 29 Apr 2019 07:50:37 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 29 Apr 2019 07:50:36 +0000 (GMT)
From:   Thomas Richter <tmricht@linux.ibm.com>
To:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org
Cc:     brueckner@linux.vnet.ibm.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, Thomas Richter <tmricht@linux.ibm.com>
Subject: [PATCHv2] perf/report: Report OOM in perf report status line
Date:   Mon, 29 Apr 2019 09:50:33 +0200
X-Mailer: git-send-email 2.16.4
X-TM-AS-GCONF: 00
x-cbid: 19042907-4275-0000-0000-0000032F6FF9
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19042907-4276-0000-0000-0000383EC436
Message-Id: <20190429075033.68680-1-tmricht@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-29_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904290059
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

An -ENOMEM error is not reported in the GTK GUI.
Instead this error message pops up on the screen:

[root@m35lp76 perf]# ./perf  report -i perf.data.error68-1

	Processing events... [974K/3M]
	Error:failed to process sample

	0xf4198 [0x8]: failed to process type: 68

However when I use the same perf.data file with --stdio it works:

[root@m35lp76 perf]# ./perf  report -i perf.data.error68-1 --stdio \
		| head -12

  # Total Lost Samples: 0
  #
  # Samples: 76K of event 'cycles'
  # Event count (approx.): 99056160000
  #
  # Overhead  Command          Shared Object      Symbol
  # ........  ...............  .................  .........
  #
     8.81%  find             [kernel.kallsyms]  [k] ftrace_likely_update
     8.74%  swapper          [kernel.kallsyms]  [k] ftrace_likely_update
     8.34%  sshd             [kernel.kallsyms]  [k] ftrace_likely_update
     2.19%  kworker/u512:1-  [kernel.kallsyms]  [k] ftrace_likely_update

The sample precentage is a bit low.....

The GUI always fails in the FINISHED_ROUND event (68) and does not
indicate the reason why.

When happened is the following. Perf report calls a lot of functions and
down deep when a FINISHED_ROUND event is processed, these functions are
called:

  perf_session__process_event()
  + perf_session__process_user_event()
    + process_finished_round()
      + ordered_events__flush()
        + __ordered_events__flush()
	  + do_flush()
	    + ordered_events__deliver_event()
	      + perf_session__deliver_event()
	        + machine__deliver_event()
	          + perf_evlist__deliver_event()
	            + process_sample_event()
	              + hist_entry_iter_add() --> only called in GUI case!!!
	                + hist_iter__report__callback()
	                  + symbol__inc_addr_sample()

	                    Now this functions runs out of memory and
			    returns -ENOMEM. This is reported all the way up
			    until function

perf_session__process_event() returns to its caller, where -ENOMEM is
changed to -EINVAL and processing stops:

 if ((skip = perf_session__process_event(session, event, head)) < 0) {
      pr_err("%#" PRIx64 " [%#x]: failed to process type: %d\n",
	     head, event->header.size, event->header.type);
      err = -EINVAL;
      goto out_err;
 }

This occurred in the FINISHED_ROUND event when it has to process some
10000 entries and ran out of memory.

This patch indicates the root cause and displays it in the status line
of ther perf report GUI.

Output before (on GUI status line):
0xf4198 [0x8]: failed to process type: 68

Output after:
0xf4198 [0x8]: failed to process type: 68 [not enough memory]

Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
Reviewed-by: Jiri Olsa <jolsa@redhat.com>
Reviewed-by: Hendrik Brueckner <brueckner@linux.ibm.com>
---
 tools/perf/util/session.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index b17f1c9bc965..267d3f8fcc0f 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -1930,10 +1930,17 @@ reader__process_events(struct reader *rd, struct perf_session *session,
 
 	if (size < sizeof(struct perf_event_header) ||
 	    (skip = rd->process(session, event, file_pos)) < 0) {
-		pr_err("%#" PRIx64 " [%#x]: failed to process type: %d\n",
-		       file_offset + head, event->header.size,
-		       event->header.type);
-		err = -EINVAL;
+		if (skip < 0) {
+			pr_err("%#" PRIx64 " [%#x]: failed to process type: %d [%s]\n",
+			       file_offset + head, event->header.size,
+			       event->header.type, strerror(-skip));
+			err = skip;
+		} else {
+			pr_err("%#" PRIx64 " [%#x]: failed to process type: %d\n",
+			       file_offset + head, event->header.size,
+			       event->header.type);
+			err = -EINVAL;
+		}
 		goto out;
 	}
 
-- 
2.19.1

