Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60F01C10F06
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 03:57:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E61C20882
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 03:57:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Z8xhJlPv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728345AbfDCD5T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 23:57:19 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:46503 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbfDCD5S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 23:57:18 -0400
Received: by mail-lf1-f68.google.com with SMTP id r25so10566725lfn.13
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2019 20:57:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AbU+kmZSC+Y/tOkChrqM0buIPdAzFYZS8GmNBgZASBE=;
        b=Z8xhJlPv0TtCxjb97A0wr3PD6CLzvcGjyT+3RAC9TGeAJqa1TWFRoOVtsPnlVAlHze
         dg7umcmlEe2PXpjwG5pupxb31N1nPWAG967bBJJyQhAm09MquXAdv96Hzw+GDaslJnqB
         yX9ceBdf4aaTSbSdIaKXQSmcPso6uLDgFcY3gsEMa6rXS5XXfKEFJTC7uL8IY606liqt
         TJ+/SdkjH6E66u4CpdlDJNy1PRXqZSQPCdJkTOQfRc1F9FYvBP4Tf0X6RSKZq12C61nO
         F7yXE9LFkOXNle8MntmrD/+ympcHataYbRrwhyTMcW4KWYW3oS+eXF6eT95togsSj4Fc
         9IwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AbU+kmZSC+Y/tOkChrqM0buIPdAzFYZS8GmNBgZASBE=;
        b=Wu3D79UzVWJMTZMj7FuS033nROUCLsJs5urET1BywzHEsY/PbME/VY4ZnGvBPHN/Aj
         w3V6kMY35ohaq0FTHB9PU3UppyoSkMedht3EX3oBQFxtQS0SymFMrgDVBoADj1WAF4+G
         6t3UQPHZdxRxc9nyczXYt7AvcdtbkUk1yK9eGWJUcbim9Hi+/hqwWLwdSCyXP70fyI5X
         yzUQCkdUhwvdReiipNdPzjLtDuBK/20cB/oWyHU6ddz0bfCtBaaMorc//MNhbfKypkKF
         ZXK50ezFxsgBwtm4w4UV/OVQNSDmd1Mal6m5Mm2Ws2EIxYaoqBLk4J06LK3q+AqzjE2k
         tjAA==
X-Gm-Message-State: APjAAAXjNCtFW8tYom/JCe0RdCIQkt54B6+Ia+AUY5hm8EgXmoVXEArO
        8xkDxiPhsP8aTbb9MJvI1y8zaVkiPzkaykVkBXFdRA==
X-Google-Smtp-Source: APXvYqxCtW6t1J0D2KR9/Dvk/b7vu0LCbFlnG2X7HgOHuumYsqjFLX/FhDm026tSB6cKJc5ogxxh3f4Dlow1w3RPJcU=
X-Received: by 2002:ac2:4192:: with SMTP id z18mr9312256lfh.96.1554263836817;
 Tue, 02 Apr 2019 20:57:16 -0700 (PDT)
MIME-Version: 1.0
References: <1552330521-4276-1-git-send-email-info@metux.net> <1552330521-4276-42-git-send-email-info@metux.net>
In-Reply-To: <1552330521-4276-42-git-send-email-info@metux.net>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 3 Apr 2019 10:57:05 +0700
Message-ID: <CACRpkdZ2de7Z+yhwb_dYfn5ThmuCHtxhgYoOVJtc9mQU4PsSAg@mail.gmail.com>
Subject: Re: [PATCH 42/42] drivers: gpio: use devm_platform_ioremap_resource()
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

Changed subject to gpio: zynq: and applied.

Yours,
Linus Walleij
