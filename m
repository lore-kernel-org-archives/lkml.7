Return-Path: <SRS0=hqT0=XE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0B98C433EF
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 07:03:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E93121479
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 07:03:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731720AbfIIHDo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Sep 2019 03:03:44 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:12428 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731607AbfIIHDo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 03:03:44 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x8972DIX134820
        for <linux-kernel@vger.kernel.org>; Mon, 9 Sep 2019 03:03:43 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2uwhr18um0-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2019 03:03:42 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <mamatha4@linux.vnet.ibm.com>;
        Mon, 9 Sep 2019 08:03:40 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 9 Sep 2019 08:03:37 +0100
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x8973aFW50069718
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 9 Sep 2019 07:03:36 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AF73B4C058;
        Mon,  9 Sep 2019 07:03:36 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 24DA34C050;
        Mon,  9 Sep 2019 07:03:34 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.109.219.151])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon,  9 Sep 2019 07:03:33 +0000 (GMT)
Subject: [PATCH]perf vendor events:Remove P8 HW events which are not
 supported
From:   Mamatha Inamdar <mamatha4@linux.vnet.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     ravi.bangoria@linux.ibm.com, maddy@linux.vnet.ibm.com,
        peterz@infradead.org, mpe@ellerman.id.au, acme@kernel.org,
        alexander.shishkin@linux.intel.com, mingo@redhat.com,
        namhyung@kernel.org, jolsa@redhat.com
Date:   Mon, 09 Sep 2019 12:33:33 +0530
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19090907-4275-0000-0000-000003631700
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19090907-4276-0000-0000-000038756617
Message-Id: <20190909065624.11956.3992.stgit@localhost.localdomain>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-09-09_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1909090077
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is to remove following hardware events
from JSON file which are not supported on POWER8.

pm_l3_p0_grp_pump
pm_l3_p0_lco_data
pm_l3_p0_lco_no_data
pm_l3_p0_lco_rty

Fixes: c3b4d5c4afb0 ("perf vendor events: Remove P8 HW events which are not supported")
Note: Unfortunately power8 event list is not publicly available.
Signed-off-by: Mamatha Inamdar <mamatha4@linux.vnet.ibm.com>
Acked-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
---
 .../perf/pmu-events/arch/powerpc/power8/other.json |   24 --------------------
 1 file changed, 24 deletions(-)

diff --git a/tools/perf/pmu-events/arch/powerpc/power8/other.json b/tools/perf/pmu-events/arch/powerpc/power8/other.json
index 9dc2f6b7..b2a3df0 100644
--- a/tools/perf/pmu-events/arch/powerpc/power8/other.json
+++ b/tools/perf/pmu-events/arch/powerpc/power8/other.json
@@ -1776,30 +1776,6 @@
     "PublicDescription": ""
   },
   {,
-    "EventCode": "0xa29084",
-    "EventName": "PM_L3_P0_GRP_PUMP",
-    "BriefDescription": "L3 pf sent with grp scope port 0",
-    "PublicDescription": ""
-  },
-  {,
-    "EventCode": "0x528084",
-    "EventName": "PM_L3_P0_LCO_DATA",
-    "BriefDescription": "lco sent with data port 0",
-    "PublicDescription": ""
-  },
-  {,
-    "EventCode": "0x518080",
-    "EventName": "PM_L3_P0_LCO_NO_DATA",
-    "BriefDescription": "dataless l3 lco sent port 0",
-    "PublicDescription": ""
-  },
-  {,
-    "EventCode": "0xa4908c",
-    "EventName": "PM_L3_P0_LCO_RTY",
-    "BriefDescription": "L3 LCO received retry port 0",
-    "PublicDescription": ""
-  },
-  {,
     "EventCode": "0x84908d",
     "EventName": "PM_L3_PF0_ALLOC",
     "BriefDescription": "lifetime, sample of PF machine 0 valid",

