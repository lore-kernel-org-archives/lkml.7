Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2543CC606B0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 04:26:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE2C72171F
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 04:26:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="q46wm6dj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727545AbfGIE0E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 00:26:04 -0400
Received: from conuserg-09.nifty.com ([210.131.2.76]:42171 "EHLO
        conuserg-09.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727132AbfGIEZm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 00:25:42 -0400
Received: from localhost.localdomain (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-09.nifty.com with ESMTP id x694OqVm009969;
        Tue, 9 Jul 2019 13:24:55 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com x694OqVm009969
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1562646295;
        bh=66C6WSUar+9fCnRwYJ6reDlsM+3fNuxKvxVBSvN7M4A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=q46wm6djBsOMl+UO7ZtYGgKPKq/5uWI1+EejrxIb6jgSgMFQ75kuiq914nMu/wkox
         UWaJOaXFTlI5UhkkLDUw5QQuPkYP8GjokqLebrW67zJHWz0kyhMvyRX49SqaXWWfn1
         5RaasWQ5LjZz8w/Y4fT/31ZmXAHnseqIBx/ca06Ykr/fzMTffYKvlgqd7UFZ+serXT
         jjgFvGFxeVK7+c7kDsUZLRxNkEt7puygIvDtSYROgA20ui1qdp+fue7Zao5DT2g1n0
         Qq7eJnIjoFVv3Bow8jCqqUiIm6AU9unVIBnewsUY87vlr6oNdqb1cMNSHYTnvjJraF
         xBdJgoF5+M7FA==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Nicolas Pitre <nico@fluxnic.net>, Sam Ravnborg <sam@ravnborg.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 03/11] kbuild: remove duplication from modules.order in sub-directories
Date:   Tue,  9 Jul 2019 13:24:07 +0900
Message-Id: <20190709042416.27554-4-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190709042416.27554-1-yamada.masahiro@socionext.com>
References: <20190709042416.27554-1-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, only the top-level modules.order drops duplicated entries.

The modules.order files in sub-directories potentially contain
duplication. To list out the paths of all modules, I want to use
modules.order instead of parsing *.mod files in $(MODVERDIR).

To achieve this, I want to rip off duplication from modules.order
of external modules too.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 scripts/Makefile.build | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index d827b7a36892..1492e37c3927 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -425,13 +425,10 @@ endif # builtin-target
 #
 # Create commands to either record .ko file or cat modules.order from
 # a subdirectory
-modorder-cmds =						\
-	$(foreach m, $(modorder),			\
-		$(if $(filter %/modules.order, $m),	\
-			cat $m;, echo $m;))
-
 $(modorder-target): $(subdir-ym) FORCE
-	$(Q)(cat /dev/null; $(modorder-cmds)) > $@
+	$(Q){ $(foreach m, $(modorder), \
+	$(if $(filter %/modules.order, $m), cat $m, echo $m);) :; } \
+	| $(AWK) '!x[$$0]++' - > $@
 
 #
 # Rule to compile a set of .o files into one .a file (with symbol table)
-- 
2.17.1

