Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 997B8C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 07:10:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6430C218AE
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 07:10:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="2d9PP7OB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731831AbfCAHK6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 02:10:58 -0500
Received: from conuserg-10.nifty.com ([210.131.2.77]:16717 "EHLO
        conuserg-10.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726036AbfCAHKy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 02:10:54 -0500
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-10.nifty.com with ESMTP id x217APwt017759;
        Fri, 1 Mar 2019 16:10:26 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com x217APwt017759
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1551424226;
        bh=C0sHvPANucd8+RgfELTY1HPKylG28HrnpVhzUAgdkk0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2d9PP7OBoHFTitYH2UMIfMvNNqNPknytSM9VQng+F2Gmc1kx8uGd03p+jQ8t3EQDK
         lZ46v3lDLI2ifd3Hzt4XuXQAZ/lzXtlIZhVX5JLPUrtxvBI1s0bvfS3An1j/pMvaEn
         v+oq5IVsZJulIm3lzfU+PYW8WMOXiCnI4IkWJxIOykzmlRgFyoyPxtiPVCjDzAJhuH
         tVUF1ILoQxhdsVEuZcFqvHdmCi3X7OKtfQOm9pqqn/W46WQQ5b8PFp+3mU3vpqCXzR
         bsKArSqls5lTrTRnJ8qSndTHLqMChD4Y5Dt+LB7JEmcVafb9wQWZHOVfQbS1p36Cx8
         VFbVeyk7OJdIg==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] kbuild: clean up scripts/gcc-version.sh
Date:   Fri,  1 Mar 2019 16:10:22 +0900
Message-Id: <1551424222-3727-3-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1551424222-3727-1-git-send-email-yamada.masahiro@socionext.com>
References: <1551424222-3727-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that the Kconfig is the only user of this script, we can drop
unneeded code.

Remove the -p option, and stop prepending the output with zero,
so that Kconfig can directly use the output from this script.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 init/Kconfig            |  2 +-
 scripts/Kconfig.include |  2 +-
 scripts/gcc-version.sh  | 27 +++++++--------------------
 3 files changed, 9 insertions(+), 22 deletions(-)

diff --git a/init/Kconfig b/init/Kconfig
index 1f05a88..74a0217 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -13,7 +13,7 @@ config CC_IS_GCC
 
 config GCC_VERSION
 	int
-	default $(shell,$(srctree)/scripts/gcc-version.sh -p $(CC) | sed 's/^0*//') if CC_IS_GCC
+	default $(shell,$(srctree)/scripts/gcc-version.sh $(CC)) if CC_IS_GCC
 	default 0
 
 config CC_IS_CLANG
diff --git a/scripts/Kconfig.include b/scripts/Kconfig.include
index dad5583..87ff1dc 100644
--- a/scripts/Kconfig.include
+++ b/scripts/Kconfig.include
@@ -27,4 +27,4 @@ cc-option = $(success,$(CC) -Werror $(1) -E -x c /dev/null -o /dev/null)
 ld-option = $(success,$(LD) -v $(1))
 
 # gcc version including patch level
-gcc-version := $(shell,$(srctree)/scripts/gcc-version.sh -p $(CC) | sed 's/^0*//')
+gcc-version := $(shell,$(srctree)/scripts/gcc-version.sh $(CC))
diff --git a/scripts/gcc-version.sh b/scripts/gcc-version.sh
index 11bb909..ae35343 100755
--- a/scripts/gcc-version.sh
+++ b/scripts/gcc-version.sh
@@ -1,33 +1,20 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
 #
-# gcc-version [-p] gcc-command
-#
-# Prints the gcc version of `gcc-command' in a canonical 4-digit form
-# such as `0295' for gcc-2.95, `0303' for gcc-3.3, etc.
-#
-# With the -p option, prints the patchlevel as well, for example `029503' for
-# gcc-2.95.3, `030301' for gcc-3.3.1, etc.
+# gcc-version gcc-command
 #
-
-if [ "$1" = "-p" ] ; then
-	with_patchlevel=1;
-	shift;
-fi
+# Print the gcc version of `gcc-command' in a 5 or 6-digit form
+# such as `29503' for gcc-2.95.3, `30301' for gcc-3.3.1, etc.
 
 compiler="$*"
 
 if [ ${#compiler} -eq 0 ]; then
-	echo "Error: No compiler specified."
-	printf "Usage:\n\t$0 <gcc-command>\n"
+	echo "Error: No compiler specified." >&2
+	printf "Usage:\n\t$0 <gcc-command>\n" >&2
 	exit 1
 fi
 
 MAJOR=$(echo __GNUC__ | $compiler -E -x c - | tail -n 1)
 MINOR=$(echo __GNUC_MINOR__ | $compiler -E -x c - | tail -n 1)
-if [ "x$with_patchlevel" != "x" ] ; then
-	PATCHLEVEL=$(echo __GNUC_PATCHLEVEL__ | $compiler -E -x c - | tail -n 1)
-	printf "%02d%02d%02d\\n" $MAJOR $MINOR $PATCHLEVEL
-else
-	printf "%02d%02d\\n" $MAJOR $MINOR
-fi
+PATCHLEVEL=$(echo __GNUC_PATCHLEVEL__ | $compiler -E -x c - | tail -n 1)
+printf "%d%02d%02d\\n" $MAJOR $MINOR $PATCHLEVEL
-- 
2.7.4

