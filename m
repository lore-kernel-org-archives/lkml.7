Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DATE_IN_PAST_03_06,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90EF2C4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 13:36:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60A8B208E3
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 13:36:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="aeh+7bB1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726944AbfF1Ngf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 09:36:35 -0400
Received: from merlin.infradead.org ([205.233.59.134]:43260 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726819AbfF1NgZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 09:36:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=rorvJ83/GJfpFUnkyS0VqTsFbxx61BGDfOfB2UeyKjc=; b=aeh+7bB1HRnS0rfHO2F0gJVj7x
        UdIv90rumkn4EF9GonR+C97MF8+jKxDjXS7jUUzPgxfjLcGXySBPzP6ssB5ILoegEKXRbkCVi5OGt
        Jb5nEUJWtKrwtkeGcALIfT3Yg5H+mD8X+udaODcl7m0VPTmmtd8+X8AJLq/irdfc72Sc7Fjl4qiMn
        t7pWbN+STiQrG/KejsC0W8UnVPI/ynQCDd1qMefP14sXpoxa5WxrrB4BU9qCfcbzEVQQ4+9bhDwjG
        4nKItnXpCFLujvpmbuPQL1UHKi32FWKnpnX7mOiQZ+9f05KeMK+LzSR3k2bfH+OSkTfNkgDrJfZIa
        2I0YHyHw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hgr2s-0000nD-CY; Fri, 28 Jun 2019 13:36:07 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 8D72320AB8992; Fri, 28 Jun 2019 15:36:03 +0200 (CEST)
Message-Id: <20190628103224.716910079@infradead.org>
User-Agent: quilt/0.65
Date:   Fri, 28 Jun 2019 12:21:18 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org, peterz@infradead.org, linux-kernel@vger.kernel.org
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Jason Baron <jbaron@akamai.com>, Nadav Amit <namit@vmware.com>,
        Andy Lutomirski <luto@kernel.org>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: [RFC][PATCH 5/8] jump_label, x86: Improve error when we fail expected text
References: <20190628102113.360432762@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is only a single usage site left, remove the function and extend
the print to include more information, like the expected text and the
patch type.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/kernel/jump_label.c |   24 +++++++++++-------------
 1 file changed, 11 insertions(+), 13 deletions(-)

--- a/arch/x86/kernel/jump_label.c
+++ b/arch/x86/kernel/jump_label.c
@@ -24,17 +24,6 @@ union jump_code_union {
 	} __attribute__((packed));
 };
 
-static void bug_at(unsigned char *ip, int line)
-{
-	/*
-	 * The location is not an op that we were expecting.
-	 * Something went wrong. Crash the box, as something could be
-	 * corrupting the kernel.
-	 */
-	pr_crit("jump_label: Fatal kernel bug, unexpected op at %pS [%p] (%5ph) %d\n", ip, ip, ip, line);
-	BUG();
-}
-
 static void __jump_label_set_jump_code(struct jump_entry *entry,
 				       enum jump_label_type type,
 				       union jump_code_union *code,
@@ -42,6 +31,7 @@ static void __jump_label_set_jump_code(s
 {
 	const unsigned char default_nop[] = { STATIC_KEY_INIT_NOP };
 	const unsigned char *ideal_nop = ideal_nops[NOP_ATOMIC5];
+	unsigned char *ip = (void *)jump_entry_code(entry);
 	const void *expect;
 	int line;
 
@@ -57,8 +47,16 @@ static void __jump_label_set_jump_code(s
 		expect = code->code; line = __LINE__;
 	}
 
-	if (memcmp((void *)jump_entry_code(entry), expect, JUMP_LABEL_NOP_SIZE))
-		bug_at((void *)jump_entry_code(entry), line);
+	if (memcmp(ip, expect, JUMP_LABEL_NOP_SIZE)) {
+		/*
+		 * The location is not an op that we were expecting.
+		 * Something went wrong. Crash the box, as something could be
+		 * corrupting the kernel.
+		 */
+		pr_crit("jump_label: Fatal kernel bug, unexpected op at %pS [%p] (%5ph != %5ph)) line:%d init:%d type:%d\n",
+				ip, ip, ip, expect, line, init, type);
+		BUG();
+	}
 
 	if (type == JUMP_LABEL_NOP)
 		memcpy(code, ideal_nop, JUMP_LABEL_NOP_SIZE);


