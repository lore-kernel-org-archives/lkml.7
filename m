Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86E14C49EAB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 09:28:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F71C21D7C
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 09:28:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WVjlcjsA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388413AbfKEJ22 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 04:28:28 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:35722 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388387AbfKEJ21 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 04:28:27 -0500
Received: by mail-lj1-f193.google.com with SMTP id r7so12273495ljg.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2019 01:28:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=F2FPfgjdbIXWdDjS0yCRl6/2h1CV4PZp64uPK2X2BNQ=;
        b=WVjlcjsAOE+e3hERSGqNCL8ugQssMBzjxA2Ol1tzpslqafskb+d2jyNqT1JD9GsOMo
         qsCQWow1BCS3ieMoh8sCB2LZw8OMmnvBYirEwVOK0hECiIXvPCK/qloP+/hGPgf7mBIW
         nGNIpW27JhXojS4uyw/a9qYmYpu4wEau1xe775jP74yD7K+PQU+DawGWaPSO4jZolhMl
         6n7hDnxoY9IKeSpOdI6474fWiZmGTcVWlgZhkPxjoPRFYxP80S927Ww00HXm1JWknfso
         QkI943Fcr72SDf9V+JOoKKVnRzqbaw5PWTIj8OaHuycQeD6GgTHdHdEHSGxza4WG1wkx
         hJwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=F2FPfgjdbIXWdDjS0yCRl6/2h1CV4PZp64uPK2X2BNQ=;
        b=aNj5P5hdiqZi4f9ygo9zWt13cLgmkR16WI2xl8UJGnxG9HPwqCtEMYIgVmgoMndmYo
         IMaDS/Pgd4HHezwLFdDU4TI7wD8hmkjZ+Pges4Ndq9a/5JvMM8/ZHzmzkU+CoVks2Dze
         Cb6jGjxOGS8RDL8v6S7fBsvMbycTawIriNRxh40bqCD+5BNuGtD9uU0jMknnoWlJ/CL1
         CubeAdDRAIC8BINNhJfwsvUYPlbEssqCC/gEJCBPMe6pDFx4QmllCPckPNVSyHgHDZp3
         EJKjLz2C7Au6tjGkj7+aoM25evhaxxLqx2LloNiFmkwW7Z25nS9piJ3aOqtTORrCxaIG
         Bxqg==
X-Gm-Message-State: APjAAAVRiJi2xklbg4B0B4MwLaEWXzspgVwOhM7JPiN05EIauCS0E7bt
        c6vMLEQ2mbI8FKCM+G4Fwen7zykYj2DgjXgwBhMFMw==
X-Google-Smtp-Source: APXvYqzkf3P4NiC+7rZsNgbXYUIcsBRDikSMDKFNsnz+OK18v4KaaK/EheFwXUjlKoFP+nppakoDlDtKmiwMGx5B9Mw=
X-Received: by 2002:a2e:9a55:: with SMTP id k21mr8803557ljj.251.1572946105330;
 Tue, 05 Nov 2019 01:28:25 -0800 (PST)
MIME-Version: 1.0
References: <20191018154052.1276506-1-arnd@arndb.de> <20191018154201.1276638-26-arnd@arndb.de>
In-Reply-To: <20191018154201.1276638-26-arnd@arndb.de>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 5 Nov 2019 10:28:12 +0100
Message-ID: <CACRpkdYDaJmd1MxmEA52Fjbh0d6Q5Vvb-Fb1SVLH-6AquxC6+Q@mail.gmail.com>
Subject: Re: [PATCH 26/46] ARM: pxa: zylonite: use gpio lookup instead mfp header
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Linux Input <linux-input@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 18, 2019 at 5:42 PM Arnd Bergmann <arnd@arndb.de> wrote:

> The mach/mfp.h header is only used by this one driver
> for hardcoded gpio numbers. Change that to use a lookup
> table instead.
>
> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Cc: linux-input@vger.kernel.org
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
(...)
> +               GPIO_LOOKUP("gpio-pxa", mfp_to_gpio(MFP_PIN_GPIO15),
> +                           "touch", GPIO_ACTIVE_LOW),

What I tried to do with code like this, when I was ambitious,
was to wind out mfp_to_gpio() as well and either just encode
the offset on gpio-pxa as a define locally.

But this works too, the kernel looks better after than before
and I am not perfectionist, so:
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
