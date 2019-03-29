Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3F50C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 18:22:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0923218A5
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 18:22:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730041AbfC2SWf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 14:22:35 -0400
Received: from terminus.zytor.com ([198.137.202.136]:59265 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729950AbfC2SWe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 14:22:34 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x2TIMF3E3895679
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 29 Mar 2019 11:22:15 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x2TIMEQN3895676;
        Fri, 29 Mar 2019 11:22:14 -0700
Date:   Fri, 29 Mar 2019 11:22:14 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Borislav Petkov <tipbot@zytor.com>
Message-ID: <tip-ae37a8cd9b0ad3416d71e54cfaeb3744178189a8@git.kernel.org>
Cc:     nadav.amit@gmail.com, peterz@infradead.org, hpa@zytor.com,
        mingo@kernel.org, linux-kernel@vger.kernel.org, bp@suse.de,
        tglx@linutronix.de
Reply-To: peterz@infradead.org, nadav.amit@gmail.com, hpa@zytor.com,
          mingo@kernel.org, linux-kernel@vger.kernel.org, bp@suse.de,
          tglx@linutronix.de
In-Reply-To: <20190307151036.GD26566@zn.tnic>
References: <20190307151036.GD26566@zn.tnic>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/asm] x86/cpufeature: Remove __pure attribute to
 _static_cpu_has()
Git-Commit-ID: ae37a8cd9b0ad3416d71e54cfaeb3744178189a8
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

Commit-ID:  ae37a8cd9b0ad3416d71e54cfaeb3744178189a8
Gitweb:     https://git.kernel.org/tip/ae37a8cd9b0ad3416d71e54cfaeb3744178189a8
Author:     Borislav Petkov <bp@suse.de>
AuthorDate: Thu, 7 Mar 2019 15:54:51 +0100
Committer:  Borislav Petkov <bp@suse.de>
CommitDate: Fri, 29 Mar 2019 19:13:48 +0100

x86/cpufeature: Remove __pure attribute to _static_cpu_has()

__pure is used to make gcc do Common Subexpression Elimination (CSE)
and thus save subsequent invocations of a function which does a complex
computation (without side effects). As a simple example:

  bool a = _static_cpu_has(x);
  bool b = _static_cpu_has(x);

gets turned into

  bool a = _static_cpu_has(x);
  bool b = a;

However, gcc doesn't do CSE with asm()s when those get inlined - like it
is done with _static_cpu_has() - because, for example, the t_yes/t_no
labels are different for each inlined function body and thus cannot be
detected as equivalent anymore for the CSE heuristic to hit.

However, this all is beside the point because best it should be avoided
to have more than one call to _static_cpu_has(X) in the same function
due to the fact that each such call is an alternatives patch site and it
is simply pointless.

Therefore, drop the __pure attribute as it is not doing anything.

Reported-by: Nadav Amit <nadav.amit@gmail.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: x86@kernel.org
Link: https://lkml.kernel.org/r/20190307151036.GD26566@zn.tnic
---
 arch/x86/include/asm/cpufeature.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/cpufeature.h b/arch/x86/include/asm/cpufeature.h
index ce95b8cbd229..2fb791a1b479 100644
--- a/arch/x86/include/asm/cpufeature.h
+++ b/arch/x86/include/asm/cpufeature.h
@@ -159,7 +159,7 @@ extern void clear_cpu_cap(struct cpuinfo_x86 *c, unsigned int bit);
  * These will statically patch the target code for additional
  * performance.
  */
-static __always_inline __pure bool _static_cpu_has(u16 bit)
+static __always_inline bool _static_cpu_has(u16 bit)
 {
 	asm_volatile_goto("1: jmp 6f\n"
 		 "2:\n"
