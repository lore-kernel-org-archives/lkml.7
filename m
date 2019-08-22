Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4D3EC3A5A3
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 04:46:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9594922DA7
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 04:46:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="f++9zhyS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731072AbfHVEqr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 00:46:47 -0400
Received: from conuserg-07.nifty.com ([210.131.2.74]:29724 "EHLO
        conuserg-07.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730896AbfHVEq3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 00:46:29 -0400
Received: from localhost.localdomain (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-07.nifty.com with ESMTP id x7M4kEYh001492;
        Thu, 22 Aug 2019 13:46:16 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com x7M4kEYh001492
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1566449176;
        bh=hD5x6lRKUb0/bNsPEdTjxNKGIJMjG0FfIIS/kLrvgeQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=f++9zhySIjkHbDQkl57baoVaRVeJp+Yd9LX6Vx+VUn/vQK/DTqCnrVAsBxCqnsqz8
         wtMD0gsjdD/vyp44n/CHj71HgbsOozl/0M872DhTvwrpZmiwIUG2TCZAFyhtiGRkkg
         J2AZXIgM8egOXJEfevgHfONc2KzkW/JSUr3p3qXJgqioa4HZo59qRnuVW4kbchavqq
         iXWFkVDPWeKkpKp2Eip1S4Ts0eiNWdQWscyCZbCeC45N7zmY/dk5Nc/7S9KBq3GUon
         rnq4vdbOODNiWn6xaTYrHEqW/KUCvi/e7OEfnwlzzisu9F9a400HJwFsWat9st6iVt
         F6WPMtgX9uPww==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/6] kbuild: clarify where to run make mrproper when out-of-tree fails
Date:   Thu, 22 Aug 2019 13:46:10 +0900
Message-Id: <20190822044613.5349-3-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190822044613.5349-1-yamada.masahiro@socionext.com>
References: <20190822044613.5349-1-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If you try out-of-tree build with an unclean source tree, Kbuild
suggests to run make mrproper. The path to the source tree may be
shown with a relative path, for example, "make O=foo" emits the
following:

  .. is not clean, please run 'make mrproper'
  in the '..' directory.

This is somewhat confusing if you ran "make O=foo" in the source tree.
Using the absolute path will be clearer.

This commit changes the error message like follows:

***
*** The source tree is not clean, please run 'make mrproper'
*** in /absolute/path/to/linux
***

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 Makefile | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index d9cbbc27d4ba..901fcb8fffbe 100644
--- a/Makefile
+++ b/Makefile
@@ -1121,8 +1121,10 @@ ifdef building_out_of_srctree
 	$(Q)if [ -f $(srctree)/.config -o \
 		 -d $(srctree)/include/config -o \
 		 -d $(srctree)/arch/$(SRCARCH)/include/generated ]; then \
-		echo >&2 "  $(srctree) is not clean, please run 'make$(if $(findstring command line, $(origin ARCH)), ARCH=$(ARCH)) mrproper'"; \
-		echo >&2 "  in the '$(srctree)' directory.";\
+		echo >&2 "***"; \
+		echo >&2 "*** The source tree is not clean, please run 'make$(if $(findstring command line, $(origin ARCH)), ARCH=$(ARCH)) mrproper'"; \
+		echo >&2 "*** in $(abs_srctree)";\
+		echo >&2 "***"; \
 		/bin/false; \
 	fi;
 endif
-- 
2.17.1

