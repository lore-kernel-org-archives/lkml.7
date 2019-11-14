Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55F9AC432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 13:23:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3702620724
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 13:23:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727016AbfKNNXC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 08:23:02 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:41648 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726958AbfKNNXB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 08:23:01 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id xAED9M5m121388
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2019 08:23:00 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2w94yk7av1-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2019 08:22:44 -0500
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <ravi.bangoria@linux.ibm.com>;
        Thu, 14 Nov 2019 13:22:36 -0000
Received: from b06avi18878370.portsmouth.uk.ibm.com (9.149.26.194)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 14 Nov 2019 13:22:31 -0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xAEDMUk841681314
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Nov 2019 13:22:30 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8423EA4040;
        Thu, 14 Nov 2019 13:22:30 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 897D4A404D;
        Thu, 14 Nov 2019 13:22:27 +0000 (GMT)
Received: from bangoria.ibmuc.com (unknown [9.199.57.87])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 14 Nov 2019 13:22:27 +0000 (GMT)
From:   Ravi Bangoria <ravi.bangoria@linux.ibm.com>
To:     acme@kernel.org
Cc:     jolsa@redhat.com, kan.liang@intel.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, namhyung@kernel.org,
        ak@linux.intel.com, yao.jin@linux.intel.com,
        linux-kernel@vger.kernel.org,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Subject: [PATCH v2 1/3] perf hists: Replace pr_err with ui__error
Date:   Thu, 14 Nov 2019 18:52:11 +0530
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191114132213.5419-1-ravi.bangoria@linux.ibm.com>
References: <20191114132213.5419-1-ravi.bangoria@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19111413-0020-0000-0000-00000386262A
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19111413-0021-0000-0000-000021DC3D10
Message-Id: <20191114132213.5419-2-ravi.bangoria@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-11-14_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=892 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1910280000 definitions=main-1911140123
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pr_err() in tui mode does not print anyting on the screen and
just quits. Replace such pr_err with ui__error.

Before:
  $ ./perf report -s +
  $

After:
  $ ./perf report -s +

    ┌─Error:────────────────┐
    │Invalid --sort key: `+'│
    │                       │
    │Press any key...       │
    └───────────────────────┘

Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
---
 tools/perf/util/sort.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
index 43d1d410854a..cba8f22e4ffb 100644
--- a/tools/perf/util/sort.c
+++ b/tools/perf/util/sort.c
@@ -2696,12 +2696,12 @@ static int setup_sort_list(struct perf_hpp_list *list, char *str,
 			ret = sort_dimension__add(list, tok, evlist, level);
 			if (ret == -EINVAL) {
 				if (!cacheline_size() && !strncasecmp(tok, "dcacheline", strlen(tok)))
-					pr_err("The \"dcacheline\" --sort key needs to know the cacheline size and it couldn't be determined on this system");
+					ui__error("The \"dcacheline\" --sort key needs to know the cacheline size and it couldn't be determined on this system");
 				else
-					pr_err("Invalid --sort key: `%s'", tok);
+					ui__error("Invalid --sort key: `%s'", tok);
 				break;
 			} else if (ret == -ESRCH) {
-				pr_err("Unknown --sort key: `%s'", tok);
+				ui__error("Unknown --sort key: `%s'", tok);
 				break;
 			}
 		}
@@ -2758,7 +2758,7 @@ static int setup_sort_order(struct evlist *evlist)
 		return 0;
 
 	if (sort_order[1] == '\0') {
-		pr_err("Invalid --sort key: `+'");
+		ui__error("Invalid --sort key: `+'");
 		return -EINVAL;
 	}
 
@@ -3049,7 +3049,7 @@ static int __setup_output_field(void)
 		strp++;
 
 	if (!strlen(strp)) {
-		pr_err("Invalid --fields key: `+'");
+		ui__error("Invalid --fields key: `+'");
 		goto out;
 	}
 
-- 
2.21.0

