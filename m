Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 003BCC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 13:51:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9BD62173C
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 13:51:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="oQ6DqanQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729731AbfC2NvH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 09:51:07 -0400
Received: from conssluserg-06.nifty.com ([210.131.2.91]:21542 "EHLO
        conssluserg-06.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729639AbfC2NvH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 09:51:07 -0400
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id x2TDofYT028644;
        Fri, 29 Mar 2019 22:50:41 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com x2TDofYT028644
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1553867442;
        bh=z07dstaWaASY9Xr9tFB5a3Sy7OXdHBbB/QFb0ZKL+5Q=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=oQ6DqanQuwRMxvpEiKoE7e8P4STQmFYuZTj4W5I9Om2g/Xlr0kwmvvdIYqPzj1lX7
         Xqk3s3AzqVTS6cfp4xJ3O5T2Q3VS/9m12B2ljM7ACdfKqIGLR7hEHH/XVi+12aOJWm
         x6GoYxNd0xOUgqxF1HtSuENYCvjxxF6vwlGQRrgA4Cwt83bd/5D1ZKTxUTNVk1lUa4
         7Y2DhreDZCwuCRvWoJbEeSw/6LMCNFHQzhJOL9YWC8N0MlBOVW3NkHaF7QFe7Dz3h5
         hquoDM9607EIsxSG159wOtbP0UYGfjKd5bxnsRXBKYa0h3cfDVwjah0W5dXZv+NEll
         aI+6Vnhf+o53g==
X-Nifty-SrcIP: [209.85.222.52]
Received: by mail-ua1-f52.google.com with SMTP id f88so686879uaf.2;
        Fri, 29 Mar 2019 06:50:41 -0700 (PDT)
X-Gm-Message-State: APjAAAVixeUqqhIENyw55YMPjE1mSi4LpcJHXMXXZqyEg2Fbzr1Aa+jb
        FRAO96+WUfg0ZHCZGDsGC59cyYe9sX/yLIXBi8o=
X-Google-Smtp-Source: APXvYqxkZauXKtY9hE+RQiBpumEp1M5sUCzTyG3eeRks+HcvWSgRSGHhkO06tsXvjiO3k0AE0nRrQYHCd6aW/S2jrg4=
X-Received: by 2002:ab0:3058:: with SMTP id x24mr17778681ual.95.1553867440537;
 Fri, 29 Mar 2019 06:50:40 -0700 (PDT)
MIME-Version: 1.0
References: <20190325151647.11581-1-changbin.du@gmail.com> <CAK7LNARkTQoAhjk7qPR4Pn0SHKvW4cvSrtC5brATQ2LbsWegtw@mail.gmail.com>
 <20190329081558.u54hczsjheacwvtk@mail.google.com>
In-Reply-To: <20190329081558.u54hczsjheacwvtk@mail.google.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Fri, 29 Mar 2019 22:50:04 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQ9-m5BKcNwwNp1m-PeX+B+fFwBVqKc88Trsyu4E+J1uQ@mail.gmail.com>
Message-ID: <CAK7LNAQ9-m5BKcNwwNp1m-PeX+B+fFwBVqKc88Trsyu4E+J1uQ@mail.gmail.com>
Subject: Re: [PATCH] kconfig/[mn]conf: handle backspace (^H) key
To:     Changbin Du <changbin.du@gmail.com>
Cc:     Sam Ravnborg <sam@ravnborg.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 29, 2019 at 5:16 PM Changbin Du <changbin.du@gmail.com> wrote:
>
> On Fri, Mar 29, 2019 at 04:50:18PM +0900, Masahiro Yamada wrote:
> > On Tue, Mar 26, 2019 at 12:16 AM Changbin Du <changbin.du@gmail.com> wrote:
> > >
> > > Backspace is not working on some terminal emulators which do not send the
> > > key code defined by terminfo. Terminals either send '^H' (8) or '^?' (127).
> > > But currently only '$?' is handled.
> >
> >
> >
> > Shall I fix '$?' to '^?'
> > if it is a typo?
> >
> yes, please. It is a typo, sorry.
>

Fixed the typo,
and applied to linux-kbuild/fixes. Thanks.



> >
> >
> >
> > > Let's also handle '^H' for those
> > > terminals.
> > >
> > > Signed-off-by: Changbin Du <changbin.du@gmail.com>
> > > ---
> > >  scripts/kconfig/lxdialog/inputbox.c | 3 ++-
> > >  scripts/kconfig/nconf.c             | 2 +-
> > >  scripts/kconfig/nconf.gui.c         | 3 ++-
> > >  3 files changed, 5 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/scripts/kconfig/lxdialog/inputbox.c b/scripts/kconfig/lxdialog/inputbox.c
> > > index 611945611bf8..1dcfb288ee63 100644
> > > --- a/scripts/kconfig/lxdialog/inputbox.c
> > > +++ b/scripts/kconfig/lxdialog/inputbox.c
> > > @@ -113,7 +113,8 @@ int dialog_inputbox(const char *title, const char *prompt, int height, int width
> > >                         case KEY_DOWN:
> > >                                 break;
> > >                         case KEY_BACKSPACE:
> > > -                       case 127:
> > > +                       case 8:   /* ^H */
> > > +                       case 127: /* ^? */
> > >                                 if (pos) {
> > >                                         wattrset(dialog, dlg.inputbox.atr);
> > >                                         if (input_x == 0) {
> > > diff --git a/scripts/kconfig/nconf.c b/scripts/kconfig/nconf.c
> > > index a4670f4e825a..ac92c0ded6c5 100644
> > > --- a/scripts/kconfig/nconf.c
> > > +++ b/scripts/kconfig/nconf.c
> > > @@ -1048,7 +1048,7 @@ static int do_match(int key, struct match_state *state, int *ans)
> > >                 state->match_direction = FIND_NEXT_MATCH_UP;
> > >                 *ans = get_mext_match(state->pattern,
> > >                                 state->match_direction);
> > > -       } else if (key == KEY_BACKSPACE || key == 127) {
> > > +       } else if (key == KEY_BACKSPACE || key == 8 || key == 127) {
> > >                 state->pattern[strlen(state->pattern)-1] = '\0';
> > >                 adj_match_dir(&state->match_direction);
> > >         } else
> > > diff --git a/scripts/kconfig/nconf.gui.c b/scripts/kconfig/nconf.gui.c
> > > index 7be620a1fcdb..77f525a8617c 100644
> > > --- a/scripts/kconfig/nconf.gui.c
> > > +++ b/scripts/kconfig/nconf.gui.c
> > > @@ -439,7 +439,8 @@ int dialog_inputbox(WINDOW *main_window,
> > >                 case KEY_F(F_EXIT):
> > >                 case KEY_F(F_BACK):
> > >                         break;
> > > -               case 127:
> > > +               case 8:   /* ^H */
> > > +               case 127: /* ^? */
> > >                 case KEY_BACKSPACE:
> > >                         if (cursor_position > 0) {
> > >                                 memmove(&result[cursor_position-1],
> > > --
> > > 2.17.1
> > >
> >
> >
> > --
> > Best Regards
> > Masahiro Yamada
>
> --
> Cheers,
> Changbin Du



-- 
Best Regards
Masahiro Yamada
