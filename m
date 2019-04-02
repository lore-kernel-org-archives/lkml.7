Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA686C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 08:06:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A27F220856
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 08:06:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Q1NV5mVa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729128AbfDBIGq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 04:06:46 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:44603 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726558AbfDBIGq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 04:06:46 -0400
Received: by mail-lf1-f66.google.com with SMTP id v71so3441783lfa.11
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2019 01:06:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3WT5Rdn7B2I8mwHTOIJSabuf0BiIIvc0b13OxkuNwhM=;
        b=Q1NV5mVaguoZ3Q2YpIPtKBedH08nyfptiV+4dqzgVrJ1jk7iv8jMFEL5WacljWDpFc
         JBRkHfGJ9BXUzqpCe7DXYHjNw8Lvm54UsN/eTBa+YK5M8TtRBPt/GFtUg7qYTnkKCyo+
         AU7sWOzcZfJQSYVFI4Hz+kjzJPL6mkI5SD1ftWAFpGwT6V/Bap7/ju6P6kzo+9SSwWe4
         BKS/VcgP2O0WSd1qDYU3qa0DNZFyolqRMaJ/iw/vBWmFu8t3bfQ/M64HyvtAST9n02t4
         IfukkcIQcX0RyyOlXHmUJlU+ncbq5jS5sI5ZdnFooWRB+rwF64GHUIf29S0gR1oz9UOr
         bWSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3WT5Rdn7B2I8mwHTOIJSabuf0BiIIvc0b13OxkuNwhM=;
        b=adKqMVyKMN4+hWT12zchXGzLaKAcDbmbej+D6PJafK8ZPAOlSz7XXWhvKXvea1WQYi
         WUppaT4rsmnDenYfdhhNNbhpw2fUo9KACHZc4oCvVT9i4+VgHBlkcsOggqaCqnDS0tHC
         n0PL+pGt7ldeHBt10p0h4IMQVtDLr3ykpEeTtevtQDE+xCSOUVMP0sGxQlc31stYwO2i
         X7adYg83s0ShTn6EA5w1y81aHagowsJ/QKbFoh+OvyGaiMkw8weKB3TUBXM+5UkUtv0c
         IqDGrZJh/pB7RDFn3+3anfZmcPvL9Nn6pHiFGSSRgCiIEcvPND7/Aw7NEwAzYI4/1HW0
         AE0A==
X-Gm-Message-State: APjAAAUyttEmyCQusRIzdbVuXDfYlha4BUlsuOx5s7brvFPZMxpWaDB0
        tP0tm0o0YMV3XPzV+l8bb5Th2JsJSWJ4rC+QAalGpQ==
X-Google-Smtp-Source: APXvYqzTrZBUwYD2FLtF9zqiQSgw6NRx3KZOhu77daqsbg2fMLAAh6HhKJR2F6ZRMNN2HWciFwcF5rJm6XAy028r+9A=
X-Received: by 2002:ac2:4285:: with SMTP id m5mr8448427lfh.103.1554192404324;
 Tue, 02 Apr 2019 01:06:44 -0700 (PDT)
MIME-Version: 1.0
References: <1552330521-4276-1-git-send-email-info@metux.net> <1552330521-4276-2-git-send-email-info@metux.net>
In-Reply-To: <1552330521-4276-2-git-send-email-info@metux.net>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 2 Apr 2019 15:06:32 +0700
Message-ID: <CACRpkdZzqeLMz3+fdA6Sd5KGE-X+hPU8hU=AimURcAV-YQ+M3w@mail.gmail.com>
Subject: Re: [PATCH 02/42] drivers: gpio: amdpt: use devm_platform_ioremap_resource()
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
