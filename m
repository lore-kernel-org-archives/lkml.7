Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBF70C7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 15:07:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95B4D2238C
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 15:07:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="T00V2Xsb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389001AbfGYPHl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 11:07:41 -0400
Received: from conuserg-08.nifty.com ([210.131.2.75]:29566 "EHLO
        conuserg-08.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388500AbfGYPHk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 11:07:40 -0400
Received: from grover.flets-west.jp (softbank126026094249.bbtec.net [126.26.94.249]) (authenticated)
        by conuserg-08.nifty.com with ESMTP id x6PF652M009240;
        Fri, 26 Jul 2019 00:06:06 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com x6PF652M009240
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1564067166;
        bh=XVd6xCB986FgI4lziNdiIUd8DbxIxrs0iKDny4AAdqY=;
        h=From:To:Cc:Subject:Date:From;
        b=T00V2Xsb5bCcGQQk5pgc3prcyt3Phib8cIT3GY0L92nITXEUXPTyTji6VjzVDkfYz
         FPEFhJvH7K0DuDH2Hbnm8If4baIhQVrNiZ/EZ0aG4RjjVCyt+yPzIUJM4g031KWxK3
         iolsRmwr+MHopRqQhX4QHOYE41HA09WAwfvjARZYz+aWW5S7Ycc1+/RHeOSU3xSdCM
         dZiKxyhY5uQIUt4g0W7RvGT2VoO7ytHJcD7oTzMC0qwVmeAccSHLUYDH2pjN1r2r8l
         k0yNdkD7/gEFRzkN7tpOzYbpdKP7MoL1JiMnxx2Mg3FwWF9zhIS2MMDxbqQsFb0Asm
         VWkRCQVOxODGg==
X-Nifty-SrcIP: [126.26.94.249]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Jan Kiszka <jan.kiszka@siemens.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kernel@vger.kernel.org
Subject: [FWIW PATCH] kbuild: create modules.order in sub-directories visited by subdir-y,m
Date:   Fri, 26 Jul 2019 00:06:00 +0900
Message-Id: <20190725150600.27007-1-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Kiszka reported a module build regression; since commit ff9b45c55b26
("kbuild: modpost: read modules.order instead of $(MODVERDIR)/*.mod"),
a module is no longer built in the following pattern:

  [Makefile]
  subdir-y := some-module

  [some-module/Makefile]
  obj-m := some-module.o

You can make it work by writing like this:

  [Makefile]
  obj-m := some-module/

  [some-module/Makefile]
  obj-m := some-module.o

None of upstream Makefiles is written like the former. In fact, the
former is a bug in upstream since modules.order is not correctly
generated.

For external modules, it was at least known to work, and being used
by some people.

This commit gets it back working, but I do not to want to encourage it
for the upstream code, so I surrounded it by ifeq ($(KBUILD_EXTMOD),).

Reported-by: Jan Kiszka <jan.kiszka@siemens.com>
Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

I just wrote a fix-up patch, but I am still wondering if it is correct
to build modules under subdir-y.


 scripts/Makefile.lib | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index 5241d0751eb0..9568888c97ca 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -25,6 +25,11 @@ lib-y := $(filter-out $(obj-y), $(sort $(lib-y) $(lib-m)))
 # and -m subdirs.  Just put -y's first.
 modorder	:= $(patsubst %/,%/modules.order, $(filter %/, $(obj-y)) $(obj-m:.o=.ko))
 
+ifeq ($(KBUILD_EXTMOD),)
+# External modules may generate modules under subdir-y or subdir-m.
+modorder += $(addsuffix /modules.order, $(subdir-y) $(subdir-m))
+endif
+
 # Handle objects in subdirs
 # ---------------------------------------------------------------------------
 # o if we encounter foo/ in $(obj-y), replace it by foo/built-in.a
-- 
2.17.1

