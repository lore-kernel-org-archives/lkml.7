Return-Path: <SRS0=RThv=TD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0CA7C43219
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 23:08:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9D3F2070B
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 23:08:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556924901;
	bh=G16IyFTuLqoThxej5cIzXWsWgvjFmmzB2AggOslGxAY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=VCXEdS2AJP/oJKjvSK3+qJgmvtyphujjiKv5aCyjH2djqq73Ct0UUSRSRoVXR01w1
	 gydpcdQ8aGnasT42ThFpmqH44OW45LKv1zqJmc5TV7CBRcu5mC+O/QNqkVzLdcoFYr
	 YKkz+DbxB4/wjgq80FaXygjwUb72jrvHlpRVFIhw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726898AbfECXIU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 May 2019 19:08:20 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:37919 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726042AbfECXIU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 19:08:20 -0400
Received: by mail-lf1-f65.google.com with SMTP id v1so5482285lfg.5
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2019 16:08:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PJAflPmQogNQpRfYKXa4wncPdUKgvcxegImOYQZ9y4M=;
        b=YRB1C4a8aY6oNQ4Dcz6qJG4DjRq4rRf5c96hJky+mFEos14uxAjmg5IRtblz5Zm/+p
         AIWWkKxTm6hIurYsOfUWuKlPO3f3CKS4z4ENU/Uxi4oZSRGIkqbYn5VX66A1WW96OEeW
         VfyeY+ZH75pBqOv3uAMq5kkfebEdfOYQXUMAE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PJAflPmQogNQpRfYKXa4wncPdUKgvcxegImOYQZ9y4M=;
        b=q0o/nvQpdQGExiWh1S1EK9sF6ixGKVJrlWm6QH/+2pHtE12nzQSz0eNpIXL702sjkE
         xWE/uT3BxszhOX7JSfMKaEN+VbMrye9BA7DaKKqDLf4sl3HtkrhLdGavlZ+wuhb18y5h
         HVCNAaljUag0q+j/YDKiXthXRjZrf5bGVHHqxDtUQiK3ck7Dm6HL8t7+BUxqtquWzL0Q
         cWE7OLSO7SIbEUkYa3T4NZM+cF3aTcKJ0Sp6pIX/QG2jUsDk4JJ3uIrnQXxvH/TIJW80
         8sszWHd3XauqIVYke5pRyXkDM8CeIqe8M/C9fjBgfSGMoF3aVdWWzeMJ5shumt5UBshF
         9+bg==
X-Gm-Message-State: APjAAAVIDSXhkvEkYlFVjiasfDhfcxW33fnONA/HFJMMUwre5K/1F/lw
        F30z332st0zDjBpQGVxkQz6kP79QoEw=
X-Google-Smtp-Source: APXvYqyMben1+gMfRC+iEMyz+q/GVBzSmHMhSauQBJ6O96Ib1CmDzKBpqSFtU68IoouDUAxHSSKo0w==
X-Received: by 2002:ac2:50ca:: with SMTP id h10mr6556786lfm.31.1556924896866;
        Fri, 03 May 2019 16:08:16 -0700 (PDT)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com. [209.85.208.170])
        by smtp.gmail.com with ESMTPSA id v11sm655643lfb.68.2019.05.03.16.08.15
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 May 2019 16:08:15 -0700 (PDT)
Received: by mail-lj1-f170.google.com with SMTP id y8so6314047ljd.3
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2019 16:08:15 -0700 (PDT)
X-Received: by 2002:a2e:9a84:: with SMTP id p4mr6156404lji.22.1556924895019;
 Fri, 03 May 2019 16:08:15 -0700 (PDT)
