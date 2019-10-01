Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 677CFC352AA
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 12:17:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F372120700
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 12:17:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="Zf3xvtMO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387691AbfJAMRz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 08:17:55 -0400
Received: from conuserg-11.nifty.com ([210.131.2.78]:24482 "EHLO
        conuserg-11.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725821AbfJAMRy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 08:17:54 -0400
Received: from localhost.localdomain (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-11.nifty.com with ESMTP id x91CHO42014561;
        Tue, 1 Oct 2019 21:17:25 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com x91CHO42014561
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1569932245;
        bh=9hkjCrWAmYl8Hzn0M9NoT02tNI9xvkz9T7RGu9HJXvc=;
        h=From:To:Cc:Subject:Date:From;
        b=Zf3xvtMOcFMOqPb9lalb7aEUjRdygqtb2++Le+8tL3Kaq7nkVQOusOBJ8NVu0EqsT
         2n7pO1I8k6auJdH+vPDQU4XrIB9MQuHXzzTk4HaenQmd5bnWZEw4gacZKl8863tMe/
         r8tRagTROlRnbNCW3J/HmHF5Er3DLB9ylWlqs6IY9u79cRbKVQH4IN7loOS3Qo161t
         cl+1+x35XjFPETe1cNvOJBTE0JL2YaR5VyozetocY3RKG+TogOCNNXPUjx7XSbn9oz
         CgT16ihKjVklfdonOR2Hh0qMsTEUOsvvnalMZkn36aCDDAEoyJzXRoNQM2DwuGo6Ck
         mIPcyxCuc8U5Q==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kernel@vger.kernel.org
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH] scripts/setlocalversion: clear local varaible to make it work for sh
Date:   Tue,  1 Oct 2019 21:17:24 +0900
Message-Id: <20191001121724.23886-1-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Geert Uytterhoeven reports a strange side-effect of commit 858805b336be
("kbuild: add $(BASH) to run scripts with bash-extension"), which
inserts the contents of a localversion file in the build directory twice.

[Steps to Reproduce]
  $ echo bar > localversion
  $ mkdir build
  $ cd build/
  $ echo foo > localversion
  $ make -s -f ../Makefile defconfig include/config/kernel.release
  $ cat include/config/kernel.release
  5.4.0-rc1foofoobar

This comes down to the behavior change of 'local' variables.

The 'man sh' on my Ubuntu machine, where sh is an alias to dash,
explains as follows:
  When a variable is made local, it inherits the initial value and
  exported and readonly flags from the variable with the same name
  in the surrounding scope, if there is one. Otherwise, the variable
  is initially unset.

[Test Code]

  foo ()
  {
          local res
          echo "res: $res"
  }

  res=1
  foo

[Result]

  $ sh test.sh
  res: 1
  $ bash test.sh
  res:

So, scripts/setlocalversion correctly works only for bash in spite of
its hashbang being #!/bin/sh. Nobody had noticed it before because
CONFIG_SHELL was previously set to sh only when bash is missing, which
is very unlikely to happen.

The benefit of commit 858805b336be is to make people write portable and
correct code. I gave it the Fixes tag since it uncovered the issue for
most of people.

Clear the variable 'res' in collect_files() to make it work for sh
(and it also works on distributions where sh is an alias to bash).

Fixes: commit 858805b336be ("kbuild: add $(BASH) to run scripts with bash-extension")
Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 scripts/setlocalversion | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/setlocalversion b/scripts/setlocalversion
index 365b3c2b8f43..220dae0db3f1 100755
--- a/scripts/setlocalversion
+++ b/scripts/setlocalversion
@@ -126,7 +126,7 @@ scm_version()
 
 collect_files()
 {
-	local file res
+	local file res=
 
 	for file; do
 		case "$file" in
-- 
2.17.1

