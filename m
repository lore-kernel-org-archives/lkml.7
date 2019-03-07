Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B217BC43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 15:30:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C5B620643
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 15:30:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="X+BPx5uH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726626AbfCGPae (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 10:30:34 -0500
Received: from conssluserg-04.nifty.com ([210.131.2.83]:41463 "EHLO
        conssluserg-04.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726207AbfCGPad (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 10:30:33 -0500
Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id x27FUQt4008577;
        Fri, 8 Mar 2019 00:30:27 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com x27FUQt4008577
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1551972627;
        bh=VXjijWoWOc6nm2L+VzQ8XNss08/fJzXp8GPB0vQesmo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=X+BPx5uH+HXV5HukExH1Zbq1M6Kd+KzNBg7nr96fTAkFPyY6d7XWyo5FLXIQupsS3
         Fq+CriOCO0cEwaSdXO3MxZdrAguI5oND8dalMSA5pmaH6Hxg2cClQtxImlkao1OEKv
         mS3d/W0hDmX75qME9b6hdPxzYdwLaoH49rXn/pswLPf+Z8UL5QPZtgS7EIjmvZF688
         IQLHEN+komIZ+xlRnh8i2iKTZhUAYsZR0P8t7vL3rA3y+f4DHJvzVReK/NZFVLhDmJ
         wAYdXQUrw/LKWq6JY+kTvYFq2CUq9noZr6GYE8jV3iRbrUrcpStTg0lUpsO3Mm8kJ3
         rjKmNeODfInbQ==
X-Nifty-SrcIP: [209.85.221.179]
Received: by mail-vk1-f179.google.com with SMTP id l136so3801542vke.2;
        Thu, 07 Mar 2019 07:30:27 -0800 (PST)
X-Gm-Message-State: APjAAAU9AZJftJBwltt+8ltNPKDO68pfnwWc611BEW1Kji0mBti9RYYv
        iwDlsNtYllIfCuqJmuKJoJx09CzCV/g9PeD4xSY=
X-Google-Smtp-Source: APXvYqx1yNVOQIvYca3gZU49ofvTXoxYby+kKCG1F0giNcDNnL6LITTxY/HXOFGAiJPHypzkq/LRGgw5+wuPnr3nrU4=
X-Received: by 2002:a1f:9350:: with SMTP id v77mr6207401vkd.84.1551972626100;
 Thu, 07 Mar 2019 07:30:26 -0800 (PST)
MIME-Version: 1.0
References: <20190221215901.23970-1-ar@cs.msu.ru> <20190221215901.23970-3-ar@cs.msu.ru>
In-Reply-To: <20190221215901.23970-3-ar@cs.msu.ru>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Fri, 8 Mar 2019 00:29:50 +0900
X-Gmail-Original-Message-ID: <CAK7LNATez-USGytbyEG=So47JQPGvsJOSqd==q6MuBoj9DJTFw@mail.gmail.com>
Message-ID: <CAK7LNATez-USGytbyEG=So47JQPGvsJOSqd==q6MuBoj9DJTFw@mail.gmail.com>
Subject: Re: [PATCH] scripts/package/mkdebian: expose KCONFIG_CONFIG to debian/rules
To:     Arseny Maslennikov <ar@cs.msu.ru>
Cc:     Michal Marek <michal.lkml@markovi.net>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ben Hutchings <ben@decadent.org.uk>,
        Riku Voipio <riku.voipio@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 22, 2019 at 7:21 AM Arseny Maslennikov <ar@cs.msu.ru> wrote:
>
> If KCONFIG_CONFIG is passed to `make deb-pkg` as a makeflag or
> environment variable, the source tarball produced contains whatever
> specified by that variable instead of the usual `.config'.
>
> While `make deb-pkg' yields a correct Debian binary package (at least
> on amd64), the generated source package's debian/rules does not pass
> KCONFIG_CONFIG to make(1), thus rendering the source package unable to
> be rebuilt.
>
> Steps to reproduce the kind of failure being fixed:
> 1)  Produce a source and binary package with:
>         % KCONFIG_CONFIG=my.config make deb-pkg
> 2)  In the parent directory:
>         % dpkg-source -x linux-*.dsc
> 3)  In the unpacked source directory:
>         % debuild -i -us -uc
>
> Here is an excerpt from an example output of `debuild -i -us -uc':
>
> make[2]: *** No rule to make target '.config', needed by 'kernel/config_data.gz'.  Stop.
> make[1]: *** [Makefile:1043: kernel] Error 2
> make[1]: Leaving directory '/home/ar/linux-kernel/deb/linux-5.0.0-rc5-tks-gitd6ff78479ec5-57-5.0.0-rc5-tks-gitd6ff78479ec5-57'
> make: *** [debian/rules:4: build] Error 2
> dpkg-buildpackage: error: debian/rules build subprocess returned exit status 2
> debuild: fatal error at line 1182:
> dpkg-buildpackage -us -uc -ui -i failed



I am not convinced with this patch.

People would be upset if they got a source package and
they  did not find the .config in the standard location.

It is difficult to notice the .config has been moved
to somewhere until they check debian/rules.

Why do we need to create such a strange package?





> Signed-off-by: Arseny Maslennikov <ar@cs.msu.ru>
> ---
>  scripts/package/mkdebian | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/scripts/package/mkdebian b/scripts/package/mkdebian
> index edcad61fe3cd..130d3f6696eb 100755
> --- a/scripts/package/mkdebian
> +++ b/scripts/package/mkdebian
> @@ -207,10 +207,12 @@ cat <<EOF > debian/rules
>
>  build:
>         \$(MAKE) KERNELRELEASE=${version} ARCH=${ARCH} \
> +       KCONFIG_CONFIG=${KCONFIG_CONFIG} \
>         KBUILD_BUILD_VERSION=${revision} KBUILD_SRC=
>
>  binary-arch:
>         \$(MAKE) KERNELRELEASE=${version} ARCH=${ARCH} \
> +       KCONFIG_CONFIG=${KCONFIG_CONFIG} \
>         KBUILD_BUILD_VERSION=${revision} KBUILD_SRC= intdeb-pkg
>
>  clean:
> --
> 2.20.1
>


--
Best Regards
Masahiro Yamada
