Return-Path: <SRS0=M1fl=TR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F919C04AB4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 19:03:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6856D20848
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 19:03:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728534AbfEQTDE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 May 2019 15:03:04 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:49964 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726293AbfEQTDD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 15:03:03 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4HJ2TBq059065
        for <linux-kernel@vger.kernel.org>; Fri, 17 May 2019 15:03:02 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2shyu0xw9u-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 17 May 2019 15:03:02 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <naveen.n.rao@linux.vnet.ibm.com>;
        Fri, 17 May 2019 20:03:00 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 17 May 2019 20:02:59 +0100
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x4HJ2wt855771192
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 May 2019 19:02:58 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EB7C7AE04D;
        Fri, 17 May 2019 19:02:57 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1CDA9AE056;
        Fri, 17 May 2019 19:02:56 +0000 (GMT)
Received: from naverao1-tp.ibm.com (unknown [9.199.60.55])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 17 May 2019 19:02:55 +0000 (GMT)
From:   "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>
Cc:     <linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH 1/4] ftrace: Expose flags used for ftrace_replace_code()
Date:   Sat, 18 May 2019 00:32:45 +0530
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1558115654.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1558115654.git.naveen.n.rao@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19051719-4275-0000-0000-00000335EC92
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19051719-4276-0000-0000-000038457937
Message-Id: <f2aa621d26056aa9fc8a6b82e3ceeaf44201d86d.1558115654.git.naveen.n.rao@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-17_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=828 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905170112
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since ftrace_replace_code() is a __weak function and can be overridden,
we need to expose the flags that can be set. So, move the flags enum to
the header file.

Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
---
 include/linux/ftrace.h | 5 +++++
 kernel/trace/ftrace.c  | 5 -----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index 20899919ead8..835e761f63b0 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -162,6 +162,11 @@ enum {
 	FTRACE_OPS_FL_TRACE_ARRAY		= 1 << 15,
 };
 
+enum {
+	FTRACE_MODIFY_ENABLE_FL		= (1 << 0),
+	FTRACE_MODIFY_MAY_SLEEP_FL	= (1 << 1),
+};
+
 #ifdef CONFIG_DYNAMIC_FTRACE
 /* The hash used to know what functions callbacks trace */
 struct ftrace_ops_hash {
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index b920358dd8f7..38c15cd27fc4 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -78,11 +78,6 @@
 #define ASSIGN_OPS_HASH(opsname, val)
 #endif
 
-enum {
-	FTRACE_MODIFY_ENABLE_FL		= (1 << 0),
-	FTRACE_MODIFY_MAY_SLEEP_FL	= (1 << 1),
-};
-
 struct ftrace_ops ftrace_list_end __read_mostly = {
 	.func		= ftrace_stub,
 	.flags		= FTRACE_OPS_FL_RECURSION_SAFE | FTRACE_OPS_FL_STUB,
-- 
2.21.0

