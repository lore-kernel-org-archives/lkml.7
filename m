Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 390AEC43603
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 02:39:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05C1E227BF
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 02:39:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576723167;
	bh=eajPtaQ53bdOFSFYbVWl33hqm6snpzaR1BIbqwcmipc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=mO0d4+PqiJtfOwTmB/7b+3+fOqq8MxoN8YmDgW6AYRhuof2fJNMsw8KctuMgDXdng
	 vY8zLAzD4rI6JLl264aCG9gYtHAngI9jmpWvKytQBq2qmad0bF4bfwcNdx9wnGMyyF
	 PhRcXtzSOiqA/hIdEZfCj+Bvmd7+akRmQ70GrDrk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726829AbfLSCj0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 21:39:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:41348 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726744AbfLSCjZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 21:39:25 -0500
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1CDAF24650
        for <linux-kernel@vger.kernel.org>; Thu, 19 Dec 2019 02:39:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576723164;
        bh=eajPtaQ53bdOFSFYbVWl33hqm6snpzaR1BIbqwcmipc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=x6LKJnotNQnkJ265YZC5x6L2ctNshQr3nxM4y9iPGrfKal2m6T+4DYPK5w1lrX7UF
         JOl1qDIPlKKaYnZ8/ZJOxRaoFPd634Wo4AfqC7KT64YGdyyWQFTcQglF3dm0reidyL
         uvoR417tgOLJftw8zWWhHUOdctLZIZiVCRPGNjkk=
Received: by mail-wm1-f50.google.com with SMTP id q9so3883564wmj.5
        for <linux-kernel@vger.kernel.org>; Wed, 18 Dec 2019 18:39:24 -0800 (PST)
X-Gm-Message-State: APjAAAVo7z+EigjE7WtmP0lNJY3FQmXP0QlXuC4r9j9TAhHfMXzqSXMR
        ERQtUUQTYd7ZIXulHWGYgPSRxRXtGlvWiU5gwUjc/g==
X-Google-Smtp-Source: APXvYqwep+344sQC+HuzTqwzguRdq7PpWhK8uI3+wN7TllXrE7ZFk7XU0A7NbiLTydssk0yFVVCup7Gr184lFYKifGk=
X-Received: by 2002:a1c:20d6:: with SMTP id g205mr7119194wmg.38.1576723162420;
 Wed, 18 Dec 2019 18:39:22 -0800 (PST)
MIME-Version: 1.0
References: <cbecab05-9e95-5dec-ef81-499617c153a6@suse.com>
 <08B92B44-CCA9-4B83-B9CC-F1601D44B73F@amacapital.net> <0053f606-f4f7-3951-f40b-b7bd08703590@suse.com>
 <CALCETrWHNunMzP1xHmOhvHG20_baoeXhNbCcEJgCgm5xzGM5Tw@mail.gmail.com>
 <ed9d8df6-0fe7-ca15-bab2-4d9cbbfe62f0@suse.com> <CALCETrXoK+6gNn=3_yZdkHScd=N-a2f_VPC-svkFfHVsiVusVw@mail.gmail.com>
 <62d9f87d-de55-3fb4-664d-d24897f4dd9b@suse.com> <CAMzpN2gBrXWwUrDUQQAatutg6xxgxOunVrse6gs2C=EYKH11JA@mail.gmail.com>
In-Reply-To: <CAMzpN2gBrXWwUrDUQQAatutg6xxgxOunVrse6gs2C=EYKH11JA@mail.gmail.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Wed, 18 Dec 2019 18:39:09 -0800
X-Gmail-Original-Message-ID: <CALCETrXDhPU54L8XmXanXK4pTPKykCVx44xahrvoZ8K_ZdTMRw@mail.gmail.com>
Message-ID: <CALCETrXDhPU54L8XmXanXK4pTPKykCVx44xahrvoZ8K_ZdTMRw@mail.gmail.com>
Subject: Re: [PATCH] x86-64/entry: add instruction suffix to SYSRET
To:     Brian Gerst <brgerst@gmail.com>
Cc:     Jan Beulich <jbeulich@suse.com>, Andy Lutomirski <luto@kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 16, 2019 at 7:23 AM Brian Gerst <brgerst@gmail.com> wrote:
>
> On Mon, Dec 16, 2019 at 5:12 AM Jan Beulich <jbeulich@suse.com> wrote:
> >
> > On 13.12.2019 18:49, Andy Lutomirski wrote:
> > > On Fri, Dec 13, 2019 at 1:55 AM Jan Beulich <jbeulich@suse.com> wrote=
:
> > >>
> > >> On 12.12.2019 22:43, Andy Lutomirski wrote:
> > >>> On Tue, Dec 10, 2019 at 7:40 AM Jan Beulich <jbeulich@suse.com> wro=
te:
> > >>>>
> > >>>> On 10.12.2019 16:29, Andy Lutomirski wrote:
> > >>>>>> On Dec 10, 2019, at 2:48 AM, Jan Beulich <JBeulich@suse.com> wro=
te:
> > >>>>>>
> > >>>>>> =EF=BB=BFOmitting suffixes from instructions in AT&T mode is bad=
 practice when
