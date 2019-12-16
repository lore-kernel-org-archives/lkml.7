Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C52A0C2D0BF
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 15:23:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BDB5206D3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 15:23:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m27BW14E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728384AbfLPPX2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 10:23:28 -0500
Received: from mail-il1-f194.google.com ([209.85.166.194]:45894 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728173AbfLPPX1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 10:23:27 -0500
Received: by mail-il1-f194.google.com with SMTP id p8so5685594iln.12
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2019 07:23:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=nQ22oLc0zqLqbegn7Cvj87zY90cjQ6vfznQBArzmbMk=;
        b=m27BW14EzvUpyU//W9X3fqIHh69QzSaXOB0BqiWo7p55PMA2iv4T0MnE0dwbN/btp9
         jkEbjL+nXKB4l+1yJ8S3AQgwJdS5SYlxYQnLIme/BJm6NXjcusmo/WNEVE7pkb9Xo6pR
         DGH8vCCzeg4OXV+kK0IBSu7M2yEmkDObjwOA/ev0YYArCkVMeESM1sCO9xfDbb5+oBqL
         IJVZYovTpPu/oMA68oZeCRbuCuELTMZXm9ozzPoKqc6Z+E6mJ0//KXjrJ1kh3fTPl8pL
         kz6GLms/BCqIqbuTRMsXkgViab8McB1j/EWa989ALOYN+I1PmSlqzeZijFM5ANNrDTlc
         M68Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=nQ22oLc0zqLqbegn7Cvj87zY90cjQ6vfznQBArzmbMk=;
        b=Zslfe0AAgV0AsjNtPdHXo0y2RumxYcCjvtwfRjL9gfSrS/m9CpkRG1aAEMFKxFOiJC
         3myEGwcJinsNz9xAw/qrTo68hNxpGaFh26kSXZ6u4wUJvHsXa8pVtpVUuXlufW7JH0WT
         hxOomoKFu9iducXTtif0bWNDK04r2myQ5hXT8FMp1WJw2SbiWfRDttvmlXJah2HlNUGD
         0x7EwpLpr+JRVsEL/qPLEOw4emNQsgBOp7XL9W5BJECdfgOTBpn5KrJmwSdKRCRKoMfd
         aY9upxUuXdk2yH25cDglBAPCEzsa6R2htBl+wegU0ccle/oTMkNCU+65zqs3BNXnoui4
         ll1A==
X-Gm-Message-State: APjAAAV2HY9sxn2XVV84kOtpm8+zx3JpBC/OteDOXdJiEqV2T37CO/ZW
        VxbZluCIdnfxJU0Sp5EHsMCj+uPhAl0SgkbVCg==
X-Google-Smtp-Source: APXvYqxjNE+NkeKs6Tfal2DiBwwKzytmNe96HV1j1nYf2KOhtzTVOOn6Cun+iW9p/La5quf9ZjFq/APqdyL6bWR2UNc=
X-Received: by 2002:a05:6e02:1014:: with SMTP id n20mr2661479ilj.172.1576509806954;
 Mon, 16 Dec 2019 07:23:26 -0800 (PST)
MIME-Version: 1.0
References: <cbecab05-9e95-5dec-ef81-499617c153a6@suse.com>
 <08B92B44-CCA9-4B83-B9CC-F1601D44B73F@amacapital.net> <0053f606-f4f7-3951-f40b-b7bd08703590@suse.com>
 <CALCETrWHNunMzP1xHmOhvHG20_baoeXhNbCcEJgCgm5xzGM5Tw@mail.gmail.com>
 <ed9d8df6-0fe7-ca15-bab2-4d9cbbfe62f0@suse.com> <CALCETrXoK+6gNn=3_yZdkHScd=N-a2f_VPC-svkFfHVsiVusVw@mail.gmail.com>
 <62d9f87d-de55-3fb4-664d-d24897f4dd9b@suse.com>
In-Reply-To: <62d9f87d-de55-3fb4-664d-d24897f4dd9b@suse.com>
From:   Brian Gerst <brgerst@gmail.com>
Date:   Mon, 16 Dec 2019 10:23:15 -0500
Message-ID: <CAMzpN2gBrXWwUrDUQQAatutg6xxgxOunVrse6gs2C=EYKH11JA@mail.gmail.com>
Subject: Re: [PATCH] x86-64/entry: add instruction suffix to SYSRET
To:     Jan Beulich <jbeulich@suse.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 16, 2019 at 5:12 AM Jan Beulich <jbeulich@suse.com> wrote:
>
> On 13.12.2019 18:49, Andy Lutomirski wrote:
> > On Fri, Dec 13, 2019 at 1:55 AM Jan Beulich <jbeulich@suse.com> wrote:
> >>
> >> On 12.12.2019 22:43, Andy Lutomirski wrote:
> >>> On Tue, Dec 10, 2019 at 7:40 AM Jan Beulich <jbeulich@suse.com> wrote=
:
> >>>>
> >>>> On 10.12.2019 16:29, Andy Lutomirski wrote:
> >>>>>> On Dec 10, 2019, at 2:48 AM, Jan Beulich <JBeulich@suse.com> wrote=
:
> >>>>>>
> >>>>>> =EF=BB=BFOmitting suffixes from instructions in AT&T mode is bad p=
ractice when
> >>>>>> operand size cannot be determined by the assembler from register
> >>>>>> operands, and is likely going to be warned about by upstream gas i=
n the
> >>>>>> future. Add the missing suffix here.
> >>>>>>
> >>>>>> Signed-off-by: Jan Beulich <jbeulich@suse.com>
> >>>>>>
> >>>>>> --- a/arch/x86/entry/entry_64.S
> >>>>>> +++ b/arch/x86/entry/entry_64.S
> >>>>>> @@ -1728,7 +1728,7 @@ END(nmi)
> >>>>>> SYM_CODE_START(ignore_sysret)
> >>>>>>    UNWIND_HINT_EMPTY
> >>>>>>    mov    $-ENOSYS, %eax
> >>>>>> -    sysret
> >>>>>> +    sysretl
> >>>>>
> >>>>> Isn=E2=80=99t the default sysretq?  sysretl looks more correct, but=
 that suggests
> >>>>> that your changelog is wrong.
> >>>>
> >>>> No, this is different from ret, and more like iret and lret.
> >>>>
> >>>>> Is this code even reachable?
> >>>>
> >>>> Yes afaict, supported by the comment ahead of the symbol. syscall_in=
it()
> >>>> puts its address into MSR_CSTAR when !IA32_EMULATION.
> >>>>
> >>>
> >>> What I meant was: can a program actually get itself into 32-bit mode
> >>> to execute a 32-bit SYSCALL instruction?
> >>
> >> Why not? It can set up a 32-bit code segment descriptor, far-branch
> >> into it, and then execute SYSCALL. I can't see anything preventing
> >> this in the logic involved in descriptor adjustment system calls. In
> >> fact it looks to be at least partly the opposite - fill_ldt()
> >> disallows creation of 64-bit code segments (oddly enough
> >> fill_user_desc() then still copies the bit back, despite there
> >> apparently being no way for it to get set).
> >
> > Do we allow creation of 32-bit code segments on !IA32_EMULATION
> > kernels?
>
> As per above - I think so.
>
> >  I think we shouldn't, but I'm not really sure.
>
> It may be a little exotic, but I can't see any reason to disallow
> a 64-bit process to switch to compatibility mode temporarily. One
> contrived use case could be to be able to invoke INTO or BOUND.

I think it should be kept intact for future use by WINE.  WINE is
currently set up so that 32/16-bit Windows emulation needs a 32-bit
build against 32-bit Linux libraries, using the kernel compat layer.
With many distributions wanting to drop 32-bit support this has been a
big sticking point.  If WINE could be modified so that the core is
always built as 64-bit with 32-bit compatibility handled entirely in
userspace, that would remove its dependency on 32-bit Linux libraries
and thus wouldn't require IA32_EMULATION.

--
Brian Gerst
