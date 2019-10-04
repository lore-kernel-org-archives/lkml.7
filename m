Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D599BC47404
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 21:09:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB33F2133F
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 21:09:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aCbl12x3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730855AbfJDVJr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 17:09:47 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:37615 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730341AbfJDVJq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 17:09:46 -0400
Received: by mail-lj1-f195.google.com with SMTP id l21so7869306lje.4
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2019 14:09:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nsF2c8OGTXKvB1zK+uZXhEjz1J0a3m4rT+VSSrY1BhY=;
        b=aCbl12x30H0M1NbpcbVYJ/2/eoaY73t6fRBNVfU7bOOOLlr4BH040+mtS+nuDKsAfC
         1Ag8zyY7B5JSR8VhHXV6L21EwY4QTvIwa6fDAOZIJ4FHNSi5rqlgB4EZZ4zD4x6TkIr+
         X65ZARuNLu/KFOUMm0C16M4Z5YyQpKuQqNHRNCv9C1sEkEBhg7y6Djg+VOMwmknnv6Kf
         upXE2q/+qp2bgdmPbqkgFHcVfj35Y605o9IEkR6s/tHjfBVbv2YiF15BIb0NMejloO4t
         hJD8YDIkI9wKHqPV9XRs4sdGdo14hCUFvOlIqwEWmJZv2TH7pWmdEj5GkR4vNTfFgIT4
         9PdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nsF2c8OGTXKvB1zK+uZXhEjz1J0a3m4rT+VSSrY1BhY=;
        b=U18q++5/pg2FgtTV0mzeiRmA47ma65uxh3vl/86t7tn58B1Ad4xWOsrM85FfP+gNx+
         KWl8Q9NEXaW0jqlLjX19bnW+UQZ9OQHOKPbeeVGfeG3VRwwEYO37dQG4ZCWZK0gzQhuI
         2A8Cj7svYgrV3vx85WZGgGGnJVGzlMcBmDIwqA4o8/mgyu1nYR2tkr4KzzZodkDEJtjh
         y4TTv9ZFxb+t2QZMhITzPlRmXgUNAYOkSKxKIKkUW0rWyRNNBgfpE8/KyLlqV0cMm8Tb
         pzr+hhikmnZd+Tl46F+IWBk1fCNyogNyRgeCVyqu8zCFg34I8dCuUq616guGUIlPPFZd
         Mt8Q==
X-Gm-Message-State: APjAAAUoYC7xpcjWEfIkoLL7TxWmYUlqEf7eY2bsrn/lndF9o/mhJhAM
        OB/nH7Q5EBqsxxKh+5MqHoFE1JNKXL+mGd7BF61zBg==
X-Google-Smtp-Source: APXvYqwPSI99zYdzPXsF5LC5g1u0DHiTIc+QFVPoPtWG8vJBF5vIibncqONIV7SaF30kuuK/kJPPe6LMA+kLJKX/Dn4=
X-Received: by 2002:a2e:894b:: with SMTP id b11mr10618294ljk.152.1570223384451;
 Fri, 04 Oct 2019 14:09:44 -0700 (PDT)
MIME-Version: 1.0
References: <20190920122030.14340-1-colin.king@canonical.com>
In-Reply-To: <20190920122030.14340-1-colin.king@canonical.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 4 Oct 2019 23:09:33 +0200
Message-ID: <CACRpkdbQBaZgYBGAAfi7mg+4RMfWovi9io28q4u7KAW44bJ6WQ@mail.gmail.com>
Subject: Re: [PATCH] pinctl: ti: iodelay: fix error checking on
 pinctrl_count_index_with_args call
To:     Colin King <colin.king@canonical.com>
Cc:     Tony Lindgren <tony@atomide.com>,
        YueHaibing <yuehaibing@huawei.com>, Nishanth Menon <nm@ti.com>,
        Tero Kristo <t-kristo@ti.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        kernel-janitors@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 20, 2019 at 2:20 PM Colin King <colin.king@canonical.com> wrote:

> From: Colin Ian King <colin.king@canonical.com>
>
> The call to pinctrl_count_index_with_args checks for a -EINVAL return
> however this function calls pinctrl_get_list_and_count and this can
> return -ENOENT. Rather than check for a specific error, fix this by
> checking for any error return to catch the -ENOENT case.
>
> Addresses-Coverity: ("Improper use of negative")
> Fixes: 003910ebc83b ("pinctrl: Introduce TI IOdelay configuration driver")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Patch applied with Tony's ACK.

Yours,
Linus Walleij
