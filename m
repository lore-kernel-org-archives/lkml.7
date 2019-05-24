Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACD63C282E3
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 16:00:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 821712184E
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 16:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558713621;
	bh=M2tkTCd1HtjGQ8oLh531w13Z/3FsamYXNtMhYKv/b14=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=NR0ZMmB17cgABidrHlJwVbwdvDhzdbkySD0B8yipy9Ac1dzNCHG430ZTv/7ToFYSj
	 Zh4u3xRSer1x2wgGmV+y2A1iSizGMClx4BAn36fzns9j607JIcsDdhHO1z8SPFw1n0
	 6+NO/G4nPxh7PCfkZjiNDOtWoAEgeJQJlDqg/Tl8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391038AbfEXQAU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 12:00:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:52260 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389812AbfEXQAT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 12:00:19 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B697121848;
        Fri, 24 May 2019 16:00:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558713618;
        bh=M2tkTCd1HtjGQ8oLh531w13Z/3FsamYXNtMhYKv/b14=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FIAY1jjmbBSUJGCWCqZKEwY13pPykhqusQa9hkP/QU070Ft/uHfLAB0d/2WHtUfCJ
         uj/TVBiHPE7DnuA0CwxzEUR7zXlOzPVaTk6E3xDQ7nZ0NU6TnQizXAWCperytOnz5T
         g4BXd7wIKqXXjfT7jajFPZK1Q7ev73yajJH9gH+Q=
Date:   Fri, 24 May 2019 18:00:15 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Cliff Whickman <cpw@sgi.com>,
        Robin Holt <robinmholt@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Stephen Hines <srhines@google.com>,
        Tony Luck <tony.luck@intel.com>, rja@sgi.com,
        Fenghua Yu <fenghua.yu@intel.com>
Subject: Re: [PATCH] misc: sgi-xp: Properly initialize buf in
 xpc_get_rsvd_page_pa
Message-ID: <20190524160015.GA7590@kroah.com>
References: <CAAzmS69VFrTPzZ8DY_NPPTZYtBssocRnQOFAyo3VbSTO4CesbA@mail.gmail.com>
 <20190523161532.122421-1-natechancellor@gmail.com>
 <CAKwvOdmjQvCh__ZH+gLLgcKy4u1n5cgJQPU1WRuitEp+UZra5w@mail.gmail.com>
 <CAK8P3a3RE3Jwft6WTNavV7St3P+mVFwRyCQFVaO3==LB7j29rw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a3RE3Jwft6WTNavV7St3P+mVFwRyCQFVaO3==LB7j29rw@mail.gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 24, 2019 at 09:40:47AM +0200, Arnd Bergmann wrote:
> On Thu, May 23, 2019 at 8:05 PM 'Nick Desaulniers' via Clang Built
> Linux <clang-built-linux@googlegroups.com> wrote:
> >
> > On Thu, May 23, 2019 at 9:20 AM Nathan Chancellor
> > <natechancellor@gmail.com> wrote:
> > >
> > > Clang warns:
> > >
> > > drivers/misc/sgi-xp/xpc_partition.c:73:14: warning: variable 'buf' is
> > > uninitialized when used within its own initialization [-Wuninitialized]
> > >         void *buf = buf;
> > >               ~~~   ^~~
> > > 1 warning generated.
> > >
> > > Initialize it to NULL, which is more deterministic.
> > >
> > > Fixes: 279290294662 ("[IA64-SGI] cleanup the way XPC locates the reserved page")
> > > Link: https://github.com/ClangBuiltLinux/linux/issues/466
> > > Suggested-by: Stephen Hines <srhines@google.com>
> > > Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> >
> > From https://github.com/ClangBuiltLinux/linux/issues/466#issuecomment-488781917
> > I tried to follow the rabbit hole, but eventually these void* get
> > converted to u64's and passed along to function that I have no idea
> > whether they handle the value `(u64)(void*)0` or not.  Either way,
> > they definitely don't handle uninitialized values/UB.
> >
> > I was going to cc Robin who's already cc'ed, but looks like this code
> > was last touched 7-10 years ago. + Tony and Fenghua for ia64 since
> > sn_partition_reserved_page_pa is defined in
> > arch/ia64/include/asm/sn/sn_sal.h.
> >
> > In absence of consensus, I'll prefer NULL to uninitialized.
> > Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
> > Thanks Nathan for following up on this.
> 
> I also had to take a look, and I think I understand what's going on,
> and interestingly, the code is correct, both before and after your patch.
> It's described in this comment:
> 
> /*
>  * Returns the physical address of the partition's reserved page through
>  * an iterative number of calls.
>  *
>  * On first call, 'cookie' and 'len' should be set to 0, and 'addr'
>  * set to the nasid of the partition whose reserved page's address is
>  * being sought.
>  * On subsequent calls, pass the values, that were passed back on the
>  * previous call.
>  *
>  * While the return status equals SALRET_MORE_PASSES, keep calling
>  * this function after first copying 'len' bytes starting at 'addr'
>  * into 'buf'. Once the return status equals SALRET_OK, 'addr' will
>  * be the physical address of the partition's reserved page. If the
>  * return status equals neither of these, an error as occurred.
>  */
> static inline s64
> sn_partition_reserved_page_pa(u64 buf, u64 *cookie, u64 *addr, u64 *len)
> 
> so *len is set to zero on the first call and tells the bios how many bytes
> are accessible at 'buf', and it does get updated by the BIOS to tell
> us how many bytes it needs, and then we allocate that and try again.
> 
> With that explanation added,
> 
> Reviewed-by: Arnd Bergmann <arnd@arndb.de>

Nathan, can you add this to the changelog comment and add the reviewed
by lines and resend it so I can queue it up?

thanks,

greg k-h
