Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00779C4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 18:44:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3A60214DA
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 18:44:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kyTd38Qs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726785AbfF1So3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 14:44:29 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:40222 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726620AbfF1So2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 14:44:28 -0400
Received: by mail-pl1-f195.google.com with SMTP id a93so3726328pla.7
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2019 11:44:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8ICRQXbhD4k5gkrjYWUCNLpqdugrkLTq1Vx2puXpxxs=;
        b=kyTd38QsGKQjnVXftWi5tvIU8gEX4QfDPHXjl2glvXlGxmewnXR5IyiY/vs9DGA4eL
         Q5W+oAj/7vxEku7JV6mu94ySEnp/+5HfiegDcNR3j/zW06o8ZmzLYbTCbebcOhwfoq7r
         8NrFCson333FPLaWIlwa8JBktz0/6zmtmLBxYHyYBSXfHPSmkan0UNgrGHZBxFRyom1s
         BQFSkbyGOMuPgiNanY5LTmLFeLjmcomrV3iUcIFxZqKxKQ91Wk8pk/MF9tUqQuz0yD/O
         Y2YASZ1ZRVzbd/e5LsnK/FTmsT3qy4UryEMwqMHsW4oyW38AmoxLNTJOOg8suGGi+L/9
         Dk0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8ICRQXbhD4k5gkrjYWUCNLpqdugrkLTq1Vx2puXpxxs=;
        b=XlOsadcm4K/ZV/RZBvByzILM1qRo3BvB1JjHjAihmvzNTHTc9vku70qOqs55fqVnC7
         bIJ2kv9W5rk4dz0/4kj9i7k8S1shhTdyfPuYsF9RdyhIxdiZvv2wt+svCHuOCPspOy3E
         q4j5PKCP1wLjXKAfYmmfO5BzA5xqQx9aLOGv7l0vmr9+74ANxcuHl7wE4vkMCRL0IQfM
         5jB10pLVEOobeMNM8fBR0vua21lFW3+Feiea7cASDc0BUbb3fkPz5wGlyqNtwXjHdA6x
         2vBHpX2+5y47QLAKpSwxWxlns6Hj8n/8z+tbvhRHr06vlK9X91IJw8uweLqRHumH5Imi
         aJ3w==
X-Gm-Message-State: APjAAAXHWq4mIy8g6zQhUMCk2STLh2+gZ0ThSw2DcrEBdSZulaGZ+/Gr
        aV2OTxrukHkDM7bV+7kPhgeiSklTKPo9K5VIjaLeTg==
X-Google-Smtp-Source: APXvYqyXUb2Iee3BoGT7w2f+SONO80weM4D3nGBR0kSNEFydLE7pEwcm21NfVhhvQac9AQ0TcVT+7adspWwoVd0GcTI=
X-Received: by 2002:a17:902:9f93:: with SMTP id g19mr13121233plq.223.1561747467714;
 Fri, 28 Jun 2019 11:44:27 -0700 (PDT)
MIME-Version: 1.0
References: <b00fc090d83ac6bd41a5db866b02d425d9ab20e4.camel@perches.com>
 <20190624203737.GL3436@hirez.programming.kicks-ass.net> <3dc75cd4-9a8d-f454-b5fb-64c3e6d1f416@embeddedor.com>
 <CANiq72mMS6tHcP8MHW63YRmbdFrD3ZCWMbnQEeHUVN49v7wyXQ@mail.gmail.com>
 <20190625071846.GN3436@hirez.programming.kicks-ass.net> <CANiq72=zzZ+Cx8uM+5UW7HeB9XtbXRhXmC2y2tz5EzPX77gHMw@mail.gmail.com>
 <CAKwvOdn5j8Hkc_jrLMbhg-4jbNya+agtMJi=c9o01RPCno1Q+w@mail.gmail.com>
 <20190626084927.GI3419@hirez.programming.kicks-ass.net> <CAKwvOdkp7qnwLGY2=TOx=FQa1k2hEkdi1PO+9GfZkTQEUh49Rg@mail.gmail.com>
 <20190627071250.GZ3402@hirez.programming.kicks-ass.net> <20190628133105.GD3463@hirez.programming.kicks-ass.net>
In-Reply-To: <20190628133105.GD3463@hirez.programming.kicks-ass.net>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 28 Jun 2019 11:44:16 -0700
Message-ID: <CAKwvOdkx+=Z5-Ov4CY6y+XhMCNWa35BBFUdQWgP49PBTLr-Erg@mail.gmail.com>
Subject: Re: [PATCH] perf/x86/intel: Mark expected switch fall-throughs
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Joe Perches <joe@perches.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Shawn Landden <shawn@git.icu>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Chandler Carruth <chandlerc@google.com>,
        Jann Horn <jannh@google.com>, Bill Wendling <morbo@google.com>,
        Alexander Potapenko <glider@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 28, 2019 at 6:31 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Thu, Jun 27, 2019 at 09:12:50AM +0200, Peter Zijlstra wrote:
>
> > Josh came up with the following:
> >
> > +             /* If the jump target is close, do a 2-byte nop: */
> > +             ".skip -(%l[l_yes] - 1b <= 126), 0x66\n"
> > +             ".skip -(%l[l_yes] - 1b <= 126), 0x90\n"
> > +             /* Otherwise do a 5-byte nop: */
> > +             ".skip -(%l[l_yes] - 1b > 126), 0x0f\n"
> > +             ".skip -(%l[l_yes] - 1b > 126), 0x1f\n"
> > +             ".skip -(%l[l_yes] - 1b > 126), 0x44\n"
> > +             ".skip -(%l[l_yes] - 1b > 126), 0x00\n"
> > +             ".skip -(%l[l_yes] - 1b > 126), 0x00\n"
> >
> > Which is a wonderfully gruesome hack :-) So I'll be playing with that
> > for a bit.
>
> For those with interest; full patches at:
>
>   https://lkml.kernel.org/r/20190628102113.360432762@infradead.org

Do you have a branch pushed that I can pull this from to quickly test w/ Clang?

The .skip trick is wild; I don't quite understand the negation in the
above or patch 8/8 for is_byte/is_long.

Also, the comment on 8/8 about patching early hits home; we had a
sign-extending-booleans bug that was causing the address calculation
to be off by two.  Jann and Bill had to help me debug that one, and
funnily enough Kees fixed it in LLVM.  Fetching exception frames out
of early_idt_handler_common has been my most memorable kernel
debugging experience to date, and hope I don't have to do that ever
again.  Kees this week adjusted where arm64 does static_key enablement
(moved it earlier for Alexander Potapenko's slab
initialization/poisoning set).

For the wrong __jump_table entry; I consider that a critical issue we
need to fix before the clang-9 release.  I'm unloading my current
responsibilities at work to be able to sit and focus on bug.  I'll
probably start a new thread with you, tglx, Josh, and our mailing list
next week (sorry for co-opting this thread).  I have been using
creduce quite successfully for finding and fixing our previous codegen
bugs (https://nickdesaulniers.github.io/blog/2019/01/18/finding-compiler-bugs-with-c-reduce/),
but I need to sit and understand the precise failure more in order to
reduce the input.  We can see pretty well where in the compilation
pipeline things go wrong; I just find it hard to page through large
inputs such as whole translation units.
-- 
Thanks,
~Nick Desaulniers
