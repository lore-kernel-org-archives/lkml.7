Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 659E9C43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 01:42:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3484E208E4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 01:42:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="ykk+mrqD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726440AbfFXBkw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Jun 2019 21:40:52 -0400
Received: from terminus.zytor.com ([198.137.202.136]:51211 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726304AbfFXBkv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jun 2019 21:40:51 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5NNvYO52860613
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sun, 23 Jun 2019 16:57:34 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5NNvYO52860613
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1561334255;
        bh=JCXMBZ4jwUQ64qsoesWTGpB3WEjAXkb75kfS12UJltI=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=ykk+mrqD2cJpX9IxNd+wcKHq2YcKd6fGEKyiyPhD+7WG9e1KQzQsQFE30eOIdhk1n
         7BZoDQVX0mmJYZY0mhtwoHln2ViZrfVQjqwe6wgQfiA4PnenKlcluIiGIOtMFZ2EPu
         ZHm0BJLpFSQbjV/3N8k6PaNDBlHrR+bpyDIzDJfU8OBbKrmJw3AyDqgMbp45zJjPUg
         eM815F7Liz/2LE4vjJ8c1BgHfNabfH9gF8fBmoqzPZLHO61A9XZezHHl85URZR7BL3
         Zl5iV00bcAzSdBnOWoM36NdOms9/O5cSllZVndw12cTgxAWQt6i9Khw0gnxcS1rCfw
         FdrLCxHo+/WNg==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5NNvYgw2860610;
        Sun, 23 Jun 2019 16:57:34 -0700
Date:   Sun, 23 Jun 2019 16:57:34 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Andy Lutomirski <tipbot@zytor.com>
Message-ID: <tip-ecf9db3d1f1a8fd2c335148891c3b044e9ce0628@git.kernel.org>
Cc:     torvalds@linux-foundation.org, luto@kernel.org,
        linux-kernel@vger.kernel.org, mingo@kernel.org, bp@alien8.de,
        peterz@infradead.org, hpa@zytor.com, tglx@linutronix.de
Reply-To: mingo@kernel.org, bp@alien8.de, linux-kernel@vger.kernel.org,
          torvalds@linux-foundation.org, luto@kernel.org,
          tglx@linutronix.de, hpa@zytor.com, peterz@infradead.org
In-Reply-To: <6920c5188f8658001af1fc56fd35b815706d300c.1561241273.git.luto@kernel.org>
References: <6920c5188f8658001af1fc56fd35b815706d300c.1561241273.git.luto@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:timers/vdso] x86/vdso: Give the [ph]vclock_page declarations
 real types
Git-Commit-ID: ecf9db3d1f1a8fd2c335148891c3b044e9ce0628
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

Commit-ID:  ecf9db3d1f1a8fd2c335148891c3b044e9ce0628
Gitweb:     https://git.kernel.org/tip/ecf9db3d1f1a8fd2c335148891c3b044e9ce0628
Author:     Andy Lutomirski <luto@kernel.org>
AuthorDate: Sat, 22 Jun 2019 15:08:18 -0700
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Mon, 24 Jun 2019 01:21:31 +0200

x86/vdso: Give the [ph]vclock_page declarations real types

Clean up the vDSO code a bit by giving pvclock_page and hvclock_page
their actual types instead of u8[PAGE_SIZE].  This shouldn't
materially affect the generated code.

Heavily based on a patch from Linus.

[ tglx: Adapted to the unified VDSO code ]

Co-developed-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: https://lkml.kernel.org/r/6920c5188f8658001af1fc56fd35b815706d300c.1561241273.git.luto@kernel.org
---
 arch/x86/include/asm/vdso/gettimeofday.h | 36 +++++++++++++++++++++-----------
 1 file changed, 24 insertions(+), 12 deletions(-)

diff --git a/arch/x86/include/asm/vdso/gettimeofday.h b/arch/x86/include/asm/vdso/gettimeofday.h
index f92752d6cbcf..5b63f1f78a1f 100644
--- a/arch/x86/include/asm/vdso/gettimeofday.h
+++ b/arch/x86/include/asm/vdso/gettimeofday.h
@@ -26,13 +26,33 @@
 
 #define VDSO_HAS_CLOCK_GETRES 1
 
+/*
+ * Declare the memory-mapped vclock data pages.  These come from hypervisors.
+ * If we ever reintroduce something like direct access to an MMIO clock like
+ * the HPET again, it will go here as well.
+ *
+ * A load from any of these pages will segfault if the clock in question is
+ * disabled, so appropriate compiler barriers and checks need to be used
+ * to prevent stray loads.
+ *
+ * These declarations MUST NOT be const.  The compiler will assume that
+ * an extern const variable has genuinely constant contents, and the
+ * resulting code won't work, since the whole point is that these pages
+ * change over time, possibly while we're accessing them.
+ */
+
 #ifdef CONFIG_PARAVIRT_CLOCK
-extern u8 pvclock_page[PAGE_SIZE]
+/*
+ * This is the vCPU 0 pvclock page.  We only use pvclock from the vDSO
+ * if the hypervisor tells us that all vCPUs can get valid data from the
+ * vCPU 0 page.
+ */
+extern struct pvclock_vsyscall_time_info pvclock_page
 	__attribute__((visibility("hidden")));
 #endif
 
 #ifdef CONFIG_HYPERV_TSCPAGE
-extern u8 hvclock_page[PAGE_SIZE]
+extern struct ms_hyperv_tsc_page hvclock_page
 	__attribute__((visibility("hidden")));
 #endif
 
@@ -131,14 +151,9 @@ clock_getres_fallback(clockid_t _clkid, struct __kernel_timespec *_ts)
 #endif
 
 #ifdef CONFIG_PARAVIRT_CLOCK
-static const struct pvclock_vsyscall_time_info *get_pvti0(void)
-{
-	return (const struct pvclock_vsyscall_time_info *)&pvclock_page;
-}
-
 static u64 vread_pvclock(void)
 {
-	const struct pvclock_vcpu_time_info *pvti = &get_pvti0()->pvti;
+	const struct pvclock_vcpu_time_info *pvti = &pvclock_page.pvti;
 	u32 version;
 	u64 ret;
 
@@ -180,10 +195,7 @@ static u64 vread_pvclock(void)
 #ifdef CONFIG_HYPERV_TSCPAGE
 static u64 vread_hvclock(void)
 {
-	const struct ms_hyperv_tsc_page *tsc_pg =
-		(const struct ms_hyperv_tsc_page *)&hvclock_page;
-
-	return hv_read_tsc_page(tsc_pg);
+	return hv_read_tsc_page(&hvclock_page);
 }
 #endif
 
