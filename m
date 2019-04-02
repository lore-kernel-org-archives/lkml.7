Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 665E1C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 09:00:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33C4A207E0
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 09:00:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kyGeAX+6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729751AbfDBJAe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 05:00:34 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:44136 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729162AbfDBJAe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 05:00:34 -0400
Received: by mail-lf1-f67.google.com with SMTP id v71so3557977lfa.11
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2019 02:00:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XkQq/Hrmv0eGgt6shvKyYOCwWEYAJMOW7yeHRm4cO0g=;
        b=kyGeAX+6loCtDRSQFYtFQVQrjLKRVhQzAx+gJwDVfvnchTPnRnnjQfqlXzgSS9wyF5
         4TCpzfSXR5mQOl3e/mMZaT85aum1xxnOnMWoIIfSBfpUPn94sg0QwwxIaYGtsRtFshhm
         3mLi4A0hjTlz6+1gHxIcIkZGtkweN3Fhgbcrtyt65+By1zL+Cb9mj4t0tLPRlzl70Vk0
         PJKLRRBF7yOnypBz+YDogoyFm1RFq1mt8RrnF7NJQ9juRg3D/eb1dshh5nZSy9v97nnb
         I9TpEo5EGV6Q+PGvkgXLxxvmg48ngoiu7DjcYKYILlYD//1Z5M2TLN10/DzczGLP2V3P
         YZGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XkQq/Hrmv0eGgt6shvKyYOCwWEYAJMOW7yeHRm4cO0g=;
        b=EQbEsRUZl+lRLAtULclLizsNPduZ7smPk/VS4duNgwFa9NXhNntCHBmAQUl+UmO75p
         pj5819XWoZyWo2f4YOiYtwuSroZK2hPM0ZPIbzxCF9LvXiUs0aVjDzt7rUtQClei8zK9
         qIq32dpLM0rBWGIfIN6GQQnpaz/jABgT5ix5IqbiEQsFAL0l1YB/rrmfbr+MSff17dMe
         k28ax2eQFAaUEv4AUJWUrWIBavIDvEkiKPER8B88MAE2k4mTSF/UybvUchSqJ2rP0ooE
         bPTkDYv6E2XnkBRFxZSm/eaWJOFc5UsqJmt2m+ee1LgCYvROpKyMojOv+YUABOyteiTD
         h0rA==
X-Gm-Message-State: APjAAAVlxeeypLFbFA24vx8ZhVyeoj1SbAdQfgyYbU84gc7KpfdxmQdG
        ahISgyCpQ0jNNnxvlIBK5NPasRL1HX3qfP6Ar0GjKA==
X-Google-Smtp-Source: APXvYqwbSJaAqTX9CxD4ZOjsVNtLtwJ8emyPA4U6UvuYIwZ+VHDNnwow4so8SpX9gkMCdCMeONmPZJGaXOPnMG2ozf4=
X-Received: by 2002:ac2:4285:: with SMTP id m5mr8600479lfh.103.1554195632445;
 Tue, 02 Apr 2019 02:00:32 -0700 (PDT)
MIME-Version: 1.0
References: <1552330521-4276-1-git-send-email-info@metux.net> <1552330521-4276-6-git-send-email-info@metux.net>
In-Reply-To: <1552330521-4276-6-git-send-email-info@metux.net>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 2 Apr 2019 16:00:21 +0700
Message-ID: <CACRpkdbsjPRU+HPditfF9WgwZuajwQZb_0M1YLyC7V7--scK=g@mail.gmail.com>
Subject: Re: [PATCH 06/42] drivers: gpio: cadence: use devm_platform_ioremap_resource()
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
