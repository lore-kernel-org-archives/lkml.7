Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04F3BC04AB1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 17:26:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB4C1216C4
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 17:26:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="JyGGmcUX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726973AbfEIR0N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 13:26:13 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:42032 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726927AbfEIR0L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 13:26:11 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x49HJORW162281;
        Thu, 9 May 2019 17:25:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2018-07-02;
 bh=0sHcBQZZm2m8n7VSeg5613BdtRsT5ec0dUBXwtC8uAs=;
 b=JyGGmcUXpwvFNaK/lrakoZFVukYREhe0xbAYoDTz4BfT7Lyof/WWdQ63X5n03aLEUAHc
 Q9c/Gx3DWwP8V/VwvySdPLTdORRSXxxEqcNMoFqURZKq0pugx2RsXIBh017YLz5oe0QS
 9EGDo0oPhwOTDH5PV4QkW1FdOFDooYt1l1uwL2cxMiNP5j5+zwerGeekJRaNrIGrkoNI
 s3inlBCJECgL9pHT0m+bhg1xYug8YAGbmNGW6gA8hzllGN9qtgpqUEDDj9EnLDbo/vL8
 wcWgNN6XUwpFkWLMn+dRn39eaxtRJ2ukIhdM3yoXj0QHZoeh39P1NIes7sE6GicO/E06 /g== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2130.oracle.com with ESMTP id 2s94b6ceyx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 09 May 2019 17:25:44 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x49HPhZS086735;
        Thu, 9 May 2019 17:25:43 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 2s94agwu1p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 09 May 2019 17:25:43 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x49HPcBW031181;
        Thu, 9 May 2019 17:25:38 GMT
Received: from aa1-ca-oracle-com.ca.oracle.com (/10.156.75.204)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 09 May 2019 10:25:37 -0700
From:   Ankur Arora <ankur.a.arora@oracle.com>
To:     linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org
Cc:     jgross@suse.com, pbonzini@redhat.com, boris.ostrovsky@oracle.com,
        konrad.wilk@oracle.com, sstabellini@kernel.org,
        joao.m.martins@oracle.com, ankur.a.arora@oracle.com
Subject: [RFC PATCH 04/16] x86/xen: hypercall support for xenhost_t
Date:   Thu,  9 May 2019 10:25:28 -0700
Message-Id: <20190509172540.12398-5-ankur.a.arora@oracle.com>
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

Allow for different hypercall implementations for different xenhost types.
Nested xenhost, which has two underlying xenhosts, can use both
simultaneously.

The hypercall macros (HYPERVISOR_*) implicitly use the default xenhost.x
A new macro (hypervisor_*) takes xenhost_t * as a parameter and does the
right thing.

TODO:
  - Multicalls for now assume the default xenhost
  - xen_hypercall_* symbols are only generated for the default xenhost.

Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 arch/x86/include/asm/xen/hypercall.h | 233 ++++++++++++++++++---------
 arch/x86/xen/enlighten.c             |   3 -
 arch/x86/xen/enlighten_hvm.c         |  23 ++-
 arch/x86/xen/enlighten_pv.c          |  13 +-
 arch/x86/xen/enlighten_pvh.c         |   9 +-
 arch/x86/xen/xen-head.S              |   3 +
 drivers/xen/fallback.c               |   8 +-
 include/xen/xenhost.h                |  23 +++
 8 files changed, 218 insertions(+), 97 deletions(-)

diff --git a/arch/x86/include/asm/xen/hypercall.h b/arch/x86/include/asm/xen/hypercall.h
index 1a3cd6680e6f..e138f9c36a5a 100644
--- a/arch/x86/include/asm/xen/hypercall.h
+++ b/arch/x86/include/asm/xen/hypercall.h
@@ -51,6 +51,7 @@
 #include <xen/interface/physdev.h>
 #include <xen/interface/platform.h>
 #include <xen/interface/xen-mca.h>
+#include <xen/xenhost.h>
 
 struct xen_dm_op_buf;
 
@@ -88,11 +89,11 @@ struct xen_dm_op_buf;
 
 struct hypercall_entry { char _entry[32]; };
 extern struct hypercall_entry xen_hypercall_page[128];
-extern struct hypercall_entry *hypercall_page;
+extern struct hypercall_entry xen_hypercall_page2[128];
 
 #define __HYPERCALL	CALL_NOSPEC
