Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89521C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 09:02:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 595532075E
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 09:02:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qXgeu4SR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729792AbfDBJCh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 05:02:37 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:38634 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729625AbfDBJCh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 05:02:37 -0400
Received: by mail-lf1-f66.google.com with SMTP id a6so8408777lfl.5
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2019 02:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XkQq/Hrmv0eGgt6shvKyYOCwWEYAJMOW7yeHRm4cO0g=;
        b=qXgeu4SR3w2KMphxlxSdhsDiCsgDnxD8N7dEJRxNMY1KCEZn+a24Km51Chafa8rc7R
         8vt3OsZ/4crIpd2UGHpq58NfwB/PxwtFP+3IJHGIujh/L1CGpPsXHn98ReL+XQ4NEeIz
         Es+XSgHyBrjngfEn0ACxZn0xsKX88emKV0Th0Y+vkzHmg62cADRWnfM/gEwbvTv4MCB6
         vthcbaibDb5TEl4hMFskUhDykMfoV8nhuE7REH/+RlK/qsfyqxI+68wJmBLjFmiNp4TC
         3FHoB1nH+EpVgTAUaqygyH0RPgR+zUNrapJFt98kpcCbr26z0oLDm72eg8NWd+DU9M64
         PxEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XkQq/Hrmv0eGgt6shvKyYOCwWEYAJMOW7yeHRm4cO0g=;
        b=Vrq5zFmgkw3o9QYortKQeXKJawXxEDkWDFkJ2jzm/799HK5R1/ldOAX/hVqXIDIe7v
         fApJ1T/GooZdXpXXwgx8zT44sNY6dkWtwQLlZu0M/10wym65tjSN1j2MzAss9RrBZMmn
         Pzvylc5qNlnooSa9PftaiLDiz1CCkRkT0hQGC154P5PLVnn5uzctbL1FmJfMVSQYEWzO
         8G6GGewzzPqXNKNW+tR4sEyPee9mCwDXjtUfEC2kAcWfV6waEkHtG4xIZwo5gkxQAWdA
         17bEQtDhucmTd1O0VKUb0tVXrQ6dXeHTgmO24Bcp0HDw7dHPj7dNhtJo04hTeqCm71f3
         XJtg==
X-Gm-Message-State: APjAAAXvYMZ+8ZAJ/+XSfGFQYQIONGnXSXikPGhiVKjGbJF8dSvDB73O
        p52SNVfcMO8rHdksM1dBwPVa+/jOn5byjK+4GP/9Nw==
X-Google-Smtp-Source: APXvYqwtPX7kghb/BJOztTD/T+gcYWOsWYox+xPddCaZVH9LpSnlDmMiE9i0MNpUxqOUmA7yqx/ajp/L79zQ54ZwX/I=
X-Received: by 2002:ac2:491a:: with SMTP id n26mr20421940lfi.122.1554195755639;
 Tue, 02 Apr 2019 02:02:35 -0700 (PDT)
MIME-Version: 1.0
References: <1552330521-4276-1-git-send-email-info@metux.net> <1552330521-4276-8-git-send-email-info@metux.net>
In-Reply-To: <1552330521-4276-8-git-send-email-info@metux.net>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 2 Apr 2019 16:02:23 +0700
Message-ID: <CACRpkdbFdWXFShmiKgdaBdQTH+HY2RQuKXMR3UU3_gMYb1inPg@mail.gmail.com>
Subject: Re: [PATCH 08/42] drivers: gpio: dwap: use devm_platform_ioremap_resource()
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
