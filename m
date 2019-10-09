Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59F45C47404
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 09:30:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DFDF206B6
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 09:30:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gLPsWmnc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730030AbfJIJaz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 05:30:55 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:33526 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726579AbfJIJaz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 05:30:55 -0400
Received: by mail-wm1-f68.google.com with SMTP id r17so4320734wme.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2019 02:30:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=txRsFexRpU1aPNeD8b7JBsX8kLmbN3JP80S/708Wgfo=;
        b=gLPsWmnczY0e7Wk71kiVoTCc+JY1/qPjMfZhqFjWWiHNLfnMrxfDVJ4ghpJXBnF/YO
         Ec7ocU5Li+FBvSx1Pzm6980RCiIuAvnrfezKS2Cye/spAHE3FLgVDDh5q+wych4laJK5
         12J0snnlMlN91oG5srZHsewi2HyMuLhJis4D5IpqC14ataRJR2udYgRWMCot19L8qS5N
         rlFxn5e8XqicCVlrcdR1QmC9YsLMjzIt7V922QQgaQd63vTb3esyyfWSzf/DfuZPD2MZ
         Ze8bt4iNG7rFJYsuWatafeTzxheh6f+VetzqNV8Nz1Yu1iMYMs9UayvzpS8evlLdg/JX
         rV/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=txRsFexRpU1aPNeD8b7JBsX8kLmbN3JP80S/708Wgfo=;
        b=ZVkksYIf2QIfr65GGRMhJFpn/NAPSUNfijSMLRJxRcdJP+lFyXNs+TgbAG7HuVtFlb
         yJcJjasV/TWNMC3v85TAk6lB1w2yHDGydt/e0KaV3vkH4D+YyWl78f3FnC6DA4Uf6BsO
         ncoH8X7BR8Nerz4/K4+RRMoVlgLPxadGGJdCyy9h+IfUBuchAYxEOYk2H3HJHy1axABi
         6KfjuX/Crt2fmhtPOK56gnYqJkbGE56svt6kjNJSbwqpTLWUPgw0Pt2PF7JtR4Ml6pJF
         oDiyz/M5SPrXrjdae9XA/dUuZ7/+LY301DTmS9qxJo9PefyDCQRB/DukJnKuyvg7H2Vm
         uD4w==
X-Gm-Message-State: APjAAAWItFbRlZI5z68ofL5mMZzeLw6ncwzIczushbHmMQVXqAEYmQ/L
        kjjVITUVLEm9jJ2ARc5HNjXvPUbLXLE4eg==
X-Google-Smtp-Source: APXvYqxEtDqy10+w0EezfdD5gJ8QG5/xCzlEo6BQTWYPwPc7Byjv7IsGWZz72CanmYJ3aEur7mF7Nw==
X-Received: by 2002:a1c:ed0d:: with SMTP id l13mr1863770wmh.76.1570613451951;
        Wed, 09 Oct 2019 02:30:51 -0700 (PDT)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id b186sm2330471wmd.16.2019.10.09.02.30.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2019 02:30:51 -0700 (PDT)
Date:   Wed, 9 Oct 2019 10:30:49 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Doug Anderson <dianders@chromium.org>
Cc:     Jason Wessel <jason.wessel@windriver.com>,
        kgdb-bugreport@lists.sourceforge.net,
        LKML <linux-kernel@vger.kernel.org>,
        Patch Tracking <patches@linaro.org>
Subject: Re: [PATCH v2 3/5] kdb: Remove special case logic from kdb_read()
Message-ID: <20191009093049.tnz442bo54bzmzmz@holly.lan>
References: <20191008132043.7966-1-daniel.thompson@linaro.org>
 <20191008132043.7966-4-daniel.thompson@linaro.org>
 <CAD=FV=W9Tdh2hPekzgSYnCqoTX_ms1GY-FXgnxd-uEW0SWbyuw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD=FV=W9Tdh2hPekzgSYnCqoTX_ms1GY-FXgnxd-uEW0SWbyuw@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 08, 2019 at 03:21:02PM -0700, Doug Anderson wrote:
