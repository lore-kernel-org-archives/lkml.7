Return-Path: <SRS0=9baz=WV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEF8DC3A59E
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Aug 2019 01:32:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D3FE22CED
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Aug 2019 01:32:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="bDw0HV/A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728343AbfHYBb7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 24 Aug 2019 21:31:59 -0400
Received: from conuserg-08.nifty.com ([210.131.2.75]:29100 "EHLO
        conuserg-08.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727941AbfHYBb7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Aug 2019 21:31:59 -0400
Received: from grover.flets-west.jp (softbank126125143222.bbtec.net [126.125.143.222]) (authenticated)
        by conuserg-08.nifty.com with ESMTP id x7P1Vg4h010677;
        Sun, 25 Aug 2019 10:31:42 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com x7P1Vg4h010677
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1566696702;
        bh=N5h8iJFDGkxJdkgiGqbdsmMoL3tboI8yMOGmAf/rJKg=;
        h=From:To:Cc:Subject:Date:From;
        b=bDw0HV/AHW/tpP6D4okWfnM7Gnyi9KYS7BS99bdFaEHwJaYm7fD/ArCPxLHdqJz2w
         CwpD8jYn4l44eyNLGieX59WDsvCNBPld9j9PQ1BrysftLmDjSY1r26dLihH3B7fZgl
         /7CjSABcBafFHokIiiQ2PjLls50tEfs57W34icqfZU42sze6MrzLDbQqauPoxRN1Gf
         wE90Gnbwn42gpodNAvmq7QEA1DoKazFRb3a1KiLWGUyaPGxZzDugczwJ/51IuBWNG0
         nIGhzKujRZzY68I93tLkWEr8qsRLrMO4+B/paNYdTUHU70n9ZGGrfHXPkN1S+40rtY
         NpGeki2m2ajDg==
X-Nifty-SrcIP: [126.125.143.222]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] kbuild: clean up subdir-ymn calculation in Makefile.clean
Date:   Sun, 25 Aug 2019 10:31:39 +0900
Message-Id: <20190825013139.12913-1-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove some variables.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 scripts/Makefile.clean | 13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff --git a/scripts/Makefile.clean b/scripts/Makefile.clean
index fc38a34128d4..e367eb95c5c0 100644
--- a/scripts/Makefile.clean
+++ b/scripts/Makefile.clean
@@ -17,17 +17,8 @@ include $(if $(wildcard $(kbuild-dir)/Kbuild), $(kbuild-dir)/Kbuild, $(kbuild-di
 # Figure out what we need to build from the various variables
 # ==========================================================================
 
-__subdir-y	:= $(patsubst %/,%,$(filter %/, $(obj-y)))
-subdir-y	+= $(__subdir-y)
-__subdir-m	:= $(patsubst %/,%,$(filter %/, $(obj-m)))
-subdir-m	+= $(__subdir-m)
-__subdir-	:= $(patsubst %/,%,$(filter %/, $(obj-)))
-subdir-		+= $(__subdir-)
-
-# Subdirectories we need to descend into
-
-subdir-ym	:= $(sort $(subdir-y) $(subdir-m))
-subdir-ymn      := $(sort $(subdir-ym) $(subdir-))
+subdir-ymn := $(sort $(subdir-y) $(subdir-m) $(subdir-) \
+		$(patsubst %/,%, $(filter %/, $(obj-y) $(obj-m) $(obj-))))
 
 # Add subdir path
 
-- 
2.17.1

