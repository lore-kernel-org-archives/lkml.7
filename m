Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E7F9C3A59E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 07:01:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E9CC206BA
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 07:01:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RMKm8u4a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727890AbfHUHBN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 03:01:13 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:39147 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725268AbfHUHBN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 03:01:13 -0400
Received: by mail-lj1-f195.google.com with SMTP id x4so1105667ljj.6
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2019 00:01:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=45VwxPMZ2VRTdvGcS6InzQ5jT8ovuVn5bmoUU3rlkSU=;
        b=RMKm8u4aDSYop1iSb3Gr6mPLG3mGQTPimrATSgn1UAhXY9PdU0M+EFKRzBvXhRrbk6
         cVVVYUvMuCTtBJCbNZDav1n9HZl/C3LwRD87ZuP0ua+k03/iACX2NVVP57WPfg5H6EXQ
         KB6EGLymq+dTSromI57EF3NrDGbTaHjNAHFN7bEShqfKNTy3KObSsQcHvc7CeG32O5M5
         eTtzLUu2PbiTCCntA0bCBtEM3vUuY0Jrfz5I2J8aGajQclbrZnuszRGECKEO8WW+8dR1
         jtet4kko5WNee74vzaFS+pUuYR0CUCBPLRfjPB0pqPmMgvL+b9Pf3mIpzczJxZxYUvyj
         mVAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=45VwxPMZ2VRTdvGcS6InzQ5jT8ovuVn5bmoUU3rlkSU=;
        b=FleKXPf/KaWwtUnUYaNZT/FldCLVOFZXvajexod0yIGtG7GeD3EavMpGurMeZ61LdO
         wlVHA+fKpr/CS1rJPKjAvYnRKNclyv2gqZxa2ey/hIyVGTqoOcBM6hlbEljTWylwsFX2
         a3+td5f/3UeqkVBnIVtjN1fOAXh+yJ0ilxHNnm6E+DUEs4e36twzPlWRr3jefgs+DPeF
         cl/0n7RVnQd1X0gfzqzHqxNkGoMxYkhxVu1HzBwnZsUtDHoAbGA0ft0NBK8O7TybLQBm
         +6RuAlvbHWf5tsuI7fue30OsBvB0FHyoNqweJOZpUefnSc2s3tfQDsFl1A3Xdodt955C
         M08g==
X-Gm-Message-State: APjAAAWLt/OZlzV0ivNh/i8Jxmw0MeFh/ds6HcI0Adgx9wvrCd+mwC4n
        B7OGhL157aiEnQdpGr28J3h+H3S8Wb7x+75emFzSvhrdb8Y=
X-Google-Smtp-Source: APXvYqzzxpc/KIZteudGF3ML4Pwcop+gQzvsBym8rGDx914MnhHB6d4FabwwAY98D2vLM2yvWZJMLmMX1KYPGXhN+IE=
X-Received: by 2002:a2e:80da:: with SMTP id r26mr15248039ljg.62.1566370870887;
 Wed, 21 Aug 2019 00:01:10 -0700 (PDT)
MIME-Version: 1.0
References: <20190821161620.403f663c@canb.auug.org.au>
In-Reply-To: <20190821161620.403f663c@canb.auug.org.au>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 21 Aug 2019 09:00:59 +0200
Message-ID: <CACRpkdZUpuK2fg9ASF_0z_c=9r2sk0vU5JKsje98J-Qt1aQSrQ@mail.gmail.com>
Subject: Re: linux-next: build failure after merge of the pinctrl tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 21, 2019 at 8:16 AM Stephen Rothwell <sfr@canb.auug.org.au> wrote:

> After merging the pinctrl tree, today's linux-next build (arm
> multi_v7_defconfig) failed like this:
>
> drivers/pinctrl/pinctrl-st.c: In function 'st_pctl_dt_parse_groups':
> drivers/pinctrl/pinctrl-st.c:1212:15: error: implicit declaration of function 'of_get_named_gpio'; did you mean 'of_get_address'? [-Werror=implicit-function-declaration]
>    conf->pin = of_get_named_gpio(pins, pp->name, 0);
>                ^~~~~~~~~~~~~~~~~
>                of_get_address
>
> Probably caused by commit
>
>   712dfdaf62b6 ("pinctrl: st: Include the right header")

Yeah my mistake :(

I made a v2 patch fixing the error and took this out.

Thanks,
Linus Walleij
