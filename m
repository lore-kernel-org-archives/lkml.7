Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D3D7C10F14
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 12:32:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2AC420862
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 12:32:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Xs0UHHdS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730164AbfJCMcw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 08:32:52 -0400
Received: from merlin.infradead.org ([205.233.59.134]:51172 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730027AbfJCMcs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 08:32:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=7fYz0vJ661x367z1HdxIQ8T0lQiWOwZl1Be5LTqF4ZE=; b=Xs0UHHdSC+UJC+tSmcoYeljSA
        PnOky73ndEHrdXF4iMRu+TJd3ak2L74zMgu1wGVPUKyLQZ0aUtdGaQ2+eNYmqRdzZ8dR/6yG/bySz
        tAPJpjkMKftuB3cOiuMqxIgSSGgyGnL8zim5cirp8Ak6G7E0BKpP1HOYmTG13Z6GfZJatvWzke4Sq
        MSk5aMwF0dI+fDSXUCDNqwk/R31sFNR310ydIYjSfOex6vrg3AsL4IgB1YSPKFK09P96SGiWtRLDo
        evcWPTw964PlMxqi27LEQhmdgZUAaBr3UkptRqL4O9y04m1OXejYfNLE8NLkaJd3kCalqOh94bYQq
        hxuDNjrAg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iG0Ha-0006sG-CU; Thu, 03 Oct 2019 12:32:34 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 41A2C3060F2;
        Thu,  3 Oct 2019 14:31:42 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7DA7C201DF21A; Thu,  3 Oct 2019 14:32:31 +0200 (CEST)
Date:   Thu, 3 Oct 2019 14:32:31 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Nadav Amit <nadav.amit@gmail.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Song Liu <songliubraving@fb.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: Re: [PATCH 1/3] x86/alternatives: Teach text_poke_bp() to emulate
 instructions
Message-ID: <20191003123231.GK4581@hirez.programming.kicks-ass.net>
References: <20190827180622.159326993@infradead.org>
 <20190827181147.053490768@infradead.org>
 <20191003140050.1d4cf59d3de8b5396d36c269@kernel.org>
 <20191003082751.GQ4536@hirez.programming.kicks-ass.net>
 <20191003110106.GI4581@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191003110106.GI4581@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 03, 2019 at 01:01:06PM +0200, Peter Zijlstra wrote:
> Also, I think text_poke_bp(INT3) is broken, although I don't think
> anybody actually does that. Still, let me fix that.

Something like so should allow text_poke_bp(INT3) to work as expected.

---
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -999,6 +999,13 @@ int poke_int3_handler(struct pt_regs *re
 	ip += tp->len;
 
 	switch (tp->opcode) {
+	case INT3_INSN_OPCODE:
+		/*
+		 * Someone poked an explicit INT3, they'll want to handle it,
+		 * do not consume.
+		 */
+		return 0;
+
 	case CALL_INSN_OPCODE:
 		int3_emulate_call(regs, (long)ip + tp->rel32);
 		break;
@@ -1040,8 +1047,8 @@ NOKPROBE_SYMBOL(poke_int3_handler);
 void text_poke_bp_batch(struct text_poke_loc *tp, unsigned int nr_entries)
 {
 	unsigned char int3 = INT3_INSN_OPCODE;
-	int patched_all_but_first = 0;
 	unsigned int i;
+	int do_sync;
 
 	lockdep_assert_held(&text_mutex);
 
@@ -1065,16 +1072,16 @@ void text_poke_bp_batch(struct text_poke
 	/*
 	 * Second step: update all but the first byte of the patched range.
 	 */
-	for (i = 0; i < nr_entries; i++) {
+	for (do_sync = 0, i = 0; i < nr_entries; i++) {
 		if (tp[i].len - sizeof(int3) > 0) {
 			text_poke((char *)tp[i].addr + sizeof(int3),
 				  (const char *)tp[i].text + sizeof(int3),
 				  tp[i].len - sizeof(int3));
-			patched_all_but_first++;
+			do_sync++;
 		}
 	}
 
-	if (patched_all_but_first) {
+	if (do_sync) {
 		/*
 		 * According to Intel, this core syncing is very likely
 		 * not necessary and we'd be safe even without it. But
@@ -1087,10 +1094,17 @@ void text_poke_bp_batch(struct text_poke
 	 * Third step: replace the first byte (int3) by the first byte of
 	 * replacing opcode.
 	 */
-	for (i = 0; i < nr_entries; i++)
+	for (do_sync = 0, i = 0; i < nr_entries; i++) {
+		if (tp[i].text[0] == INT3_INSN_OPCODE)
+			continue;
+
 		text_poke(tp[i].addr, tp[i].text, sizeof(int3));
+		do_sync++;
+	}
+
+	if (do_sync)
+		on_each_cpu(do_sync_core, NULL, 1);
 
-	on_each_cpu(do_sync_core, NULL, 1);
 	/*
 	 * sync_core() implies an smp_mb() and orders this store against
 	 * the writing of the new instruction.
@@ -1123,6 +1137,9 @@ void text_poke_loc_init(struct text_poke
 	tp->opcode = insn.opcode.bytes[0];
 
 	switch (tp->opcode) {
+	case INT3_INSN_OPCPDE:
+		break;
+
 	case CALL_INSN_OPCODE:
 	case JMP32_INSN_OPCODE:
 	case JMP8_INSN_OPCODE:
