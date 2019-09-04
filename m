Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89D36C3A5A7
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 09:48:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FD7F2339D
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 09:48:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729803AbfIDJsG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 05:48:06 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:51008 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725840AbfIDJsG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 05:48:06 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x849hTGC009060
        for <linux-kernel@vger.kernel.org>; Wed, 4 Sep 2019 05:48:04 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2ut88w5r82-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2019 05:48:04 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <srikar@linux.vnet.ibm.com>;
        Wed, 4 Sep 2019 10:48:02 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 4 Sep 2019 10:48:00 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x849lxJl48300254
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 4 Sep 2019 09:47:59 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9355EA405B;
        Wed,  4 Sep 2019 09:47:59 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 58714A404D;
        Wed,  4 Sep 2019 09:47:58 +0000 (GMT)
Received: from srikart450.in.ibm.com (unknown [9.122.211.65])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed,  4 Sep 2019 09:47:58 +0000 (GMT)
From:   Srikar Dronamraju <srikar@linux.vnet.ibm.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Naveen N Rao <naveen.n.rao@linux.vnet.ibm.com>
Subject: [PATCH 2/2] perf/stat: Fix a segmentation fault when using repeat forever
Date:   Wed,  4 Sep 2019 15:17:38 +0530
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190904094738.9558-1-srikar@linux.vnet.ibm.com>
References: <20190904094738.9558-1-srikar@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19090409-4275-0000-0000-00000360F84C
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19090409-4276-0000-0000-000038733CC9
Message-Id: <20190904094738.9558-3-srikar@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-09-04_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1909040096
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Observe a segmentation fault when perf stat is asked to repeat forever
with the interval option.

Without fix:
perf stat -r 0 -I 5000 -e cycles -a sleep 10
 #           time             counts unit events
     5.000211692  3,13,89,82,34,157      cycles
    10.000380119  1,53,98,52,22,294      cycles
    10.040467280       17,16,79,265      cycles
Segmentation fault

This problem was only observed when we use forever option aka -r 0 and
works with limited repeats. Calling print_counter with ts being set to
NULL, is not a correct option when interval is set. Hence avoid
print_counter(NULL,..)  if interval is set.

With fix:
perf stat -r 0 -I 5000 -e cycles -a sleep 10
 #           time             counts unit events
     5.019866622  3,15,14,43,08,697      cycles
    10.039865756  3,15,16,31,95,261      cycles
    10.059950628     1,26,05,47,158      cycles
     5.009902655  3,14,52,62,33,932      cycles
    10.019880228  3,14,52,22,89,154      cycles
    10.030543876       66,90,18,333      cycles
     5.009848281  3,14,51,98,25,437      cycles
    10.029854402  3,15,14,93,04,918      cycles
     5.009834177  3,14,51,95,92,316      cycles

Signed-off-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
---
 tools/perf/builtin-stat.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index eda451842bfd..8ec06bf3372c 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -1965,7 +1965,7 @@ int cmd_stat(int argc, const char **argv)
 			perf_evlist__reset_prev_raw_counts(evsel_list);
 
 		status = run_perf_stat(argc, argv, run_idx);
-		if (forever && status != -1) {
+		if (forever && status != -1 && !interval) {
 			print_counters(NULL, argc, argv);
 			perf_stat__reset_stats();
 		}
-- 
2.18.1

