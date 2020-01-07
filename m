Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0A7FC282DD
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 22:09:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4A89206F0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 22:09:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727491AbgAGWJc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 17:09:32 -0500
Received: from mout.kundenserver.de ([212.227.126.135]:51827 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726142AbgAGWJb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 17:09:31 -0500
Received: from mail-qk1-f181.google.com ([209.85.222.181]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1MUok5-1jFB2R0wpV-00QoDq for <linux-kernel@vger.kernel.org>; Tue, 07 Jan
 2020 23:09:30 +0100
Received: by mail-qk1-f181.google.com with SMTP id x129so876343qke.8
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jan 2020 14:09:30 -0800 (PST)
X-Gm-Message-State: APjAAAUTSge+cKmMjPVNYR1HscQTpbd2B03pTCFm2TKHZNe6PEmZwMK9
        4N2QkjjAP5prJ1gxl0NzDT6sBsDhs0cRk9mKjUg=
X-Google-Smtp-Source: APXvYqyh4XhRK9mmwA/xG3OF0WHgJZcWnnUxG0Jya3G/fVxWIQcA+2YFQ5BlUjCY92hnSt60E7na/jCofuSjk5V1hS8=
X-Received: by 2002:a37:84a:: with SMTP id 71mr1484972qki.138.1578434969137;
 Tue, 07 Jan 2020 14:09:29 -0800 (PST)
MIME-Version: 1.0
References: <20200107212747.4182515-1-arnd@arndb.de> <20200107220019.GC7869@pendragon.ideasonboard.com>
In-Reply-To: <20200107220019.GC7869@pendragon.ideasonboard.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 7 Jan 2020 23:09:13 +0100
X-Gmail-Original-Message-ID: <CAK8P3a1Gt10_OLF1dXiNBxcO-seJfutcPu3w_dsHKNsDN4r7-A@mail.gmail.com>
Message-ID: <CAK8P3a1Gt10_OLF1dXiNBxcO-seJfutcPu3w_dsHKNsDN4r7-A@mail.gmail.com>
Subject: Re: [PATCH] drm: panel: fix excessive stack usage in td028ttec1_prepare
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Oleksandr Natalenko <oleksandr@redhat.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:dCasvTqr/0B6fIPWDDv07jjjP7G6ye3zC6v+Tc2ix6iddvwfcM3
 U3kAGyXW4Kqyi8LjTQGAnxOOv/ob+qUs6QQdqXclHGao+X8ADxg01Un4OOPPL3Qaiu6cbBt
 a+0fXKQbbDAD2byC4oeu8QJPzBX6o1UrPsCAZIKjcUE7ekYu6PaNQTQgwAOsVF+4S6cpQpU
 Yt+O66Edr64pnc2SBgAPg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:UG+7dq4n3GE=:BrsJluNWGW2Fcaj3MHV2n3
 WbJlxi+DIrgQZgTPENeTCvS2sK8bXS51z02j4t/9oDkgtsDBYhPmjIix5BThc/gWXy4W9iUx/
 pmscCZBL9awP1+vbdLxyCKZOCUDvP2yPCZmGuWfJwNdZsnq6le1EP7o+dcHk/1A9f9dFcoErc
 M2ru1XSb4/H5CFql0TzqDGR8dBFEP7gguQ7cGs3Gi+WgK7slp2Au/tB3vwT99D5KTtkROKZ3W
 o7u9Eyu+0cpnrwWKGxLd0yyac4gMeRHUsy9AkmnCf8k4k950YZPmNOhPIM/nJV5DwVhhLM95S
 29Wc+MxKc+ZU2DE0f0YWwUDUzOWuUKvSn9GUP6ZxIKIn3gq035FhMEg2FMHW02GzZKgj73daG
 Nm8oUo9nGFsM8mBPGkQYPd2ogxuAjCHFns+yfXhAMSxp/bByasaYsv19trPwwazzlLFcnysw6
 v2VryoPHG57fF42sZzoBKKvajoUu/JTRCQ7Sll34KFrgqfCbKzFSwt+PYu9fZuBhUMUdMsJjr
 z6x7zrFjNZuw0woC5K+aLneZ42uce6AAsBHqx7vQXkHo42qomgHREb8n6EKi1e5s/sPu+1ApT
 s6iRdgipWdVPP3TO2vECKn9T9rWJOCnrq4WbfO35AoUasAQ1+bECWtUr4usuN6j/cmVSekoQ6
 PKSFIGXzhijdfpa9ko7oS6kVhj9yL4dX7SbUjDUi9RkNPq3py8rvWZ/niVk8hVxgC3RLTLIvs
 U2pqGBwxjAbQcCmGbQey7+ANWiRvN9iATyF80OEdbM9n31sv/eQj77GDB+ynYDNAQOc8JaFJn
 0xKVBUIufYqWhh5q8mmLvxYIxeQs2Qoa6oSCM2WwXrPj+93qwRLgwTOdWnWhS9E0pKxzJ4rWq
 anXSXIlH1eEqIVhxEJbw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 7, 2020 at 11:00 PM Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>
> Hi Arnd,
>
> Thank you for the patch.
>
> On Tue, Jan 07, 2020 at 10:27:33PM +0100, Arnd Bergmann wrote:
> > With gcc -O3, the compiler can inline very aggressively,
> > leading to rather large stack usage:
> >
> > drivers/gpu/drm/panel/panel-tpo-td028ttec1.c: In function 'td028ttec1_prepare':
> > drivers/gpu/drm/panel/panel-tpo-td028ttec1.c:233:1: error: the frame size of 2768 bytes is larger than 2048 bytes [-Werror=frame-larger-than=]
> >  }
> >
> > Marking jbt_reg_write_1() as noinline avoids the case where
> > multiple instances of this function get inlined into the same
> > stack frame and each one adds a copy of 'tx_buf'.
> >
> > Fixes: mmtom ("init/Kconfig: enable -O3 for all arches")
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>
> Isn't this something that should be fixed at the compiler level ?

I suspect but have not verified that structleak gcc plugin is partly at
fault here as well, it has caused similar problems elsewhere.

If you like I can try to dig deeper before that patch gets merged,
and explain more in the changelog or open a gcc bug if necessary.

      Arnd
