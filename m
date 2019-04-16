Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93DA2C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 08:14:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EABA20868
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 08:14:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728615AbfDPIOE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 04:14:04 -0400
Received: from terminus.zytor.com ([198.137.202.136]:35247 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726346AbfDPIOD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 04:14:03 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x3G8Dpur3352660
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 16 Apr 2019 01:13:51 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x3G8Dp9T3352657;
        Tue, 16 Apr 2019 01:13:51 -0700
Date:   Tue, 16 Apr 2019 01:13:51 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Peter Zijlstra <tipbot@zytor.com>
Message-ID: <tip-780e0106d468a2962b16b52fdf42898f2639e0a0@git.kernel.org>
Cc:     tglx@linutronix.de, peterz@infradead.org, luto@kernel.org,
        mingo@kernel.org, dave.hansen@intel.com,
        linux-kernel@vger.kernel.org, hpa@zytor.com,
        torvalds@linux-foundation.org, namit@vmware.com, bp@alien8.de
Reply-To: bp@alien8.de, namit@vmware.com, torvalds@linux-foundation.org,
          luto@kernel.org, peterz@infradead.org, mingo@kernel.org,
          tglx@linutronix.de, hpa@zytor.com, dave.hansen@intel.com,
          linux-kernel@vger.kernel.org
In-Reply-To: <20190416080335.GM7905@worktop.programming.kicks-ass.net>
References: <20190416080335.GM7905@worktop.programming.kicks-ass.net>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] x86/mm/tlb: Revert "x86/mm: Align TLB invalidation
 info"
Git-Commit-ID: 780e0106d468a2962b16b52fdf42898f2639e0a0
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

Commit-ID:  780e0106d468a2962b16b52fdf42898f2639e0a0
Gitweb:     https://git.kernel.org/tip/780e0106d468a2962b16b52fdf42898f2639e0a0
Author:     Peter Zijlstra <peterz@infradead.org>
AuthorDate: Tue, 16 Apr 2019 10:03:35 +0200
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 16 Apr 2019 10:10:13 +0200

x86/mm/tlb: Revert "x86/mm: Align TLB invalidation info"

Revert the following commit:

  515ab7c41306: ("x86/mm: Align TLB invalidation info")

I found out (the hard way) that under some .config options (notably L1_CACHE_SHIFT=7)
and compiler combinations this on-stack alignment leads to a 320 byte
stack usage, which then triggers a KASAN stack warning elsewhere.

Using 320 bytes of stack space for a 40 byte structure is ludicrous and
clearly not right.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Linus Torvalds <torvalds@linux-foundation.org>
Acked-by: Nadav Amit <namit@vmware.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Fixes: 515ab7c41306 ("x86/mm: Align TLB invalidation info")
Link: http://lkml.kernel.org/r/20190416080335.GM7905@worktop.programming.kicks-ass.net
[ Minor changelog edits. ]
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/mm/tlb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index bc4bc7b2f075..487b8474c01c 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -728,7 +728,7 @@ void flush_tlb_mm_range(struct mm_struct *mm, unsigned long start,
 {
 	int cpu;
 
-	struct flush_tlb_info info __aligned(SMP_CACHE_BYTES) = {
+	struct flush_tlb_info info = {
 		.mm = mm,
 		.stride_shift = stride_shift,
 		.freed_tables = freed_tables,
