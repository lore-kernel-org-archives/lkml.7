Return-Path: <SRS0=E2Zf=ZP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D98A5C43141
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Nov 2019 16:05:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5F9E2070E
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Nov 2019 16:05:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="GbAAVpbg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727059AbfKWQFJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Nov 2019 11:05:09 -0500
Received: from conuserg-12.nifty.com ([210.131.2.79]:49493 "EHLO
        conuserg-12.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726842AbfKWQFD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Nov 2019 11:05:03 -0500
Received: from grover.flets-west.jp (softbank126093102113.bbtec.net [126.93.102.113]) (authenticated)
        by conuserg-12.nifty.com with ESMTP id xANG4l5M019106;
        Sun, 24 Nov 2019 01:04:50 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com xANG4l5M019106
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1574525090;
        bh=IIQsi1izm8K/GBPuGItQbp2rWTEbFo+vUJb/JZsPBDI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GbAAVpbgjzpdtjqkO8wl3cJej1h/ITGS5yHcTf9awSi3XY26RsKP4Ki1jX1rnYzIB
         JH7UZ3e472ol+0QSqmBjgH/huyJdnyIPiByIYYeiIxQkWEEGrkiQ38gzRS35nc+UVy
         RALjM0UoNDh1KduT0bwIMM9ndb6vfMucqhI5QbIPA7RlZZVlZy8VxIdUOxPThnKYRv
         SVJ0Du52HgWW/ypuwRfhoBLbp71ZzmHo3Jox4VR/mez9NfogoksbeiE7PMYP4yq1oA
         91XXY7FZ+1wVOhUreeYPH7vMkSo8M6ezucg8MS2KuM10OmvPvB2eEV4NXzpxBasSPT
         suh+56AJBy2xQ==
X-Nifty-SrcIP: [126.93.102.113]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 05/16] scripts/kallsyms: remove redundant is_arm_mapping_symbol()
Date:   Sun, 24 Nov 2019 01:04:33 +0900
Message-Id: <20191123160444.11251-6-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191123160444.11251-1-yamada.masahiro@socionext.com>
References: <20191123160444.11251-1-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 6f00df24ee39 ("[PATCH] Strip local symbols from kallsyms"),
all symbols starting '$' are ignored.

is_arm_mapping_symbol() particularly ignores $a, $t, etc. but it is
redundant.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

Changes in v2: None

 scripts/kallsyms.c | 19 ++++++-------------
 1 file changed, 6 insertions(+), 13 deletions(-)

diff --git a/scripts/kallsyms.c b/scripts/kallsyms.c
index c9efb67c6ecb..14a50c8d3f34 100644
--- a/scripts/kallsyms.c
+++ b/scripts/kallsyms.c
@@ -74,16 +74,6 @@ static void usage(void)
 	exit(1);
 }
 
-/*
- * This ignores the intensely annoying "mapping symbols" found
- * in ARM ELF files: $a, $t and $d.
- */
-static int is_arm_mapping_symbol(const char *str)
-{
-	return str[0] == '$' && strchr("axtd", str[1])
-	       && (str[2] == '\0' || str[2] == '.');
-}
-
 static int check_symbol_range(const char *sym, unsigned long long addr,
 			      struct addr_range *ranges, int entries)
 {
@@ -139,10 +129,13 @@ static int read_symbol(FILE *in, struct sym_entry *s)
 			return -1;
 
 	}
-	else if (toupper(stype) == 'U' ||
-		 is_arm_mapping_symbol(sym))
+	else if (toupper(stype) == 'U')
 		return -1;
-	/* exclude also MIPS ELF local symbols ($L123 instead of .L123) */
+	/*
+	 * Ignore generated symbols such as:
+	 *  - mapping symbols in ARM ELF files ($a, $t, and $d)
+	 *  - MIPS ELF local symbols ($L123 instead of .L123)
+	 */
 	else if (sym[0] == '$')
 		return -1;
 	/* exclude debugging symbols */
-- 
2.17.1

