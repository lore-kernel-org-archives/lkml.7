Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 552CCC433FF
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 17:50:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2637520B1F
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 17:50:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lcMh40MT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729903AbfHERup (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 13:50:45 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:46611 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728885AbfHERup (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 13:50:45 -0400
Received: by mail-ed1-f65.google.com with SMTP id d4so79667643edr.13
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2019 10:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Cudx4Ed0VrEgvxeqYlvplwj7CuqSGFqTGqW93wYT0ZA=;
        b=lcMh40MTEhDqcDc/Gwizp4DJq1zLgs29VTl8B1MgV0gn6732Zykhw5rk/hpfE/bZdg
         Z858446bKNZEhHdaqVDwdaAsKxo6RjEGO70Kjc0YCdzO2WCfu8gWMDnBHRY7Wsqazeyi
         upx6pi+/qoF7JyIsV5gcZruSS8VvqmZ+kjsTs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Cudx4Ed0VrEgvxeqYlvplwj7CuqSGFqTGqW93wYT0ZA=;
        b=rn0d/uLKh8Tylc7Ns9Kt+lrkmwbbh4KukfnyW5PfI9J853a/6D2pxhW7owiRASc0Tf
         yVZMlj9NlYv2yIdK4Ukt9M95ZRS7zqsV5fsnMRntz2NMh+eBWmpT2pDs/fHkhN8uzVFU
         6M8DuWC/zAzqHhU2fm3w9fO5pc1oGX5hl2xFEzWaVdI+jyZI4Y8YENyYBmufhTBxhO5e
         hZVeUdibRREXQoIpMz6zdBNJ578Dy2PwlWCryKYEd1/+p7657KO27mR4q2oZ6BqACgqB
         Xr5PUFpx7TbFXiDSE4kpxSS2YSXVWMISCastPrqoUXto7nGQmirPdvhvdWyXagNkZfLL
         IfGQ==
X-Gm-Message-State: APjAAAVN5QQ82q0/lIc7ipapWq6Zh9LI3gPJQbuxF/pvWUUAj3jY//YK
        Bth4ZHUemlMnBonmDoUaf+sXLpMnJWo=
X-Google-Smtp-Source: APXvYqxDtmKaDSHqglX7WpZ78VF26t9/0RJOoD9K6/+jG2l6I74n3OUROEdP8zdzMHxuWz7mmBUyMg==
X-Received: by 2002:a17:907:105e:: with SMTP id oy30mr15994410ejb.236.1565027443304;
        Mon, 05 Aug 2019 10:50:43 -0700 (PDT)
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com. [209.85.221.53])
        by smtp.gmail.com with ESMTPSA id b15sm20382007edb.46.2019.08.05.10.50.42
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Aug 2019 10:50:42 -0700 (PDT)
Received: by mail-wr1-f53.google.com with SMTP id z1so85270246wru.13
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2019 10:50:42 -0700 (PDT)
X-Received: by 2002:adf:f40b:: with SMTP id g11mr11766296wro.81.1565027441769;
 Mon, 05 Aug 2019 10:50:41 -0700 (PDT)
MIME-Version: 1.0
References: <20190730191303.206365-1-thgarnie@chromium.org>
 <20190730191303.206365-5-thgarnie@chromium.org> <20190805172854.GF18785@zn.tnic>
In-Reply-To: <20190805172854.GF18785@zn.tnic>
From:   Thomas Garnier <thgarnie@chromium.org>
Date:   Mon, 5 Aug 2019 10:50:30 -0700
X-Gmail-Original-Message-ID: <CAJcbSZGedSfZZ5rveH2+_3q7pvmMyDGLxmZU41Nno=ZBX8kN=w@mail.gmail.com>
Message-ID: <CAJcbSZGedSfZZ5rveH2+_3q7pvmMyDGLxmZU41Nno=ZBX8kN=w@mail.gmail.com>
Subject: Re: [PATCH v9 04/11] x86/entry/64: Adapt assembly for PIE support
To:     Borislav Petkov <bp@alien8.de>
Cc:     Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Kristen Carlson Accardi <kristen@linux.intel.com>,
        Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 5, 2019 at 10:28 AM Borislav Petkov <bp@alien8.de> wrote:
>
> On Tue, Jul 30, 2019 at 12:12:48PM -0700, Thomas Garnier wrote:
> > Change the assembly code to use only relative references of symbols for the
> > kernel to be PIE compatible.
> >
> > Position Independent Executable (PIE) support will allow to extend the
> > KASLR randomization range below 0xffffffff80000000.
> >
> > Signed-off-by: Thomas Garnier <thgarnie@chromium.org>
> > Reviewed-by: Kees Cook <keescook@chromium.org>
> > ---
> >  arch/x86/entry/entry_64.S | 16 +++++++++++-----
> >  1 file changed, 11 insertions(+), 5 deletions(-)
> >
> > diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
> > index 3f5a978a02a7..4b588a902009 100644
> > --- a/arch/x86/entry/entry_64.S
> > +++ b/arch/x86/entry/entry_64.S
> > @@ -1317,7 +1317,8 @@ ENTRY(error_entry)
> >       movl    %ecx, %eax                      /* zero extend */
> >       cmpq    %rax, RIP+8(%rsp)
> >       je      .Lbstep_iret
> > -     cmpq    $.Lgs_change, RIP+8(%rsp)
> > +     leaq    .Lgs_change(%rip), %rcx
> > +     cmpq    %rcx, RIP+8(%rsp)
> >       jne     .Lerror_entry_done
> >
> >       /*
> > @@ -1514,10 +1515,10 @@ ENTRY(nmi)
> >        * resume the outer NMI.
> >        */
> >
> > -     movq    $repeat_nmi, %rdx
> > +     leaq    repeat_nmi(%rip), %rdx
> >       cmpq    8(%rsp), %rdx
> >       ja      1f
> > -     movq    $end_repeat_nmi, %rdx
> > +     leaq    end_repeat_nmi(%rip), %rdx
> >       cmpq    8(%rsp), %rdx
> >       ja      nested_nmi_out
> >  1:
> > @@ -1571,7 +1572,8 @@ nested_nmi:
> >       pushq   %rdx
> >       pushfq
> >       pushq   $__KERNEL_CS
> > -     pushq   $repeat_nmi
> > +     leaq    repeat_nmi(%rip), %rdx
> > +     pushq   %rdx
> >
> >       /* Put stack back */
> >       addq    $(6*8), %rsp
> > @@ -1610,7 +1612,11 @@ first_nmi:
> >       addq    $8, (%rsp)      /* Fix up RSP */
> >       pushfq                  /* RFLAGS */
> >       pushq   $__KERNEL_CS    /* CS */
> > -     pushq   $1f             /* RIP */
> > +     pushq   $0              /* Future return address */
> > +     pushq   %rax            /* Save RAX */
> > +     leaq    1f(%rip), %rax  /* RIP */
> > +     movq    %rax, 8(%rsp)   /* Put 1f on return address */
> > +     popq    %rax            /* Restore RAX */
>
> Can't you just use a callee-clobbered reg here instead of preserving
> %rax?

I saw that %rdx was used for temporary usage and restored before the
end so I assumed that it was not an option.

>
> --
> Regards/Gruss,
>     Boris.
>
> Good mailing practices for 400: avoid top-posting and trim the reply.
