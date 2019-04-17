Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E6E0C282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 14:18:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 181942177B
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 14:18:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="iHiniwd7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732479AbfDQOSf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 10:18:35 -0400
Received: from terminus.zytor.com ([198.137.202.136]:47191 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732267AbfDQOSf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 10:18:35 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x3HEI00Y3935191
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 17 Apr 2019 07:18:01 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x3HEI00Y3935191
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019041743; t=1555510681;
        bh=VpgvxgEmYDZOYhbm9j4l6lCn1vOLGAmgB4fpDqx+uf0=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=iHiniwd7PLhkqqH9BD6HY4i/TVTiiv6XISxw80ilgs1ZC/bMoLQCCbySeXC3M+kYC
         +on2tV/UGikb/VlvUfsIJ8vDFnqX6kleVS3QZu7/t95b0qOAi2GYuDwno6XiJDfUzc
         qAUNh+/9fvbuaM436Optkw0GCOTYldxXkho2APuzToNG2p2CjU0+AogCki2ask4PMg
         6O01I/5ToqmmSfB210QCNbIEKBILOmDwPHfX0QyvCMBlGAzpMA65s2lY7pJd0OkjHX
         VAn5+oiAcdtga3IDdQ8Yyoa7txD+sT3l8OZ0QhBBkEa24S0tSyGYFg19oaLNQIHmxv
         DEfN5BK7IRDjg==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x3HEI0Lq3935188;
        Wed, 17 Apr 2019 07:18:00 -0700
Date:   Wed, 17 Apr 2019 07:18:00 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Thomas Gleixner <tipbot@zytor.com>
Message-ID: <tip-231c4846b106d526fa212b02b37447d3f2fcc99d@git.kernel.org>
Cc:     tglx@linutronix.de, akpm@linux-foundation.org, luto@kernel.org,
        bp@suse.de, hpa@zytor.com, puwen@hygon.cn, mingo@redhat.com,
        x86@kernel.org, mingo@kernel.org, jkosina@suse.cz,
        ndesaulniers@google.com, linux-kernel@vger.kernel.org,
        vbabka@suse.cz, kernelfans@gmail.com, jpoimboe@redhat.com,
        sean.j.christopherson@intel.com, adobriyan@gmail.com
Reply-To: tglx@linutronix.de, akpm@linux-foundation.org, luto@kernel.org,
          bp@suse.de, hpa@zytor.com, puwen@hygon.cn, mingo@redhat.com,
          x86@kernel.org, mingo@kernel.org, jkosina@suse.cz,
          ndesaulniers@google.com, linux-kernel@vger.kernel.org,
          vbabka@suse.cz, kernelfans@gmail.com, jpoimboe@redhat.com,
          sean.j.christopherson@intel.com, adobriyan@gmail.com
In-Reply-To: <20190414160145.736241969@linutronix.de>
References: <20190414160145.736241969@linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/irq] x86/irq/32: Make irq stack a character array
Git-Commit-ID: 231c4846b106d526fa212b02b37447d3f2fcc99d
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

Commit-ID:  231c4846b106d526fa212b02b37447d3f2fcc99d
Gitweb:     https://git.kernel.org/tip/231c4846b106d526fa212b02b37447d3f2fcc99d
Author:     Thomas Gleixner <tglx@linutronix.de>
AuthorDate: Sun, 14 Apr 2019 18:00:00 +0200
Committer:  Borislav Petkov <bp@suse.de>
CommitDate: Wed, 17 Apr 2019 15:21:21 +0200

x86/irq/32: Make irq stack a character array

There is no reason to have an u32 array in struct irq_stack. The only
purpose of the array is to size the struct properly.

Preparatory change for sharing struct irq_stack with 64-bit.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: Alexey Dobriyan <adobriyan@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Jiri Kosina <jkosina@suse.cz>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Nick Desaulniers <ndesaulniers@google.com>
Cc: Pingfan Liu <kernelfans@gmail.com>
Cc: Pu Wen <puwen@hygon.cn>
Cc: Sean Christopherson <sean.j.christopherson@intel.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: x86-ml <x86@kernel.org>
Link: https://lkml.kernel.org/r/20190414160145.736241969@linutronix.de
---
 arch/x86/include/asm/processor.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index 8b4bf732e1b5..ff3f469ab2d4 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -422,7 +422,7 @@ DECLARE_PER_CPU_ALIGNED(struct stack_canary, stack_canary);
  * per-CPU IRQ handling stacks
  */
 struct irq_stack {
-	u32			stack[IRQ_STACK_SIZE / sizeof(u32)];
+	char			stack[IRQ_STACK_SIZE];
 } __aligned(IRQ_STACK_SIZE);
 
 DECLARE_PER_CPU(struct irq_stack *, hardirq_stack);
