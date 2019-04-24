Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78D35C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 11:11:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45C762175B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 11:11:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="l4/Paee7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728489AbfDXLL4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 07:11:56 -0400
Received: from terminus.zytor.com ([198.137.202.136]:46395 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727119AbfDXLLz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 07:11:55 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x3OBBUNl2549287
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 24 Apr 2019 04:11:30 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x3OBBUNl2549287
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019041745; t=1556104291;
        bh=3zSss02+unt8h4SxeVCyr2FpT3qo/PQ+UBzFzk4H7Tw=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=l4/Paee7U1/th0LkWwfQlwCdG6CtWQPv59YPp3xhlhugucwKBW4aM1D0D6hV1jjpf
         pJn+uGo7KBxEbz6sU1p5GXuczP+8EIHULMiIUibFnbshMGDqeFGq/wX9dvlgJTKc4U
         ISWV5mSFmXKBXOKrW426CBrbpR7h+CFsT1ceFFrbOeGMPEb2dGS/NZyPpdbgqdlx8P
         Zexqw6p70qlhZgsrust064R5MVGWPDX1h8bfnO02+G9/w9nFhr5dgHf6mP1aPyQb8+
         1aEhJD0gEfS+OFTlQChzUw7qBWLv0RpxBtbirrtsc/+ItshrV62g5MHZLIw/AwK8o/
         Ds6wahBhHtoWw==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x3OBBTUE2549283;
        Wed, 24 Apr 2019 04:11:29 -0700
Date:   Wed, 24 Apr 2019 04:11:29 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jiri Kosina <tipbot@zytor.com>
Message-ID: <tip-a65c88e16f32aa9ef2e8caa68ea5c29bd5eb0ff0@git.kernel.org>
Cc:     dave.hansen@linux.intel.com, peterz@infradead.org,
        torvalds@linux-foundation.org, luto@kernel.org, jkosina@suse.cz,
        linux-kernel@vger.kernel.org, mingo@kernel.org, tglx@linutronix.de,
        jroedel@suse.de, nstange@suse.de, bp@alien8.de, fweisbec@gmail.com,
        hpa@zytor.com
Reply-To: mingo@kernel.org, jkosina@suse.cz, linux-kernel@vger.kernel.org,
          tglx@linutronix.de, bp@alien8.de, nstange@suse.de,
          jroedel@suse.de, fweisbec@gmail.com, hpa@zytor.com,
          dave.hansen@linux.intel.com, peterz@infradead.org,
          torvalds@linux-foundation.org, luto@kernel.org
In-Reply-To: <nycvar.YFH.7.76.1904240902280.9803@cbobk.fhfr.pm>
References: <nycvar.YFH.7.76.1904240902280.9803@cbobk.fhfr.pm>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/mm] x86/mm: Remove in_nmi() warning from 64-bit
 implementation of vmalloc_fault()
Git-Commit-ID: a65c88e16f32aa9ef2e8caa68ea5c29bd5eb0ff0
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

Commit-ID:  a65c88e16f32aa9ef2e8caa68ea5c29bd5eb0ff0
Gitweb:     https://git.kernel.org/tip/a65c88e16f32aa9ef2e8caa68ea5c29bd5eb0ff0
Author:     Jiri Kosina <jkosina@suse.cz>
AuthorDate: Wed, 24 Apr 2019 09:04:57 +0200
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Wed, 24 Apr 2019 12:21:35 +0200

x86/mm: Remove in_nmi() warning from 64-bit implementation of vmalloc_fault()

In-NMI warnings have been added to vmalloc_fault() via:

  ebc8827f75 ("x86: Barf when vmalloc and kmemcheck faults happen in NMI")

back in the time when our NMI entry code could not cope with nested NMIs.

These days, it's perfectly fine to take a fault in NMI context and we
don't have to care about the fact that IRET from the fault handler might
cause NMI nesting.

This warning has already been removed from 32-bit implementation of
vmalloc_fault() in:

  6863ea0cda8 ("x86/mm: Remove in_nmi() warning from vmalloc_fault()")

but the 64-bit version was omitted.

Remove the bogus warning also from 64-bit implementation of vmalloc_fault().

Reported-by: Nicolai Stange <nstange@suse.de>
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Frederic Weisbecker <fweisbec@gmail.com>
Cc: Joerg Roedel <jroedel@suse.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Fixes: 6863ea0cda8 ("x86/mm: Remove in_nmi() warning from vmalloc_fault()")
Link: http://lkml.kernel.org/r/nycvar.YFH.7.76.1904240902280.9803@cbobk.fhfr.pm
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/mm/fault.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index a0df19b0897d..bd20de9db1a8 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -359,8 +359,6 @@ static noinline int vmalloc_fault(unsigned long address)
 	if (!(address >= VMALLOC_START && address < VMALLOC_END))
 		return -1;
 
-	WARN_ON_ONCE(in_nmi());
-
 	/*
 	 * Copy kernel mappings over when needed. This can also
 	 * happen within a race in page table update. In the later
