Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB930C17441
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 14:47:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A226E21783
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 14:47:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="BJ83ZQEI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727491AbfKKOrq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 09:47:46 -0500
Received: from merlin.infradead.org ([205.233.59.134]:40984 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727363AbfKKOr2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 09:47:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=LFQwvvnKEMmErblNKbs48mN5sa0jPCoHfpYrCHI0bMk=; b=BJ83ZQEIlkrlI665hKreyC36Be
        I5A2511CIDXVPEvc9wDiOeGx3hukGLw11XQx+Ox8Rd+PXgRIIc2GfVaNot27TOeiFgFs8Y2oca4li
        3GO//5dXw4WrPldbYUc23wUPXURMEfh4WM5q5t52ES9kbusHkynw12KnQOjfN1PZyVj5shkwMaE0L
        sb/OmBQB9HCOURENzSgNDzSD3WVAR49WEs5MhO6FCMrJjU0b++d5UzklvsBcK2CwueOs3NK7fOaba
        ma1UckS0q4UOTtFInnByMrbWphN0c/01AYmM8SDW/8UpXvktLs7OtyCGC9xgFkJLZrMzy0ZPa4RQk
        Lb3DE++g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iUAyB-0003t8-Dw; Mon, 11 Nov 2019 14:47:07 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 30962307295;
        Mon, 11 Nov 2019 15:45:58 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id B1F3C29A37A94; Mon, 11 Nov 2019 15:47:03 +0100 (CET)
Message-Id: <20191111132458.460144656@infradead.org>
User-Agent: quilt/0.65
Date:   Mon, 11 Nov 2019 14:13:09 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org
Cc:     peterz@infradead.org, linux-kernel@vger.kernel.org,
        rostedt@goodmis.org, mhiramat@kernel.org, bristot@redhat.com,
        jbaron@akamai.com, torvalds@linux-foundation.org,
        tglx@linutronix.de, mingo@kernel.org, namit@vmware.com,
        hpa@zytor.com, luto@kernel.org, ard.biesheuvel@linaro.org,
        jpoimboe@redhat.com, jeyu@kernel.org, alexei.starovoitov@gmail.com
Subject: [PATCH -v5 17/17] x86/alternative: Use INT3_INSN_SIZE
References: <20191111131252.921588318@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use INT3_INSN_SIZE instead of sizeof(int3).

Suggested-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/kernel/alternative.c |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -1088,7 +1088,7 @@ static void text_poke_bp_batch(struct te
 	 * First step: add a int3 trap to the address that will be patched.
 	 */
 	for (i = 0; i < nr_entries; i++)
-		text_poke(text_poke_addr(&tp[i]), &int3, sizeof(int3));
+		text_poke(text_poke_addr(&tp[i]), &int3, INT3_INSN_SIZE);
 
 	text_poke_sync();
 
@@ -1098,10 +1098,10 @@ static void text_poke_bp_batch(struct te
 	for (do_sync = 0, i = 0; i < nr_entries; i++) {
 		int len = text_opcode_size(tp[i].opcode);
 
-		if (len - sizeof(int3) > 0) {
-			text_poke(text_poke_addr(&tp[i]) + sizeof(int3),
-				  (const char *)tp[i].text + sizeof(int3),
-				  len - sizeof(int3));
+		if (len - INT3_INSN_SIZE > 0) {
+			text_poke(text_poke_addr(&tp[i]) + INT3_INSN_SIZE,
+				  (const char *)tp[i].text + INT3_INSN_SIZE,
+				  len - INT3_INSN_SIZE);
 			do_sync++;
 		}
 	}
@@ -1123,7 +1123,7 @@ static void text_poke_bp_batch(struct te
 		if (tp[i].text[0] == INT3_INSN_OPCODE)
 			continue;
 
-		text_poke(text_poke_addr(&tp[i]), tp[i].text, sizeof(int3));
+		text_poke(text_poke_addr(&tp[i]), tp[i].text, INT3_INSN_SIZE);
 		do_sync++;
 	}
 


