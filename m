Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADACFC10F14
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 07:40:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C89120815
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 07:40:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CjfB28DM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728303AbfJCHkx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 03:40:53 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:38693 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725497AbfJCHkx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 03:40:53 -0400
Received: by mail-lj1-f195.google.com with SMTP id b20so1529049ljj.5
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2019 00:40:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=E7iqFe1lhn8LdVCxH7rgleIidp2/4wVxSz9as/XPLSU=;
        b=CjfB28DMRCqGQ++ofQBR0em6Kgtij9ayqHRRVD7m/As54ZH4FBQpZ14boAO5HnGqkR
         sAjU8jX8jETg5g6za2V3pd/MT1a09N58Wo/2WDdURo/zHLYH5ckEFHPWp5O2Gqxt+9pa
         UY4g5m+O0Z65ChGAr6wOP4T7JXFL4DXjRpI2UJ8AwKv+F6Iffpikg52L1+iwwJKL7gQX
         PUt5HQoUO7929q0IwmWtbhEG3dbbmTCT2i3UbmbiqUNtbz7aYWBs5MOJu+c3tcjwWGBX
         gLhaQt3y2tjryDIy4u4SmCyrIDvzYpmwBcPy51x7ncF6VzYSYhzp7mHQOGyuK6Wkru3Q
         It5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E7iqFe1lhn8LdVCxH7rgleIidp2/4wVxSz9as/XPLSU=;
        b=qwlyHIxXL9puZ+lkg0yDoXvlXaXJCR0L6/Kr5FkF691KEIPE3mh53AFy0zI3PKxSQ7
         Q2G0oEompHMnIacC1bQdo0rOMAFM5Wj+AYn+i9g+Ribvsohc3CYF6k+XvYLGAjODL4ou
         216fu0TxX804SQVbcFbIAzo/Xh/rpwn2qWkCIf/ZeaqQ42VczSDA5Q9LprZ2Qgx8oO3+
         jnmg/H25UaAtYp++1jGoXeQQNtJWIPaXIKK3C1m2oTau0RYvL/agw/uqNb7RjI+DwYJT
         8LOt19XrzgnP7baWqaE4IzVRqRWZBL716X2p5auDdFW1fK+6fY0J1eFgSOi/tEUFn1wx
         gELQ==
X-Gm-Message-State: APjAAAXxAa+3k46FDnb5Q02l733kqBL71HYjssGZQ0B0uRrK8Brux+Yk
        A/FHltnyuTeR1IJJRyJSA+oNzV0oinUhf6AW+BEOtg==
X-Google-Smtp-Source: APXvYqwZknb69/TYERw7YCBTe+s8V/JXOBxcZNJEdeGG35NyM+62662ZhUSQhFi5nm0jtPXJNq/2DOQgLPo1HLs58rY=
X-Received: by 2002:a2e:530d:: with SMTP id h13mr5131568ljb.109.1570088451104;
 Thu, 03 Oct 2019 00:40:51 -0700 (PDT)
MIME-Version: 1.0
References: <20190926193030.5843-1-anders.roxell@linaro.org>
 <20190926193030.5843-5-anders.roxell@linaro.org> <bf5db3a5-96da-752c-49ea-d0de899882d5@huawei.com>
In-Reply-To: <bf5db3a5-96da-752c-49ea-d0de899882d5@huawei.com>
From:   Anders Roxell <anders.roxell@linaro.org>
Date:   Thu, 3 Oct 2019 09:40:40 +0200
Message-ID: <CADYN=9LB9RHgRkQj=HcKDz1x9jqmT464Kseh2wZU5VvcLit+bQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] arm64: configs: unset CPU_BIG_ENDIAN
To:     John Garry <john.garry@huawei.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 Oct 2019 at 16:04, John Garry <john.garry@huawei.com> wrote:
>
> On 26/09/2019 20:30, Anders Roxell wrote:
> > When building allmodconfig KCONFIG_ALLCONFIG=$(pwd)/arch/arm64/configs/defconfig
> > CONFIG_CPU_BIG_ENDIAN gets enabled. Which tends not to be what most
> > people wants.
>
> Today allmodconfig does not enable CONFIG_ACPI due to BE config, which
> is quite unfortunate, I'd say.

right.

>
> >
> > Rework so that we disable CONFIG_CPU_BIG_ENDIAN in the defcinfig file so
>
> defconfig

thanks.

>
> > it doesn't get enabled when building allmodconfig kernels. When doing a
> > 'make savedefconfig' CONFIG_CPU_BIG_ENDIAN will be dropped.
>
> So without having to pass KCONFIG_ALLCONFIG or do anything else, what
> about a config for CONFIG_CPU_LITTLE_ENDIAN instead? I'm not sure if
> that was omitted for a specific reason.

Oh, I tried to elaborate on the idea in the cover letter, that using
the defconfig
as base and then configure the rest as modules is to get a bootable kernel
that have as many features turned on as possible. That will make it possible
to run as wide a range of testsuites as possible on a single kernel.

Does that make it clearer ?

Cheers,
Anders


>
> Thanks,
> John
>
> >
> > Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
> > ---
> >  arch/arm64/configs/defconfig | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> > index 878f379d8d84..c9aa6b9ee996 100644
> > --- a/arch/arm64/configs/defconfig
> > +++ b/arch/arm64/configs/defconfig
> > @@ -855,3 +855,4 @@ CONFIG_DEBUG_KERNEL=y
> >  # CONFIG_SCHED_DEBUG is not set
> >  CONFIG_MEMTEST=y
> >  # CONFIG_CMDLINE_FORCE is not set
> > +# CONFIG_CPU_BIG_ENDIAN is not set
> >
>
>
