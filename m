Return-Path: <SRS0=E2Zf=ZP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEE6CC432C0
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Nov 2019 13:28:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 934BC204FD
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Nov 2019 13:28:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="Atkfyh8Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727218AbfKWN2q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Nov 2019 08:28:46 -0500
Received: from conuserg-10.nifty.com ([210.131.2.77]:39537 "EHLO
        conuserg-10.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726767AbfKWN2A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Nov 2019 08:28:00 -0500
Received: from grover.flets-west.jp (softbank126093102113.bbtec.net [126.93.102.113]) (authenticated)
        by conuserg-10.nifty.com with ESMTP id xANDRbkk000733;
        Sat, 23 Nov 2019 22:27:43 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com xANDRbkk000733
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1574515664;
        bh=WauG9D9YqzAMxDQWtyV5l/7rFsL3kICN4sbEOWLPOkk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Atkfyh8QyZvNdKwiRXs5OY/qwqpMMMo2N0WjBKKh+FGfMLwSX7fFeADxa9XOSzcpp
         vMU8+MhgrX4IjbMl00w26VFNZIRm/dA1R39mMGtONOiPbmosblhDZeEOUlcmgQ5p3l
         mTZV1ynHyDrhAFRqO2BJHFqcInvnvsGYhOsg6iEr9Dh4DHKElIq/XiOQ/mCBZZaaxl
         UWvKRv/Tiuv62pGW5eiIhiDIlIpQQD1nrXNoQ4THBDgkhiPyUozLIDdgLHVt+Su8IB
         1kQGU1yNRmma8S0WWKvHFe8O+/D5LG3hdR6tlQdRzkck4KWwL+BTTkQnVor3EjSXVA
         j7b6o2WNwFTyg==
X-Nifty-SrcIP: [126.93.102.113]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 11/16] scripts/kallsyms: move more patterns to the ignored_prefixes array
Date:   Sat, 23 Nov 2019 22:27:22 +0900
Message-Id: <20191123132727.30151-12-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191123132727.30151-1-yamada.masahiro@socionext.com>
References: <20191123132727.30151-1-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Refactoring for shortening the code.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 scripts/kallsyms.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/scripts/kallsyms.c b/scripts/kallsyms.c
index 5553843631d4..63473924d4de 100644
--- a/scripts/kallsyms.c
+++ b/scripts/kallsyms.c
@@ -105,6 +105,8 @@ static bool is_ignored_symbol(const char *name, char type)
 	};
 
 	static const char * const ignored_prefixes[] = {
+		"$",			/* local symbols for ARM, MIPS, etc. */
+		".LASANPC",		/* s390 kasan local symbols */
 		"__crc_",		/* modversions */
 		"__efistub_",		/* arm64 EFI stub namespace */
 		NULL
@@ -198,19 +200,9 @@ static int read_symbol(FILE *in, struct sym_entry *s)
 	}
 	else if (toupper(stype) == 'U')
 		return -1;
-	/*
-	 * Ignore generated symbols such as:
-	 *  - mapping symbols in ARM ELF files ($a, $t, and $d)
-	 *  - MIPS ELF local symbols ($L123 instead of .L123)
-	 */
-	else if (sym[0] == '$')
-		return -1;
 	/* exclude debugging symbols */
 	else if (stype == 'N' || stype == 'n')
 		return -1;
-	/* exclude s390 kasan local symbols */
-	else if (!strncmp(sym, ".LASANPC", 8))
-		return -1;
 
 	/* include the type field in the symbol name, so that it gets
 	 * compressed together */
-- 
2.17.1

