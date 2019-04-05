Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A145CC4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 10:40:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A23421738
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 10:40:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730726AbfDEKkh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 06:40:37 -0400
Received: from terminus.zytor.com ([198.137.202.136]:44353 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730283AbfDEKkh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 06:40:37 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x35AeIaV2716343
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 5 Apr 2019 03:40:18 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x35AeIcH2716340;
        Fri, 5 Apr 2019 03:40:18 -0700
Date:   Fri, 5 Apr 2019 03:40:18 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Kees Cook <tipbot@zytor.com>
Message-ID: <tip-7c21383f3429dd70da39c0c7f1efa12377a47ab6@git.kernel.org>
Cc:     mingo@redhat.com, keescook@chromium.org, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, x86@kernel.org, mingo@kernel.org,
        hpa@zytor.com, bp@suse.de, ndesaulniers@google.com
Reply-To: linux-kernel@vger.kernel.org, x86@kernel.org, mingo@kernel.org,
          hpa@zytor.com, mingo@redhat.com, tglx@linutronix.de,
          keescook@chromium.org, bp@suse.de, ndesaulniers@google.com
In-Reply-To: <20190404214027.GA7324@beast>
References: <20190404214027.GA7324@beast>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/build] x86/build: Keep local relocations with ld.lld
Git-Commit-ID: 7c21383f3429dd70da39c0c7f1efa12377a47ab6
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

Commit-ID:  7c21383f3429dd70da39c0c7f1efa12377a47ab6
Gitweb:     https://git.kernel.org/tip/7c21383f3429dd70da39c0c7f1efa12377a47ab6
Author:     Kees Cook <keescook@chromium.org>
AuthorDate: Thu, 4 Apr 2019 14:40:27 -0700
Committer:  Borislav Petkov <bp@suse.de>
CommitDate: Fri, 5 Apr 2019 12:34:35 +0200

x86/build: Keep local relocations with ld.lld

The LLVM linker (ld.lld) defaults to removing local relocations, which
causes KASLR boot failures. ld.bfd and ld.gold already handle this
correctly. This adds the explicit instruction "--discard-none" during
the link phase. There is no change in output for ld.bfd and ld.gold,
but ld.lld now produces an image with all the needed relocations.

Signed-off-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Nick Desaulniers <ndesaulniers@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: clang-built-linux@googlegroups.com
Cc: x86-ml <x86@kernel.org>
Link: https://lkml.kernel.org/r/20190404214027.GA7324@beast
Link: https://github.com/ClangBuiltLinux/linux/issues/404
---
 arch/x86/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/Makefile b/arch/x86/Makefile
index a587805c6687..56e748a7679f 100644
--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -47,7 +47,7 @@ export REALMODE_CFLAGS
 export BITS
 
 ifdef CONFIG_X86_NEED_RELOCS
-        LDFLAGS_vmlinux := --emit-relocs
+        LDFLAGS_vmlinux := --emit-relocs --discard-none
 endif
 
 #
