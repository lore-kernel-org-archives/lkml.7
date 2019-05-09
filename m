Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D0BBC04AB3
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 17:26:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4708321019
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 17:26:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="JVdmi8Qs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726899AbfEIRZ7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 13:25:59 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:41824 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726819AbfEIRZz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 13:25:55 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x49HJKhR151507;
        Thu, 9 May 2019 17:25:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2018-07-02;
 bh=3LSWyrB/R95u7v5C2K7eIXIMxZmvnIpEVypvxjtlHBI=;
 b=JVdmi8QsftBJ0Q8P8nrZ3UOGM4ChJ2oHVC2jHqIjXA7hlWcP3V7XVP+BPgxBmw0OBkmi
 q8mHb+8dFtinIqg2+S5tH7QqXjJolNbx+jUQoGrCkfMQ0EMWNHkubC5+MloMANBbsSWY
 9GmwLYsYI/MMaE11sol6srMfeC0hHa9aS0+qkl0C6WeuI7tWKzAeldNpuN6f3CnJR3kr
 +fxge1FZAEn3h66ygqcJL4KiB+NwFSBDmZbfOZrYH9/S3kEGhNpwPDEHAFMzRXF8xNLm
 WdLj9EFy6eSoZGzSnM24st5NL+KJGU/ZcHkHSfqv7HNQ3DKwvSOQYjWRHHZrCHYBWwH2 wA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 2s94bgcedr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 09 May 2019 17:25:39 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x49HP4sf119423;
        Thu, 9 May 2019 17:25:38 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 2scpy5t219-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 09 May 2019 17:25:38 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x49HPbcl031171;
        Thu, 9 May 2019 17:25:37 GMT
Received: from aa1-ca-oracle-com.ca.oracle.com (/10.156.75.204)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 09 May 2019 10:25:37 -0700
From:   Ankur Arora <ankur.a.arora@oracle.com>
To:     linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org
Cc:     jgross@suse.com, pbonzini@redhat.com, boris.ostrovsky@oracle.com,
        konrad.wilk@oracle.com, sstabellini@kernel.org,
        joao.m.martins@oracle.com, ankur.a.arora@oracle.com
Subject: [RFC PATCH 03/16] x86/xen: make hypercall_page generic
Date:   Thu,  9 May 2019 10:25:27 -0700
Message-Id: <20190509172540.12398-4-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190509172540.12398-1-ankur.a.arora@oracle.com>
References: <20190509172540.12398-1-ankur.a.arora@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9252 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1905090100
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9252 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1905090100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make hypercall_page a generic interface which can be implemented
by other hypervisors. With this change, hypercall_page now points to
the newly introduced xen_hypercall_page which is seeded by Xen, or
to one that is filled in by a different hypervisor.

Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 arch/x86/include/asm/xen/hypercall.h | 12 +++++++-----
 arch/x86/xen/enlighten.c             |  1 +
 arch/x86/xen/enlighten_hvm.c         |  3 ++-
 arch/x86/xen/enlighten_pv.c          |  1 +
 arch/x86/xen/enlighten_pvh.c         |  3 ++-
 arch/x86/xen/xen-asm_32.S            |  2 +-
 arch/x86/xen/xen-asm_64.S            |  2 +-
 arch/x86/xen/xen-head.S              |  8 ++++----
 8 files changed, 19 insertions(+), 13 deletions(-)

diff --git a/arch/x86/include/asm/xen/hypercall.h b/arch/x86/include/asm/xen/hypercall.h
index ef05bea7010d..1a3cd6680e6f 100644
--- a/arch/x86/include/asm/xen/hypercall.h
+++ b/arch/x86/include/asm/xen/hypercall.h
@@ -86,11 +86,13 @@ struct xen_dm_op_buf;
  * there aren't more than 5 arguments...)
  */
 
-extern struct { char _entry[32]; } hypercall_page[];
+struct hypercall_entry { char _entry[32]; };
+extern struct hypercall_entry xen_hypercall_page[128];
+extern struct hypercall_entry *hypercall_page;
 
