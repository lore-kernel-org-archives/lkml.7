Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15C8CC43215
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 13:59:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6D8920722
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 13:59:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="autV2GM1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726858AbfK0N7C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 08:59:02 -0500
Received: from mail-vs1-f68.google.com ([209.85.217.68]:33902 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726558AbfK0N7C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 08:59:02 -0500
Received: by mail-vs1-f68.google.com with SMTP id y23so15268618vso.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2019 05:59:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gAq++vOmWlGE0rfhdloa1GAF3bf8ceEKuBq/5jw6JRM=;
        b=autV2GM15bvqwiA+NNcmk4/aTXU/HSFEF/5su4++BbyqM9TTPEl160Dl4aSSi4PSHx
         7dEzEqyacVs+yewRvnBZ83UHqscNkWGpzMcJWLLLi+QCkk1xhjhnBlxejNfHU/qVmTuj
         T8igdSS/tZRj5c7YLCT4H6AYMtIaHIBwPBfL+kI7kHRiUmSNwFnRVIFTZRS1Wyt1h3R3
         cyqBUvI2GSXDWeDlgidAaqloDquB80gWY3CD6nCyEEBi1JxlLSFZcsLD22SLWLifDTD2
         +z7R1ny87pHoyTM6Q6jqCBqMtdOrTs+pljEMTkDmflCfHXKg6KEMU4pBGfyFDHpkZxXz
         MSgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gAq++vOmWlGE0rfhdloa1GAF3bf8ceEKuBq/5jw6JRM=;
        b=DUFpOLrJfhD0OG5g/rkvkFJKk/uX55UwqKPvDXJHrbs23IBP8sB4y/lcRD5lJHg0RK
         jzbv1WfvRkWpcnQ36F+ygj5Y5xPX6MT/XNDDIxcsUARbCaXxOh2MhRkSspWo/5jH/zoI
         K8F72wk1tJ6LY5QuQ1fd1GGSTYuR5+foEcc34KXF6U1bMMZvqFgIAk08za5LyYkgXJmi
         N+FvFa5NOV7H+iKCcn+d9sHxDeumF9vXInCzG0mmpTp+G/fGekW+t4weU3RApQGmb/AJ
         QmIEUluKxFwTvbAW7UE9Xp7FUuF3LzVwFMGGCvi0/PFwMnX3tRvNAuMucjgiaOAh9bSb
         z8NQ==
X-Gm-Message-State: APjAAAV92zT6shKhWAuGDGXROW/zJiOK0KvKzz5DMknsunsWGHi3GdAX
        U/QBCNlBZu/dbfamxLIT3GBVBNocdw4iWym2y3xJY+r8ZvQ=
X-Google-Smtp-Source: APXvYqyf8H0dROBB9bvOXaLHvIe1OfTnJRLDLNL9AnIDcuNOVVLHNLEtVlUz2d1I4D3NhQ2ISu26ZnJQDRyo/JcRIiU=
X-Received: by 2002:a67:88c8:: with SMTP id k191mr3366250vsd.86.1574863141682;
 Wed, 27 Nov 2019 05:59:01 -0800 (PST)
MIME-Version: 1.0
References: <20191124195728.32226-1-stephan@gerhold.net>
In-Reply-To: <20191124195728.32226-1-stephan@gerhold.net>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 27 Nov 2019 14:58:50 +0100
Message-ID: <CACRpkdagXoVamNGj6hQ-0YQAoDpwTVOY8uUCVB8wwsXY9aQj4A@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: ux500: Add "simple-bus" compatible to soc node
To:     Stephan Gerhold <stephan@gerhold.net>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 24, 2019 at 8:58 PM Stephan Gerhold <stephan@gerhold.net> wrote:

> The "soc" node in the Ux500 device tree does not need any special
> handling - it is just a simple I/O bus that can be accessed without
> additional configuration.
>
> Therefore we can additionally describe it as compatible with "simple-bus".
> This can be used by platforms to probe devices under the soc node without
> special handling for our custom "stericsson,db8500" compatible
> (e.g. in U-Boot).
>
> Signed-off-by: Stephan Gerhold <stephan@gerhold.net>

Patch applied.

Yours,
Linus Walleij
