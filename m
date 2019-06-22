Return-Path: <SRS0=kYop=UV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D8D1C43613
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 08:39:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 700D9206BA
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 08:39:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561192763;
	bh=qAXXbtnQBFmUgmRyzc4VkIcs13YQ55kQtiIfHKdMQAM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=DMw5mT8exOJ3O5kEVEPy4pKe9Tfdk1P7XGS+xrPpgmSuWGm+H7OLYDm++vFC9SXu6
	 GcwK/mU5P0U65+D44Tc1j12hVklRxnuL/z1ih7vV1wngzdkNSTbxqvEZ9RwXMc8bJW
	 XGX7nEoFfplJ2dy1AnP7mNvaGEgjtx2fGlf3ppBg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726339AbfFVIjW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Jun 2019 04:39:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:58242 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726278AbfFVIjV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jun 2019 04:39:21 -0400
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A77EC215EA;
        Sat, 22 Jun 2019 08:39:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561192761;
        bh=qAXXbtnQBFmUgmRyzc4VkIcs13YQ55kQtiIfHKdMQAM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=nAiN3KHHuh3GDHGSYzoKQ0szWAcLEKSJR8fj6S3Puih9WsIT+QnfcZDq5/yl+I0Zb
         TvVPIQYXNyxtSLhya0XjYCjcjb611p7Sc97ZU7oZtE2AkYFQH0TZ1gFUub9Eqic/Ty
         BfdpaFciV4AdK/dyKmpoAR24cWyCdvkq9q16UJu0=
Received: by mail-lj1-f175.google.com with SMTP id m23so7983634lje.12;
        Sat, 22 Jun 2019 01:39:20 -0700 (PDT)
X-Gm-Message-State: APjAAAVW/d4nQC74I5efjL4wWnGxn44Qrcriu4na50vcSOzKOB4PBVQ7
        A9Re5FdfNgAcxbWiFZASiRxUWF7F2n/57Oy1eGc=
X-Google-Smtp-Source: APXvYqxyRGkjOqMwnY3GOZOxtp7YuotqZNdcuHXzNI9tdgx7yO5ll/x9xEcbo852e3cgrZMCREphrlRE46xebyBF2zI=
X-Received: by 2002:a2e:50e:: with SMTP id 14mr56971315ljf.5.1561192759012;
 Sat, 22 Jun 2019 01:39:19 -0700 (PDT)
MIME-Version: 1.0
References: <20190621180208.25361-1-krzk@kernel.org> <20190621180208.25361-7-krzk@kernel.org>
 <CA+E=qVe45NVCfpSHRF6=0aYRpURZA4DVz8W-XkSaNDB=1mX2kA@mail.gmail.com>
In-Reply-To: <CA+E=qVe45NVCfpSHRF6=0aYRpURZA4DVz8W-XkSaNDB=1mX2kA@mail.gmail.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Sat, 22 Jun 2019 10:39:07 +0200
X-Gmail-Original-Message-ID: <CAJKOXPdk2MmBHjiDU4M6PA6O4ifVe_sDifejUPJiGPCQ7MR1sQ@mail.gmail.com>
Message-ID: <CAJKOXPdk2MmBHjiDU4M6PA6O4ifVe_sDifejUPJiGPCQ7MR1sQ@mail.gmail.com>
Subject: Re: [PATCH v2 7/7] arm64: defconfig: Enable Panfrost driver
To:     Vasily Khoruzhick <anarsoul@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kukjin Kim <kgene@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        devicetree <devicetree@vger.kernel.org>,
        arm-linux <linux-arm-kernel@lists.infradead.org>,
        linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Joseph Kogut <joseph.kogut@gmail.com>,
        Inki Dae <inki.dae@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Jun 2019 at 22:15, Vasily Khoruzhick <anarsoul@gmail.com> wrote:
>
> On Fri, Jun 21, 2019 at 11:04 AM Krzysztof Kozlowski <krzk@kernel.org> wrote:
> >
> > Enable support for Mali GPU with Panfrost driver, e.g. for Exynos5433
> > and Exynos7 (having Mali T760).
> >
> > Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> > ---
> >  arch/arm64/configs/defconfig | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> > index 6b4f5cf23324..972b17239f13 100644
> > --- a/arch/arm64/configs/defconfig
> > +++ b/arch/arm64/configs/defconfig
> > @@ -517,6 +517,7 @@ CONFIG_DRM_HISI_HIBMC=m
> >  CONFIG_DRM_HISI_KIRIN=m
> >  CONFIG_DRM_MESON=m
> >  CONFIG_DRM_PL111=m
> > +CONFIG_DRM_PANFROST=m
>
> It makes sense to enable lima for arm64 defconfig as well since it's
> used on number of 64-bit Allwinner SoCs.

I wasn't aware that some of ARMv8 SoCs still use Utgard. In such case
it makes sense indeed, I will send a follow up.

Thanks for feedback!

Krzysztof
