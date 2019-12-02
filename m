Return-Path: <SRS0=LniW=ZY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 144BFC432C0
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 13:44:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB92C2053B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 13:44:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="d9aG1Iav"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727442AbfLBNoR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Dec 2019 08:44:17 -0500
Received: from merlin.infradead.org ([205.233.59.134]:44406 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727362AbfLBNoR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 08:44:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=kSTnxOuOJ+MtaTCiw+wP3xbdV2U8vxrHGrnB/pyAHi8=; b=d9aG1IavPqIA/FzjN6EqhenEm
        8bNSKnlMJlWTICWVxf1YS0o2MFPy/iNHDEqOXo/TJ/9GTa3FVnnuMhoKZeqjFk7eJZNbVn9N35zq2
        hxnPinoFr097Sk7bGDzulKu26rz6EMS39I+s/jdU3MLPr8k2DUTK7bArkIG99LVN6LYD5RIh2KhSB
        u+1tVyQ0v1vGHHOW5g5UxF8bFyEQFbDq/y+7tAoawq+AYOcj2PcwL3IL9gMadkPoVJbdi8V2oR4hw
        P6CaVHIg3fo3aRCDHOBpCAeiII5WGLwQ8obnqH3MbBwDIly0K9/sqdcN9WmIcXCwbq7cyeBy1P4Sx
        9SsowT7HA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iblza-0008SK-9U; Mon, 02 Dec 2019 13:43:58 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 0D2E13011DD;
        Mon,  2 Dec 2019 14:42:38 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D2BE3201A253F; Mon,  2 Dec 2019 14:43:54 +0100 (CET)
Date:   Mon, 2 Dec 2019 14:43:54 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org, bristot@redhat.com,
        jbaron@akamai.com, torvalds@linux-foundation.org,
        tglx@linutronix.de, namit@vmware.com, hpa@zytor.com,
        luto@kernel.org, ard.biesheuvel@linaro.org, jpoimboe@redhat.com,
        jeyu@kernel.org, alexei.starovoitov@gmail.com
Subject: Re: [PATCH -tip 1/2] x86/alternative: Sync bp_patching update for
 avoiding NULL pointer exception
Message-ID: <20191202134354.GF2827@hirez.programming.kicks-ass.net>
References: <157483420094.25881.9190014521050510942.stgit@devnote2>
 <157483421229.25881.15314414408559963162.stgit@devnote2>
 <20191202091519.GA2827@hirez.programming.kicks-ass.net>
 <20191202205012.8109bf98b649f38cdcd1e535@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191202205012.8109bf98b649f38cdcd1e535@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 02, 2019 at 08:50:12PM +0900, Masami Hiramatsu wrote:
> On Mon, 2 Dec 2019 10:15:19 +0100
> Peter Zijlstra <peterz@infradead.org> wrote:
> > On Wed, Nov 27, 2019 at 02:56:52PM +0900, Masami Hiramatsu wrote:

> > > --- a/arch/x86/kernel/alternative.c
> > > +++ b/arch/x86/kernel/alternative.c
> > > @@ -1134,8 +1134,14 @@ static void text_poke_bp_batch(struct text_poke_loc *tp, unsigned int nr_entries
> > >  	 * sync_core() implies an smp_mb() and orders this store against
> > >  	 * the writing of the new instruction.
> > >  	 */
> > > -	bp_patching.vec = NULL;
> > >  	bp_patching.nr_entries = 0;
> > > +	/*
> > > +	 * This sync_core () ensures that all int3 handlers in progress
> > > +	 * have finished. This allows poke_int3_handler () after this to
> > > +	 * avoid touching bp_paching.vec by checking nr_entries == 0.
> > > +	 */
> > > +	text_poke_sync();
> > > +	bp_patching.vec = NULL;
> > >  }
> > 
> > Hurm.. is there no way we can merge that with the 'last'
> > text_poke_sync() ? It seems a little daft to do 2 back-to-back IPI
> > things like that.
> 
> Maybe we can add a NULL check of bp_patchig.vec in poke_int3_handler()
> but it doesn't ensure the fundamental safeness, because the array
> pointed by bp_patching.vec itself can be released while
> poke_int3_handler() accesses it.

No, what I mean is something like:

diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 30e86730655c..347a234a7c52 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -1119,17 +1119,13 @@ static void text_poke_bp_batch(struct text_poke_loc *tp, unsigned int nr_entries
 	 * Third step: replace the first byte (int3) by the first byte of
 	 * replacing opcode.
 	 */
-	for (do_sync = 0, i = 0; i < nr_entries; i++) {
+	for (i = 0; i < nr_entries; i++) {
 		if (tp[i].text[0] == INT3_INSN_OPCODE)
 			continue;
 
 		text_poke(text_poke_addr(&tp[i]), tp[i].text, INT3_INSN_SIZE);
-		do_sync++;
 	}
 
-	if (do_sync)
-		text_poke_sync();
-
 	/*
 	 * sync_core() implies an smp_mb() and orders this store against
 	 * the writing of the new instruction.


Or is that unsafe ?
