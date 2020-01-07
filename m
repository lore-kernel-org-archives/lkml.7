Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFEC7C282DD
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 22:26:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96E2B20715
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 22:26:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727437AbgAGW0x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 17:26:53 -0500
Received: from mout.kundenserver.de ([217.72.192.75]:48165 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727183AbgAGW0x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 17:26:53 -0500
Received: from mail-qk1-f169.google.com ([209.85.222.169]) by
 mrelayeu.kundenserver.de (mreue109 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1Ma1wY-1j9yEZ48tY-00VwoW for <linux-kernel@vger.kernel.org>; Tue, 07 Jan
 2020 23:26:52 +0100
Received: by mail-qk1-f169.google.com with SMTP id j9so971782qkk.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jan 2020 14:26:51 -0800 (PST)
X-Gm-Message-State: APjAAAVmU6N2OcHBKgKoO/qeqkduVlrgWfzvDgcZmgWxGHt+mNJzw8mx
        x2HZIzbNEv+HLnsjycEmg2tGsi6KW+L/sSF0Hx4=
X-Google-Smtp-Source: APXvYqwG1LARCdNIKMhTJaBhIBGBLfcCf2DMbWm1oGmzF4texL29S6PXyRbn/Bq49xuTuLPfyx5ZUFoZ7cDXliTBdLk=
X-Received: by 2002:a37:84a:: with SMTP id 71mr1543490qki.138.1578436010905;
 Tue, 07 Jan 2020 14:26:50 -0800 (PST)
MIME-Version: 1.0
References: <20200107212747.4182515-1-arnd@arndb.de> <20200107220019.GC7869@pendragon.ideasonboard.com>
 <CAK8P3a1Gt10_OLF1dXiNBxcO-seJfutcPu3w_dsHKNsDN4r7-A@mail.gmail.com> <20200107221222.GE7869@pendragon.ideasonboard.com>
In-Reply-To: <20200107221222.GE7869@pendragon.ideasonboard.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 7 Jan 2020 23:26:34 +0100
X-Gmail-Original-Message-ID: <CAK8P3a0ny0UhOpvVNE3x6gE=3SG7h_sBvtR7L7Hj2XsjrkavAA@mail.gmail.com>
Message-ID: <CAK8P3a0ny0UhOpvVNE3x6gE=3SG7h_sBvtR7L7Hj2XsjrkavAA@mail.gmail.com>
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
X-Provags-ID: V03:K1:u6/beJz7TR6r0QjR0vl02vCMk13wj0ZyfnwIHL7j3P1KqZQ79AT
 yNPk9vm930p7cC1ZzANAW5s1hHFuVKP7bYHBAlx9vwVqGBFAc/cCytdTkb3V0TuEaOctcJA
 NztDqF9lhRw+kx95H443koakYFGJ52IzR4gdHWtrvB6siIlksuj+JFygWgK+XJpK7XOMpB3
 oC2zNhl3kbqI7LiSKC5lA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:mzMZv78yU4M=:Ilsriw39ANpoNbCkxRAfF1
 Wtjl/cqG8niW2KQctjbpxCJGRnKcSQhJTWNQLt9Dvfsm4tw57LrD9sYGkDaRBdjvRj9P3LwLC
 BnC0t3lIKZtjOhbkHc/rmu25SYg5QKZYFz8SHoWHD7LORGYB+WThs+ZBYpdCq/JpeuX3mFNrf
 r4PCgbUK5MegoLiAS+ikVFsSeysUgAm6hL4fiQpV24af88Yj0Q3gl+/UAmUY7SwhjE44zCpWY
 wn6SJJSyGaubmQBdbGYfnLJt8hSimgByh22R7EcqyhK1+bQMLwBU8gwGrRYlwkV9T7UL3h1/L
 cMdhDjje/FEHFWe9DEmTfC+E2B91NYwo93i9gOBsz615LjYwcWCtNof50T4CofiG8OLVV8voE
 lMZ4Z4k8i39QB7lopfR4ROKC5T6OaL1tapQLXVCf10l/SsmAh18e6hoe/mcI5SqmpavS//YxG
 xI7w+WQ8WOsYA27j16rUQhNE1QZmfVQeqgwfdRilFFhguCTIvHnpQtSNk0NxdObtBz9nFa9Sp
 dPFLSrM1usCURSiXa6ubT/APUsRg2T3HKz5xCcUK9jcnH/+X32qQhMGecmy8mvDv/H6MdswTL
 zn2bl0xqjLxkzxDBqNGpwLDu2ZdHgOhW+zfI/ecjcJzTmK1ZDVkZGNVzcXO5l3B3bB2aJspQB
 AXmQq5Hr6wsktMS9vuq28llNY7hPixjp7EN/qDIC5//a4uojSdF6SX6JvuAQ9HS68Ty+Li0i2
 og2x5tsD8Onr6e0fvUh//Flb/U27wJdm/iVU5uNOGMJlW3XndcU9BlUdPx2TO09a6L2TvcF1A
 uZGUSGM6j4GGkLpFyXm+xU6YrxJorFTo3tMhliEC8LByKKukmKU0qqpZuu9PZO/c07ZJH2mr5
 RScADPJX2VRJ/xnK/EkA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 7, 2020 at 11:12 PM Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
> On Tue, Jan 07, 2020 at 11:09:13PM +0100, Arnd Bergmann wrote:
> > On Tue, Jan 7, 2020 at 11:00 PM Laurent Pinchart wrote:

> > > Isn't this something that should be fixed at the compiler level ?
> >
> > I suspect but have not verified that structleak gcc plugin is partly at
> > fault here as well, it has caused similar problems elsewhere.

I checked that now, and it's indeed the structleak plugin.

Interestingly the problem goes away without the -fconserve-stack
option, which is meant to reduce the stack usage bug has the
opposite effect here (!).

I'll do some more tests tomorrow.

> > If you like I can try to dig deeper before that patch gets merged,
> > and explain more in the changelog or open a gcc bug if necessary.
>
> I think we'll need to merge this in the meantime, but if gcc is able to
> detect too large frame sizes, I think it should have the ability to take
> a frame size limit into account when optimizing. I haven't checked if
> this is already possible and just not honoured here (possibly due to a
> bug) or if the feature is entirely missing. In any case we'll likely
> have to live with this compiler issue for quite some time.

When talking to gcc developers about other files that use excessive
amounts of stack space, it was pointed out to me that this is a
fundamentally hard problem to solve in general: what usually happens
is that one optimization step uses a heuristic for inlining, but the
register allocator much later runs out of registers and spills them to
the stack at a point when it's too late to undo the earlier optimizations.

        Arnd
