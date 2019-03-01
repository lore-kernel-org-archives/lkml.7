Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79F45C10F03
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 13:25:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49F5520850
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 13:25:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FBPKZx85"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387711AbfCANZv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 08:25:51 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:46749 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732820AbfCANZv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 08:25:51 -0500
Received: by mail-lj1-f194.google.com with SMTP id v16so20346769ljg.13
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2019 05:25:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=V7YXjj6FthcgYc/eHQE7KUwu0HKMTksPy9gturuX4q4=;
        b=FBPKZx85GGzcqpffUquGe9ktuOQIIN9vFHMr/FLayA9Auy8o5rmp/7DzB/+2vOV4kn
         2D7T3xvnRhCaLwkZDP+Ika35fXiEj/lacLFygIZP8Im32Q3winPVUHL/6/VdMh50B+oa
         /EGHiqoEvXa+m30vbI88tW81nvp0+SsajTfed//xyIjlXUyLrqjuc4Cnvz+JDzUrve6O
         Zg5h8o6EABkuqKF0jlymEAbRdp+TDb5hMB77AjGd8Mt5lnKVwxOhlfhFjTQHra7A0/uu
         i4Ssz8KYl3gRL2E+ENCrQRglQ6hdzELjdKPB/3Btxo87klJxCg9qUgxoxoprVzy9cIMp
         m53Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=V7YXjj6FthcgYc/eHQE7KUwu0HKMTksPy9gturuX4q4=;
        b=KhLL8juevh9vXBECAIfEIKzqClDXmzwAVnHBZmLCv96PbfsLxKKN2n+LW92svdrmTZ
         rfppxHu2MZe2Hfs2oHUNKgK7TBapEFYSs5A4gnpN4UfnjlFZtmQp+GdmDQJGiA7q6kbE
         X3XNoD/S4NPU0n8N32dZoHtGCgPYq5UFvVjcDwoZHXBwBGp5Tk42mZ1JpP3bYYv2weLH
         FQEou3jl3+SdFDe/60XGd5M7i1Y7ZyLMh02CgNMbRb1enebRr+NEEuNWFkNuXl9iKyFj
         KvZA0zs1x0qucQaHN7fJzIiIv/jN3RjfNPta+8UwmbaUHpaSfN8lGFMwQZP2ZkTPGxfH
         hK9w==
X-Gm-Message-State: APjAAAWF/+bFwbBsxtKQF84Y00oz27ZReYtSruFlHV86XO4x4MYIM0t7
        l8ZJEOmr2MK4DQuayk1BrYmmEVh5qjkWspI2RcgznQ==
X-Google-Smtp-Source: APXvYqwwClf7Ywf1G84ceXV4hDUegWOuep38etn+0iQeEJeYJJJb7iSvOmsNj/jEsv5orKAP6S3OEQYnDPVeFpJTXQc=
X-Received: by 2002:a2e:2ce:: with SMTP id y75mr2637491lje.126.1551446749098;
 Fri, 01 Mar 2019 05:25:49 -0800 (PST)
MIME-Version: 1.0
References: <1551392209-20004-1-git-send-email-justinpopo6@gmail.com> <1551392209-20004-3-git-send-email-justinpopo6@gmail.com>
In-Reply-To: <1551392209-20004-3-git-send-email-justinpopo6@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 1 Mar 2019 14:25:37 +0100
Message-ID: <CACRpkdaDVvOQnYUGPLFEjqWOnLS=sw=mAn4WkJPHrLtp0gtCdQ@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] iio: adc: ti-ads7950: add GPIO support
To:     Justin Chen <justinpopo6@gmail.com>
Cc:     linux-iio@vger.kernel.org,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 28, 2019 at 11:17 PM <justinpopo6@gmail.com> wrote:

> From: Justin Chen <justinpopo6@gmail.com>
>
> The ADS79XX has GPIO pins that can be used. Add support for the GPIO
> pins using the GPIO chip framework.
>
> Signed-off-by: Justin Chen <justinpopo6@gmail.com>

This looks good from a GPIO point of view.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
