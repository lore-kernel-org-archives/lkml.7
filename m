Return-Path: <SRS0=/nvU=VK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3D8CC742D2
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jul 2019 02:46:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A27AD208E4
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jul 2019 02:46:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="Uoy5OCgu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727601AbfGMCqX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jul 2019 22:46:23 -0400
Received: from conuserg-09.nifty.com ([210.131.2.76]:42311 "EHLO
        conuserg-09.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727393AbfGMCqX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 22:46:23 -0400
Received: from grover.flets-west.jp (softbank126026094249.bbtec.net [126.26.94.249]) (authenticated)
        by conuserg-09.nifty.com with ESMTP id x6D2k2fQ024877;
        Sat, 13 Jul 2019 11:46:02 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com x6D2k2fQ024877
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1562985962;
        bh=1ltkFVFaR9C7ymTKN/tBQ9NH1ZD80tQaVTmMpR2IObA=;
        h=From:To:Cc:Subject:Date:From;
        b=Uoy5OCgubLkhqdKWlvjeTwR59Z+FgqEYQvR9vYET4KOh1yySyLdVHhDdNUSbfGwL8
         G0xHndeCYpJC4ji0VgGBp768I8UjLny+69uccT2VQC+cjFfi1OdcXLvzLGVy4nb3uc
         fBpJSiRQjZOo71NUXfFwywEFV6zto0GYP2799iIngCPw/qFiuB3hWpe5vhM+s3hqQ/
         LQeb+6jX8sjxZMlLDvfALGu4XehBWToyUm8INKbK9qpM0/MAuLHaMtJLHqe9LnkV2d
         PQLfShBqJ+aAA/wD5sx7XnL5SISsB5Gb5GQKXrfAdW14RHEgZyZOSix6xEew1VSVUQ
         EwIrEibWdmXrg==
X-Nifty-SrcIP: [126.26.94.249]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3] kbuild: get rid of misleading $(AS) from documents
Date:   Sat, 13 Jul 2019 11:45:58 +0900
Message-Id: <20190713024558.27214-1-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The assembler files in the kernel are *.S instead of *.s, so they must
be preprocessed. Since 'as' of GNU binutils is not able to preprocess,
we always use $(CC) as an assembler driver.

$(AS) is almost unused in Kbuild. As of v5.2, there is just one place
that directly invokes $(AS).

  $ git grep -e '$(AS)' -e '${AS}' -e '$AS' -e '$(AS:' -e '${AS:' -- :^Documentation
  drivers/net/wan/Makefile:  AS68K = $(AS)

The documentation about *_AFLAGS* sounds like the flags were passed
to $(AS). This is somewhat misleading.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>
---

Changes in v3:
  - Rebase

Changes in v2:
  - Rephrase without using "assembling"

 Documentation/kbuild/kbuild.rst    |  5 ++---
 Documentation/kbuild/makefiles.rst | 12 ++++++------
 2 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/Documentation/kbuild/kbuild.rst b/Documentation/kbuild/kbuild.rst
index b25548963d70..727520b3d7b1 100644
--- a/Documentation/kbuild/kbuild.rst
+++ b/Documentation/kbuild/kbuild.rst
@@ -38,12 +38,11 @@ Additional options to the assembler (for built-in and modules).
 
 AFLAGS_MODULE
 -------------
-Additional module specific options to use for $(AS).
+Additional assembler options for modules.
 
 AFLAGS_KERNEL
 -------------
-Additional options for $(AS) when used for assembler
-code for code that is compiled as built-in.
+Additional assembler options for built-in.
 
 KCFLAGS
 -------
diff --git a/Documentation/kbuild/makefiles.rst b/Documentation/kbuild/makefiles.rst
index 093f2d79ab95..67e47589d9d2 100644
--- a/Documentation/kbuild/makefiles.rst
+++ b/Documentation/kbuild/makefiles.rst
@@ -328,7 +328,7 @@ more details, with real examples.
 	variable $(KBUILD_CFLAGS) and uses it for compilation flags for the
 	entire tree.
 
-	asflags-y specifies options for assembling with $(AS).
+	asflags-y specifies assembler options.
 
 	Example::
 
@@ -489,7 +489,7 @@ more details, with real examples.
 	as-instr checks if the assembler reports a specific instruction
 	and then outputs either option1 or option2
 	C escapes are supported in the test instruction
-	Note: as-instr-option uses KBUILD_AFLAGS for $(AS) options
+	Note: as-instr-option uses KBUILD_AFLAGS for assembler options
 
     cc-option
 	cc-option is used to check if $(CC) supports a given option, and if
@@ -905,7 +905,7 @@ When kbuild executes, the following steps are followed (roughly):
 	vmlinux. The usage of $(call if_changed,xxx) will be described later.
 
     KBUILD_AFLAGS
-	$(AS) assembler flags
+	Assembler flags
 
 	Default value - see top level Makefile
 	Append or modify as required per architecture.
@@ -948,16 +948,16 @@ When kbuild executes, the following steps are followed (roughly):
 	to 'y' when selected.
 
     KBUILD_AFLAGS_KERNEL
-	$(AS) options specific for built-in
+	Assembler options specific for built-in
 
 	$(KBUILD_AFLAGS_KERNEL) contains extra C compiler flags used to compile
 	resident kernel code.
 
     KBUILD_AFLAGS_MODULE
-	Options for $(AS) when building modules
+	Assembler options specific for modules
 
 	$(KBUILD_AFLAGS_MODULE) is used to add arch-specific options that
-	are used for $(AS).
+	are used for assembler.
 
 	From commandline AFLAGS_MODULE shall be used (see kbuild.txt).
 
-- 
2.17.1

