Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60362C2D0C8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 16:36:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3768E20716
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 16:36:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fuTmNCiT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727492AbfLTQgF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Dec 2019 11:36:05 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:41313 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727403AbfLTQgE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 11:36:04 -0500
Received: by mail-lf1-f68.google.com with SMTP id m30so7504416lfp.8
        for <linux-kernel@vger.kernel.org>; Fri, 20 Dec 2019 08:36:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jLa2dN/auoX5wIvaWIVrrYsMpSzoa4LfkaQLVViXRJU=;
        b=fuTmNCiTKFxJDOBKOwXuPHN1WkPtp9111gau5tq95BiYFaa+9IkBEku2AS9IF8O9c4
         Ql+JaTxqYS1ZPJiDEyzOJPaJFofEgFs7nuaCyueSOthWkXsR8GmMwuCj0Nb7mhx//Bab
         Dp+xfI7PSYTXM7XxYDQ+1HwLE/enWpFL/uG5e+SPXedX+3LOhftZU62MGoJcA7CfrkJt
         x93r9ttFh96VMbpw7GskVb3KTS6NuEhZ/SmftJ3v0f4UtGvomBxElx/UDczf6Wo0+eBT
         uLV3QyuOERCIk3OUMfGc8ZpawGHK3EmvB/k9GZpnHILSdNwvwQB2jGxOjDVJVj3/fF33
         5Dhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jLa2dN/auoX5wIvaWIVrrYsMpSzoa4LfkaQLVViXRJU=;
        b=Xy7dWnW5DRyI6S1T7QGzl1UW2vCsiLfBX1bI0TvIXToZh9Ly9kdRLat4g/YTptRqO4
         xz4Rr1uzX9+LyZTi/IH8LGHgwy46uIBARX2Db40MxXBw/s49S99kRhw3OuL6+hCcKJqg
         J3Qw++pX7+wpsMJ9Ppafk8U0tbvp9vrg3yFgrnDDeuUXlAf/6THR3qZbu2yBJqPK6STs
         y5XQPB/G1lZvR6ahaU03+9/4YlxCNrqjx4mQrnHq0uCP/BsbhPV5+xPVthSVNuk7TTGU
         9qZezL13fLRQycicjF4MZ3ZSx4XTYMdqcfhUZWxb+O2YFbSvDR3n8M6+/yVe9iTz12JP
         +rcg==
X-Gm-Message-State: APjAAAUJyF543VI04c6oGUcwVX1RQhPMOv2Bmf12tBmSPt/ijXMb5acp
        a+fqYRegluwNgQdjF4Wh2jBZrphi0YBp/InZKHppeA==
X-Google-Smtp-Source: APXvYqx4tffl12i/HGqRf4xn6+oXQ7x7HuEeGMpoti4TzYzcxieGNQFBYTjykMARXxnYBjdpgNmWxoJFilAlNgheiBM=
X-Received: by 2002:a19:2389:: with SMTP id j131mr9202421lfj.86.1576859762615;
 Fri, 20 Dec 2019 08:36:02 -0800 (PST)
MIME-Version: 1.0
References: <20191220160051.26321-1-dan@dlrobertson.com> <20191220160051.26321-4-dan@dlrobertson.com>
In-Reply-To: <20191220160051.26321-4-dan@dlrobertson.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 20 Dec 2019 17:35:50 +0100
Message-ID: <CACRpkdYVSGa4PHT9nHcV-YnVbhd7E3xK1FDhV+50SOMEk699Ww@mail.gmail.com>
Subject: Re: [PATCH v8 3/3] iio: (bma400) basic regulator support
To:     Dan Robertson <dan@dlrobertson.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Joe Perches <joe@perches.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 20, 2019 at 5:17 PM Dan Robertson <dan@dlrobertson.com> wrote:

> Add support for the VDD and VDDIO regulators using the regulator
> framework.
>
> Signed-off-by: Dan Robertson <dan@dlrobertson.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
