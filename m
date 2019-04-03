Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 346FBC4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 08:33:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00CB021473
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 08:33:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="LFcbnq0D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728888AbfDCIdY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 04:33:24 -0400
Received: from conuserg-12.nifty.com ([210.131.2.79]:41428 "EHLO
        conuserg-12.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726004AbfDCIdY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 04:33:24 -0400
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-12.nifty.com with ESMTP id x338We3d002056;
        Wed, 3 Apr 2019 17:32:40 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com x338We3d002056
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1554280361;
        bh=XHJafHUyFnknfzhjnap4Zl+wIRElQxv4rFPTpKay5is=;
        h=From:To:Cc:Subject:Date:From;
        b=LFcbnq0DSUCxmV/YGoPJasR/TRDDLE+e4kXPVtqucK2BcMr/cDgioXMosN5jzCtEx
         5pWMCkeVsuSnvHWJcUnkQkEJFd+DmlG+suiGCOnISAxawv8n+jw3XBKtSluK7DEOnj
         9JpzMuS0T7SL+U/GBleG6HHu5h49rMNKAw3BU2jd8V+mdnzSH9ITV0bntg+whvP10H
         f0Wg8Opa55EWZqmwr+douvaQUeIqA/eqUQehkhuIbhQqWNtUCw5S4a79j4549Ptqmq
         7zj5A0EgKw6e+CxE7hj+ScEHzLSmK/qzcMOv17FiF0szDsYWezqkkujQd6Tch5SvfR
         5yWlsa0tZrexg==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     "David S . Miller" <davem@davemloft.net>,
        sparclinux@vger.kernel.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        "ndesaulniers@google.com" <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org,
        Frank Rowand <frowand.list@gmail.com>,
        Ingo Molnar <mingo@kernel.org>
Subject: [PATCH] sparc: vdso: add FORCE to the build rule of %.so
Date:   Wed,  3 Apr 2019 17:32:24 +0900
Message-Id: <1554280344-10741-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

$(call if_changed,...) must have FORCE as a prerequisite.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/sparc/vdso/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/sparc/vdso/Makefile b/arch/sparc/vdso/Makefile
index 74e97f7..83c4b46 100644
--- a/arch/sparc/vdso/Makefile
+++ b/arch/sparc/vdso/Makefile
@@ -68,7 +68,7 @@ CFLAGS_REMOVE_vdso-note.o = -pg
 CFLAGS_REMOVE_vclock_gettime.o = -pg
 
 $(obj)/%.so: OBJCOPYFLAGS := -S
-$(obj)/%.so: $(obj)/%.so.dbg
+$(obj)/%.so: $(obj)/%.so.dbg FORCE
 	$(call if_changed,objcopy)
 
 CPPFLAGS_vdso32.lds = $(CPPFLAGS_vdso.lds)
-- 
2.7.4

