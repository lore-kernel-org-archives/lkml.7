Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09060C43331
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 14:28:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE566222D0
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 14:28:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="g3xvfdpe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727741AbfKMO2U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 09:28:20 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:34942 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727392AbfKMO2T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 09:28:19 -0500
Received: by mail-lf1-f66.google.com with SMTP id i26so2149597lfl.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2019 06:28:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=t4Br6s5tJ4L1zVkGHFm9nI2kU0+XpkWE4+fr2OAuoLA=;
        b=g3xvfdpeL4WhflkdqvFIf0sp3bsmmDqyBmGTTvSd0WbexD/iYz/QRxWLCrSoV8uBm6
         MxLvUlgSwN9+pcc6arb/YCpcd2uIyR+LP0ImjhPQPHzrSSoxJEnV4Aqf3mMHORn7efd8
         UrObo3Znzj5KBNFJTLnTgqPX07wzEKj9Z/VdEHs8Qm76QF0/xsRRlJ5grWrXvnLGVQ8E
         urh4n2r5oDH2qPXJz5Ccr8xQGIB5Kn8+G63mxytvx4DCeNKqx3a5iH1NvfpeOsIa66Gq
         UnTdSdSsapDwtmVjlhpp9EcTB2wWYomumBMX2ckJuDb4IbG+LZXFJzIfCoNtbFSr3ngO
         Yb7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=t4Br6s5tJ4L1zVkGHFm9nI2kU0+XpkWE4+fr2OAuoLA=;
        b=SM6R8D8OteVMLaR+tZ+0d86V3SoaBrZwMiqu24zDyW+9DrJkx52UUrogSy9kSfQp8l
         YZUW0T47tgo75mwj3f/0HhLlYqPYyHLc2VcjBbqT1wWv6Joy8Y9cl0sy6+tzYHq7U/VK
         j20uUYYMm5yoH2iIpRQyj1wueYBM9C+SgzkNZJIRwOoW4JWX5D58sp4T3Z9QSYwEb+04
         H2BBpVysLHg+GPy8AE9q32mS7ueqZLqxJiTh73BS61jZc7lvNk4W0CB0lThPI1mpsH0T
         9UUtrv01G+0uL3Cc3NT6jsWkiONDq5ywv2lUF1O8XPqyVxHToKqNoSudZaewWt+oOkc3
         5VPg==
X-Gm-Message-State: APjAAAUxQXBTF2LFziASSKiqzCi1RmI6+OUkxtsVIaKz18aTXeI9yRV3
        NCm6pRIvoZPWf81hktzBxpGhq7QE84ckbyZQDcJoSQ==
X-Google-Smtp-Source: APXvYqy3NtMfniXtu2zud+Kl2BXXUcMjxJFOjULwGGbFTpijwYWIw97dIEANaBIleld3reEDnxzEZB6WWUWhGfFzOD4=
X-Received: by 2002:ac2:4a8f:: with SMTP id l15mr2916588lfp.5.1573655296620;
 Wed, 13 Nov 2019 06:28:16 -0800 (PST)
MIME-Version: 1.0
References: <20191108160900.3280960-1-thierry.reding@gmail.com>
In-Reply-To: <20191108160900.3280960-1-thierry.reding@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 13 Nov 2019 15:28:05 +0100
Message-ID: <CACRpkdZH1e856Rnoy_rwHuM2nyMDwCiXLvxOV2CJ0arXaTwj0Q@mail.gmail.com>
Subject: Re: [PATCH] mmc: mmc_spi: Use proper debounce time for CD GPIO
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>, Pavel Machek <pavel@denx.de>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 8, 2019 at 5:09 PM Thierry Reding <thierry.reding@gmail.com> wrote:

> From: Thierry Reding <treding@nvidia.com>
>
> According to the comment, board files used to specify 1 ms for the
> debounce time. gpiod_set_debounce() needs the debounce time to be
> specified in units of microseconds, so make sure to multiply the value
> by 1000.
>
> Note that, according to the git log, the board files actually did
> specify 1 us for bounce times, but that seems really low. Device tree
> bindings for this type of GPIO typically specify the debounce times in
> milliseconds, so setting this default value to 1 ms seems like it would
> be somewhat safer.
>
> Signed-off-by: Thierry Reding <treding@nvidia.com>

Makes perfect sense.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
