Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD509C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 03:04:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87D8C2084A
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 03:04:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jz4l/sfB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727053AbfDCDEr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 23:04:47 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:35781 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726670AbfDCDEq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 23:04:46 -0400
Received: by mail-lj1-f194.google.com with SMTP id t4so13471732ljc.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2019 20:04:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XkQq/Hrmv0eGgt6shvKyYOCwWEYAJMOW7yeHRm4cO0g=;
        b=jz4l/sfBt2guRdw7Nex5Da3A1DrKNG6RP9kSqBk72WthY7g8CYK8DXINCot6ksn821
         o/0gVGrBc9rGQDg8u9roott5AGOqeplKZnWdeEcBIBMwUqnXhiyyXcIdGan/w/EsdlPP
         nIpHd77H+L8Gn31zRSWJNcy5hO4ixFuqDbKPxQvjMXxFHm7QYswu0epvQI30hnn9ikgo
         122iUJ7lPGE8k9H1H3nHYrYcr/cfthFHNGIUZQ56zZGulAyQbZMFGtP1rPC+fQFwc7AK
         v2asLjS/8y+W5IkVfCCQNcYxF6qjJpGCmWw7lk/C0e3VaIDrCtOvInl/JWp3Kmy+2kz2
         A3wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XkQq/Hrmv0eGgt6shvKyYOCwWEYAJMOW7yeHRm4cO0g=;
        b=LgGnOFLMMPQ2Z1cDkawUcee+TuGW+PyL8ddDwfIHTlDHo3QegTOtOWGKBd0ViRVkjk
         4qljDJkn+q7DaDu9+ECA/TUZLk1rJZFLc/+eaWhvKJc1voFh9xMf1CdPph3xSTwQ0q2a
         k71na3JZ1dgWdMiXeCq383ah4Fg8o+BAmJ/Vrw1wLKnlLZ7y6LxmC57111/oEIj716xy
         tcfR/AgeuhxFj6M0k3xS2Xt48/MLqavHe0xqoLQSDma3vBDWYW32KkCXZYZRVAIvCThL
         zfZgouRgR0NNmmzgVY/9vx0EkwO/OZXas64ODRVK+wYAPYoti9hO49EVACdYxw31Tk6Q
         1OQg==
X-Gm-Message-State: APjAAAUHGaKfLOaoV2gnRjRgES32ZvlF8yZyOcm+8xXi+JJu92vCvvBG
        uYHt676F3fhQ+7hLqtrR4xg57nYTIaF6tckk7rj8Bg==
X-Google-Smtp-Source: APXvYqwCpclFE0B6aiLt/xeJkod4NNeVotiR9GZY0G8wtY/6oxFM7Q0UzsAvOv0L6inWbX4wzLhGpt9EQ4cWCTWV3x0=
X-Received: by 2002:a2e:4a1a:: with SMTP id x26mr5036295lja.49.1554260684955;
 Tue, 02 Apr 2019 20:04:44 -0700 (PDT)
MIME-Version: 1.0
References: <1552330521-4276-1-git-send-email-info@metux.net> <1552330521-4276-22-git-send-email-info@metux.net>
In-Reply-To: <1552330521-4276-22-git-send-email-info@metux.net>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 3 Apr 2019 10:04:33 +0700
Message-ID: <CACRpkdYi72aUuPPP2xrAQTqKDEPWzjgscPgqSoCh=iC+0Gb_-Q@mail.gmail.com>
Subject: Re: [PATCH 22/42] drivers: gpio: mxc: use devm_platform_ioremap_resource()
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
