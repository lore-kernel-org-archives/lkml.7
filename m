Return-Path: <SRS0=wu79=TZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B07AC282CE
	for <linux-kernel@archiver.kernel.org>; Sat, 25 May 2019 11:52:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F21652085A
	for <linux-kernel@archiver.kernel.org>; Sat, 25 May 2019 11:52:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="WL5vE7XZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726931AbfEYLw4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 May 2019 07:52:56 -0400
Received: from terminus.zytor.com ([198.137.202.136]:41963 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726484AbfEYLwz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 May 2019 07:52:55 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x4PBqO1M669391
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sat, 25 May 2019 04:52:24 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x4PBqO1M669391
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1558785145;
        bh=+2tVzL716qZMfK/2Lsae5ftcXAdW3xS7aEYeoXeVHqA=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=WL5vE7XZAh/sVtSarLjzGcOuvvVB/wzFxIsJGA1Y3R97g+5yXC6erVYlPnFtV9jFi
         vQzA9cWah2jJ8fpJ1Q9XEX2xs1rRRGtcv8Qq1dECMY4qz0vivl0RRBMnkRborwJxHF
         o1IDoR+l5XfGI+1z90dEqG6m7BcjvNX82H13oTMYQs7YAqDgQnAO1SrOr+ri5H7/PD
         SvGB61BYlo8tULMvlWPEf6S5K5L9101N1UAMq3iPS5VSE3SMiDByCS1F4h6WIDy3BN
         CmIqOHRC4vqUY9Y+PGrjyHmv/YA2yf70tfRCtJi5FlYecEkg3acTV6Fgv4BCWaiqnb
         6IjtRv1OxZNZw==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x4PBqNxW669388;
        Sat, 25 May 2019 04:52:23 -0700
Date:   Sat, 25 May 2019 04:52:23 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Gen Zhang <tipbot@zytor.com>
Message-ID: <tip-4e78921ba4dd0aca1cc89168f45039add4183f8e@git.kernel.org>
Cc:     peterz@infradead.org, mingo@kernel.org,
        torvalds@linux-foundation.org, hpa@zytor.com,
        ard.biesheuvel@linaro.org, robert.bradford@intel.com,
        blackgod016574@gmail.com, tglx@linutronix.de,
        linux-kernel@vger.kernel.org
Reply-To: robert.bradford@intel.com, ard.biesheuvel@linaro.org,
          hpa@zytor.com, mingo@kernel.org, peterz@infradead.org,
          torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
          blackgod016574@gmail.com, tglx@linutronix.de
In-Reply-To: <20190525112559.7917-2-ard.biesheuvel@linaro.org>
References: <20190525112559.7917-2-ard.biesheuvel@linaro.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:efi/urgent] efi/x86/Add missing error handling to old_memmap
 1:1 mapping code
Git-Commit-ID: 4e78921ba4dd0aca1cc89168f45039add4183f8e
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

Commit-ID:  4e78921ba4dd0aca1cc89168f45039add4183f8e
Gitweb:     https://git.kernel.org/tip/4e78921ba4dd0aca1cc89168f45039add4183f8e
Author:     Gen Zhang <blackgod016574@gmail.com>
AuthorDate: Sat, 25 May 2019 13:25:58 +0200
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Sat, 25 May 2019 13:48:17 +0200

efi/x86/Add missing error handling to old_memmap 1:1 mapping code

The old_memmap flow in efi_call_phys_prolog() performs numerous memory
allocations, and either does not check for failure at all, or it does
but fails to propagate it back to the caller, which may end up calling
into the firmware with an incomplete 1:1 mapping.

So let's fix this by returning NULL from efi_call_phys_prolog() on
memory allocation failures only, and by handling this condition in the
caller. Also, clean up any half baked sets of page tables that we may
have created before returning with a NULL return value.

Note that any failure at this level will trigger a panic() two levels
up, so none of this makes a huge difference, but it is a nice cleanup
nonetheless.

[ardb: update commit log, add efi_call_phys_epilog() call on error path]

Signed-off-by: Gen Zhang <blackgod016574@gmail.com>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Rob Bradford <robert.bradford@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-efi@vger.kernel.org
Link: http://lkml.kernel.org/r/20190525112559.7917-2-ard.biesheuvel@linaro.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/platform/efi/efi.c    | 2 ++
 arch/x86/platform/efi/efi_64.c | 9 ++++++---
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/arch/x86/platform/efi/efi.c b/arch/x86/platform/efi/efi.c
index e1cb01a22fa8..a7189a3b4d70 100644
--- a/arch/x86/platform/efi/efi.c
+++ b/arch/x86/platform/efi/efi.c
@@ -85,6 +85,8 @@ static efi_status_t __init phys_efi_set_virtual_address_map(
 	pgd_t *save_pgd;
 
 	save_pgd = efi_call_phys_prolog();
+	if (!save_pgd)
+		return EFI_ABORTED;
 
 	/* Disable interrupts around EFI calls: */
 	local_irq_save(flags);
diff --git a/arch/x86/platform/efi/efi_64.c b/arch/x86/platform/efi/efi_64.c
index cf0347f61b21..08ce8177c3af 100644
--- a/arch/x86/platform/efi/efi_64.c
+++ b/arch/x86/platform/efi/efi_64.c
@@ -84,13 +84,15 @@ pgd_t * __init efi_call_phys_prolog(void)
 
 	if (!efi_enabled(EFI_OLD_MEMMAP)) {
 		efi_switch_mm(&efi_mm);
-		return NULL;
+		return efi_mm.pgd;
 	}
 
 	early_code_mapping_set_exec(1);
 
 	n_pgds = DIV_ROUND_UP((max_pfn << PAGE_SHIFT), PGDIR_SIZE);
 	save_pgd = kmalloc_array(n_pgds, sizeof(*save_pgd), GFP_KERNEL);
+	if (!save_pgd)
+		return NULL;
 
 	/*
 	 * Build 1:1 identity mapping for efi=old_map usage. Note that
@@ -138,10 +140,11 @@ pgd_t * __init efi_call_phys_prolog(void)
 		pgd_offset_k(pgd * PGDIR_SIZE)->pgd &= ~_PAGE_NX;
 	}
 
-out:
 	__flush_tlb_all();
-
 	return save_pgd;
+out:
+	efi_call_phys_epilog(save_pgd);
+	return NULL;
 }
 
 void __init efi_call_phys_epilog(pgd_t *save_pgd)
