Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B7DCC43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 13:47:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AF1D20848
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 13:47:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Si6pVPGJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728480AbfCENrR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 08:47:17 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:41868 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727879AbfCENrQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 08:47:16 -0500
Received: by mail-pg1-f195.google.com with SMTP id k11so4695406pgb.8;
        Tue, 05 Mar 2019 05:47:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0MWAfL+9WMXncMjfR7wFgw9HvCk+Zg05OesirdqR/Q0=;
        b=Si6pVPGJfjyg9v8LnUQTEGOTQ//fn9kEbD5TCzKRd+iOgAQTUZf7OxAO+IpNuJLsww
         eCxsm3tt9JJW3pamXXxaqamwDQDnzYnfBVvnGxVw3Q2x+r/SFxm72CQSjGXzxZWPlDRf
         QZJrzj020kqOAnyQI7yGNR2E2tKFxzwWTeUo6hRYrELZgBTOk+rZS8WvhHWHFgdToQJV
         hJu24/gqEcyxVYYCTKckccIO/fKqf3pYFe+zIfMEcvogQExOjI7dOW6F8dkgJPtAI0+H
         xz/qbDFvfpeQ34tZVs4jBPhOk8FkA8lhfCzTzOLG5krr+Igz5u/39unnLqgBtNT+nuaN
         3TUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0MWAfL+9WMXncMjfR7wFgw9HvCk+Zg05OesirdqR/Q0=;
        b=L/AYmrqeLsqfbeoP0iT4fdkoHu0mJAaZws7scAB2RXCljXqfbcOfYVWK0Qach9A0ar
         abLYtRiBzc/53D/5QRSqqWpror3aF/OGwWQZ9HfhtoLU2jF+0Z4yPDKYn5FvyHeoVxg1
         lpj6T2IoB8oSFwV/cpZhDttiN+gLXrvUwtbTqnRqRwOuiqbTLv8b+hd4n5In4LKrdTZI
         3Mx8ExQsAq713woz1P/wMfy/qY2fNWDw9CN2Cz6v/PL9piQ9AmBYL/THHcm9n5f5JGH8
         ETr0cm85DAQrLvbmnZYUoOqcLASfBWfSwQ3M8vDQNL9d1YhXgXRQsBxCOHQuD0hVMQlH
         ixgQ==
X-Gm-Message-State: APjAAAXfk8Gv1zUCmAYDuDj+Jsf9bN7h5GN6JG4j8iNxdjor8PncNTPP
        0ZQ0/oGmNyMgafVpY/XIsNaVA8V0HmbHJG18aSM=
X-Google-Smtp-Source: APXvYqzuhjiQVG2xVUifhoEnx1ey+x/mWtZnuMyZIQVywMBRmAx0dncV3xPZ5/6VVVafhO5BYtoA3rAbn1GN+0VbK5M=
X-Received: by 2002:a62:5e41:: with SMTP id s62mr1914733pfb.232.1551793635970;
 Tue, 05 Mar 2019 05:47:15 -0800 (PST)
MIME-Version: 1.0
References: <20190304201930.1622839-1-arnd@arndb.de> <25276a71-2d50-0039-226c-3066a3767c0d@metux.net>
In-Reply-To: <25276a71-2d50-0039-226c-3066a3767c0d@metux.net>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 5 Mar 2019 15:47:05 +0200
Message-ID: <CAHp75Vf_H8_++QtwPhGAyjnPE1hriU-85_WnmP6PO6D8uM9H5g@mail.gmail.com>
Subject: Re: [PATCH 1/3] x86: apuv2: remove unused variable
To:     "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        "Enrico Weigelt, metux IT consult" <info@metux.net>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Linus Walleij <linusw@kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 5, 2019 at 2:04 AM Enrico Weigelt, metux IT consult
<lkml@metux.net> wrote:
>
> On 04.03.19 21:19, Arnd Bergmann wrote:
>
> > diff --git a/drivers/platform/x86/pcengines-apuv2.c b/drivers/platform/x86/pcengines-apuv2.c
> > index dcb084f6b892..c1ca931e1fab 100644
> > --- a/drivers/platform/x86/pcengines-apuv2.c
> > +++ b/drivers/platform/x86/pcengines-apuv2.c
> > @@ -208,7 +208,6 @@ static struct platform_device * __init apu_create_pdev(
> >
> >  static int __init apu_board_init(void)
> >  {
> > -     int rc;
> >       const struct dmi_system_id *id;
> >
> >       id = dmi_first_match(apu_gpio_dmi_table);
> >
>
> ACK.
>
> Reviewed-By: Enrico Weigelt, metux IT consult <info@metux.net>

Patches from here presumably should go to v5.1-rc1 or, if Linus would
do it, through his tree.

Linus, I'm fine with what Randy and Arnd sent for fixing this driver.

>
>
> thx
> --mtx
>
> --
> Enrico Weigelt, metux IT consult
> Free software and Linux embedded engineering
> info@metux.net -- +49-151-27565287



-- 
With Best Regards,
Andy Shevchenko
