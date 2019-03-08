Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B18C1C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 05:31:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 763D42081B
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 05:31:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="rbjYIf7L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726302AbfCHFa7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 00:30:59 -0500
Received: from conuserg-09.nifty.com ([210.131.2.76]:56172 "EHLO
        conuserg-09.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725308AbfCHFa6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 00:30:58 -0500
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-09.nifty.com with ESMTP id x285Udqx017095;
        Fri, 8 Mar 2019 14:30:39 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com x285Udqx017095
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1552023039;
        bh=oU7ETBxuT4v8f1zR1m07flzixJJImsBFfOVhlFXCla8=;
        h=From:To:Cc:Subject:Date:From;
        b=rbjYIf7LmgjsM6BAPgG6iL4S0u8qkbCW78zhTj56X1Qq8ysGwCy3NsXTT7YnokCvF
         ZM80rhnviuXsu4Eyf0t5cBVLTqIH1VLVNIzILDYao8s4hIe7rWQBA1fr2ptPwlFhVL
         +HJsyJRKCVs4dwzNENhAQnfok5FTIbBJYyZXpNIPVUQn3SLjmIF0XOEjvnkcdCxhX4
         zSxSppa5+OMqa8q0P39T4fKVFT/RQz35B1nc9eiV8W7kQNVjqw4b0rJRjE5Vkh995d
         fI9IYg29mGrVKC3ruKWUd/+YAe5PqeL+1DDu1TqN507GlttuOgGimVnL+sTmIesPGM
         snNmsALXVv2cQ==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org, Guan Xuetao <gxt@pku.edu.cn>
Subject: [PATCH] unicore32: simplify linker script generation for decompressor
Date:   Fri,  8 Mar 2019 14:30:35 +0900
Message-Id: <1552023035-29826-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When I was searching for unneeded $(KCONFIG_CONFIG) usages, I noticed
this strange build dependency.

It can use $(call if_changed,...) in case ZTEXTADDR and ZBSSADDR are
changed, but even a simpler way is to use the pattern rule in
scripts/Makefile.build. This is what arch/arm/boot/compressed/Makefile
does.

I did only build test. I confirmed equivalent vmlinux.lds was generated.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/unicore32/boot/compressed/Makefile                          | 5 +----
 arch/unicore32/boot/compressed/{vmlinux.lds.in => vmlinux.lds.S} | 0
 2 files changed, 1 insertion(+), 4 deletions(-)
 rename arch/unicore32/boot/compressed/{vmlinux.lds.in => vmlinux.lds.S} (100%)

diff --git a/arch/unicore32/boot/compressed/Makefile b/arch/unicore32/boot/compressed/Makefile
index 9aecdd3..150fafc 100644
--- a/arch/unicore32/boot/compressed/Makefile
+++ b/arch/unicore32/boot/compressed/Makefile
@@ -61,7 +61,4 @@ $(obj)/vmlinux: $(obj)/vmlinux.lds $(obj)/head.o $(obj)/piggy.o \
 ZTEXTADDR	:= 0x03000000
 ZBSSADDR	:= ALIGN(4)
 
-SEDFLAGS_lds	= s/TEXT_START/$(ZTEXTADDR)/;s/BSS_START/$(ZBSSADDR)/
-$(obj)/vmlinux.lds: $(obj)/vmlinux.lds.in arch/unicore32/boot/Makefile $(KCONFIG_CONFIG)
-	@sed "$(SEDFLAGS_lds)" < $< > $@
-
+CPPFLAGS_vmlinux.lds = -DTEXT_START="$(ZTEXTADDR)" -DBSS_START="$(ZBSSADDR)"
diff --git a/arch/unicore32/boot/compressed/vmlinux.lds.in b/arch/unicore32/boot/compressed/vmlinux.lds.S
similarity index 100%
rename from arch/unicore32/boot/compressed/vmlinux.lds.in
rename to arch/unicore32/boot/compressed/vmlinux.lds.S
-- 
2.7.4

