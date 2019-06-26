Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6841C4646B
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 05:29:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B74172080C
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 05:29:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="AThriEnm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726550AbfFZF3a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 01:29:30 -0400
Received: from terminus.zytor.com ([198.137.202.136]:60909 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725536AbfFZF3a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 01:29:30 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5Q5T2ei3964006
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 25 Jun 2019 22:29:02 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5Q5T2ei3964006
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1561526943;
        bh=IGNWQx5wN70J98okdEe4kw9CgNDkhfJ+7f+b9Z3V3SE=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=AThriEnmcrWslOwUxEAeL46Y2aTuEap9ot0P9v6GsaR2L43MedQK6o4w2Nnr0kGag
         +3sahrzoNUQhjdWHPgkhZJ80+VznMzeblAisNhbKa0Da+WYccIekOU0ARCEpxOCS13
         PxdlA396oMsg8Lk54iYD8DYfjNJhcg2EJ5KaLMt1stMC8ipCzxp5DMZ4LdY50uq47T
         vPancAsBxoLEWWfmHZZ/3MvbWhOtOyq2SEfCisfKqy2tFdC819WdAWFcd2y6QqwtRh
         gQVkjzEmL0XNONFT6fghmhb9c2gN6LxE3qPRiNFAPxpylraAkLTmWveUwLML7w4EOz
         bWXIFxes4PBsg==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5Q5T2Xi3964000;
        Tue, 25 Jun 2019 22:29:02 -0700
Date:   Tue, 25 Jun 2019 22:29:02 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   "tip-bot for Kirill A. Shutemov" <tipbot@zytor.com>
Message-ID: <tip-c1887159eb48ba40e775584cfb2a443962cf1a05@git.kernel.org>
Cc:     kirill.shutemov@linux.intel.com, linux-kernel@vger.kernel.org,
        mingo@kernel.org, peterz@infradead.org, kirill@shutemov.name,
        luto@kernel.org, tglx@linutronix.de, hpa@zytor.com,
        glider@google.com, dave.hansen@linux.intel.com, bp@alien8.de
Reply-To: luto@kernel.org, mingo@kernel.org,
          kirill.shutemov@linux.intel.com, hpa@zytor.com,
          glider@google.com, bp@alien8.de, dave.hansen@linux.intel.com,
          peterz@infradead.org, kirill@shutemov.name, tglx@linutronix.de,
          linux-kernel@vger.kernel.org
In-Reply-To: <20190620112422.29264-1-kirill.shutemov@linux.intel.com>
References: <20190620112422.29264-1-kirill.shutemov@linux.intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] x86/boot/64: Add missing fixup_pointer() for
 next_early_pgt access
Git-Commit-ID: c1887159eb48ba40e775584cfb2a443962cf1a05
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

Commit-ID:  c1887159eb48ba40e775584cfb2a443962cf1a05
Gitweb:     https://git.kernel.org/tip/c1887159eb48ba40e775584cfb2a443962cf1a05
Author:     Kirill A. Shutemov <kirill@shutemov.name>
AuthorDate: Thu, 20 Jun 2019 14:24:22 +0300
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Wed, 26 Jun 2019 07:25:09 +0200

x86/boot/64: Add missing fixup_pointer() for next_early_pgt access

__startup_64() uses fixup_pointer() to access global variables in a
position-independent fashion. Access to next_early_pgt was wrapped into the
helper, but one instance in the 5-level paging branch was missed.

GCC generates a R_X86_64_PC32 PC-relative relocation for the access which
doesn't trigger the issue, but Clang emmits a R_X86_64_32S which leads to
an invalid memory access and system reboot.

Fixes: 187e91fe5e91 ("x86/boot/64/clang: Use fixup_pointer() to access 'next_early_pgt'")
Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Borislav Petkov <bp@alien8.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Alexander Potapenko <glider@google.com>
Link: https://lkml.kernel.org/r/20190620112422.29264-1-kirill.shutemov@linux.intel.com

---
 arch/x86/kernel/head64.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
index 7df5bce4e1be..29ffa495bd1c 100644
--- a/arch/x86/kernel/head64.c
+++ b/arch/x86/kernel/head64.c
@@ -184,7 +184,8 @@ unsigned long __head __startup_64(unsigned long physaddr,
 	pgtable_flags = _KERNPG_TABLE_NOENC + sme_get_me_mask();
 
 	if (la57) {
-		p4d = fixup_pointer(early_dynamic_pgts[next_early_pgt++], physaddr);
+		p4d = fixup_pointer(early_dynamic_pgts[(*next_pgt_ptr)++],
+				    physaddr);
 
 		i = (physaddr >> PGDIR_SHIFT) % PTRS_PER_PGD;
 		pgd[i + 0] = (pgdval_t)p4d + pgtable_flags;
