Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18779C33C9E
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 18:18:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1727214D8
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 18:18:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728569AbgAGSSc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 13:18:32 -0500
Received: from foss.arm.com ([217.140.110.172]:32770 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727925AbgAGSSb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 13:18:31 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E472831B;
        Tue,  7 Jan 2020 10:18:30 -0800 (PST)
Received: from [10.1.196.37] (e121345-lin.cambridge.arm.com [10.1.196.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 956783F534;
        Tue,  7 Jan 2020 10:18:29 -0800 (PST)
Subject: Re: dma-direct: don't check swiotlb=force in dma_direct_map_resource
To:     Naresh Kamboju <naresh.kamboju@linaro.org>, hch@lst.de,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>
Cc:     m.szyprowski@samsung.com, linux- stable <stable@vger.kernel.org>,
        iommu@lists.linux-foundation.org,
        open list <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        lkft-triage@lists.linaro.org
References: <CA+G9fYvMX4gMi6hmTmukzgr1xPsoJsj0WTm=AS3hC5Mq-dLvsQ@mail.gmail.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <2c401e83-99d2-925f-66fe-fffe04415e1a@arm.com>
Date:   Tue, 7 Jan 2020 18:18:28 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CA+G9fYvMX4gMi6hmTmukzgr1xPsoJsj0WTm=AS3hC5Mq-dLvsQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/01/2020 5:38 pm, Naresh Kamboju wrote:
> Following build error on stable-rc 5.4.9-rc1 for arm architecture.
> 
> dma/direct.c: In function 'dma_direct_possible':
> dma/direct.c:329:3: error: too many arguments to function 'dma_capable'
>     dma_capable(dev, dma_addr, size, true);
>     ^~~~~~~~~~~

Not sure that $SUBJECT comes into it at all, but by the look of it I 
guess "dma-direct: exclude dma_direct_map_resource from the min_low_pfn 
check" implicitly depends on 130c1ccbf553 ("dma-direct: unify the 
dma_capable definitions") too.

Robin.

> In file included from
> /srv/oe/build/tmp-lkft-glibc/work-shared/am57xx-evm/kernel-source/include/linux/dma-direct.h:12:0,
>                   from
> /srv/oe/build/tmp-lkft-glibc/work-shared/am57xx-evm/kernel-source/kernel/dma/direct.c:10:
> /srv/oe/build/tmp-lkft-glibc/work-shared/am57xx-evm/kernel-source/arch/arm/include/asm/dma-direct.h:17:20:
> note: declared here
>   static inline bool dma_capable(struct device *dev, dma_addr_t addr,
> size_t size)
>                      ^~~~~~~~~~~
> In file included from
> /srv/oe/build/tmp-lkft-glibc/work-shared/am57xx-evm/kernel-source/include/linux/init.h:5:0,
>                   from
> /srv/oe/build/tmp-lkft-glibc/work-shared/am57xx-evm/kernel-source/include/linux/memblock.h:12,
>                   from
> /srv/oe/build/tmp-lkft-glibc/work-shared/am57xx-evm/kernel-source/kernel/dma/direct.c:7:
> dma/direct.c: In function 'dma_direct_map_resource':
> dma/direct.c:378:16: error: too many arguments to function 'dma_capable'
>    if (unlikely(!dma_capable(dev, dma_addr, size, false))) {
>                  ^
> /srv/oe/build/tmp-lkft-glibc/work-shared/am57xx-evm/kernel-source/include/linux/compiler.h:78:42:
> note: in definition of macro 'unlikely'
>   # define unlikely(x) __builtin_expect(!!(x), 0)
>                                            ^
> In file included from
> /srv/oe/build/tmp-lkft-glibc/work-shared/am57xx-evm/kernel-source/include/linux/dma-direct.h:12:0,
>                   from
> /srv/oe/build/tmp-lkft-glibc/work-shared/am57xx-evm/kernel-source/kernel/dma/direct.c:10:
> /srv/oe/build/tmp-lkft-glibc/work-shared/am57xx-evm/kernel-source/arch/arm/include/asm/dma-direct.h:17:20:
> note: declared here
>   static inline bool dma_capable(struct device *dev, dma_addr_t addr,
> size_t size)
>                      ^~~~~~~~~~~
> /srv/oe/build/tmp-lkft-glibc/work-shared/am57xx-evm/kernel-source/scripts/Makefile.build:265:
> recipe for target 'kernel/dma/direct.o' failed
> 
> Full build log link,
> https://ci.linaro.org/view/lkft/job/openembedded-lkft-linux-stable-rc-5.4/DISTRO=lkft,MACHINE=am57xx-evm,label=docker-lkft/44/consoleText
> 
