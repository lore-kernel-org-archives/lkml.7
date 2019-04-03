Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AD34C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 03:03:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39EE0204EC
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 03:03:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RVLPPgCx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727023AbfDCDDU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 23:03:20 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:40852 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbfDCDDT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 23:03:19 -0400
Received: by mail-lj1-f194.google.com with SMTP id q66so13434136ljq.7
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2019 20:03:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XkQq/Hrmv0eGgt6shvKyYOCwWEYAJMOW7yeHRm4cO0g=;
        b=RVLPPgCx6K3L2VFOGtBYaTS+GD+SWYbolv+uzwMoFxh6u6yQJ+ikpDfAGX8zxxLuMJ
         +p/IWqkG4lRu0JKlTdb3PxvmZkNXwaiIpR9U0N2D0KUcUxZK02c52Gqmuw0l+o58rM89
         OVQlIeeHIomLucbg/VoUFlFA4qDLcsxLVlvfonphh2cUCPfzJYmOlRHSEgr60xsTqdZd
         3AY+OchrFCo1b5DIGnbKS5ox/DDw8V3dSpJdDckg8v3Bf9zhHZ90QTHQjhrQnWQoEOdc
         isBNSORTQVC+sJ+qVYb96EOECbiW3ODOWr42wl10keT6rs6F0wfEnX2PVKk1Mr/NXZ51
         Y+qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XkQq/Hrmv0eGgt6shvKyYOCwWEYAJMOW7yeHRm4cO0g=;
        b=YX4/PBmSzk+zspZOXUn67z2YPuAuLfJoCX9E5RruVTOb77rArvllZdCzpYL7IiC6Eu
         pipbmbR+wP77oV+60vV4N4QfB5FUrns5vNXjzWsaZcTew12/FMTzgLmi/t+Ly3qIDLPA
         72oZX9kTnh1MzdcLnwXHW8FhLfub7Yls194MdmxMgPlblifrchzhpCAfLpcAHstjUrTT
         cg6lt/SnGy6z/StGY82n+yJqUJ8Q6vK6EpvF4BDeSKMdd9cCM6pUIzsnxSd4+3xM9aj5
         b0d9sdFiAUpMFQs0XRUVqgSfo6ZXZKBtlr8p6BLNeMu6fpc1eV0XVZ8VTgtiHNpPWp7T
         AouQ==
X-Gm-Message-State: APjAAAUk8V2XpwYGXvr9sGNig+BRjVuCNz47iANkbj4FBkuoRhhupWMW
        +OeeaXD6gok+E+t/gVyX0gQ7YL2avGGbTPzpHAN+tQ==
X-Google-Smtp-Source: APXvYqyUiSJNIbNGobMeQ+nOS55yLnkw+fRP4j1n5ZD2swq2e4QKQJ3GQ2HhFzusELKH8yMqCLLkPOfKmVK6Myo4EQA=
X-Received: by 2002:a2e:5d56:: with SMTP id r83mr37927704ljb.74.1554260597927;
 Tue, 02 Apr 2019 20:03:17 -0700 (PDT)
MIME-Version: 1.0
References: <1552330521-4276-1-git-send-email-info@metux.net> <1552330521-4276-21-git-send-email-info@metux.net>
In-Reply-To: <1552330521-4276-21-git-send-email-info@metux.net>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 3 Apr 2019 10:03:06 +0700
Message-ID: <CACRpkda9SJ9q4xZm=3-J3fN2Ndc-UJ4ArsL26yGD8djj-h=9kA@mail.gmail.com>
Subject: Re: [PATCH 21/42] drivers: gpio: mvebu: use devm_platform_ioremap_resource()
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