-#define __HYPERCALL		"call hypercall_page+%c[offset]"
+#define __HYPERCALL	CALL_NOSPEC
 #define __HYPERCALL_ENTRY(x)						\
-	[offset] "i" (__HYPERVISOR_##x * sizeof(hypercall_page[0]))
+	[thunk_target] "0" (hypercall_page + __HYPERVISOR_##x)
 
 #ifdef CONFIG_X86_32
 #define __HYPERCALL_RETREG	"eax"
@@ -116,7 +118,7 @@ extern struct { char _entry[32]; } hypercall_page[];
 	register unsigned long __arg4 asm(__HYPERCALL_ARG4REG) = __arg4; \
 	register unsigned long __arg5 asm(__HYPERCALL_ARG5REG) = __arg5;
 
-#define __HYPERCALL_0PARAM	"=r" (__res), ASM_CALL_CONSTRAINT
+#define __HYPERCALL_0PARAM	"=&r" (__res), ASM_CALL_CONSTRAINT
 #define __HYPERCALL_1PARAM	__HYPERCALL_0PARAM, "+r" (__arg1)
 #define __HYPERCALL_2PARAM	__HYPERCALL_1PARAM, "+r" (__arg2)
 #define __HYPERCALL_3PARAM	__HYPERCALL_2PARAM, "+r" (__arg3)
@@ -208,7 +210,7 @@ xen_single_call(unsigned int call,
 
 	asm volatile(CALL_NOSPEC
 		     : __HYPERCALL_5PARAM
-		     : [thunk_target] "a" (&hypercall_page[call])
+		     : [thunk_target] "0" (hypercall_page + call)
 		     : __HYPERCALL_CLOBBER5);
 
 	return (long)__res;
diff --git a/arch/x86/xen/enlighten.c b/arch/x86/xen/enlighten.c
index 750f46ad018a..e9dc92e79afa 100644
--- a/arch/x86/xen/enlighten.c
+++ b/arch/x86/xen/enlighten.c
@@ -20,6 +20,7 @@
 #include "smp.h"
 #include "pmu.h"
 
+struct hypercall_entry *hypercall_page;
 EXPORT_SYMBOL_GPL(hypercall_page);
 
 /*
diff --git a/arch/x86/xen/enlighten_hvm.c b/arch/x86/xen/enlighten_hvm.c
index ffc5791675b2..4d85cd2ff261 100644
--- a/arch/x86/xen/enlighten_hvm.c
+++ b/arch/x86/xen/enlighten_hvm.c
@@ -115,8 +115,9 @@ static void __init init_hvm_pv_info(void)
 
 		pv_info.name = "Xen HVM";
 		msr = cpuid_ebx(base + 2);
-		pfn = __pa(hypercall_page);
+		pfn = __pa(xen_hypercall_page);
 		wrmsr_safe(msr, (u32)pfn, (u32)(pfn >> 32));
+		hypercall_page = xen_hypercall_page;
 	}
 
 	xen_setup_features();
diff --git a/arch/x86/xen/enlighten_pv.c b/arch/x86/xen/enlighten_pv.c
index a4e04b0cc596..3239e8452ede 100644
--- a/arch/x86/xen/enlighten_pv.c
+++ b/arch/x86/xen/enlighten_pv.c
@@ -1217,6 +1217,7 @@ asmlinkage __visible void __init xen_start_kernel(void)
 
 	if (!xen_start_info)
 		return;
+	hypercall_page = xen_hypercall_page;
 
 	xenhost_register(xenhost_r1, &xh_pv_ops);
 
diff --git a/arch/x86/xen/enlighten_pvh.c b/arch/x86/xen/enlighten_pvh.c
index c07eba169572..e47866fcb7ea 100644
--- a/arch/x86/xen/enlighten_pvh.c
+++ b/arch/x86/xen/enlighten_pvh.c
@@ -46,8 +46,9 @@ void __init xen_pvh_init(void)
 	xen_start_flags = pvh_start_info.flags;
 
 	msr = cpuid_ebx(xen_cpuid_base() + 2);
-	pfn = __pa(hypercall_page);
+	pfn = __pa(xen_hypercall_page);
 	wrmsr_safe(msr, (u32)pfn, (u32)(pfn >> 32));
+	hypercall_page = xen_hypercall_page;
 }
 
 void __init mem_map_via_hcall(struct boot_params *boot_params_p)
diff --git a/arch/x86/xen/xen-asm_32.S b/arch/x86/xen/xen-asm_32.S
index c15db060a242..ee4998055ea9 100644
--- a/arch/x86/xen/xen-asm_32.S
+++ b/arch/x86/xen/xen-asm_32.S
@@ -121,7 +121,7 @@ xen_iret_end_crit:
 
 hyper_iret:
 	/* put this out of line since its very rarely used */
-	jmp hypercall_page + __HYPERVISOR_iret * 32
+	jmp xen_hypercall_page + __HYPERVISOR_iret * 32
 
 	.globl xen_iret_start_crit, xen_iret_end_crit
 
diff --git a/arch/x86/xen/xen-asm_64.S b/arch/x86/xen/xen-asm_64.S
index 1e9ef0ba30a5..2172d6aec9a3 100644
--- a/arch/x86/xen/xen-asm_64.S
+++ b/arch/x86/xen/xen-asm_64.S
@@ -70,7 +70,7 @@ ENTRY(xen_early_idt_handler_array)
 END(xen_early_idt_handler_array)
 	__FINIT
 
-hypercall_iret = hypercall_page + __HYPERVISOR_iret * 32
+hypercall_iret = xen_hypercall_page + __HYPERVISOR_iret * 32
 /*
  * Xen64 iret frame:
  *
diff --git a/arch/x86/xen/xen-head.S b/arch/x86/xen/xen-head.S
index 5077ead5e59c..7ff5437bd83f 100644
--- a/arch/x86/xen/xen-head.S
+++ b/arch/x86/xen/xen-head.S
@@ -58,18 +58,18 @@ END(startup_xen)
 
 .pushsection .text
 	.balign PAGE_SIZE
-ENTRY(hypercall_page)
+ENTRY(xen_hypercall_page)
 	.rept (PAGE_SIZE / 32)
 		UNWIND_HINT_EMPTY
 		.skip 32
 	.endr
 
 #define HYPERCALL(n) \
-	.equ xen_hypercall_##n, hypercall_page + __HYPERVISOR_##n * 32; \
+	.equ xen_hypercall_##n, xen_hypercall_page + __HYPERVISOR_##n * 32; \
 	.type xen_hypercall_##n, @function; .size xen_hypercall_##n, 32
 #include <asm/xen-hypercalls.h>
 #undef HYPERCALL
-END(hypercall_page)
+END(xen_hypercall_page)
 .popsection
 
 	ELFNOTE(Xen, XEN_ELFNOTE_GUEST_OS,       .asciz "linux")
@@ -85,7 +85,7 @@ END(hypercall_page)
 #ifdef CONFIG_XEN_PV
 	ELFNOTE(Xen, XEN_ELFNOTE_ENTRY,          _ASM_PTR startup_xen)
 #endif
-	ELFNOTE(Xen, XEN_ELFNOTE_HYPERCALL_PAGE, _ASM_PTR hypercall_page)
+	ELFNOTE(Xen, XEN_ELFNOTE_HYPERCALL_PAGE, _ASM_PTR xen_hypercall_page)
 	ELFNOTE(Xen, XEN_ELFNOTE_FEATURES,
 		.ascii "!writable_page_tables|pae_pgdir_above_4gb")
 	ELFNOTE(Xen, XEN_ELFNOTE_SUPPORTED_FEATURES,
-- 
2.20.1

