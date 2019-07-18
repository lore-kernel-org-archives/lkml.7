Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B632C7618F
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 19:07:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D457721019
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 19:07:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="QqhaGhOS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391129AbfGRTHo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 15:07:44 -0400
Received: from terminus.zytor.com ([198.137.202.136]:58711 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727685AbfGRTHo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 15:07:44 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6IJ7L2K2123545
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 18 Jul 2019 12:07:22 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6IJ7L2K2123545
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1563476842;
        bh=3Q/67xmSF60QreiyFoMQf4x91Gql9kff1+3IAqL53Fc=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=QqhaGhOSLNrAOJ1bxwt0cxdD+E130w7wLiSS7oXO6Hxo8M7cV+pDFP7VSiu2luMPV
         m7OjvapHI4WaOLOU4FjrE8f6H2r4QwXSf2Hcch4JP1BFciDHm0CluJliA6+xc+i3O0
         AuMeatmSk/fHZKyxG3nFhVatGR8SjMCPs86ONQBA0aHeZVa2hLrSLv+lT2fJ6H3o4H
         P+r6v1rnTx8hYFPRD6z7d1p3KQGQBu8yEYPJS9qVmkSq049Gn7jgqYO7jv8Ub+LCMD
         ct3BJbUO6bgdoOsRYyIRgxFsX+8PseoWONk75k1YZgAEbSGoj6HFoUuZ4qBTViEFPC
         xGB3TpzZA+2IA==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6IJ7LGh2123541;
        Thu, 18 Jul 2019 12:07:21 -0700
Date:   Thu, 18 Jul 2019 12:07:21 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Josh Poimboeuf <tipbot@zytor.com>
Message-ID: <tip-083db6764821996526970e42d09c1ab2f4155dd4@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org, jgross@suse.com,
        jpoimboe@redhat.com, tglx@linutronix.de, hpa@zytor.com,
        peterz@infradead.org
Reply-To: peterz@infradead.org, hpa@zytor.com, tglx@linutronix.de,
          jpoimboe@redhat.com, jgross@suse.com,
          linux-kernel@vger.kernel.org, mingo@kernel.org
In-Reply-To: <afa6d49bb07497ca62e4fc3b27a2d0cece545b4e.1563413318.git.jpoimboe@redhat.com>
References: <afa6d49bb07497ca62e4fc3b27a2d0cece545b4e.1563413318.git.jpoimboe@redhat.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:core/urgent] x86/paravirt: Fix callee-saved function ELF sizes
Git-Commit-ID: 083db6764821996526970e42d09c1ab2f4155dd4
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  083db6764821996526970e42d09c1ab2f4155dd4
Gitweb:     https://git.kernel.org/tip/083db6764821996526970e42d09c1ab2f4155dd4
Author:     Josh Poimboeuf <jpoimboe@redhat.com>
AuthorDate: Wed, 17 Jul 2019 20:36:36 -0500
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Thu, 18 Jul 2019 21:01:03 +0200

x86/paravirt: Fix callee-saved function ELF sizes

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
