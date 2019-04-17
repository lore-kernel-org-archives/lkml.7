Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAB53C282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 14:17:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B0052177B
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 14:17:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="f4IblylY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732616AbfDQORq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 10:17:46 -0400
Received: from terminus.zytor.com ([198.137.202.136]:58991 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728335AbfDQORp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 10:17:45 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x3HEHJQ43935111
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 17 Apr 2019 07:17:19 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x3HEHJQ43935111
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019041743; t=1555510640;
        bh=FEcaeuwX1Xdz+Gj6TlnPpZ7hGM0EWtZNkBw11zdPMKY=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=f4IblylYwJTcdV01Lduc+WVtqh0ynYWahixMECqSfrfvBzVSMC2/RfC4raziAFkFC
         A8ipF8Lx4l3HssmBghPlS9x5NEYsADpFfV1ktCD/BiKROB/3Hxb+NtOyvlg8tBE60h
         a32hK1b7dcvOq3pexdwxe+ilGd4POsVT9MaRTZXmE934KewAwFT4PGXTmDJy3zYPHe
         Lx2Mpi36ucDufnKgQ+mkUJ+hu8ITFqX4Bm0LmYogxB6NE56fDKG5lC1/8BZmR5Mv86
         flBZdZu/GbqWLjoh6rwfgDFf1VC7Ge+0loufiEKxiyu06zTl0zRseUxMN+8a516bZQ
         ldZ0z0aw3VG2w==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x3HEHJdV3935108;
        Wed, 17 Apr 2019 07:17:19 -0700
Date:   Wed, 17 Apr 2019 07:17:19 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Thomas Gleixner <tipbot@zytor.com>
Message-ID: <tip-aa641c287b2f7676f6f0064a8351daf08eca6b0a@git.kernel.org>
Cc:     mingo@redhat.com, akpm@linux-foundation.org, bp@suse.de,
        tglx@linutronix.de, mingo@kernel.org, mhocko@suse.com,
        jpoimboe@redhat.com, vbabka@suse.cz, luto@kernel.org,
        sean.j.christopherson@intel.com, dave.hansen@intel.com,
        x86@kernel.org, hpa@zytor.com, jkosina@suse.cz,
        linux-kernel@vger.kernel.org, suravee.suthikulpanit@amd.com,
        ndesaulniers@google.com, jgross@suse.com
Reply-To: luto@kernel.org, sean.j.christopherson@intel.com, vbabka@suse.cz,
          jgross@suse.com, ndesaulniers@google.com,
          linux-kernel@vger.kernel.org, suravee.suthikulpanit@amd.com,
          dave.hansen@intel.com, x86@kernel.org, jkosina@suse.cz,
          hpa@zytor.com, bp@suse.de, tglx@linutronix.de, mingo@redhat.com,
          akpm@linux-foundation.org, jpoimboe@redhat.com, mingo@kernel.org,
          mhocko@suse.com
In-Reply-To: <20190414160145.632513987@linutronix.de>
References: <20190414160145.632513987@linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/irq] x86/irq/32: Define IRQ_STACK_SIZE
Git-Commit-ID: aa641c287b2f7676f6f0064a8351daf08eca6b0a
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

Commit-ID:  aa641c287b2f7676f6f0064a8351daf08eca6b0a
Gitweb:     https://git.kernel.org/tip/aa641c287b2f7676f6f0064a8351daf08eca6b0a
Author:     Thomas Gleixner <tglx@linutronix.de>
AuthorDate: Sun, 14 Apr 2019 17:59:59 +0200
Committer:  Borislav Petkov <bp@suse.de>
CommitDate: Wed, 17 Apr 2019 15:18:36 +0200

x86/irq/32: Define IRQ_STACK_SIZE

On 32-bit IRQ_STACK_SIZE is the same as THREAD_SIZE.

To allow sharing struct irq_stack with 32-bit, define IRQ_STACK_SIZE for
32-bit and use it for struct irq_stack.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Jiri Kosina <jkosina@suse.cz>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Nick Desaulniers <ndesaulniers@google.com>
Cc: Sean Christopherson <sean.j.christopherson@intel.com>
Cc: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: x86-ml <x86@kernel.org>
Link: https://lkml.kernel.org/r/20190414160145.632513987@linutronix.de
---
 arch/x86/include/asm/page_32_types.h | 2 ++
 arch/x86/include/asm/processor.h     | 4 ++--
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/page_32_types.h b/arch/x86/include/asm/page_32_types.h
index 57b5dc15ca7e..565ad755c785 100644
--- a/arch/x86/include/asm/page_32_types.h
+++ b/arch/x86/include/asm/page_32_types.h
@@ -22,6 +22,8 @@
 #define THREAD_SIZE_ORDER	1
 #define THREAD_SIZE		(PAGE_SIZE << THREAD_SIZE_ORDER)
 
+#define IRQ_STACK_SIZE		THREAD_SIZE
+
 #define N_EXCEPTION_STACKS	1
 
 #ifdef CONFIG_X86_PAE
diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index 8fcfcd1a8375..8b4bf732e1b5 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -422,8 +422,8 @@ DECLARE_PER_CPU_ALIGNED(struct stack_canary, stack_canary);
  * per-CPU IRQ handling stacks
  */
 struct irq_stack {
-	u32                     stack[THREAD_SIZE/sizeof(u32)];
-} __aligned(THREAD_SIZE);
+	u32			stack[IRQ_STACK_SIZE / sizeof(u32)];
+} __aligned(IRQ_STACK_SIZE);
 
 DECLARE_PER_CPU(struct irq_stack *, hardirq_stack);
 DECLARE_PER_CPU(struct irq_stack *, softirq_stack);
