Return-Path: <SRS0=Ybdz=SI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96975C10F06
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Apr 2019 08:21:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 496E021855
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Apr 2019 08:21:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554538871;
	bh=zWLgtTsEcoMzoCnMLfF4Dnx0+sZuVMArPI+DXGDnkgo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=guIaJGCpKGtqnTNoKkH5nSaUX9mGrzgTjA5N0hHBPvLsvY19+RyxJiznxRt+tl4MZ
	 lNxUJ0rmrSyUsDmg+msHhN7X34xCrqfwpFiK2npBjKY+djPeT+0qftI+JSbMkbaUfG
	 IIEl3GOX3lRprqAAdwrhz9FBmOjEPt8ct8iEn3mU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726547AbfDFIVA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Apr 2019 04:21:00 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40123 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725934AbfDFIU7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Apr 2019 04:20:59 -0400
Received: by mail-wr1-f67.google.com with SMTP id h4so10506455wre.7
        for <linux-kernel@vger.kernel.org>; Sat, 06 Apr 2019 01:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=k9rU9yghYK83XVvUxVZz9qHGLtaOf1zUAeQp9He60z8=;
        b=fHdZPpnR6QlAirCKpT24d3eenSd1Sl6rr65Zg/wypk4E18lSIJfSek488Kxxx2mSIQ
         8shPkat68CJfX1T/TpHd9cI6xZhtToKdvZbpWQ+I/wink29c1+i4Y4us1nsRs9MWszKi
         6tfYMav0XAIft7gr1R9aQhoStCll56BDR0BORANWncjOJPsa4SMabv6uBQcKMyQqWnWX
         7pNxhyE9/jwU9RuV8ojNK3qay0iftBZZx5nj1m9usBYK5aUPYJL+s3NAWZNcWoLigIsx
         tfKJVvh+aAJe5PuBNuEBEYXsohV6+ei9Ipjuqp+yQvGZZBzgAijxxGUSZHmh6+4wPKt/
         /GPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=k9rU9yghYK83XVvUxVZz9qHGLtaOf1zUAeQp9He60z8=;
        b=I1H5oCNeRLesV4JghONSvhGA9dsc+qLlg0B5+ij+XDWr+pYRcZbRNcQDCpNF7u5Q1P
         p9pRcNeWthb6HgHPXdibUkfmSvluOd2bQgYaMC+GgZj2gYpPkOH1NVrBeYEZxWi4K9m/
         KZheX4OgDZ1xh41h5yIHp0p0l5MAMrhNuA2BnlgotLD+WD96rrMEP68fbyrm8aMvaNTz
         5QkHb87Z5BVXQVofurPhkTTL4Ini7JTtvk1P6VPOhmGLk53476ozXXBH5hvkj7jdjxU6
         BGb2uk4kvBg+reI33zG3vfSR+M/CiPWNQvV5d7AEKYPFNLapuh0KMzdsdhUVlHZTu5We
         q2jw==
X-Gm-Message-State: APjAAAXhbVlsp6HlcYwnVmYN5Ef09u+bnDIRbyRDqvP0EHNlxxnOPupZ
        Bp8vf0ilaycU/lzQSEDpWM0Oni5J
X-Google-Smtp-Source: APXvYqwcNY4322ULUXZReU23ZtdeZCZKWcPvzXJNplXKJUBcb4D87sulGeSrojgiGqkX4/GBNKvKGw==
X-Received: by 2002:a5d:63c5:: with SMTP id c5mr11938376wrw.82.1554538856771;
        Sat, 06 Apr 2019 01:20:56 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id o2sm20003867wrs.89.2019.04.06.01.20.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 06 Apr 2019 01:20:55 -0700 (PDT)
Date:   Sat, 6 Apr 2019 10:20:53 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Alexander Potapenko <glider@google.com>
Cc:     Paul McKenney <paulmck@linux.ibm.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Dmitriy Vyukov <dvyukov@google.com>,
        James Y Knight <jyknight@google.com>, x86@kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH v2] x86/asm: fix assembly constraints in bitops
Message-ID: <20190406082053.GA33988@gmail.com>
References: <20190402112813.193378-1-glider@google.com>
 <20190405093931.GA28890@gmail.com>
 <CAG_fn=VxwY4KmY5_X3RTdNw9DhSSbozHh5jRGs4YnkkYh6iiFw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG_fn=VxwY4KmY5_X3RTdNw9DhSSbozHh5jRGs4YnkkYh6iiFw@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Alexander Potapenko <glider@google.com> wrote:

> On Fri, Apr 5, 2019 at 11:39 AM Ingo Molnar <mingo@kernel.org> wrote:
> >
> >
> > * Alexander Potapenko <glider@google.com> wrote:
> >
> > > 1. Use memory clobber in bitops that touch arbitrary memory
> > >
> > > Certain bit operations that read/write bits take a base pointer and an
> > > arbitrarily large offset to address the bit relative to that base.
> > > Inline assembly constraints aren't expressive enough to tell the
> > > compiler that the assembly directive is going to touch a specific memory
> > > location of unknown size, therefore we have to use the "memory" clobber
> > > to indicate that the assembly is going to access memory locations other
> > > than those listed in the inputs/outputs.
> > > To indicate that BTR/BTS instructions don't necessarily touch the first
> > > sizeof(long) bytes of the argument, we also move the address to assembly
> > > inputs.
> > >
> > > This particular change leads to size increase of 124 kernel functions in
> > > a defconfig build. For some of them the diff is in NOP operations, other
> > > end up re-reading values from memory and may potentially slow down the
> > > execution. But without these clobbers the compiler is free to cache
> > > the contents of the bitmaps and use them as if they weren't changed by
> > > the inline assembly.
> > >
> > > 2. Use byte-sized arguments for operations touching single bytes.
> > >
> > > Passing a long value to ANDB/ORB/XORB instructions makes the compiler
> > > treat sizeof(long) bytes as being clobbered, which isn't the case. This
> > > may theoretically lead to worse code in the case of heavy optimization.
> > >
> > > Signed-off-by: Alexander Potapenko <glider@google.com>
> > > Cc: Dmitry Vyukov <dvyukov@google.com>
> > > Cc: Paul E. McKenney <paulmck@linux.ibm.com>
> > > Cc: H. Peter Anvin <hpa@zytor.com>
> > > Cc: Peter Zijlstra <peterz@infradead.org>
> > > Cc: James Y Knight <jyknight@google.com>
> > > ---
> > >  v2:
> > >   -- renamed the patch
> > >   -- addressed comment by Peter Zijlstra: don't use "+m" for functions
> > >   returning void
> > >   -- fixed input types for operations touching single bytes
> > > ---
> > >  arch/x86/include/asm/bitops.h | 41 +++++++++++++++--------------------
> > >  1 file changed, 18 insertions(+), 23 deletions(-)
> >
> > I'm wondering what the primary motivation for the patch is:
> >
> >  - Does it fix an actual miscompilation, or only a theoretical miscompilation?
> Depends on what we name an actual miscompilation.
> I've built a defconfig kernel and looked through some of the functions
> generated by GCC 7.3.0 with and without this clobber, and didn't spot
> any miscompilations.
> However there is a (trivial) theoretical case where this code leads to
> miscompilation: https://lkml.org/lkml/2019/3/28/393 using just GCC
> 8.3.0 with -O2.
> It isn't hard to imagine someone writes such a function in the kernel someday.
> 
> So the primary motivation is to fix an existing misuse of the asm
> directive, which happens to work in certain configurations now, but
> isn't guaranteed to work under different circumstances.

Thanks, that's all the context this patch needed: the miscompilation is 
real, demonstrated, and the pattern of your testcase doesn't look overly 
weird.

Also the 'cost' side of your patch appears to be pretty low, the 
defconfig-64 bloat from the stricter asm() constraints appears to be very 
small and not measurable in .text section size with bog standard GCC 7.3:

  text       data     bss      dec        hex      filename        sha1
  19565909   4974784  1826888  26367581   192565d  vmlinux.before  07f91fa36d2b477b245c7fee283dd3b7
  19565909   4974784  1826888  26367581   192565d  vmlinux.after   51a3f9a5fec4c29198953c06672a61a5

The allmodconfig-64 .text bloat appears to be zero as well:

  text       data     bss      dec        hex      filename        sha1
  27058207   34467402 30863436 92389045   581beb5  vmlinux.before  b38c470330f38779ab0be08fd7d90053
  27058207   34467402 30863436 92389045   581beb5  vmlinux.after   36c99be7cbebc13899ae22ced32fa2ec

Note that defconfig/allmodconfig is only a fraction of the kernel's 
complexity, especially if we consider the myriads of build time options 
in the Kconfig space plus the compiler variants out there.

Anyway, I agree that this needs fixing, so I have queued up your 
constraint fixes for x86/urgent, with a -stable tag.

We'll probably not push it to Linus until next week (-rc5 time), to make 
sure there are no surprises, and also to allow for any late review 
feedback.

Thanks,

	Ingo