-#define __HYPERCALL_ENTRY(x)						\
-	[thunk_target] "0" (hypercall_page + __HYPERVISOR_##x)
+#define __HYPERCALL_ENTRY(xh, x)						\
+	[thunk_target] "0" (xh->hypercall_page + __HYPERVISOR_##x)
 
 #ifdef CONFIG_X86_32
 #define __HYPERCALL_RETREG	"eax"
@@ -144,57 +145,57 @@ extern struct hypercall_entry *hypercall_page;
 #define __HYPERCALL_CLOBBER1	__HYPERCALL_CLOBBER2, __HYPERCALL_ARG2REG
 #define __HYPERCALL_CLOBBER0	__HYPERCALL_CLOBBER1, __HYPERCALL_ARG1REG
 
-#define _hypercall0(type, name)						\
+#define _hypercall0(xh, type, name)					\
 ({									\
 	__HYPERCALL_DECLS;						\
 	__HYPERCALL_0ARG();						\
 	asm volatile (__HYPERCALL					\
 		      : __HYPERCALL_0PARAM				\
-		      : __HYPERCALL_ENTRY(name)				\
+		      : __HYPERCALL_ENTRY(xh, name)			\
 		      : __HYPERCALL_CLOBBER0);				\
 	(type)__res;							\
 })
 
-#define _hypercall1(type, name, a1)					\
+#define _hypercall1(xh, type, name, a1)					\
 ({									\
 	__HYPERCALL_DECLS;						\
 	__HYPERCALL_1ARG(a1);						\
 	asm volatile (__HYPERCALL					\
 		      : __HYPERCALL_1PARAM				\
-		      : __HYPERCALL_ENTRY(name)				\
+		      : __HYPERCALL_ENTRY(xh, name)			\
 		      : __HYPERCALL_CLOBBER1);				\
 	(type)__res;							\
 })
 
-#define _hypercall2(type, name, a1, a2)					\
+#define _hypercall2(xh, type, name, a1, a2)				\
 ({									\
 	__HYPERCALL_DECLS;						\
 	__HYPERCALL_2ARG(a1, a2);					\
 	asm volatile (__HYPERCALL					\
 		      : __HYPERCALL_2PARAM				\
-		      : __HYPERCALL_ENTRY(name)				\
+		      : __HYPERCALL_ENTRY(xh, name)			\
 		      : __HYPERCALL_CLOBBER2);				\
 	(type)__res;							\
 })
 
-#define _hypercall3(type, name, a1, a2, a3)				\
+#define _hypercall3(xh, type, name, a1, a2, a3)				\
 ({									\
 	__HYPERCALL_DECLS;						\
 	__HYPERCALL_3ARG(a1, a2, a3);					\
 	asm volatile (__HYPERCALL					\
 		      : __HYPERCALL_3PARAM				\
-		      : __HYPERCALL_ENTRY(name)				\
+		      : __HYPERCALL_ENTRY(xh, name)			\
 		      : __HYPERCALL_CLOBBER3);				\
 	(type)__res;							\
 })
 
-#define _hypercall4(type, name, a1, a2, a3, a4)				\
+#define _hypercall4(xh, type, name, a1, a2, a3, a4)			\
 ({									\
 	__HYPERCALL_DECLS;						\
 	__HYPERCALL_4ARG(a1, a2, a3, a4);				\
 	asm volatile (__HYPERCALL					\
 		      : __HYPERCALL_4PARAM				\
-		      : __HYPERCALL_ENTRY(name)				\
+		      : __HYPERCALL_ENTRY(xh, name)			\
 		      : __HYPERCALL_CLOBBER4);				\
 	(type)__res;							\
 })
@@ -210,7 +211,7 @@ xen_single_call(unsigned int call,
 
 	asm volatile(CALL_NOSPEC
 		     : __HYPERCALL_5PARAM
-		     : [thunk_target] "0" (hypercall_page + call)
+		     : [thunk_target] "0" (xh_default->hypercall_page + call)
 		     : __HYPERCALL_CLOBBER5);
 
 	return (long)__res;
@@ -232,170 +233,235 @@ privcmd_call(unsigned int call,
 }
 
 static inline int
-HYPERVISOR_set_trap_table(struct trap_info *table)
+hypervisor_set_trap_table(xenhost_t *xh, struct trap_info *table)
 {
-	return _hypercall1(int, set_trap_table, table);
+	return _hypercall1(xh, int, set_trap_table, table);
 }
 
+#define HYPERVISOR_set_trap_table(table) \
+	hypervisor_set_trap_table(xh_default, table)
+
 static inline int
-HYPERVISOR_mmu_update(struct mmu_update *req, int count,
+hypervisor_mmu_update(xenhost_t *xh, struct mmu_update *req, int count,
 		      int *success_count, domid_t domid)
 {
-	return _hypercall4(int, mmu_update, req, count, success_count, domid);
+	return _hypercall4(xh, int, mmu_update, req, count, success_count, domid);
 }
+#define HYPERVISOR_mmu_update(req, count, success_count, domid)	\
+	hypervisor_mmu_update(xh_default, req, count, success_count, domid)
 
 static inline int
-HYPERVISOR_mmuext_op(struct mmuext_op *op, int count,
+hypervisor_mmuext_op(xenhost_t *xh, struct mmuext_op *op, int count,
 		     int *success_count, domid_t domid)
 {
-	return _hypercall4(int, mmuext_op, op, count, success_count, domid);
+	return _hypercall4(xh, int, mmuext_op, op, count, success_count, domid);
 }
 
+#define HYPERVISOR_mmuext_op(op, count, success_count, domid)	\
+	hypervisor_mmuext_op(xh_default, op, count, success_count, domid)
+
 static inline int
-HYPERVISOR_set_gdt(unsigned long *frame_list, int entries)
+hypervisor_set_gdt(xenhost_t *xh, unsigned long *frame_list, int entries)
 {
-	return _hypercall2(int, set_gdt, frame_list, entries);
+	return _hypercall2(xh, int, set_gdt, frame_list, entries);
 }
 
+#define HYPERVISOR_set_gdt(frame_list, entries)		\
+	hypervisor_set_gdt(xh_default, frame_list, entries)
+
 static inline int
-HYPERVISOR_callback_op(int cmd, void *arg)
+hypervisor_callback_op(xenhost_t *xh, int cmd, void *arg)
 {
-	return _hypercall2(int, callback_op, cmd, arg);
+	return _hypercall2(xh, int, callback_op, cmd, arg);
 }
 
+#define HYPERVISOR_callback_op(cmd, arg)	\
+	hypervisor_callback_op(xh_default, cmd, arg)
+
 static inline int
-HYPERVISOR_sched_op(int cmd, void *arg)
+hypervisor_sched_op(xenhost_t *xh, int cmd, void *arg)
 {
-	return _hypercall2(int, sched_op, cmd, arg);
+	return _hypercall2(xh, int, sched_op, cmd, arg);
 }
 
+#define HYPERVISOR_sched_op(cmd, arg)		\
+	 hypervisor_sched_op(xh_default, cmd, arg)
+
 static inline long
-HYPERVISOR_set_timer_op(u64 timeout)
+hypervisor_set_timer_op(xenhost_t *xh, u64 timeout)
 {
 	unsigned long timeout_hi = (unsigned long)(timeout>>32);
 	unsigned long timeout_lo = (unsigned long)timeout;
-	return _hypercall2(long, set_timer_op, timeout_lo, timeout_hi);
+	return _hypercall2(xh, long, set_timer_op, timeout_lo, timeout_hi);
 }
 
+#define HYPERVISOR_set_timer_op(timeout)	\
+	hypervisor_set_timer_op(xh_default, timeout)
+
 static inline int
-HYPERVISOR_mca(struct xen_mc *mc_op)
+hypervisor_mca(xenhost_t *xh, struct xen_mc *mc_op)
 {
 	mc_op->interface_version = XEN_MCA_INTERFACE_VERSION;
-	return _hypercall1(int, mca, mc_op);
+	return _hypercall1(xh, int, mca, mc_op);
 }
 
+#define HYPERVISOR_mca(mc_op)	\
+	hypervisor_mca(xh_default, mc_op)
+
 static inline int
-HYPERVISOR_platform_op(struct xen_platform_op *op)
+hypervisor_platform_op(xenhost_t *xh, struct xen_platform_op *op)
 {
 	op->interface_version = XENPF_INTERFACE_VERSION;
-	return _hypercall1(int, platform_op, op);
+	return _hypercall1(xh, int, platform_op, op);
 }
 
+#define HYPERVISOR_platform_op(op)	\
+	hypervisor_platform_op(xh_default, op)
+
 static inline int
-HYPERVISOR_set_debugreg(int reg, unsigned long value)
+hypervisor_set_debugreg(xenhost_t *xh, int reg, unsigned long value)
 {
-	return _hypercall2(int, set_debugreg, reg, value);
+	return _hypercall2(xh, int, set_debugreg, reg, value);
 }
 
+#define HYPERVISOR_set_debugreg(reg, value)	\
+	hypervisor_set_debugreg(xh_default, reg, value)
+
 static inline unsigned long
-HYPERVISOR_get_debugreg(int reg)
+hypervisor_get_debugreg(xenhost_t *xh, int reg)
 {
-	return _hypercall1(unsigned long, get_debugreg, reg);
+	return _hypercall1(xh, unsigned long, get_debugreg, reg);
 }
+#define HYPERVISOR_get_debugreg(reg)	\
+	hypervisor_get_debugreg(xh_default, reg)
 
 static inline int
-HYPERVISOR_update_descriptor(u64 ma, u64 desc)
+hypervisor_update_descriptor(xenhost_t *xh, u64 ma, u64 desc)
 {
 	if (sizeof(u64) == sizeof(long))
-		return _hypercall2(int, update_descriptor, ma, desc);
-	return _hypercall4(int, update_descriptor, ma, ma>>32, desc, desc>>32);
+		return _hypercall2(xh, int, update_descriptor, ma, desc);
+	return _hypercall4(xh, int, update_descriptor, ma, ma>>32, desc, desc>>32);
 }
 
+#define HYPERVISOR_update_descriptor(ma, desc)	\
+	hypervisor_update_descriptor(xh_default, ma, desc)
+
 static inline long
-HYPERVISOR_memory_op(unsigned int cmd, void *arg)
+hypervisor_memory_op(xenhost_t *xh, unsigned int cmd, void *arg)
 {
-	return _hypercall2(long, memory_op, cmd, arg);
+	return _hypercall2(xh, long, memory_op, cmd, arg);
 }
 
+#define HYPERVISOR_memory_op(cmd, arg)	\
+	hypervisor_memory_op(xh_default, cmd, arg)	\
+
 static inline int
-HYPERVISOR_multicall(void *call_list, uint32_t nr_calls)
+hypervisor_multicall(xenhost_t *xh, void *call_list, uint32_t nr_calls)
 {
-	return _hypercall2(int, multicall, call_list, nr_calls);
+	return _hypercall2(xh, int, multicall, call_list, nr_calls);
 }
 
+#define HYPERVISOR_multicall(call_list, nr_calls)	\
+	hypervisor_multicall(xh_default, call_list, nr_calls)
+
 static inline int
-HYPERVISOR_update_va_mapping(unsigned long va, pte_t new_val,
+hypervisor_update_va_mapping(xenhost_t *xh, unsigned long va, pte_t new_val,
 			     unsigned long flags)
 {
 	if (sizeof(new_val) == sizeof(long))
-		return _hypercall3(int, update_va_mapping, va,
+		return _hypercall3(xh, int, update_va_mapping, va,
 				   new_val.pte, flags);
 	else
-		return _hypercall4(int, update_va_mapping, va,
+		return _hypercall4(xh, int, update_va_mapping, va,
 				   new_val.pte, new_val.pte >> 32, flags);
 }
-extern int __must_check xen_event_channel_op_compat(int, void *);
+
+#define HYPERVISOR_update_va_mapping(va, new_val, flags)	\
+	hypervisor_update_va_mapping(xh_default, va, new_val, flags)
+
+extern int __must_check xen_event_channel_op_compat(xenhost_t *xh, int, void *);
 
 static inline int
-HYPERVISOR_event_channel_op(int cmd, void *arg)
+hypervisor_event_channel_op(xenhost_t *xh, int cmd, void *arg)
 {
-	int rc = _hypercall2(int, event_channel_op, cmd, arg);
+	int rc = _hypercall2(xh, int, event_channel_op, cmd, arg);
 	if (unlikely(rc == -ENOSYS))
-		rc = xen_event_channel_op_compat(cmd, arg);
+		rc = xen_event_channel_op_compat(xh, cmd, arg);
 	return rc;
 }
 
+#define HYPERVISOR_event_channel_op(cmd, arg)		\
+	hypervisor_event_channel_op(xh_default, cmd, arg)
+
 static inline int
-HYPERVISOR_xen_version(int cmd, void *arg)
+hypervisor_xen_version(xenhost_t *xh, int cmd, void *arg)
 {
-	return _hypercall2(int, xen_version, cmd, arg);
+	return _hypercall2(xh, int, xen_version, cmd, arg);
 }
 
+#define HYPERVISOR_xen_version(cmd, arg)	\
+	hypervisor_xen_version(xh_default, cmd, arg)
+
 static inline int
-HYPERVISOR_console_io(int cmd, int count, char *str)
+hypervisor_console_io(xenhost_t *xh, int cmd, int count, char *str)
 {
-	return _hypercall3(int, console_io, cmd, count, str);
+	return _hypercall3(xh, int, console_io, cmd, count, str);
 }
+#define HYPERVISOR_console_io(cmd, count, str) \
+	hypervisor_console_io(xh_default, cmd, count, str)
 
-extern int __must_check xen_physdev_op_compat(int, void *);
+extern int __must_check xen_physdev_op_compat(xenhost_t *xh, int, void *);
 
 static inline int
-HYPERVISOR_physdev_op(int cmd, void *arg)
+hypervisor_physdev_op(xenhost_t *xh, int cmd, void *arg)
 {
-	int rc = _hypercall2(int, physdev_op, cmd, arg);
+	int rc = _hypercall2(xh, int, physdev_op, cmd, arg);
 	if (unlikely(rc == -ENOSYS))
-		rc = xen_physdev_op_compat(cmd, arg);
+		rc = xen_physdev_op_compat(xh, cmd, arg);
 	return rc;
 }
+#define HYPERVISOR_physdev_op(cmd, arg)	\
+	hypervisor_physdev_op(xh_default, cmd, arg)
 
 static inline int
-HYPERVISOR_grant_table_op(unsigned int cmd, void *uop, unsigned int count)
+hypervisor_grant_table_op(xenhost_t *xh, unsigned int cmd, void *uop, unsigned int count)
 {
-	return _hypercall3(int, grant_table_op, cmd, uop, count);
+	return _hypercall3(xh, int, grant_table_op, cmd, uop, count);
 }
 
+#define HYPERVISOR_grant_table_op(cmd, uop, count)	\
+	hypervisor_grant_table_op(xh_default, cmd, uop, count)
+
 static inline int
-HYPERVISOR_vm_assist(unsigned int cmd, unsigned int type)
+hypervisor_vm_assist(xenhost_t *xh, unsigned int cmd, unsigned int type)
 {
-	return _hypercall2(int, vm_assist, cmd, type);
+	return _hypercall2(xh, int, vm_assist, cmd, type);
 }
 
+#define HYPERVISOR_vm_assist(cmd, type)		\
+	hypervisor_vm_assist(xh_default, cmd, type)
+
 static inline int
-HYPERVISOR_vcpu_op(int cmd, int vcpuid, void *extra_args)
+hypervisor_vcpu_op(xenhost_t *xh, int cmd, int vcpuid, void *extra_args)
 {
-	return _hypercall3(int, vcpu_op, cmd, vcpuid, extra_args);
+	return _hypercall3(xh, int, vcpu_op, cmd, vcpuid, extra_args);
 }
 
+#define HYPERVISOR_vcpu_op(cmd, vcpuid, extra_args)	\
+	hypervisor_vcpu_op(xh_default, cmd, vcpuid, extra_args)
+
 #ifdef CONFIG_X86_64
 static inline int
-HYPERVISOR_set_segment_base(int reg, unsigned long value)
+hypervisor_set_segment_base(xenhost_t *xh, int reg, unsigned long value)
 {
-	return _hypercall2(int, set_segment_base, reg, value);
+	return _hypercall2(xh, int, set_segment_base, reg, value);
 }
+#define HYPERVISOR_set_segment_base(reg, value)		\
+	hypervisor_set_segment_base(xh_default, reg, value)
 #endif
 
 static inline int
-HYPERVISOR_suspend(unsigned long start_info_mfn)
+hypervisor_suspend(xenhost_t *xh, unsigned long start_info_mfn)
 {
 	struct sched_shutdown r = { .reason = SHUTDOWN_suspend };
 
@@ -405,38 +471,53 @@ HYPERVISOR_suspend(unsigned long start_info_mfn)
 	 * hypercall calling convention this is the third hypercall
 	 * argument, which is start_info_mfn here.
 	 */
-	return _hypercall3(int, sched_op, SCHEDOP_shutdown, &r, start_info_mfn);
+	return _hypercall3(xh, int, sched_op, SCHEDOP_shutdown, &r, start_info_mfn);
 }
+#define HYPERVISOR_suspend(start_info_mfn)	\
+	hypervisor_suspend(xh_default, start_info_mfn)
 
 static inline unsigned long __must_check
-HYPERVISOR_hvm_op(int op, void *arg)
+hypervisor_hvm_op(xenhost_t *xh, int op, void *arg)
 {
-       return _hypercall2(unsigned long, hvm_op, op, arg);
+       return _hypercall2(xh, unsigned long, hvm_op, op, arg);
 }
 
+#define HYPERVISOR_hvm_op(op, arg)	\
+	hypervisor_hvm_op(xh_default, op, arg)
+
 static inline int
-HYPERVISOR_tmem_op(
+hypervisor_tmem_op(
+	xenhost_t *xh,
 	struct tmem_op *op)
 {
-	return _hypercall1(int, tmem_op, op);
+	return _hypercall1(xh, int, tmem_op, op);
 }
 
+#define HYPERVISOR_tmem_op(op)	\
+	hypervisor_tmem_op(xh_default, op)
+
 static inline int
-HYPERVISOR_xenpmu_op(unsigned int op, void *arg)
+hypervisor_xenpmu_op(xenhost_t *xh, unsigned int op, void *arg)
 {
-	return _hypercall2(int, xenpmu_op, op, arg);
+	return _hypercall2(xh, int, xenpmu_op, op, arg);
 }
 
+#define HYPERVISOR_xenpmu_op(op, arg) \
+	hypervisor_xenpmu_op(xh_default, op, arg)
+
 static inline int
-HYPERVISOR_dm_op(
+hypervisor_dm_op(
+	xenhost_t *xh,
 	domid_t dom, unsigned int nr_bufs, struct xen_dm_op_buf *bufs)
 {
 	int ret;
 	stac();
-	ret = _hypercall3(int, dm_op, dom, nr_bufs, bufs);
+	ret = _hypercall3(xh, int, dm_op, dom, nr_bufs, bufs);
 	clac();
 	return ret;
 }
+#define HYPERVISOR_dm_op(dom, nr_bufs, bufs)	\
+	hypervisor_dm_op(xh_default, dom, nr_bufs, bufs)
 
 static inline void
 MULTI_fpu_taskswitch(struct multicall_entry *mcl, int set)
diff --git a/arch/x86/xen/enlighten.c b/arch/x86/xen/enlighten.c
index e9dc92e79afa..f88bb14da3f2 100644
--- a/arch/x86/xen/enlighten.c
+++ b/arch/x86/xen/enlighten.c
@@ -20,9 +20,6 @@
 #include "smp.h"
 #include "pmu.h"
 
-struct hypercall_entry *hypercall_page;
-EXPORT_SYMBOL_GPL(hypercall_page);
-
 /*
  * Pointer to the xen_vcpu_info structure or
  * &HYPERVISOR_shared_info->vcpu_info[cpu]. See xen_hvm_init_shared_info
diff --git a/arch/x86/xen/enlighten_hvm.c b/arch/x86/xen/enlighten_hvm.c
index 4d85cd2ff261..f84941d6944e 100644
--- a/arch/x86/xen/enlighten_hvm.c
+++ b/arch/x86/xen/enlighten_hvm.c
@@ -85,8 +85,20 @@ static void __init xen_hvm_init_mem_mapping(void)
 
 extern uint32_t xen_pv_cpuid_base(xenhost_t *xh);
 
+void xen_hvm_setup_hypercall_page(xenhost_t *xh)
+{
+	u32 msr;
+	u64 pfn;
+
+	msr = cpuid_ebx(xenhost_cpuid_base(xh) + 2);
+	pfn = __pa(xen_hypercall_page);
+	wrmsr_safe(msr, (u32)pfn, (u32)(pfn >> 32));
+	xh->hypercall_page = xen_hypercall_page;
+}
+
 xenhost_ops_t xh_hvm_ops = {
 	.cpuid_base = xen_pv_cpuid_base,
+	.setup_hypercall_page = xen_hvm_setup_hypercall_page,
 };
 
 xenhost_ops_t xh_hvm_nested_ops = {
@@ -96,6 +108,7 @@ static void __init init_hvm_pv_info(void)
 {
 	int major, minor;
 	uint32_t eax, ebx, ecx, edx, base;
+	xenhost_t **xh;
 
 	base = xenhost_cpuid_base(xh_default);
 	eax = cpuid_eax(base + 1);
@@ -110,14 +123,10 @@ static void __init init_hvm_pv_info(void)
 	if (xen_pvh_domain())
 		pv_info.name = "Xen PVH";
 	else {
-		u64 pfn;
-		uint32_t msr;
-
 		pv_info.name = "Xen HVM";
-		msr = cpuid_ebx(base + 2);
-		pfn = __pa(xen_hypercall_page);
-		wrmsr_safe(msr, (u32)pfn, (u32)(pfn >> 32));
-		hypercall_page = xen_hypercall_page;
+
+		for_each_xenhost(xh)
+			xenhost_setup_hypercall_page(*xh);
 	}
 
 	xen_setup_features();
diff --git a/arch/x86/xen/enlighten_pv.c b/arch/x86/xen/enlighten_pv.c
index 3239e8452ede..a2c07cc71498 100644
--- a/arch/x86/xen/enlighten_pv.c
+++ b/arch/x86/xen/enlighten_pv.c
@@ -1200,12 +1200,20 @@ uint32_t xen_pv_nested_cpuid_base(xenhost_t *xh)
 				2 /* nested specific leaf? */);
 }
 
+static void xen_pv_setup_hypercall_page(xenhost_t *xh)
+{
+	xh->hypercall_page = xen_hypercall_page;
+}
+
 xenhost_ops_t xh_pv_ops = {
 	.cpuid_base = xen_pv_cpuid_base,
+
+	.setup_hypercall_page = xen_pv_setup_hypercall_page,
 };
 
 xenhost_ops_t xh_pv_nested_ops = {
 	.cpuid_base = xen_pv_nested_cpuid_base,
+	.setup_hypercall_page = NULL,
 };
 
 /* First C function to be called on Xen boot */
@@ -1213,11 +1221,11 @@ asmlinkage __visible void __init xen_start_kernel(void)
 {
 	struct physdev_set_iopl set_iopl;
 	unsigned long initrd_start = 0;
+	xenhost_t **xh;
 	int rc;
 
 	if (!xen_start_info)
 		return;
-	hypercall_page = xen_hypercall_page;
 
 	xenhost_register(xenhost_r1, &xh_pv_ops);
 
@@ -1228,6 +1236,9 @@ asmlinkage __visible void __init xen_start_kernel(void)
 	if (xen_driver_domain() && xen_nested())
 		xenhost_register(xenhost_r2, &xh_pv_nested_ops);
 
+	for_each_xenhost(xh)
+		xenhost_setup_hypercall_page(*xh);
+
 	xen_domain_type = XEN_PV_DOMAIN;
 	xen_start_flags = xen_start_info->flags;
 
diff --git a/arch/x86/xen/enlighten_pvh.c b/arch/x86/xen/enlighten_pvh.c
index e47866fcb7ea..50277dfbdf30 100644
--- a/arch/x86/xen/enlighten_pvh.c
+++ b/arch/x86/xen/enlighten_pvh.c
@@ -26,8 +26,7 @@ extern xenhost_ops_t xh_hvm_ops, xh_hvm_nested_ops;
 
 void __init xen_pvh_init(void)
 {
-	u32 msr;
-	u64 pfn;
+	xenhost_t **xh;
 
 	/*
 	 * Note: we have already called xen_cpuid_base() in
@@ -45,10 +44,8 @@ void __init xen_pvh_init(void)
 	xen_pvh = 1;
 	xen_start_flags = pvh_start_info.flags;
 
-	msr = cpuid_ebx(xen_cpuid_base() + 2);
-	pfn = __pa(xen_hypercall_page);
-	wrmsr_safe(msr, (u32)pfn, (u32)(pfn >> 32));
-	hypercall_page = xen_hypercall_page;
+	for_each_xenhost(xh)
+		xenhost_setup_hypercall_page(*xh);
 }
 
 void __init mem_map_via_hcall(struct boot_params *boot_params_p)
diff --git a/arch/x86/xen/xen-head.S b/arch/x86/xen/xen-head.S
index 7ff5437bd83f..6bbf4ff700d6 100644
--- a/arch/x86/xen/xen-head.S
+++ b/arch/x86/xen/xen-head.S
@@ -70,6 +70,9 @@ ENTRY(xen_hypercall_page)
 #include <asm/xen-hypercalls.h>
 #undef HYPERCALL
 END(xen_hypercall_page)
+/*
+ * Add xen_hypercall_page2 for remote xenhost?
+ */
 .popsection
 
 	ELFNOTE(Xen, XEN_ELFNOTE_GUEST_OS,       .asciz "linux")
diff --git a/drivers/xen/fallback.c b/drivers/xen/fallback.c
index b04fb64c5a91..ae81cf75ae5f 100644
--- a/drivers/xen/fallback.c
+++ b/drivers/xen/fallback.c
@@ -5,14 +5,14 @@
 #include <asm/hypervisor.h>
 #include <asm/xen/hypercall.h>
 
-int xen_event_channel_op_compat(int cmd, void *arg)
+int xen_event_channel_op_compat(xenhost_t *xh, int cmd, void *arg)
 {
 	struct evtchn_op op;
 	int rc;
 
 	op.cmd = cmd;
 	memcpy(&op.u, arg, sizeof(op.u));
-	rc = _hypercall1(int, event_channel_op_compat, &op);
+	rc = _hypercall1(xh, int, event_channel_op_compat, &op);
 
 	switch (cmd) {
 	case EVTCHNOP_close:
@@ -44,14 +44,14 @@ int xen_event_channel_op_compat(int cmd, void *arg)
 }
 EXPORT_SYMBOL_GPL(xen_event_channel_op_compat);
 
-int xen_physdev_op_compat(int cmd, void *arg)
+int xen_physdev_op_compat(xenhost_t *xh, int cmd, void *arg)
 {
 	struct physdev_op op;
 	int rc;
 
 	op.cmd = cmd;
 	memcpy(&op.u, arg, sizeof(op.u));
-	rc = _hypercall1(int, physdev_op_compat, &op);
+	rc = _hypercall1(xh, int, physdev_op_compat, &op);
 
 	switch (cmd) {
 	case PHYSDEVOP_IRQ_UNMASK_NOTIFY:
diff --git a/include/xen/xenhost.h b/include/xen/xenhost.h
index 13a70bdadfd2..d9bc1fb6cce4 100644
--- a/include/xen/xenhost.h
+++ b/include/xen/xenhost.h
@@ -70,6 +70,8 @@ typedef struct {
 	enum xenhost_type type;
 
 	struct xenhost_ops *ops;
+
+	struct hypercall_entry *hypercall_page;
 } xenhost_t;
 
 typedef struct xenhost_ops {
@@ -83,6 +85,22 @@ typedef struct xenhost_ops {
 	 *   Separate cpuid-leafs?
 	 */
 	uint32_t (*cpuid_base)(xenhost_t *xenhost);
+
+	/*
+	 * Hypercall page is setup as the first thing once the PV/PVH/PVHVM
+	 * code detects that it is selected. The first use is in
+	 * xen_setup_features().
+	 *
+	 * PV/PVH/PVHVM set this up in different ways: hypervisor takes
+	 * care of this for PV, PVH and PVHVM use xen_cpuid.
+	 *
+	 *  xenhost_r0: point hypercall_page to external hypercall_page.
+	 *  xenhost_r1: what we do now.
+	 *  xenhost_r2: hypercall interface that bypasses L1-Xen to go from
+	 *    L1-guest to L0-Xen. The interface would allow L0-Xen to be able
+	 *    to decide which particular L1-guest was the caller.
+	 */
+	void (*setup_hypercall_page)(xenhost_t *xenhost);
 } xenhost_ops_t;
 
 extern xenhost_t *xh_default, *xh_remote;
@@ -113,4 +131,9 @@ static inline uint32_t xenhost_cpuid_base(xenhost_t *xh)
 		return xen_cpuid_base();
 }
 
+static inline void xenhost_setup_hypercall_page(xenhost_t *xh)
+{
+	(xh->ops->setup_hypercall_page)(xh);
+}
+
 #endif /* __XENHOST_H */
-- 
2.20.1

