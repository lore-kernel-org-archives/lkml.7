Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE784C742D2
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 00:37:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2F9721734
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 00:37:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728985AbfGOAh3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Jul 2019 20:37:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35650 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726936AbfGOAh1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Jul 2019 20:37:27 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8793AC057EC6;
        Mon, 15 Jul 2019 00:37:27 +0000 (UTC)
Received: from treble.redhat.com (ovpn-120-170.rdu2.redhat.com [10.10.120.170])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3BFC45D9D2;
        Mon, 15 Jul 2019 00:37:26 +0000 (UTC)
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Arnd Bergmann <arnd@arndb.de>, Jann Horn <jannh@google.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Juergen Gross <jgross@suse.com>,
        Alok Kataria <akataria@vmware.com>
Subject: [PATCH 01/22] x86/paravirt: Fix callee-saved function ELF sizes
Date:   Sun, 14 Jul 2019 19:36:56 -0500
Message-Id: <b116e8bf2d3a4f703020e7911b6226ecc3ea34c5.1563150885.git.jpoimboe@redhat.com>
In-Reply-To: <cover.1563150885.git.jpoimboe@redhat.com>
References: <cover.1563150885.git.jpoimboe@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Mon, 15 Jul 2019 00:37:27 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The __raw_callee_save_*() functions have an ELF symbol size of zero,
which confuses objtool and other tools.

Fixes a bunch of warnings like the following:

  arch/x86/xen/mmu_pv.o: warning: objtool: __raw_callee_save_xen_pte_val() is missing an ELF size annotation
  arch/x86/xen/mmu_pv.o: warning: objtool: __raw_callee_save_xen_pgd_val() is missing an ELF size annotation
  arch/x86/xen/mmu_pv.o: warning: objtool: __raw_callee_save_xen_make_pte() is missing an ELF size annotation
  arch/x86/xen/mmu_pv.o: warning: objtool: __raw_callee_save_xen_make_pgd() is missing an ELF size annotation

Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
Cc: Juergen Gross <jgross@suse.com>
Cc: Alok Kataria <akataria@vmware.com>
---
 arch/x86/include/asm/paravirt.h | 1 +
 arch/x86/kernel/kvm.c           | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/x86/include/asm/paravirt.h b/arch/x86/include/asm/paravirt.h
index c25c38a05c1c..d6f5ae2c79ab 100644
--- a/arch/x86/include/asm/paravirt.h
+++ b/arch/x86/include/asm/paravirt.h
@@ -746,6 +746,7 @@ bool __raw_callee_save___native_vcpu_is_preempted(long cpu);
 	    PV_RESTORE_ALL_CALLER_REGS					\
 	    FRAME_END							\
 	    "ret;"							\
+	    ".size " PV_THUNK_NAME(func) ", .-" PV_THUNK_NAME(func) ";"	\
 	    ".popsection")
 
 /* Get a reference to a callee-save function */
diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
index 82caf01b63dd..6661bd2f08a6 100644
--- a/arch/x86/kernel/kvm.c
+++ b/arch/x86/kernel/kvm.c
@@ -838,6 +838,7 @@ asm(
 "cmpb	$0, " __stringify(KVM_STEAL_TIME_preempted) "+steal_time(%rax);"
 "setne	%al;"
 "ret;"
+".size __raw_callee_save___kvm_vcpu_is_preempted, .-__raw_callee_save___kvm_vcpu_is_preempted;"
 ".popsection");
 
 #endif
-- 
2.20.1

