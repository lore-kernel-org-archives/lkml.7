Return-Path: <SRS0=HQPa=VE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEB2BC0650E
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jul 2019 10:08:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 910C120665
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jul 2019 10:08:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="Tx+4YqYK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727304AbfGGKIF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Jul 2019 06:08:05 -0400
Received: from terminus.zytor.com ([198.137.202.136]:41333 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727141AbfGGKIE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Jul 2019 06:08:04 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x67A7ws4878589
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sun, 7 Jul 2019 03:07:59 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x67A7ws4878589
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1562494079;
        bh=nQc4W8TxTWn6p3U1vcjXmmpb5BtCnp3qTiIy9pV4lgc=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=Tx+4YqYKw7vNJL+kv6mY7cfMBb7ZBH5zun1oeEA6rf+h9EeE4nxk4S9WB6TOr2S9N
         ske6Y6IO7EVB0Cm0BOfVUjqJc3JVXzcTZzSjR8ccg6iO7UHnfDCFoNOr872fGoCWAD
         EMRNwWXYCCQhCmfVzcpB/msxG1XE9cccH5QlQIr6YiPSBs//i3psOuEa9y9xE0YX9c
         YVSYyXxJH4x4gB41tTIriaWks0oS45IguyG8CpzDMS52H+5P10AkKgT4sfvty5qDMp
         FZtLCLkOe0F6O5VvjMhnXAK3VjeVa6UyqzivWg3EKQ8Xw0VmXWY9gxNi8zBxqxFkBg
         GiQ/InC8xPZWg==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x67A7wTE878585;
        Sun, 7 Jul 2019 03:07:58 -0700
Date:   Sun, 7 Jul 2019 03:07:58 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Sebastian Andrzej Siewior <tipbot@zytor.com>
Message-ID: <tip-7891bc0ab739a31538b5f879a523232b8b07a0d3@git.kernel.org>
Cc:     hpa@zytor.com, bigeasy@linutronix.de, mingo@kernel.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de
Reply-To: hpa@zytor.com, tglx@linutronix.de, linux-kernel@vger.kernel.org,
          mingo@kernel.org, bigeasy@linutronix.de
In-Reply-To: <20190704060743.rvew4yrjd6n33uzx@linutronix.de>
References: <20190704060743.rvew4yrjd6n33uzx@linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/fpu] x86/fpu: Inline fpu__xstate_clear_all_cpu_caps()
Git-Commit-ID: 7891bc0ab739a31538b5f879a523232b8b07a0d3
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

Commit-ID:  7891bc0ab739a31538b5f879a523232b8b07a0d3
Gitweb:     https://git.kernel.org/tip/7891bc0ab739a31538b5f879a523232b8b07a0d3
Author:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate: Thu, 4 Jul 2019 08:07:43 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Sun, 7 Jul 2019 12:01:47 +0200

x86/fpu: Inline fpu__xstate_clear_all_cpu_caps()

All fpu__xstate_clear_all_cpu_caps() does is to invoke one simple
function since commit

  73e3a7d2a7c3b ("x86/fpu: Remove the explicit clearing of XSAVE dependent features")

so invoke that function directly and remove the wrapper.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20190704060743.rvew4yrjd6n33uzx@linutronix.de

---
 arch/x86/include/asm/fpu/xstate.h |  1 -
 arch/x86/kernel/fpu/init.c        |  2 +-
 arch/x86/kernel/fpu/xstate.c      | 11 +----------
 3 files changed, 2 insertions(+), 12 deletions(-)

diff --git a/arch/x86/include/asm/fpu/xstate.h b/arch/x86/include/asm/fpu/xstate.h
index 7e42b285c856..c6136d79f8c0 100644
--- a/arch/x86/include/asm/fpu/xstate.h
+++ b/arch/x86/include/asm/fpu/xstate.h
@@ -47,7 +47,6 @@ extern u64 xstate_fx_sw_bytes[USER_XSTATE_FX_SW_WORDS];
 extern void __init update_regset_xstate_info(unsigned int size,
 					     u64 xstate_mask);
 
-void fpu__xstate_clear_all_cpu_caps(void);
 void *get_xsave_addr(struct xregs_state *xsave, int xfeature_nr);
 const void *get_xsave_field_ptr(int xfeature_nr);
 int using_compacted_format(void);
diff --git a/arch/x86/kernel/fpu/init.c b/arch/x86/kernel/fpu/init.c
index 5baae74af4f9..6ce7e0a23268 100644
--- a/arch/x86/kernel/fpu/init.c
+++ b/arch/x86/kernel/fpu/init.c
@@ -259,7 +259,7 @@ static void __init fpu__init_parse_early_param(void)
 #endif
 
 	if (cmdline_find_option_bool(boot_command_line, "noxsave"))
-		fpu__xstate_clear_all_cpu_caps();
+		setup_clear_cpu_cap(X86_FEATURE_XSAVE);
 
 	if (cmdline_find_option_bool(boot_command_line, "noxsaveopt"))
 		setup_clear_cpu_cap(X86_FEATURE_XSAVEOPT);
diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index 3c36dd1784db..7b4c52aa929f 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -67,15 +67,6 @@ static unsigned int xstate_comp_offsets[sizeof(xfeatures_mask)*8];
  */
 unsigned int fpu_user_xstate_size;
 
-/*
- * Clear all of the X86_FEATURE_* bits that are unavailable
- * when the CPU has no XSAVE support.
- */
-void fpu__xstate_clear_all_cpu_caps(void)
-{
-	setup_clear_cpu_cap(X86_FEATURE_XSAVE);
-}
-
 /*
  * Return whether the system supports a given xfeature.
  *
@@ -709,7 +700,7 @@ static void fpu__init_disable_system_xstate(void)
 {
 	xfeatures_mask = 0;
 	cr4_clear_bits(X86_CR4_OSXSAVE);
-	fpu__xstate_clear_all_cpu_caps();
+	setup_clear_cpu_cap(X86_FEATURE_XSAVE);
 }
 
 /*