MIME-Version: 1.0
References: <20190501202830.347656894@goodmis.org> <20190501203152.397154664@goodmis.org>
 <20190501232412.1196ef18@oasis.local.home> <20190502162133.GX2623@hirez.programming.kicks-ass.net>
 <CAHk-=wijZ-MD4g3zMJ9W2r=h8LUWneiu29OWuxZEoSfAF=0bhQ@mail.gmail.com>
 <20190502181811.GY2623@hirez.programming.kicks-ass.net> <CAHk-=wi6A9tgw=kkPh5Ywqt687VvsVEjYXVkAnq0jpt0u0tk6g@mail.gmail.com>
 <20190502202146.GZ2623@hirez.programming.kicks-ass.net> <CAHk-=wh8bi5c_GkyjPtDAiaXaZRqtmhWs30usUvs4qK_F+c9tg@mail.gmail.com>
 <20190503152405.2d741af8@gandalf.local.home> <CAHk-=wiA-WbrFrDs-kOfJZMXy4zMo9-SZfk=7B-GfmBJ866naw@mail.gmail.com>
 <20190503184919.2b7ef242@gandalf.local.home>
In-Reply-To: <20190503184919.2b7ef242@gandalf.local.home>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 3 May 2019 16:07:59 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh2vPLvsGBi6JtmEYeqHxB5UpTzHDjY5JsWG=YR0Lypzw@mail.gmail.com>
Message-ID: <CAHk-=wh2vPLvsGBi6JtmEYeqHxB5UpTzHDjY5JsWG=YR0Lypzw@mail.gmail.com>
Subject: Re: [RFC][PATCH 1/2] x86: Allow breakpoints to emulate call functions
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Nicolai Stange <nstange@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jiri Kosina <jikos@kernel.org>,
        Miroslav Benes <mbenes@suse.cz>,
        Petr Mladek <pmladek@suse.com>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Juergen Gross <jgross@suse.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nayna Jain <nayna@linux.ibm.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Joerg Roedel <jroedel@suse.de>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 3, 2019 at 3:49 PM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> You are saying that we have a do_int3() for user space int3, and
> do_kernel_int3() for kernel space. That would need to be done in asm
> for both, because having x86_64 call do_int3() for kernel and
> user would be interesting.

The clean/simple way is to just do this

 - x86-32 does the special asm for the kernel_do_int3(), case and
calls user_do_int3 otherwise.

 - x86-64 doesn't care, and just calls "do_int3()".

We have a trivial helper function like

    dotraplinkage void notrace do_int3(struct pt_regs *regs, long error_code)
    {
        if (user_mode(regs))
                user_int3(regs);
        else
                WARN_ON_ONCE(kernel_int3(regs) != regs);
    }

which adds that warning just for debug purposes.

Then we make the rule be that user_int3() does the normal stuff, and
kernel_int3() returns the pt_regs it was passed in.

Easy-peasy, there is absolutely no difference between x86-64 and
x86-32 here except for the trivial case that x86-32 does its thing at
the asm layer, which is what allows "kernel_int3()" to move pt_regs
around by a small amount.

Now, the _real_ difference is when you do the "call_emulate()" case,
which will have to do something like this

    static struct pt_regs *emulate_call(struct pt_regs *regs, unsigned
long return, unsigned long target)
    {
    #ifdef CONFIG_X86_32
            /* BIG comment about how we need to move pt_regs to make
room and to update the return 'sp' */
            struct pt_regs *new = (void *)regs - 4;
            unsigned long *sp = (unsigned long *)(new + 1);
            memmove(new, regs, sizeof(*regs));
            regs = new;
    #else
            unsigned long *sp = regs->sp;
            regs->sp -= 4;
    #endif
            *sp = value;
            regs->ip = target;
            return regs;
    }

but look, the above isn't that complicated, is it? And notice how the
subtle pt_regs movement is exactly where it needs to be and nowhere
else.

And what's the cost of all of this? NOTHING. The x86-32 entry code has
to do the test for kernel space anyway, and *all* it does now is to
call "kernel_int3" for the kernel case after having made a bit of
extra room on the stack so that you *can* move pt_regs around (maybe
people want to pop things too? It would work as well).

See what I mean by "localized to the cases the need it"?

              Linus