> Hi,
> 
> On Tue, Oct 8, 2019 at 6:21 AM Daniel Thompson
> <daniel.thompson@linaro.org> wrote:
> >
> > kdb_read() contains special case logic to force it exit after reading
> > a single character. We can remove all the special case logic by directly
> > calling the function to read a single character instead. This also
> > allows us to tidy up the function prototype which, because it now matches
> > getchar(), we can also rename in order to make its role clearer.
> 
> nit: since you're doing the rename, should you rename
> kdb_read_handle_escape() to match?

Will do.


> > Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
> > ---
> >  kernel/debug/kdb/kdb_io.c | 56 ++++++++++++++++-----------------------
> >  1 file changed, 23 insertions(+), 33 deletions(-)
> >
> > diff --git a/kernel/debug/kdb/kdb_io.c b/kernel/debug/kdb/kdb_io.c
> > index 78cb6e339408..a9e73bc9d1c3 100644
> > --- a/kernel/debug/kdb/kdb_io.c
> > +++ b/kernel/debug/kdb/kdb_io.c
> > @@ -106,7 +106,19 @@ static int kdb_read_handle_escape(char *buf, size_t sz)
> >         return -1;
> >  }
> >
> > -static int kdb_read_get_key(char *buffer, size_t bufsize)
> > +/*
> > + * kdb_getchar
> > + *
> > + * Read a single character from kdb console (or consoles).
> 
> nit: should we start moving to the standard kernel convention of
> kernel-doc style comments?  See
> "Documentation/doc-guide/kernel-doc.rst"

It will look a little odd whilst the others are still in the old form
but it seems like a good direction of travel... will update.

> > + *
> > + * An escape key could be the start of a vt100 control sequence such as \e[D
> > + * (left arrow) or it could be a character in its own right.  The standard
> > + * method for detecting the difference is to wait for 2 seconds to see if there
> > + * are any other characters.  kdb is complicated by the lack of a timer service
> > + * (interrupts are off), by multiple input sources. Escape sequence processing
> > + * has to be done as states in the polling loop.
> 
> Before your paragraph, maybe add: "Most of the work of this function
> is dealing with escape sequences." to give it a little bit of context.
> 
> 
> > + */
> > +static int kdb_getchar(void)
> 
> Is "int" the right return type here, or "unsigned char"?  You never
> return EOF, right?  Always a valid character?  NOTE: if you do change
> this to "unsigned char" I think you still need to keep the local "key"
> variable as an "int" since -1 shouldn't be confused with the character
> 255.

unsigned char sounds best.


