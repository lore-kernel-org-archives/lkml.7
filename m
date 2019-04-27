Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B8CAC43219
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 06:24:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D17552087C
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 06:24:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="GXXOX8kG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726191AbfD0GYv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 02:24:51 -0400
Received: from conuserg-12.nifty.com ([210.131.2.79]:60922 "EHLO
        conuserg-12.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725966AbfD0GYv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 02:24:51 -0400
Received: from grover.flets-west.jp (softbank126125154137.bbtec.net [126.125.154.137]) (authenticated)
        by conuserg-12.nifty.com with ESMTP id x3R6OCps017956;
        Sat, 27 Apr 2019 15:24:12 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com x3R6OCps017956
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1556346253;
        bh=vL1Bf+spcHyBGtHPjmjcDXjku/vXN2a3uQCvr5j1ra4=;
        h=From:To:Cc:Subject:Date:From;
        b=GXXOX8kGpTUYL9RzlNG/2ComWmUxYKKMeNjNFvP+xu3MNLKPMadjUOZcsjaUc43nr
         1nb6UrhLYY3e2UeMpXtZ3Uc5H7LyawwiLi9hk/dMxuyJvr8URTg3A3EO3HZDPFsC/2
         Kck+9rNricvrcySCvPfuJs/jyuNEjDl5gI+ndkv8aA+r84OXB9wKnnjNmvezFbbrLY
         Iob1BnCUWWWtoluz9OtSUbUshRfPXL5xoJw81pLhAVr1C79fvO6ajdL3AyqPupu8Xc
         qHUeJhBjt4gLapjU7pwnPXz8JrC6E2aDtAwCxrxONPWp7sWQHuimRzXow0KyYKEJDr
         9oCpRzBCzrWCw==
X-Nifty-SrcIP: [126.125.154.137]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     Olaf Weber <olaf@sgi.com>,
        Gabriel Krisman Bertazi <krisman@collabora.co.uk>,
        "Theodore Ts'o" <tytso@mit.edu>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        linux-doc@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH] unicode: refactor the rule for regenerating utf8data.h
Date:   Sat, 27 Apr 2019 15:24:01 +0900
Message-Id: <1556346241-10451-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

scripts/mkutf8data is used only when regenerating utf8data.h,
which never happens in the normal kernel build. However, it is
irrespectively built if CONFIG_UNICODE is enabled.

Moreover, there is no good reason for it to reside in the scripts/
directory since it is only used in fs/unicode/.

Hence, move it from scripts/ to fs/unicode/.

In some cases, we bypass build artifacts in the normal build. The
conventianl way to do so is to surround the code with ifdef REGENERATE_*.

For example,

 - 7373f4f83c71 ("kbuild: add implicit rules for parser generation")
 - 6aaf49b495b4 ("crypto: arm,arm64 - Fix random regeneration of S_shipped")

I rewrote the rule in a more kbuild'ish style.

It works like this:

$ make REGENERATE_UTF8DATA=1 fs/unicode/
  [ snip ]
  HOSTCC  fs/unicode/mkutf8data
  GEN     fs/unicode/utf8data.h
  CC      fs/unicode/utf8-norm.o
  CC      fs/unicode/utf8-core.o
  AR      fs/unicode/built-in.a

Also, I added utf8data.h to .gitignore and dontdiff.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 Documentation/dontdiff               |  1 +
 fs/unicode/.gitignore                |  1 +
 fs/unicode/Makefile                  | 37 +++++++++++++++++++++++++-----------
 fs/unicode/README.utf8data           | 10 +++++-----
 {scripts => fs/unicode}/mkutf8data.c |  0
 scripts/Makefile                     |  1 -
 6 files changed, 33 insertions(+), 17 deletions(-)
 create mode 100644 fs/unicode/.gitignore
 rename {scripts => fs/unicode}/mkutf8data.c (100%)

diff --git a/Documentation/dontdiff b/Documentation/dontdiff
index ef25a06..bc353ad 100644
--- a/Documentation/dontdiff
+++ b/Documentation/dontdiff
@@ -176,6 +176,7 @@ mkprep
 mkregtable
 mktables
 mktree
+mkutf8data
 modpost
 modules.builtin
 modules.order
