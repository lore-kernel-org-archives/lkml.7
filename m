Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E114AC33C99
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 10:33:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADEEF207E0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 10:33:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bgo00NBN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727818AbgAGKdH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 05:33:07 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:46264 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726565AbgAGKdH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 05:33:07 -0500
Received: by mail-lj1-f196.google.com with SMTP id m26so51695928ljc.13
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jan 2020 02:33:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xC5eckw6LeHTQNvUicysdWSevFLO+gQO55vJ3inC8GY=;
        b=bgo00NBNQ7QeyKuZRI5207V4LPSEALLJbm+Qn8vuLgkKgv9K+TOeYbAKoo0prDns7G
         Jo+GtUnSf8YRyZD439tshC0l3HXLYNCzZaABHf4/caPDYRbEBVMGZxBbYdK8dkfJ3nVw
         VrP0iudXFKJQRttAp1ZGziwLfB7y0if/JUc6vRi01i5kcyNjW6GRIhwsU0ATWv6YooWL
         htma5HJh7LVrwR9jQnh/+I1KnCsSmRH310YNZ8sJSZX9C0nKa97voMLY9cwlEej0YtwC
         r7QkfHmPzfG4HBCqluj4LpxzlkZgrteCAf3zUUEDWFuw5wn0bQ+yld5e/FpGL/NUsdzH
         RBAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xC5eckw6LeHTQNvUicysdWSevFLO+gQO55vJ3inC8GY=;
        b=jCfvktpLmjRaK1Q3/Nd4HHOaxu1IxLTHiR8X0MOBuJCo1eyiQNQjuXqQlY2gIkgGvU
         LvEwuXPpNAiLBAOdJ6IL3sj/VDOHkCQwp78rSMor0ADt6vWj0+fqAnBMJOUitvbm+Z4w
         D0nVXysWbZvQjKd6a1zO6FrD3Rn+/3/OBkRPw09Glm/cbk88XrnjmDOpDG64ZyWtYcyF
         gqzmRjYURcga1eJkyP0iMs/k+pN0Okb0D9SHxdEQWBfkBUNum470hNbXEB8WU4eROtoh
         2Pkbcv1ssJcVjjdTHUyXp0ioP/46n1MLshRTdknMhOLLgBtCqR5Vj4UWEUepJJlePyHH
         JoAw==
X-Gm-Message-State: APjAAAXnwrqvEdr9aYP13w27k1NPraYJMoCzM01M5uy+Qh+fkxzCDkwH
        7NYxYrftFOTtwgUlB+TNtog9z9q+ppfUVE9vItD/Qg==
X-Google-Smtp-Source: APXvYqzCDMEvzHlBYQDhP4F32AbSocRmoqo2rsOS+sKUN52oJaPqCY7ScGRgE9GJ3dyK1pDScgA8Sz7BOyh2aT/z3qg=
X-Received: by 2002:a2e:b4f6:: with SMTP id s22mr64129889ljm.218.1578393185295;
 Tue, 07 Jan 2020 02:33:05 -0800 (PST)
MIME-Version: 1.0
References: <20191229013059.495767-1-linus.walleij@linaro.org> <20191230102021.GF2628@lahna.fi.intel.com>
In-Reply-To: <20191230102021.GF2628@lahna.fi.intel.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 7 Jan 2020 11:32:54 +0100
Message-ID: <CACRpkdZONfNCPwTn=Ou7LU=+fPjDXeGGN8jkCzgRLkK2stKeNw@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: intel: Pass irqchip when adding gpiochip
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mathias Nyman <mathias.nyman@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 30, 2019 at 11:20 AM Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
> On Sun, Dec 29, 2019 at 02:30:59AM +0100, Linus Walleij wrote:
> > We need to convert all old gpio irqchips to pass the irqchip
> > setup along when adding the gpio_chip. For more info see
> > drivers/gpio/TODO.
> >
> > Set up the pin ranges using the new callback.
>
> Maybe have this one split as a separate patch? Same what we do for
> Baytrail and Cherryview.

I'm afraid to do that since splitting the semantic ordering was
something that broke a lot of times already, I was under the
impression that doing the two things (moving to the callback
and adding along with the gpio_chip) at the same time was
the only way to preserve the semantic ordering.

But more than anything I want someone to test it ...

Yours,
Linus Walleij
