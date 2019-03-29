Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECCE5C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 07:51:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B82A02173C
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 07:51:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="aL+p9l6p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728962AbfC2HvG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 03:51:06 -0400
Received: from conssluserg-04.nifty.com ([210.131.2.83]:54249 "EHLO
        conssluserg-04.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728790AbfC2HvG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 03:51:06 -0400
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com [209.85.217.53]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id x2T7osLo016111;
        Fri, 29 Mar 2019 16:50:55 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com x2T7osLo016111
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1553845855;
        bh=saaWUDP5mX8qsiYFCsd+ZIOMYcMZuJ2jJy8/XAZsDrk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=aL+p9l6p2lqL1j1L+IywrYbFgxaHSDlManZVgJk1Kl0SNYMG7vqsuI7Ze8KprMGfX
         z5pK+aKghpbhrY8y4O7L6LjwovJAU2TNF90B0WUsbyufDvqJ1tb8ix2iwYfzeubac0
         yrCcN/WBDvSjih2q/rIzr/f7UjV7OQBXvTrfxFVoFNjF9TLoetQ9vLSjS/XLIADwxV
         ZPZUak1/PpewciFoTi0W0fi8BvU5Z7caa/DJteTQy0BWrUV9ttNBrxfnayF2FQxkAg
         Yl2UvlSNlzQCJs4aW9Nwzhh0wC7dmzCDP9nb0kcxO64dEUaArCDKGx9j50FMgFQbtB
         zCLskRZNwaZBw==
X-Nifty-SrcIP: [209.85.217.53]
Received: by mail-vs1-f53.google.com with SMTP id a190so783358vsd.0;
        Fri, 29 Mar 2019 00:50:55 -0700 (PDT)
X-Gm-Message-State: APjAAAW5RHEu0pzcGfu2X4hQ0X2B+no9Ml6oUHQ/a+SaBRBYh2hUA6pQ
        Qah3cRrz5hK/Xi0V9H2oMlGLhUEjXw2hdH/q4Tk=
X-Google-Smtp-Source: APXvYqxrBougeDSbU6DOvnHSS/mliUulvmRdEX5+F8nhCSAd6/fpNZeOTSTnEK3BUxiBgjWKWiRIfxPCib0UGmld1B0=
X-Received: by 2002:a67:f105:: with SMTP id n5mr29060648vsk.181.1553845854408;
 Fri, 29 Mar 2019 00:50:54 -0700 (PDT)
MIME-Version: 1.0
References: <20190325151647.11581-1-changbin.du@gmail.com>
In-Reply-To: <20190325151647.11581-1-changbin.du@gmail.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Fri, 29 Mar 2019 16:50:18 +0900
X-Gmail-Original-Message-ID: <CAK7LNARkTQoAhjk7qPR4Pn0SHKvW4cvSrtC5brATQ2LbsWegtw@mail.gmail.com>
Message-ID: <CAK7LNARkTQoAhjk7qPR4Pn0SHKvW4cvSrtC5brATQ2LbsWegtw@mail.gmail.com>
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

On Tue, Mar 26, 2019 at 12:16 AM Changbin Du <changbin.du@gmail.com> wrote:
>
> Backspace is not working on some terminal emulators which do not send the
> key code defined by terminfo. Terminals either send '^H' (8) or '^?' (127).
> But currently only '$?' is handled.



Shall I fix '$?' to '^?'
if it is a typo?




> Let's also handle '^H' for those
> terminals.
>
> Signed-off-by: Changbin Du <changbin.du@gmail.com>
> ---
>  scripts/kconfig/lxdialog/inputbox.c | 3 ++-
>  scripts/kconfig/nconf.c             | 2 +-
>  scripts/kconfig/nconf.gui.c         | 3 ++-
>  3 files changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/scripts/kconfig/lxdialog/inputbox.c b/scripts/kconfig/lxdialog/inputbox.c
> index 611945611bf8..1dcfb288ee63 100644
> --- a/scripts/kconfig/lxdialog/inputbox.c
> +++ b/scripts/kconfig/lxdialog/inputbox.c
> @@ -113,7 +113,8 @@ int dialog_inputbox(const char *title, const char *prompt, int height, int width
>                         case KEY_DOWN:
>                                 break;
>                         case KEY_BACKSPACE:
> -                       case 127:
> +                       case 8:   /* ^H */
> +                       case 127: /* ^? */
>                                 if (pos) {
>                                         wattrset(dialog, dlg.inputbox.atr);
>                                         if (input_x == 0) {
> diff --git a/scripts/kconfig/nconf.c b/scripts/kconfig/nconf.c
> index a4670f4e825a..ac92c0ded6c5 100644
> --- a/scripts/kconfig/nconf.c
> +++ b/scripts/kconfig/nconf.c
> @@ -1048,7 +1048,7 @@ static int do_match(int key, struct match_state *state, int *ans)
>                 state->match_direction = FIND_NEXT_MATCH_UP;
>                 *ans = get_mext_match(state->pattern,
>                                 state->match_direction);
> -       } else if (key == KEY_BACKSPACE || key == 127) {
> +       } else if (key == KEY_BACKSPACE || key == 8 || key == 127) {
>                 state->pattern[strlen(state->pattern)-1] = '\0';
>                 adj_match_dir(&state->match_direction);
>         } else
> diff --git a/scripts/kconfig/nconf.gui.c b/scripts/kconfig/nconf.gui.c
> index 7be620a1fcdb..77f525a8617c 100644
> --- a/scripts/kconfig/nconf.gui.c
> +++ b/scripts/kconfig/nconf.gui.c
> @@ -439,7 +439,8 @@ int dialog_inputbox(WINDOW *main_window,
>                 case KEY_F(F_EXIT):
>                 case KEY_F(F_BACK):
>                         break;
> -               case 127:
> +               case 8:   /* ^H */
> +               case 127: /* ^? */
>                 case KEY_BACKSPACE:
>                         if (cursor_position > 0) {
>                                 memmove(&result[cursor_position-1],
> --
> 2.17.1
>


-- 
Best Regards
Masahiro Yamada
