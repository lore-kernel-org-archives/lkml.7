Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2505BC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 09:21:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6B762184C
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 09:21:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SOei8pJn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728667AbfCOJVL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 05:21:11 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:45615 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728630AbfCOJVL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 05:21:11 -0400
Received: by mail-pg1-f196.google.com with SMTP id 125so6006624pgc.12;
        Fri, 15 Mar 2019 02:21:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vP7HZTMw3xRHh76+TCwb0U6+oiCWOhG2I8JYAfF4nA0=;
        b=SOei8pJnsaW43FbpvZduNG+4jWxkM7xcc7L+G98+cRCFjIs9+jRSv6NgYn12+/hcnO
         Nv5t6dQSp5S4qOnya8Nz+e6lxpCJDfklC+B7DBECUAFBwF1Zt9UDu6HEhrMEEM5ZgcDD
         fx0/o+dEGLX1N3SMoufM884L7yK8+sETv3q4SaLyA7GPLh18HLp+IawpViPHdWEyKbB3
         sMA67i4YV5on1gQlLeMPE5mNI5uWv2NjH4FzqFK/7Q4YwhqmtFJPMPcrKJ2Ecifri3cR
         Kh6ufQfpXmWTIHt6CLPFOcHpyhVU5u+0uazsZjxllUR7IitazXDo/3f2Wh7MZzFkmq7v
         xRTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vP7HZTMw3xRHh76+TCwb0U6+oiCWOhG2I8JYAfF4nA0=;
        b=g1MPwhAQqZpb+bLHXsjBWKkuxXwayiPoKMEOkSEUd/+yG4d7sNkGIvoyG7RqZZ/1o3
         q0DZiigyBKrbU3f+icXQ78pq0U1rSA2er4TMyMCTkdwIAhBA0hfQ0OqbJIWPf3Uz6D/Y
         G9YNYDu73iu5Fvrlpj0yqp+LlbmiVTT3wPq521fQ9t7PqhLi/Eo+Zi11xqbG8DU433J1
         /OJhXoHerMm2gqdnQ7tQoRPd1WNBSPH4a549y6DBVMVwelaq2MehwPfmfsLr4BLSYvJ1
         LbwD++OnoGwXsknj0bfwmj8p64d7lc5jdeKrtAgA9jxtb8tgPsS8OKmJsZcJ48415RxM
         c4tw==
X-Gm-Message-State: APjAAAU8YrvX1jOGb1AxKs2noCQoYVDZ2PyciRLsveqDbVMlKR+jiXP3
        J5OJW9s8WZhLOXv9oYfcE4Bs3whVJQdK+zPaB34=
X-Google-Smtp-Source: APXvYqz22UdJCSLKoxzdhZyS+ZKRgJLsXLsNZvh1TNAN2h3MOiCuU1bniKwYs5STgwn2sTImZFs0w9oRUeE9wLHRHUc=
X-Received: by 2002:a63:d442:: with SMTP id i2mr2427933pgj.246.1552641670454;
 Fri, 15 Mar 2019 02:21:10 -0700 (PDT)
MIME-Version: 1.0
References: <1552602855-26086-1-git-send-email-info@metux.net> <CAHp75VeH9isvFkp+AECgsN8du__8tBBp_4zZEVXJ083BdFweeg@mail.gmail.com>
In-Reply-To: <CAHp75VeH9isvFkp+AECgsN8du__8tBBp_4zZEVXJ083BdFweeg@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 15 Mar 2019 11:20:58 +0200
Message-ID: <CAHp75Vf+f-b+px__ekdDZPFHtmMwoBVw-itoTtxfELesfSciXg@mail.gmail.com>
Subject: Re: serial driver cleanups v2
To:     "Enrico Weigelt, metux IT consult" <info@metux.net>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Eric Anholt <eric@anholt.net>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Tobias Klauser <tklauser@distanz.ch>,
        Richard Genoud <richard.genoud@gmail.com>,
        macro@linux-mips.org,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>, slemieux.tyco@gmail.com,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>, baohua@kernel.org,
        Peter Korsgaard <jacmet@sunsite.dk>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org,
        "open list:LINUX FOR POWERPC PA SEMI PWRFICIENT" 
        <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 15, 2019 at 11:12 AM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Fri, Mar 15, 2019 at 12:40 AM Enrico Weigelt, metux IT consult
> <info@metux.net> wrote:
>
> > here's v2 of my serial cleanups queue - part I:
> >
> > essentially using helpers to code more compact and switching to
> > devm_*() functions for mmio management.
> >
> > Part II will be about moving the mmio range from mapbase and
> > mapsize (which are used quite inconsistently) to a struct resource
> > and using helpers for that. But this one isn't finished yet.
> > (if somebody likes to have a look at it, I can send it, too)
>
> Let's do that way you are preparing a branch somewhere and anounce
> here as an RFC, since this was neither tested nor correct.
> And selling point for many of them is not true: it doesn't make any
> difference in the size in code, but increases a time to run
> (devm_ioremap_resource() does more than plain devm_iomap() call).

And one more thing, perhaps you can run existing and / or contribute
to coccinelle since this all scriptable and maintainers can decide if
this or that coccinelle script is useful.

-- 
With Best Regards,
Andy Shevchenko
