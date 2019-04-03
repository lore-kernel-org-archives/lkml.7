Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9326C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 03:55:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F7F320882
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 03:55:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="L1woiTDu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728211AbfDCDzI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 23:55:08 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:34584 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726766AbfDCDzH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 23:55:07 -0400
Received: by mail-lf1-f66.google.com with SMTP id y18so10596928lfe.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2019 20:55:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3WT5Rdn7B2I8mwHTOIJSabuf0BiIIvc0b13OxkuNwhM=;
        b=L1woiTDuO+XuU9uAEhcLUJVwGcHNVeNAThUH9QDtfeLxHL9l3Z7qpb9c+Zvrwt3/cn
         yMz4YBfDSIEmOfiTlzTSa54x/KCQ8/bLvqje6H9GJWNUSSwjv0SkaDRUYe31lvhyyXpL
         +kpUV62y6huzj3v35EGmev18x4Z7l2EPjmEBYxTc1hgsVKUJIl8ltEJ2GNnuRH4IGO4S
         CSdPJfwG59dh1rRPhSfJNf6E0kiGiGzkY+HmYgh9VSwkLzovMraQ7+bxaeQYqqAMcl1p
         raHhDT1cbgOUiTnt6WUEQbibk6OhaqoPR0pi34YfSH51t0sOXVWmHofQ+/I9qk3bRuYH
         f5OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3WT5Rdn7B2I8mwHTOIJSabuf0BiIIvc0b13OxkuNwhM=;
        b=hNyzrsnpOBdPfWfV37Z6iMVjgHbRuOzi1+bD58krOtzHPQadMoSLg9QtESbRCsJ72G
         EoFTgvyWJZ3aZy79a9gYWCXXE73/sNm6O0r7QMEWVQRIVEDZUW345o017L28vHP9CFQb
         WXAim3yc01VT2Wq7oNg+llAXhiGJCBZOPWTxO6bO0sJgSH7Tbc3H9oEBsTUx7aRKdeC9
         6wd6rvlaB9SQNY9xMX+hxwSTSLAT2mAhDy2lUPP6XzS3/ByFmMeHRpmzgr9L9gFUQyb/
         wq16prn5V0dM7r3dRkZONIfsh/Mfz423U+1z4SDWUZpiNsesQfrTpS2wcbgyiDDNYiop
         +2GA==
X-Gm-Message-State: APjAAAVT+b+u3BJqwFaZhoQL68DlciLHkCnHY2Ysm4c/9pH8XCMi8yh5
        Ev2aVuBtXsEQ8p+SpIG2Y3+KTKRoafz0gZMZnF0x6Q==
X-Google-Smtp-Source: APXvYqxWpI4BsMuMKPnXoOc8h357I5LzDG4UhGupkQrGbJO0KjNt6+BgxthytA7i0ad9bv+tGSHEY1s3hXG0xi1226s=
X-Received: by 2002:ac2:485a:: with SMTP id 26mr37573324lfy.128.1554263705575;
 Tue, 02 Apr 2019 20:55:05 -0700 (PDT)
MIME-Version: 1.0
References: <1552330521-4276-1-git-send-email-info@metux.net> <1552330521-4276-41-git-send-email-info@metux.net>
In-Reply-To: <1552330521-4276-41-git-send-email-info@metux.net>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 3 Apr 2019 10:54:54 +0700
Message-ID: <CACRpkdYuNqj+SKMs_OWFF6pzj-uk62nNnhFHAgmUVp1gmiWZhA@mail.gmail.com>
Subject: Re: [PATCH 41/42] drivers: gpio: xlp: devm_platform_ioremap_resource()
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

On Tue, Mar 12, 2019 at 1:56 AM Enrico Weigelt, metux IT consult
<info@metux.net> wrote:

> Use the new helper that wraps the calls to platform_get_resource()
> and devm_ioremap_resource() together.
>
> Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>

Patch applied.

Yours,
Linus Walleij
