Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD830C282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 11:18:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DAE8214DA
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 11:18:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="fPkOXws6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388782AbfDRLSs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 07:18:48 -0400
Received: from conuserg-09.nifty.com ([210.131.2.76]:36394 "EHLO
        conuserg-09.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387519AbfDRLSr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 07:18:47 -0400
Received: from localhost.localdomain (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-09.nifty.com with ESMTP id x3IBITuF031986;
        Thu, 18 Apr 2019 20:18:29 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com x3IBITuF031986
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1555586310;
        bh=JmzgjSsvntbwNuOuncuXs51IbjZIDlbQpg5sIotoe98=;
        h=From:To:Cc:Subject:Date:From;
        b=fPkOXws69daRTbVgqJhDMndOU2Ld6yKl6a8yfZNQaGgiWfqKZ9gg/1FO+AUZRgygJ
         1dElYWTwZvS7u7eiqeen2aVOj9mj2IozlpqiLZq4s6mmxwWoZjffQ16/rVmnx9KVlt
         fS6CXIjqeO4HyAqG1v25vo8ZnahF1vl6+jOf7fM2YQfkG1DHDZJxn/BgqYr8SR+y1W
         svBsUGdQk6xETnGMy12JsnbhfuVejoT6kqEOxZGLYi+aMtK11+jK3qYzuaSfdH2kCT
         K3d3u3ETIWGBapuSL7ryO5jaf60hmarrWcriLRSuhgr7dwQj2OS9BHXx20IIvI25kL
         xO7Clv2jDsvCw==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] kbuild: re-enable int-in-bool-context warning
Date:   Thu, 18 Apr 2019 20:18:22 +0900
Message-Id: <20190418111822.12660-1-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This warning was disabled by commit bd664f6b3e37 ("disable new
gcc-7.1.1 warnings for now") just because it was too noisy.

Thanks to Arnd Bergmann, (almost) all warnings have been fixed.
We are now ready to re-enable it.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Arnd Bergmann <arnd@arndb.de>
---

 Makefile | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Makefile b/Makefile
index 459f37d9c482..adba08606f37 100644
--- a/Makefile
+++ b/Makefile
@@ -690,7 +690,6 @@ KBUILD_CFLAGS	+= $(call cc-option,-fno-delete-null-pointer-checks,)
 KBUILD_CFLAGS	+= $(call cc-disable-warning,frame-address,)
 KBUILD_CFLAGS	+= $(call cc-disable-warning, format-truncation)
 KBUILD_CFLAGS	+= $(call cc-disable-warning, format-overflow)
-KBUILD_CFLAGS	+= $(call cc-disable-warning, int-in-bool-context)
 
 ifdef CONFIG_CC_OPTIMIZE_FOR_SIZE
 KBUILD_CFLAGS	+= -Os
-- 
2.17.1

