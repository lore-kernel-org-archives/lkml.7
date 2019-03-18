Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB1F4C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 09:14:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 708A620857
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 09:14:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="tttwVrK8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727022AbfCRJOo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 05:14:44 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:43732 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726466AbfCRJOn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 05:14:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=2ZBQxEhzqiwXwolRtbcmbVsrSgBbYcPXtjPXuicD4Qg=; b=tttwVrK8pznlnrxpO1WDMC5i2
        esHJriNpX2j7ef4vhfXg5rf46i0IC5W/50y33q+NHe+EMCPjrueduPCFqC2G7DKM+1SLPRcwxbccm
        5QHKbWUkDBIRu0iLdFKGHAfiioM4vzDmelgXDOGR4lnNXPpYFb7yVDWdVmaqbbySiXDBdTp9M7E8v
        DMXXmMcIX1VC6Yo7rfRZkvCOE2pN/5DrbdbxGVYqelI/wtt2PnmbrQd7hr540i2tMbIgZbmphTU93
        GhFcSU9qaUad2fu7HpxTjup8Tc98ry/mUKkrQ0WLZ6IVn0/FSJGlnWF5oU9PJv4lDhhWAZxid79zS
        8iGTM13Ew==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h5oLl-0001vy-TG; Mon, 18 Mar 2019 09:14:30 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3E784202194EC; Mon, 18 Mar 2019 10:14:28 +0100 (CET)
Date:   Mon, 18 Mar 2019 10:14:28 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Matthias Kaehlcke <mka@chromium.org>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Manoj Gupta <manojgupta@chromium.org>,
        Tiancong Wang <tcwang@chromium.org>,
        Stephen Hines <srhines@google.com>,
        clang-built-linux@googlegroups.com,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Subject: Re: [PATCH] lib: Add shared copy of __lshrti3 from libgcc
Message-ID: <20190318091428.GI6058@hirez.programming.kicks-ass.net>
References: <CAG5bF+S6OvBnsaR6UpMCqjDR9_hMo6qRMHGiW+iCaRYQW4C3YA@mail.gmail.com>
 <CAKwvOdkfb_DT2p2vvxK2ye6JpGYB4qqCc8yECU_JEkrc+6HXDA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOdkfb_DT2p2vvxK2ye6JpGYB4qqCc8yECU_JEkrc+6HXDA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 15, 2019 at 03:06:37PM -0700, Nick Desaulniers wrote:
> On Fri, Mar 15, 2019 at 1:54 PM Matthias Kaehlcke <mka@chromium.org> wrote:
> >
> > The compiler may emit calls to __lshrti3 from the compiler runtime
> > library, which results in undefined references:
> >
> > arch/x86/kvm/x86.o: In function `mul_u64_u64_shr':
> >   include/linux/math64.h:186: undefined reference to `__lshrti3'
> 
> Looks like Clang will emit this at -Oz (but not -O2):
> https://godbolt.org/z/w1_2YC

*OMG*, what is that compiler smoking and why do we want that?

It doesn't even do that for "-Os".

So where "-Os" is "Optimize for Sadness" this "-Oz" thing is like a
downright depression. Please just take it out back. Don't enable crap
like this.
