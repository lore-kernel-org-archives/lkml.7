Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7787FC352AA
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 09:46:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E09D21855
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 09:46:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728698AbfJAJqf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 05:46:35 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:54690 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725765AbfJAJqf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 05:46:35 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iFEjm-00071I-Mt; Tue, 01 Oct 2019 11:46:30 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 4D8671C03AB;
        Tue,  1 Oct 2019 11:46:30 +0200 (CEST)
Date:   Tue, 01 Oct 2019 09:46:30 -0000
From:   "tip-bot2 for Borislav Petkov" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/microcode] x86/microcode/amd: Fix two
 -Wunused-but-set-variable warnings
Cc:     Borislav Petkov <bp@suse.de>, x86@kernel.org,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20190928162559.26294-1-bp@alien8.de>
References: <20190928162559.26294-1-bp@alien8.de>
MIME-Version: 1.0
Message-ID: <156992319017.9978.9822954444615674815.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/microcode branch of tip:

Commit-ID:     2b730952066cd022d1f46e801f06ca6ca9878823
Gitweb:        https://git.kernel.org/tip/2b730952066cd022d1f46e801f06ca6ca9878823
Author:        Borislav Petkov <bp@suse.de>
AuthorDate:    Sat, 28 Sep 2019 16:53:56 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Tue, 01 Oct 2019 11:36:09 +02:00

x86/microcode/amd: Fix two -Wunused-but-set-variable warnings

The dummy variable is the high part of the microcode revision MSR which
is defined as reserved. Mark it unused so that W=1 builds don't trigger
the above warning.

No functional changes.

Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: x86@kernel.org
Link: https://lkml.kernel.org/r/20190928162559.26294-1-bp@alien8.de
---
 arch/x86/kernel/cpu/microcode/amd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/microcode/amd.c b/arch/x86/kernel/cpu/microcode/amd.c
index a0e52bd..3f6b137 100644
--- a/arch/x86/kernel/cpu/microcode/amd.c
+++ b/arch/x86/kernel/cpu/microcode/amd.c
@@ -567,7 +567,7 @@ int __init save_microcode_in_initrd_amd(unsigned int cpuid_1_eax)
 void reload_ucode_amd(void)
 {
 	struct microcode_amd *mc;
-	u32 rev, dummy;
+	u32 rev, dummy __always_unused;
 
 	mc = (struct microcode_amd *)amd_ucode_patch;
 
@@ -673,7 +673,7 @@ static enum ucode_state apply_microcode_amd(int cpu)
 	struct ucode_cpu_info *uci;
 	struct ucode_patch *p;
 	enum ucode_state ret;
-	u32 rev, dummy;
+	u32 rev, dummy __always_unused;
 
 	BUG_ON(raw_smp_processor_id() != cpu);
 
