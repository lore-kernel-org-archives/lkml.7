Return-Path: <SRS0=tJqY=VY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E17CC7618F
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jul 2019 03:01:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 393F72077C
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jul 2019 03:01:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="WHk1dk/G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727630AbfG0DBg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 23:01:36 -0400
Received: from conuserg-11.nifty.com ([210.131.2.78]:53478 "EHLO
        conuserg-11.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726184AbfG0DBg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 23:01:36 -0400
Received: from grover.flets-west.jp (softbank126026094249.bbtec.net [126.26.94.249]) (authenticated)
        by conuserg-11.nifty.com with ESMTP id x6R31DYB001215;
        Sat, 27 Jul 2019 12:01:13 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com x6R31DYB001215
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1564196474;
        bh=UNyfgzuhf7SSHm0jA4hur0Fz0ys04Oa0KDkTYVtSEDc=;
        h=From:To:Cc:Subject:Date:From;
        b=WHk1dk/GTv4oJrrpZoJeX5dy1YFcWYpAJW1ulCm0lYFF8toiGwx+fPiC5jqVv834j
         4GeuXH2BvQBaV1i0Xf9HWctpmJA+ZdHnJ5sNNQ+LgVXSEZ7jomflqtnLaBrvb2BOs9
         iveJyyMnWFKSe8hrfLHQz0ifZ/OZZFFVF65J+pjzPIfNmDHCiBf4K0+oPX28iiGiNp
         Z30nvzUK84jxzruInW/odLhB3q/axhMHBRD4OnKGSk/ZBbm+KHrkeWcFCEQhHJvHCy
         8WjknL9NDZsW5qgaTrBsfWYBBbdKU3+1AwCxI+vdkjR2f1JdkYi0KZgEYZd5M55k9F
         41s8UotmvEvPA==
X-Nifty-SrcIP: [126.26.94.249]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Tom Roeder <tmroeder@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] gen_compile_commands: lower the entry count threshold
Date:   Sat, 27 Jul 2019 12:01:10 +0900
Message-Id: <20190727030110.17208-1-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Running gen_compile_commands.py after building with allnoconfig
gave this:

$ ./scripts/gen_compile_commands.py
WARNING: Found 449 entries. Have you compiled the kernel?

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 scripts/gen_compile_commands.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/scripts/gen_compile_commands.py b/scripts/gen_compile_commands.py
index 7915823b92a5..c458696ef3a7 100755
--- a/scripts/gen_compile_commands.py
+++ b/scripts/gen_compile_commands.py
@@ -21,9 +21,9 @@ _LINE_PATTERN = r'^cmd_[^ ]*\.o := (.* )([^ ]*\.c)$'
 _VALID_LOG_LEVELS = ['DEBUG', 'INFO', 'WARNING', 'ERROR', 'CRITICAL']
 
 # A kernel build generally has over 2000 entries in its compile_commands.json
-# database. If this code finds 500 or fewer, then warn the user that they might
+# database. If this code finds 300 or fewer, then warn the user that they might
 # not have all the .cmd files, and they might need to compile the kernel.
-_LOW_COUNT_THRESHOLD = 500
+_LOW_COUNT_THRESHOLD = 300
 
 
 def parse_arguments():
-- 
2.17.1

