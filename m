Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E43A4C04AB1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 07:36:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7D76216C4
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 07:36:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="cpV4dHle"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726650AbfEIHg3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 03:36:29 -0400
Received: from conuserg-11.nifty.com ([210.131.2.78]:29879 "EHLO
        conuserg-11.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725940AbfEIHg3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 03:36:29 -0400
Received: from localhost.localdomain (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-11.nifty.com with ESMTP id x497a876027332;
        Thu, 9 May 2019 16:36:08 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com x497a876027332
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1557387369;
        bh=WvsKxYjmrZ0o9zogyEYzJJvBoltHq2gquWxe1gHwrUc=;
        h=From:To:Cc:Subject:Date:From;
        b=cpV4dHleODex4lgIfIxVwNfYJJEtBo43pLaA/Q9t8GWvQgeRihIoS6kAxsi11IX2V
         aBvELu+ReG0iOkTZ/PORlvSmyGKDkn+B6HUbcLUl9Iui6BHLKeY1KnyFHDXprvEbmC
         tDh1MGztCrDKncS4JnDqhaO3jP9G1s4A0n0VobzIR0CKa9AT+QT9WoNvUmN+S68yu4
         /ap3fmIkrs4oioU2uRgpfGnhLdmw578XbsNwY2ZJFYDkCsXgr2dWizSIsz9z1Oy0GM
         A6BGU2TiCQ3IDcZ7I+E5y6U8w1HL7SD9JZmDjwI4VDhLNPPKkvKm92a7P1jVDdJ7f1
         7+0fsu/TDbLIA==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Joel Stanley <joel@jms.id.au>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] kbuild: terminate Kconfig when $(CC) or $(LD) is missing
Date:   Thu,  9 May 2019 16:35:55 +0900
Message-Id: <20190509073555.15545-1-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the compiler specified by $(CC) is not present, the Kconfig stage
sprinkles 'not found' messages, then succeeds.

  $ make CROSS_COMPILE=foo defconfig
  /bin/sh: 1: foogcc: not found
  /bin/sh: 1: foogcc: not found
  *** Default configuration is based on 'x86_64_defconfig'
  ./scripts/gcc-version.sh: 17: ./scripts/gcc-version.sh: foogcc: not found
  ./scripts/gcc-version.sh: 18: ./scripts/gcc-version.sh: foogcc: not found
  ./scripts/gcc-version.sh: 19: ./scripts/gcc-version.sh: foogcc: not found
  ./scripts/gcc-version.sh: 17: ./scripts/gcc-version.sh: foogcc: not found
  ./scripts/gcc-version.sh: 18: ./scripts/gcc-version.sh: foogcc: not found
  ./scripts/gcc-version.sh: 19: ./scripts/gcc-version.sh: foogcc: not found
  ./scripts/clang-version.sh: 11: ./scripts/clang-version.sh: foogcc: not found
  ./scripts/gcc-plugin.sh: 11: ./scripts/gcc-plugin.sh: foogcc: not found
  init/Kconfig:16:warning: 'GCC_VERSION': number is invalid
  #
  # configuration written to .config
  #

Terminate parsing files immediately if $(CC) or $(LD) is not found.
"make *config" will fail more nicely.

  $ make CROSS_COMPILE=foo defconfig
  *** Default configuration is based on 'x86_64_defconfig'
  scripts/Kconfig.include:34: compiler 'foogcc' not found
  make[1]: *** [scripts/kconfig/Makefile;82: defconfig] Error 1
  make: *** [Makefile;557: defconfig] Error 2

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 Makefile                | 2 +-
 scripts/Kconfig.include | 8 ++++++++
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 28965187c528..bd7ae11947cb 100644
--- a/Makefile
+++ b/Makefile
@@ -537,7 +537,7 @@ endif
 # Some architectures define CROSS_COMPILE in arch/$(SRCARCH)/Makefile.
 # CC_VERSION_TEXT is referenced from Kconfig (so it needs export),
 # and from include/config/auto.conf.cmd to detect the compiler upgrade.
-CC_VERSION_TEXT = $(shell $(CC) --version | head -n 1)
+CC_VERSION_TEXT = $(shell $(CC) --version 2>/dev/null | head -n 1)
 
 ifeq ($(config-targets),1)
 # ===========================================================================
diff --git a/scripts/Kconfig.include b/scripts/Kconfig.include
index 87ff1dcc6bd5..0b267fb27f07 100644
--- a/scripts/Kconfig.include
+++ b/scripts/Kconfig.include
@@ -18,6 +18,10 @@ if-success = $(shell,{ $(1); } >/dev/null 2>&1 && echo "$(2)" || echo "$(3)")
 # Return y if <command> exits with 0, n otherwise
 success = $(if-success,$(1),y,n)
 
+# $(failure,<command>)
+# Return n if <command> exits with 0, y otherwise
+failure = $(if-success,$(1),n,y)
+
 # $(cc-option,<flag>)
 # Return y if the compiler supports <flag>, n otherwise
 cc-option = $(success,$(CC) -Werror $(1) -E -x c /dev/null -o /dev/null)
@@ -26,5 +30,9 @@ cc-option = $(success,$(CC) -Werror $(1) -E -x c /dev/null -o /dev/null)
 # Return y if the linker supports <flag>, n otherwise
 ld-option = $(success,$(LD) -v $(1))
 
+# check if $(CC) and $(LD) exist
+$(error-if,$(failure,command -v $(CC)),compiler '$(CC)' not found)
+$(error-if,$(failure,command -v $(LD)),linker '$(LD)' not found)
+
 # gcc version including patch level
 gcc-version := $(shell,$(srctree)/scripts/gcc-version.sh $(CC))
-- 
2.17.1

