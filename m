Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03340C2D0B1
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 23:36:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFE12206DF
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 23:36:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dsT0KNTc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728428AbfLDXgU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 18:36:20 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:40759 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728060AbfLDXgU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 18:36:20 -0500
Received: by mail-lj1-f193.google.com with SMTP id s22so1290778ljs.7
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2019 15:36:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=siad11pyKMHN/ABbhrW0Mm1V+zj9RUyniY+RuR4S5Cg=;
        b=dsT0KNTcZjZq37qCkdG8G8XUtiZJ1U/V64DuhRwUynGLCIDQY2DO9xqdhes4l2QNcD
         zUMXoBxJMvc/job/mK2PhE1k6VVsuDTiu8z3ommkP0dXx/JSZHmsq9dY1t8Hqg+cRhxX
         KuVNKZgOiVFXEiO8gzTqJG3em55r2IyiZyEX7gvaQdbVK/YbskQcysj3tF1b2O8t0/ul
         2/BX3EYVmF9GDOMpo+1yVbqBtm9YtJPLl9sQqugN2loWlNj2kD+TivW05ei60IaP23rj
         HikyRsn8YnD7/XQMPUVWJuDAoGzmbZ0wIaIQxduRkVm42CDcQGm6FxJptDBk3blLcOaX
         V92w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=siad11pyKMHN/ABbhrW0Mm1V+zj9RUyniY+RuR4S5Cg=;
        b=I82jUjKNoupzGa9F0UuyCF4Y9R9X5tQARwm4DkwnE8lPsFh4O+R/0qO1vp94lvUNwf
         AivPIeMx04tzaYg32wETvQP6B00ECLfttszNM8T2JzQjsJcbfGXFX2/On7wE0grvXNGM
         DSUvuEedVwST7bpElVgqjxudlPYIpl+dkXD6OO3qYvE2lSh/OjgSzhupnHDGNgsug1qt
         f58diA8RQh8UiuLtPS1wTlQda+yWDoIOm50m3BblxICz6RKu7X+FCNQI1POG4i//irCT
         vb3tzFpl0aGdnjJLv88ULL2KonCC+39/4+VVvpRXns1wsm/bCAY1QQaZzxtzpAKiy+On
         +Hdg==
X-Gm-Message-State: APjAAAUAeZf1GjBU1AYtE9rJ+YZnN0EUMmdX9HYaqwvrNzSiq0lw+C4B
        LQegdYihm2dy/s7/kDtoBJkhcEmh7iYbbeytX0fl2ieifVI=
X-Google-Smtp-Source: APXvYqzJbFVzxD/hiEZAHCZIDwC/OWPE3gPtN3+jvcFCQfBmovI5uxd24DNWum0sE+nPjtG076fplETO6279Qumk+5Q=
X-Received: by 2002:a2e:b4f6:: with SMTP id s22mr3647014ljm.218.1575502578128;
 Wed, 04 Dec 2019 15:36:18 -0800 (PST)
MIME-Version: 1.0
References: <20191203155405.31404722@canb.auug.org.au> <1a78124d-bef9-46da-aef4-60f85fddfceb@infradead.org>
 <1c54235b-545c-db3e-4225-ec6824ac6003@linux.intel.com>
In-Reply-To: <1c54235b-545c-db3e-4225-ec6824ac6003@linux.intel.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 5 Dec 2019 00:36:06 +0100
Message-ID: <CACRpkdaNuQpaMe+FsQ6UeHMwP8f=1uCvG+kanhFauMRn_CrSCA@mail.gmail.com>
Subject: Re: linux-next: Tree for Dec 3 (pinctrl-equilibrium)
To:     "Tanwar, Rahul" <rahul.tanwar@linux.intel.com>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 4, 2019 at 10:36 AM Tanwar, Rahul
<rahul.tanwar@linux.intel.com> wrote:

> I have a patch that adds 'depends on OF' in the Kconfig to resolve this but i
> want to ensure that i recreate this error first & confirm resolution with the
> patch before posting it. Thanks.

That's gonna be a good patch anyway, so just send it :)
We should always depend on OF when we need it.

Yours,
Linus Walleij