> >  {
> >  #define ESCAPE_UDELAY 1000
> >  #define ESCAPE_DELAY (2*1000000/ESCAPE_UDELAY) /* 2 seconds worth of udelays */
> > @@ -124,7 +136,6 @@ static int kdb_read_get_key(char *buffer, size_t bufsize)
> >                 }
> >
> >                 key = (*f)();
> > -
> >                 if (key == -1) {
> >                         if (escape_delay) {
> >                                 udelay(ESCAPE_UDELAY);
> > @@ -134,14 +145,6 @@ static int kdb_read_get_key(char *buffer, size_t bufsize)
> >                         continue;
> >                 }
> >
> > -               if (bufsize <= 2) {
> > -                       if (key == '\r')
> > -                               key = '\n';
> > -                       *buffer++ = key;
> > -                       *buffer = '\0';
> > -                       return -1;
> > -               }
> > -
> >                 if (escape_delay == 0 && key == '\e') {
> >                         escape_delay = ESCAPE_DELAY;
> >                         ped = escape_data;
> > @@ -183,17 +186,7 @@ static int kdb_read_get_key(char *buffer, size_t bufsize)
> >   *     function.  It is not reentrant - it relies on the fact
> >   *     that while kdb is running on only one "master debug" cpu.
> >   * Remarks:
> > - *
> > - * The buffer size must be >= 2.  A buffer size of 2 means that the caller only
> > - * wants a single key.
> 
> By removing this you broke "BTAPROMPT".  So doing:
> 
> set BTAPROMPT=1
> bta
> 
> It's now impossible to quit out.  Not that I've ever used BTAPROMPT,
> but seems like we should either get rid of it or keep it working.

Thanks. Just to check I got exactly what you meant I assume this could
also have been phrased as "it looks like you forgot to convert the
kdb_getstr() in kdb_bt1() over to use the new kdb_getchar() function"?

PS I will update kgdbtest to cover this case.


> > - *
> > - * An escape key could be the start of a vt100 control sequence such as \e[D
> > - * (left arrow) or it could be a character in its own right.  The standard
> > - * method for detecting the difference is to wait for 2 seconds to see if there
> > - * are any other characters.  kdb is complicated by the lack of a timer service
> > - * (interrupts are off), by multiple input sources and by the need to sometimes
> > - * return after just one key.  Escape sequence processing has to be done as
> > - * states in the polling loop.
> > + *     The buffer size must be >= 2.
> >   */
> >
> >  static char *kdb_read(char *buffer, size_t bufsize)
> > @@ -228,9 +221,7 @@ static char *kdb_read(char *buffer, size_t bufsize)
> >         *cp = '\0';
> >         kdb_printf("%s", buffer);
> >  poll_again:
> > -       key = kdb_read_get_key(buffer, bufsize);
> > -       if (key == -1)
> > -               return buffer;
> > +       key = kdb_getchar();
> >         if (key != 9)
> >                 tab = 0;
> >         switch (key) {
> > @@ -741,7 +732,7 @@ int vkdb_printf(enum kdb_msgsrc src, const char *fmt, va_list ap)
> >
> >         /* check for having reached the LINES number of printed lines */
> >         if (kdb_nextline >= linecount) {
> > -               char buf1[16] = "";
> > +               char ch;
> 
> The type of "ch" should be the same as returned by kdb_getchar()?
> Either "int" if you're keeping it "int" or "unsigned char"?

Probably... although the assumption that kdb strings are char * is burnt
in a lot of places so there will still be further tidy up needed.


> >                 /* Watch out for recursion here.  Any routine that calls
> >                  * kdb_printf will come back through here.  And kdb_read
> > @@ -776,39 +767,38 @@ int vkdb_printf(enum kdb_msgsrc src, const char *fmt, va_list ap)
> >                 if (logging)
> >                         printk("%s", moreprompt);
> >
> > -               kdb_read(buf1, 2); /* '2' indicates to return
> > -                                   * immediately after getting one key. */
> > +               ch = kdb_getchar();
> >                 kdb_nextline = 1;       /* Really set output line 1 */
> >
> >                 /* empty and reset the buffer: */
> >                 kdb_buffer[0] = '\0';
> >                 next_avail = kdb_buffer;
> >                 size_avail = sizeof(kdb_buffer);
> > -               if ((buf1[0] == 'q') || (buf1[0] == 'Q')) {
> > +               if ((ch == 'q') || (ch == 'Q')) {
> >                         /* user hit q or Q */
> >                         KDB_FLAG_SET(CMD_INTERRUPT); /* command interrupted */
> >                         KDB_STATE_CLEAR(PAGER);
> >                         /* end of command output; back to normal mode */
> >                         kdb_grepping_flag = 0;
> >                         kdb_printf("\n");
> > -               } else if (buf1[0] == ' ') {
> > +               } else if (ch == ' ') {
> >                         kdb_printf("\r");
> >                         suspend_grep = 1; /* for this recursion */
> > -               } else if (buf1[0] == '\n') {
> > +               } else if (ch == '\n' || ch == '\r') {
> >                         kdb_nextline = linecount - 1;
> >                         kdb_printf("\r");
> >                         suspend_grep = 1; /* for this recursion */
> > -               } else if (buf1[0] == '/' && !kdb_grepping_flag) {
> > +               } else if (ch == '/' && !kdb_grepping_flag) {
> >                         kdb_printf("\r");
> >                         kdb_getstr(kdb_grep_string, KDB_GREP_STRLEN,
> >                                    kdbgetenv("SEARCHPROMPT") ?: "search> ");
> >                         *strchrnul(kdb_grep_string, '\n') = '\0';
> >                         kdb_grepping_flag += KDB_GREPPING_FLAG_SEARCH;
> >                         suspend_grep = 1; /* for this recursion */
> > -               } else if (buf1[0] && buf1[0] != '\n') {
> > +               } else if (ch && ch != '\n') {
> 
> Remove "&& ch != '\n'".  We would have hit an earlier case in the
> if/else anyway.  If you really want to keep it here for some reason, I
> guess you should also handle '\r' ?

Let's remove.


Daniel.
