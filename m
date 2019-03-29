Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABF0EC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 06:46:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8689E2082F
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 06:46:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728799AbfC2Gqj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 02:46:39 -0400
Received: from terminus.zytor.com ([198.137.202.136]:41349 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728720AbfC2Gqi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 02:46:38 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x2T6kOYK3663219
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 28 Mar 2019 23:46:24 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x2T6kO0c3663216;
        Thu, 28 Mar 2019 23:46:24 -0700
Date:   Thu, 28 Mar 2019 23:46:24 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Ard Biesheuvel <tipbot@zytor.com>
Message-ID: <tip-02562d0ca1084a688ac5c92e0e92947f62f13093@git.kernel.org>
Cc:     mingo@kernel.org, ard.biesheuvel@linaro.org,
        matt@codeblueprint.co.uk, torvalds@linux-foundation.org,
        peterz@infradead.org, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, hpa@zytor.com,
        ndesaulniers@google.com
Reply-To: ndesaulniers@google.com, hpa@zytor.com, tglx@linutronix.de,
          linux-kernel@vger.kernel.org, peterz@infradead.org,
          mingo@kernel.org, ard.biesheuvel@linaro.org,
          matt@codeblueprint.co.uk, torvalds@linux-foundation.org
In-Reply-To: <20190328193429.21373-6-ard.biesheuvel@linaro.org>
References: <20190328193429.21373-6-ard.biesheuvel@linaro.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:efi/core] efi/libstub/arm: Omit unneeded stripping of
 ksymtab/kcrctab sections
Git-Commit-ID: 02562d0ca1084a688ac5c92e0e92947f62f13093
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

Commit-ID:  02562d0ca1084a688ac5c92e0e92947f62f13093
Gitweb:     https://git.kernel.org/tip/02562d0ca1084a688ac5c92e0e92947f62f13093
Author:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
AuthorDate: Thu, 28 Mar 2019 20:34:29 +0100
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Fri, 29 Mar 2019 07:35:00 +0100

efi/libstub/arm: Omit unneeded stripping of ksymtab/kcrctab sections

Commit f922c4abdf764 ("module: allow symbol exports to be disabled")
introduced a way to inhibit generation of kcrctab/ksymtab sections
when building ordinary kernel code to be used in a different execution
context (decompressor, EFI stub, etc)

That means we no longer have to strip those sections explicitly when
building the EFI libstub objects, so drop this from the Makefile.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Matt Fleming <matt@codeblueprint.co.uk>
Cc: Nick Desaulniers <ndesaulniers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-efi@vger.kernel.org
Link: http://lkml.kernel.org/r/20190328193429.21373-6-ard.biesheuvel@linaro.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 drivers/firmware/efi/libstub/Makefile | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
index ae9081988c88..b1f7b64652db 100644
--- a/drivers/firmware/efi/libstub/Makefile
+++ b/drivers/firmware/efi/libstub/Makefile
@@ -71,7 +71,6 @@ CFLAGS_arm64-stub.o		:= -DTEXT_OFFSET=$(TEXT_OFFSET)
 extra-$(CONFIG_EFI_ARMSTUB)	:= $(lib-y)
 lib-$(CONFIG_EFI_ARMSTUB)	:= $(patsubst %.o,%.stub.o,$(lib-y))
 
-STUBCOPY_RM-y			:= -R *ksymtab* -R *kcrctab*
 STUBCOPY_FLAGS-$(CONFIG_ARM64)	+= --prefix-alloc-sections=.init \
 				   --prefix-symbols=__efistub_
 STUBCOPY_RELOC-$(CONFIG_ARM64)	:= R_AARCH64_ABS
@@ -87,7 +86,7 @@ $(obj)/%.stub.o: $(obj)/%.o FORCE
 #
 quiet_cmd_stubcopy = STUBCPY $@
       cmd_stubcopy =							\
-	$(STRIP) --strip-debug $(STUBCOPY_RM-y) -o $@ $<;		\
+	$(STRIP) --strip-debug -o $@ $<;				\
 	if $(OBJDUMP) -r $@ | grep $(STUBCOPY_RELOC-y); then		\
 		echo "$@: absolute symbol references not allowed in the EFI stub" >&2; \
 		/bin/false;						\
