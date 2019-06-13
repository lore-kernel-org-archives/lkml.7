Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBC4EC31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:51:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDF9D20665
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:51:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393028AbfFMQvx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 12:51:53 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:33496 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730138AbfFMDaZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 23:30:25 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5D3RHLV124566
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2019 23:30:24 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2t3cm0utpd-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2019 23:30:23 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <ravi.bangoria@linux.ibm.com>;
        Thu, 13 Jun 2019 04:30:21 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 13 Jun 2019 04:30:19 +0100
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x5D3UHHR51445824
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 13 Jun 2019 03:30:17 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 81C5F52065;
        Thu, 13 Jun 2019 03:30:17 +0000 (GMT)
Received: from bangoria.in.ibm.com (unknown [9.124.31.207])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 866F152052;
        Thu, 13 Jun 2019 03:30:15 +0000 (GMT)
From:   Ravi Bangoria <ravi.bangoria@linux.ibm.com>
To:     mpe@ellerman.id.au
Cc:     mikey@neuling.org, benh@kernel.crashing.org, paulus@samba.org,
        npiggin@gmail.com, christophe.leroy@c-s.fr,
        mahesh@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, naveen.n.rao@linux.vnet.ibm.com,
        ravi.bangoria@linux.ibm.com, aneesh.kumar@linux.ibm.com
Subject: [PATCH v2] Powerpc/Watchpoint: Restore nvgprs while returning from exception
Date:   Thu, 13 Jun 2019 09:00:14 +0530
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19061303-4275-0000-0000-00000341DB39
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19061303-4276-0000-0000-00003851F339
Message-Id: <20190613033014.17496-1-ravi.bangoria@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-13_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906130025
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Powerpc hw triggers watchpoint before executing the instruction. To
make trigger-after-execute behavior, kernel emulates the instruction.
If the instruction is 'load something into non-volatile register',
exception handler should restore emulated register state while
returning back, otherwise there will be register state corruption.
Ex, Adding a watchpoint on a list can corrput the list:

  # cat /proc/kallsyms | grep kthread_create_list
  c00000000121c8b8 d kthread_create_list

Add watchpoint on kthread_create_list->prev:

  # perf record -e mem:0xc00000000121c8c0

Run some workload such that new kthread gets invoked. Ex, I just
logged out from console:

  list_add corruption. next->prev should be prev (c000000001214e00), \
	but was c00000000121c8b8. (next=c00000000121c8b8).
  WARNING: CPU: 59 PID: 309 at lib/list_debug.c:25 __list_add_valid+0xb4/0xc0
  CPU: 59 PID: 309 Comm: kworker/59:0 Kdump: loaded Not tainted 5.1.0-rc7+ #69
  ...
  NIP __list_add_valid+0xb4/0xc0
  LR __list_add_valid+0xb0/0xc0
  Call Trace:
  __list_add_valid+0xb0/0xc0 (unreliable)
  __kthread_create_on_node+0xe0/0x260
  kthread_create_on_node+0x34/0x50
  create_worker+0xe8/0x260
  worker_thread+0x444/0x560
  kthread+0x160/0x1a0
  ret_from_kernel_thread+0x5c/0x70

List corruption happened because it uses 'load into non-volatile
register' instruction:

Snippet from __kthread_create_on_node:

  c000000000136be8:     addis   r29,r2,-19
  c000000000136bec:     ld      r29,31424(r29)
        if (!__list_add_valid(new, prev, next))
  c000000000136bf0:     mr      r3,r30
  c000000000136bf4:     mr      r5,r28
  c000000000136bf8:     mr      r4,r29
  c000000000136bfc:     bl      c00000000059a2f8 <__list_add_valid+0x8>

Register state from WARN_ON():

  GPR00: c00000000059a3a0 c000007ff23afb50 c000000001344e00 0000000000000075
  GPR04: 0000000000000000 0000000000000000 0000001852af8bc1 0000000000000000
  GPR08: 0000000000000001 0000000000000007 0000000000000006 00000000000004aa
  GPR12: 0000000000000000 c000007ffffeb080 c000000000137038 c000005ff62aaa00
  GPR16: 0000000000000000 0000000000000000 c000007fffbe7600 c000007fffbe7370
  GPR20: c000007fffbe7320 c000007fffbe7300 c000000001373a00 0000000000000000
  GPR24: fffffffffffffef7 c00000000012e320 c000007ff23afcb0 c000000000cb8628
  GPR28: c00000000121c8b8 c000000001214e00 c000007fef5b17e8 c000007fef5b17c0

Watchpoint hit at 0xc000000000136bec.

  addis   r29,r2,-19
   => r29 = 0xc000000001344e00 + (-19 << 16)
   => r29 = 0xc000000001214e00

  ld      r29,31424(r29)
   => r29 = *(0xc000000001214e00 + 31424)
   => r29 = *(0xc00000000121c8c0)

0xc00000000121c8c0 is where we placed a watchpoint and thus this
instruction was emulated by emulate_step. But because handle_dabr_fault
did not restore emulated register state, r29 still contains stale
value in above register state.

Fixes: 5aae8a5370802 ("powerpc, hw_breakpoints: Implement hw_breakpoints for 64-bit server processors")
Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Cc: stable@vger.kernel.org # 2.6.36+
---
v1: https://lkml.org/lkml/2019/6/10/1058
v1->v2:
Successful do_page_fault returns using ret_from_except_lite at
the same place where handle_dabr_fault also returns. v1 messed
up with do_page_fault return path. Fix that in v2.

 arch/powerpc/kernel/exceptions-64s.S | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index 6b86055..2546427 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -1746,7 +1746,7 @@ handle_page_fault:
 	addi	r3,r1,STACK_FRAME_OVERHEAD
 	bl	do_page_fault
 	cmpdi	r3,0
-	beq+	12f
+	beq+	ret_from_except_lite
 	bl	save_nvgprs
 	mr	r5,r3
 	addi	r3,r1,STACK_FRAME_OVERHEAD
@@ -1761,7 +1761,12 @@ handle_dabr_fault:
 	ld      r5,_DSISR(r1)
 	addi    r3,r1,STACK_FRAME_OVERHEAD
 	bl      do_break
-12:	b       ret_from_except_lite
+	/*
+	 * do_break may have changed the nv-gprs while haldling
+	 * breakpoint. If so, we need to restore them with their
+	 * updated values. Don't use ret_from_except_lite here.
+	 */
+	b       ret_from_except
 
 
 #ifdef CONFIG_PPC_BOOK3S_64
-- 
1.8.3.1

