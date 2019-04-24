Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD3B0C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 11:13:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D2E9218D3
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 11:13:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="Iq1hJS99"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729084AbfDXLNK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 07:13:10 -0400
Received: from terminus.zytor.com ([198.137.202.136]:40469 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726135AbfDXLNJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 07:13:09 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x3OBCqGk2549670
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 24 Apr 2019 04:12:53 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x3OBCqGk2549670
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019041745; t=1556104373;
        bh=OjWgvd6dKYswwv3npoNjRFVZQ384ZzkiKL3VRt51oVQ=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=Iq1hJS99qrozvee6wYWoEDmhipMCrf6O7SLn5O1707IPBBr/PPMdgWfuwXp+3/TXv
         lpcSHEnm6atENyzsQhsbuKDuujAH9xvbAFbQjYm5m3BZYEidlM0cCxznpGojMTQPKV
         iPmBU8T2I9lU+ilqyUfQXI4bxnADvoJWStMlEtmY4R4JXeX/He1wpqn5F1TA4MIFTL
         4z6cCi5vlpH2XaSxZBOffipcEkO6GS4D+TWMfFw1+zoYMJSNJ5+q+t/NjvOywSSW8S
         APxgtNyrk4rX9E/cpucwtDB7SpyYSbx4EnoJtHgpUa/mjM/VN1BO41uJBAcq5x+2mU
         J/Jmv7eWCRsug==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x3OBCqfQ2549667;
        Wed, 24 Apr 2019 04:12:52 -0700
Date:   Wed, 24 Apr 2019 04:12:52 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Kees Cook <tipbot@zytor.com>
Message-ID: <tip-392bef709659abea614abfe53cf228e7a59876a4@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, bp@suse.de, mingo@kernel.org,
        hpa@zytor.com, keescook@chromium.org, samitolvanen@google.com,
        tglx@linutronix.de, peterz@infradead.org,
        torvalds@linux-foundation.org
Reply-To: peterz@infradead.org, torvalds@linux-foundation.org, bp@suse.de,
          linux-kernel@vger.kernel.org, tglx@linutronix.de,
          samitolvanen@google.com, keescook@chromium.org, hpa@zytor.com,
          mingo@kernel.org
In-Reply-To: <20190423183827.GA4012@beast>
References: <20190423183827.GA4012@beast>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/mm] x86/build: Move _etext to actual end of .text
Git-Commit-ID: 392bef709659abea614abfe53cf228e7a59876a4
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

Commit-ID:  392bef709659abea614abfe53cf228e7a59876a4
Gitweb:     https://git.kernel.org/tip/392bef709659abea614abfe53cf228e7a59876a4
Author:     Kees Cook <keescook@chromium.org>
AuthorDate: Tue, 23 Apr 2019 11:38:27 -0700
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Wed, 24 Apr 2019 12:27:47 +0200

x86/build: Move _etext to actual end of .text

When building x86 with Clang LTO and CFI, CFI jump regions are
automatically added to the end of the .text section late in linking. As a
result, the _etext position was being labelled before the appended jump
regions, causing confusion about where the boundaries of the executable
region actually are in the running kernel, and broke at least the fault
injection code. This moves the _etext mark to outside (and immediately
after) the .text area, as it already the case on other architectures
(e.g. arm64, arm).

Reported-and-tested-by: Sami Tolvanen <samitolvanen@google.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
Cc: Borislav Petkov <bp@suse.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/20190423183827.GA4012@beast
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/kernel/vmlinux.lds.S | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index bad8c51fee6e..de94da2366e7 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -141,11 +141,11 @@ SECTIONS
 		*(.text.__x86.indirect_thunk)
 		__indirect_thunk_end = .;
 #endif
-
-		/* End of text section */
-		_etext = .;
 	} :text = 0x9090
 
+	/* End of text section */
+	_etext = .;
+
 	NOTES :text :note
 
 	EXCEPTION_TABLE(16) :text = 0x9090
