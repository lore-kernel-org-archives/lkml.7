Return-Path: <SRS0=V+Ds=VJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DATE_IN_PAST_12_24,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7F97C742A8
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 08:12:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A408320863
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 08:12:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Vt08rtIQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726483AbfGLIMf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jul 2019 04:12:35 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:33000 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726112AbfGLIMe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 04:12:34 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6C89Jha099333;
        Fri, 12 Jul 2019 08:11:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2018-07-02;
 bh=pqd0p1GXeUPggPPvXgNNFelVAfyPsXqmmeemTWLVezY=;
 b=Vt08rtIQ4pSnPnJ+H7ONebQ6+AySlLrp604xldWUxpRaxasHRQbCzRsfKgQZGQQ24eIi
 s5+T67nk3RwOCHU7PoEsPVe1psrZbhvaYpka8P1OvmnoDUbA1cDgijo8OB9RABcbOrdM
 AccTxS806NpbyBRBR8IcP8Ar2Icvb5BsodR6asWMYL9H7YgPdeN2wSKGkNRu8QCp2THj
 QH44FLnXFlRT9gv850J5eHYM7287AtPBpk4+c0DsaBSRq3l4w972e6KovlfOYh8S8/Sx
 SmdW6RdpTh6ioVifS7K9RrxzrUOJpIq7abJBHJRzBACwjX6m+5J0G6805hKDGgxxAg8l eA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 2tjkkq44y2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 Jul 2019 08:11:35 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6C87aZX087491;
        Fri, 12 Jul 2019 08:11:35 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 2tmwgyn7hr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 Jul 2019 08:11:34 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x6C8BXno016345;
        Fri, 12 Jul 2019 08:11:34 GMT
Received: from z2.cn.oracle.com (/10.182.69.87)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 12 Jul 2019 01:11:33 -0700
From:   Zhenzhong Duan <zhenzhong.duan@oracle.com>
To:     linux-kernel@vger.kernel.org
Cc:     xen-devel@lists.xenproject.org, x86@kernel.org,
        srinivas.eeda@oracle.com,
        Zhenzhong Duan <zhenzhong.duan@oracle.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>
Subject: [PATCH v2] xen/pv: Fix a boot up hang revealed by int3 self test
Date:   Thu, 11 Jul 2019 16:15:21 +0800
Message-Id: <1562832921-20831-1-git-send-email-zhenzhong.duan@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9315 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1907120085
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9315 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1907120086
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 7457c0da024b ("x86/alternatives: Add int3_emulate_call()
selftest") is used to ensure there is a gap setup in exception stack
which could be used for inserting call return address.

This gap is missed in XEN PV int3 exception entry path, then below panic
triggered:

[    0.772876] general protection fault: 0000 [#1] SMP NOPTI
[    0.772886] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.2.0+ #11
[    0.772893] RIP: e030:int3_magic+0x0/0x7
[    0.772905] RSP: 3507:ffffffff82203e98 EFLAGS: 00000246
[    0.773334] Call Trace:
[    0.773334]  alternative_instructions+0x3d/0x12e
[    0.773334]  check_bugs+0x7c9/0x887
[    0.773334]  ? __get_locked_pte+0x178/0x1f0
[    0.773334]  start_kernel+0x4ff/0x535
[    0.773334]  ? set_init_arg+0x55/0x55
[    0.773334]  xen_start_kernel+0x571/0x57a

As xenint3 and int3 entry code are same except xenint3 doesn't generate
a gap, we can fix it by using int3 and drop useless xenint3.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@oracle.com>
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: Stefano Stabellini <sstabellini@kernel.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
---
 v2: fix up description.
---
 arch/x86/entry/entry_64.S    | 1 -
 arch/x86/include/asm/traps.h | 2 +-
 arch/x86/xen/enlighten_pv.c  | 2 +-
 arch/x86/xen/xen-asm_64.S    | 1 -
 4 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 0ea4831..35a66fc 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -1176,7 +1176,6 @@ idtentry stack_segment		do_stack_segment	has_error_code=1
 #ifdef CONFIG_XEN_PV
 idtentry xennmi			do_nmi			has_error_code=0
 idtentry xendebug		do_debug		has_error_code=0
-idtentry xenint3		do_int3			has_error_code=0
 #endif
 
 idtentry general_protection	do_general_protection	has_error_code=1
diff --git a/arch/x86/include/asm/traps.h b/arch/x86/include/asm/traps.h
index 7d6f3f3..f2bd284 100644
--- a/arch/x86/include/asm/traps.h
+++ b/arch/x86/include/asm/traps.h
@@ -40,7 +40,7 @@
 asmlinkage void xen_divide_error(void);
 asmlinkage void xen_xennmi(void);
 asmlinkage void xen_xendebug(void);
-asmlinkage void xen_xenint3(void);
+asmlinkage void xen_int3(void);
 asmlinkage void xen_overflow(void);
 asmlinkage void xen_bounds(void);
 asmlinkage void xen_invalid_op(void);
diff --git a/arch/x86/xen/enlighten_pv.c b/arch/x86/xen/enlighten_pv.c
index 4722ba2..2138d69 100644
--- a/arch/x86/xen/enlighten_pv.c
+++ b/arch/x86/xen/enlighten_pv.c
@@ -596,7 +596,7 @@ struct trap_array_entry {
 
 static struct trap_array_entry trap_array[] = {
 	{ debug,                       xen_xendebug,                    true },
-	{ int3,                        xen_xenint3,                     true },
+	{ int3,                        xen_int3,                        true },
 	{ double_fault,                xen_double_fault,                true },
 #ifdef CONFIG_X86_MCE
 	{ machine_check,               xen_machine_check,               true },
diff --git a/arch/x86/xen/xen-asm_64.S b/arch/x86/xen/xen-asm_64.S
index 1e9ef0b..ebf610b 100644
--- a/arch/x86/xen/xen-asm_64.S
+++ b/arch/x86/xen/xen-asm_64.S
@@ -32,7 +32,6 @@ xen_pv_trap divide_error
 xen_pv_trap debug
 xen_pv_trap xendebug
 xen_pv_trap int3
-xen_pv_trap xenint3
 xen_pv_trap xennmi
 xen_pv_trap overflow
 xen_pv_trap bounds
-- 
1.8.3.1

