Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB0C2C7618B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 11:18:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 731FD2190F
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 11:18:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="k7wwSlLr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727483AbfGXLS1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 07:18:27 -0400
Received: from mout.web.de ([212.227.15.3]:37223 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726070AbfGXLS0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 07:18:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1563967064;
        bh=SsNI5tmVo7N3wZC/sePrJbc8RodzxSrTUghETIx26Jg=;
        h=X-UI-Sender-Class:Cc:References:Subject:From:To:Date:In-Reply-To;
        b=k7wwSlLrZIQ1Y6GT5gSHPcLGClty9BhPHyKXQTShW0C7EiuaC2fIhM4d+nk8OPZle
         P8wOHiAgsaZe0DwibUP7s+rVIc3oOIeGSYMfu7OB1C9AKoGeY823PaBgRc1AwUEXas
         rr28LNTTJXi44W/fxJgZZzt/pWO7BtbQWPKxmYsg=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.133.51.56]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MRiZt-1hx99d0vMn-00SsFL; Wed, 24
 Jul 2019 13:17:44 +0200
Cc:     linux-kernel@vger.kernel.org, Andrzej Hajda <a.hajda@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Julia Lawall <Julia.Lawall@lip6.fr>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Mark Brown <broonie@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Rob Herring <robh@kernel.org>,
        Russell King <linux@armlinux.org.uk>
References: <5d3788cf.1c69fb81.44f27.5907@mx.google.com>
Subject: Re: [v4 2/3] treewide: Remove dev_err() usage after
 platform_get_irq()
From:   Markus Elfring <Markus.Elfring@web.de>
Openpgp: preference=signencrypt
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
To:     Stephen Boyd <swboyd@chromium.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        cocci@systeme.lip6.fr, kernel-janitors@vger.kernel.org
Message-ID: <a69aeff9-338c-a763-3a25-3ff767e5401d@web.de>
Date:   Wed, 24 Jul 2019 13:17:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <5d3788cf.1c69fb81.44f27.5907@mx.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
X-Provags-ID: V03:K1:aXiqUYly+c/GU8T3Pl/fxwP3g5OJeD4hs4TT2qggjuZxAtJfRr9
 Zgtarybvlpk1hf7Oq53wK/hNF0fumbBe6L8a1S25mt9uVZB4JsdVGB11fVma9RKDheMqGUX
 IO3/kTDHjLYlMDxtnMO+0Y5+M/CBCKnzSanDc+TCd8h5h4kSpFck9Zp0ko/f6lfm7GSOvsg
 eY2l06UgibKhMndQscbSQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:bDZBNbXBObQ=:yytbZroNvm1OibfAJylpQb
 p4qqBiQ1rrqQIFGqU32UWjg41rRRjGi6x0AeR4Hj92lHRvFQNc0oZyjFar3aFcdlwQJct1OSQ
 mIjpfLOALmx4rJTDOq3mGr/eWbsgEA9MNoQNCJ8E3EjbUP7HMoEbHp4Bl14drPskLOHmDsMHt
 /ZdDgMW5w04ECbkTcftvHWR5JYM4LZ8zVzntonVF3mJFvy+3J4h6e55Alw7gfkLfVj3mUupA2
 zNZHWIAWkhKG4tSSH4E8DNFDAZRvAoj17HiRESW9dtIdOzuKbdoL3KDn66nPGWh+EXiiQ/QVx
 gHJhPwmHRnL2XCvElD5WVFQl4/svSNVt5MkiNdaTRlU1A06wE/D7LL0Zwk/ZGJ4vzqkjSHBLk
 ZBacfsAkejynMztCncKYkwiSSzHpieSRkGqAeTH1bQYzHH+ToT0T1pFfLx1BJ+rw1gfcIDVIV
 h6aaYq/sUNq2UZUDS2YU5S1VP/Q1RmfJ8wah9BhZhstamOroHA7iWr77JEvdMU3vcg1yYdc7j
 Xze3A30lq+yAxbEFa48ULZGpUhe8wG6bxjXasEMXnD/xtLBMCiyh1Aj7LTFlogawrqAa8tN/A
 C4Q0R3iZeAYS+7yO6kIUIOHBgisDIX2/nzUM4rY4jiY+pkdT5dQTcyIdt7Ej9EptcwgyZGymd
 mnzRHWzvId1RaCutRfIM44L1gl272NIHC8OSZQ08lQi+l0tUnqpwarXynXpHFtO+DV2kfPdIw
 RK2Tr0lZJaW6rSFOhmXFyKYKe7PAGS01RxBijnyL1sMeRQxkORdQaRybtf/TiuwtX6rrtEMSH
 1pWK6q+lcFy2qIgzesYIvMvHPaWGBinL9uMVbo3feWXtrk0YMlUtmjWWQ2hVMnL/7yApYcgIj
 6SolO1/5+9kRKIvZKMJEAihNhz78kDVJpXdkhHjPqKljlzWuJs9aPVsIKt6mvX0lqEvBnhGA2
 UtJ4K+6vVgBbRdogRYa7VV8ivJv7v+1vmtm62L1ZY4F7rMl/fBhX9nUfv5mRUyTtAN9mM3fbS
 CV687j+jfGvDnllbU0o3MXA6JjgJz82LQ9ZYjn30TnoZ52AKxZI77MKgmdYARuARQWwq/mP64
 rK4yC8QVeRBSuORVGhwZkLGnQiBE8iBSr7e
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > > struct platform_device *E;

How much does this specification matter for the parameters
of the mentioned functions (in the SmPL script)?
Will the selection of function names be sufficient for the discussed
source code search pattern?


> > Can you teach it to remove curly braces when it's appropriate?
> > (see below for examples)
>
> I don't know if that works.

Such an adjustment depends on additional development efforts.


> Is there some sort of tidy script I can run on my patches to do this?

You can add corresponding case distinctions to your transformation approach
for the semantic patch language (on demand), can't you?

Regards,
Markus
