Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4CE6C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 15:37:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB2872133D
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 15:37:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732862AbfB1Phd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 10:37:33 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:46264 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727789AbfB1Phc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 10:37:32 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1SFYxTM011219
        for <linux-kernel@vger.kernel.org>; Thu, 28 Feb 2019 10:37:31 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2qxhs9ap9b-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 28 Feb 2019 10:37:31 -0500
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <ravi.bangoria@linux.ibm.com>;
        Thu, 28 Feb 2019 15:37:29 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 28 Feb 2019 15:37:26 -0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x1SFbOdg32899178
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Feb 2019 15:37:24 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A73E15204F;
        Thu, 28 Feb 2019 15:37:24 +0000 (GMT)
Received: from bangoria.ibmuc.com (unknown [9.199.51.57])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 0FCE252054;
        Thu, 28 Feb 2019 15:37:21 +0000 (GMT)
From:   Ravi Bangoria <ravi.bangoria@linux.ibm.com>
To:     acme@kernel.org
Cc:     alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, eranian@google.com,
        linux-kernel@vger.kernel.org, tonyj@suse.com, nasastry@in.ibm.com,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Subject: [PATCH] perf c2c: Fix c2c report for empty numa node
Date:   Thu, 28 Feb 2019 21:07:19 +0530
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19022815-0020-0000-0000-0000031C6EE1
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19022815-0021-0000-0000-0000216DE1E4
Message-Id: <20190228153719.23411-1-ravi.bangoria@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-28_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902280105
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

perf c2c report fails if system has empty numa node(0 cpus):

  $ lscpu
  NUMA node0 CPU(s):   
  NUMA node1 CPU(s):   0-4

  $ sudo ./perf c2c report 
  node/cpu topology bugFailed setup nodes

Fix this.

Reported-by: Nageswara R Sastry <nasastry@in.ibm.com>
Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
---
 tools/perf/util/cpumap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/cpumap.c b/tools/perf/util/cpumap.c
index 383674f448fc..517c3f37c613 100644
--- a/tools/perf/util/cpumap.c
+++ b/tools/perf/util/cpumap.c
@@ -261,7 +261,7 @@ struct cpu_map *cpu_map__dummy_new(void)
 	struct cpu_map *cpus = malloc(sizeof(*cpus) + sizeof(int));
 
 	if (cpus != NULL) {
-		cpus->nr = 1;
+		cpus->nr = 0;
 		cpus->map[0] = -1;
 		refcount_set(&cpus->refcnt, 1);
 	}
-- 
2.17.1

