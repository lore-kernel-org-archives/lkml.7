Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E977C606B0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 06:13:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9C7321537
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 06:13:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="MUCfYy4x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726108AbfGIGNO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 02:13:14 -0400
Received: from conuserg-11.nifty.com ([210.131.2.78]:42787 "EHLO
        conuserg-11.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726032AbfGIGNO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 02:13:14 -0400
Received: from localhost.localdomain (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-11.nifty.com with ESMTP id x696D2LL030773;
        Tue, 9 Jul 2019 15:13:02 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com x696D2LL030773
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1562652783;
        bh=lnTkZOWAozqElNoBWK0L63rALMGbDSyFD2Pe++T0T9Q=;
        h=From:To:Cc:Subject:Date:From;
        b=MUCfYy4xiocaxazb9OPb1wu3bZjr11ZoUaQhOL2mzlVOn0YNgKj/kI74R5A84fuOg
         OOPZHSMwYdcyJ1o7r+tvuqdoxwDB79XLIPFFB4emL6t4nawhBBRzedhxFKcbZrJsR0
         Oz6jh9syQ0ix49Z/UynsefJtrajshefVhoUaoyALBvioOiG43iTZ+qVMhr48ZSl2kj
         OU40LwLlWL+hOpLFjrjMKMGrEIoXtQ1tLEbKeK1MzVXJKcoTd4UFat8aHPbkoC4W/8
         ENQ8o9Ma+QgGDraRjXKPQ04ViJPKYqh9O27E1REWlKMaHBTkZ4FhuygZI8H8qwTJhJ
         wkwpZxXLXm8yA==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] kbuild: use -- separater intead of $(filter-out ...) for cc-cross-prefix
Date:   Tue,  9 Jul 2019 15:13:00 +0900
Message-Id: <20190709061300.527-1-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

arch/mips/Makefile passes prefixes that start with '-' to cc-cross-prefix
when $(tool-archpref) evaluates to the empty string.

They are filtered-out before the $(shell ...) invocation. Otherwise,
'command -v' would be confused.

  $ command -v -linux-gcc
  bash: command: -l: invalid option
  command: usage: command [-pVv] command [arg ...]

Since commit 913ab9780fc0 ("kbuild: use more portable 'command -v' for
cc-cross-prefix"), cc-cross-prefix throws away the stderr output, so
the console is not polluted in any way.

This is not a big deal in practice, but I see a slightly better taste
in adding '--' to teach it that '-linux-gcc' is an argument instead of
a command option.

This will cause extra forking of subshell, but it will not be noticeable
performance regression.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 scripts/Kbuild.include | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/scripts/Kbuild.include b/scripts/Kbuild.include
index 222fd1d7d3ae..c62d690c7dcf 100644
--- a/scripts/Kbuild.include
+++ b/scripts/Kbuild.include
@@ -79,8 +79,8 @@ endef
 # would try to directly execute the shell builtin 'command'. This workaround
 # should be kept for a long time since this issue was fixed only after the
 # GNU Make 4.2.1 release.
-cc-cross-prefix = $(firstword $(foreach c, $(filter-out -%, $(1)), \
-			$(if $(shell command -v $(c)gcc 2>/dev/null), $(c))))
+cc-cross-prefix = $(firstword $(foreach c, $(1), \
+			$(if $(shell command -v -- $(c)gcc 2>/dev/null), $(c))))
 
 # output directory for tests below
 TMPOUT := $(if $(KBUILD_EXTMOD),$(firstword $(KBUILD_EXTMOD))/)
-- 
2.17.1

