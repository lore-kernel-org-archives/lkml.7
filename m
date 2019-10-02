Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9630C10F14
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 17:27:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E74721848
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 17:27:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="MkSRK8bI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728701AbfJBR14 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 13:27:56 -0400
Received: from conssluserg-02.nifty.com ([210.131.2.81]:53941 "EHLO
        conssluserg-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728383AbfJBR14 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 13:27:56 -0400
Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com [209.85.217.46]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id x92HRXsI022775
        for <linux-kernel@vger.kernel.org>; Thu, 3 Oct 2019 02:27:34 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com x92HRXsI022775
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1570037254;
        bh=8ezh4zPqsyD7mcZn5AN+2I9frzay0zH8q/WQ3NPEOlY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=MkSRK8bICX1sKmS0BgD93NSD3EcXaIpHqhBoaV1/jecWZMnx737eNSLcndc+yPi0P
         K9qkQyFUelN8rKL6c+XpiSonrH+Leht3YU7mYI1kGkDrUPP+6Qq+LC84RJwr1CEcvs
         UeiocfuMCyGkFB9Ugfq8Z9UDIEnMYlLgMPftGrC3+XagkGYGBhhs27gRgml2Xmpb5s
         uasJ1O7M1WUk8xZnRdr/Ih9+ArC51iSr+2jE8QIe0Y6/NNUeI0FhigAfFC++PwwHbe
         0LvPlEgSNrD7rdyFODS0zTynwviGYVUXiqvSXB9R17VKz03lEsX8yAho3+52FEB8BE
         BsD1AXGoRKJKQ==
X-Nifty-SrcIP: [209.85.217.46]
Received: by mail-vs1-f46.google.com with SMTP id d3so12507620vsr.1
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2019 10:27:33 -0700 (PDT)
X-Gm-Message-State: APjAAAXKPcrAaup/3iuIdrg2p192wep8+wR6XU7JrINFhw6TaWXSVW5Y
        Ra7gXoTbonQIewCqEapiTFzGZc6VD/tBcq4GUTk=
X-Google-Smtp-Source: APXvYqye6S/TYRNLFfynp+yNS0Hohi2x3m1SPtHG/B1+V5UN5MI5uwWWQHVFVo4CDANTpOsNMYLJk0hKJsUAPd+YmTs=
X-Received: by 2002:a67:1a41:: with SMTP id a62mr2589309vsa.54.1570037252722;
 Wed, 02 Oct 2019 10:27:32 -0700 (PDT)
MIME-Version: 1.0
References: <5d94766b.1c69fb81.6d9f4.dc6d@mx.google.com> <d8357536-6750-d9ba-e114-30944d8f95ab@collabora.com>
 <20191002.102417.205729199993915832.davem@davemloft.net>
In-Reply-To: <20191002.102417.205729199993915832.davem@davemloft.net>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Thu, 3 Oct 2019 02:26:56 +0900
X-Gmail-Original-Message-ID: <CAK7LNAR2Cx+3z6QUO_WSURc2Cq6sQhxB5R+U2EyvVnk_s5cn0g@mail.gmail.com>
Message-ID: <CAK7LNAR2Cx+3z6QUO_WSURc2Cq6sQhxB5R+U2EyvVnk_s5cn0g@mail.gmail.com>
Subject: Re: net-next/master boot bisection: v5.3-13203-gc01ebd6c4698 on bcm2836-rpi-2-b
To:     David Miller <davem@davemloft.net>
Cc:     Guillaume Tucker <guillaume.tucker@collabora.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        mgalka@collabora.com, Mark Brown <broonie@kernel.org>,
        matthew.hart@linaro.org, Kevin Hilman <khilman@baylibre.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        tomeu.vizoso@collabora.com, urezki@gmail.com,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Changbin Du <changbin.du@intel.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Sri Krishna chowdary <schowdary@nvidia.com>,
        Catalin Marinas <catalin.marinas@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 3, 2019 at 2:24 AM David Miller <davem@davemloft.net> wrote:
>
> From: Guillaume Tucker <guillaume.tucker@collabora.com>
> Date: Wed, 2 Oct 2019 18:21:31 +0100
>
> > It seems like this isn't the case on the Raspberry Pi 2b with
> > bcm2835_defconfig.  Here's an example of the kernel errors:
>
> This has been fixed upstream I believe, it was some ARM assembler issue
> or something like that.
>
> In any event, definitely not a networking problem. :-)


The fix and related discussions are available.

https://lore.kernel.org/patchwork/patch/1132785/



-- 
Best Regards
Masahiro Yamada
