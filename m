Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5072C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 21:43:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C8EB21556
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 21:43:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576187027;
	bh=A4nEQkfUDBBVKYKII6PHgh7pFpFt/VN17mv8mSDENJc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=UZFr+WN2ZBuxxhUgyDr71msL1dk0bHDZS0pEugkjH1V0cp7rg/NHdfLNWnEZR83NN
	 U+IzPaUTrWpu0UCRl0aKyt9B/8xWUvNnT+XrnNPkoPE/t+HClnXAf3mjGQDBWII0FT
	 nwfxDOtw5L876kIDgyfZzYw2oyifgoyNviUo+Umg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731134AbfLLVn0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 16:43:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:42248 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731086AbfLLVn0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 16:43:26 -0500
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F35E321556
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2019 21:43:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576187005;
        bh=A4nEQkfUDBBVKYKII6PHgh7pFpFt/VN17mv8mSDENJc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=1EBq85mM5JdtXIxar4YW2RpCK6FzQUPLZ9dQDtqe+PA+uS7X91bZB3cUI8va1IMn2
         Csjp9s16ki46r9c/5lxwCbqIwGaWiqivusKy+1AmNFZ3ZrbqXz+90XoD3ocqfa2KjB
         5SCkAl91jx4avu1VRP0Opv/67Dpkjq8lEl5Z0spk=
Received: by mail-wr1-f41.google.com with SMTP id g17so4406688wro.2
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2019 13:43:24 -0800 (PST)
X-Gm-Message-State: APjAAAW6vNcyMaKjyClkvMMLgq0dw0i4vAjrCeUwf+4b6GqI3Zz/U4XK
        A0f2JsbE88Tg0vQtkvVhGO7uYLq60/VhaKDfGStTjw==
X-Google-Smtp-Source: APXvYqy3vfw/7fbZf4fh/Ka5CkrY9QRtmlEsKd3VZdbewGVcZDK4Q898CPAd06uKdjgX/hz2wYGIervBqd2cQPt9/io=
X-Received: by 2002:adf:f2c1:: with SMTP id d1mr8464500wrp.111.1576187003430;
 Thu, 12 Dec 2019 13:43:23 -0800 (PST)
MIME-Version: 1.0
References: <cbecab05-9e95-5dec-ef81-499617c153a6@suse.com>
 <08B92B44-CCA9-4B83-B9CC-F1601D44B73F@amacapital.net> <0053f606-f4f7-3951-f40b-b7bd08703590@suse.com>
In-Reply-To: <0053f606-f4f7-3951-f40b-b7bd08703590@suse.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Thu, 12 Dec 2019 13:43:12 -0800
X-Gmail-Original-Message-ID: <CALCETrWHNunMzP1xHmOhvHG20_baoeXhNbCcEJgCgm5xzGM5Tw@mail.gmail.com>
Message-ID: <CALCETrWHNunMzP1xHmOhvHG20_baoeXhNbCcEJgCgm5xzGM5Tw@mail.gmail.com>
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

On Tue, Dec 10, 2019 at 7:40 AM Jan Beulich <jbeulich@suse.com> wrote:
>
> On 10.12.2019 16:29, Andy Lutomirski wrote:
> >> On Dec 10, 2019, at 2:48 AM, Jan Beulich <JBeulich@suse.com> wrote:
> >>
> >> =EF=BB=BFOmitting suffixes from instructions in AT&T mode is bad pract=
ice when
> >> operand size cannot be determined by the assembler from register
> >> operands, and is likely going to be warned about by upstream gas in th=
e
> >> future. Add the missing suffix here.
> >>
> >> Signed-off-by: Jan Beulich <jbeulich@suse.com>
> >>
> >> --- a/arch/x86/entry/entry_64.S
> >> +++ b/arch/x86/entry/entry_64.S
> >> @@ -1728,7 +1728,7 @@ END(nmi)
> >> SYM_CODE_START(ignore_sysret)
> >>    UNWIND_HINT_EMPTY
> >>    mov    $-ENOSYS, %eax
> >> -    sysret
> >> +    sysretl
> >
> > Isn=E2=80=99t the default sysretq?  sysretl looks more correct, but tha=
t suggests
> > that your changelog is wrong.
>
> No, this is different from ret, and more like iret and lret.
>
> > Is this code even reachable?
>
> Yes afaict, supported by the comment ahead of the symbol. syscall_init()
> puts its address into MSR_CSTAR when !IA32_EMULATION.
>

What I meant was: can a program actually get itself into 32-bit mode
to execute a 32-bit SYSCALL instruction?

Anyway, the change itself is Acked-by: Andy Lutomirski <luto@kernel.org>

But let's please clarify the changelog:

ignore_sysret contains an unsuffixed 'sysret' instruction.  gas
correctly interprets this as sysretl, but leaving it up to gas to
guess when there is no register operand that implies a size is bad
practice, and upstream gas is likely to warn about this in the future.
Use 'sysretl' explicitly.  This does not change the assembled output.

--Andy
