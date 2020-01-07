Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60A9EC33C8C
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 12:22:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40A4D2070E
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 12:22:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728228AbgAGMWE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 07:22:04 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:20330 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728172AbgAGMWC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 07:22:02 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 007CHuUr048563
        for <linux-kernel@vger.kernel.org>; Tue, 7 Jan 2020 07:22:01 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2xar48suhv-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jan 2020 07:22:01 -0500
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <tmricht@linux.ibm.com>;
        Tue, 7 Jan 2020 12:21:59 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 7 Jan 2020 12:21:58 -0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 007CLu2J54591720
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 7 Jan 2020 12:21:56 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 576FF42041;
        Tue,  7 Jan 2020 12:21:56 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0CED442045;
        Tue,  7 Jan 2020 12:21:56 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  7 Jan 2020 12:21:55 +0000 (GMT)
From:   Thomas Richter <tmricht@linux.ibm.com>
To:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org, ak@linux.intel.com
Cc:     gor@linux.ibm.com, sumanthk@linux.ibm.com,
        heiko.carstens@de.ibm.com, Thomas Richter <tmricht@linux.ibm.com>
Subject: [PATCH] perf test: Fix test case Merge cpu map
Date:   Tue,  7 Jan 2020 13:21:50 +0100
X-Mailer: git-send-email 2.17.1
X-TM-AS-GCONF: 00
x-cbid: 20010712-0016-0000-0000-000002DB283B
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20010712-0017-0000-0000-0000333D9EDB
Message-Id: <20200107122150.9093-1-tmricht@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2020-01-07_03:2020-01-06,2020-01-07 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 mlxlogscore=999 impostorscore=0 mlxscore=0 priorityscore=1501
 lowpriorityscore=0 suspectscore=2 clxscore=1015 bulkscore=0 phishscore=0
 adultscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-2001070102
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit a2408a70368a ("perf evlist: Maintain evlist->all_cpus")
introduces a test case for cpumap merge operation, see functions
perf_cpu_map__merge() and test__cpu_map_merge().

The test case fails on s390 with this error message:
 [root@m35lp76 perf]# ./perf test -Fvvvvv 52
 52: Merge cpu map                                         :
 --- start ---
 cpumask list: 1-2,4-5,7
 perf: /root/linux/tools/include/linux/refcount.h:131:\
          refcount_sub_and_test: Assertion `!(new > val)' failed.
 Aborted (core dumped)
 [root@m35lp76 perf]#

The root cause is in the function test__cpu_map_merge():
It creates two cpu_maps named 'a' and 'b':

  struct perf_cpu_map *a = perf_cpu_map__new("4,2,1");
  struct perf_cpu_map *b = perf_cpu_map__new("4,5,7");

and creates a third map named 'c' which is the result of
the merge of maps a and b:

  struct perf_cpu_map *c = perf_cpu_map__merge(a, b);

After some verifaction of the merged cpu_map all three
of them are have their reference count reduced and are
freed:

   perf_cpu_map__put(a); (1)
   perf_cpu_map__put(b);
   perf_cpu_map__put(c);

The release of perf_cpu_map__put(a) is wrong. The map
is already released and free'ed as part of the function

  perf_cpu_map__merge(struct perf_cpu_map *orig,
  |	              struct perf_cpu_map *other)
  +--> perf_cpu_map__put(orig);
       |
       +--> cpu_map__delete(orig)

At the end perf_cpu_map_put() is called for map 'orig'
alias 'a' and since the reference count is 1, the map
is deleted, as can be seen by the following gdb trace:

 (gdb) where
 #0  tcache_put (tc_idx=0, chunk=0x156cc30) at malloc.c:2940
 #1  _int_free (av=0x3fffd49ee80 <main_arena>, p=0x156cc30,
		     have_lock=<optimized out>) at malloc.c:4222
 #2  0x00000000012d5e78 in cpu_map__delete (map=0x156cc40) at cpumap.c:31
 #3  0x00000000012d5f7a in perf_cpu_map__put (map=0x156cc40) at cpumap.c:45
 #4  0x00000000012d723a in perf_cpu_map__merge (orig=0x156cc40,
     other=0x156cc60) at cpumap.c:343
 #5  0x000000000110cdd0 in test__cpu_map_merge (
     test=0x14ea6c8 <generic_tests+2856>, subtest=-1) at tests/cpumap.c:128

Thus the perf_cpu_map__put(a) (see (1) above) frees map 'a'
a second time and causes the failure. Fix this be removing that
function call.

Output after:
  [root@m35lp76 perf]# ./perf test -Fvvvvv 52
  52: Merge cpu map                                         :
  --- start ---
  cpumask list: 1-2,4-5,7
  ---- end ----
  Merge cpu map: Ok
  [root@m35lp76 perf]#

Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
---
 tools/perf/tests/cpumap.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/perf/tests/cpumap.c b/tools/perf/tests/cpumap.c
index 4ac56741ac5f..29c793ac7d10 100644
--- a/tools/perf/tests/cpumap.c
+++ b/tools/perf/tests/cpumap.c
@@ -131,7 +131,6 @@ int test__cpu_map_merge(struct test *test __maybe_unused, int subtest __maybe_un
 	TEST_ASSERT_VAL("failed to merge map: bad nr", c->nr == 5);
 	cpu_map__snprint(c, buf, sizeof(buf));
 	TEST_ASSERT_VAL("failed to merge map: bad result", !strcmp(buf, "1-2,4-5,7"));
-	perf_cpu_map__put(a);
 	perf_cpu_map__put(b);
 	perf_cpu_map__put(c);
 	return 0;
-- 
2.21.0

