Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5CDFC43613
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 21:01:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3A1821530
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 21:01:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mnnK/RC5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726129AbfFUVBe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 17:01:34 -0400
Received: from mail-yb1-f196.google.com ([209.85.219.196]:40600 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725992AbfFUVBd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 17:01:33 -0400
Received: by mail-yb1-f196.google.com with SMTP id i14so3205186ybp.7
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2019 14:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pSX96sM10spT9GCGhKGP6T0HRGkaamy9kXn0AhO6OpQ=;
        b=mnnK/RC5tvWJlKJ/B22Unej4mg4lye4l3Sd5mF9TCZlrGiCVTskGE4Zd0b7sszz9AF
         fJJP2mrh0TCOa2wVfS3NS3at+qHRCZNxgLDOecsYHiXO9tCIWUHaq1d+Cqm+Olr3FvQZ
         uaSElwbeFVo8Qjd9jiOsV2wHSDgEfTjmcxrIk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pSX96sM10spT9GCGhKGP6T0HRGkaamy9kXn0AhO6OpQ=;
        b=HbEsJrGJ/GIu68nbVmQsn68vRZYGoZ76ESkvX+K81uSOxLLnZ1WqfzoFuMWizoAx91
         o3MgcqXR5dToky1Ln/bcbFwCQQGV8MZMBaeTJmAAmthKN5twnN0I+X2strXn9+G/I3HR
         KuFecJMDRVGbafeHqoP+sRxGEDxhVEhGZOYP/ay5L0VgqC4ppkOuTUfVhXO2cGCmg7+M
         xdVLN8FTfrcdsiTTrxT7vjumLNwRJ05cGUFsJgSaS4LD2j53mRZzikeIUjBNTJYLWUAh
         JriMJEl2OH63z8eGr2PHXviN6yB40R4s/mZpA7TBAFZ6v8Gn/1oqCEFO1FD8o82aBbht
         f2dg==
X-Gm-Message-State: APjAAAUb+BJTnW27FT9w05Ii3JYoIbqC3JbNSVZMgGfE/xZH5dCAME0F
        OMc/u4HiEvExDcuKIni+zDdkwb8KzwY=
X-Google-Smtp-Source: APXvYqzx7k1XhvmGFQMSTTboxXU3Q89lA/1u5JBsgBx6uSv0IzQr6/oHkV47R2QZRLR7eZf+OLwS1Q==
X-Received: by 2002:a25:d310:: with SMTP id e16mr1824349ybf.10.1561150892249;
        Fri, 21 Jun 2019 14:01:32 -0700 (PDT)
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com. [209.85.219.179])
        by smtp.gmail.com with ESMTPSA id n64sm904057ywe.76.2019.06.21.14.01.31
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Jun 2019 14:01:32 -0700 (PDT)
Received: by mail-yb1-f179.google.com with SMTP id 189so3212005ybh.4
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2019 14:01:31 -0700 (PDT)
X-Received: by 2002:a25:9704:: with SMTP id d4mr68039393ybo.312.1561150464251;
 Fri, 21 Jun 2019 13:54:24 -0700 (PDT)
MIME-Version: 1.0
References: <20190620003244.261595-1-ndesaulniers@google.com>
 <20190620074640.GA27228@brain-police> <CAKv+Gu_KCFCVxw_zAfzUf8DjD4DmhvaJEoqBsX_SigOse_NwYw@mail.gmail.com>
 <CAKwvOdmQ+WdD8nvLz_VB_5atDi56fv485Xsn+mHJZKnyj6L-JA@mail.gmail.com>
In-Reply-To: <CAKwvOdmQ+WdD8nvLz_VB_5atDi56fv485Xsn+mHJZKnyj6L-JA@mail.gmail.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Fri, 21 Jun 2019 13:54:10 -0700
X-Gmail-Original-Message-ID: <CAGXu5j+aihyZWUUTTxweXxEMfgL12HULqNhHj_mUedLefFrcLA@mail.gmail.com>
Message-ID: <CAGXu5j+aihyZWUUTTxweXxEMfgL12HULqNhHj_mUedLefFrcLA@mail.gmail.com>
Subject: Re: [PATCH] arm64: defconfig: update and enable CONFIG_RANDOMIZE_BASE
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Jeffrey Vander Stoep <jeffv@google.com>,
        Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Olof Johansson <olof@lixom.net>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Arnd Bergmann <arnd@arndb.de>, Shawn Guo <shawnguo@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 21, 2019 at 1:28 PM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Thu, Jun 20, 2019 at 1:17 AM Ard Biesheuvel
> <ard.biesheuvel@linaro.org> wrote:
> > I think it is mostly controversial among non-security folks, who think
> > that every mitigation by itself should be bullet proof. Security folks
> > tend to think more about how each layer reduces the attack surface,
> > hopefully resulting in a secure system when all layers are enabled.
>
> + Kees, Sami, Jeff
> It's a relatively low cost part of our defense in depth strategy.
> Maybe (Kees, Sami, Jeff) have more thoughts?

Right -- the thought is that it provides more benefit than
complication. It is hardly a perfect defense, but it does provide
building blocks to more interesting situations. For example, once
execute-only memory is more common, KASLR + XOM means there is a not
insignificant defense against automated ROP. And KASLR is a general
precursor to fine-grained KASLR (i.e. randomizing on function).

> > So KASLR is known to be broken unless you enable KPTI as well, so that
> > is something we could take into account. I.e., mitigations that don't
> > reduce the attack surface at all are just pointless complexity, which
> > should obviously be avoided.
>
> (Note to Sami + Jeff if they had KPTI on their radar)

I prefer that KPTI always stay enabled. :)

> > Another thing to note is that the runtime cost of KASLR is ~zero, with
> > the exception of the module PLTs. However, the latter could do with
> > some additional coverage as well, so in summary, I think enabling this
> > is a good thing. Otherwise, we could disable full module randomization
> > so that the module PLT code doesn't get used in practice.
> >
> > Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
