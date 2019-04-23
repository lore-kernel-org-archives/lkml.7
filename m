Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E246C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 10:52:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42F30206A3
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 10:52:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uHUxSxzu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727483AbfDWKwT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 06:52:19 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:35137 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726150AbfDWKwS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 06:52:18 -0400
Received: by mail-lj1-f195.google.com with SMTP id t4so13062437ljc.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 03:52:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jjHJWj5FeXe18WchV2bn8F7Pb/3Z1VsLWjcSEKmeIAU=;
        b=uHUxSxzuPKxxVAA87jIdgcZeG2i8ehbZ5AKsl7ok4ibVNub+BR7/bfbP6XrHYLG57T
         +A7T9Dr3dk5ZAzaCGoXAYQxdXyMXYuzQLD3ZpF2yOi8VvbH5i3H14nFBlc9Gm/CVkVCQ
         GFjSCbIU8WkGFKyWURIa4HpSI52+nTmpV3DX9M3ycnsQqJ72jL5Bh0e850P0TobJTb3r
         3RxPG5h65NnLGeMDUM3Q1HINi2OTlTzjSKIWlazhkyWF5k7q0EjrmosSf+tKg2ZHSymR
         Q1CUzOrwOD9FCUbbBj/MiooXltXWCgYw/r6BBHTEIVh69jERNersfFGN8ifxnJhKeIxT
         b5Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jjHJWj5FeXe18WchV2bn8F7Pb/3Z1VsLWjcSEKmeIAU=;
        b=bizF/5pGlib7tIAsVSUcRFSEWmQnBn27vNkSAugRa0X2g3BCHRdtkl+Cb+EbDH2kK7
         Uahtv2ivnHzq0aVXLsphtjAR+tBpLqeep4q5w154OOdt5wsIaBkaCCnqX7agXoovhpxP
         seWfwhQUwC1S4S2Or3IqK57pr+BDIvjNKeyirdrsnFuM3DyxKWXEVePYQ2EExQdg7jxl
         EyeInfu6fR5JM3RqRIOqR5kOmqHOhAeci5Qvm0hrClwD/JYrqhSB9L4Q9EFDN/UmeZgh
         KCaVIpFDe1X3S54rr41lYsoDcLi61jPs5YPWJBkkpM0sRENVPOnD7fiPlKWBrwrg+Ce8
         NcNw==
X-Gm-Message-State: APjAAAXiYA4YfaiVqSNoxUAIvtbXB/AeR4+x32b5Lah9Agp0qVaOiBe+
        zhc2/0xkFVmzkVJdk4O6GU1W94x8cp/Yv21FYJ35ww==
X-Google-Smtp-Source: APXvYqwMt5uT1pB7M8THZUlaySgjL6nMPPyMuWushg7nGzWH2zl+JqyBRVsNZIanc80nK4eKsAUkFlYxgigeOTc4Qww=
X-Received: by 2002:a2e:834d:: with SMTP id l13mr13669579ljh.97.1556016737041;
 Tue, 23 Apr 2019 03:52:17 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1555382110.git.mchehab+samsung@kernel.org> <0f2d522a80f96391d3f7b51389d08b4afaedb618.1555382110.git.mchehab+samsung@kernel.org>
In-Reply-To: <0f2d522a80f96391d3f7b51389d08b4afaedb618.1555382110.git.mchehab+samsung@kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 23 Apr 2019 12:52:04 +0200
Message-ID: <CACRpkdYQeEoyE9sAAo2KZjurx9sH4w+bzM-_-_h6U4w7PeX7eg@mail.gmail.com>
Subject: Re: [PATCH 15/57] docs: gpio: convert it to ReST
To:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 16, 2019 at 4:56 AM Mauro Carvalho Chehab
<mchehab+samsung@kernel.org> wrote:

> The API described at sysfs.txt is deprecated.
>
> Still, as it is still part of the Kernel (and will likely be
> there for some time, as we don't simply remove APIs). So,
> it makes sense to keep it there.
>
> The conversion of this file is trivial.
>
> Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Mauro will you merge this or do you want me to merge it?

Yours,
Linus Walleij
