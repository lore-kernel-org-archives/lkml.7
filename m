Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 985BFC072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 11:38:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E84D2184B
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 11:38:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LUaBU+oQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391188AbfEXLia (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 07:38:30 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:35637 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390743AbfEXLi3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 07:38:29 -0400
Received: by mail-qk1-f195.google.com with SMTP id c15so6990146qkl.2
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2019 04:38:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0lxiGmWfLgl7C0PUBf51UY66oylRUCwuW2L386gQxFM=;
        b=LUaBU+oQ+7tPBoX/UMmq0HZGaNUxbnS4Li9ZC0bSZJ7gQ9i5S9z2Y2TGSJQ60X+Bki
         37KF1sRvhwYU42JBaxNqk4Eqn1GJayVPYODxe20VQIWSzDpMqbh8MJjp45HbKdJcc1vk
         pnjeuZ5OvGdmGOhbaC44nP2tbXRRQOb1mJWvYKyEjDAEl1Obt6lZ/G7NI6GmNocDUBRK
         2Xr0SjpwW4FnOuCvKUVeEXnWXj740GTgprlcCV47PSyFUBMbMBeFQPZXHLO+psfn24Hu
         NfEsR+Js97tD3PQlVq9YDIiPVtP070m/YuQ6Y40B3Z9p3A1JaaI75CbnbuN8ANVi+udN
         mNKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0lxiGmWfLgl7C0PUBf51UY66oylRUCwuW2L386gQxFM=;
        b=Xz1kRTB4H6tPJHH3Uj+FjgIHM9SFS/2gfYewSApIvdNApUB8rQ/AhztmAh5eurbQGq
         8aHOmZPXgqUJheLCMsZY1BA54wd6tNm2zu+vqvJQHnBZ35b8juE1+mZXc5tfNDSRzsjB
         YIlN3epxDMZ8BNRT+3MhzZrLvYSYTQVDUmkxI1anzOYkcOVTVeooCiXL9Yaw6GUl2Dox
         DPu1ZnXDl/BNP3xftUiBulqEdmVVLvrsMGe9IhINcDWZYello46a1dSEfjac6CUI7omL
         it0LgNttG6B5nYhGsEG4PrJ9RCUphhQb9iXec6yR/gViXP3sAAK9EL9mK5Z0yi9emQAT
         /EFA==
X-Gm-Message-State: APjAAAUZV4fLtgn+oNSL0rPeTRUGHhjtwvw4itt57wX+dL5PaB4yzKa7
        ttb8c/N9nTLrP3MG1F/9v82kOJ9pk3dORQh8zOJSkNZM
X-Google-Smtp-Source: APXvYqwgX2PLA0fSXA7p0azFhUSmOAckdqbzgNqBifI/FEQSkUa/r3EhD7hLuBNm+vM7K0FXzlsJhhdkDC52rf3oPlA=
X-Received: by 2002:a37:b287:: with SMTP id b129mr70960448qkf.20.1558697909058;
 Fri, 24 May 2019 04:38:29 -0700 (PDT)
MIME-Version: 1.0
References: <20190514005033.15593-1-robh@kernel.org>
In-Reply-To: <20190514005033.15593-1-robh@kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 24 May 2019 13:38:17 +0200
Message-ID: <CACRpkdZabT3_vjkv0PR+GLC0ZXWzpMxfwJU6O9Y+omKJ=6zCaA@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: gpio: Convert Arm PL061 to json-schema
To:     Rob Herring <robh@kernel.org>,
        viresh kumar <viresh.kumar@linaro.org>
Cc:     "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 14, 2019 at 2:50 AM Rob Herring <robh@kernel.org> wrote:

> Convert the Arm PL061 GPIO controller binding to json-schema format.
>
> As I'm the author for all but the gpio-ranges line, make the schema dual
> GPL/BSD license.
>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> Cc: linux-gpio@vger.kernel.org
> Signed-off-by: Rob Herring <robh@kernel.org>

Patch applied. As you know I am already a big fan of this scheme.

> This warns on a few platforms missing clocks, interrupt-controller
> and/or #interrupt-cells. We could not make those required, but really
> they should be IMO. OTOH, it's platforms like Spear and Calxeda which
> aren't too active, so I don't know that we want to fix them.

What works for you works for me.

We could add dummy fixed clocks in the DTS files if
we wanted I suppose. The #interrupt-cells and interrupt-controller
things we can just fix, but I wonder what the maintainers of these
platforms are up to? Isn't Calxeda yours, and could Viresh fix
up the SPEAr?

Yours,
Linus Walleij
