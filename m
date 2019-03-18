Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B915C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 15:52:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D12362087E
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 15:52:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NvWSMmpv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727586AbfCRPw4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 11:52:56 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:45616 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727426AbfCRPwz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 11:52:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=pnQ+YnUj1ZIwlTJ9q0qmAJneQVZi9pnabkm2uQjoiPU=; b=NvWSMmpviGwYXxwG0i3miTPTSM
        Chpn/xM+kOzhEcUVU6KEW16SRenSqPy3wc8WyENLF+URJ7dkCqdAu1HX/joILi0iBDblRw2ZCcbWN
        PCKhwDT5Uo03i9a9wJ+fiGILKNto3P91Zi8AWb7lQ2i1ErwmDpgwzSNtNqwmw8k9f7mACXucfN7f+
        JsAlprCdNnMQrpeAwhXUcjGsImz/xzREzelHziLsmZ+qISKyngDWfw65xoNn5apU5KcZV8pcAGRkL
        Hb6yTfO6R/0VD3wMmlfr6z8lke8D6D8Lu9yMq8bKYGtJ/37+SNCLMf9xbcUz06DrOONdC4aMByU+s
        qizeEKYQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h5uZ9-0006n5-EJ; Mon, 18 Mar 2019 15:52:43 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id DA4DF25E45D7E; Mon, 18 Mar 2019 16:52:38 +0100 (CET)
Message-Id: <20190318155141.558827084@infradead.org>
User-Agent: quilt/0.65
Date:   Mon, 18 Mar 2019 16:38:58 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     torvalds@linux-foundation.org, tglx@linutronix.de, hpa@zytor.com,
        julien.thierry@arm.com, will.deacon@arm.com, luto@amacapital.net,
        mingo@kernel.org, catalin.marinas@arm.com, james.morse@arm.com,
        valentin.schneider@arm.com, brgerst@gmail.com, jpoimboe@redhat.com,
        luto@kernel.org, bp@alien8.de, dvlasenk@redhat.com
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        dvyukov@google.com, rostedt@goodmis.org
Subject: [PATCH 18/25] objtool: Handle function aliases
References: <20190318153840.906404905@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Function aliases result in different symbols for the same set of
instructions; track a canonical symbol so there is a unique point of
access.

This again prepares the way for function attributes. And in particular
the need for aliases comes from how KASAN uses them.

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


