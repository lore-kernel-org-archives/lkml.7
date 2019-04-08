Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88647C10F14
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 14:29:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6366920879
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 14:29:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726850AbfDHO3O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 10:29:14 -0400
Received: from terminus.zytor.com ([198.137.202.136]:47449 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726573AbfDHO3O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 10:29:14 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x38ET2cr4100728
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 8 Apr 2019 07:29:02 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x38ET2954100725;
        Mon, 8 Apr 2019 07:29:02 -0700
Date:   Mon, 8 Apr 2019 07:29:02 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Borislav Petkov <tipbot@zytor.com>
Message-ID: <tip-bfdd5a67c8cb02c147c6b012543e84cb1f5759ba@git.kernel.org>
Cc:     hpa@zytor.com, mingo@kernel.org, bp@suse.de, nadav.amit@gmail.com,
        linux-kernel@vger.kernel.org, tglx@linutronix.de
Reply-To: hpa@zytor.com, tglx@linutronix.de, nadav.amit@gmail.com,
          linux-kernel@vger.kernel.org, bp@suse.de, mingo@kernel.org
In-Reply-To: <20190330112022.28888-2-bp@alien8.de>
References: <20190330112022.28888-2-bp@alien8.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/asm] x86/asm: Clarify static_cpu_has()'s intended use
Git-Commit-ID: bfdd5a67c8cb02c147c6b012543e84cb1f5759ba
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

Commit-ID:  bfdd5a67c8cb02c147c6b012543e84cb1f5759ba
Gitweb:     https://git.kernel.org/tip/bfdd5a67c8cb02c147c6b012543e84cb1f5759ba
Author:     Borislav Petkov <bp@suse.de>
AuthorDate: Fri, 29 Mar 2019 19:35:24 +0100
Committer:  Borislav Petkov <bp@suse.de>
CommitDate: Mon, 8 Apr 2019 12:02:55 +0200

x86/asm: Clarify static_cpu_has()'s intended use

Clarify when one should use static_cpu_has() and when one should use
boot_cpu_has().

Requested-by: Nadav Amit <nadav.amit@gmail.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: x86@kernel.org
Link: https://lkml.kernel.org/r/20190330112022.28888-2-bp@alien8.de
---
 arch/x86/include/asm/cpufeature.h | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/cpufeature.h b/arch/x86/include/asm/cpufeature.h
index 2fb791a1b479..6d6d5cc4302b 100644
--- a/arch/x86/include/asm/cpufeature.h
+++ b/arch/x86/include/asm/cpufeature.h
@@ -155,9 +155,12 @@ extern void clear_cpu_cap(struct cpuinfo_x86 *c, unsigned int bit);
 #else
 
 /*
- * Static testing of CPU features.  Used the same as boot_cpu_has().
- * These will statically patch the target code for additional
- * performance.
+ * Static testing of CPU features. Used the same as boot_cpu_has(). It
+ * statically patches the target code for additional performance. Use
+ * static_cpu_has() only in fast paths, where every cycle counts. Which
+ * means that the boot_cpu_has() variant is already fast enough for the
+ * majority of cases and you should stick to using it as it is generally
+ * only two instructions: a RIP-relative MOV and a TEST.
  */
 static __always_inline bool _static_cpu_has(u16 bit)
 {
