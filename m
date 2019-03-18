Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1C1FC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 14:55:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BE7520880
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 14:55:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="2H4yOUMM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727102AbfCROzQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 10:55:16 -0400
Received: from merlin.infradead.org ([205.233.59.134]:57858 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726677AbfCROzQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 10:55:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=DveGjV7VlNIt6I9Qj4f1jQT9M6xmzD8Nsl/pc6btbd0=; b=2H4yOUMM3xxSTNR8eLH1gQKtG
        WnRYGNBxhBTtPl7VbjNkm8HNiwmHBxM1uUyJAdBQGic0ByeVSqIoDYL/nc+qJ1nJOutiTkl0Q+rVE
        Lu4qrsBOp0JioXt8vyoTxdOIbFQ5Fi5ucWxcJmBfbZJpfSTJc4vy63KfkZ1ngUX29iuGm2uZatnVh
        hyUFVsndQq/7k2VxSjwXUG/F12NlFR+jcdLD2UYNtkxi1+34FIb2JnoUoCdqjM2E4fzIgHT9C8M0z
        ECuQzdqTBfJNX2SyCgITzsabdqdaub+iMdu+EwanyLbL6FnYemGbbt7iKqWbd4nSyQUiFDFyIGRtC
        KfOHqUK3A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h5tfE-0004QW-OB; Mon, 18 Mar 2019 14:54:57 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id EF69D2030E114; Mon, 18 Mar 2019 15:54:54 +0100 (CET)
Date:   Mon, 18 Mar 2019 15:54:54 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     David Laight <David.Laight@ACULAB.COM>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        "x86@kernel.org" <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Manoj Gupta <manojgupta@chromium.org>,
        Tiancong Wang <tcwang@chromium.org>,
        Stephen Hines <srhines@google.com>,
        "clang-built-linux@googlegroups.com" 
        <clang-built-linux@googlegroups.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Subject: Re: [PATCH] lib: Add shared copy of __lshrti3 from libgcc
Message-ID: <20190318145454.GS6058@hirez.programming.kicks-ass.net>
References: <CAG5bF+S6OvBnsaR6UpMCqjDR9_hMo6qRMHGiW+iCaRYQW4C3YA@mail.gmail.com>
 <CAKwvOdkfb_DT2p2vvxK2ye6JpGYB4qqCc8yECU_JEkrc+6HXDA@mail.gmail.com>
 <20190318091428.GI6058@hirez.programming.kicks-ass.net>
 <cccfcd81efcf47a9ad2ddec7219a797d@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cccfcd81efcf47a9ad2ddec7219a797d@AcuMS.aculab.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 18, 2019 at 02:43:41PM +0000, David Laight wrote:
> From: Peter Zijlstra
> > Sent: 18 March 2019 09:14
> > On Fri, Mar 15, 2019 at 03:06:37PM -0700, Nick Desaulniers wrote:
> > > On Fri, Mar 15, 2019 at 1:54 PM Matthias Kaehlcke <mka@chromium.org> wrote:
> > > >
> > > > The compiler may emit calls to __lshrti3 from the compiler runtime
> > > > library, which results in undefined references:
> > > >
> > > > arch/x86/kvm/x86.o: In function `mul_u64_u64_shr':
> > > >   include/linux/math64.h:186: undefined reference to `__lshrti3'
> > >
> > > Looks like Clang will emit this at -Oz (but not -O2):
> > > https://godbolt.org/z/w1_2YC
> > 
> > *OMG*, what is that compiler smoking and why do we want that?
> > 
> > It doesn't even do that for "-Os".
> 
> I like the way it moves %edx to %ecx, then %cl to %ecx and finally %ecx back to %edx.
> I'm guessing this is all made worse by the prototype containing 'char' not 'int'.
> 
> I'm sure the register tracking gets worse in every version of gcc.

This is clang, no GCC on that list comes even close to generating
anything as 'brilliant' as that.
