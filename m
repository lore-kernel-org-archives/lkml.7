Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 966FDC2BCA1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 22:34:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 635542067C
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 22:34:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bQ/s3UvM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731315AbfFGWe5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 18:34:57 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:36562 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728636AbfFGWe5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 18:34:57 -0400
Received: by mail-lj1-f193.google.com with SMTP id i21so3054483ljj.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2019 15:34:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nW0bDnX2DQlTyj4Jt+f94n5VzhS3xOLy/lYulpcwYpU=;
        b=bQ/s3UvM1gpkOgw6oJOO6WR5fpsFQK1G2TT3rzk1g1TVNvBIqMDVF2rcJ0UWuNttOa
         /SQ44Q1xb2hxWLHviBlyVzA9WfegStlQnFoWiHNj72H/NHPnAFO6Ja7TY39vV+erg4nF
         VhVjTTLrwbTqCnMhEP6htB5X3MEh5MpbKYOHOa6RbSZriYeXWTLkcpMJFjAUD0U5mAf5
         VGfSVUlO8r19MOOrLso+N2laLGnuYkFmoHThxOEcVtOSGq7i9J5GZ5v59ADy2yAMDsYi
         Ys2OR/Rxc4lwxBvyWjfi+6pd3LbBrLpvvoue5UOvqsjAzkZAy4by/qVJgNh3rwwE8lT3
         rQvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nW0bDnX2DQlTyj4Jt+f94n5VzhS3xOLy/lYulpcwYpU=;
        b=e+WESyCgvyZAJvn4L5jW+rD4TiOwF8CbaFxnHqD0JeJH2xaIT0eF3BIfDlVpVOpg9u
         Ns0ivCzmkoPGFXaHqUlIrFt7ZPZDHtxRux6iBgwveePsuqVilOywIFxniphR7BpW+DJi
         eESODZoGKPSOvk1Mwlyoe7bIIPq8TLqKBDOAR3sKTwk8lfpQlbdLNrHdSvPWrVVGsQ7f
         qB0l4l75j6v5PXQFJR1LM2hO/c2TGVd4IxAvN0NZ3I4qvYZU9shsr2uhBz8ZYfA5zfeg
         LEus23rGmc5hZ9xrSQ44M0lECck91XxYRHD6fVocasTEslJ+Jx9B6CyJ2Ttnnna5LtGz
         4TIw==
X-Gm-Message-State: APjAAAVPdkDdQLsA+7DSeiImuaCfgWN5M0N9V1k5b4opMkbsqCDWD/GQ
        odLfUbFSEV4NUSFV5sYegOAIJG2gO8kQBfymntY6iA==
X-Google-Smtp-Source: APXvYqxMCb0vA3vj3mu0UoNjzO8mL1x4/owcy7EV8Z0WD3Eiw9+wP0XjsbZ3PKWkGdz/dl89R+zKZ7M30JBxzwFQJ6M=
X-Received: by 2002:a2e:5bdd:: with SMTP id m90mr19934399lje.46.1559946895470;
 Fri, 07 Jun 2019 15:34:55 -0700 (PDT)
MIME-Version: 1.0
References: <20190605080259.2462-1-j-keerthy@ti.com> <20190605080259.2462-2-j-keerthy@ti.com>
In-Reply-To: <20190605080259.2462-2-j-keerthy@ti.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 8 Jun 2019 00:34:48 +0200
Message-ID: <CACRpkdYe4L3MAG3sFAnpdELp7FNB6kqMDCv8xt4E5h77N=rLxQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] gpio: davinci: Fix the compiler warning with ARM64
 config enabled
To:     Keerthy <j-keerthy@ti.com>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Tero Kristo <t-kristo@ti.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 5, 2019 at 10:02 AM Keerthy <j-keerthy@ti.com> wrote:

> Fix the compiler warning with ARM64 config enabled
> as the current mask assumes 32 bit by default.
>
> Signed-off-by: Keerthy <j-keerthy@ti.com>

Patch applied, I think this and patch 2/3 work fine
together as-is.

Yours,
Linus Walleij
