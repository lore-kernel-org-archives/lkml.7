Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16AFEC28CC5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 13:23:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C759D2086A
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 13:23:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="pjELKVwd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728230AbfFENXy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 09:23:54 -0400
Received: from merlin.infradead.org ([205.233.59.134]:50958 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727966AbfFENXe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 09:23:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=TdtUzQw4Xh7pHfYaMHc8uRWdMmIOW2a80o3ly6vU9Hk=; b=pjELKVwdXyyPfzMHoK9Lfi+j7f
        7tq78mcAfsue4hbA0T6rVyocnkjkMIIpERRHvY/hFtRijHlbPIGF3x6iXNn4cqWc+vrnrC4SvUC6s
        lQesRhD5MOS1BCjlSxYIvUWBaGD4tHlW6nhYXIYouoWeWyJGy9bVy/yJGZ1rGYRcZo849ev/1t/Pn
        5ZknIqdltUmPBAHajFM2On0t6crKFfpCcLkVuu9MQ+LDKwbEt9weytZiGfQ/m/naNB0epliwHyXe5
        DQp2MngaSjahfjnMfKhD9zrszu82UplInvvflWZWHkrAl+ccFZJSbtmFL/yrqIvbO/wTbj4TeC0mW
        mUIhIq7A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hYVsJ-0006rR-2V; Wed, 05 Jun 2019 13:22:43 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 907EE2008D9FD; Wed,  5 Jun 2019 15:22:39 +0200 (CEST)
Message-Id: <20190605131945.064393024@infradead.org>
User-Agent: quilt/0.65
Date:   Wed, 05 Jun 2019 15:08:02 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Andy Lutomirski <luto@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jason Baron <jbaron@akamai.com>, Jiri Kosina <jkosina@suse.cz>,
        David Laight <David.Laight@ACULAB.COM>,
        Borislav Petkov <bp@alien8.de>,
        Julia Cartwright <julia@ni.com>, Jessica Yu <jeyu@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Nadav Amit <namit@vmware.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Edward Cree <ecree@solarflare.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: [PATCH 09/15] compiler.h: Make __ADDRESSABLE() symbol truly unique
References: <20190605130753.327195108@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Josh Poimboeuf <jpoimboe@redhat.com>

The __ADDRESSABLE() macro uses the __LINE__ macro to create a temporary
symbol which has a unique name.  However, if the macro is used multiple
times from within another macro, the line number will always be the
same, resulting in duplicate symbols.

Make the temporary symbols truly unique by using __UNIQUE_ID instead of
__LINE__.

Cc: Julia Cartwright <julia@ni.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: x86@kernel.org
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Jason Baron <jbaron@akamai.com>
Cc: Edward Cree <ecree@solarflare.com>
Cc: Jiri Kosina <jkosina@suse.cz>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Jessica Yu <jeyu@kernel.org>
Cc: David Laight <David.Laight@ACULAB.COM>
Cc: Nadav Amit <namit@vmware.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Andy Lutomirski <luto@kernel.org>
Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/8bc857824f82462a296a8a3c4913a11a7f801e74.1547073843.git.jpoimboe@redhat.com
---
 include/linux/compiler.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -294,7 +294,7 @@ unsigned long read_word_at_a_time(const
  */
 #define __ADDRESSABLE(sym) \
 	static void * __section(".discard.addressable") __used \
-		__PASTE(__addressable_##sym, __LINE__) = (void *)&sym;
+		__UNIQUE_ID(__addressable_##sym) = (void *)&sym;
 
 /**
  * offset_to_ptr - convert a relative memory offset to an absolute pointer


