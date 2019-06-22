Return-Path: <SRS0=kYop=UV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1364EC43613
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 22:08:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBAB4206B7
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 22:08:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561241318;
	bh=BvSt+fMYJewY1L3HbKjDF1ilwCwa+LuIeaLapVC1Lgc=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=xITJ300ucj9Q3ZXPX6afbdRR2jV5dTZ3QBIijGl+wt/GLhqcB8JNfL/tPk0/Gmnzl
	 DTiAftaQkLrsKqSD+EzMuv0zFM0DLFYBVQdY7eO8sfmVtCqIuw6v/8UeSnaia+9fqD
	 gDVfZZ1fti2ZmOFnwJIRbziUsvYTVD2rkT3tts5k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726372AbfFVWIY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Jun 2019 18:08:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:47074 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725844AbfFVWIX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jun 2019 18:08:23 -0400
Received: from localhost (c-67-180-165-146.hsd1.ca.comcast.net [67.180.165.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 45FCA206B7;
        Sat, 22 Jun 2019 22:08:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561241302;
        bh=BvSt+fMYJewY1L3HbKjDF1ilwCwa+LuIeaLapVC1Lgc=;
        h=From:To:Cc:Subject:Date:From;
        b=AW2o0cx5rRzHPlM3kEFWc4wjywu9160FB9Kw2twAkwA7z2afodlI8HqBVFl8LnUVo
         7GBtbN5ptaatKQayxBsSyyNgBr35HLaj08U0ZHlqLJJB1qMN4foQo2oHQQ7U/by0d2
         56k0JUnYWOQVl7+tX+cblbb7zL1V2BtKNnCK0IkA=
From:   Andy Lutomirski <luto@kernel.org>
To:     x86@kernel.org
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH] x86/vdso: Give the [ph]vclock_page declarations real types
Date:   Sat, 22 Jun 2019 15:08:18 -0700
Message-Id: <6920c5188f8658001af1fc56fd35b815706d300c.1561241273.git.luto@kernel.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clean up the vDSO code a bit by giving pvclock_page and hvclock_page
their actual types instead of u8[PAGE_SIZE].  This shouldn't
materially affect the generated code.

Heavily based on a patch from Linus.

Cc: Borislav Petkov <bp@alien8.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Andy Lutomirski <luto@kernel.org>
---
 arch/x86/entry/vdso/vclock_gettime.c | 36 ++++++++++++++++++----------
 1 file changed, 24 insertions(+), 12 deletions(-)

diff --git a/arch/x86/entry/vdso/vclock_gettime.c b/arch/x86/entry/vdso/vclock_gettime.c
index 4aed41f638bb..907efc5015ec 100644
--- a/arch/x86/entry/vdso/vclock_gettime.c
+++ b/arch/x86/entry/vdso/vclock_gettime.c
@@ -28,13 +28,33 @@ extern int __vdso_clock_gettime(clockid_t clock, struct timespec *ts);
 extern int __vdso_gettimeofday(struct timeval *tv, struct timezone *tz);
 extern time_t __vdso_time(time_t *t);
 
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
 
@@ -69,14 +89,9 @@ notrace static long vdso_fallback_gettime(long clock, struct timespec *ts)
 #endif
 
 #ifdef CONFIG_PARAVIRT_CLOCK
-static notrace const struct pvclock_vsyscall_time_info *get_pvti0(void)
-{
-	return (const struct pvclock_vsyscall_time_info *)&pvclock_page;
-}
-
 static notrace u64 vread_pvclock(void)
 {
-	const struct pvclock_vcpu_time_info *pvti = &get_pvti0()->pvti;
+	const struct pvclock_vcpu_time_info *pvti = &pvclock_page.pvti;
 	u32 version;
 	u64 ret;
 
@@ -117,10 +132,7 @@ static notrace u64 vread_pvclock(void)
 #ifdef CONFIG_HYPERV_TSCPAGE
 static notrace u64 vread_hvclock(void)
 {
-	const struct ms_hyperv_tsc_page *tsc_pg =
-		(const struct ms_hyperv_tsc_page *)&hvclock_page;
-
-	return hv_read_tsc_page(tsc_pg);
+	return hv_read_tsc_page(&hvclock_page);
 }
 #endif
 
-- 
2.21.0

