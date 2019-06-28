Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DATE_IN_PAST_03_06,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99B4FC4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 13:36:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EACA208E3
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 13:36:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="luzBeIDL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726857AbfF1Ng1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 09:36:27 -0400
Received: from merlin.infradead.org ([205.233.59.134]:43258 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726711AbfF1NgZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 09:36:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=anCtZSSKBswa15L3XwFcRjCLWE8G9OZyId+z8B3LRsc=; b=luzBeIDL3uxKquAWg/Rhs79Rhn
        wXUW+y4jTzz6QTK/ct6u2tRy5+3luQ6/y8xDJLR9XsAwbNF9DsIO3fykXG9638dAaFFE910sPVW4n
        y5DpOKQKlqEW8rYY3loArYfAH8E2pzu2hLDMsf+LYCJJs3UrsYfwuc1NMGK7wCjEGDAEbDgfIibj2
        7fug3Gz+EVotZL8/uNJ+WOeQ/KpBsJtIU0kOPic3bZOrxBFzC3jpF7HTQalu1tZdnVWDiZP+34W0c
        4LTY/hl5XpF5eVxpafz21E2cf2FF4gcIvuuBsVmZEe2gaAGKAUqhD+wvI/zXAI/ykb3gXXUKgnAj8
        I/7rPKgw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hgr2q-0000n9-QQ; Fri, 28 Jun 2019 13:36:05 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 83C8020AB8990; Fri, 28 Jun 2019 15:36:03 +0200 (CEST)
Message-Id: <20190628103224.602848654@infradead.org>
User-Agent: quilt/0.65
Date:   Fri, 28 Jun 2019 12:21:16 +0200
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
Subject: [RFC][PATCH 3/8] jump_label, x86: Factor out the __jump_table generation
References: <20190628102113.360432762@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Both arch_static_branch() and arch_static_branch_jump() have the same
blurb to generate the __jump_table entry, share it.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/include/asm/jump_label.h |   24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

--- a/arch/x86/include/asm/jump_label.h
+++ b/arch/x86/include/asm/jump_label.h
@@ -20,15 +20,19 @@
 #include <linux/stringify.h>
 #include <linux/types.h>
 
+#define JUMP_TABLE_ENTRY				\
+	".pushsection __jump_table,  \"aw\" \n\t"	\
+	_ASM_ALIGN "\n\t"				\
+	".long 1b - . \n\t"				\
+	".long %l[l_yes] - . \n\t"			\
+	_ASM_PTR "%c0 + %c1 - .\n\t"			\
+	".popsection \n\t"
+
 static __always_inline bool arch_static_branch(struct static_key *key, bool branch)
 {
 	asm_volatile_goto("1:"
 		".byte " __stringify(STATIC_KEY_INIT_NOP) "\n\t"
-		".pushsection __jump_table,  \"aw\" \n\t"
-		_ASM_ALIGN "\n\t"
-		".long 1b - ., %l[l_yes] - . \n\t"
-		_ASM_PTR "%c0 + %c1 - .\n\t"
-		".popsection \n\t"
+		JUMP_TABLE_ENTRY
 		: :  "i" (key), "i" (branch) : : l_yes);
 
 	return false;
@@ -39,13 +43,9 @@ static __always_inline bool arch_static_
 static __always_inline bool arch_static_branch_jump(struct static_key *key, bool branch)
 {
 	asm_volatile_goto("1:"
-		".byte 0xe9\n\t .long %l[l_yes] - 2f\n\t"
-		"2:\n\t"
-		".pushsection __jump_table,  \"aw\" \n\t"
-		_ASM_ALIGN "\n\t"
-		".long 1b - ., %l[l_yes] - . \n\t"
-		_ASM_PTR "%c0 + %c1 - .\n\t"
-		".popsection \n\t"
+		".byte 0xe9 \n\t"
+		".long %l[l_yes] - (. + 4) \n\t"
+		JUMP_TABLE_ENTRY
 		: :  "i" (key), "i" (branch) : : l_yes);
 
 	return false;


