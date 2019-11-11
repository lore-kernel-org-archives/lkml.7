Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED9EDC43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 14:47:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C31EA2190F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 14:47:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UEjk1b7F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727401AbfKKOrX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 09:47:23 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:48674 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727355AbfKKOrS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 09:47:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=eCzyQp0N/0lsSk1d3IkTJatCuFiOdLMeuV/Po57Dr4E=; b=UEjk1b7FwRmoFAXTWlcguqeJVd
        +UxkD8HLuYlnw8gWoVT/21RPurrFJjUHUreGDBDHA6cqrMHQ/+2i7YRNHeidyEw07eClZxlc4ydKy
        l2bn/5FRWVSn4IK9u7j0R0DwWcbKcSiAJnaOTP7Kf/RXr9dwGMTuwgZ6PkeJ6tD8rkqNBHT4RdeI8
        YhjSvIJ1MxXvMpZPxAM6n+oXMa/7rLkyeGTFHSSL+3MIXaOrPgpMIo3BTZKkT42eAjt0bEueGmLqX
        fd3AimoRr7osM9zqg+e8BmI/OcQf/sQ6N/igex2Sv0I4/30OuHapxf4JYUL7zFDp2N80OzPHPOfpI
        PN63tVgQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iUAy9-0006Zf-Sk; Mon, 11 Nov 2019 14:47:06 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 327D8305DE2;
        Mon, 11 Nov 2019 15:45:57 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 70F9429980EFA; Mon, 11 Nov 2019 15:47:03 +0100 (CET)
Message-Id: <20191111132457.588386013@infradead.org>
User-Agent: quilt/0.65
Date:   Mon, 11 Nov 2019 14:12:54 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org
Cc:     peterz@infradead.org, linux-kernel@vger.kernel.org,
        rostedt@goodmis.org, mhiramat@kernel.org, bristot@redhat.com,
        jbaron@akamai.com, torvalds@linux-foundation.org,
        tglx@linutronix.de, mingo@kernel.org, namit@vmware.com,
        hpa@zytor.com, luto@kernel.org, ard.biesheuvel@linaro.org,
        jpoimboe@redhat.com, jeyu@kernel.org, alexei.starovoitov@gmail.com
Subject: [PATCH -v5 02/17] x86/alternatives: Update int3_emulate_push() comment
References: <20191111131252.921588318@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the comment now that we've merged x86_32 support.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/include/asm/text-patching.h |    3 +++
 1 file changed, 3 insertions(+)

--- a/arch/x86/include/asm/text-patching.h
+++ b/arch/x86/include/asm/text-patching.h
@@ -85,6 +85,9 @@ static inline void int3_emulate_push(str
 	 * stack where the break point happened, and the saving of
 	 * pt_regs. We can extend the original stack because of
 	 * this gap. See the idtentry macro's create_gap option.
+	 *
+	 * Similarly entry_32.S will have a gap on the stack for (any) hardware
+	 * exception and pt_regs; see FIXUP_FRAME.
 	 */
 	regs->sp -= sizeof(unsigned long);
 	*(unsigned long *)regs->sp = val;


