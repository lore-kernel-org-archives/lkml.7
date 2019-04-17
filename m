Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D427C282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 14:04:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED906206BA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 14:04:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="TKV9m/Sx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732430AbfDQOER (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 10:04:17 -0400
Received: from terminus.zytor.com ([198.137.202.136]:54279 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732345AbfDQOEN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 10:04:13 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x3HE3uiH3931196
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 17 Apr 2019 07:03:57 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x3HE3uiH3931196
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019041743; t=1555509837;
        bh=yMnPVkwanANeIgT8h/MHU9D6dfIOyBa3JV3gQ+IHd4c=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=TKV9m/Sx2DlYyMwfx8ukkQSsY4e8Eaoaud7sP3t5uIPi6Yrxw1jEEO5GmP50S9moJ
         psowCW4kKeMf5mzy0C2OWw0ANBaICrRHgaqyOgXgz4mdOhm+qjcFYsD6neW0w+FgF/
         tpxoP1UZ4fATXlgl6QqHlFIt6fvJZpy9moZD6AzuzDH8J4jzLtCozWLWOK3mrideiX
         cSkc2MMJZn8bcYcq6g2DrKR1n/K7plb8aOqZol4GJ+Cr1PvBrKyc6jf1JasWLYdP9w
         MT/VoGO8UaZt9eWhiMCsYV9FJy9KTolWXPTCs5qxKDPjhLRyUDCdMfZq583XkrVmRV
         ztIoe/IeAtyQQ==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x3HE3uYl3931193;
        Wed, 17 Apr 2019 07:03:56 -0700
Date:   Wed, 17 Apr 2019 07:03:56 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Andy Lutomirski <tipbot@zytor.com>
Message-ID: <tip-4f44b8f0b33b7111216f0fad353315f796b81617@git.kernel.org>
Cc:     nstange@suse.de, mingo@kernel.org, tglx@linutronix.de,
        jpoimboe@redhat.com, luto@kernel.org, mingo@redhat.com,
        hpa@zytor.com, bp@suse.de, linux-kernel@vger.kernel.org,
        x86@kernel.org, sean.j.christopherson@intel.com
Reply-To: luto@kernel.org, jpoimboe@redhat.com, tglx@linutronix.de,
          mingo@kernel.org, nstange@suse.de, hpa@zytor.com,
          mingo@redhat.com, x86@kernel.org, linux-kernel@vger.kernel.org,
          bp@suse.de, sean.j.christopherson@intel.com
In-Reply-To: <20190414160143.872549191@linutronix.de>
References: <20190414160143.872549191@linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/irq] x86/irq/64: Remove a hardcoded irq_stack_union access
Git-Commit-ID: 4f44b8f0b33b7111216f0fad353315f796b81617
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

Commit-ID:  4f44b8f0b33b7111216f0fad353315f796b81617
Gitweb:     https://git.kernel.org/tip/4f44b8f0b33b7111216f0fad353315f796b81617
Author:     Andy Lutomirski <luto@kernel.org>
AuthorDate: Sun, 14 Apr 2019 17:59:40 +0200
Committer:  Borislav Petkov <bp@suse.de>
CommitDate: Wed, 17 Apr 2019 12:31:38 +0200

x86/irq/64: Remove a hardcoded irq_stack_union access

stack_overflow_check() is using both irq_stack_ptr and irq_stack_union
to find the IRQ stack. That's going to break when vmapped irq stacks are
introduced.

Change it to just use irq_stack_ptr.

Signed-off-by: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Sean Christopherson <sean.j.christopherson@intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Nicolai Stange <nstange@suse.de>
Cc: x86-ml <x86@kernel.org>
Link: https://lkml.kernel.org/r/20190414160143.872549191@linutronix.de
---
 arch/x86/kernel/irq_64.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/x86/kernel/irq_64.c b/arch/x86/kernel/irq_64.c
index b50ac9c7397b..f6dcc8fea5c0 100644
--- a/arch/x86/kernel/irq_64.c
+++ b/arch/x86/kernel/irq_64.c
@@ -55,9 +55,8 @@ static inline void stack_overflow_check(struct pt_regs *regs)
 	    regs->sp <= curbase + THREAD_SIZE)
 		return;
 
-	irq_stack_top = (u64)this_cpu_ptr(irq_stack_union.irq_stack) +
-			STACK_TOP_MARGIN;
 	irq_stack_bottom = (u64)__this_cpu_read(irq_stack_ptr);
+	irq_stack_top = irq_stack_bottom - IRQ_STACK_SIZE + STACK_TOP_MARGIN;
 	if (regs->sp >= irq_stack_top && regs->sp <= irq_stack_bottom)
 		return;
 
