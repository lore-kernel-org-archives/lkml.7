Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EA1AC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 08:16:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BE2F2054F
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 08:16:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W+lq4tE3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729032AbfC2IQD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 04:16:03 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:35044 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726320AbfC2IQD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 04:16:03 -0400
Received: by mail-pg1-f193.google.com with SMTP id g8so851290pgf.2;
        Fri, 29 Mar 2019 01:16:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=cTZwErMy/6ShUmeZ7S5k9yA7EQi480v9XQtsikB0Iyk=;
        b=W+lq4tE3YCjD1U52oRDyw0MITmhs+JG37iEPbBOYYWnLNS7rw+007GeaP97To0ALve
         5a59trA+XOpzFum/LO+uIHb3TO4/jgJFpHJPIjzP5bzR4vVQDHDkatNsQ0gVgIqkjw7p
         SILeRRq4UNFhzFd4spUDKsjR7StsjIjhqfAeQrgvsOVbdCZBBRPNTePmKQCR4dfeO3rl
         ecDlPtmpYenyBmsstmzszzPmSToyR5hDfcBW69h5Poq2DvyYkLWwH3p4UqbegK3Hkrc/
         AmR2rmjJqsgMVd7zyTITpAH9KhZJp6sBJu3S1HAAVDxVDNNJSeZJuUjb1sloQNoAP0Ge
         qx6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cTZwErMy/6ShUmeZ7S5k9yA7EQi480v9XQtsikB0Iyk=;
        b=pl+DINtArE2vhcZXxTZP9GHlDSYRguUpZXTgKLTA+qYJb5LhFFK0zxov/qs46/Yo+h
         XiPPxyTx4jKfET84wj0a6yDonD4QCZlVxqKt/hBSDpFlfLhZqFbQuW9qhiSbG8oD8tLv
         HWRr+Nj9MJ11tWRsgrJyxsUYavM8VvCaHHL8BKTgv0t6fM9SMVl/ouOuAL43L1bKZCms
         AQuKSrF2SfT1x/Pd7uCi7UROxJr3muMLZBgppwGHI5t/xVXES9Ix38N9ls1WJddvfJAA
         c1qvHUu9k4f38AK64vhnQVzi04PahVmGQHLZuEufmq2OJhmsTIFhumSbPf5WJoonsmAG
         z/mg==
X-Gm-Message-State: APjAAAWmLvY39BATHFmxOnnfdemOt809o6Jj/eT4NnN5MdnI4gZC+KMW
        aUGpBUBAZHddghUlg8nTUnY=
X-Google-Smtp-Source: APXvYqwR14W3/1b/twVjcbAzYIbpu4qF9zun+Lyl3trUkTfVw+1PD3qlqY+YWADGFtlIEzEbg8o8Jg==
X-Received: by 2002:aa7:8719:: with SMTP id b25mr45884459pfo.90.1553847362300;
        Fri, 29 Mar 2019 01:16:02 -0700 (PDT)
Received: from mail.google.com ([104.238.181.70])
        by smtp.gmail.com with ESMTPSA id c3sm1923288pfo.2.2019.03.29.01.16.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 29 Mar 2019 01:16:01 -0700 (PDT)
Date:   Fri, 29 Mar 2019 08:15:59 +0000
From:   Changbin Du <changbin.du@gmail.com>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Changbin Du <changbin.du@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] kconfig/[mn]conf: handle backspace (^H) key
Message-ID: <20190329081558.u54hczsjheacwvtk@mail.google.com>
References: <20190325151647.11581-1-changbin.du@gmail.com>
 <CAK7LNARkTQoAhjk7qPR4Pn0SHKvW4cvSrtC5brATQ2LbsWegtw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK7LNARkTQoAhjk7qPR4Pn0SHKvW4cvSrtC5brATQ2LbsWegtw@mail.gmail.com>
User-Agent: NeoMutt/20180716-508-7c9a6d
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 29, 2019 at 04:50:18PM +0900, Masahiro Yamada wrote:
> On Tue, Mar 26, 2019 at 12:16 AM Changbin Du <changbin.du@gmail.com> wrote:
> >
> > Backspace is not working on some terminal emulators which do not send the
> > key code defined by terminfo. Terminals either send '^H' (8) or '^?' (127).
> > But currently only '$?' is handled.
> 
> 
> 
> Shall I fix '$?' to '^?'
> if it is a typo?
>
yes, please. It is a typo, sorry.

> 
> 
> 
> > Let's also handle '^H' for those
> > terminals.
> >
> > Signed-off-by: Changbin Du <changbin.du@gmail.com>
> > ---
> >  scripts/kconfig/lxdialog/inputbox.c | 3 ++-
> >  scripts/kconfig/nconf.c             | 2 +-
> >  scripts/kconfig/nconf.gui.c         | 3 ++-
> >  3 files changed, 5 insertions(+), 3 deletions(-)
> >
> > diff --git a/scripts/kconfig/lxdialog/inputbox.c b/scripts/kconfig/lxdialog/inputbox.c
> > index 611945611bf8..1dcfb288ee63 100644
> > --- a/scripts/kconfig/lxdialog/inputbox.c
> > +++ b/scripts/kconfig/lxdialog/inputbox.c
> > @@ -113,7 +113,8 @@ int dialog_inputbox(const char *title, const char *prompt, int height, int width
> >                         case KEY_DOWN:
> >                                 break;
> >                         case KEY_BACKSPACE:
> > -                       case 127:
> > +                       case 8:   /* ^H */
> > +                       case 127: /* ^? */
> >                                 if (pos) {
> >                                         wattrset(dialog, dlg.inputbox.atr);
> >                                         if (input_x == 0) {
> > diff --git a/scripts/kconfig/nconf.c b/scripts/kconfig/nconf.c
> > index a4670f4e825a..ac92c0ded6c5 100644
> > --- a/scripts/kconfig/nconf.c
> > +++ b/scripts/kconfig/nconf.c
> > @@ -1048,7 +1048,7 @@ static int do_match(int key, struct match_state *state, int *ans)
> >                 state->match_direction = FIND_NEXT_MATCH_UP;
> >                 *ans = get_mext_match(state->pattern,
> >                                 state->match_direction);
> > -       } else if (key == KEY_BACKSPACE || key == 127) {
> > +       } else if (key == KEY_BACKSPACE || key == 8 || key == 127) {
> >                 state->pattern[strlen(state->pattern)-1] = '\0';
> >                 adj_match_dir(&state->match_direction);
> >         } else
> > diff --git a/scripts/kconfig/nconf.gui.c b/scripts/kconfig/nconf.gui.c
> > index 7be620a1fcdb..77f525a8617c 100644
> > --- a/scripts/kconfig/nconf.gui.c
> > +++ b/scripts/kconfig/nconf.gui.c
> > @@ -439,7 +439,8 @@ int dialog_inputbox(WINDOW *main_window,
> >                 case KEY_F(F_EXIT):
> >                 case KEY_F(F_BACK):
> >                         break;
> > -               case 127:
> > +               case 8:   /* ^H */
> > +               case 127: /* ^? */
> >                 case KEY_BACKSPACE:
> >                         if (cursor_position > 0) {
> >                                 memmove(&result[cursor_position-1],
> > --
> > 2.17.1
> >
> 
> 
> -- 
> Best Regards
> Masahiro Yamada

-- 
Cheers,
Changbin Du
