Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60C96C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 02:59:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E445204EC
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 02:59:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="p3ig8KV5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727242AbfDCC7Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 22:59:24 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:41190 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726892AbfDCC7Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 22:59:24 -0400
Received: by mail-lj1-f193.google.com with SMTP id k8so5045038lja.8
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2019 19:59:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=m5exmGidpjCr4jWrxYPKmCQp8rsnrX7zpX4nxsNlFNY=;
        b=p3ig8KV5DbSiTc+DqBvEXPIifWRQHI7B+1Ms7ib1/p0gAIGIqAOShL/ZW+YJ8uJZ5U
         3XtOabaCcy7VMC3LDbe2nIELLM50f8qY9djrIyPoT/bGwi2ngpXYc5Q/jXK7iDSMjrXM
         A902lpiP9X/7WKjMhHqNkgikybEbwSwuXxLS0VB/u4NZook+RpCbRUh4ersX4mp6lKko
         D+AJegBWcYPfR7q7+jWK2R//DmPEX8r/p2FZ3n5iQ83wm9Zj6DPi/LmCPU+CXjPy6Uv4
         9DLmAxbUWOYYB+3xJPU8h+5uGbrBeoGAJWWyw2TgOVBoamOVeCb8P9N3b5EV809mnjpo
         Q0DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=m5exmGidpjCr4jWrxYPKmCQp8rsnrX7zpX4nxsNlFNY=;
        b=odJpmiFFVhcCKIHiqsBtaNB7YBqJ50H0fcPTkU1JSEPpjzn6OVm2HWFLFmhRwvFSZD
         qq4+mteviwjAgRQGdlJBvYUkDnj3Pfp11McBsxY3VZRDndnvtaNugvnNmzu2/vTXCkvS
         ggh5SCtqc1E0JmgzfcYVngJoLGYxCd7X93yCFuK7mrdpektLnFr+xn6gniLT/6yP/UsD
         qrY1Svs8j2z4W09ZHkqyWURS9bMpKmeV2O1qn49RqePJvN8icXEdxAdwzrkc40vM+zYO
         kmP5bUPRyFj2S9sMji4tZwCnSxnqnbD6kk+m09Hxdz7lMsVXEsLLJMTGKXQkM0lj+fMM
         AuuA==
X-Gm-Message-State: APjAAAUg8GsEM91z49tKodhrpdcjIikNxT/wj3bZawbdPqcZC4R5kl49
        CNYR+FNYxFx9EF5mnYdg4h5AFGq62vPVD4RKjM3VmA==
X-Google-Smtp-Source: APXvYqy29GH1Jn+4u+MOhDomj+6lezG9yxERqwHecHUTB1BCVyWQlMbSD+e5lim1Q7JFWVDTXQVrM/0b/Nzkmxs9nBE=
X-Received: by 2002:a2e:3512:: with SMTP id z18mr27025494ljz.25.1554260361993;
 Tue, 02 Apr 2019 19:59:21 -0700 (PDT)
MIME-Version: 1.0
References: <1552330521-4276-1-git-send-email-info@metux.net> <1552330521-4276-20-git-send-email-info@metux.net>
In-Reply-To: <1552330521-4276-20-git-send-email-info@metux.net>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 3 Apr 2019 09:59:10 +0700
Message-ID: <CACRpkdYXKOdk42V4xZLY5BWbEp8hPePep5-XmcdB=WBewpUm6w@mail.gmail.com>
Subject: Re: [PATCH 20/42] drivers: gpio: mt7621: use devm_platform_ioremap_resource()
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

On Tue, Mar 12, 2019 at 1:59 AM Enrico Weigelt, metux IT consult
<info@metux.net> wrote:

> Use the new helper that wraps the calls to platform_get_resource()
> and devm_ioremap_resource() together.
>
> Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>

Patch applied with Matthias' ACK.

Yours,
Linus Walleij
