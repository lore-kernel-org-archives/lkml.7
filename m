Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29288C43603
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 19:12:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E214F206D3
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 19:12:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pbqu7Uup"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727507AbfLTTM4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Dec 2019 14:12:56 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:32911 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727394AbfLTTM4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 14:12:56 -0500
Received: by mail-ot1-f67.google.com with SMTP id b18so13074552otp.0
        for <linux-kernel@vger.kernel.org>; Fri, 20 Dec 2019 11:12:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=AQWMjzoLCchFmkZQ8yhMwAYAhwyzEvr1a64rPKNFxB4=;
        b=Pbqu7UupB2EYsZh+hTy7kjO/q1gxbSy1z2jY5c2oA/FCN4NNNczxu4DpmrWeKeQ7M2
         m47dRxlQkR+JfBnoWta9zl1yjp27qUBQu/E/OrrNeRTfKv7qMrACl8wX4w9Bo+snpQ6R
         rI5czGFV2gk52zy4thFvvo7db0W3Mut2foTYdiRJi/KAtrTqo/LmfI5gnO3gYadLGzJd
         Wrht3XmP5dyX8EQmyfZZqBI6e1Ddlfw9r3/PsqZLAgYacA5v109DkMQW6ubB7EpI2Fmb
         gj4eNSyxNmsF9OD2xc7WImUbij4Skh4CvPVM0ASOGL8odaC8nHAaKroQeaibpcjxWKZl
         DVrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=AQWMjzoLCchFmkZQ8yhMwAYAhwyzEvr1a64rPKNFxB4=;
        b=Y+YJBffMzw3T3RTNYAzr1LItSpjJSy2z/DJpaMokTiq5tXgFpzUBuBGeMKyw2wiQxk
         Y9/1QiU+Ad3EnJD8fylJqNDK2o7SKQQu7pLI0D8m6/KUJs8Imq7zVnNu2hVUikqYDa1u
         gDitqOpx8e/s9e2+HOtDPm4JA3Q3jPLUWXkfO+zf3aVivXOgxlHqe9qKDbybMyC1fM84
         BVnjY4x81QmgM45SHLa9cMcGe4hgLklOr2AOciMyhMJws48R5CfkhKpSKeK1Q7w8FHql
         u+vCGq9x9ZnOssRsbWOGZP0E7FvfNlkhcilcoVkQL7SG1LvNU8EuKXLrBPK3Jmw68WUh
         R7LA==
X-Gm-Message-State: APjAAAXrLBdR5MLPliTM7X8iWwEMScWYFNQ4MyCX3UIMUW9QfAxDRlZK
        FxgU21TxokNgw9EJOE2pvYk=
X-Google-Smtp-Source: APXvYqzvqBWgRmI+JNnmPNeeTqJKiimiDqt7psCHtzLX1rf/V/psOhcKGJfowUH7wRpWSMB7u8K+Fg==
X-Received: by 2002:a05:6830:11d2:: with SMTP id v18mr408027otq.151.1576869175365;
        Fri, 20 Dec 2019 11:12:55 -0800 (PST)
Received: from ubuntu-m2-xlarge-x86 ([2604:1380:4111:8b00::1])
        by smtp.gmail.com with ESMTPSA id r23sm3476683oij.38.2019.12.20.11.12.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 20 Dec 2019 11:12:54 -0800 (PST)
Date:   Fri, 20 Dec 2019 12:12:52 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Subject: Re: [PATCH] tty: synclink: Adjust indentation and style in several
 functions
Message-ID: <20191220191252.GA48729@ubuntu-m2-xlarge-x86>
References: <20191218022758.53697-1-natechancellor@gmail.com>
 <CAKwvOdnOYUy7M0upKsknwPJOa6iYwtaqZAafrxdb4z_=vDmuXw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOdnOYUy7M0upKsknwPJOa6iYwtaqZAafrxdb4z_=vDmuXw@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 20, 2019 at 10:04:02AM -0800, Nick Desaulniers wrote:
