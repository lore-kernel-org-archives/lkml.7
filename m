Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C944DC04A6B
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 00:58:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 913C42173B
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 00:58:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="OoLkEMPf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726428AbfEIA6j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 20:58:39 -0400
Received: from conuserg-12.nifty.com ([210.131.2.79]:59227 "EHLO
        conuserg-12.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725778AbfEIA6i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 20:58:38 -0400
Received: from grover.flets-west.jp (softbank126125154139.bbtec.net [126.125.154.139]) (authenticated)
        by conuserg-12.nifty.com with ESMTP id x490w9KG001364;
        Thu, 9 May 2019 09:58:09 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com x490w9KG001364
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1557363490;
        bh=A0ah3OCkj+C/oYyV6jDmlhQW2a5VM8SUDJDCzq+gWyY=;
        h=From:To:Cc:Subject:Date:From;
        b=OoLkEMPfpOStVZh2DnAFwrv0o3LRz8rFvjKMyETx3vgP3vMCn0KpPCBCuVVJHuT5R
         fYVrVGJQSk9tgrcV3tG4I2p0ndgbmppZu+FDBcfXhHI2cU42vUa+2lenJgg8FL55GH
         737BPKEytBL/APVwR079DBJFW2bMp3cZQVdFFf8kD7gc2Y8Sv/JdbKGlrzZ265LEO5
         tTfoa0W3S8QvAxGvthsCVQNsR8N+iWbA5EKGM48X43ZxxDxkUOE33O5a4g/J1hcRLH
         ydbDUCkumhRgPelyN9EK9oA7vc7Zm3gq9kXby9ZuGnrH863Bo1SGx0pzJR+HRnAO8o
         Dn2XVbe4ovsPw==
X-Nifty-SrcIP: [126.125.154.139]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] kbuild: re-enable int-in-bool-context warning
Date:   Thu,  9 May 2019 09:58:01 +0900
Message-Id: <1557363481-27178-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This warning was disabled by commit bd664f6b3e37 ("disable new
gcc-7.1.1 warnings for now") just because it was too noisy.

Thanks to Arnd Bergmann, all warnings have been fixed. Now, we are
ready to re-enable it.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Arnd Bergmann <arnd@arndb.de>
---

Changes in v2:
  - rebase

 Makefile | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Makefile b/Makefile
index a61a95b..2896518 100644
--- a/Makefile
+++ b/Makefile
@@ -692,7 +692,6 @@ KBUILD_CFLAGS	+= $(call cc-option,-fno-delete-null-pointer-checks,)
 KBUILD_CFLAGS	+= $(call cc-disable-warning,frame-address,)
 KBUILD_CFLAGS	+= $(call cc-disable-warning, format-truncation)
 KBUILD_CFLAGS	+= $(call cc-disable-warning, format-overflow)
-KBUILD_CFLAGS	+= $(call cc-disable-warning, int-in-bool-context)
 KBUILD_CFLAGS	+= $(call cc-disable-warning, address-of-packed-member)
 
 ifdef CONFIG_CC_OPTIMIZE_FOR_SIZE
-- 
2.7.4

