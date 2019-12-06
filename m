Return-Path: <SRS0=xBSd=Z4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0033C43603
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 16:35:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A00D820659
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 16:35:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="MLSDZRNh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726416AbfLFQfZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Dec 2019 11:35:25 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:33212 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726312AbfLFQfZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Dec 2019 11:35:25 -0500
Received: by mail-ed1-f68.google.com with SMTP id l63so6337725ede.0
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2019 08:35:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XSkH0mMxJ0LjfyXh0N7TS7Y5Mgxh/voFS9v1bkgeE8Y=;
        b=MLSDZRNhI0hqxF9SMOVeK0bzV/j3DpCPUVJapnYSllSGN0EMupN4ZEact+yah726dW
         tgLTR2wLEun/p+pthj9h67Njj/fiNnXiCvs6Z1qMpYn2VQoO5Gx6i4nf6nzvCElH/JQF
         r4jpmSRlPHQzcb6OlXyVnXKNJEQfJOBv7GY7A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XSkH0mMxJ0LjfyXh0N7TS7Y5Mgxh/voFS9v1bkgeE8Y=;
        b=UuGsM7xw5Jmyi4Aibuf0IWAscHUaVm3LwF3PcVDNLXAc/5c1XpAM5DXAdSjFphZZ/a
         OAt2CL54DznCQqCP3ONgnPJpdMjHHakcApGzkE4kyC4YJQoRXtmTByulXOSLuQaN2h7A
         Z5BdyfvDwvn/uXbVxogWBdDGkjyr0xSfMUCmq4krvYWrDG5Hy9o2jWzG4u031hMgjVq/
         AHcQpMNQSXqT9MFdWOOCOFMX2Ky3AyS/Of0mEN2D+zCPcIGWqwtbid7leY1kBAqO+Ir+
         muGEGqftA0q1CLeR0+13ZMgycYrvkBj0GisbVF6c31kGytba/llHOCri7efPRWP3S5V1
         3pOA==
X-Gm-Message-State: APjAAAWwgse2PwrAuiPVXJqc8zMhpy7vmlXWOLkWrFwKU6vO1+Sb07Qe
        9nZOZL+6TciJVRleXysVF4Pkpc+38Qg=
X-Google-Smtp-Source: APXvYqw4YICC5oqaQLbz2zP7qAwdexH6nPmtD/LJaOibhRVoY1SjWRumi6S26Wz9HMy1XK4GCzousA==
X-Received: by 2002:a17:907:423b:: with SMTP id oi19mr16483316ejb.176.1575650122799;
        Fri, 06 Dec 2019 08:35:22 -0800 (PST)
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com. [209.85.221.48])
        by smtp.gmail.com with ESMTPSA id r13sm224764ejb.27.2019.12.06.08.35.21
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Dec 2019 08:35:22 -0800 (PST)
Received: by mail-wr1-f48.google.com with SMTP id j42so8401835wrj.12
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2019 08:35:21 -0800 (PST)
X-Received: by 2002:a5d:494f:: with SMTP id r15mr13261474wrs.143.1575650120873;
 Fri, 06 Dec 2019 08:35:20 -0800 (PST)
MIME-Version: 1.0
References: <20191205000957.112719-1-thgarnie@chromium.org>
 <20191205000957.112719-5-thgarnie@chromium.org> <20191205090355.GC2810@hirez.programming.kicks-ass.net>
 <CAJcbSZF+vGE6ZseiQfcis2NMcimmpwvov_P-tZe--z5UxJPDdg@mail.gmail.com> <20191206102649.GC2844@hirez.programming.kicks-ass.net>
In-Reply-To: <20191206102649.GC2844@hirez.programming.kicks-ass.net>
From:   Thomas Garnier <thgarnie@chromium.org>
Date:   Fri, 6 Dec 2019 08:35:09 -0800
X-Gmail-Original-Message-ID: <CAJcbSZHLcSN4BK=N7M3Kv9q-hkPe6dDxbHaRCG9v2JVwhSZxfw@mail.gmail.com>
Message-ID: <CAJcbSZHLcSN4BK=N7M3Kv9q-hkPe6dDxbHaRCG9v2JVwhSZxfw@mail.gmail.com>
Subject: Re: [PATCH v10 04/11] x86/entry/64: Adapt assembly for PIE support
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Kristen Carlson Accardi <kristen@linux.intel.com>,
        Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 6, 2019 at 2:27 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Thu, Dec 05, 2019 at 09:01:50AM -0800, Thomas Garnier wrote:
> > On Thu, Dec 5, 2019 at 1:04 AM Peter Zijlstra <peterz@infradead.org> wrote:
> > > On Wed, Dec 04, 2019 at 04:09:41PM -0800, Thomas Garnier wrote:
> > >
> > > > @@ -1625,7 +1627,11 @@ first_nmi:
> > > >       addq    $8, (%rsp)      /* Fix up RSP */
> > > >       pushfq                  /* RFLAGS */
> > > >       pushq   $__KERNEL_CS    /* CS */
> > > > -     pushq   $1f             /* RIP */
> > > > +     pushq   $0              /* Future return address */
> > >
> > > We're building an IRET frame, the IRET frame does not have a 'future
> > > return address' field.
> >
> > I assumed that's the target RIP after iretq.
>
> It is. But it's still the (R)IP field of the IRET frame. Calling it
> anything else is just confusing. The frame is 5 words: SS, (R)SP, (R)FLAGS,
> CS, (R)IP.
>
> > > > +     pushq   %rdx            /* Save RAX */
> > > > +     leaq    1f(%rip), %rdx  /* RIP */
> > >
> > > nonsensical comment
> >
> > That was the same comment from the push $1f that I changed.
>
> Yes, but there it made sense since the PUSH actually created that field
> of the frame, here it is nonsensical. What this instruction does is put
> the address of the '1f' label into RDX, which is then stuck into the
> (R)IP field on the next instruction.

Got it, make sense. Thanks.

>
> > > > +     movq    %rdx, 8(%rsp)   /* Put 1f on return address */
> > > > +     popq    %rdx            /* Restore RAX */
