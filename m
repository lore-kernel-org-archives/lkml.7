Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBDECC4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 08:54:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD98D20857
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 08:54:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nkvHpshG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729613AbfDBIyg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 04:54:36 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:42731 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729145AbfDBIyg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 04:54:36 -0400
Received: by mail-lj1-f194.google.com with SMTP id v22so6141535lje.9
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2019 01:54:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EcgRygwxJ6p3YumI3VfX53m7wDZg8Ls0PelR4RJThXg=;
        b=nkvHpshGbeLFj0DsNJWbcQSKDAE9kMyCZ7+t5yRXovS3IGMrEaKtG0yYDoliaShKIn
         PEvL1N07XDZIFzGHulZXuZ0o0017ikPvuOY3jXtAODqwyLUD4OklgoiHJbD7I+kgYg5c
         biPi8sOR6X21awYEjgBYBesTGJhKug0p7Pn9NoMnjG0JXE91tr2iQmAlGiijbq3gPuBr
         b6bmhPk1KX7L/8eNgxQp8ktEX+JanUtDid2vK4FTbJtUKmEks5i3OJfPcZRGqUtQJzk6
         E5sAeYBZo7xfIqxqiaAqOhbS61ZSyuSknICX1mO89BZFSJ+gt8lVQ32ZntneORNLjs/S
         ZFJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EcgRygwxJ6p3YumI3VfX53m7wDZg8Ls0PelR4RJThXg=;
        b=r59BBojGVhzPkObRovSjm9/nsQkEgMj9lIIjnU0xrrWByeMhvYGqwJtr8QSJ+VTYlx
         zhwf4xpAV1J3y99P4b646qnTsxz4OhG58IFcDiV5hFugsV2Qeg0k6htkOPaFJ+Z45QbN
         CF6SAdxfoMDji83f8eJAlssTFPGudL1wzvr2Nu5i8AEYqA4dd4r77r5JcrgM/bA960J0
         5LRPUidgJ5e4EjiLRHZ9QQFlbf8qrGLxdo7P3t7RQw4/lsnry2uTog/VwZiwTvuKWJNp
         uOVEgIlq9b3PgLxLfk32q83I8gyBxqtIS0fhkoAAYwwOASsC/U98Bi8uAMtM9x0+39N0
         y63g==
X-Gm-Message-State: APjAAAVRNXpykUJCqeo3zCLDhmM65yICy5XD6LZwgGuIBLywwf+hRqsI
        JMYbrWMYfuqD6rdMZfeDl6wHFeWnzIz/5vwSGk/LVQ==
X-Google-Smtp-Source: APXvYqzrMvRM4u96Qj2wgqZSpLaMpHo9pOhxXtzN0I80Lh29SQ0yBHKGWtcfsufgFC49MOM+OPB2ju49EnMD0HjXKUY=
X-Received: by 2002:a2e:5d94:: with SMTP id v20mr34732866lje.138.1554195274024;
 Tue, 02 Apr 2019 01:54:34 -0700 (PDT)
MIME-Version: 1.0
References: <1552330521-4276-1-git-send-email-info@metux.net> <1552330521-4276-3-git-send-email-info@metux.net>
In-Reply-To: <1552330521-4276-3-git-send-email-info@metux.net>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 2 Apr 2019 15:54:22 +0700
Message-ID: <CACRpkdaB2mLFStOrZu45VoP6V16JMZSPciMBaPZvz1e2nB7Qcg@mail.gmail.com>
Subject: Re: [PATCH 03/42] drivers: gpio: amdpt: drop unneeded deref of &pdev->dev
To:     "Enrico Weigelt, metux IT consult" <info@metux.net>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Andrew Jeffery <andrew@aj.id.au>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        Hoan Tran <hoan@os.amperecomputing.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linaro.org>,
        Lyra Zhang <zhang.lyra@gmail.com>,
        Keguang Zhang <keguang.zhang@gmail.com>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Jun Nie <jun.nie@linaro.org>, Shawn Guo <shawnguo@kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-mips@vger.kernel.org, linux-pwm@vger.kernel.org,
        Linux-OMAP <linux-omap@vger.kernel.org>,
        linux-tegra@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 12, 2019 at 1:55 AM Enrico Weigelt, metux IT consult
<info@metux.net> wrote:

> We already have the struct device* pointer in a local variable,
> so we can write this a bit shorter.
>
> Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>

Thierry seems to have spotted a bug in this patch so please
resend it fixed (I will apply some others though so no need to resend
all).

Yours,
Linus Walleij
