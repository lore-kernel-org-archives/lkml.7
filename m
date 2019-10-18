Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E929FCA9ED0
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 05:03:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAC83222C5
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 05:03:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="CUhjpJ5d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503735AbfJRFDN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 01:03:13 -0400
Received: from condef-05.nifty.com ([202.248.20.70]:41036 "EHLO
        condef-05.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391456AbfJRFDM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 01:03:12 -0400
X-Greylist: delayed 313 seconds by postgrey-1.27 at vger.kernel.org; Fri, 18 Oct 2019 01:03:11 EDT
Received: from conuserg-10.nifty.com ([10.126.8.73])by condef-05.nifty.com with ESMTP id x9I4WACR013408;
        Fri, 18 Oct 2019 13:32:11 +0900
Received: from localhost.localdomain (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-10.nifty.com with ESMTP id x9I4Vnxo019790;
        Fri, 18 Oct 2019 13:31:49 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com x9I4Vnxo019790
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1571373110;
        bh=ZaAH2x9mWYqIOpONit+tZI2RI9D6E0HqE7mG3rRzXzI=;
        h=From:To:Cc:Subject:Date:From;
        b=CUhjpJ5ddQUXB2baNZoqOnqabHsSVW6nlQbA9B5ptLnw9/9+ad/ikRHUQkcfEh2NJ
         PRoIvFwOqTVcsl+Cq8hjOaTYyZjXJhbrIkfS45DGqGMhaTYTbZEFPHRdel4Mc89OS1
         fWKH9sABQqrXAriGh4HQIMSWQckqbytg5tIXyBzWdyXwZgP5j6z/GCRGnfXFCYj5Wp
         mw8nDFGNCJTIaTlLOtxXkPc8Ia5BSImKHoGaY5Odz+Dts9os7OFs2z2oAgMWMWurcQ
         vAwYzVcqjQmiyMYIA7lOuuWMKe9FIOtqZIBhH+s9xmlVrUzwIXVmxJzSIMX3U/MITc
         sh2WSkLYYJFjQ==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kernel@vger.kernel.org, Jessica Yu <jeyu@kernel.org>
Cc:     Nicholas Piggin <npiggin@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org
Subject: [PATCH 1/2] asm-generic/export.h: make __ksymtab_* local symbols
Date:   Fri, 18 Oct 2019 13:31:47 +0900
Message-Id: <20191018043148.6285-1-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For EXPORT_SYMBOL from C files, <linux/export.h> defines __ksymtab_*
as local symbols.

For EXPORT_SYMBOL from assembly, in contrast, <asm-generic/export.h>
produces globally-visible __ksymtab_* symbols due to this .globl
directive.

I do not understand why this must be global.  It still works without
this .globl directive.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 include/asm-generic/export.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/asm-generic/export.h b/include/asm-generic/export.h
index fa577978fbbd..80ef2dc0c8be 100644
--- a/include/asm-generic/export.h
+++ b/include/asm-generic/export.h
@@ -31,7 +31,6 @@
  */
 .macro ___EXPORT_SYMBOL name,val,sec
 #ifdef CONFIG_MODULES
-	.globl __ksymtab_\name
 	.section ___ksymtab\sec+\name,"a"
 	.balign KSYM_ALIGN
 __ksymtab_\name:
-- 
2.17.1

