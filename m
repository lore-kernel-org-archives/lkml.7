Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42190C432C3
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 21:44:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38D41206E5
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 21:44:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m+9bkvC9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726613AbfKMVoy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 16:44:54 -0500
Received: from mail-il1-f193.google.com ([209.85.166.193]:36800 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726162AbfKMVox (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 16:44:53 -0500
Received: by mail-il1-f193.google.com with SMTP id s75so3253979ilc.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2019 13:44:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZSLVM11pGBINfynHILkQr3Q7Agr06MqGgvwQD+nhlgc=;
        b=m+9bkvC9Pxf9vNvByeufwcwPMm1n2llu1QW0B/DI0V0wv7oIZsi/2Q/TyuEaFqqsaB
         46yZUboC8d6/pdTAHoeDOX0los6fZ8BJtJSUKZXQIL9gUGur61P8S8MA/Vr8cJAm0fPd
         aqJa4K3cqf9gVePIz0utXW5rbw0rQYjsgp6+vaf8E+NALw8ZySG0T8ADVS7h1fyirWt8
         h56DWugp7B3HFpsIvUQ32OV5N2qVctWgsjPa/XnDHki1U73aaFOBA2OKc0d6HxNccKPF
         jH5cnzxE1AZaN66ejZGjysbUMpGHWOxEbDNKqEimrN8hQ9D3/Gx9C8Tu+ue7RDcs9rWA
         7iPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZSLVM11pGBINfynHILkQr3Q7Agr06MqGgvwQD+nhlgc=;
        b=ZzP3qpL2KNFDN3pMwV2DgW1g3aIHxUrIUHmOzEyrHPHjOldkye/TsTUR8MX+vwSx6s
         5fAeTR08AQlxlPEaDqNaDONCBTgrzDFk999s53xLWEkuZdtbZUihuA1THORo6k6CuocP
         H0lVmbePvNZUEdh4LauRqKX0CcWLbSjLbCC9fYb29lfDak/GFpzZq1V5FeyxlJuCXlYr
         H5UckteSl43lH9oOJN3+Z04Ht6TaA0oVjhhtTN509+d8pFc+0qAQsLlgJnqSINTpoi9G
         spCkwmKAzY6NuXUkYxg/9f5F4k/BkVOum4R+FDWaezsdShZGMOsTx64yyEheq97s9N3E
         Bw8A==
X-Gm-Message-State: APjAAAXdXFwR/DMxGU1JoyvCcSJf4CQP5gJPXiuhigfyb8d7Y1i9qcfN
        tBGZCd5RsmenDXqSQhW2T84pTZekidcxIJtlvA==
X-Google-Smtp-Source: APXvYqwbwmKbJ+T38L73R26GYObNwzOe09ajwHpO8oXk587naEbAqp+afVd5E89SyeF+vLXx2HM+e2sX8x8pxX2bwA0=
X-Received: by 2002:a92:5d8d:: with SMTP id e13mr6740093ilg.32.1573681492571;
 Wed, 13 Nov 2019 13:44:52 -0800 (PST)
MIME-Version: 1.0
References: <20191113204240.767922595@linutronix.de> <20191113210103.911310593@linutronix.de>
 <CAHk-=whNAEuNPU3Oy_-EpjOojpysWcCh4uqDgOt2RjBNx2xBSg@mail.gmail.com>
In-Reply-To: <CAHk-=whNAEuNPU3Oy_-EpjOojpysWcCh4uqDgOt2RjBNx2xBSg@mail.gmail.com>
From:   Brian Gerst <brgerst@gmail.com>
Date:   Wed, 13 Nov 2019 16:44:39 -0500
Message-ID: <CAMzpN2h2=DRX=jmn4vDhgRCwYjH7Y0niCc9kn5DtX7yGpYbRKw@mail.gmail.com>
Subject: Re: [patch V3 02/20] x86/process: Unify copy_thread_tls()
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Stephen Hemminger <stephen@networkplumber.org>,
        Willy Tarreau <w@1wt.eu>, Juergen Gross <jgross@suse.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 13, 2019 at 4:14 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Wed, Nov 13, 2019 at 1:02 PM Thomas Gleixner <tglx@linutronix.de> wrote:
> >
> > +int copy_thread_tls(unsigned long clone_flags, unsigned long sp,
> > +                   unsigned long arg, struct task_struct *p, unsigned long tls)
> ...
> > +#ifdef CONFIG_X86_64
> ..
> > +#else
> > +       /* Clear all status flags including IF and set fixed bit. */
> > +       frame->flags = X86_EFLAGS_FIXED;
> > +#endif
>
> Hmm. The unification I like, but it also shows these differences that
> I don't remember the reason for.
>
> Remind me why __switch_to_asm() on 32-bit safes eflags, but we don't
> do it on x86-64?
>
> The comment just talks about callee-saved registers, but flags isn't
> callee-saved, so there's something else going on.
>
> This patch clearly doesn't change anything, I'm not complaining about
> the patch at all. I'm just wondering about the odd difference that the
> patch exposes.

It's to prevent AC from leaking into the next task.  objtool can
verify that 64-bit code doesn't schedule when AC is set, but it
doesn't work on 32-bit.  We could probably just do a CLAC on switch
and when it switches back to that task you would get an oops and it
would get noticed.  It's likely though that the 64-bit coverage has
fixed most of the places where this happened.

--
Brian Gerst
