Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3148C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 02:32:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2B5B2146E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 02:32:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VBL8N9kg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727006AbfDCCcl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 22:32:41 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:42133 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726615AbfDCCcl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 22:32:41 -0400
Received: by mail-lf1-f68.google.com with SMTP id b7so10478228lfg.9
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2019 19:32:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XkQq/Hrmv0eGgt6shvKyYOCwWEYAJMOW7yeHRm4cO0g=;
        b=VBL8N9kgYf4OpxFjIlQsx7a9JiT+wlXxZjn8a7Ew1b88LHZV2Ydnv6McK49y8aZ+hZ
         tQ33owMcvOBCoMswxDyHeO2AGuUYnm292cmfNulBgnCVA1ARVdEBTjx+XzbUUClgFG6r
         F6zfgdLTTWNMnXK76LX5Rl3IDDaqcWKbQ58q6kICrQU5ChxBVIGoEBl6Ixx99zBj0Hl9
         FZX++pvhEmUl5liPHqlpF8OGkwTOLISHE4qNl6Ez2m+9zBITzEk6hAXzcdlZTPKoR07u
         1m8noRmyziVMaaQYqoP9DC5aAiDxOeayupXvD79HU1bfHnUxzpIVb39uM1R7IwibKH7Q
         Q/fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XkQq/Hrmv0eGgt6shvKyYOCwWEYAJMOW7yeHRm4cO0g=;
        b=esMkiBvrhh/njGPFyUdjwazwdqHsw9xZjtaPJcWDb4j7Dg8DK51g1OHA5fnXFqPOE3
         /lyV+iRTnCJTAidGteCr4eY2I8/FkupZCsr091zrG9vCVPJGQGYDCs1IkDw4IJERBoXp
         +jGAlVAFGUNPOfHRVaHRFjOC1oF4gR6D8G2N4DFfJ66Ost5VwR972BSQFBJtL55ITopD
         kxpyT83fIDWORNvm3ne30yD3TSFEb8jupHNQhbDM83cmLgnzK1z2TDL/6nTgyKGNlu2h
         l/by0UFwZeD6CtPNlC4pmIxv0kZMEqPpDwLZQ3et7/7GGhkEOYO5ZDV0WYDBW6z1S3Dv
         DvFQ==
X-Gm-Message-State: APjAAAXnRElHiblsQmXluSHFeTsyTuNhR2QUYhfvWmhzwpU5qAO3Lt8g
        +6bEANnkJe/Ug4hUZEEOY4WBVlLR/5DrVTLhpfvF2g==
X-Google-Smtp-Source: APXvYqw44m2qMH4I41m3lUaUrhkfEcGyaJZHic91oHnKZ19gtvM6EZuxTqd0vOCRvurIsNn7zq/sMfQvd8gw0IzgLAE=
X-Received: by 2002:ac2:4192:: with SMTP id z18mr9155286lfh.96.1554258759875;
 Tue, 02 Apr 2019 19:32:39 -0700 (PDT)
MIME-Version: 1.0
References: <1552330521-4276-1-git-send-email-info@metux.net> <1552330521-4276-15-git-send-email-info@metux.net>
In-Reply-To: <1552330521-4276-15-git-send-email-info@metux.net>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 3 Apr 2019 09:32:28 +0700
Message-ID: <CACRpkdb3wQnj6akRb9qBZAgsv7_HTguFgxhNCFaM31+pym7vzw@mail.gmail.com>
Subject: Re: [PATCH 15/42] drivers: gpio: janz-ttl: use devm_platform_ioremap_resource()
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
