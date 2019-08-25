Return-Path: <SRS0=9baz=WV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3DD3C3A59E
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Aug 2019 01:31:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B1722190F
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Aug 2019 01:31:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="LeuaRwO7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728303AbfHYBbu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 24 Aug 2019 21:31:50 -0400
Received: from conuserg-10.nifty.com ([210.131.2.77]:34084 "EHLO
        conuserg-10.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727941AbfHYBbt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Aug 2019 21:31:49 -0400
Received: from grover.flets-west.jp (softbank126125143222.bbtec.net [126.125.143.222]) (authenticated)
        by conuserg-10.nifty.com with ESMTP id x7P1VTtJ011335;
        Sun, 25 Aug 2019 10:31:30 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com x7P1VTtJ011335
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1566696691;
        bh=30Euh363O97qvPwnEmpk915vAjmKH6E6UqZ3IfON09c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LeuaRwO7RqpKYcfMmYy2v6S4kcL6SqFe8KokSGn6BajDDT4WNje7hNTWyLlyjJawA
         ONx2sZ08G5ra3bYCGUKJfBwdCGq9nGuy/QegFmenopuxBIwwB2ZNeIp6JNOOS7VVhY
         wzmNdEgysCGBABXHtavs4KkEOE2NUHzVmanNWDgUDt/nO9DSkjFk4UUQF+m0ayeLUv
         EMSnY9rtiVJKxsuFoeeMMlmnAHA6L6deZGAHzDNaLC5ABn7j2wbiI+BAHsshD5i/eT
         uWYrANem8/h2JE1pw9oMaPSIGfbV+lGlMPQSwQllf1wIBb36KvubkvFxyDOVHPNPg6
         nIlsSiJxpO2Tg==
X-Nifty-SrcIP: [126.125.143.222]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] kbuild: remove unneeded '+' marker from cmd_clean
Date:   Sun, 25 Aug 2019 10:31:28 +0900
Message-Id: <20190825013128.12831-2-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190825013128.12831-1-yamada.masahiro@socionext.com>
References: <20190825013128.12831-1-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This '+' was added a long time ago:

| commit c23e6bf05f7802e92fd3da69a1ed35e56f9c85bb (HEAD)
| Author: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
| Date:   Mon Oct 28 01:16:34 2002 -0600
|
|     kbuild: Fix a "make -j<N>" warning
|
| diff --git a/scripts/Makefile.clean b/scripts/Makefile.clean
| index 2c843e0380bc..e7c392fd5788 100644
| --- a/scripts/Makefile.clean
| +++ b/scripts/Makefile.clean
| @@ -42,7 +42,7 @@ quiet_cmd_clean = CLEAN   $(obj)
|
|  __clean: $(subdir-ymn)
|  ifneq ($(strip $(__clean-files) $(clean-rule)),)
| -        $(call cmd,clean)
| +        +$(call cmd,clean)
|  else
|          @:
|  endif

At that time, cmd_clean contained $(clean-rule), which was able to
invoke sub-make. That was why cleaning with the -j option showed:
warning: jobserver unavailable: using -j1.  Add '+' to parent make rule.

It is not the case any more. cmd_clean now just runs the 'rm' command.
The '+' marker is pointless.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 scripts/Makefile.clean | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/Makefile.clean b/scripts/Makefile.clean
index cbfbe13dc87d..fc38a34128d4 100644
--- a/scripts/Makefile.clean
+++ b/scripts/Makefile.clean
@@ -59,7 +59,7 @@ quiet_cmd_clean = CLEAN   $(obj)
 
 __clean: $(subdir-ymn)
 ifneq ($(strip $(__clean-files)),)
-	+$(call cmd,clean)
+	$(call cmd,clean)
 endif
 	@:
 
-- 
2.17.1

