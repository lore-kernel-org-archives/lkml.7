Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D734C48BD5
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 09:05:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA56A208CA
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 09:05:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nFParKFr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728977AbfFYJFk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 05:05:40 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:41473 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728365AbfFYJFk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 05:05:40 -0400
Received: by mail-lf1-f66.google.com with SMTP id 136so12068778lfa.8
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2019 02:05:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PfsIEjwno9984x0xaZFvFQRHreP7y383b0yA/8o51ao=;
        b=nFParKFr+QigyexDCDFFBgRPTVH7s2tgXQic1JyrzOYcjzvFaAe0cJHxr3XlvxzlAS
         EqoKOFf6cyewb+42kGLyTQwePgf7SG6lJd4ZkGBUqGk+nrP0IstFMCC8dsyJrh4MG+4o
         y8yLMITzcDvN+qcKEfUIKfrhpQKDA3P9F4vEkqC2efNYSKyO+idLW96uKvbpLkW4YC5c
         k5IHlLaU47Xns1FNHNwJVKZe/7ZDZucBQe9oFpX5hB18sgoAMYhpobbOG+6xsaWebLcu
         dIQH1HMond/+QbcSJZM8ejlgvyYcuZmNXTyCoyVpQT5PbnIyriqEO7x6N/gYrE9rFJMr
         ANxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PfsIEjwno9984x0xaZFvFQRHreP7y383b0yA/8o51ao=;
        b=tkQJMbn6f3xbTDQstmRLLQW48MgLXcvbEZrAg8vQOng3NwrZreJUjDbIuief5LYecn
         5xHurw3XiwXtvYfR0kvn76eBt12NSxsJeuXMmDmi1p2YGf6G7vCjlcSqux6LTCcGUB0K
         ETnkMEXVAdo2V+AtdckgMeKYpydGG4K+J+IE3E4jJBfXxZWVktRkB5xoN33V7pOm1QRi
         1TPDSCNb8cX1ToC2C3ffiwZ+3twQ89vEUPsDwWJILcwko9c8dLMmQFecyjIIqOWic6Vr
         IrwnS8Nf4J4zDZemryaZPs2dCWyQRNvAaP+mbYe4BpQFc+yV7c3LBN7qQfLwhOsn+Ml3
         cLbw==
X-Gm-Message-State: APjAAAVTGl4daL0bohDTXsMEoI65BbsRgftPcdq6OoGMO+sZnrmBcy5r
        +h5mq119Bu84N9uzzixMld2brDxKYIVLRF2qglwcVQ==
X-Google-Smtp-Source: APXvYqxeHuqZCf8OLU6iYGSBN9wT3sJ7A0Tzxmly5Y10lX4/3f8I/dMLymuTvaCc9HjkJUkdC9fFt7v7D9Pf1Y63hFs=
X-Received: by 2002:ac2:4891:: with SMTP id x17mr28635379lfc.60.1561453537378;
 Tue, 25 Jun 2019 02:05:37 -0700 (PDT)
MIME-Version: 1.0
References: <1560790160-3372-1-git-send-email-info@metux.net> <1560790160-3372-2-git-send-email-info@metux.net>
In-Reply-To: <1560790160-3372-2-git-send-email-info@metux.net>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 25 Jun 2019 11:05:25 +0200
Message-ID: <CACRpkdaSj2OA8RX-oxK2sn6=fUQd=xB6oNnbErqxbQUMDVg9Eg@mail.gmail.com>
Subject: Re: [PATCH 2/7] drivers: gpio: amdpt: drop unneeded deref of &pdev->dev
To:     "Enrico Weigelt, metux IT consult" <info@metux.net>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linaro.org>,
        Lyra Zhang <zhang.lyra@gmail.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 17, 2019 at 6:49 PM Enrico Weigelt, metux IT consult
<info@metux.net> wrote:

> We already have the struct device* pointer in a local variable,
> so we can write this a bit shorter.
>
> Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>

Patch applied.

Yours,
Linus Walleij
