Return-Path: <SRS0=nTU8=ZV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9A02C432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 08:26:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE5F9217BA
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 08:26:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="x2h/3aiI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726822AbfK2IZ7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Nov 2019 03:25:59 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:44605 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726763AbfK2IZ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Nov 2019 03:25:59 -0500
Received: by mail-lj1-f193.google.com with SMTP id c19so4021431lji.11
        for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2019 00:25:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rjwO1FwEHwaRe98ERPpJb4XhcKjr+G42GNFc2FaNjPY=;
        b=x2h/3aiIvlsEahqJZ/3btpCdFt4VmD5TTiD8V3r9A2XcxM+kI1n2O1vDNFBYlvTc4C
         w03cOACsyuypSasUEovKSkK/gGhjMthY2sd9WW6J6zzIDOjiv7jea8myB4sLc32X3Ku2
         3nMKKMhEsspzTb1EznV4qpbStmbAZAZLqa6q59CBYHkXtJLQjkZnU2cxccmLf6c4Fp2P
         6J4x1pyWdOvEQgZpQU1+NGwmCl00WWd0yeemqpqhQbgDhb8A1vjdMsCfCfE4Qlg6ZJV/
         +YGEUzgyDtGQYsg283APPSsnaZGLJfNBSW8zIJvjX+n2sWC1PAMmgDXuUOEMBB5l6J70
         WqFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rjwO1FwEHwaRe98ERPpJb4XhcKjr+G42GNFc2FaNjPY=;
        b=UvsBJwihDWmiX8pFvh9KmAWwPkISQjTe0pUoRnuPuD5f3z9cTGbdquHQfvfVNdnauk
         d8pzZZMqy0gszJZn7bb7NWu4SFNB2Yfo4raqtCwMCKOqHA8A5/eeMjIgnYEejS8CfiQI
         5QKbsoS3MON7oR2xXxCXGcOH9tN9tYMMFHZLFdYujv7bmplaJ3cTKI2YoEz4B60WBFI9
         TXl/4mcBNDCAcfHCLlBf1kAZ5u9VoW3MCqbAFjL6hRa8cGfbuWXae8JIjSXR78/n1xNc
         nmCuq4S2xvykddk1Z3Z6RYIzz1Xjxjk+aUffyWv6JSSorX0+n2WHC8rOdxg3Ujl+3PTO
         jVVg==
X-Gm-Message-State: APjAAAWlM8ZoBO7ccaTOKov/VR839TqYYyO9yxTsEgTAhu1W7pyJ37WX
        RyPAKlR2t6+t9yPfoaNqH36YwKxQyOMeqIP7HFUbsw==
X-Google-Smtp-Source: APXvYqxPEF84EN3dLF+KpgUma2Eg2Jv1hy3/PNjxMNx7d9TCfClYT8X1c071v7TmAfiER5FyEPDqCKtqjr2DW1EP2Ek=
X-Received: by 2002:a05:651c:102a:: with SMTP id w10mr7850453ljm.77.1575015956975;
 Fri, 29 Nov 2019 00:25:56 -0800 (PST)
MIME-Version: 1.0
References: <20191127135932.7223-1-m.felsch@pengutronix.de> <20191127135932.7223-6-m.felsch@pengutronix.de>
In-Reply-To: <20191127135932.7223-6-m.felsch@pengutronix.de>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 29 Nov 2019 09:25:45 +0100
Message-ID: <CACRpkdb9iXneW3BUj6RfODYnL7DwMwbGbPwXgQ4Z5YTj7MgGcw@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] regulator: da9062: add gpio based regulator
 dis-/enable support
To:     Marco Felsch <m.felsch@pengutronix.de>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Support Opensource <support.opensource@diasemi.com>,
        Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, stwiss.opensource@diasemi.com,
        Adam Thomson <Adam.Thomson.Opensource@diasemi.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 27, 2019 at 2:59 PM Marco Felsch <m.felsch@pengutronix.de> wrote:

> Each regulator can be enabeld/disabled by the internal pmic state
> machine or by a gpio input signal. Typically the OTP configures the
> regulators to be enabled/disabled on a specific sequence number which is
> most the time fine. Sometimes we need to reconfigure that due to a PCB
> bug. This patch adds the support to disable/enable the regulator based
> on a gpio input signal.
>
> Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>

Overall I think this is fine, it's a solid use case that need to be
supported.

> +       struct reg_field ena_gpi;

Maybe just add some doc comment to this struct member?

IIUC it is a general purpose input that can be configured
such that it will enable one of the DA9062 regulators when
asserted. (Correct?)

Yours,
Linus Walleij
