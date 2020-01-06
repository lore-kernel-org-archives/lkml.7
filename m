Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D099BC33C8C
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 23:03:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A461F2075A
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 23:03:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AG+WKiRL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727190AbgAFXC7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 18:02:59 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:36670 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726721AbgAFXC6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 18:02:58 -0500
Received: by mail-lf1-f65.google.com with SMTP id n12so37500681lfe.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jan 2020 15:02:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=PoH3a6UFcev6hSnVLUpMXxu6G3cX+06NWDeSI46eOP4=;
        b=AG+WKiRLIfE4a3Ryt/xpjGAZPcaSQn4bMpbWlqsm88zytaALksIdw8OAY7rkkFI0/9
         oyY2v8tSO1j1bhxa9ioSRY2Gh0bmKOWJI2dHYpfdL2FzqskvARvVPm1VRp/HP598/MxQ
         P50damguECiqf30ejikCqgmTc661ItZy+O+JZ6T3mLJZVg5BH3mmyrkGgmYZA44hkyOE
         IS8ua41bXhtqrkt6enZELSJlgkb5sW7fsNVUK1VxIGL8pS7zoQqQ+D4eTVzWZYCfbsIK
         SlPqr1xQKaYWY1sAV9HVYIaIfGjlGbySTVvKLIy2O8lW9JYnlkUYohgwcbRid8lZHxbO
         5X9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=PoH3a6UFcev6hSnVLUpMXxu6G3cX+06NWDeSI46eOP4=;
        b=aAi8vPO/dYEJM7kHw+6AUiumI1Djl37X4rNc3rGdk7KRqPs/XCGDkXtUhWK3pvCC+S
         2cJVsJKarPRwCZylR6F1lTTZJplxC0tnshAMl1T+/53eF6ulQtSJtAzZ6kmTOF9kmrWT
         gExL44k2iH+/LF4PExG1kTELKpYJ7+uWeFvlASmGGxdubtqUz4OZUHPgb4k7A7Wkkv+d
         uIwuwq8Qm3ocvNPA9lCW+ZMVVeSxzFJmeRVgHHbdazp+IlQ0dQMIyeP2nfUiTOV3E+yI
         rYfguW5OcYxKiy/v5bod/yZTfvhSXkE/IxsvoVdtpOz6dV8K+iJVHiWfWoZegXJqjKR1
         m0nA==
X-Gm-Message-State: APjAAAW/hhMxwApOZFRTnJ5CkJ7bx4WbiEMRgNSMkaKaf1QGxbZA8aNN
        0LjnQzBT8Wquv4rgmbAUEKf6srLpbL8FQuosiUdhYw==
X-Google-Smtp-Source: APXvYqztDsiEMPzgq8tia4/g2GReO5Rdoxf4kFUrQqstmxXWTvU9bAoWL4HoosBo1RlFHnQrEHEus6Ink0jFQf9inoE=
X-Received: by 2002:ac2:5c4b:: with SMTP id s11mr57106508lfp.133.1578351776360;
 Mon, 06 Jan 2020 15:02:56 -0800 (PST)
MIME-Version: 1.0
References: <20200106015154.12040-1-digetx@gmail.com>
In-Reply-To: <20200106015154.12040-1-digetx@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 7 Jan 2020 00:02:45 +0100
Message-ID: <CACRpkdZK7hvqri9NwvWfiittb2+JKJCyutP6MfBZpThJD13CWw@mail.gmail.com>
Subject: Re: [PATCH v1] gpio: max77620: Add missing dependency on GPIOLIB_IRQCHIP
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-tegra@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 6, 2020 at 2:52 AM Dmitry Osipenko <digetx@gmail.com> wrote:

> Driver fails to compile in a minimized kernel's configuration because of
> the missing dependency on GPIOLIB_IRQCHIP.
>
>  error: =E2=80=98struct gpio_chip=E2=80=99 has no member named =E2=80=98i=
rq=E2=80=99
>    44 |   virq =3D irq_find_mapping(gpio->gpio_chip.irq.domain, offset);
>
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>

Patch applied for fixes, thanks!

Yours,
Linus Walleij
