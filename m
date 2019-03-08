Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0053C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 05:50:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 907B920684
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 05:50:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="fPJwF0aE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726364AbfCHFur (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 00:50:47 -0500
Received: from conuserg-09.nifty.com ([210.131.2.76]:49044 "EHLO
        conuserg-09.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725497AbfCHFuq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 00:50:46 -0500
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-09.nifty.com with ESMTP id x285nUI8008836;
        Fri, 8 Mar 2019 14:49:31 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com x285nUI8008836
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1552024171;
        bh=WPaR9mGQS3i/ZN6TFjOnpo4V/zOzzCAsMlMHCSy8VCE=;
        h=From:To:Cc:Subject:Date:From;
        b=fPJwF0aE65pNop3N6PFh+ozSJJEeBIXH0wzTvqq2nkXUT15t/CRbFPKKDzGNnsj4R
         bRzxzF4cCiKkUjRV+s3U7LJoomhjJ6T1BT7byLODIAjXuFZtZTta0AkXQ0ZL9kjRBm
         oriy1lxxANKhqRZeYdm4gQp7ul8bNnClr0ozHWJsQZF/k82GImNxjbd/Dyf/66GLFZ
         ROiW/XWWxNqN62bpu0OUD2U7hvI0vZtrVjiNcZkdqNif5dPQ2wocBxIHS5/v8N9M07
         SdBKsqSKPAtz4ZnK69eN1ivnY2kYblL8OxRtsDOCYbp00KWR0x2DLNFqmeGyTjpohM
         lnK5H6ftCqe0g==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Michael Forney <forney@google.com>,
        Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org,
        Palmer Dabbelt <palmer@sifive.com>,
        Nicolas Pitre <nicolas.pitre@linaro.org>
Subject: [PATCH] kbuild: source include/config/auto.conf instead of ${KCONFIG_CONFIG}
Date:   Fri,  8 Mar 2019 14:49:10 +0900
Message-Id: <1552024150-9831-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As commit 423a8155facf ("kbuild: Fix reading of .config in
link-vmlinux.sh") addressed, some shells fail to perform '.' if
${KCONFIG_CONFIG} does not contain a slash at all.

Instead, we can source include/config/auto.conf, which obviously
contain slashes, and we do not expect its file path overridden by
a user. Perhaps, the performance might be slightly better since
unset CONFIG options are stripped from include/config/auto.conf.

scripts/setlocalversion already works this way.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 scripts/adjust_autoksyms.sh | 9 +--------
 scripts/link-vmlinux.sh     | 9 +--------
 2 files changed, 2 insertions(+), 16 deletions(-)

diff --git a/scripts/adjust_autoksyms.sh b/scripts/adjust_autoksyms.sh
index 6e6d639..84bf6b5 100755
--- a/scripts/adjust_autoksyms.sh
+++ b/scripts/adjust_autoksyms.sh
@@ -39,14 +39,7 @@ case "$KBUILD_VERBOSE" in
 esac
 
 # We need access to CONFIG_ symbols
-case "${KCONFIG_CONFIG}" in
-*/*)
-	. "${KCONFIG_CONFIG}"
-	;;
-*)
-	# Force using a file from the current directory
-	. "./${KCONFIG_CONFIG}"
-esac
+. include/config/auto.conf
 
 # Generate a new ksym list file with symbols needed by the current
 # set of modules.
diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
index bc7f1fc..dc0e8c5 100755
--- a/scripts/link-vmlinux.sh
+++ b/scripts/link-vmlinux.sh
@@ -171,14 +171,7 @@ if [ "$1" = "clean" ]; then
 fi
 
 # We need access to CONFIG_ symbols
-case "${KCONFIG_CONFIG}" in
-*/*)
-	. "${KCONFIG_CONFIG}"
-	;;
-*)
-	# Force using a file from the current directory
-	. "./${KCONFIG_CONFIG}"
-esac
+. include/config/auto.conf
 
 # Update version
 info GEN .version
-- 
2.7.4

