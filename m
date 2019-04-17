Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E000C282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 14:09:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C7B6206BA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 14:09:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="K++lZe0+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732383AbfDQOJ4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 10:09:56 -0400
Received: from terminus.zytor.com ([198.137.202.136]:43855 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729940AbfDQOJ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 10:09:56 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x3HE9Xew3933782
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 17 Apr 2019 07:09:33 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x3HE9Xew3933782
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019041743; t=1555510173;
        bh=vcb3+0BMhINMyR+zwTH60MG+SxAql2USlqkJCgCmKUw=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=K++lZe0+XnpLvYlusvUUYp3tV/8ffj+2U6Yyrykoa3BFEjGQOB5IH9HxI+bNLcCCD
         zZZR1/SXXgmnaUpwtehLaQ1Vz6UKHhPNirtVVy7RQabsIT0yTLwMk5Kr+HAQHabOAE
         rTJcQQmDuCJZL6rkQISF1XGWXBRob2MXUwHUk+hvW71K8BybZmCQdu61opceETckp1
         d8d5POUEboCjI/TXnhAo4yiEvFdrKXJj6U4aFDgMQS1JPaovX4/LsbX1cSIEEkMDXA
         USd9VedW98uCkUnnIgFVyUHpFHi61l+EB1NKW1EbbYVoIfIoZmZP6Rb2zYaY1Z8cYc
         lF+hL5yJ/fzIw==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x3HE9W4E3933779;
        Wed, 17 Apr 2019 07:09:32 -0700
Date:   Wed, 17 Apr 2019 07:09:32 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Thomas Gleixner <tipbot@zytor.com>
Message-ID: <tip-a4af767ae59cc579569bbfe49513a0037d5989ee@git.kernel.org>
Cc:     peterz@infradead.org, dave.hansen@linux.intel.com,
        jpoimboe@redhat.com, mingo@kernel.org, hpa@zytor.com,
        sean.j.christopherson@intel.com, mingo@redhat.com,
        tglx@linutronix.de, bp@suse.de, x86@kernel.org,
        linux-kernel@vger.kernel.org, luto@kernel.org
Reply-To: dave.hansen@linux.intel.com, peterz@infradead.org, hpa@zytor.com,
          jpoimboe@redhat.com, mingo@kernel.org,
          sean.j.christopherson@intel.com, mingo@redhat.com,
          tglx@linutronix.de, x86@kernel.org, linux-kernel@vger.kernel.org,
          bp@suse.de, luto@kernel.org
In-Reply-To: <20190414160144.592691557@linutronix.de>
References: <20190414160144.592691557@linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/irq] x86/cpu_entry_area: Prepare for IST guard pages
Git-Commit-ID: a4af767ae59cc579569bbfe49513a0037d5989ee
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

Commit-ID:  a4af767ae59cc579569bbfe49513a0037d5989ee
Gitweb:     https://git.kernel.org/tip/a4af767ae59cc579569bbfe49513a0037d5989ee
Author:     Thomas Gleixner <tglx@linutronix.de>
AuthorDate: Sun, 14 Apr 2019 17:59:48 +0200
Committer:  Borislav Petkov <bp@suse.de>
CommitDate: Wed, 17 Apr 2019 12:58:21 +0200

x86/cpu_entry_area: Prepare for IST guard pages

To allow guard pages between the IST stacks each stack needs to be
mapped individually.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Sean Christopherson <sean.j.christopherson@intel.com>
Cc: x86-ml <x86@kernel.org>
Link: https://lkml.kernel.org/r/20190414160144.592691557@linutronix.de
---
 arch/x86/mm/cpu_entry_area.c | 37 ++++++++++++++++++++++++++++++-------
 1 file changed, 30 insertions(+), 7 deletions(-)

diff --git a/arch/x86/mm/cpu_entry_area.c b/arch/x86/mm/cpu_entry_area.c
index 6a09b84c13fe..2b1407662a6d 100644
--- a/arch/x86/mm/cpu_entry_area.c
+++ b/arch/x86/mm/cpu_entry_area.c
@@ -77,6 +77,34 @@ static void __init percpu_setup_debug_store(unsigned int cpu)
 #endif
 }
 
+#ifdef CONFIG_X86_64
+
+#define cea_map_stack(name) do {					\
+	npages = sizeof(estacks->name## _stack) / PAGE_SIZE;		\
+	cea_map_percpu_pages(cea->estacks.name## _stack,		\
+			estacks->name## _stack, npages, PAGE_KERNEL);	\
+	} while (0)
+
+static void __init percpu_setup_exception_stacks(unsigned int cpu)
+{
+	struct exception_stacks *estacks = per_cpu_ptr(&exception_stacks, cpu);
+	struct cpu_entry_area *cea = get_cpu_entry_area(cpu);
+	unsigned int npages;
+
+	BUILD_BUG_ON(sizeof(exception_stacks) % PAGE_SIZE != 0);
+	/*
+	 * The exceptions stack mappings in the per cpu area are protected
+	 * by guard pages so each stack must be mapped separately.
+	 */
+	cea_map_stack(DF);
+	cea_map_stack(NMI);
+	cea_map_stack(DB);
+	cea_map_stack(MCE);
+}
+#else
+static inline void percpu_setup_exception_stacks(unsigned int cpu) {}
+#endif
+
 /* Setup the fixmap mappings only once per-processor */
 static void __init setup_cpu_entry_area(unsigned int cpu)
 {
@@ -134,13 +162,8 @@ static void __init setup_cpu_entry_area(unsigned int cpu)
 	per_cpu(cpu_entry_area, cpu) = cea;
 #endif
 
-#ifdef CONFIG_X86_64
-	BUILD_BUG_ON(sizeof(exception_stacks) % PAGE_SIZE != 0);
-	BUILD_BUG_ON(sizeof(exception_stacks) !=
-		     sizeof(((struct cpu_entry_area *)0)->estacks));
-	cea_map_percpu_pages(&cea->estacks, &per_cpu(exception_stacks, cpu),
-			     sizeof(exception_stacks) / PAGE_SIZE, PAGE_KERNEL);
-#endif
+	percpu_setup_exception_stacks(cpu);
+
 	percpu_setup_debug_store(cpu);
 }
 