> > >>>>>> operand size cannot be determined by the assembler from register
> > >>>>>> operands, and is likely going to be warned about by upstream gas=
 in the
> > >>>>>> future. Add the missing suffix here.
> > >>>>>>
> > >>>>>> Signed-off-by: Jan Beulich <jbeulich@suse.com>
> > >>>>>>
> > >>>>>> --- a/arch/x86/entry/entry_64.S
> > >>>>>> +++ b/arch/x86/entry/entry_64.S
> > >>>>>> @@ -1728,7 +1728,7 @@ END(nmi)
> > >>>>>> SYM_CODE_START(ignore_sysret)
> > >>>>>>    UNWIND_HINT_EMPTY
> > >>>>>>    mov    $-ENOSYS, %eax
> > >>>>>> -    sysret
> > >>>>>> +    sysretl
> > >>>>>
> > >>>>> Isn=E2=80=99t the default sysretq?  sysretl looks more correct, b=
ut that suggests
> > >>>>> that your changelog is wrong.
> > >>>>
> > >>>> No, this is different from ret, and more like iret and lret.
> > >>>>
> > >>>>> Is this code even reachable?
> > >>>>
> > >>>> Yes afaict, supported by the comment ahead of the symbol. syscall_=
init()
> > >>>> puts its address into MSR_CSTAR when !IA32_EMULATION.
> > >>>>
> > >>>
> > >>> What I meant was: can a program actually get itself into 32-bit mod=
e
> > >>> to execute a 32-bit SYSCALL instruction?
> > >>
> > >> Why not? It can set up a 32-bit code segment descriptor, far-branch
> > >> into it, and then execute SYSCALL. I can't see anything preventing
> > >> this in the logic involved in descriptor adjustment system calls. In
> > >> fact it looks to be at least partly the opposite - fill_ldt()
> > >> disallows creation of 64-bit code segments (oddly enough
> > >> fill_user_desc() then still copies the bit back, despite there
> > >> apparently being no way for it to get set).
> > >
> > > Do we allow creation of 32-bit code segments on !IA32_EMULATION
> > > kernels?
> >
> > As per above - I think so.
> >
> > >  I think we shouldn't, but I'm not really sure.
> >
> > It may be a little exotic, but I can't see any reason to disallow
> > a 64-bit process to switch to compatibility mode temporarily. One
> > contrived use case could be to be able to invoke INTO or BOUND.
>
> I think it should be kept intact for future use by WINE.  WINE is
> currently set up so that 32/16-bit Windows emulation needs a 32-bit
> build against 32-bit Linux libraries, using the kernel compat layer.
> With many distributions wanting to drop 32-bit support this has been a
> big sticking point.  If WINE could be modified so that the core is
> always built as 64-bit with 32-bit compatibility handled entirely in
> userspace, that would remove its dependency on 32-bit Linux libraries
> and thus wouldn't require IA32_EMULATION.

I just read an article about WINE on Mac OS doing more or less this.
I'm wondering if we should wire up set_thread_area() on x86_64 for
uses like this.  It even has a syscall number already -- it's just not
wired up.

Anyway, this isn't particularly high priority, IMO -- I don't think
many people set IA32_EMULATION=3Dn.  What we really ought to do is to
get rid of the special ignore_sysret path and instead go through the
normal syscall path but just do:

if (!IS_ENABLED(IA32_EMULATION))
  return -ENOSYS;

or equivalent.  The last thing we need is a whole special asm path
that essentially no one uses.
