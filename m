Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6169CC28CC0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 20:03:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2004D2613E
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 20:03:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DsivkJw4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726483AbfE3UDB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 16:03:01 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:41234 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725897AbfE3UDB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 16:03:01 -0400
Received: by mail-pl1-f194.google.com with SMTP id s24so2857645plr.8
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2019 13:03:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2lPLzJqwQdUonah81Fn0G8uV1MZBo0Fm5r4V6VKVMeI=;
        b=DsivkJw4Es6HQ8KD0K6NSaNjC7uhT1ySFBNA95Y6sB2TL5kg2RvKja64s9ElqBf9v9
         VVfUBo9J8jeG1+swJxmkGuYj30DGUAWJxzzSe8TLw8asAFPkKkZxffmpht2HOV77jxDt
         XQ5rT8divYDsU8knMwFWp/nFWYqAy8JqGN6C84pV5b48/vdxCAADvumuvUQpSUnNI951
         mVxXLZPilvpLT68Gbv6gm7dcs2SYLGyNz87YatKrPS9hSlp0jOpxTGJ4wmUa27O6HnLt
         FbnerE9PgmUixmUHG6v2ISrnpz8CQLNsigd78n0J/YYzS3cF8LM7DtDbLPgH+C60sExP
         71IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2lPLzJqwQdUonah81Fn0G8uV1MZBo0Fm5r4V6VKVMeI=;
        b=HnFoGprHbVimBr3vXjgWTBSfRhs+IOYN/5txDm1SGU9OLW/UVRV+R2NQxtbIKy/UtW
         kQmwlBcUGsyercTFxjuvjRpM0RPdVpqHXuIfC8KRVeyM3UVNkXY5+qQZDFI8KWpbYeLe
         R337v3mOr0iZ96Z3ZzxLQmGOmByeRlZNYtxvaiPof3GiaHV5br06Sbyx0jb9gFoLZi9J
         iAXGDBygBFs6zVgQnY2KA6y8sFyq7OevvTqtlxRPeJKF/TzHwO+OYOyJah6rzsFzb1Xq
         34rhstMzSEkGDIUPBqwuLQIRxjgR9RE+LcW9O2fKfTSwUbD1tOMeFvSjooCLIFC7j1hd
         RZ+g==
X-Gm-Message-State: APjAAAXAwMNmoEeEdX7dvLGQaolEyeAlah8uJHKpL2LlsYi+M/WXoDmP
        xOBHDegGDnttcWtjoj0H7O9PIsiMlz/KQXqdIhv6QA==
X-Google-Smtp-Source: APXvYqxSJo2SxIYJJUhtNH89Bhxn6pFLZCQcs8teWV7dX2XsDdeokVaG8wMWOWSWrhw2oHDNkWQNsKqpflGfHxu+LcY=
X-Received: by 2002:a17:902:b944:: with SMTP id h4mr4486763pls.179.1559246579947;
 Thu, 30 May 2019 13:02:59 -0700 (PDT)
MIME-Version: 1.0
References: <c0ca465daa7c7663c19b0bcb848c70e8da22baff.1558996564.git.stefan@agner.ch>
 <5ead0fe96f7e5729e4a82f432022b16cb84458a6.1558996564.git.stefan@agner.ch>
In-Reply-To: <5ead0fe96f7e5729e4a82f432022b16cb84458a6.1558996564.git.stefan@agner.ch>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 30 May 2019 13:02:48 -0700
Message-ID: <CAKwvOdmsHxyPU2O1vZ-Mah-E5vTtEWKHStp2EQCiE4A55D8xDQ@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] ARM: OMAP2: drop explicit assembler architecture
To:     Stefan Agner <stefan@agner.ch>
Cc:     arm@kernel.org, Olof Johansson <olof@lixom.net>,
        Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Robin Murphy <robin.murphy@arm.com>, nico@fluxnic.net,
        f.fainelli@gmail.com, rjui@broadcom.com, sbranden@broadcom.com,
        bcm-kernel-feedback-list@broadcom.com, kgene@kernel.org,
        krzk@kernel.org, Rob Herring <robh@kernel.org>,
        ssantosh@kernel.org, jason@lakedaemon.net, andrew@lunn.ch,
        gregory.clement@bootlin.com, sebastian.hesselbarth@gmail.com,
        tony@atomide.com, Marc Gonzalez <marc.w.gonzalez@free.fr>,
        mans@mansr.com, Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 27, 2019 at 3:41 PM Stefan Agner <stefan@agner.ch> wrote:
>
> OMAP2 depends on ARCH_MULTI_V6, which makes sure that the kernel is
> compiled with -march=armv6. The compiler frontend will pass the
> architecture to the assembler. There is no explicit architecture
> specification necessary.
>
> Signed-off-by: Stefan Agner <stefan@agner.ch>
> Acked-by: Tony Lindgren <tony@atomide.com>
> ---
> Changes since v2:
> - New patch
>
> Changes since v3:
> - Rebase on top of v5.2-rc2

Hi Stefan, looks like both patches are ack'd.  Are you waiting for an
explicit reviewed by tag to submit to
https://www.armlinux.org.uk/developer/patches/?

-- 
Thanks,
~Nick Desaulniers
