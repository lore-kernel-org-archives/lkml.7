Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66248C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 07:11:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EE8920851
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 07:11:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="A2BS+upC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732139AbfCAHLH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 02:11:07 -0500
Received: from conuserg-10.nifty.com ([210.131.2.77]:17147 "EHLO
        conuserg-10.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726036AbfCAHLH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 02:11:07 -0500
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-10.nifty.com with ESMTP id x217APws017759;
        Fri, 1 Mar 2019 16:10:26 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com x217APws017759
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1551424226;
        bh=ePc3zu1pq/u4/yjsicbC/fuitXjH2YJiwIfWsJXCxDg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=A2BS+upCGQVuwDAR31FfzgDjbuwt0ph2DhwutBFWobEcpXMzfpoPSJ31RsjRgO+4R
         0o8lcb+HbBfd2JdNF2hJhc6gbjKfdXEjIxqnI4MrCZd5vtM6hHT6bvPpcSbL406vAK
         Gb5PySYpZGyIhbYQDzO5WM+xt+6nqqTG29K4S51hoDgxtsazwKTkDbnXZcFkdo4M2b
         SkxvANNV1VBHW9GF3oa2Awg5w09vm85sEl8zT9XMRgAiigJKLQObYNyU+wJcAqVjkA
         VkoIgrDrG4xTyr9AEJcHxtFlxK8NFlwUIFJxzATmjlOqbs1q4gSNj/DnNhiNHQZ1jP
         tm0Xw9aQQ4HaA==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>,
        Michal Marek <michal.lkml@markovi.net>
Subject: [PATCH 2/3] kbuild: remove cc-version macro
Date:   Fri,  1 Mar 2019 16:10:21 +0900
Message-Id: <1551424222-3727-2-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1551424222-3727-1-git-send-email-yamada.masahiro@socionext.com>
References: <1551424222-3727-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no more direct user of this macro; it is only used by
cc-ifversion.

Calling this macro is not efficient since it invokes the compiler to
get the compiler version. CONFIG_GCC_VERSION is already calculated in
the Kconfig stage, so Makefile can reuse it.

Here is a note about the slight difference between cc-version and
CONFIG_GCC_VERSION:

When using Clang, cc-version is evaluated to '0402' because Clang
defines __GNUC__ and __GNUC__MINOR__, and looks like GCC 4.2 in the
version point of view. On the other hand, CONFIG_GCC_VERSION=0
when $(CC) is clang.

There are currently two users of cc-ifversion:
  arch/mips/loongson64/Platform
  arch/powerpc/Makefile

They are not affected by this change.

The format of cc-version is <major><minor>, while CONFIG_GCC_VERSION
<major><minor><patch>. I adjusted cc-ifversion for the difference of
the number of digits.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 Documentation/kbuild/makefiles.txt | 17 -----------------
 scripts/Kbuild.include             |  5 +----
 2 files changed, 1 insertion(+), 21 deletions(-)

diff --git a/Documentation/kbuild/makefiles.txt b/Documentation/kbuild/makefiles.txt
index 48eab0b..f124be6 100644
--- a/Documentation/kbuild/makefiles.txt
+++ b/Documentation/kbuild/makefiles.txt
@@ -499,23 +499,6 @@ more details, with real examples.
 	In the above example, -Wno-unused-but-set-variable will be added to
 	KBUILD_CFLAGS only if gcc really accepts it.
 
-    cc-version
-	cc-version returns a numerical version of the $(CC) compiler version.
-	The format is <major><minor> where both are two digits. So for example
-	gcc 3.41 would return 0341.
-	cc-version is useful when a specific $(CC) version is faulty in one
-	area, for example -mregparm=3 was broken in some gcc versions
-	even though the option was accepted by gcc.
-
-	Example:
-		#arch/x86/Makefile
-		cflags-y += $(shell \
-		if [ $(cc-version) -ge 0300 ] ; then \
-			echo "-mregparm=3"; fi ;)
-
-	In the above example, -mregparm=3 is only used for gcc version greater
-	than or equal to gcc 3.0.
-
     cc-ifversion
 	cc-ifversion tests the version of $(CC) and equals the fourth parameter
 	if version expression is true, or the fifth (if given) if the version
diff --git a/scripts/Kbuild.include b/scripts/Kbuild.include
index d93250b..b59983e 100644
--- a/scripts/Kbuild.include
+++ b/scripts/Kbuild.include
@@ -138,12 +138,9 @@ cc-option-yn = $(call try-run,\
 cc-disable-warning = $(call try-run,\
 	$(CC) -Werror $(KBUILD_CPPFLAGS) $(CC_OPTION_CFLAGS) -W$(strip $(1)) -c -x c /dev/null -o "$$TMP",-Wno-$(strip $(1)))
 
-# cc-version
-cc-version = $(shell $(CONFIG_SHELL) $(srctree)/scripts/gcc-version.sh $(CC))
-
 # cc-ifversion
 # Usage:  EXTRA_CFLAGS += $(call cc-ifversion, -lt, 0402, -O1)
-cc-ifversion = $(shell [ $(cc-version) $(1) $(2) ] && echo $(3) || echo $(4))
+cc-ifversion = $(shell [ $(CONFIG_GCC_VERSION)0 $(1) $(2)000 ] && echo $(3) || echo $(4))
 
 # cc-ldoption
 # Usage: ldflags += $(call cc-ldoption, -Wl$(comma)--hash-style=both)
-- 
2.7.4

