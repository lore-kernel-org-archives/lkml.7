Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E92A9C10F0B
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 02:36:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B972F2147A
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 02:36:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="izpEnhoR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726947AbfDCCg3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 22:36:29 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:34676 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726089AbfDCCg3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 22:36:29 -0400
Received: by mail-lj1-f194.google.com with SMTP id j89so13412398ljb.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2019 19:36:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XkQq/Hrmv0eGgt6shvKyYOCwWEYAJMOW7yeHRm4cO0g=;
        b=izpEnhoRs8bDqDQxMJCPbATuwpQ0PkaQVOxJjBfIbENbNlQc3qinI7+Vg05YP2hAn9
         mjwt+oSSDfXoj/FFgqbTb2IOKkwUHS6ISMFD0PNidrA4d2KDCSJT9hk/rSB6Du5H6NVV
         i13C+p1h9798Tlwi0EQUGekagMxGeQe0tJZrF4gcIJHWIoEcgowB9/aATgpJIQSJAjyy
         D1jxZB9L3RWgoKrPQTCOhWLSlaXDaJ1facbWugzpF9Ev2Vn7QJdySOA/VCuq9173dHQf
         RkbGLbqU8zLZA264idyHhJ1FeTlWZowNXSJGBm4lZrcfa7QGP7zS1MjES+I5MjHin0zc
         2MOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XkQq/Hrmv0eGgt6shvKyYOCwWEYAJMOW7yeHRm4cO0g=;
        b=BhRi24fJFX4GoeQZ1XrCizLjyH7Cs5kN1txxCE5XAj6wlDbgxLogS8BK0ZjFn8P6Fi
         qYY7JSpFtQfy0nuE17fR5Yj0/iNowKWcUC9mbwU/ncrds3JrTNmRtzG83In2NqW9ArK7
         NvxLPsy0obKf4ztW05gTPaHt5RDgByxw5TUdqk2LDVriCMQmENf14+cr8/npD9XVgK80
         TK7S8VT3+jxf4F36rDeFcPkGFC8ayqtzP9/onJyOjIX24L303foq7JSQzA8oiDjFw3Td
         bdc7zEhPF6L78ubrCRNvbhYm2poV8jZuwTT1AcsRNggSH3aYYcvJ2HxDuitrJFC4hmma
         Az+A==
X-Gm-Message-State: APjAAAU/TPMSFPQ2h3HvN9yez5TFcoZuioq/sL04891djj8i7MsRHiqb
        54JceSEs6h0Z8NgvLrQ44D8p5IrPBAxshIKn5aVZ8A==
X-Google-Smtp-Source: APXvYqy+QIJQKwbRMYyJuisphj2TP7E3HliPEBKjWAEnPVjR8rfZPGn00SuHeYS77wfFjR3A+uFzAwp8oZrcUCgpjtY=
X-Received: by 2002:a2e:4a1a:: with SMTP id x26mr4984809lja.49.1554258987313;
 Tue, 02 Apr 2019 19:36:27 -0700 (PDT)
MIME-Version: 1.0
References: <1552330521-4276-1-git-send-email-info@metux.net> <1552330521-4276-18-git-send-email-info@metux.net>
In-Reply-To: <1552330521-4276-18-git-send-email-info@metux.net>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 3 Apr 2019 09:36:16 +0700
Message-ID: <CACRpkdaV3psr6Xaj16LoeCuJDq-oXVY_rtrXQyKcYiwpBKS=0Q@mail.gmail.com>
Subject: Re: [PATCH 18/42] drivers: gpio: lpc18xx: use devm_platform_ioremap_resource()
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

> Use the new helper that wraps the calls to platform_get_resource()
> and devm_ioremap_resource() together.
>
> Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>

Patch applied.

Yours,
Linus Walleij
