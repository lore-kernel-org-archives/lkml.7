Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 779EFC43215
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 13:33:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F48920708
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 13:33:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cbZJoAS5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726983AbfKUNdn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 08:33:43 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:41046 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726546AbfKUNdm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 08:33:42 -0500
Received: by mail-lf1-f66.google.com with SMTP id m30so808702lfp.8
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2019 05:33:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ayr33azDG5K9t44zml1H/6SXUfSnIkQYrJwinHZ+DQI=;
        b=cbZJoAS5ZqVSucEeAtCgt5yZO7IWmGGHSnXWJtFPmuBc39kv313TsQ/sEIYj4NyPVW
         OaY9krQY02fHpqzzz5DjKZiAa11IvUb+wJl3MVBHTx/va7MIxjStmRDRx5nUElgLimYr
         7WBB7DxVy8gmD11f3y5v6VkpmWY8KPxQHuqwjRAIXjI3lBlVxVByHPhrjdbNlEUmgRbz
         rPYtT0EkI3HE7GyNqOxZwdDcJsMKyzi81g/Rls9cOswmkVMmvRAzkRff4THU4tEhYjfo
         2yqZYbD2bjf2ZtJPNKh5EgmnHKanFKkr9bUQokew3IaaZo/B2ewbJVlVNhsjpe7IdCwV
         f8gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ayr33azDG5K9t44zml1H/6SXUfSnIkQYrJwinHZ+DQI=;
        b=hjPFgAjnywAkGrsWHYEGZARAPuR9+6R+CRKR3o1EsXvlKUanLLFcwGeV2SVFRlp1W4
         SfzHX/boMwcTg4YMf6Mb5Xw7OfCDm+n0am+yQq4il5J7dITx7SgKIebrjB1fUQ27XkTK
         5A4+nxAIoABmMv2xKGgZjzmERROxPSXgtG93uiFsxiHqjrFu8PuWBTB61CjjVT8Rt4Nm
         3uUN5WkhjxJ3oPAItXQzOzR6BmjWvxRy3Jt9etOh3gE1dYu2kgQ64xLx2wtB/amHspiw
         k/Lh4MSVHXZer2RuwVsnhytBMjzsy4jauCuHAk2nSry5hBWen15aB8h6NLRbA9NBOADT
         Z2mw==
X-Gm-Message-State: APjAAAXEiGCWvWOU/4W8FDDDtsq0aqEQrPZkDuhKM024W3UsEHQ4gMSQ
        4O/e8IcGs/bnJ8QlaLwde3z9m4NQq+eev35WgwVYEw==
X-Google-Smtp-Source: APXvYqxQmOfoYPWhSLur+b4vBiIPAiFkN7+KZSB9b9SkIWs/l2mTelhTrhoXZG7Et0WplhTcYmd7M9pJY1XsO/1qbzg=
X-Received: by 2002:ac2:4945:: with SMTP id o5mr7369327lfi.93.1574343220488;
 Thu, 21 Nov 2019 05:33:40 -0800 (PST)
MIME-Version: 1.0
References: <20191113071045.GA22110@localhost.localdomain>
In-Reply-To: <20191113071045.GA22110@localhost.localdomain>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 21 Nov 2019 14:33:28 +0100
Message-ID: <CACRpkdbDz6HSZZPFB4cHMO=C9WQ7O_UQJAgO_2zyALEYzEEVsA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] pinctrl: rza1: remove unnecessary static inline function
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 13, 2019 at 8:10 AM Matti Vaittinen
<matti.vaittinen@fi.rohmeurope.com> wrote:

> Having static inline oneliner does not benefit too mucg when it is
> only called from another oneliner function. Remove some of the
> 'onion'. This simplifies also the coming usage of the gpiolib
> defines. We can do conversion from chip bits to gpiolib direction
> defines as last step in the get_direction callback. Drivers can
> use chip specific values in driver internal functions and do
> conversion only once.
>
> Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>
> Changes since v1: Subject fixed as pointed out by Geert.

Patch applied.

Yours,
Linus Walleij
