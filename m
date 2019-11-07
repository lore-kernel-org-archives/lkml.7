Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03528C5DF61
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 07:27:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8B172187F
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 07:27:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727064AbfKGH1l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 02:27:41 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:36817 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726498AbfKGH1l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 02:27:41 -0500
Received: by mail-ot1-f66.google.com with SMTP id f10so1191173oto.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2019 23:27:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OyZRQhNQF0un9Il/ZL90jb+EZuA06+9poSITN0etujY=;
        b=K5r9/ZLYLtro3cwZ7lmelYQDBVk6Bt2IsLaHgGUcQ7D4HtebYZ4Q0PO0tR4MDsduEe
         OuRdwJzRxpDeCwUChx+N+WRFxXVKe9XtTDQkkj92mRBXDYq1jX4zh2tuXQylJeykc2Vz
         GcLbLwSUbZ8kqBv34SkpLY2eW0BRz3an5MyWWYhK3P6guBSLC7FKMKvQZvT24lTiEkQ9
         u0dnVPvdkFdk5BBwAPKKv3tVUaT+HhNUznBlDcpncsoymTHPz70Ojg4xecSgguhX2mXG
         HA/XYxMafrQ8DEBI/c06y8R23Smy8dzqG3uxgATxyWzjY9XkwYrYf4BjVneVFn22FS4g
         /a4g==
X-Gm-Message-State: APjAAAW1xXXMk/ffyn5y//83h2MlqQpWlbIcXa6Zo8w47WOrPdIAzvfo
        i5jXDlvyIiBu7ESiteB4eNDGUON9aFqtaPs6g0M=
X-Google-Smtp-Source: APXvYqykgZBVOySzL/pYLBsJxZ5aXHvbyLGB90p/46uVfriKEO80e1NDA1RsceYYsaUe474Gg2sgcKKSWM5Uy20CMpw=
X-Received: by 2002:a9d:422:: with SMTP id 31mr1630520otc.107.1573111660358;
 Wed, 06 Nov 2019 23:27:40 -0800 (PST)
MIME-Version: 1.0
References: <20191106030542.868541-1-dima@arista.com> <20191106092039.GT4131@hirez.programming.kicks-ass.net>
 <10db6fa1-5b17-ebe6-09e0-6335e09e4db8@arista.com> <20191106203440.GH3079@worktop.programming.kicks-ass.net>
 <20191106232512.GU25745@shell.armlinux.org.uk>
In-Reply-To: <20191106232512.GU25745@shell.armlinux.org.uk>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 7 Nov 2019 08:27:29 +0100
Message-ID: <CAMuHMdVV67se-DzG=aDL4Y7NsctNRbi0P2p-SSgG7kh0Ce4TOQ@mail.gmail.com>
Subject: Re: [PATCH 00/50] Add log level to show_stack()
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Whitcroft <apw@canonical.com>,
        Joe Perches <joe@perches.com>,
        Dmitry Safonov <dima@arista.com>,
        Petr Mladek <pmladek@suse.com>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Russell,

(reduced CC list)

On Thu, Nov 7, 2019 at 12:28 AM Russell King - ARM Linux admin
<linux@armlinux.org.uk> wrote:
> On Wed, Nov 06, 2019 at 09:34:40PM +0100, Peter Zijlstra wrote:
> > I suppose I'm surprised there are backtraces that are not important.
> > Either badness happened and it needs printing, or the user asked for it
> > and it needs printing.
>
> Or utterly meaningless.
>
> > Perhaps we should be removing backtraces if they're not important
> > instead of allowing to print them as lower loglevels?
>
> Definitely!  WARN_ON() is well overused - and as is typical, used
> without much thought.  Bound to happen after Linus got shirty about
> BUG_ON() being over used.  Everyone just grabbed the next nearest thing
> to assert().

Which is what checkpatch.pl suggests...

> As a kind of example, I've recently come across one WARN_ON() in a
> driver subsystem (that shall remain nameless at the moment) which very
> likely has multiple different devices on a platform.  The WARN_ON()
> triggers as a result of a problem with the hardware, but because it's a
> WARN_ON(), you've no idea which device has a problem.  The backtrace is
> mostly meaningless.  So you know that a problem has occurred, but the
> kernel prints *useless* backtrace to let you know, and totally omits
> the *useful* information.

So that callsite should be converted to use dev_WARN(), with a suitable
message.

Perhaps checkpatch should be updated, to suggest {,dev_}WARN()
instead of WARN_ON(), and add a check for the latter, too?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
