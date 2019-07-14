Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DATE_IN_PAST_12_24,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BC2BC7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 09:12:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5167720838
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 09:12:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ZGLFovZP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729556AbfGOJM3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 05:12:29 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:33634 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729257AbfGOJM2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 05:12:28 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6F991ei076054;
        Mon, 15 Jul 2019 09:11:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2018-07-02;
 bh=z/YmuPr9JSWV/DypPBDpQvIz06xjsjRJ9H2PM05NQvs=;
 b=ZGLFovZPZ6uQQ5eC2fw1yn6EHcqLHh5YNaq+ye4mFA4NHLKwaYfz8XAHDy1VBR5o0fRI
 76GJJZejiNCUzXievGiR2xJljuVEL9H7amPvwVvdrnc+0hzM6bKIJwCzbyeehMWXe/gc
 AKGd2/LRF8115jb0zBk523suvfoEy7FroY63NVTigkMZ+n5TxBiEdX8xB0OY/mtQ+Wvz
 sXJRqJIskTxKt5PJc05Qj9r60HF/7esHJwu3np7EkSVAQeg6Ldwdvz0t+7qkeQ0eU7uC
 T0G6gFeSMnNNkEPMcvzhIcQc8lUS3YfWfQ93C1UYKEIIDWn7wdR0Ptf+OY0j1PYZcDD8 Cg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 2tq6qtdbq2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 15 Jul 2019 09:11:51 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6F97a4P048335;
        Mon, 15 Jul 2019 09:11:50 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 2tq5bbpp8w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 15 Jul 2019 09:11:50 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x6F9BmRB010318;
        Mon, 15 Jul 2019 09:11:49 GMT
Received: from z2.cn.oracle.com (/10.182.69.87)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 15 Jul 2019 02:11:48 -0700
From:   Zhenzhong Duan <zhenzhong.duan@oracle.com>
To:     linux-kernel@vger.kernel.org
Cc:     xen-devel@lists.xenproject.org, boris.ostrovsky@oracle.com,
        jgross@suse.com, sstabellini@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        Zhenzhong Duan <zhenzhong.duan@oracle.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Cooper <andrew.cooper3@citrix.com>
Subject: [Xen-devel][PATCH v3] xen/pv: Fix a boot up hang revealed by int3 self test
Date:   Sun, 14 Jul 2019 17:15:32 +0800
Message-Id: <1563095732-16700-1-git-send-email-zhenzhong.duan@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9318 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1907150109
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9318 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1907150109
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 7457c0da024b ("x86/alternatives: Add int3_emulate_call()
selftest") is used to ensure there is a gap setup in int3 exception stack
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

For 64bit PV guests, Xen's ABI enters the kernel with using SYSRET, with
%rcx/%r11 on the stack. To convert back to "normal" looking exceptions,
the xen thunks do 'xen_*: pop %rcx; pop %r11; jmp *'.

E.g. Extracting 'xen_pv_trap xenint3' we have:
xen_xenint3:
 pop %rcx;
 pop %r11;
 jmp xenint3

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
Cc: Andrew Cooper <andrew.cooper3@citrix.com>
---
 bootup test pass with PV guest.

 v3: set ist_okay to false for int3 per PeterZ
     add Andrew's comments to patch description

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
index 4722ba2..30c14cb 100644
--- a/arch/x86/xen/enlighten_pv.c
+++ b/arch/x86/xen/enlighten_pv.c
@@ -596,12 +596,12 @@ struct trap_array_entry {
 
 static struct trap_array_entry trap_array[] = {
 	{ debug,                       xen_xendebug,                    true },
-	{ int3,                        xen_xenint3,                     true },
 	{ double_fault,                xen_double_fault,                true },
 #ifdef CONFIG_X86_MCE
 	{ machine_check,               xen_machine_check,               true },
 #endif
 	{ nmi,                         xen_xennmi,                      true },
+	{ int3,                        xen_int3,                        false },
 	{ overflow,                    xen_overflow,                    false },
 #ifdef CONFIG_IA32_EMULATION
 	{ entry_INT80_compat,          xen_entry_INT80_compat,          false },
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

