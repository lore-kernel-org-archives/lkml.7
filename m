Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFACDC43603
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 17:02:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 724052464D
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 17:02:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CQZLI6wt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730028AbfLERCG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Dec 2019 12:02:06 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:44243 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726257AbfLERCG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 12:02:06 -0500
Received: by mail-ed1-f65.google.com with SMTP id cm12so3271815edb.11
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2019 09:02:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=b6Cleg5skflMZ2QyscwPTbAfaq7s15gQy2+Wa63ePv0=;
        b=CQZLI6wt3BWIFwogUddoJz9QqvrbKWRIopyGCyDrGA9nQMZHfK7H4mUfhrGcoYLVlj
         XXoESTgdX3I9QBOgJ1TEy89MFt9aHu26uD/5Vde3hun5CJ24nbIh7zF+Kz0IvIqjAwI5
         wA/Wnb+K1WmVLGz1uG6SDCt/9hsYhFuVNGpvg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=b6Cleg5skflMZ2QyscwPTbAfaq7s15gQy2+Wa63ePv0=;
        b=KVYwKcLi9zHYo2CBkcVz8N7NHewpTC1w7/P5Uy66Yuw103cVVD//2JzY/w/69nYJNZ
         css8uwRTGbI++OrwshuwDULa3kf5cnUAQWuvPyn2jW5QBZTV+S+WgLTEdnPFTirZszDx
         10wl6E2O3+aPUqrwmp2gBY6ZR6vWZLSm4xUDptFj71f7mF7GIS9xVNy2S7FqfkWxw0oV
         yKK0hFvJ4HRWeSfccJo8N59OdPuxZBeXoKu/LOS0GJKUyiEdlguBSd/LR8vYLyTRCosd
         eKJJ7XF3YHy9rApaiMHrLC1PWSOUDzkHCIhDjwQDXbfnePVZ95qfiIc4S6yYhEk2U6yO
         KE5g==
X-Gm-Message-State: APjAAAVtlqqJ9TTw3nCBmZAdDpZuUBhRCG1bWAh13aq1+nBPPieeACxb
        nYxQAADaDOts3Tzw5nGQhOK3moGP1cw=
X-Google-Smtp-Source: APXvYqyUnH/5RR5qXTi3vprztnGgKp5hpBOT4S6JhnqubLesKnx+6Z13PVEmcDzAZVH0HwYJPylchA==
X-Received: by 2002:aa7:cd93:: with SMTP id x19mr6156108edv.77.1575565324002;
        Thu, 05 Dec 2019 09:02:04 -0800 (PST)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com. [209.85.128.43])
        by smtp.gmail.com with ESMTPSA id n10sm177552ejc.58.2019.12.05.09.02.02
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Dec 2019 09:02:02 -0800 (PST)
Received: by mail-wm1-f43.google.com with SMTP id y23so7809926wma.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2019 09:02:02 -0800 (PST)
X-Received: by 2002:a7b:c3c6:: with SMTP id t6mr6222539wmj.106.1575565321736;
 Thu, 05 Dec 2019 09:02:01 -0800 (PST)
MIME-Version: 1.0
References: <20191205000957.112719-1-thgarnie@chromium.org>
 <20191205000957.112719-5-thgarnie@chromium.org> <20191205090355.GC2810@hirez.programming.kicks-ass.net>
In-Reply-To: <20191205090355.GC2810@hirez.programming.kicks-ass.net>
From:   Thomas Garnier <thgarnie@chromium.org>
Date:   Thu, 5 Dec 2019 09:01:50 -0800
X-Gmail-Original-Message-ID: <CAJcbSZF+vGE6ZseiQfcis2NMcimmpwvov_P-tZe--z5UxJPDdg@mail.gmail.com>
Message-ID: <CAJcbSZF+vGE6ZseiQfcis2NMcimmpwvov_P-tZe--z5UxJPDdg@mail.gmail.com>
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

On Thu, Dec 5, 2019 at 1:04 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Wed, Dec 04, 2019 at 04:09:41PM -0800, Thomas Garnier wrote:
>
> > @@ -1625,7 +1627,11 @@ first_nmi:
> >       addq    $8, (%rsp)      /* Fix up RSP */
> >       pushfq                  /* RFLAGS */
> >       pushq   $__KERNEL_CS    /* CS */
> > -     pushq   $1f             /* RIP */
> > +     pushq   $0              /* Future return address */
>
> We're building an IRET frame, the IRET frame does not have a 'future
> return address' field.

I assumed that's the target RIP after iretq.

>
> > +     pushq   %rdx            /* Save RAX */
>
> fail..

Yes, sorry. I was asked to switch from RAX to RDX and missed the comment.

>
> > +     leaq    1f(%rip), %rdx  /* RIP */
>
> nonsensical comment

That was the same comment from the push $1f that I changed.

>
> > +     movq    %rdx, 8(%rsp)   /* Put 1f on return address */
> > +     popq    %rdx            /* Restore RAX */
>
> fail..

I will change in next iteration.

>
> >       iretq                   /* continues at repeat_nmi below */
> >       UNWIND_HINT_IRET_REGS
> >  1:
> > --
> > 2.24.0.393.g34dc348eaf-goog
> >
