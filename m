Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2230ECE58C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 15:08:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D201B21479
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 15:08:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729074AbfJGPII (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 11:08:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:34038 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729050AbfJGPIH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 11:08:07 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D3D692070B;
        Mon,  7 Oct 2019 15:08:05 +0000 (UTC)
Date:   Mon, 7 Oct 2019 11:08:04 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org, mhiramat@kernel.org,
        bristot@redhat.com, jbaron@akamai.com,
        torvalds@linux-foundation.org, tglx@linutronix.de,
        namit@vmware.com, hpa@zytor.com, luto@kernel.org,
        ard.biesheuvel@linaro.org, jpoimboe@redhat.com, hjl.tools@gmail.com
Subject: Re: [RFC][PATCH 0/9] Variable size jump_label support
Message-ID: <20191007110804.66edaa03@gandalf.local.home>
In-Reply-To: <20191007125519.GA56546@gmail.com>
References: <20191007090225.44108711.6@infradead.org>
        <20191007084443.79370128.1@infradead.org>
        <20191007120756.GE2311@hirez.programming.kicks-ass.net>
        <20191007125519.GA56546@gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 Oct 2019 14:55:19 +0200
Ingo Molnar <mingo@kernel.org> wrote:

> * Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > IIRC the recordmcount variant from Steve was also rewriting JMP8 to NOP2
> > at build time.
> >
> > I dug this here link out of my IRC logs:
> > 
> >   https://lore.kernel.org/lkml/1318007374.4729.58.camel@gandalf.stny.rr.com/  
> 
> Ancient indeed ...
> 
> > Looking at that, part of the reason might've been running yet another 
> > tool, instead of having one tool do everything.  
> 
> Yeah - that too wouldn't be a problem with objtool, as we are running it 
> anyway, right?
> 
> So I can see about 2 valid technical reasons why Linus would have 
> objected to that old approach from Steve while finding the objtool 
> approach more acceptable.
> 
> Basically the main assumption is that we better never run out of 
> competent objtool experts... :-)

Actually, even back then I said that it would be best to merge all the
tools into one (I just didn't have the time to implement it), and then
we could pull this off. I have one of my developers working to merge
record-mcount into objtool now (there's been some patches floating
around).

Then with a single tool, it shouldn't be controversial.

-- Steve