> On Tue, Dec 17, 2019 at 6:28 PM Nathan Chancellor
> <natechancellor@gmail.com> wrote:
> >
> > Clang warns:
> >
> > ../drivers/tty/synclink.c:1167:3: warning: misleading indentation;
> > statement is not part of the previous 'if' [-Wmisleading-indentation]
> >         if ( (status & RXSTATUS_ABORT_RECEIVED) &&
> >         ^
> > ../drivers/tty/synclink.c:1163:2: note: previous statement is here
> >         if ( debug_level >= DEBUG_LEVEL_ISR )
> >         ^
> > ../drivers/tty/synclink.c:1973:3: warning: misleading indentation;
> > statement is not part of the previous 'if' [-Wmisleading-indentation]
> >         if (I_BRKINT(info->port.tty) || I_PARMRK(info->port.tty))
> >         ^
> > ../drivers/tty/synclink.c:1971:2: note: previous statement is here
> >         if (I_INPCK(info->port.tty))
> >         ^
> > ../drivers/tty/synclink.c:3229:3: warning: misleading indentation;
> > statement is not part of the previous 'else' [-Wmisleading-indentation]
> >         usc_set_serial_signals(info);
> >         ^
> > ../drivers/tty/synclink.c:3227:2: note: previous statement is here
> >         else
> >         ^
> > ../drivers/tty/synclink.c:4918:4: warning: misleading indentation;
> > statement is not part of the previous 'else' [-Wmisleading-indentation]
> >                 if ( info->params.clock_speed )
> >                 ^
> > ../drivers/tty/synclink.c:4901:3: note: previous statement is here
> >                 else
> >                 ^
> > 4 warnings generated.
> >
> > The indentation on these lines is not at all consistent, tabs and spaces
> > are mixed together. Convert to just using tabs to be consistent with the
> > Linux kernel coding style and eliminate these warnings from clang.
> >
> > Additionally, clean up some of lines touched by the indentation shift to
> > eliminate checkpatch warnings and leave this code in a better condition
> > than when it was left.
> 
> Indeed, this file is kind of a mess.
> 
> >
> > -:10: ERROR: trailing whitespace
> > -:10: ERROR: that open brace { should be on the previous line
> > -:10: ERROR: space prohibited after that open parenthesis '('
> > -:14: ERROR: space prohibited before that close parenthesis ')'
> > -:82: ERROR: trailing whitespace
> > -:87: WARNING: Block comments use a trailing */ on a separate line
> > -:88: ERROR: that open brace { should be on the previous line
> > -:88: ERROR: space prohibited after that open parenthesis '('
> > -:88: ERROR: space prohibited before that close parenthesis ')'
> > -:99: ERROR: else should follow close brace '}'
> >
> > Link: https://github.com/ClangBuiltLinux/linux/issues/821
> > Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> > ---
> >  drivers/tty/synclink.c | 55 ++++++++++++++++++++----------------------
> >  1 file changed, 26 insertions(+), 29 deletions(-)
> >
> > diff --git a/drivers/tty/synclink.c b/drivers/tty/synclink.c
> > index 61dc6b4a43d0..586810defb21 100644
> > --- a/drivers/tty/synclink.c
> > +++ b/drivers/tty/synclink.c
> > @@ -1164,21 +1164,20 @@ static void mgsl_isr_receive_status( struct mgsl_struct *info )
> >                 printk("%s(%d):mgsl_isr_receive_status status=%04X\n",
> >                         __FILE__,__LINE__,status);
> >
> > -       if ( (status & RXSTATUS_ABORT_RECEIVED) &&
> > +       if ((status & RXSTATUS_ABORT_RECEIVED) &&
> >                 info->loopmode_insert_requested &&
> > -               usc_loopmode_active(info) )
> > -       {
> > +               usc_loopmode_active(info)) {
> >                 ++info->icount.rxabort;
> > -               info->loopmode_insert_requested = false;
> > -
> > -               /* clear CMR:13 to start echoing RxD to TxD */
> > +               info->loopmode_insert_requested = false;
> > +
> > +               /* clear CMR:13 to start echoing RxD to TxD */
> >                 info->cmr_value &= ~BIT13;
> > -               usc_OutReg(info, CMR, info->cmr_value);
> > -
> > +               usc_OutReg(info, CMR, info->cmr_value);
> > +
> >                 /* disable received abort irq (no longer required) */
> > -               usc_OutReg(info, RICR,
> > -                       (usc_InReg(info, RICR) & ~RXSTATUS_ABORT_RECEIVED));
> > -       }
> > +               usc_OutReg(info, RICR,
> > +                       (usc_InReg(info, RICR) & ~RXSTATUS_ABORT_RECEIVED));
> > +       }
> >
> >         if (status & (RXSTATUS_EXITED_HUNT | RXSTATUS_IDLE_RECEIVED)) {
> >                 if (status & RXSTATUS_EXITED_HUNT)
> > @@ -1970,8 +1969,8 @@ static void mgsl_change_params(struct mgsl_struct *info)
> 
> I'm surprised the next hunk isn't mgsl_isr_transmit_status() in
> L1211-L1268?  I don't mind reformatting this file, but would you mind:
> 1. splitting the changes that fix the warning and reformatting the
> rest of the file in two?  That way the warning fix is more likely to
> merge back cleanly to LTS branches with less risk of merge conflict?
> Warning fix first, then reformat.
> 2. reformat the whole thing, not just most of it.

Yes, I will go ahead and break down these three TTY commits into six
(first three fixing the Clang warnings then the next three fixing all of
the indentation and spacing warnings).

I should be able to do this tonight or tomorrow at some point.

Cheers,
Nathan
