Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2CA0C282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 19:53:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81E6620881
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 19:53:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387702AbfEWTxZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 15:53:25 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:54076 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2387433AbfEWTxY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 15:53:24 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4NJlR6F187003
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2019 15:53:23 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2sp1yqg6du-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2019 15:53:23 -0400
Received: from localhost
        by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <farosas@linux.ibm.com>;
        Thu, 23 May 2019 20:53:22 +0100
Received: from b01cxnp22036.gho.pok.ibm.com (9.57.198.26)
        by e16.ny.us.ibm.com (146.89.104.203) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 23 May 2019 20:53:18 +0100
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com [9.57.199.109])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x4NJrHRk31982062
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 May 2019 19:53:17 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6D59B112065;
        Thu, 23 May 2019 19:53:17 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4E10E112062;
        Thu, 23 May 2019 19:53:16 +0000 (GMT)
Received: from farosas.linux.ibm.com.br.ibm.com (unknown [9.86.26.96])
        by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 23 May 2019 19:53:16 +0000 (GMT)
From:   Fabiano Rosas <farosas@linux.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     Jan Kiszka <jan.kiszka@siemens.com>,
        Kieran Bingham <kbingham@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Jackie Liu <liuyun01@kylinos.cn>
Subject: [PATCH] scripts/gdb: Fix invocation when CONFIG_COMMON_CLK is not set
Date:   Thu, 23 May 2019 16:53:11 -0300
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19052319-0072-0000-0000-000004326D81
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011150; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000286; SDB=6.01207584; UDB=6.00634204; IPR=6.00988564;
 MB=3.00027022; MTD=3.00000008; XFM=3.00000015; UTC=2019-05-23 19:53:20
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19052319-0073-0000-0000-00004C562D62
Message-Id: <20190523195313.24701-1-farosas@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-23_16:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=15 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=828 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905230128
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CLK_GET_RATE_NOCACHE depends on CONFIG_COMMON_CLK. Importing
constants.py when CONFIG_COMMON_CLK is not defined causes:

  (gdb) lx-symbols
  (...)
    File "scripts/gdb/linux/proc.py", line 15, in <module>
      from linux import constants
    File "scripts/gdb/linux/constants.py", line 2, in <module>
      LX_CLK_GET_RATE_NOCACHE = gdb.parse_and_eval("CLK_GET_RATE_NOCACHE")
  gdb.error: No symbol "CLK_GET_RATE_NOCACHE" in current context.

Fixes: e7e6f462c1be ("scripts/gdb: print cached rate in lx-clk-summary")
Signed-off-by: Fabiano Rosas <farosas@linux.ibm.com>
---
 scripts/gdb/linux/constants.py.in | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/scripts/gdb/linux/constants.py.in b/scripts/gdb/linux/constants.py.in
index 1d73083da6cb..2efbec6b6b8d 100644
--- a/scripts/gdb/linux/constants.py.in
+++ b/scripts/gdb/linux/constants.py.in
@@ -40,7 +40,8 @@
 import gdb
 
 /* linux/clk-provider.h */
-LX_GDBPARSED(CLK_GET_RATE_NOCACHE)
+if IS_BUILTIN(CONFIG_COMMON_CLK):
+    LX_GDBPARSED(CLK_GET_RATE_NOCACHE)
 
 /* linux/fs.h */
 LX_VALUE(SB_RDONLY)
-- 
2.20.1

