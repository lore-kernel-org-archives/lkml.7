Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16839C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 09:12:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFA4D218A5
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 09:12:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="okjVpbyl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728662AbfCOJMb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 05:12:31 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:42580 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727431AbfCOJMa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 05:12:30 -0400
Received: by mail-pg1-f196.google.com with SMTP id b2so5994110pgl.9;
        Fri, 15 Mar 2019 02:12:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TjtM6fVwWqEdIaS+4mof0Rz3Fnpu6pGIwmPSNX9Z0Hs=;
        b=okjVpbylXBvFVCgkvxV1qQmJLa4zjX+Ltn4hpXcPdxJgbI4G5M8CxOy7IUSJBTSaK1
         lxTdnqMoxPigmmFidAq79xK4vwU9t3E/R8inl0zU+u1AG/tT9Yr0/QzYVmYFIfglML2s
         dQxrMA99JHHiMsSodWcXcpVheixmZ0q1hXwJQUtCTcxuqMTGYnyJ0Mk0IrjBx9eupZdT
         HESaQGWDyHsvQPzIz3IxXh3xHFJpC+dtVICGacrmmGO3E97Nwsycj02hZpvWn5ApnqQY
         LwwbOQjSdBHZV1aRF81dZhRikWHqpOduNjsSVpgxAaD84jXKWXuyYmTF4Y6/9aVBgenP
         7lVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TjtM6fVwWqEdIaS+4mof0Rz3Fnpu6pGIwmPSNX9Z0Hs=;
        b=lywe0DsijrGiLSD9YUwaT5HDrdEh4Pooa6hpqQTdisLXpHSRV5WTTX/wioPj8XpD+Y
         B3NWriUS3a8QcnalWoFndS6KDpLtoHeeEKr4c8Z2Wo4pvw6Dcol39eBIQ31jdzRXCsat
         8GYn4SX1WkU3ivvjTwZyQmlKRlbW3TZYi7j63N8gayUEkeys7Lgh/VdKHLM9/LcDSCvB
         Z5F08rgyQbBWulroQZ3Hk/ic+aLaLn0mqF2mwVPkYjaiC4BN4pQcxfhUodLl1zrwyMQ2
         gC3ZQFzOJ8/pEf29Ks6bBdUG7hSj/uLR5sETF8kQGB9JDr4MbpvTuqpXc4WUIkLjict1
         CC8A==
X-Gm-Message-State: APjAAAWjS0SKuRcKtYpD9gSibh3ehChcQimdEUri/ONM0PQ1P4g0jlGA
        Jdo4Z75eVap/OawbEdH+OMorWXUr9jCOMYBKO68=
X-Google-Smtp-Source: APXvYqw4y5j6ogWahBv8cySNjqKMeUi5/6fyFYUM4L+/k48yar3AiX4XyVZiz3kwzFzdtM4+cPOsKYAEcr34phMbA2M=
X-Received: by 2002:a17:902:a9c8:: with SMTP id b8mr3156666plr.12.1552641149781;
 Fri, 15 Mar 2019 02:12:29 -0700 (PDT)
MIME-Version: 1.0
References: <1552602855-26086-1-git-send-email-info@metux.net>
In-Reply-To: <1552602855-26086-1-git-send-email-info@metux.net>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 15 Mar 2019 11:12:17 +0200
Message-ID: <CAHp75VeH9isvFkp+AECgsN8du__8tBBp_4zZEVXJ083BdFweeg@mail.gmail.com>
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

On Fri, Mar 15, 2019 at 12:40 AM Enrico Weigelt, metux IT consult
<info@metux.net> wrote:

> here's v2 of my serial cleanups queue - part I:
>
> essentially using helpers to code more compact and switching to
> devm_*() functions for mmio management.
>
> Part II will be about moving the mmio range from mapbase and
> mapsize (which are used quite inconsistently) to a struct resource
> and using helpers for that. But this one isn't finished yet.
> (if somebody likes to have a look at it, I can send it, too)

Let's do that way you are preparing a branch somewhere and anounce
here as an RFC, since this was neither tested nor correct.
And selling point for many of them is not true: it doesn't make any
difference in the size in code, but increases a time to run
(devm_ioremap_resource() does more than plain devm_iomap() call).

-- 
With Best Regards,
Andy Shevchenko
