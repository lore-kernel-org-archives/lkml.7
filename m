Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FA84C4360F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 15:05:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0ADC8218AE
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 15:05:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="it3jBgTd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731827AbfB1PFX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 10:05:23 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:44062 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731208AbfB1PFU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 10:05:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=ZZpQg/PmFeWSqtR4FaPxwLloIU+T9rtnJslyZ60LKec=; b=it3jBgTdj8XG6NesK/cyWTvCVm
        4X5fBJwiVHJdZdQauRHyaUdC33qF5FSDHttNW9NsadXanv4AythQkvYhJXst5O6wxm6pa02TOMCqU
        3e7fOe2gCol0zNOrYXtNCPBogaAVIt16H/X1Tm7HJcvvPaxZR7xOJa1P4FYPhRNaxOXaJ0JRM1ylU
        xftG70oEYUAOyMDSwRGGsibqB/vInk2UzZPe42QMB1Sd4Dnrw+xNoKHiegdU4J++7pCfrj1cdGNB/
        SNUB3GmVFIoYz1mPbH3nRQrS+AhDKIMgzqdwFo6v19X7gkMhizA8X06lnN4Jroh8QiWlI6a9z8KrL
        2SlqwCKw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gzNFH-0002NH-LI; Thu, 28 Feb 2019 15:05:12 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id D225D202C2DAA; Thu, 28 Feb 2019 16:05:08 +0100 (CET)
Message-Id: <20190228150152.354894099@infradead.org>
User-Agent: quilt/0.65
Date:   Thu, 28 Feb 2019 15:54:54 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     torvalds@linux-foundation.org, tglx@linutronix.de, hpa@zytor.com,
        julien.thierry@arm.com, will.deacon@arm.com, luto@amacapital.net,
        mingo@kernel.org, catalin.marinas@arm.com, james.morse@arm.com,
        valentin.schneider@arm.com, brgerst@gmail.com, jpoimboe@redhat.com,
        luto@kernel.org, bp@alien8.de, dvlasenk@redhat.com
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org
Subject: [PATCH 4/8] objtool: Hande function aliases
References: <20190228145450.289603901@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Function aliases result in different symbols for the same set of
instructions; track a canonical symbol so we have unique point of
access.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 tools/objtool/elf.c |   15 +++++++++++----
 tools/objtool/elf.h |    2 +-
 2 files changed, 12 insertions(+), 5 deletions(-)

--- a/tools/objtool/elf.c
+++ b/tools/objtool/elf.c
@@ -219,7 +219,7 @@ static int read_sections(struct elf *elf
 static int read_symbols(struct elf *elf)
 {
 	struct section *symtab, *sec;
-	struct symbol *sym, *pfunc;
+	struct symbol *sym, *pfunc, *alias;
 	struct list_head *entry, *tmp;
 	int symbols_nr, i;
 	char *coldstr;
@@ -239,6 +239,7 @@ static int read_symbols(struct elf *elf)
 			return -1;
 		}
 		memset(sym, 0, sizeof(*sym));
+		alias = sym;
 
 		sym->idx = i;
 
@@ -288,11 +289,17 @@ static int read_symbols(struct elf *elf)
 				break;
 			}
 
-			if (sym->offset == s->offset && sym->len >= s->len) {
-				entry = tmp;
-				break;
+			if (sym->offset == s->offset) {
+				if (sym->len == s->len && alias == sym)
+					alias = s;
+
+				if (sym->len >= s->len) {
+					entry = tmp;
+					break;
+				}
 			}
 		}
+		sym->alias = alias;
 		list_add(&sym->list, entry);
 		hash_add(sym->sec->symbol_hash, &sym->hash, sym->idx);
 	}
--- a/tools/objtool/elf.h
+++ b/tools/objtool/elf.h
@@ -61,7 +61,7 @@ struct symbol {
 	unsigned char bind, type;
 	unsigned long offset;
 	unsigned int len;
-	struct symbol *pfunc, *cfunc;
+	struct symbol *pfunc, *cfunc, *alias;
 };
 
 struct rela {


