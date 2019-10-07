Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE36EC47404
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 12:08:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DEE3218AC
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 12:08:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="u5bgzcz1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727951AbfJGMIF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 08:08:05 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:48912 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727467AbfJGMIF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 08:08:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=rqI/O0G3FNLk7QEjU1ZgKHZVA7miIjxPx4qhFuLG5ms=; b=u5bgzcz1Yyc9JonlH763GgK++
        gPpG9IciMIzvfFK8WjWg8lCuH2YmrajM2OjNY6JlDK6OF5X59m3L8w4xpcgThuuicVmvyeUmgfXxw
        ZG9NuTab8+l9LDfq7xhg4LuzjmYMDKHQW4/Tlj92oDEXhg+IqTFtzRLhR2Dh1nuKE3anIM2u2CAX4
        b5AVWg5HYWnW+CzRyaHePKObIgxiZhbsFzHAHUxmPcB+txRrC/1KrY8D2FqjgdXugEbyp3xVB9U1K
        7GjElNEguNtJNKhnjwYXnhSa7DccCaiOnHnp5+9+BA8ER3K3YTwDVFc3lCZmqT9BDCm58RSRCos0q
        ezk4eKsJw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iHRny-00050E-Ua; Mon, 07 Oct 2019 12:07:59 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 0661A305E32;
        Mon,  7 Oct 2019 14:07:06 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E586F20247CA6; Mon,  7 Oct 2019 14:07:56 +0200 (CEST)
Date:   Mon, 7 Oct 2019 14:07:56 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, rostedt@goodmis.org,
        mhiramat@kernel.org, bristot@redhat.com, jbaron@akamai.com,
        torvalds@linux-foundation.org, tglx@linutronix.de,
        mingo@kernel.org, namit@vmware.com, hpa@zytor.com, luto@kernel.org,
        ard.biesheuvel@linaro.org, jpoimboe@redhat.com, hjl.tools@gmail.com
Subject: Re: [RFC][PATCH 0/9] Variable size jump_label support
Message-ID: <20191007120756.GE2311@hirez.programming.kicks-ass.net>
References: <20191007090225.44108711.6@infradead.org>
 <20191007084443.79370128.1@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191007084443.79370128.1@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


In the failed thread Ingo posted:

>On Mon, Oct 07, 2019 at 01:26:06PM +0200, Ingo Molnar wrote:
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

IIRC the recordmcount variant from Steve was also rewriting JMP8 to NOP2
at build time.

I dug this here link out of my IRC logs:

  https://lore.kernel.org/lkml/1318007374.4729.58.camel@gandalf.stny.rr.com/

Looking at that, part of the reason might've been running yet another
tool, instead of having one tool do everything.

