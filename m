Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22B4CC31E40
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 06:48:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9F0020665
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 06:48:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jINIfs69"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731962AbfHFGs1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 02:48:27 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:46928 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731711AbfHFGs1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 02:48:27 -0400
Received: by mail-pl1-f195.google.com with SMTP id c2so37425231plz.13;
        Mon, 05 Aug 2019 23:48:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ciRJtLw+Bjbci4O6KTclPqIilJPIG43FdO1fNnGJOoU=;
        b=jINIfs69W6dnXIXV7+SqlcFKEklH3TqFcZNVbtkhYakSre4TI66PN//H8ERwiqji8s
         kK6SQCqmeAb7QN3rlhBouQhH1Ue/QYSvxdI9FpW4NHXxGtm0/3EQwkEHtk3yHZyDBtUk
         c+zyTUqcWf0zZILxgIqEshekTR4gNDlNFPzZei/g0w6pQCVfI+1s7DisFG7u7WrsykhC
         DFvqq6aQIt5Bedb/FzkgdiLaADH8KfmNZwUmdE2n1bmgUeqRB+IjPVMhi8uMGEmUagpv
         UB3u/VUSNhDTq0qxGpFTcaQDmBpgXnP5wqJkLan7ySjkFBGYTsGtBgPH432Jg9i4Lja2
         ErIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ciRJtLw+Bjbci4O6KTclPqIilJPIG43FdO1fNnGJOoU=;
        b=d2deLIPz6ZLHwl62ohWXPxo1vQrBQ2rJL6Q8/r6TxrbzHEfajzVnHH5thxeHRFc5Ue
         ZUExiIMjdDvmu3kYTnEbhVooLvxL7LORKhWofMX8grGOD1SlzrajXfEcwpKdsfNYHPS1
         47fwv8G8xuVDMBsWTzgrZoI6WVhzcp6yGKH9dJ0RjOTmI5WU6mQe333Tg4cD/Wht6MXF
         1G/WjQyQkb275fLB8RZHUe16prOy8RzAhGFEQmR6V6WAC6DIc8z1TfgFaQOQkGcgwGH5
         cYFQkvdedWIPVbYO2JXNe46H7RPqys6h7Xq8s7vHfxXf+7VYfF3ny9qFv5uRPmTr9TKf
         FmEg==
X-Gm-Message-State: APjAAAUkI9uR8dndLs9hnx7qMKN400Io9FXYGmM09UfO78tMu2piirwd
        s7Ck7hWlfZUo/gt8hzZaIYiEO0uusDekJ7T3xO02nlL5FG8=
X-Google-Smtp-Source: APXvYqxuWVwuRi3/FmOf7wefV59pVi5N88LF6aeEeDv0xwe6LIwetirSZQ370JTeG/19nksLzyacyKcXGqveoi7eahs=
X-Received: by 2002:a17:902:934a:: with SMTP id g10mr1705152plp.18.1565074106673;
 Mon, 05 Aug 2019 23:48:26 -0700 (PDT)
MIME-Version: 1.0
References: <20190805193243.18584-1-andrew.smirnov@gmail.com>
In-Reply-To: <20190805193243.18584-1-andrew.smirnov@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 6 Aug 2019 09:48:15 +0300
Message-ID: <CAHp75VcjUwUj-6r+k2bTFhhr9hk942-ZEu=GhvhKNjfgEYf1Qw@mail.gmail.com>
Subject: Re: [PATCH] tty: serial: Introduce uart_tx_stoppped_or_empty()
To:     Andrey Smirnov <andrew.smirnov@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, Chris Healy <cphealy@gmail.com>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 5, 2019 at 10:36 PM Andrey Smirnov <andrew.smirnov@gmail.com> wrote:
>
> The vast majority of the serial drivers check for
>
>     uart_tx_stopped(&p->port) || uart_circ_empty(xmit)
>
> condition one or more times. Create a dedicated helper function and
> convert drivers to use it.

Sometimes the arguments are swapped. It means that in case of first
being false the second is aslo going to be checked.
So, does ordering have any side effect?

Please, elaborate this in the commit message.

>  drivers/tty/serial/8250/8250_dma.c          |  2 +-
>  drivers/tty/serial/8250/8250_omap.c         |  7 +++----
>  drivers/tty/serial/sc16is7xx.c              |  2 +-

For the drivers I care about (see above) I prefer to see conversion on
per driver basis. Of course, if Greg is okay with the current, I won't
object.

> -               if (uart_tx_stopped(&up->port) ||
> -                   uart_circ_empty(&up->port.state->xmit)) {
> +               if (uart_tx_stopped_or_empty(&up->port)) {

Yes, it becomes one line, but...

> -       if (!(dmacr & UART011_TXDMAE) || uart_tx_stopped(&uap->port) ||
> -           uart_circ_empty(&uap->port.state->xmit)) {
> +       if (!(dmacr & UART011_TXDMAE) ||
> +           uart_tx_stopped_or_empty(&uap->port)) {

...wouldn't be the case here as well? And perhaps in other places?

-- 
With Best Regards,
Andy Shevchenko
