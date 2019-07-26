Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B788DC76190
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 02:11:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DCA022C7B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 02:11:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="dUApB1VG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726277AbfGZCLw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 22:11:52 -0400
Received: from conuserg-10.nifty.com ([210.131.2.77]:63684 "EHLO
        conuserg-10.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726000AbfGZCLq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 22:11:46 -0400
Received: from localhost.localdomain (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-10.nifty.com with ESMTP id x6Q2B03j020523;
        Fri, 26 Jul 2019 11:11:01 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com x6Q2B03j020523
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1564107062;
        bh=HtcIZbZ1cRNbQwQ8xFJxK6kDpAQ+ysB+8/CuJSWfBmU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dUApB1VGtbZ7YUhYHnmVTvbvV4McLS446urzu4TTIrCx6Q3uzjOXkejckWvxWj0Ny
         NVy979g1POs6m9GgEH1PVmliV+NSBj2CT5XFuFq4DqXXr0TZGArMAncmaLAO5uOXl6
         tOoAnXg9snAbHp5BoxQKYV37oYvFCTgTb0PbISJNh7xRO1megtbpTk9cVECvy7jJ/D
         f6xwBqVY73xZCbjtmlakoN05mP8V4G/tBCqg6qpiRYSQwbCNRY4/drTsYrvrQeLJz7
         MdYDS8mOf4YiQ91NP+RL1ed6bIiuPQTQ7EVudW5KAysyzD88m7WsQs0JmF/BqkNl17
         9a1YdDVcwhWKQ==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Dave Howells <dhowells@redhat.com>,
        James Morris <jmorris@namei.org>,
        Josh Boyer <jwboyer@fedoraproject.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Nayna Jain <nayna@linux.ibm.com>,
        "Serge E. Hallyn" <serge@hallyn.com>, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: [PATCH 1/5] integrity: remove unneeded, broken attempt to add -fshort-wchar
Date:   Fri, 26 Jul 2019 11:10:54 +0900
Message-Id: <20190726021058.4212-2-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190726021058.4212-1-yamada.masahiro@socionext.com>
References: <20190726021058.4212-1-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I guess commit 15ea0e1e3e18 ("efi: Import certificates from UEFI Secure
Boot") attempted to add -fshort-wchar for building load_uefi.o, but it
has never worked as intended.

load_uefi.o is created in the platform_certs/ sub-directory. If you
really want to add -fshort-wchar, the correct code is:

  $(obj)/platform_certs/load_uefi.o: KBUILD_CFLAGS += -fshort-wchar

or, in a more Kbuild-ish way:

  CFLAGS_load_uefi.o := -fshort-wchar

But, you do not need to fix it.

Commit 8c97023cf051 ("Kbuild: use -fshort-wchar globally") had already
added -fshort-wchar globally. This code was unneeded in the first place.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 security/integrity/Makefile | 1 -
 1 file changed, 1 deletion(-)

diff --git a/security/integrity/Makefile b/security/integrity/Makefile
index 19faace69644..b6d6273a4176 100644
--- a/security/integrity/Makefile
+++ b/security/integrity/Makefile
@@ -13,7 +13,6 @@ integrity-$(CONFIG_INTEGRITY_PLATFORM_KEYRING) += platform_certs/platform_keyrin
 integrity-$(CONFIG_LOAD_UEFI_KEYS) += platform_certs/efi_parser.o \
 					platform_certs/load_uefi.o
 integrity-$(CONFIG_LOAD_IPL_KEYS) += platform_certs/load_ipl_s390.o
-$(obj)/load_uefi.o: KBUILD_CFLAGS += -fshort-wchar
 
 subdir-$(CONFIG_IMA)			+= ima
 obj-$(CONFIG_IMA)			+= ima/
-- 
2.17.1

