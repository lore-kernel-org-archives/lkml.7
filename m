Return-Path: <SRS0=t4ha=TM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9959CC04A6B
	for <linux-kernel@archiver.kernel.org>; Sun, 12 May 2019 13:13:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 695652146F
	for <linux-kernel@archiver.kernel.org>; Sun, 12 May 2019 13:13:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="CBgDSJEX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726761AbfELNNA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 May 2019 09:13:00 -0400
Received: from conuserg-08.nifty.com ([210.131.2.75]:51983 "EHLO
        conuserg-08.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726477AbfELNM7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 May 2019 09:12:59 -0400
Received: from grover.flets-west.jp (softbank126125154139.bbtec.net [126.125.154.139]) (authenticated)
        by conuserg-08.nifty.com with ESMTP id x4CDCNYm019598;
        Sun, 12 May 2019 22:12:23 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com x4CDCNYm019598
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1557666743;
        bh=xGIaCCBT4ZPJeA9PBYfwFyJ4Wf7xBW9XNsnG50FXtyE=;
        h=From:To:Cc:Subject:Date:From;
        b=CBgDSJEXSGBdAzI+bPa24iLifa6HwF8l4UnQIdxUMpdmSTozL8obiIJW7zts9Lrby
         7NZ6egzFcXxL42+kkKblfpLssqnXTFwFQH6McABnD8nxioHa5Sf7xbu+wAfRQHA5L0
         DIRYoaY013Frww8y3dj5zhHri2reQw8sGrSB3r1zpNf3Zm9cIHFjw2IhKJAtKbJlZD
         gtK+cK2pwn4+ufSbV5gj29tyVYOY7uIHPE7MA8d2CdzMrtwnYmV4WjXIFNMViTXJxf
         zTCUggVVOxzc7H6H7NUvX9yxwj7im47GdQkZVx7IA44inLJk7vFnzymC65UvXazH1T
         XdOJawGXU4mNA==
X-Nifty-SrcIP: [126.125.154.139]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     Ley Foon Tan <lftan@altera.com>, nios2-dev@lists.rocketboards.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] nios2: remove pointless second entry for CONFIG_TRACE_IRQFLAGS_SUPPORT
Date:   Sun, 12 May 2019 22:12:13 +0900
Message-Id: <1557666733-19527-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Strangely enough, NIOS2 defines TRACE_IRQFLAGS_SUPPORT twice
with different values, which is pointless and confusing.

[1] arch/nios2/Kconfig

  config TRACE_IRQFLAGS_SUPPORT
          def_bool n

[2] arch/nios2/Kconfig.debug

  config TRACE_IRQFLAGS_SUPPORT
          def_bool y

[1] is included before [2]. In the Kconfig syntax, the first one
is effective. So, TRACE_IRQFLAGS_SUPPORT is always 'n'.

The second define in arch/nios2/Kconfig.debug is dead code.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/nios2/Kconfig.debug | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/nios2/Kconfig.debug b/arch/nios2/Kconfig.debug
index f1da8a7..a8bc06e 100644
--- a/arch/nios2/Kconfig.debug
+++ b/arch/nios2/Kconfig.debug
@@ -1,8 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
 
-config TRACE_IRQFLAGS_SUPPORT
-	def_bool y
-
 config EARLY_PRINTK
 	bool "Activate early kernel debugging"
 	default y
-- 
2.7.4

