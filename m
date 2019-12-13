Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DATE_IN_PAST_03_06,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 575EDC43603
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 22:05:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 209AB2073D
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 22:05:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576274708;
	bh=lB0pmE4DH9n1aB+8qsKB2hF3RhXN8SqieZmVDmlXu3o=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Peeef1+3Rcjyi6xmV1wkS4WLHTC3ZToUWU7fMk4PTpa/iyqwSXeJOV5FpZiVpKmy+
	 bUqLalphcwvjcNj5FdG+eA2xEOuo7Dzy7v3e3vPbf84NVlgAlAnqQ5qxOwXgfM2VPy
	 gy9/RCdYj1UjPbjMUij5QD8ay6LTgG5hFRoUMDG8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726774AbfLMWFH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Dec 2019 17:05:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:34936 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726638AbfLMWFG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Dec 2019 17:05:06 -0500
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 790C7206DA
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2019 22:05:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576274705;
        bh=lB0pmE4DH9n1aB+8qsKB2hF3RhXN8SqieZmVDmlXu3o=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ro+XXfNCmF2DYiSC0iWcoMb30gc3gC5HlNG+UuNlqxhgAU0oCAuqiM+MS5aIiy33J
         S2P+cuaDNV4QnzAoD+LNBCwyWpw8J9H/QxAIEaJyRi7QwdzD/yDWh9xAfYbCtvXdGV
         hYlaX3pDqyYe7VwmzH/cWYJ00snRdfRcCkqs4bvI=
Received: by mail-wm1-f44.google.com with SMTP id a5so363451wmb.0
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2019 14:05:05 -0800 (PST)
X-Gm-Message-State: APjAAAX8gqPHIrEGCRvU+hoFahojA+Ss0wSMtJN7PJ643VOSVvNctnlC
        od4m5eBNKbKDPZo8l0zDiE+33BieRWNIKDq43Xvxjg==
X-Google-Smtp-Source: APXvYqwJqiYJWWJLnD7MVAVhWixUCzijvK0zvRV05H850puS930kAWCyf3ggPO+OIZT7N+dZo0x4pEapwXHKt/lg4eo=
X-Received: by 2002:a1c:7d8b:: with SMTP id y133mr14372276wmc.165.1576259379347;
 Fri, 13 Dec 2019 09:49:39 -0800 (PST)
MIME-Version: 1.0
References: <cbecab05-9e95-5dec-ef81-499617c153a6@suse.com>
 <08B92B44-CCA9-4B83-B9CC-F1601D44B73F@amacapital.net> <0053f606-f4f7-3951-f40b-b7bd08703590@suse.com>
 <CALCETrWHNunMzP1xHmOhvHG20_baoeXhNbCcEJgCgm5xzGM5Tw@mail.gmail.com> <ed9d8df6-0fe7-ca15-bab2-4d9cbbfe62f0@suse.com>
In-Reply-To: <ed9d8df6-0fe7-ca15-bab2-4d9cbbfe62f0@suse.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Fri, 13 Dec 2019 09:49:28 -0800
X-Gmail-Original-Message-ID: <CALCETrXoK+6gNn=3_yZdkHScd=N-a2f_VPC-svkFfHVsiVusVw@mail.gmail.com>
Message-ID: <CALCETrXoK+6gNn=3_yZdkHScd=N-a2f_VPC-svkFfHVsiVusVw@mail.gmail.com>
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

On Fri, Dec 13, 2019 at 1:55 AM Jan Beulich <jbeulich@suse.com> wrote:
>
> On 12.12.2019 22:43, Andy Lutomirski wrote:
> > On Tue, Dec 10, 2019 at 7:40 AM Jan Beulich <jbeulich@suse.com> wrote:
> >>
> >> On 10.12.2019 16:29, Andy Lutomirski wrote:
> >>>> On Dec 10, 2019, at 2:48 AM, Jan Beulich <JBeulich@suse.com> wrote:
> >>>>
> >>>> =EF=BB=BFOmitting suffixes from instructions in AT&T mode is bad pra=
ctice when
> >>>> operand size cannot be determined by the assembler from register
> >>>> operands, and is likely going to be warned about by upstream gas in =
the
> >>>> future. Add the missing suffix here.
> >>>>
> >>>> Signed-off-by: Jan Beulich <jbeulich@suse.com>
> >>>>
> >>>> --- a/arch/x86/entry/entry_64.S
> >>>> +++ b/arch/x86/entry/entry_64.S
> >>>> @@ -1728,7 +1728,7 @@ END(nmi)
> >>>> SYM_CODE_START(ignore_sysret)
> >>>>    UNWIND_HINT_EMPTY
> >>>>    mov    $-ENOSYS, %eax
> >>>> -    sysret
> >>>> +    sysretl
> >>>
> >>> Isn=E2=80=99t the default sysretq?  sysretl looks more correct, but t=
hat suggests
> >>> that your changelog is wrong.
> >>
> >> No, this is different from ret, and more like iret and lret.
> >>
> >>> Is this code even reachable?
> >>
> >> Yes afaict, supported by the comment ahead of the symbol. syscall_init=
()
> >> puts its address into MSR_CSTAR when !IA32_EMULATION.
> >>
> >
> > What I meant was: can a program actually get itself into 32-bit mode
> > to execute a 32-bit SYSCALL instruction?
>
> Why not? It can set up a 32-bit code segment descriptor, far-branch
> into it, and then execute SYSCALL. I can't see anything preventing
> this in the logic involved in descriptor adjustment system calls. In
> fact it looks to be at least partly the opposite - fill_ldt()
> disallows creation of 64-bit code segments (oddly enough
> fill_user_desc() then still copies the bit back, despite there
> apparently being no way for it to get set).

Do we allow creation of 32-bit code segments on !IA32_EMULATION
kernels?  I think we shouldn't, but I'm not really sure.

Anyway, this is irrelevant to the patch at hand.

--Andy
