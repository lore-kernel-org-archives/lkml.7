Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA999C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 13:34:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4200206B6
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 13:34:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729699AbfC2Nd7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 09:33:59 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:38838 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729626AbfC2Nd7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 09:33:59 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2TDVuaX073004
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2019 09:33:58 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2rhk2dmuk4-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2019 09:33:56 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <tmricht@linux.ibm.com>;
        Fri, 29 Mar 2019 13:33:50 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 29 Mar 2019 13:33:47 -0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x2TDXkZa61407424
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Mar 2019 13:33:47 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CD81742066;
        Fri, 29 Mar 2019 13:33:45 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 84BD54204C;
        Fri, 29 Mar 2019 13:33:45 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 29 Mar 2019 13:33:45 +0000 (GMT)
From:   Thomas Richter <tmricht@linux.ibm.com>
To:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org
Cc:     brueckner@linux.vnet.ibm.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, Thomas Richter <tmricht@linux.ibm.com>
Subject: [PATCH] perf/list: Fix s390 counter long description for L1D_RO_EXCL_WRITES
Date:   Fri, 29 Mar 2019 14:33:37 +0100
X-Mailer: git-send-email 2.16.4
X-TM-AS-GCONF: 00
x-cbid: 19032913-4275-0000-0000-000003215178
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19032913-4276-0000-0000-000038305452
Message-Id: <20190329133337.60255-1-tmricht@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-29_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903290098
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Command
  # ./perf list --long-desc pmu
lists the long description of the available counters. For counter
named L1D_RO_EXCL_WRITES on machine types 3906 and 3907 the long
description contains the counter number 'Counter:128 Name:'
prefix. This is wrong.

The fix changes the description text and removes this prefix.

Output before:

[root@m35lp76 perf]# ./perf list --long-desc pmu
 ...
 L1D_ONDRAWER_L4_SOURCED_WRITES
  [A directory write to the Level-1 Data cache directory where the
   returned cache line was sourced from On-Drawer Level-4 cache]

 L1D_RO_EXCL_WRITES
  [Counter:128 Name:L1D_RO_EXCL_WRITES A directory write to the Level-1
   Data cache where the line was originally in a Read-Only state in the
   cache but has been updated to be in the Exclusive state that allows
   stores to the cache line]

 ...

Output after:

[root@m35lp76 perf]# ./perf list --long-desc pmu
 ...
 L1D_ONDRAWER_L4_SOURCED_WRITES
  [A directory write to the Level-1 Data cache directory where the
   returned cache line was sourced from On-Drawer Level-4 cache]

 L1D_RO_EXCL_WRITES
  [L1D_RO_EXCL_WRITES A directory write to the Level-1
   Data cache where the line was originally in a Read-Only state in the
   cache but has been updated to be in the Exclusive state that allows
   stores to the cache line]

 ...

Fixes: 109d59b900e7 ("perf vendor events s390: Add JSON files for IBM z14")
Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
---
 tools/perf/pmu-events/arch/s390/cf_z14/extended.json | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/pmu-events/arch/s390/cf_z14/extended.json b/tools/perf/pmu-events/arch/s390/cf_z14/extended.json
index e7a3524b748f..68618152ea2c 100644
--- a/tools/perf/pmu-events/arch/s390/cf_z14/extended.json
+++ b/tools/perf/pmu-events/arch/s390/cf_z14/extended.json
@@ -4,7 +4,7 @@
 		"EventCode": "128",
 		"EventName": "L1D_RO_EXCL_WRITES",
 		"BriefDescription": "L1D Read-only Exclusive Writes",
-		"PublicDescription": "Counter:128	Name:L1D_RO_EXCL_WRITES A directory write to the Level-1 Data cache where the line was originally in a Read-Only state in the cache but has been updated to be in the Exclusive state that allows stores to the cache line"
+		"PublicDescription": "L1D_RO_EXCL_WRITES A directory write to the Level-1 Data cache where the line was originally in a Read-Only state in the cache but has been updated to be in the Exclusive state that allows stores to the cache line"
 	},
 	{
 		"Unit": "CPU-M-CF",
-- 
2.19.1

