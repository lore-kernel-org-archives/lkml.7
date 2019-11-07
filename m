Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 884D5C5DF61
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 08:04:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BD6A206DF
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 08:04:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="F/SLkeZf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727621AbfKGIEW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 03:04:22 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:43537 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726734AbfKGIEW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 03:04:22 -0500
Received: by mail-lj1-f193.google.com with SMTP id y23so1152765ljh.10
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2019 00:04:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Icvs9OZ2xWXC5UPn4WjTDzsRSqv4ABuStVj0mfFJ9ZA=;
        b=F/SLkeZfh9tn1C1SOcqQGA7uI8T6cB6x6lBr5R+HR4WuNbOlV4NPR9FoJasE9xAtv6
         myuCAP/bRD1Vvyzg8Ht5V9SEOvVDBbEU7ewy7WXFpiZ1HLhB8P2oZeUPl3Cmzz8jHTBx
         +JfsjtF9sx1XLM12jsSW1Us+ebt3dG7MeFhJRiWZ9vvFjb/pYX1Z67xgojDhwliUFwWq
         wc+FCq3m2Kv4+LogclzGNz9+4IIpJKrUjtvRQecQJusMeZQtaRp1A4lh4MEQGcSjyORu
         POQGNcpHNLzdj9lNrwEoO14rI7QHovnPphY92fDo2F1f8ufzcgSnOLHhOCHrewzyFfUV
         TcfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Icvs9OZ2xWXC5UPn4WjTDzsRSqv4ABuStVj0mfFJ9ZA=;
        b=txy/AHIYPJASaeFYzZz82UjZAmsknzg+Ar2xapqhsiprx6+ZNVubPqDckYI63Fl3wI
         z7PZu7p2r5iI7vYbH5qO6sAluyZigzr2NZ4V5clNO6lc+ErvWCtD5B7vm7cx868tYayU
         mhxNZPAOKXB4TboDReZhgBCkxdJu5ldGsF9AErHnyVgdEGBoR6sS30a0EGpKDcxIPsG4
         HG7jGqplCJcTaV55J9Z/wceqTyatWmdt1YyiqFoT0Q/wYgu3VfhPJzrh32M7VRpAveaN
         OTJ3ykUcVaHUBKpi+/+rz+NPfb2xocmxB9SNYv/eVQAC6FCHHqTAEo4QhjMLRRJJLA5v
         igDA==
X-Gm-Message-State: APjAAAUVTnTTuauGymxhCD3rTnBHIQa13/Q4XbZT3u+WA6wdHMuO1+iz
        /gnBUYLW9xOBtw1XqQrt8j7Okbq9/48/hiF8JGukIQ==
X-Google-Smtp-Source: APXvYqwyLBON2IrM1MH7zrGDSUoOt7eH91Ktx6j7qYfJSSZHJ7k8s5gOCs6qkRwBV0ORbE/D4fJNFUcmt5X6vjZzWp0=
X-Received: by 2002:a2e:161b:: with SMTP id w27mr1297296ljd.183.1573113860059;
 Thu, 07 Nov 2019 00:04:20 -0800 (PST)
MIME-Version: 1.0
References: <5dc3460a.1c69fb81.bfae4.adf1@mx.google.com> <e2ba3c23-4b85-f83b-0ba4-dc0db1b8dd0f@collabora.com>
In-Reply-To: <e2ba3c23-4b85-f83b-0ba4-dc0db1b8dd0f@collabora.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 7 Nov 2019 09:04:08 +0100
Message-ID: <CACRpkdYA9TgBWb2TQzSVtV1CWy6ZOXA1=8NjSg5bksrNM1C=NA@mail.gmail.com>
Subject: Re: next/master boot bisection: next-20191106 on r8a7795-salvator-x
To:     Guillaume Tucker <guillaume.tucker@collabora.com>
Cc:     Tomeu Vizoso <tomeu.vizoso@collabora.com>, mgalka@collabora.com,
        Mark Brown <broonie@kernel.org>,
        Matt Hart <matthew.hart@linaro.org>,
        Scott Branden <scott.branden@broadcom.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        Scott Branden <sbranden@broadcom.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Ray Jui <rjui@broadcom.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 6, 2019 at 11:27 PM Guillaume Tucker
<guillaume.tucker@collabora.com> wrote:
> On 06/11/2019 22:15, kernelci.org bot wrote:
> > +static const struct of_device_id bcm_iproc_gpio_of_match[] __initconst = {
> > +     { .compatible = "brcm,iproc-gpio-cca" },
> > +     {}
> > +};
> > +MODULE_DEVICE_TABLE(of, bcm_iproc_gpio_of_match);
> > +
> > +static struct platform_driver bcm_iproc_gpio_driver = {
> > +     .driver = {
> > +             .name = "iproc-xgs-gpio",
> > +             .owner = THIS_MODULE,
> > +             .of_match_table = bcm_iproc_gpio_of_match,
> > +     },
> > +     .probe = iproc_gpio_probe,
> > +     .remove = iproc_gpio_remove,
> > +};
>
> There's a fix for this which Mark sent yesterday[1] and should
> have now been applied, by removing __initconst for the
> of_device_id table.  So this regression should not be present in
> the next linux-next tag.

Confirmed, I pushed a new for-next branch with this fix in it.

Yours,
Linus Walleij
