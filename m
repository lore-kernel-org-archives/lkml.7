Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35763C31E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 14:49:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14D6920B1F
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 14:49:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729161AbfFROtN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 10:49:13 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:1044 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729050AbfFROtN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 10:49:13 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5IEmoxY077801
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2019 10:49:12 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2t70awd2e2-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2019 10:49:03 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <naveen.n.rao@linux.vnet.ibm.com>;
        Tue, 18 Jun 2019 15:48:10 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 18 Jun 2019 15:47:53 +0100
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x5IElqcH45547558
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Jun 2019 14:47:52 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2906911C04C;
        Tue, 18 Jun 2019 14:47:52 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 427EF11C054;
        Tue, 18 Jun 2019 14:47:50 +0000 (GMT)
Received: from naverao1-tp.ibmuc.com (unknown [9.85.74.6])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 18 Jun 2019 14:47:50 +0000 (GMT)
From:   "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>
Cc:     <linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 6/7] kprobes/ftrace: Use ftrace_location() when [dis]arming probes
Date:   Tue, 18 Jun 2019 20:17:05 +0530
X-Mailer: git-send-email 2.22.0
In-Reply-To: <cover.1560868106.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1560868106.git.naveen.n.rao@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19061814-4275-0000-0000-00000343618D
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19061814-4276-0000-0000-0000385389E1
Message-Id: <4fedad69107b7fd81b9324315ce4fbf6287e5084.1560868106.git.naveen.n.rao@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-18_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906180119
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ftrace location could include more than a single instruction in case of
some architectures (powerpc64, for now). In this case, kprobe is
permitted on any of those instructions, and uses ftrace infrastructure
for functioning.

However, [dis]arm_kprobe_ftrace() uses the kprobe address when setting
up ftrace filter IP. This won't work if the address points to any
instruction apart from the one that has a branch to _mcount(). To
resolve this, have [dis]arm_kprobe_ftrace() use ftrace_function() to
identify the filter IP.

Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
---
 kernel/kprobes.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index 445337c107e0..282ee704e2d8 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -978,10 +978,10 @@ static int prepare_kprobe(struct kprobe *p)
 /* Caller must lock kprobe_mutex */
 static int arm_kprobe_ftrace(struct kprobe *p)
 {
+	unsigned long ftrace_ip = ftrace_location((unsigned long)p->addr);
 	int ret = 0;
 
-	ret = ftrace_set_filter_ip(&kprobe_ftrace_ops,
-				   (unsigned long)p->addr, 0, 0);
+	ret = ftrace_set_filter_ip(&kprobe_ftrace_ops, ftrace_ip, 0, 0);
 	if (ret) {
 		pr_debug("Failed to arm kprobe-ftrace at %pS (%d)\n",
 			 p->addr, ret);
@@ -1005,13 +1005,14 @@ static int arm_kprobe_ftrace(struct kprobe *p)
 	 * non-empty filter_hash for IPMODIFY ops, we're safe from an accidental
 	 * empty filter_hash which would undesirably trace all functions.
 	 */
-	ftrace_set_filter_ip(&kprobe_ftrace_ops, (unsigned long)p->addr, 1, 0);
+	ftrace_set_filter_ip(&kprobe_ftrace_ops, ftrace_ip, 1, 0);
 	return ret;
 }
 
 /* Caller must lock kprobe_mutex */
 static int disarm_kprobe_ftrace(struct kprobe *p)
 {
+	unsigned long ftrace_ip = ftrace_location((unsigned long)p->addr);
 	int ret = 0;
 
 	if (kprobe_ftrace_enabled == 1) {
@@ -1022,8 +1023,7 @@ static int disarm_kprobe_ftrace(struct kprobe *p)
 
 	kprobe_ftrace_enabled--;
 
-	ret = ftrace_set_filter_ip(&kprobe_ftrace_ops,
-			   (unsigned long)p->addr, 1, 0);
+	ret = ftrace_set_filter_ip(&kprobe_ftrace_ops, ftrace_ip, 1, 0);
 	WARN_ONCE(ret < 0, "Failed to disarm kprobe-ftrace at %pS (%d)\n",
 		  p->addr, ret);
 	return ret;
-- 
2.22.0

