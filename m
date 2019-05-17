Return-Path: <SRS0=M1fl=TR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95777C04AB4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 19:04:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71AB82087B
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 19:04:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729127AbfEQTEo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 May 2019 15:04:44 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:44586 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725954AbfEQTEo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 15:04:44 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4HJ4d8o087026
        for <linux-kernel@vger.kernel.org>; Fri, 17 May 2019 15:04:42 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2sj2au8xsm-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 17 May 2019 15:04:41 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <naveen.n.rao@linux.vnet.ibm.com>;
        Fri, 17 May 2019 20:03:07 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 17 May 2019 20:03:03 +0100
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x4HJ32M648365626
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 May 2019 19:03:02 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7334CAE045;
        Fri, 17 May 2019 19:03:02 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 98638AE04D;
        Fri, 17 May 2019 19:03:00 +0000 (GMT)
Received: from naverao1-tp.ibm.com (unknown [9.199.60.55])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 17 May 2019 19:03:00 +0000 (GMT)
From:   "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>
Cc:     <linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH 3/4] ftrace: Expose __ftrace_replace_code()
Date:   Sat, 18 May 2019 00:32:47 +0530
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1558115654.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1558115654.git.naveen.n.rao@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19051719-0028-0000-0000-0000036ED600
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19051719-0029-0000-0000-0000242E7640
Message-Id: <40a640c1b9d2362b88a9d4b9412242ad396c9c68.1558115654.git.naveen.n.rao@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-17_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905170112
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While over-riding ftrace_replace_code(), we still want to reuse the
existing __ftrace_replace_code() function. Rename the function and
make it available for other kernel code.

Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
---
 include/linux/ftrace.h | 1 +
 kernel/trace/ftrace.c  | 8 ++++----
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index 835e761f63b0..3f4ceb982214 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -456,6 +456,7 @@ ftrace_set_early_filter(struct ftrace_ops *ops, char *buf, int enable);
 /* defined in arch */
 extern int ftrace_ip_converted(unsigned long ip);
 extern int ftrace_dyn_arch_init(void);
+extern int ftrace_do_replace_code(struct dyn_ftrace *rec, int enable);
 extern void ftrace_replace_code(int enable);
 extern int ftrace_update_ftrace_func(ftrace_func_t func);
 extern void ftrace_caller(void);
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 38c15cd27fc4..d94f7e526c33 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -2354,8 +2354,8 @@ unsigned long ftrace_get_addr_curr(struct dyn_ftrace *rec)
 		return (unsigned long)FTRACE_ADDR;
 }
 
-static int
-__ftrace_replace_code(struct dyn_ftrace *rec, int enable)
+int
+ftrace_do_replace_code(struct dyn_ftrace *rec, int enable)
 {
 	unsigned long ftrace_old_addr;
 	unsigned long ftrace_addr;
@@ -2406,7 +2406,7 @@ void __weak ftrace_replace_code(int mod_flags)
 		if (rec->flags & FTRACE_FL_DISABLED)
 			continue;
 
-		failed = __ftrace_replace_code(rec, enable);
+		failed = ftrace_do_replace_code(rec, enable);
 		if (failed) {
 			ftrace_bug(failed, rec);
 			/* Stop processing */
@@ -5822,7 +5822,7 @@ void ftrace_module_enable(struct module *mod)
 		rec->flags = cnt;
 
 		if (ftrace_start_up && cnt) {
-			int failed = __ftrace_replace_code(rec, 1);
+			int failed = ftrace_do_replace_code(rec, 1);
 			if (failed) {
 				ftrace_bug(failed, rec);
 				goto out_loop;
-- 
2.21.0

