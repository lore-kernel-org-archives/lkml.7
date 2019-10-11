Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5C66C47404
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 10:25:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4E882084C
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 10:25:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727003AbfJKKZq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 06:25:46 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:46425 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726290AbfJKKZq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 06:25:46 -0400
Received: by mail-qt1-f193.google.com with SMTP id u22so13059265qtq.13
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2019 03:25:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=t/rs8Xp1pdPpdAkD8nGvsvdxNs69qOBQmbpI4r5piqI=;
        b=SnsKyICNl0eCgp4yGtCfzH5pL1nuwlM1/FPVlqy2PhDPZ7pqun6kNv/IXnVIw5mF4u
         I4IKStm7bodX/K2LqoQHErHCQdv10/a5xZbQJY8RoV6y9WVdvgxhbz0gVpMWZoKN4fLf
         lY9j89IPWC2ZDSv/6WtKgfRI1gnb+lPcmTIr0uesRkAM1B0ivjaf+B3cgeV48N92QqQf
         EOqmThXDywHX9hXOnkI0PzXLSeK7WX5uZuBH+1xAzHj8eZwb8Os54KziwJshX5cfsIBy
         dl6xeo09iIG3ZNcpY0Bx5SU4ShV/VJiy68yOsWvjvxmpVwH//ZHLMpdVGvBDa5bnL7WY
         5HOQ==
X-Gm-Message-State: APjAAAVjp4OoO2mAvxfNmcl53zinBVajcnCoJWZalZku9O+joPHjyRYc
        qzBwsUW19e7io51uJ5JP/slrcHQRQYdaB2mbuoY=
X-Google-Smtp-Source: APXvYqwjulTSV7kS+w6qp4MRoCgoWGqaIzzGWNbblq62PsnCyHSrbBi44lgcajzslUmbSED4Th05TzD/0I+F9s+Wedk=
X-Received: by 2002:a0c:fde8:: with SMTP id m8mr15279083qvu.4.1570789545038;
 Fri, 11 Oct 2019 03:25:45 -0700 (PDT)
MIME-Version: 1.0
References: <20190926193030.5843-1-anders.roxell@linaro.org>
 <20190926193030.5843-5-anders.roxell@linaro.org> <bf5db3a5-96da-752c-49ea-d0de899882d5@huawei.com>
 <CADYN=9LB9RHgRkQj=HcKDz1x9jqmT464Kseh2wZU5VvcLit+bQ@mail.gmail.com> <d978673e-cbd1-5ab5-b2a4-cdb407d0f98c@huawei.com>
In-Reply-To: <d978673e-cbd1-5ab5-b2a4-cdb407d0f98c@huawei.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 11 Oct 2019 12:25:29 +0200
Message-ID: <CAK8P3a0kBz1-i-3miCo1vMuoM39ivXa3oxOE9VnCqDO-nfNOxw@mail.gmail.com>
Subject: Re: [PATCH 3/3] arm64: configs: unset CPU_BIG_ENDIAN
To:     John Garry <john.garry@huawei.com>
Cc:     Anders Roxell <anders.roxell@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Olof Johansson <olof@lixom.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 3, 2019 at 1:15 PM John Garry <john.garry@huawei.com> wrote:
> On 03/10/2019 08:40, Anders Roxell wrote:
> > On Tue, 1 Oct 2019 at 16:04, John Garry <john.garry@huawei.com> wrote:
> >> On 26/09/2019 20:30, Anders Roxell wrote:
> >>> it doesn't get enabled when building allmodconfig kernels. When doing a
> >>> 'make savedefconfig' CONFIG_CPU_BIG_ENDIAN will be dropped.
> >>
> >> So without having to pass KCONFIG_ALLCONFIG or do anything else, what
> >> about a config for CONFIG_CPU_LITTLE_ENDIAN instead? I'm not sure if
> >> that was omitted for a specific reason.
> >
> > Oh, I tried to elaborate on the idea in the cover letter, that using
> > the defconfig
> > as base and then configure the rest as modules is to get a bootable kernel
> > that have as many features turned on as possible. That will make it possible
> > to run as wide a range of testsuites as possible on a single kernel.
> >
> > Does that make it clearer ?
>
> Hi Anders,
>
> Yeah, I got the idea.
>
> So when you say "'make savedefconfig' CONFIG_CPU_BIG_ENDIAN will be
> dropped", I don't know what the rules are in terms of resyncing the
> common defconfig (I was under the impression that it's done per release
> cycle by the arm soc maintainers, but can't find evidence as such), but
> your change may be easily lost in this way.

We don't do it every release, but occasionally someone sends a patch
with a refresh, and this might easily get missed.

We could force the allmodconfig kernel to be little-endian by default,
using a choice statement to pick endianess like arch/mips and arch/sh
do, the effect would be that an allmodconfig kernel gains a few more
options that depend on !BIG_ENDIAN, but we would no longer catch
a class of endianess bugs in drivers that we otherwise get warnings
for. No idea what is better here.

       Arnd
