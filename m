Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9892C352AA
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 11:24:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EFE92173B
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 11:24:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YR2DG0Fb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728132AbfJGLYx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 07:24:53 -0400
Received: from merlin.infradead.org ([205.233.59.134]:58268 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727801AbfJGLXk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 07:23:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=IGKCF3NuFnyybDTJh/xDdKD8BmS4wqN5+SIQw04FGZ8=; b=YR2DG0FbhF77cOvbH+O7+zduL5
        U3dWdqm/d/YxsJi1juaLMOlx5nJ+J4Znrbivk511mnO1I2Kc2KJjN7zGuBVlEkUiw+GLrad+Ih0Ht
        qAm+0tJw+Xfc7o/vnI/aSi16HI8JGQVjIy2ruU5IjAYfbCQEdkAKDJSSIawUiFWK7xmOUgr2fu9up
        HjBOrPS/fZT8os/8ni6wZPPLr8jc/DrE5z5SPZpZy08oRepGi+YoId1kVgkFbZUKyGAK5Z50nJvvz
        s5L1Xmr61IWKxEM/PtJoJ0JP6qH5FbicGk9FkeZoMqMndAwPTyxJQgptHTRHo/aN3LiqeLCaXrx/Z
        ineXW4ow==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iHR6x-0002BM-QF; Mon, 07 Oct 2019 11:23:31 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 538483073C5;
        Mon,  7 Oct 2019 13:22:36 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 01A2320244E46; Mon,  7 Oct 2019 13:23:27 +0200 (CEST)
Message-Id: <20191007090012.00469193.6@infradead.org>
User-Agent: quilt/0.65
Date:   Mon, 07 Oct 2019 10:44:47 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org
Cc:     peterz@infradead.org, linux-kernel@vger.kernel.org,
        rostedt@goodmis.org, mhiramat@kernel.org, bristot@redhat.com,
        jbaron@akamai.com, torvalds@linux-foundation.org,
        tglx@linutronix.de, mingo@kernel.org, namit@vmware.com,
        hpa@zytor.com, luto@kernel.org, ard.biesheuvel@linaro.org,
        jpoimboe@redhat.com, hjl.tools@gmail.com
Subject: [RFC][PATCH 4/9] jump_label, x86: Improve error when we fail expected text
References: <20191007084443.79370128.1@infradead.org>
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
 arch/x86/kernel/jump_label.c |   23 ++++++++++-------------
 1 file changed, 10 insertions(+), 13 deletions(-)

--- a/arch/x86/kernel/jump_label.c
+++ b/arch/x86/kernel/jump_label.c
@@ -16,17 +16,6 @@
 #include <asm/alternative.h>
 #include <asm/text-patching.h>
 
-static void bug_at(const void *ip, int line)
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
 static const void *
 __jump_label_set_jump_code(struct jump_entry *entry, enum jump_label_type type, int init)
 {
@@ -49,8 +38,16 @@ __jump_label_set_jump_code(struct jump_e
 		expect = code; line = __LINE__;
 	}
 
-	if (memcmp(addr, expect, JUMP_LABEL_NOP_SIZE))
-		bug_at(addr, line);
+	if (memcmp(addr, expect, JUMP_LABEL_NOP_SIZE)) {
+		/*
+		 * The location is not an op that we were expecting.
+		 * Something went wrong. Crash the box, as something could be
+		 * corrupting the kernel.
+		 */
+		pr_crit("jump_label: Fatal kernel bug, unexpected op at %pS [%p] (%5ph != %5ph)) line:%d init:%d type:%d\n",
+				addr, addr, addr, expect, line, init, type);
+		BUG();
+	}
 
 	if (type == JUMP_LABEL_NOP)
 		code = ideal_nop;


