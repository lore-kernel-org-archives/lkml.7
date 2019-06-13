Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D667C31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:09:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E642820896
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:09:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qcg6Ug1W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387443AbfFMPJk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 11:09:40 -0400
Received: from merlin.infradead.org ([205.233.59.134]:49632 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732355AbfFMN5S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 09:57:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=aA/1aavt7PUWSaIskCoz28ksgW1vXkhEJ5m3Kuwr3l8=; b=qcg6Ug1WPjYlxYYRQxdpB/bZTv
        vHZEXWUVOrTiZYbvHLCUSqEL2HAyPK31aPWTrupesw2zcqa1HP+CF9KzobIm2fs+HBwFiRcObhSYu
        ZmQMp08l3ErOF+lCuRXy5HS4ke0Gx7u5hJhdHLB2JQLyct/YsoDX3d79y+KotCgE2L9+HouvvAolj
        V5lUISewZLecs5hNWuFFh+GmbBJdaqo6C7qhLDcGj9EPXu1XOquGConKyIP4Q+SkISgxWTfqnmRgE
        zP2H6JBIq+h0BWwJjB9rVoTHhIvnl1aKmzYxdFMfp6HnSFTA60IUemg1hgE8kFjloIovnYI7Zp1VM
        n2dkEYVQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hbQDy-0004GD-7v; Thu, 13 Jun 2019 13:57:06 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 079A2202C9D74; Thu, 13 Jun 2019 15:57:05 +0200 (CEST)
Message-Id: <20190613135653.212248581@infradead.org>
User-Agent: quilt/0.65
Date:   Thu, 13 Jun 2019 15:54:46 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     torvalds@linux-foundation.org, mingo@kernel.org, bp@alien8.de,
        tglx@linutronix.de, luto@kernel.org, namit@vmware.com,
        peterz@infradead.org
Cc:     linux-kernel@vger.kernel.org, Nadav Amit <nadav.amit@gmail.com>
Subject: [PATCH v2 1/5] x86/percpu: Differentiate this_cpu_{}() and __this_cpu_{}()
References: <20190613135445.318096781@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nadav Amit reported that commit:

  b59167ac7baf ("x86/percpu: Fix this_cpu_read()")

added a bunch of constraints to all sorts of code; and while some of
that was correct and desired, some of that seems superfluous.

The thing is, the this_cpu_*() operations are defined IRQ-safe, this
means the values are subject to change from IRQs, and thus must be
reloaded.

Also, the generic form:

  local_irq_save()
  __this_cpu_read()
  local_irq_restore()

would not allow the re-use of previous values; if by nothing else,
then the barrier()s implied by local_irq_*().

Which raises the point that percpu_from_op() and the others also need
that volatile.

OTOH __this_cpu_*() operations are not IRQ-safe and assume external
preempt/IRQ disabling and could thus be allowed more room for
optimization.

This makes the this_cpu_*() vs __this_cpu_*() behaviour more
consistent with other architectures.

$ ./compare.sh defconfig-build defconfig-build1 vmlinux.o
x86_pmu_cancel_txn                                         80         71   -9,+0
__text_poke                                               919        964   +45,+0
do_user_addr_fault                                       1082       1058   -24,+0
__do_page_fault                                          1194       1178   -16,+0
do_exit                                                  2995       3027   -43,+75
process_one_work                                         1008        989   -67,+48
finish_task_switch                                        524        505   -19,+0
__schedule_bug                                            103         98   -59,+54
__schedule_bug                                            103         98   -59,+54
__sched_setscheduler                                     2015       2030   +15,+0
freeze_processes                                          203        230   +31,-4
rcu_gp_kthread_wake                                       106         99   -7,+0
rcu_core                                                 1841       1834   -7,+0
call_timer_fn                                             298        286   -12,+0
can_stop_idle_tick                                        146        139   -31,+24
perf_pending_event                                        253        239   -14,+0
shmem_alloc_page                                          209        213   +4,+0
__alloc_pages_slowpath                                   3284       3269   -15,+0
umount_tree                                               671        694   +23,+0
advance_transaction                                       803        798   -5,+0
con_put_char                                               71         51   -20,+0
xhci_urb_enqueue                                         1302       1295   -7,+0
xhci_urb_enqueue                                         1302       1295   -7,+0
tcp_sacktag_write_queue                                  2130       2075   -55,+0
tcp_try_undo_loss                                         229        208   -21,+0
tcp_v4_inbound_md5_hash                                   438        411   -31,+4
tcp_v4_inbound_md5_hash                                   438        411   -31,+4
tcp_v6_inbound_md5_hash                                   469        411   -33,-25
tcp_v6_inbound_md5_hash                                   469        411   -33,-25
restricted_pointer                                        434        420   -14,+0
irq_exit                                                  162        154   -8,+0
get_perf_callchain                                        638        624   -14,+0
rt_mutex_trylock                                          169        156   -13,+0
avc_has_extended_perms                                   1092       1089   -3,+0
avc_has_perm_noaudit                                      309        306   -3,+0
__perf_sw_event                                           138        122   -16,+0
perf_swevent_get_recursion_context                        116        102   -14,+0
__local_bh_enable_ip                                       93         72   -21,+0
xfrm_input                                               4175       4161   -14,+0
avc_has_perm                                              446        443   -3,+0
vm_events_fold_cpu                                         57         56   -1,+0
vfree                                                      68         61   -7,+0
freeze_processes                                          203        230   +31,-4
_local_bh_enable                                           44         30   -14,+0
ip_do_fragment                                           1982       1944   -38,+0
do_exit                                                  2995       3027   -43,+75
__do_softirq                                              742        724   -18,+0
cpu_init                                                 1510       1489   -21,+0
account_system_time                                        80         79   -1,+0
                                             total   12985281   12984819   -742,+280

Reported-by: Nadav Amit <nadav.amit@gmail.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20181206112433.GB13675@hirez.programming.kicks-ass.net
---
 arch/x86/include/asm/percpu.h |  224 +++++++++++++++++++++---------------------
 1 file changed, 112 insertions(+), 112 deletions(-)

--- a/arch/x86/include/asm/percpu.h
+++ b/arch/x86/include/asm/percpu.h
@@ -87,7 +87,7 @@
  * don't give an lvalue though). */
 extern void __bad_percpu_size(void);
 
-#define percpu_to_op(op, var, val)			\
+#define percpu_to_op(qual, op, var, val)		\
 do {							\
 	typedef typeof(var) pto_T__;			\
 	if (0) {					\
@@ -97,22 +97,22 @@ do {							\
 	}						\
 	switch (sizeof(var)) {				\
 	case 1:						\
-		asm(op "b %1,"__percpu_arg(0)		\
+		asm qual (op "b %1,"__percpu_arg(0)	\
 		    : "+m" (var)			\
 		    : "qi" ((pto_T__)(val)));		\
 		break;					\
 	case 2:						\
-		asm(op "w %1,"__percpu_arg(0)		\
+		asm qual (op "w %1,"__percpu_arg(0)	\
 		    : "+m" (var)			\
 		    : "ri" ((pto_T__)(val)));		\
 		break;					\
 	case 4:						\
-		asm(op "l %1,"__percpu_arg(0)		\
+		asm qual (op "l %1,"__percpu_arg(0)	\
 		    : "+m" (var)			\
 		    : "ri" ((pto_T__)(val)));		\
 		break;					\
 	case 8:						\
-		asm(op "q %1,"__percpu_arg(0)		\
+		asm qual (op "q %1,"__percpu_arg(0)	\
 		    : "+m" (var)			\
 		    : "re" ((pto_T__)(val)));		\
 		break;					\
@@ -124,7 +124,7 @@ do {							\
  * Generate a percpu add to memory instruction and optimize code
  * if one is added or subtracted.
  */
-#define percpu_add_op(var, val)						\
+#define percpu_add_op(qual, var, val)					\
 do {									\
 	typedef typeof(var) pao_T__;					\
 	const int pao_ID__ = (__builtin_constant_p(val) &&		\
@@ -138,41 +138,41 @@ do {									\
 	switch (sizeof(var)) {						\
 	case 1:								\
 		if (pao_ID__ == 1)					\
-			asm("incb "__percpu_arg(0) : "+m" (var));	\
+			asm qual ("incb "__percpu_arg(0) : "+m" (var));	\
 		else if (pao_ID__ == -1)				\
-			asm("decb "__percpu_arg(0) : "+m" (var));	\
+			asm qual ("decb "__percpu_arg(0) : "+m" (var));	\
 		else							\
-			asm("addb %1, "__percpu_arg(0)			\
+			asm qual ("addb %1, "__percpu_arg(0)		\
 			    : "+m" (var)				\
 			    : "qi" ((pao_T__)(val)));			\
 		break;							\
 	case 2:								\
 		if (pao_ID__ == 1)					\
-			asm("incw "__percpu_arg(0) : "+m" (var));	\
+			asm qual ("incw "__percpu_arg(0) : "+m" (var));	\
 		else if (pao_ID__ == -1)				\
-			asm("decw "__percpu_arg(0) : "+m" (var));	\
+			asm qual ("decw "__percpu_arg(0) : "+m" (var));	\
 		else							\
-			asm("addw %1, "__percpu_arg(0)			\
+			asm qual ("addw %1, "__percpu_arg(0)		\
 			    : "+m" (var)				\
 			    : "ri" ((pao_T__)(val)));			\
 		break;							\
 	case 4:								\
 		if (pao_ID__ == 1)					\
-			asm("incl "__percpu_arg(0) : "+m" (var));	\
+			asm qual ("incl "__percpu_arg(0) : "+m" (var));	\
 		else if (pao_ID__ == -1)				\
-			asm("decl "__percpu_arg(0) : "+m" (var));	\
+			asm qual ("decl "__percpu_arg(0) : "+m" (var));	\
 		else							\
-			asm("addl %1, "__percpu_arg(0)			\
+			asm qual ("addl %1, "__percpu_arg(0)		\
 			    : "+m" (var)				\
 			    : "ri" ((pao_T__)(val)));			\
 		break;							\
 	case 8:								\
 		if (pao_ID__ == 1)					\
-			asm("incq "__percpu_arg(0) : "+m" (var));	\
+			asm qual ("incq "__percpu_arg(0) : "+m" (var));	\
 		else if (pao_ID__ == -1)				\
-			asm("decq "__percpu_arg(0) : "+m" (var));	\
+			asm qual ("decq "__percpu_arg(0) : "+m" (var));	\
 		else							\
-			asm("addq %1, "__percpu_arg(0)			\
+			asm qual ("addq %1, "__percpu_arg(0)		\
 			    : "+m" (var)				\
 			    : "re" ((pao_T__)(val)));			\
 		break;							\
@@ -180,27 +180,27 @@ do {									\
 	}								\
 } while (0)
 
-#define percpu_from_op(op, var)				\
+#define percpu_from_op(qual, op, var)			\
 ({							\
 	typeof(var) pfo_ret__;				\
 	switch (sizeof(var)) {				\
 	case 1:						\
-		asm volatile(op "b "__percpu_arg(1)",%0"\
+		asm qual (op "b "__percpu_arg(1)",%0"	\
 		    : "=q" (pfo_ret__)			\
 		    : "m" (var));			\
 		break;					\
 	case 2:						\
-		asm volatile(op "w "__percpu_arg(1)",%0"\
+		asm qual (op "w "__percpu_arg(1)",%0"	\
 		    : "=r" (pfo_ret__)			\
 		    : "m" (var));			\
 		break;					\
 	case 4:						\
-		asm volatile(op "l "__percpu_arg(1)",%0"\
+		asm qual (op "l "__percpu_arg(1)",%0"	\
 		    : "=r" (pfo_ret__)			\
 		    : "m" (var));			\
 		break;					\
 	case 8:						\
-		asm volatile(op "q "__percpu_arg(1)",%0"\
+		asm qual (op "q "__percpu_arg(1)",%0"	\
 		    : "=r" (pfo_ret__)			\
 		    : "m" (var));			\
 		break;					\
@@ -238,23 +238,23 @@ do {									\
 	pfo_ret__;					\
 })
 
-#define percpu_unary_op(op, var)			\
+#define percpu_unary_op(qual, op, var)			\
 ({							\
 	switch (sizeof(var)) {				\
 	case 1:						\
-		asm(op "b "__percpu_arg(0)		\
+		asm qual (op "b "__percpu_arg(0)	\
 		    : "+m" (var));			\
 		break;					\
 	case 2:						\
-		asm(op "w "__percpu_arg(0)		\
+		asm qual (op "w "__percpu_arg(0)	\
 		    : "+m" (var));			\
 		break;					\
 	case 4:						\
-		asm(op "l "__percpu_arg(0)		\
+		asm qual (op "l "__percpu_arg(0)	\
 		    : "+m" (var));			\
 		break;					\
 	case 8:						\
-		asm(op "q "__percpu_arg(0)		\
+		asm qual (op "q "__percpu_arg(0)	\
 		    : "+m" (var));			\
 		break;					\
 	default: __bad_percpu_size();			\
@@ -264,27 +264,27 @@ do {									\
 /*
  * Add return operation
  */
-#define percpu_add_return_op(var, val)					\
+#define percpu_add_return_op(qual, var, val)				\
 ({									\
 	typeof(var) paro_ret__ = val;					\
 	switch (sizeof(var)) {						\
 	case 1:								\
-		asm("xaddb %0, "__percpu_arg(1)				\
+		asm qual ("xaddb %0, "__percpu_arg(1)			\
 			    : "+q" (paro_ret__), "+m" (var)		\
 			    : : "memory");				\
 		break;							\
 	case 2:								\
-		asm("xaddw %0, "__percpu_arg(1)				\
+		asm qual ("xaddw %0, "__percpu_arg(1)			\
 			    : "+r" (paro_ret__), "+m" (var)		\
 			    : : "memory");				\
 		break;							\
 	case 4:								\
-		asm("xaddl %0, "__percpu_arg(1)				\
+		asm qual ("xaddl %0, "__percpu_arg(1)			\
 			    : "+r" (paro_ret__), "+m" (var)		\
 			    : : "memory");				\
 		break;							\
 	case 8:								\
-		asm("xaddq %0, "__percpu_arg(1)				\
+		asm qual ("xaddq %0, "__percpu_arg(1)			\
 			    : "+re" (paro_ret__), "+m" (var)		\
 			    : : "memory");				\
 		break;							\
@@ -299,13 +299,13 @@ do {									\
  * expensive due to the implied lock prefix.  The processor cannot prefetch
  * cachelines if xchg is used.
  */
-#define percpu_xchg_op(var, nval)					\
+#define percpu_xchg_op(qual, var, nval)					\
 ({									\
 	typeof(var) pxo_ret__;						\
 	typeof(var) pxo_new__ = (nval);					\
 	switch (sizeof(var)) {						\
 	case 1:								\
-		asm("\n\tmov "__percpu_arg(1)",%%al"			\
+		asm qual ("\n\tmov "__percpu_arg(1)",%%al"		\
 		    "\n1:\tcmpxchgb %2, "__percpu_arg(1)		\
 		    "\n\tjnz 1b"					\
 			    : "=&a" (pxo_ret__), "+m" (var)		\
@@ -313,7 +313,7 @@ do {									\
 			    : "memory");				\
 		break;							\
 	case 2:								\
-		asm("\n\tmov "__percpu_arg(1)",%%ax"			\
+		asm qual ("\n\tmov "__percpu_arg(1)",%%ax"		\
 		    "\n1:\tcmpxchgw %2, "__percpu_arg(1)		\
 		    "\n\tjnz 1b"					\
 			    : "=&a" (pxo_ret__), "+m" (var)		\
@@ -321,7 +321,7 @@ do {									\
 			    : "memory");				\
 		break;							\
 	case 4:								\
-		asm("\n\tmov "__percpu_arg(1)",%%eax"			\
+		asm qual ("\n\tmov "__percpu_arg(1)",%%eax"		\
 		    "\n1:\tcmpxchgl %2, "__percpu_arg(1)		\
 		    "\n\tjnz 1b"					\
 			    : "=&a" (pxo_ret__), "+m" (var)		\
@@ -329,7 +329,7 @@ do {									\
 			    : "memory");				\
 		break;							\
 	case 8:								\
-		asm("\n\tmov "__percpu_arg(1)",%%rax"			\
+		asm qual ("\n\tmov "__percpu_arg(1)",%%rax"		\
 		    "\n1:\tcmpxchgq %2, "__percpu_arg(1)		\
 		    "\n\tjnz 1b"					\
 			    : "=&a" (pxo_ret__), "+m" (var)		\
@@ -345,32 +345,32 @@ do {									\
  * cmpxchg has no such implied lock semantics as a result it is much
  * more efficient for cpu local operations.
  */
-#define percpu_cmpxchg_op(var, oval, nval)				\
+#define percpu_cmpxchg_op(qual, var, oval, nval)			\
 ({									\
 	typeof(var) pco_ret__;						\
 	typeof(var) pco_old__ = (oval);					\
 	typeof(var) pco_new__ = (nval);					\
 	switch (sizeof(var)) {						\
 	case 1:								\
-		asm("cmpxchgb %2, "__percpu_arg(1)			\
+		asm qual ("cmpxchgb %2, "__percpu_arg(1)		\
 			    : "=a" (pco_ret__), "+m" (var)		\
 			    : "q" (pco_new__), "0" (pco_old__)		\
 			    : "memory");				\
 		break;							\
 	case 2:								\
-		asm("cmpxchgw %2, "__percpu_arg(1)			\
+		asm qual ("cmpxchgw %2, "__percpu_arg(1)		\
 			    : "=a" (pco_ret__), "+m" (var)		\
 			    : "r" (pco_new__), "0" (pco_old__)		\
 			    : "memory");				\
 		break;							\
 	case 4:								\
-		asm("cmpxchgl %2, "__percpu_arg(1)			\
+		asm qual ("cmpxchgl %2, "__percpu_arg(1)		\
 			    : "=a" (pco_ret__), "+m" (var)		\
 			    : "r" (pco_new__), "0" (pco_old__)		\
 			    : "memory");				\
 		break;							\
 	case 8:								\
-		asm("cmpxchgq %2, "__percpu_arg(1)			\
+		asm qual ("cmpxchgq %2, "__percpu_arg(1)		\
 			    : "=a" (pco_ret__), "+m" (var)		\
 			    : "r" (pco_new__), "0" (pco_old__)		\
 			    : "memory");				\
@@ -391,58 +391,58 @@ do {									\
  */
 #define this_cpu_read_stable(var)	percpu_stable_op("mov", var)
 
-#define raw_cpu_read_1(pcp)		percpu_from_op("mov", pcp)
-#define raw_cpu_read_2(pcp)		percpu_from_op("mov", pcp)
-#define raw_cpu_read_4(pcp)		percpu_from_op("mov", pcp)
-
-#define raw_cpu_write_1(pcp, val)	percpu_to_op("mov", (pcp), val)
-#define raw_cpu_write_2(pcp, val)	percpu_to_op("mov", (pcp), val)
-#define raw_cpu_write_4(pcp, val)	percpu_to_op("mov", (pcp), val)
-#define raw_cpu_add_1(pcp, val)		percpu_add_op((pcp), val)
-#define raw_cpu_add_2(pcp, val)		percpu_add_op((pcp), val)
-#define raw_cpu_add_4(pcp, val)		percpu_add_op((pcp), val)
-#define raw_cpu_and_1(pcp, val)		percpu_to_op("and", (pcp), val)
-#define raw_cpu_and_2(pcp, val)		percpu_to_op("and", (pcp), val)
-#define raw_cpu_and_4(pcp, val)		percpu_to_op("and", (pcp), val)
-#define raw_cpu_or_1(pcp, val)		percpu_to_op("or", (pcp), val)
-#define raw_cpu_or_2(pcp, val)		percpu_to_op("or", (pcp), val)
-#define raw_cpu_or_4(pcp, val)		percpu_to_op("or", (pcp), val)
-#define raw_cpu_xchg_1(pcp, val)	percpu_xchg_op(pcp, val)
-#define raw_cpu_xchg_2(pcp, val)	percpu_xchg_op(pcp, val)
-#define raw_cpu_xchg_4(pcp, val)	percpu_xchg_op(pcp, val)
-
-#define this_cpu_read_1(pcp)		percpu_from_op("mov", pcp)
-#define this_cpu_read_2(pcp)		percpu_from_op("mov", pcp)
-#define this_cpu_read_4(pcp)		percpu_from_op("mov", pcp)
-#define this_cpu_write_1(pcp, val)	percpu_to_op("mov", (pcp), val)
-#define this_cpu_write_2(pcp, val)	percpu_to_op("mov", (pcp), val)
-#define this_cpu_write_4(pcp, val)	percpu_to_op("mov", (pcp), val)
-#define this_cpu_add_1(pcp, val)	percpu_add_op((pcp), val)
-#define this_cpu_add_2(pcp, val)	percpu_add_op((pcp), val)
-#define this_cpu_add_4(pcp, val)	percpu_add_op((pcp), val)
-#define this_cpu_and_1(pcp, val)	percpu_to_op("and", (pcp), val)
-#define this_cpu_and_2(pcp, val)	percpu_to_op("and", (pcp), val)
-#define this_cpu_and_4(pcp, val)	percpu_to_op("and", (pcp), val)
-#define this_cpu_or_1(pcp, val)		percpu_to_op("or", (pcp), val)
-#define this_cpu_or_2(pcp, val)		percpu_to_op("or", (pcp), val)
-#define this_cpu_or_4(pcp, val)		percpu_to_op("or", (pcp), val)
-#define this_cpu_xchg_1(pcp, nval)	percpu_xchg_op(pcp, nval)
-#define this_cpu_xchg_2(pcp, nval)	percpu_xchg_op(pcp, nval)
-#define this_cpu_xchg_4(pcp, nval)	percpu_xchg_op(pcp, nval)
-
-#define raw_cpu_add_return_1(pcp, val)		percpu_add_return_op(pcp, val)
-#define raw_cpu_add_return_2(pcp, val)		percpu_add_return_op(pcp, val)
-#define raw_cpu_add_return_4(pcp, val)		percpu_add_return_op(pcp, val)
-#define raw_cpu_cmpxchg_1(pcp, oval, nval)	percpu_cmpxchg_op(pcp, oval, nval)
-#define raw_cpu_cmpxchg_2(pcp, oval, nval)	percpu_cmpxchg_op(pcp, oval, nval)
-#define raw_cpu_cmpxchg_4(pcp, oval, nval)	percpu_cmpxchg_op(pcp, oval, nval)
-
-#define this_cpu_add_return_1(pcp, val)		percpu_add_return_op(pcp, val)
-#define this_cpu_add_return_2(pcp, val)		percpu_add_return_op(pcp, val)
-#define this_cpu_add_return_4(pcp, val)		percpu_add_return_op(pcp, val)
-#define this_cpu_cmpxchg_1(pcp, oval, nval)	percpu_cmpxchg_op(pcp, oval, nval)
-#define this_cpu_cmpxchg_2(pcp, oval, nval)	percpu_cmpxchg_op(pcp, oval, nval)
-#define this_cpu_cmpxchg_4(pcp, oval, nval)	percpu_cmpxchg_op(pcp, oval, nval)
+#define raw_cpu_read_1(pcp)		percpu_from_op(, "mov", pcp)
+#define raw_cpu_read_2(pcp)		percpu_from_op(, "mov", pcp)
+#define raw_cpu_read_4(pcp)		percpu_from_op(, "mov", pcp)
+
+#define raw_cpu_write_1(pcp, val)	percpu_to_op(, "mov", (pcp), val)
+#define raw_cpu_write_2(pcp, val)	percpu_to_op(, "mov", (pcp), val)
+#define raw_cpu_write_4(pcp, val)	percpu_to_op(, "mov", (pcp), val)
+#define raw_cpu_add_1(pcp, val)		percpu_add_op(, (pcp), val)
+#define raw_cpu_add_2(pcp, val)		percpu_add_op(, (pcp), val)
+#define raw_cpu_add_4(pcp, val)		percpu_add_op(, (pcp), val)
+#define raw_cpu_and_1(pcp, val)		percpu_to_op(, "and", (pcp), val)
+#define raw_cpu_and_2(pcp, val)		percpu_to_op(, "and", (pcp), val)
+#define raw_cpu_and_4(pcp, val)		percpu_to_op(, "and", (pcp), val)
+#define raw_cpu_or_1(pcp, val)		percpu_to_op(, "or", (pcp), val)
+#define raw_cpu_or_2(pcp, val)		percpu_to_op(, "or", (pcp), val)
+#define raw_cpu_or_4(pcp, val)		percpu_to_op(, "or", (pcp), val)
+#define raw_cpu_xchg_1(pcp, val)	percpu_xchg_op(, pcp, val)
+#define raw_cpu_xchg_2(pcp, val)	percpu_xchg_op(, pcp, val)
+#define raw_cpu_xchg_4(pcp, val)	percpu_xchg_op(, pcp, val)
+
+#define this_cpu_read_1(pcp)		percpu_from_op(volatile, "mov", pcp)
+#define this_cpu_read_2(pcp)		percpu_from_op(volatile, "mov", pcp)
+#define this_cpu_read_4(pcp)		percpu_from_op(volatile, "mov", pcp)
+#define this_cpu_write_1(pcp, val)	percpu_to_op(volatile, "mov", (pcp), val)
+#define this_cpu_write_2(pcp, val)	percpu_to_op(volatile, "mov", (pcp), val)
+#define this_cpu_write_4(pcp, val)	percpu_to_op(volatile, "mov", (pcp), val)
+#define this_cpu_add_1(pcp, val)	percpu_add_op(volatile, (pcp), val)
+#define this_cpu_add_2(pcp, val)	percpu_add_op(volatile, (pcp), val)
+#define this_cpu_add_4(pcp, val)	percpu_add_op(volatile, (pcp), val)
+#define this_cpu_and_1(pcp, val)	percpu_to_op(volatile, "and", (pcp), val)
+#define this_cpu_and_2(pcp, val)	percpu_to_op(volatile, "and", (pcp), val)
+#define this_cpu_and_4(pcp, val)	percpu_to_op(volatile, "and", (pcp), val)
+#define this_cpu_or_1(pcp, val)		percpu_to_op(volatile, "or", (pcp), val)
+#define this_cpu_or_2(pcp, val)		percpu_to_op(volatile, "or", (pcp), val)
+#define this_cpu_or_4(pcp, val)		percpu_to_op(volatile, "or", (pcp), val)
+#define this_cpu_xchg_1(pcp, nval)	percpu_xchg_op(volatile, pcp, nval)
+#define this_cpu_xchg_2(pcp, nval)	percpu_xchg_op(volatile, pcp, nval)
+#define this_cpu_xchg_4(pcp, nval)	percpu_xchg_op(volatile, pcp, nval)
+
+#define raw_cpu_add_return_1(pcp, val)		percpu_add_return_op(, pcp, val)
+#define raw_cpu_add_return_2(pcp, val)		percpu_add_return_op(, pcp, val)
+#define raw_cpu_add_return_4(pcp, val)		percpu_add_return_op(, pcp, val)
+#define raw_cpu_cmpxchg_1(pcp, oval, nval)	percpu_cmpxchg_op(, pcp, oval, nval)
+#define raw_cpu_cmpxchg_2(pcp, oval, nval)	percpu_cmpxchg_op(, pcp, oval, nval)
+#define raw_cpu_cmpxchg_4(pcp, oval, nval)	percpu_cmpxchg_op(, pcp, oval, nval)
+
+#define this_cpu_add_return_1(pcp, val)		percpu_add_return_op(volatile, pcp, val)
+#define this_cpu_add_return_2(pcp, val)		percpu_add_return_op(volatile, pcp, val)
+#define this_cpu_add_return_4(pcp, val)		percpu_add_return_op(volatile, pcp, val)
+#define this_cpu_cmpxchg_1(pcp, oval, nval)	percpu_cmpxchg_op(volatile, pcp, oval, nval)
+#define this_cpu_cmpxchg_2(pcp, oval, nval)	percpu_cmpxchg_op(volatile, pcp, oval, nval)
+#define this_cpu_cmpxchg_4(pcp, oval, nval)	percpu_cmpxchg_op(volatile, pcp, oval, nval)
 
 #ifdef CONFIG_X86_CMPXCHG64
 #define percpu_cmpxchg8b_double(pcp1, pcp2, o1, o2, n1, n2)		\
@@ -466,23 +466,23 @@ do {									\
  * 32 bit must fall back to generic operations.
  */
 #ifdef CONFIG_X86_64
-#define raw_cpu_read_8(pcp)			percpu_from_op("mov", pcp)
-#define raw_cpu_write_8(pcp, val)		percpu_to_op("mov", (pcp), val)
-#define raw_cpu_add_8(pcp, val)			percpu_add_op((pcp), val)
-#define raw_cpu_and_8(pcp, val)			percpu_to_op("and", (pcp), val)
-#define raw_cpu_or_8(pcp, val)			percpu_to_op("or", (pcp), val)
-#define raw_cpu_add_return_8(pcp, val)		percpu_add_return_op(pcp, val)
-#define raw_cpu_xchg_8(pcp, nval)		percpu_xchg_op(pcp, nval)
-#define raw_cpu_cmpxchg_8(pcp, oval, nval)	percpu_cmpxchg_op(pcp, oval, nval)
-
-#define this_cpu_read_8(pcp)			percpu_from_op("mov", pcp)
-#define this_cpu_write_8(pcp, val)		percpu_to_op("mov", (pcp), val)
-#define this_cpu_add_8(pcp, val)		percpu_add_op((pcp), val)
-#define this_cpu_and_8(pcp, val)		percpu_to_op("and", (pcp), val)
-#define this_cpu_or_8(pcp, val)			percpu_to_op("or", (pcp), val)
-#define this_cpu_add_return_8(pcp, val)		percpu_add_return_op(pcp, val)
-#define this_cpu_xchg_8(pcp, nval)		percpu_xchg_op(pcp, nval)
-#define this_cpu_cmpxchg_8(pcp, oval, nval)	percpu_cmpxchg_op(pcp, oval, nval)
+#define raw_cpu_read_8(pcp)			percpu_from_op(, "mov", pcp)
+#define raw_cpu_write_8(pcp, val)		percpu_to_op(, "mov", (pcp), val)
+#define raw_cpu_add_8(pcp, val)			percpu_add_op(, (pcp), val)
+#define raw_cpu_and_8(pcp, val)			percpu_to_op(, "and", (pcp), val)
+#define raw_cpu_or_8(pcp, val)			percpu_to_op(, "or", (pcp), val)
+#define raw_cpu_add_return_8(pcp, val)		percpu_add_return_op(, pcp, val)
+#define raw_cpu_xchg_8(pcp, nval)		percpu_xchg_op(, pcp, nval)
+#define raw_cpu_cmpxchg_8(pcp, oval, nval)	percpu_cmpxchg_op(, pcp, oval, nval)
+
+#define this_cpu_read_8(pcp)			percpu_from_op(volatile, "mov", pcp)
+#define this_cpu_write_8(pcp, val)		percpu_to_op(volatile, "mov", (pcp), val)
+#define this_cpu_add_8(pcp, val)		percpu_add_op(volatile, (pcp), val)
+#define this_cpu_and_8(pcp, val)		percpu_to_op(volatile, "and", (pcp), val)
+#define this_cpu_or_8(pcp, val)			percpu_to_op(volatile, "or", (pcp), val)
+#define this_cpu_add_return_8(pcp, val)		percpu_add_return_op(volatile, pcp, val)
+#define this_cpu_xchg_8(pcp, nval)		percpu_xchg_op(volatile, pcp, nval)
+#define this_cpu_cmpxchg_8(pcp, oval, nval)	percpu_cmpxchg_op(volatile, pcp, oval, nval)
 
 /*
  * Pretty complex macro to generate cmpxchg16 instruction.  The instruction


