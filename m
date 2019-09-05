Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B7ECC43331
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 18:21:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B8722173B
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 18:21:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403891AbfIESVJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 14:21:09 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:38204 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2391241AbfIESVE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 14:21:04 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x85ICYDY032607
        for <linux-kernel@vger.kernel.org>; Thu, 5 Sep 2019 14:21:02 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2uu4wa6k3k-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2019 14:21:02 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <naveen.n.rao@linux.vnet.ibm.com>;
        Thu, 5 Sep 2019 19:21:00 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 5 Sep 2019 19:20:57 +0100
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x85IKuPR55836852
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 5 Sep 2019 18:20:56 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 61EF5AE053;
        Thu,  5 Sep 2019 18:20:56 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 86CC9AE051;
        Thu,  5 Sep 2019 18:20:54 +0000 (GMT)
Received: from naverao1-tp.ibmuc.com (unknown [9.85.95.49])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu,  5 Sep 2019 18:20:54 +0000 (GMT)
From:   "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     Nicholas Piggin <npiggin@gmail.com>,
        <linux-kernel@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH 3/3] powerpc: Use ftrace_graph_ret_addr() when unwinding
Date:   Thu,  5 Sep 2019 23:50:30 +0530
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1567707399.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1567707399.git.naveen.n.rao@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19090518-4275-0000-0000-000003619928
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19090518-4276-0000-0000-00003873E295
Message-Id: <dc89c9a887121342d9c7819482c3dabdece2a323.1567707399.git.naveen.n.rao@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-09-05_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=498 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1909050172
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With support for HAVE_FUNCTION_GRAPH_RET_ADDR_PTR,
ftrace_graph_ret_addr() provides more robust unwinding when function
graph is in use. Update show_stack() to use the same.

With dump_stack() added to sysrq_sysctl_handler(), before this patch:
  root@(none):/sys/kernel/debug/tracing# cat /proc/sys/kernel/sysrq
  CPU: 0 PID: 218 Comm: cat Not tainted 5.3.0-rc7-00868-g8453ad4a078c-dirty #20
  Call Trace:
  [c0000000d1e13c30] [c00000000006ab98] return_to_handler+0x0/0x40 (dump_stack+0xe8/0x164) (unreliable)
  [c0000000d1e13c80] [c000000000145680] sysrq_sysctl_handler+0x48/0xb8
  [c0000000d1e13cd0] [c00000000006ab98] return_to_handler+0x0/0x40 (proc_sys_call_handler+0x274/0x2a0)
  [c0000000d1e13d60] [c00000000006ab98] return_to_handler+0x0/0x40 (return_to_handler+0x0/0x40)
  [c0000000d1e13d80] [c00000000006ab98] return_to_handler+0x0/0x40 (__vfs_read+0x3c/0x70)
  [c0000000d1e13dd0] [c00000000006ab98] return_to_handler+0x0/0x40 (vfs_read+0xb8/0x1b0)
  [c0000000d1e13e20] [c00000000006ab98] return_to_handler+0x0/0x40 (ksys_read+0x7c/0x140)

After this patch:
  Call Trace:
  [c0000000d1e33c30] [c00000000006ab58] return_to_handler+0x0/0x40 (dump_stack+0xe8/0x164) (unreliable)
  [c0000000d1e33c80] [c000000000145680] sysrq_sysctl_handler+0x48/0xb8
  [c0000000d1e33cd0] [c00000000006ab58] return_to_handler+0x0/0x40 (proc_sys_call_handler+0x274/0x2a0)
  [c0000000d1e33d60] [c00000000006ab58] return_to_handler+0x0/0x40 (__vfs_read+0x3c/0x70)
  [c0000000d1e33d80] [c00000000006ab58] return_to_handler+0x0/0x40 (vfs_read+0xb8/0x1b0)
  [c0000000d1e33dd0] [c00000000006ab58] return_to_handler+0x0/0x40 (ksys_read+0x7c/0x140)
  [c0000000d1e33e20] [c00000000006ab58] return_to_handler+0x0/0x40 (system_call+0x5c/0x68)

Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/process.c | 19 ++++++-------------
 1 file changed, 6 insertions(+), 13 deletions(-)

diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index 24621e7e5033..f289bdd2b562 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -2047,10 +2047,8 @@ void show_stack(struct task_struct *tsk, unsigned long *stack)
 	int count = 0;
 	int firstframe = 1;
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
-	struct ftrace_ret_stack *ret_stack;
-	extern void return_to_handler(void);
-	unsigned long rth = (unsigned long)return_to_handler;
-	int curr_frame = 0;
+	unsigned long ret_addr;
+	int ftrace_idx = 0;
 #endif
 
 	if (tsk == NULL)
@@ -2079,15 +2077,10 @@ void show_stack(struct task_struct *tsk, unsigned long *stack)
 		if (!firstframe || ip != lr) {
 			printk("["REG"] ["REG"] %pS", sp, ip, (void *)ip);
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
-			if ((ip == rth) && curr_frame >= 0) {
-				ret_stack = ftrace_graph_get_ret_stack(current,
-								  curr_frame++);
-				if (ret_stack)
-					pr_cont(" (%pS)",
-						(void *)ret_stack->ret);
-				else
-					curr_frame = -1;
-			}
+			ret_addr = ftrace_graph_ret_addr(current,
+						&ftrace_idx, ip, stack);
+			if (ret_addr != ip)
+				pr_cont(" (%pS)", (void *)ret_addr);
 #endif
 			if (firstframe)
 				pr_cont(" (unreliable)");
-- 
2.23.0

