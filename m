Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B07FBC4CED1
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 10:08:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88C30222C2
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 10:08:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gf3o9QQz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728443AbfJCKIB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 06:08:01 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:46255 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728322AbfJCKIA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 06:08:00 -0400
Received: by mail-lf1-f65.google.com with SMTP id t8so1315676lfc.13
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2019 03:07:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nmO5LewwZMDCTVOD0m15OckoerRE+gUTRMroTOX/gqo=;
        b=gf3o9QQz6iDTw3YQocwe8vhOvyg22r7qX4I6Go6YaU6sfYojooOKFGZulEcQbINamB
         d09t0LMLCLdvvihAQUuLFVM6AlQp8aIeCGo2Goned7xpOBE8167CN/dJBvQrJyCopHLR
         svAHOdKCY/aMS6WbYH7tUnXuNr9CSZn76BcIDCpASblMZGECxaOS/aMvQHRU/OeFjAAf
         UVCw3tZBKeeIov6JX8pEfsEY/r1U3v5HARQlq9mSanj+zeUEg+KaPwPlA+G/tYvS4gaZ
         LyLIcYaOtghkrd9if2Qu1EWmuwQVrv05MclDX5bSE/8PDjetpbaVoZoTmD57+U6SFJ2Z
         pOQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nmO5LewwZMDCTVOD0m15OckoerRE+gUTRMroTOX/gqo=;
        b=kJ/Ck1I0RQSZflr8bkPTTfFPZkT1MlukbwbLLRzXIKD88WJsokLalcbZ25dfgRJtr1
         Ax1imqwvVl/AsOtyi857Ymr5XTM4HT2RYmy02j2xtq85g/825hfzrnckworSxObgF12w
         SRLixyqmLP8afX9/4EUcxIIBPJ+6wLivC3wwHUB71PxLt6gzN7/7xXT4D8NZuWQCBvXD
         Zc9UYA0MMEHBB18nvo3A8EkbCGmZp8Y+vMj3LLVsddhylQzPhbBxDa+SKxuDi8Ht55Km
         jy/JpaqiGyFEWZ9DUbtSqVa30Eiy5OZQ//iftEvqjxib0Fpj7HBuaqObUqodHXYFZtCn
         KviQ==
X-Gm-Message-State: APjAAAVy5j83nFeIam7DiT5X21YYPYpzd98PJXHr7kDPsrNQcRVhvtd6
        QxtYZP6yQuR4anB7b6IhRVw6dEIhkTs8EgcIdigbQg==
X-Google-Smtp-Source: APXvYqwwmJjII1kUj2MYah652uOLrdJkosOBlPtvXXYt0w53ra4TlkBfoNY0QC9+kb+7mt6Q9vwEWeWrUDwq3eelZwE=
X-Received: by 2002:a05:6512:419:: with SMTP id u25mr5078743lfk.165.1570097278622;
 Thu, 03 Oct 2019 03:07:58 -0700 (PDT)
MIME-Version: 1.0
References: <20190913032240.50333-1-dmitry.torokhov@gmail.com>
In-Reply-To: <20190913032240.50333-1-dmitry.torokhov@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 3 Oct 2019 12:07:47 +0200
Message-ID: <CACRpkdYm=qK7x0cLg3HjPmGYhZ076cDN1Kvd774p6g0UEg9C7w@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] Add support for software nodes to gpiolib
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 13, 2019 at 5:22 AM Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:

> This is a part of the larger series previously posted at
>
> https://lore.kernel.org/linux-gpio/20190911075215.78047-1-dmitry.torokhov@gmail.com
>
> that was rebased on top of linux-gpio devel branch.
>
> Changes in v2:
> - switched export to be EXPORT_SYMBOL_GPL to match the new export
>   markings for the rest of GPIO devres functions
> - rebased on top of Linus W devel branch
> - added Andy's Reviewed-by

I failed to get this into v5.4 because of misc stress, sorry :(

I have queued it on an immutable branch:
https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-gpio.git/log/?h=ib-fwnode-gpiod-get-index
then pulled that into my devel branch for v5.5.

So you can ask subsystem maintainers to pull this in to do conversions.

Apologies for the inconvenience.

Yours,
Linus Walleij
