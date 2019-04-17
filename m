Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25D6AC282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 14:14:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E83E320872
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 14:14:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="FVUKRdrt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732481AbfDQOOt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 10:14:49 -0400
Received: from terminus.zytor.com ([198.137.202.136]:36065 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731743AbfDQOOt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 10:14:49 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x3HEDrDc3934469
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 17 Apr 2019 07:13:53 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x3HEDrDc3934469
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019041743; t=1555510434;
        bh=xcMjG4ch+qGqAKvVK2Lmu5pklpHo4xPwXmLQdQ9DoEE=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=FVUKRdrt/GG63WBLBEmnQbaFusVd7iVfSCmuc61zCFIbuX8vuUgFw9GDAFmvcAgpa
         aWWWd1Tj5Zo08DDu2VWej0fn9n3h4b6ULmDkKFPjHXTeMiNphQs/UkidamjZ3Ki0jy
         sMI2nnyZY6ck2CFwtA8M6XmMl91Xtw8414E/5K1MhMk5AyPe6gqRSlfy887KC6yA/G
         m+BbR/BAumDj1gl+s+AMbDxVKiE20k3PfATd0dDlQ1KoE17YE+iEIRD2qurV84m6jz
         7UNxJyQpWCi1PV831fuSllV8sLbejPDjVvkTNF9R9o57OZuupF8boxenAtfzgHonP0
         xBZsyAPMNYPPA==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x3HEDpgf3934458;
        Wed, 17 Apr 2019 07:13:51 -0700
Date:   Wed, 17 Apr 2019 07:13:51 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Thomas Gleixner <tipbot@zytor.com>
Message-ID: <tip-4d68c3d0ecd5fcba8876e8a58ac41ffb360de43e@git.kernel.org>
Cc:     hpa@zytor.com, jpoimboe@redhat.com, x86@kernel.org,
        chang.seok.bae@intel.com, bp@suse.de, konrad.wilk@oracle.com,
        tglx@linutronix.de, mingo@kernel.org, jgross@suse.com,
        kernelfans@gmail.com, luto@kernel.org, ndesaulniers@google.com,
        peterz@infradead.org, sean.j.christopherson@intel.com,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        vbabka@suse.cz, puwen@hygon.cn, jkosina@suse.cz, mingo@redhat.com,
        linux@dominikbrodowski.net, dave.hansen@linux.intel.com
Reply-To: peterz@infradead.org, sean.j.christopherson@intel.com,
          akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
          ndesaulniers@google.com, kernelfans@gmail.com, luto@kernel.org,
          mingo@kernel.org, tglx@linutronix.de, jgross@suse.com,
          hpa@zytor.com, bp@suse.de, konrad.wilk@oracle.com,
          jpoimboe@redhat.com, chang.seok.bae@intel.com, x86@kernel.org,
          dave.hansen@linux.intel.com, linux@dominikbrodowski.net,
          mingo@redhat.com, vbabka@suse.cz, jkosina@suse.cz, puwen@hygon.cn
In-Reply-To: <20190414160145.151435667@linutronix.de>
References: <20190414160145.151435667@linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/irq] x86/cpu: Remove orig_ist array
Git-Commit-ID: 4d68c3d0ecd5fcba8876e8a58ac41ffb360de43e
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

Commit-ID:  4d68c3d0ecd5fcba8876e8a58ac41ffb360de43e
Gitweb:     https://git.kernel.org/tip/4d68c3d0ecd5fcba8876e8a58ac41ffb360de43e
Author:     Thomas Gleixner <tglx@linutronix.de>
AuthorDate: Sun, 14 Apr 2019 17:59:54 +0200
Committer:  Borislav Petkov <bp@suse.de>
CommitDate: Wed, 17 Apr 2019 14:44:17 +0200

x86/cpu: Remove orig_ist array

All users gone.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: "Chang S. Bae" <chang.seok.bae@intel.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Jiri Kosina <jkosina@suse.cz>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: Nick Desaulniers <ndesaulniers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Pingfan Liu <kernelfans@gmail.com>
Cc: Pu Wen <puwen@hygon.cn>
Cc: Sean Christopherson <sean.j.christopherson@intel.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: x86-ml <x86@kernel.org>
Link: https://lkml.kernel.org/r/20190414160145.151435667@linutronix.de
---
 arch/x86/include/asm/processor.h | 9 ---------
 arch/x86/kernel/cpu/common.c     | 6 ------
 2 files changed, 15 deletions(-)

diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index 2bb3a648fc12..8fcfcd1a8375 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -374,16 +374,7 @@ DECLARE_PER_CPU(unsigned long, cpu_current_top_of_stack);
 #define cpu_current_top_of_stack cpu_tss_rw.x86_tss.sp1
 #endif
 
-/*
- * Save the original ist values for checking stack pointers during debugging
- */
-struct orig_ist {
-	unsigned long		ist[7];
-};
-
 #ifdef CONFIG_X86_64
-DECLARE_PER_CPU(struct orig_ist, orig_ist);
-
 union irq_stack_union {
 	char irq_stack[IRQ_STACK_SIZE];
 	/*
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 4b01b71415f5..8243f198fb7f 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1549,12 +1549,6 @@ void syscall_init(void)
 	       X86_EFLAGS_IOPL|X86_EFLAGS_AC|X86_EFLAGS_NT);
 }
 
-/*
- * Copies of the original ist values from the tss are only accessed during
- * debugging, no special alignment required.
- */
-DEFINE_PER_CPU(struct orig_ist, orig_ist);
-
 static DEFINE_PER_CPU(unsigned long, debug_stack_addr);
 DEFINE_PER_CPU(int, debug_stack_usage);
 
