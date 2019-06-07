Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06C7AC2BCA1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 22:40:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2B6A20840
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 22:40:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Y1wzQSw3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730547AbfFGWkG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 18:40:06 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:35849 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729345AbfFGWkF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 18:40:05 -0400
Received: by mail-lj1-f196.google.com with SMTP id i21so3061544ljj.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2019 15:40:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2He8fM7kcXQfsornTR9w4EIW8ewTHe/YWrAox5h8fVA=;
        b=Y1wzQSw3xyLXOije8DwbtzUeT40ID/RB3K6j9lA9ycHeOawwFiOB2UGDToQY9iptd8
         qdB0PTbgAPUdAs5j6OGLikt0UDPGJVvwRx3MQrFm1sa/4ive4N+MZEH1ZdRZkWTj7jan
         Ea4lmsPTV1MmZvUaLuyQ+1N202QQE1+a5jt06n7dyjTuxVkLeGD862oU7Yv/bwPfI6Ek
         /0wcCoDdB4M+BU3QmL1/uR/m3vbdS1Xuj9DKutHK5+rObzRUXA/CJBp+n7yQU+Lsvz5R
         vbfHWFBswsWYELI4G8Akq5VXlkm870a6aSKiOWw2ejytuYdUkwWGVItwc6Dc/nd3xNkF
         S0/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2He8fM7kcXQfsornTR9w4EIW8ewTHe/YWrAox5h8fVA=;
        b=YZdHpRwErqDMol1Us1i1+fbjmd2MCyXGq9d8myByO8NOE5KhrJj8fG57+M+PQGwFjW
         RcINRwduT32mkgURYzOvlnZFkiR2+YZ8dKqqqZ7Ah0iAZK7g4snYyhtzqffQDiW2fgnJ
         A4G2rV7zz31DrxMLfLuQmRGM5r77jLxcyg+Y7q61buYdhVMhHgN1IhfnuFUZ5Vep8bvv
         AhCxr8bhbGKxVwkGVZKc+Dxe65P6j4HEO02nMFebdHRZ+ziHZM91fK4SBPNEK4n7RNh6
         b9ip2bvaqPxlWKgh9dGShJC8ggRMUowxhbwaZsoPR74jom1wARkhdxDx+G+M6oZ5y/hn
         nvJQ==
X-Gm-Message-State: APjAAAW4U+ms63rVCD7AJpmBxO6KmzAUrhIQ2f7rv44mhIkkaemue3CP
        b3RiIzdt1p30jnKXHG7+rjWjAbEmO6S54SuM8n7j2v2B
X-Google-Smtp-Source: APXvYqx/VwNEsPm3ayxAU3renmpKyYQsiC7r4U3mSDqbHCSnM+jZ3lPRwPTRSWn4x0qqtNvr8hw2rES8YOA2GkaI/gY=
X-Received: by 2002:a2e:9e85:: with SMTP id f5mr23363303ljk.104.1559947203348;
 Fri, 07 Jun 2019 15:40:03 -0700 (PDT)
MIME-Version: 1.0
References: <20190606095620.6211-1-j-keerthy@ti.com> <20190606095620.6211-2-j-keerthy@ti.com>
In-Reply-To: <20190606095620.6211-2-j-keerthy@ti.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 8 Jun 2019 00:39:55 +0200
Message-ID: <CACRpkdY-yK3+uZvq1Xk7qJ2Nd7mgRkQ9C22AYO4AiZP5Cs719w@mail.gmail.com>
Subject: Re: [RFC RESEND PATCH v2 1/4] dt-bindings: gpio: davinci: Add k3
 am654 compatible
To:     Keerthy <j-keerthy@ti.com>
Cc:     Tero Kristo <t-kristo@ti.com>, ext Nishanth Menon <nm@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 6, 2019 at 11:55 AM Keerthy <j-keerthy@ti.com> wrote:

> The patch adds k3 am654 compatible, specific properties and
> an example.
>
> Signed-off-by: Keerthy <j-keerthy@ti.com>

Patch applied with the three others, so now all
GPIO changes are in tree.

Please funnel all the DTS changes through ARM SoC.

Yours,
Linus Walleij
