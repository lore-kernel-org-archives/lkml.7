Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E2D8C7618B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 13:50:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0815D22CE5
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 13:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564149029;
	bh=kg9ORp9aZK6vwWWjv/ZJX2FXW9kBst9/U2Ly7bWVi7A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=XfGyI2N9dqz389tOrbAlb7QcCPw8gDbrYoZV+egblbsGzBlWJLI/a4IrjCRkG3c9S
	 fQ0Nf8fu3DteeQ1Q9P6Udy+/HO8au7iGFAliXEP8jkRocXT9KCRPTYffSEzUuAkNIy
	 kLrUd65BNZYK1eudiXct3nMvhCrGVTlf2IbDEjMU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388840AbfGZNuY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 09:50:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:52714 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388340AbfGZNo2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 09:44:28 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B19D022CD0;
        Fri, 26 Jul 2019 13:44:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564148667;
        bh=kg9ORp9aZK6vwWWjv/ZJX2FXW9kBst9/U2Ly7bWVi7A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=psxWUZS2oJJ+QMuhyQTZNCXHfabyUNrjqQ2TvHaChKOq9EFwHA/qqozgxVeua8C7s
         99AntLdyJhfvQaVoAYNfw+keZ5p+wQ05knuZtgPuQqYvF9puqqMqzm2eRIsnnmxZk6
         cKoQ4tULGityAFWb9EXURyIyfHGS96AbW8B4vBek=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Juergen Gross <jgross@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Sasha Levin <sashal@kernel.org>,
        virtualization@lists.linux-foundation.org, kvm@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 35/37] x86/paravirt: Fix callee-saved function ELF sizes
Date:   Fri, 26 Jul 2019 09:43:30 -0400
Message-Id: <20190726134332.12626-35-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190726134332.12626-1-sashal@kernel.org>
References: <20190726134332.12626-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Josh Poimboeuf <jpoimboe@redhat.com>

[ Upstream commit 083db6764821996526970e42d09c1ab2f4155dd4 ]

The __raw_callee_save_*() functions have an ELF symbol size of zero,
which confuses objtool and other tools.

Fixes a bunch of warnings like the following:

  arch/x86/xen/mmu_pv.o: warning: objtool: __raw_callee_save_xen_pte_val() is missing an ELF size annotation
  arch/x86/xen/mmu_pv.o: warning: objtool: __raw_callee_save_xen_pgd_val() is missing an ELF size annotation
  arch/x86/xen/mmu_pv.o: warning: objtool: __raw_callee_save_xen_make_pte() is missing an ELF size annotation
  arch/x86/xen/mmu_pv.o: warning: objtool: __raw_callee_save_xen_make_pgd() is missing an ELF size annotation

Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Juergen Gross <jgross@suse.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/afa6d49bb07497ca62e4fc3b27a2d0cece545b4e.1563413318.git.jpoimboe@redhat.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/include/asm/paravirt.h | 1 +
 arch/x86/kernel/kvm.c           | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/x86/include/asm/paravirt.h b/arch/x86/include/asm/paravirt.h
index c83a2f418cea..4471f0da6ed7 100644
--- a/arch/x86/include/asm/paravirt.h
+++ b/arch/x86/include/asm/paravirt.h
@@ -758,6 +758,7 @@ static __always_inline bool pv_vcpu_is_preempted(long cpu)
 	    PV_RESTORE_ALL_CALLER_REGS					\
 	    FRAME_END							\
 	    "ret;"							\
+	    ".size " PV_THUNK_NAME(func) ", .-" PV_THUNK_NAME(func) ";"	\
 	    ".popsection")
 
 /* Get a reference to a callee-save function */
diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
index 652bdd867782..5853eb50138e 100644
--- a/arch/x86/kernel/kvm.c
+++ b/arch/x86/kernel/kvm.c
@@ -631,6 +631,7 @@ asm(
 "cmpb	$0, " __stringify(KVM_STEAL_TIME_preempted) "+steal_time(%rax);"
 "setne	%al;"
 "ret;"
+".size __raw_callee_save___kvm_vcpu_is_preempted, .-__raw_callee_save___kvm_vcpu_is_preempted;"
 ".popsection");
 
 #endif
-- 
2.20.1

