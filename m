Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF65EC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 06:43:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B230C20811
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 06:43:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728767AbfC2Gns (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 02:43:48 -0400
Received: from terminus.zytor.com ([198.137.202.136]:39719 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728676AbfC2Gnr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 02:43:47 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x2T6hQP73661241
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 28 Mar 2019 23:43:26 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x2T6hOZX3661238;
        Thu, 28 Mar 2019 23:43:24 -0700
Date:   Thu, 28 Mar 2019 23:43:24 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Masahiro Yamada <tipbot@zytor.com>
Message-ID: <tip-e8d368ad20f514dce86a64931fe4a6f06a0a6703@git.kernel.org>
Cc:     torvalds@linux-foundation.org, ard.biesheuvel@linaro.org,
        linux-kernel@vger.kernel.org, peterz@infradead.org,
        mingo@kernel.org, tglx@linutronix.de,
        yamada.masahiro@socionext.com, matt@codeblueprint.co.uk,
        hpa@zytor.com
Reply-To: peterz@infradead.org, linux-kernel@vger.kernel.org,
          ard.biesheuvel@linaro.org, torvalds@linux-foundation.org,
          hpa@zytor.com, matt@codeblueprint.co.uk, tglx@linutronix.de,
          yamada.masahiro@socionext.com, mingo@kernel.org
In-Reply-To: <20190328193429.21373-2-ard.biesheuvel@linaro.org>
References: <20190328193429.21373-2-ard.biesheuvel@linaro.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:efi/core] efi/libstub: Refactor the cmd_stubcopy Makefile
 command
Git-Commit-ID: e8d368ad20f514dce86a64931fe4a6f06a0a6703
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

Commit-ID:  e8d368ad20f514dce86a64931fe4a6f06a0a6703
Gitweb:     https://git.kernel.org/tip/e8d368ad20f514dce86a64931fe4a6f06a0a6703
Author:     Masahiro Yamada <yamada.masahiro@socionext.com>
AuthorDate: Thu, 28 Mar 2019 20:34:25 +0100
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Fri, 29 Mar 2019 07:34:59 +0100

efi/libstub: Refactor the cmd_stubcopy Makefile command

It took me a while to understand what is going on in the nested
if-blocks.

Simplify it by removing unneeded code.

  - if_changed automatically adds 'set -e', so any failure in the
    series of commands makes it immediately fail as a whole.
    So, the outer if block is entirely redundant.

  - Since commit 9c2af1c7377a ("kbuild: add .DELETE_ON_ERROR special target"),
    GNU Make automatically deletes the target on any failure
    in its recipe. The explicit 'rm -f $@' is redundant.

  - Surrounding commands with ( ) will spawn a subshell to execute them
    in it, but it is rarely useful to do so.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Matt Fleming <matt@codeblueprint.co.uk>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-efi@vger.kernel.org
Link: http://lkml.kernel.org/r/20190328193429.21373-2-ard.biesheuvel@linaro.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 drivers/firmware/efi/libstub/Makefile | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
index b0103e16fc1b..ae9081988c88 100644
--- a/drivers/firmware/efi/libstub/Makefile
+++ b/drivers/firmware/efi/libstub/Makefile
@@ -86,12 +86,13 @@ $(obj)/%.stub.o: $(obj)/%.o FORCE
 # this time, use objcopy and leave all sections in place.
 #
 quiet_cmd_stubcopy = STUBCPY $@
-      cmd_stubcopy = if $(STRIP) --strip-debug $(STUBCOPY_RM-y) -o $@ $<; \
-		     then if $(OBJDUMP) -r $@ | grep $(STUBCOPY_RELOC-y); \
-		     then (echo >&2 "$@: absolute symbol references not allowed in the EFI stub"; \
-			   rm -f $@; /bin/false);			  \
-		     else $(OBJCOPY) $(STUBCOPY_FLAGS-y) $< $@; fi	  \
-		     else /bin/false; fi
+      cmd_stubcopy =							\
+	$(STRIP) --strip-debug $(STUBCOPY_RM-y) -o $@ $<;		\
+	if $(OBJDUMP) -r $@ | grep $(STUBCOPY_RELOC-y); then		\
+		echo "$@: absolute symbol references not allowed in the EFI stub" >&2; \
+		/bin/false;						\
+	fi;								\
+	$(OBJCOPY) $(STUBCOPY_FLAGS-y) $< $@
 
 #
 # ARM discards the .data section because it disallows r/w data in the
