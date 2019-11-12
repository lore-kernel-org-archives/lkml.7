Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE514C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 05:50:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A6BC206BB
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 05:50:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727010AbfKLFuF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 00:50:05 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:23544 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725775AbfKLFuF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 00:50:05 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id xAC5lwTb054045
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2019 00:50:04 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2w7jpankv8-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2019 00:50:03 -0500
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <ravi.bangoria@linux.ibm.com>;
        Tue, 12 Nov 2019 05:50:02 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 12 Nov 2019 05:49:59 -0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xAC5nwII38535186
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Nov 2019 05:49:58 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B288111C04A;
        Tue, 12 Nov 2019 05:49:58 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9FF6D11C052;
        Tue, 12 Nov 2019 05:49:57 +0000 (GMT)
Received: from bangoria.in.ibm.com (unknown [9.124.31.152])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 12 Nov 2019 05:49:57 +0000 (GMT)
From:   Ravi Bangoria <ravi.bangoria@linux.ibm.com>
To:     acme@kernel.org
Cc:     jolsa@redhat.com, kan.liang@intel.com,
        linux-kernel@vger.kernel.org,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Subject: [PATCH] perf report: Fix segfault with '-F phys_daddr'
Date:   Tue, 12 Nov 2019 11:19:46 +0530
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19111205-0008-0000-0000-0000032E3969
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19111205-0009-0000-0000-00004A4D3C1F
Message-Id: <20191112054946.5869-1-ravi.bangoria@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-11-12_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1910280000 definitions=main-1911120052
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If perf.data file is not recorded with mem-info, adding 'phys_daddr'
to output field in perf report results in segfault. Fix that.

Before:
  $ ./perf record ls
  $ ./perf report -F +phys_daddr
  Segmentation fault (core dumped)

After:
  $ ./perf report -F +phys_daddr
  Samples: 11  of event 'cycles:u', Event count (approx.): 1485821
  Overhead  Data Physical Address  Command  Shared Object  Symbol
    22.57%  [.] 0000000000000000   ls       libc-2.29.so   [.] __strcoll_l
    21.87%  [.] 0000000000000000   ls       ld-2.29.so     [.] _dl_relocate_object
    ...

Fixes: 8780fb25ab06 ("perf sort: Add sort option for physical address")
Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
---
 tools/perf/util/sort.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
index 43d1d410854a..c2430676e569 100644
--- a/tools/perf/util/sort.c
+++ b/tools/perf/util/sort.c
@@ -1413,7 +1413,7 @@ static int hist_entry__phys_daddr_snprintf(struct hist_entry *he, char *bf,
 	size_t ret = 0;
 	size_t len = BITS_PER_LONG / 4;
 
-	addr = he->mem_info->daddr.phys_addr;
+	addr = he->mem_info ? he->mem_info->daddr.phys_addr : 0;
 
 	ret += repsep_snprintf(bf + ret, size - ret, "[%c] ", he->level);
 
-- 
2.21.0

