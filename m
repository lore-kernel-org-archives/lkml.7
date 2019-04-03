Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35D1BC4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 08:31:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F072D2084B
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 08:31:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="wipYMY0i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728865AbfDCIbn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 04:31:43 -0400
Received: from conuserg-08.nifty.com ([210.131.2.75]:64527 "EHLO
        conuserg-08.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726004AbfDCIbl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 04:31:41 -0400
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-08.nifty.com with ESMTP id x338UEMA010865;
        Wed, 3 Apr 2019 17:30:14 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com x338UEMA010865
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1554280215;
        bh=nXWYMtdLVaGCyWnoFL9KAlo63vuMeGuPTBrn/rc0Jes=;
        h=From:To:Cc:Subject:Date:From;
        b=wipYMY0ibZjmJ9pg5Md9eZoXlKQ0EPdOU8CsRynMjnTt2jrmG39cuYG8AqjXYiPvk
         /RVk9uGmBgcOosXznB9r4tfRS/Ip9I+YbNuMr8p9sd+Tbhezu3Q5k0t40ymFGLyr6+
         /aa5Mzd2IxkEU0kBshTBTzBaNLoleQDFPOT+XLBzKwYB9u+h2fE9dOOe1Rpxc5tUt8
         N8q6a+vP9BrnKwxywCFH+zIRcU0NUF116thWa9AnxmaDBpQys1Gg7degSvDGjBaTjU
         vDEHugrQv09Vxi/5ukXxmr5wuWZdWNRRrlmTB36bP0HG1Nz+DHslhL2LT3X6X3heRj
         IIpOdf1TIl90g==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        Andy Lutomirski <luto@kernel.org>
Subject: [PATCH] x86/build/vdso: add FORCE to the build rule of %.so
Date:   Wed,  3 Apr 2019 17:30:12 +0900
Message-Id: <1554280212-10578-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

$(call if_changed,...) must have FORCE as a prerequisite.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/x86/entry/vdso/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/entry/vdso/Makefile b/arch/x86/entry/vdso/Makefile
index 5bfe224..42fe42e 100644
--- a/arch/x86/entry/vdso/Makefile
+++ b/arch/x86/entry/vdso/Makefile
@@ -116,7 +116,7 @@ $(obj)/%-x32.o: $(obj)/%.o FORCE
 targets += vdsox32.lds $(vobjx32s-y)
 
 $(obj)/%.so: OBJCOPYFLAGS := -S
-$(obj)/%.so: $(obj)/%.so.dbg
+$(obj)/%.so: $(obj)/%.so.dbg FORCE
 	$(call if_changed,objcopy)
 
 $(obj)/vdsox32.so.dbg: $(obj)/vdsox32.lds $(vobjx32s) FORCE
-- 
2.7.4

