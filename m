Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D99E1C31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 08:56:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B273520866
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 08:56:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cdDvAZo+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437257AbfFLI4B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 04:56:01 -0400
Received: from mail-lf1-f45.google.com ([209.85.167.45]:45239 "EHLO
        mail-lf1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437164AbfFLI4A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 04:56:00 -0400
Received: by mail-lf1-f45.google.com with SMTP id u10so11428187lfm.12
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2019 01:55:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=S6dsc9hWBbsJ9ftcy5oIWdQeYlBaT7RnVpUbv8am+So=;
        b=cdDvAZo+BI/4z2Gjdm90L1glbL5oSJei4EYJuA9mTlDlpUK2J0mpDznfRk/DdmnreZ
         sGTgEGq/NrXG/+FkTauUqDUSnEfYnMgZW9F8eLlFFGI16rSZf6AyBxty18aDbh16Ercs
         baT9ohslEOYLTztWBQynYAIhVJpSIuR3gE+pXd9iCtV/D0B0HPxnhD6+icAER68vr9Wr
         p6j2SlRTsKlvkihYJAFHt79r+J2HCwn5OUAXH4tgUJxtYcIx8FFzR93yzPNLZUevLQW6
         YosMYudXrNcLxU9VhUWaWtbzmh3o+rDlHuT97QSK6/19hanulIx0ZAzcm/R672NpCOg8
         sEhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=S6dsc9hWBbsJ9ftcy5oIWdQeYlBaT7RnVpUbv8am+So=;
        b=hJmrL/0uOrErZ0MmYDIE7fWyFCAcoj10hYAAmAcWurCEQ+wLyjU5GH5NQCG1HGuExv
         i4m5/PKI1NZ4DrczOA/MRATIkcpNIcLiUdOE7rM2jBNnxOI3lpU9Mszb9QQAcQcufs3V
         hiRSoxXmE2PxwmUiiejg/5HpXudx3lQ4v7gukTt8JkrHWyf6iAtbywiIMYIF6ArKn7ZN
         Q6svWK9R+FBfEMPFp1hpS1vNveHXCRLG5ilkQYbZPqyFJ2kQOWx5tgczQquW18umP/U4
         VHgV4VBjiCslJkkpMVuEge6WNTPWW6DtvjFfgIj+1OEgWTPlPwKB2QYBo/X5Cb4EWTUR
         +pXg==
X-Gm-Message-State: APjAAAVgRb65NzA1i+VV40ud4Xs3Xhheo4ggGOfMmeL0e6tMnPsUmiLj
        +spNVL9NgZWHIOKDp93IyDJT67LnxMIaV3sN9U2bVw==
X-Google-Smtp-Source: APXvYqzPSx5XfdL5cdU82+TCxBTmCmwTndsIlHmjhMLF7KXn4u1Puk4//3L7dErprp1ZZvvjJHwNVyPpuMFsHUSjlJ4=
X-Received: by 2002:a19:7616:: with SMTP id c22mr36812571lff.115.1560329758321;
 Wed, 12 Jun 2019 01:55:58 -0700 (PDT)
MIME-Version: 1.0
References: <20190610171103.30903-1-grygorii.strashko@ti.com> <20190610171103.30903-16-grygorii.strashko@ti.com>
In-Reply-To: <20190610171103.30903-16-grygorii.strashko@ti.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 12 Jun 2019 10:55:46 +0200
Message-ID: <CACRpkdZQpG5eHdDUy4aRxr6vEgs0qZHRMXUkCfms_VBYwiQeXg@mail.gmail.com>
Subject: Re: [PATCH-next 15/20] gpio: gpio-omap: remove dataout variation in
 context handling
To:     Grygorii Strashko <grygorii.strashko@ti.com>
Cc:     Russell King <rmk@arm.linux.org.uk>,
        Tony Lindgren <tony@atomide.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Linux-OMAP <linux-omap@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Russell King <rmk+kernel@armlinux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 10, 2019 at 7:13 PM Grygorii Strashko
<grygorii.strashko@ti.com> wrote:

> From: Russell King <rmk+kernel@armlinux.org.uk>
>
> When a GPIO block has the set/clear dataout registers implemented, it
> also has the normal dataout register implemented. Reading this register
> reads the current GPIO output state, and writing it sets the GPIOs to
> the explicit state. This is the behaviour that we want when saving and
> restoring the context, so use the dataout register exclusively.
>
> Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>

Patch applied.

Yours,
Linus Walleij
