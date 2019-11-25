Return-Path: <SRS0=OOqn=ZR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B411AC432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 05:48:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86ADB20656
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 05:48:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iXN0XOsF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725851AbfKYFsp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Nov 2019 00:48:45 -0500
Received: from mail-pl1-f201.google.com ([209.85.214.201]:42460 "EHLO
        mail-pl1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725468AbfKYFsp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 00:48:45 -0500
Received: by mail-pl1-f201.google.com with SMTP id 30so5662206plb.9
        for <linux-kernel@vger.kernel.org>; Sun, 24 Nov 2019 21:48:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=FI5EUsnW2tllZPOcKfh8zEZkIgR4ks3oXOOv8BjcIao=;
        b=iXN0XOsFHMJstMYl4Vb5XIPTGxPwT3L4Q1cQH1j4d+fxXolwz2eWfcJOMbbWaDnTLp
         rCNYms/m5JQmMFiPh1lCGgbyXCkhbPxCl+ua7iPOdBZ5N64nQr6NrrZg6MszuTB964yY
         FkfM8IaHuj9dKhI01L8v+hXN7h6cIgvjYeRaLKu91M9aQbB8LukxIMCPQ0JT+Mz6fSLf
         DNh6D5d9Qt/g22kebr5S0cnjuFeqYIONrjX90oyHQCS/Qj13FLU5lZGY27y/HaFJVF0j
         dnf495GO6chKkNmddD3SIfRciMopxhzUchqJPDKEMMuOd+OnWJO+oVe4+Vj+6yaM0COu
         40jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=FI5EUsnW2tllZPOcKfh8zEZkIgR4ks3oXOOv8BjcIao=;
        b=JcIp2GkTH/jdVSf+oirOllz90LxOKDr0c51j/l92gep1xwC/k54KufZKJEa4/8OPDX
         kGIx6HtOdqUeGtBk3alE/yb3J95ut+bFN8qwYu79qR6AN+x3wyutErS8DwErNiSR0+pf
         /iWAOnRNGpIWsfgYoGZWGpJQtBhyUepoXL33II9DKgWBFwPytYQOJsFqubPkcoAyZzsp
         N7vHrhYwGFH+uIuRO99RiVgcZLI2MIaXJabMtKCefJ2WnhLFZzFnUEQDnAmuR7I8YWwN
         eSlS6AMz60yVHibzb4k/Slab2AHWupQjfRd1/hcx3EcjbkWOaryxC8JgcGZxFOEFQGb5
         4kcQ==
X-Gm-Message-State: APjAAAUfCgicLSLjfic+OZyYVShH8kNtXwpj9F0XY1VxjpySX9CE/Ccc
        jACvDJ6BQsjbc49zyXAcYCIusw3Pa9VNXhb5SOg4czNkCbM+tZjJxIWJ/+mvDajwNPwds8AIFuI
        6l2IhbiUpZHns4GqfmP+cRjKQtDGhHEyhffGV93QlW8JCgHSMaZquuGriyP4HkCRwVMXoGNeb6W
        NJvPTmwKRo
X-Google-Smtp-Source: APXvYqywa9F4lnnabgW0YUjU70W5puvdkJ5dP/K1PMu8f/6nU1BAv/zqNTek4HnEj6+aZNWabR0k1F+n6/RU8eRanT8=
X-Received: by 2002:a65:6906:: with SMTP id s6mr13922166pgq.26.1574660922804;
 Sun, 24 Nov 2019 21:48:42 -0800 (PST)
Date:   Sun, 24 Nov 2019 21:48:38 -0800
Message-Id: <20191125054838.137615-1-asteinhauser@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.24.0.432.g9d3f5f5b63-goog
Subject: [PATCH] Immediate enforcement of /sys/devices/cpu/rdpmc set to 0.
From:   Anthony Steinhauser <asteinhauser@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        x86@kernel.org, Anthony Steinhauser <asteinhauser@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When you successfully write 0 to /sys/devices/cpu/rdpmc, the RDPMC
instruction should be disabled unconditionally and immediately (after you
close the SYSFS file) by the documentation.
Instead, in the current implementation the PMU must be reloaded which
happens only eventually some time in the future. Only after that the RDPMC
instruction becomes disabled (on ring 3) on the respective core.
This change makes the treatment of the 0 value as blocking and as
unconditional as the current treatment of the 2 value, only the CR4.PCE
bit is naturally set to false instead of true.

Signed-off-by: Anthony Steinhauser <asteinhauser@google.com>
---
 arch/x86/events/core.c             | 18 ++++++++++++------
 arch/x86/include/asm/mmu_context.h |  4 +++-
 2 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 7b21455d7504..0531092fe8f3 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -49,6 +49,7 @@ DEFINE_PER_CPU(struct cpu_hw_events, cpu_hw_events) = {
 	.enabled = 1,
 };
 
+DEFINE_STATIC_KEY_FALSE(rdpmc_never_available_key);
 DEFINE_STATIC_KEY_FALSE(rdpmc_always_available_key);
 
 u64 __read_mostly hw_cache_event_ids
@@ -2181,21 +2182,26 @@ static ssize_t set_attr_rdpmc(struct device *cdev,
 	if (x86_pmu.attr_rdpmc_broken)
 		return -ENOTSUPP;
 
-	if ((val == 2) != (x86_pmu.attr_rdpmc == 2)) {
+	if (val != x86_pmu.attr_rdpmc) {
 		/*
-		 * Changing into or out of always available, aka
-		 * perf-event-bypassing mode.  This path is extremely slow,
+		 * Changing into or out of never available or always available,
+		 * aka perf-event-bypassing mode. This path is extremely slow,
 		 * but only root can trigger it, so it's okay.
 		 */
+		if (val == 0)
+			static_branch_inc(&rdpmc_never_available_key);
+		else if (x86_pmu.attr_rdpmc == 0)
+			static_branch_dec(&rdpmc_never_available_key);
+
 		if (val == 2)
 			static_branch_inc(&rdpmc_always_available_key);
-		else
+		else if (x86_pmu.attr_rdpmc == 2)
 			static_branch_dec(&rdpmc_always_available_key);
+
 		on_each_cpu(refresh_pce, NULL, 1);
+		x86_pmu.attr_rdpmc = val;
 	}
 
-	x86_pmu.attr_rdpmc = val;
-
 	return count;
 }
 
diff --git a/arch/x86/include/asm/mmu_context.h b/arch/x86/include/asm/mmu_context.h
index 16ae821483c8..bd60bbd2f959 100644
--- a/arch/x86/include/asm/mmu_context.h
+++ b/arch/x86/include/asm/mmu_context.h
@@ -26,12 +26,14 @@ static inline void paravirt_activate_mm(struct mm_struct *prev,
 
 #ifdef CONFIG_PERF_EVENTS
 
+DECLARE_STATIC_KEY_FALSE(rdpmc_never_available_key);
 DECLARE_STATIC_KEY_FALSE(rdpmc_always_available_key);
 
 static inline void load_mm_cr4_irqsoff(struct mm_struct *mm)
 {
 	if (static_branch_unlikely(&rdpmc_always_available_key) ||
-	    atomic_read(&mm->context.perf_rdpmc_allowed))
+	    (!static_branch_unlikely(&rdpmc_never_available_key) &&
+	     atomic_read(&mm->context.perf_rdpmc_allowed)))
 		cr4_set_bits_irqsoff(X86_CR4_PCE);
 	else
 		cr4_clear_bits_irqsoff(X86_CR4_PCE);
-- 
2.24.0.432.g9d3f5f5b63-goog

