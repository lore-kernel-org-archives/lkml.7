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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9762C742A8
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 04:44:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE8F92084B
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 04:44:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="pQPEW7Dx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729624AbfGLEou (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jul 2019 00:44:50 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:59630 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726610AbfGLEou (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 00:44:50 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6C4dH4j056602;
        Fri, 12 Jul 2019 04:43:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2018-07-02;
 bh=uw9ARe8x7QtRm6OOT1c/IbRl5bsJpRHqHU8DP7hvV60=;
 b=pQPEW7Dx4el+JBLPt8X5lkuRVGTKaPyBnwXZoCQOAJekYwf8Y7K3H1fIMkpvvELMZmuA
 Li1Ucgf0pXYPFe92BXDYi+6ztpdw5dbxpOnFCTIKkXiqP/bQpTzS3sbx+/7+S2yWfPBO
 o/o3yFhFXl8262oWh/I04NkRq4MluTsLOIQyXkKiHaBCso8scqH52BBz4hgipWQ4Xd4+
 RkDrSj2dPUEoMfzb53xFUmHuyGmc8CGhBZu68mYfr2r1cMxbjYpsa/8U0M0r+dogTrxZ
 lYQzmPH/+YWoWRqkz+tYCgoub1bWlFFFnoWQPgztequYVPW4o1tAWaCRRqh1v3Md+ykQ zQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 2tjm9r3d9k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 Jul 2019 04:43:35 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6C4gWQZ162744;
        Fri, 12 Jul 2019 04:43:34 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 2tpefcvn8u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 Jul 2019 04:43:34 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x6C4hUXJ012299;
        Fri, 12 Jul 2019 04:43:32 GMT
Received: from z2.cn.oracle.com (/10.182.69.87)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 11 Jul 2019 21:43:30 -0700
From:   Zhenzhong Duan <zhenzhong.duan@oracle.com>
To:     linux-kernel@vger.kernel.org
Cc:     xen-devel@lists.xenproject.org, x86@kernel.org,
        srinivas.eeda@oracle.com,
        Zhenzhong Duan <zhenzhong.duan@oracle.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>
Subject: [PATCH] xen/pv: Fix a boot up hang triggered by int3 self test
Date:   Thu, 11 Jul 2019 12:47:18 +0800
Message-Id: <1562820438-30328-1-git-send-email-zhenzhong.duan@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9315 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1907120047
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9315 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1907120046
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 7457c0da024b ("x86/alternatives: Add int3_emulate_call()
selftest") reveals a bug in XEN PV int3 assemble code. There is
a double pop of register R11 and RCX currupting the exception
frame, one in xen_int3 and the other in xen_xenint3.

We see below hang at bootup:

general protection fault: 0000 [#1] SMP NOPTI
CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.2.0+ #6
RIP: e030:int3_magic+0x0/0x7
Call Trace:
 alternative_instructions+0x3d/0x12e
 check_bugs+0x7c9/0x887
 ?__get_locked_pte+0x178/0x1f0
 start_kernel+0x4ff/0x535
 ?set_init_arg+0x55/0x55
 xen_start_kernel+0x571/0x57a

Fix it by removing xen_xenint3.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@oracle.com>
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: Stefano Stabellini <sstabellini@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
---
 arch/x86/include/asm/traps.h | 2 +-
 arch/x86/xen/enlighten_pv.c  | 2 +-
 arch/x86/xen/xen-asm_64.S    | 1 -
 3 files changed, 2 insertions(+), 3 deletions(-)

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