diff --git a/fs/unicode/.gitignore b/fs/unicode/.gitignore
new file mode 100644
index 0000000..44811fc
--- /dev/null
+++ b/fs/unicode/.gitignore
@@ -0,0 +1 @@
+mkutf8data
diff --git a/fs/unicode/Makefile b/fs/unicode/Makefile
index 671d31f..1a109b7 100644
--- a/fs/unicode/Makefile
+++ b/fs/unicode/Makefile
@@ -5,15 +5,30 @@ obj-$(CONFIG_UNICODE_NORMALIZATION_SELFTEST) += utf8-selftest.o
 
 unicode-y := utf8-norm.o utf8-core.o
 
-# This rule is not invoked during the kernel compilation.  It is used to
-# regenerate the utf8data.h header file.
-utf8data.h.new: *.txt $(objdir)/scripts/mkutf8data
-	$(objdir)/scripts/mkutf8data \
-		-a DerivedAge.txt \
-		-c DerivedCombiningClass.txt \
-		-p DerivedCoreProperties.txt \
-		-d UnicodeData.txt \
-		-f CaseFolding.txt \
-		-n NormalizationCorrections.txt \
-		-t NormalizationTest.txt \
+
+# To regenerate utf8data.h, run the following in the top directory:
+#   $ make REGENERATE_UTF8DATA=1 fs/unicode/
+ifdef REGENERATE_UTF8DATA
+
+$(obj)/utf8-norm.o: $(obj)/utf8data.h
+
+quiet_cmd_utf8data = GEN     $@
+      cmd_utf8data = $(obj)/mkutf8data \
+		-a $(src)/DerivedAge.txt \
+		-c $(src)/DerivedCombiningClass.txt \
+		-p $(src)/DerivedCoreProperties.txt \
+		-d $(src)/UnicodeData.txt \
+		-f $(src)/CaseFolding.txt \
+		-n $(src)/NormalizationCorrections.txt \
+		-t $(src)/NormalizationTest.txt \
 		-o $@
+
+$(obj)/utf8data.h: $(filter %.txt, $(cmd_utf8data)) $(obj)/mkutf8data FORCE
+	$(call if_changed,utf8data)
+
+always += utf8data.h
+no-clean-files += utf8data.h
+
+endif
+
+hostprogs-y += mkutf8data
diff --git a/fs/unicode/README.utf8data b/fs/unicode/README.utf8data
index eeb7561..155d56e 100644
--- a/fs/unicode/README.utf8data
+++ b/fs/unicode/README.utf8data
@@ -41,15 +41,15 @@ released version of the UCD can be found here:
 
   http://www.unicode.org/Public/UCD/latest/
 
-To build the utf8data.h file, from a kernel tree that has been built,
-cd to this directory (fs/unicode) and run this command:
+To regenerate utf8data.h in the build process, pass REGENERATE_UTF8DATA=1
+from the command line. The easiest command to update it is this:
 
-	make C=../.. objdir=../.. utf8data.h.new
+	make REGENERATE_UTF8DATA=1 fs/unicode/
 
-After sanity checking the newly generated utf8data.h.new file (the
+After sanity checking the newly generated utf8data.h file (the
 version generated from the 12.1.0 UCD should be 4,109 lines long, and
 have a total size of 324k) and/or comparing it with the older version
-of utf8data.h, rename it to utf8data.h.
+of utf8data.h, check it in.
 
 If you are a kernel developer updating to a newer version of the
 Unicode Character Database, please update this README.utf8data file
diff --git a/scripts/mkutf8data.c b/fs/unicode/mkutf8data.c
similarity index 100%
rename from scripts/mkutf8data.c
rename to fs/unicode/mkutf8data.c
diff --git a/scripts/Makefile b/scripts/Makefile
index b87e3e0..9d442ee 100644
--- a/scripts/Makefile
+++ b/scripts/Makefile
@@ -20,7 +20,6 @@ hostprogs-$(CONFIG_ASN1)	 += asn1_compiler
 hostprogs-$(CONFIG_MODULE_SIG)	 += sign-file
 hostprogs-$(CONFIG_SYSTEM_TRUSTED_KEYRING) += extract-cert
 hostprogs-$(CONFIG_SYSTEM_EXTRA_CERTIFICATE) += insert-sys-cert
-hostprogs-$(CONFIG_UNICODE) += mkutf8data
 
 HOSTCFLAGS_sortextable.o = -I$(srctree)/tools/include
 HOSTCFLAGS_asn1_compiler.o = -I$(srctree)/include
-- 
2.7.4

