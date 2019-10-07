Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92357C47404
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 15:17:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DE2F2054F
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 15:17:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728340AbfJGPRq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 11:17:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:39038 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727490AbfJGPRp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 11:17:45 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0B52F2053B;
        Mon,  7 Oct 2019 15:17:43 +0000 (UTC)
Date:   Mon, 7 Oct 2019 11:17:42 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org, mhiramat@kernel.org,
        bristot@redhat.com, jbaron@akamai.com,
        torvalds@linux-foundation.org, tglx@linutronix.de,
        namit@vmware.com, hpa@zytor.com, luto@kernel.org,
        ard.biesheuvel@linaro.org, jpoimboe@redhat.com,
        hjl.tools@gmail.com, Andrew Morton <akpm@linux-foundation.org>,
        Borislav Petkov <bp@alien8.de>,
        Denys Vlasenko <dvlasenk@redhat.com>
Subject: Re: [RFC][PATCH 0/9] Variable size jump_label support
Message-ID: <20191007111742.00d6c50b@gandalf.local.home>
In-Reply-To: <20191007112606.GA44864@gmail.com>
References: <20191007090225.441087116@infradead.org>
        <20191007084443.793701281@infradead.org>
        <20191007112229.GA3221@gmail.com>
        <20191007112606.GA44864@gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 Oct 2019 13:26:06 +0200
Ingo Molnar <mingo@kernel.org> wrote:

> [ Sorry, fixed the Cc:lkml line. ]

/me joining the fun.

> 
> * Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > These here patches are something I've been poking at for a while, 
> > enabling jump_label to use 2 byte jumps/nops.
> > 
> > It _almost_ works :-/
> > 
> > That is, you can build some kernels with it (x86_64-defconfig for 
> > example works just fine).
> > 
> > The problem comes when GCC generates a branch into another section, 
> > mostly .text.unlikely. At that point GAS just gives up and throws a fit 
> > (more details in the last patch).
> > 
> > Aside from anyone coming up with a really clever GAS trick, I don't see 
> > how we can do this other than:  
> 
> >  - use 'jmp' and get objtool to rewrite the text. Steven has earlier proposed
> >    something like that (using recordmcount) and Linus hated that.  
> 
> As long as GCC+GAS correctly generates a 2-byte or 5-byte JMP depending 
> on the target distance, the objtool solution should work fine, shouldn't 
> it?
> 
> I can see the recordmcount solution sucking, it would depend on early 
> kernel patchery. But build time patchery is something we already depend 
> on, so assuming some objtool catastrophy it's a more robust solution, 
> isn't it?
> 

Actually, even back then I said that it would be best to merge all the
tools into one (I just didn't have the time to implement it), and then
we could pull this off. I have one of my developers working to merge
record-mcount into objtool now (there's been some patches floating
around).

Then with a single tool, it shouldn't be controversial.

-- Steve
