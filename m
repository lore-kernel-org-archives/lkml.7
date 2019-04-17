Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C4D5C282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 14:03:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A4B4206BA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 14:03:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="WrICk2Zq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732419AbfDQODX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 10:03:23 -0400
Received: from terminus.zytor.com ([198.137.202.136]:42365 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731743AbfDQODW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 10:03:22 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x3HE3Bvs3931112
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 17 Apr 2019 07:03:12 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x3HE3Bvs3931112
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019041743; t=1555509792;
        bh=qhblEbnXM58FzQB3P4Rtso3pep86xk31efIXXFvdWFM=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=WrICk2Zq+w3qWwWkoC1UZUZxkKgNvKZPQ65KsXQ/S0Tjj3erbmoUan74ViZpNUUV3
         +H7cUl8u3KMSm7effqcpxp/asireFlWr3sgx4vWAAdUbEBOvP1LJ29NZ1cqL2+2dmV
         RQ/to8YkvJfJfq1II08hC7jL0DkJFDIYJNREq4Axuu58/JxVFITyZ1JkxQGQ/mBY0I
         GRjcc+1Ca6Ml32hyjris9cppIpIqG4TUdZGGpD7ps38pZHNbGly9qcpXyMPfnMaF28
         XPazEo22wT/XfFGJt8Gzt9pStVJFvN9WqOZoOzR1ts0pWBqj934g9Tfkp8n0RM+Odf
         dKGclUcAQ1yOA==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x3HE3BvT3931108;
        Wed, 17 Apr 2019 07:03:11 -0700
Date:   Wed, 17 Apr 2019 07:03:11 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Andy Lutomirski <tipbot@zytor.com>
Message-ID: <tip-fa33215422fd415a07ec2a00e9f1acdaf0fa8e94@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org,
        sean.j.christopherson@intel.com, tglx@linutronix.de,
        x86@kernel.org, luto@kernel.org, jpoimboe@redhat.com, bp@suse.de,
        mingo@redhat.com, hpa@zytor.com
Reply-To: tglx@linutronix.de, hpa@zytor.com, mingo@redhat.com, bp@suse.de,
          luto@kernel.org, jpoimboe@redhat.com, x86@kernel.org,
          mingo@kernel.org, linux-kernel@vger.kernel.org,
          sean.j.christopherson@intel.com
In-Reply-To: <20190414160143.785651055@linutronix.de>
References: <20190414160143.785651055@linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/irq] x86/dumpstack: Fix off-by-one errors in stack
 identification
Git-Commit-ID: fa33215422fd415a07ec2a00e9f1acdaf0fa8e94
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

Commit-ID:  fa33215422fd415a07ec2a00e9f1acdaf0fa8e94
Gitweb:     https://git.kernel.org/tip/fa33215422fd415a07ec2a00e9f1acdaf0fa8e94
Author:     Andy Lutomirski <luto@kernel.org>
AuthorDate: Sun, 14 Apr 2019 17:59:39 +0200
Committer:  Borislav Petkov <bp@suse.de>
CommitDate: Wed, 17 Apr 2019 12:26:50 +0200

x86/dumpstack: Fix off-by-one errors in stack identification

The get_stack_info() function is off-by-one when checking whether an
address is on a IRQ stack or a IST stack. This prevents an overflowed
IRQ or IST stack from being dumped properly.

[ tglx: Do the same for 32-bit ]

Signed-off-by: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Sean Christopherson <sean.j.christopherson@intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: x86-ml <x86@kernel.org>
Link: https://lkml.kernel.org/r/20190414160143.785651055@linutronix.de
---
 arch/x86/kernel/dumpstack_32.c | 4 ++--
 arch/x86/kernel/dumpstack_64.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/dumpstack_32.c b/arch/x86/kernel/dumpstack_32.c
index cd53f3030e40..d305440ebe9c 100644
--- a/arch/x86/kernel/dumpstack_32.c
+++ b/arch/x86/kernel/dumpstack_32.c
@@ -41,7 +41,7 @@ static bool in_hardirq_stack(unsigned long *stack, struct stack_info *info)
 	 * This is a software stack, so 'end' can be a valid stack pointer.
 	 * It just means the stack is empty.
 	 */
-	if (stack <= begin || stack > end)
+	if (stack < begin || stack > end)
 		return false;
 
 	info->type	= STACK_TYPE_IRQ;
@@ -66,7 +66,7 @@ static bool in_softirq_stack(unsigned long *stack, struct stack_info *info)
 	 * This is a software stack, so 'end' can be a valid stack pointer.
 	 * It just means the stack is empty.
 	 */
-	if (stack <= begin || stack > end)
+	if (stack < begin || stack > end)
 		return false;
 
 	info->type	= STACK_TYPE_SOFTIRQ;
diff --git a/arch/x86/kernel/dumpstack_64.c b/arch/x86/kernel/dumpstack_64.c
index 5cdb9e84da57..90f0fa88cbb3 100644
--- a/arch/x86/kernel/dumpstack_64.c
+++ b/arch/x86/kernel/dumpstack_64.c
@@ -65,7 +65,7 @@ static bool in_exception_stack(unsigned long *stack, struct stack_info *info)
 		begin = end - (exception_stack_sizes[k] / sizeof(long));
 		regs  = (struct pt_regs *)end - 1;
 
-		if (stack <= begin || stack >= end)
+		if (stack < begin || stack >= end)
 			continue;
 
 		info->type	= STACK_TYPE_EXCEPTION + k;
@@ -88,7 +88,7 @@ static bool in_irq_stack(unsigned long *stack, struct stack_info *info)
 	 * This is a software stack, so 'end' can be a valid stack pointer.
 	 * It just means the stack is empty.
 	 */
-	if (stack <= begin || stack > end)
+	if (stack < begin || stack >= end)
 		return false;
 
 	info->type	= STACK_TYPE_IRQ;
