Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ED71C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 14:20:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53FAD2082C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 14:20:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728040AbfDAOUW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 10:20:22 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:38884 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726841AbfDAOUV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 10:20:21 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x31EEbvc037942
        for <linux-kernel@vger.kernel.org>; Mon, 1 Apr 2019 10:20:20 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2rkku5adhh-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2019 10:20:19 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <tmricht@linux.ibm.com>;
        Mon, 1 Apr 2019 15:20:16 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 1 Apr 2019 15:20:14 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x31EKEWt53280816
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 1 Apr 2019 14:20:14 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E4890A4051;
        Mon,  1 Apr 2019 14:20:13 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9B4D4A4055;
        Mon,  1 Apr 2019 14:20:13 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon,  1 Apr 2019 14:20:13 +0000 (GMT)
From:   Thomas Richter <tmricht@linux.ibm.com>
To:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org
Cc:     brueckner@linux.vnet.ibm.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, Thomas Richter <tmricht@linux.ibm.com>
Subject: [PATCH] perf/report: [RFC] Handling OOM in perf report
Date:   Mon,  1 Apr 2019 16:20:00 +0200
X-Mailer: git-send-email 2.16.4
X-TM-AS-GCONF: 00
x-cbid: 19040114-0020-0000-0000-0000032A3D64
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19040114-0021-0000-0000-0000217C9646
Message-Id: <20190401142000.17679-1-tmricht@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-01_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904010097
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A very strange -ENOMEM error which only when output
is displayed using the GTK GUI (I have copied the text from the GUI):

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

It always fails in the FINISHED_ROUND event, event number 68.

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

This occured in the FINISHED_ROUND event when it has to process some
10000 entries and ran out of memory.

I understand that my perf.data file might just be too big, but I would
like to see some error message indicating OOM error instead of
processing failure of a unrelated event.

However this patch just does what the pr_debug() statement indicates,
the event is skipped and processing continues.
But at least the root cause is indicated and also shows up in the
GUI.

Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
---
 tools/perf/builtin-report.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index 4054eb1f98ac..7a27b815f7a8 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -283,8 +283,13 @@ static int process_sample_event(struct perf_tool *tool,
 		al.map->dso->hit = 1;
 
 	ret = hist_entry_iter__add(&iter, &al, rep->max_stack, rep);
-	if (ret < 0)
+	if (ret < 0) {
 		pr_debug("problem adding hist entry, skipping event\n");
+		if (ret == -ENOMEM) {
+			pr_err("Running out of memory\n");
+			ret = 0;
+		}
+	}
 out_put:
 	addr_location__put(&al);
 	return ret;
-- 
2.16.4

