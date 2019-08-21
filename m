Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 310B7C3A59E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 07:02:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06881206BA
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 07:02:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="O79tJqAS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728065AbfHUHCT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 03:02:19 -0400
Received: from conuserg-09.nifty.com ([210.131.2.76]:35857 "EHLO
        conuserg-09.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727266AbfHUHCT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 03:02:19 -0400
Received: from localhost.localdomain (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-09.nifty.com with ESMTP id x7L727vC010350;
        Wed, 21 Aug 2019 16:02:13 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com x7L727vC010350
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1566370933;
        bh=TA/zbA2DSALzdXaU6Ddb7Mv6d9woV6++8wrK6WyUiu8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=O79tJqASw472VpGe7Z+6TJ2h8ISo4UlOS4IQMB2etcEVSTgPUeoQ74NLgmTajpJCF
         6Zg+S3IHflNqo+N6C/zUcbB38lIwjaM2fwTQwVBvDYiwiw5+Uok7gAXqc447zmvcBW
         6BSRX4X+jO8Z0cOgjBEZ2+sRV+UOmc6jQxxSOR7rLUxBUZ9xKUa4CoguUmT2qDc4F3
         zFRmd5cR21kaf7ldQku5+i2Wj6PncLxjBonlPfT1uJO0ymlqbJL5fHNKRBQ4ZNeEHs
         0TKQmcYhgMoUdFn+0MXlk+iTtpeHbMcc9ybWD1SUhkirQoe7HjLkxyESKpr8CSZrwm
         pkCAIP0X40cUw==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] kbuild: remove unneeded '+' marker from cmd_clean
Date:   Wed, 21 Aug 2019 16:02:05 +0900
Message-Id: <20190821070205.8297-4-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190821070205.8297-1-yamada.masahiro@socionext.com>
References: <20190821070205.8297-1-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This '+' was added a long time ago:

|commit c23e6bf05f7802e92fd3da69a1ed35e56f9c85bb (HEAD)
|Author: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
|Date:   Mon Oct 28 01:16:34 2002 -0600
|
|    kbuild: Fix a "make -j<N>" warning
|
|diff --git a/scripts/Makefile.clean b/scripts/Makefile.clean
|index 2c843e0380bc..e7c392fd5788 100644
|--- a/scripts/Makefile.clean
|+++ b/scripts/Makefile.clean
|@@ -42,7 +42,7 @@ quiet_cmd_clean = CLEAN   $(obj)
|
| __clean: $(subdir-ymn)
| ifneq ($(strip $(__clean-files) $(clean-rule)),)
|-       $(call cmd,clean)
|+       +$(call cmd,clean)
| else
|        @:
| endif

At that time, cmd_clean contained '$(clean-rule)', which was able to
invoke sub-make. That was why "make -j<N> clean" showed:
warning: jobserver unavailable: using -j1.  Add '+' to parent make rule.

It is not the case any more. cmd_clean now just runs the 'rm' command.
The '+' marker is pointless.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 scripts/Makefile.clean | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/Makefile.clean b/scripts/Makefile.clean
index 798e8717c1d9..29281a20cf8e 100644
--- a/scripts/Makefile.clean
+++ b/scripts/Makefile.clean
@@ -59,7 +59,7 @@ quiet_cmd_clean    = CLEAN   $(obj)
 
 __clean: $(subdir-ymn)
 ifneq ($(strip $(__clean-files)),)
-	+$(call cmd,clean)
+	$(call cmd,clean)
 endif
 	@:
 
-- 
2.17.1

