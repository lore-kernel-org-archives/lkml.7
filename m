Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FF6BC33C9B
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 17:38:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 269DC20848
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 17:38:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YazhU/1g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728474AbgAGRio (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 12:38:44 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:46237 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728408AbgAGRio (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 12:38:44 -0500
Received: by mail-lf1-f68.google.com with SMTP id f15so296954lfl.13
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jan 2020 09:38:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=YShlSsj6Xvg1OPo/28mdVtM8iXSk9E0UBpNiD7d4cxc=;
        b=YazhU/1g6LwFUIZeow4DmwAk2IRXPDITZkAOr2G/j4sCa4bGbUL7sYUao55R8VZ3ZQ
         Jv2Ml2OB7SXId3CCh1zEulZ3QjsySlL3rT53Y4ldWMtvsqes3QDo+aeIgRm+/pLEA+Tm
         5aThR1u/u5iFNvsiBzluecy1q1OyXe9+IJ3tht63Sq7JFgqxTMRn03XZzN0fvRdggLQF
         p//PkUf6nff51015iEzpZHBUNPubmqTws917O69DZZ+pI/GRjcKWwhKPoFEHYjjXqdnz
         UekIRCddL2f1Z2MlbWBZJRAs1cl/r2UVmMtlSKhppAdCQdR1Iz9eiypKiHjS68jCEYSU
         whfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=YShlSsj6Xvg1OPo/28mdVtM8iXSk9E0UBpNiD7d4cxc=;
        b=sukbcLQrXkvumkVmgcprbjzh4xLEHQoK43LIlZ81knD/xGS0KiH3oYSlDOQzVmx9xc
         B60qc9cwYRq8aAdpOSe3C/NngTePEerb9k4R2A3KTKaTLE/8mrAxm+zqjqGQqqYQ/rir
         BQv2HQJiwVVhuljOfMuM7dbve+CCsA61k6u9NRSkd39Mzs3G+NPUdnHFYbi8xiNjfgg/
         2X9mnKlOW0jJYfMYv0AlhtJTv7s0LCP1XeXnjOAmeLjqJlVDyq/SMxFuq6JYy9Sjooxa
         Mgh0wQyOIRdRn/nWi1rmgGdFLxOWTrrJM/hog4wnhm3bxvSAKlGFiSKLZVuIr3BgD04E
         Whjg==
X-Gm-Message-State: APjAAAU1Rq3Fprr6ror01Vb3GGp8NpUWv0FGhDOJ4JX2qUdi5jzaNgYs
        RqVh3c44yxtNyH1ZxNLFS6DwzPx50O0vuiyDQmELdA==
X-Google-Smtp-Source: APXvYqzQpfWSWht2AsmDB2uHaiszhuxs88LR7mPSu6VSKvyO2MAlyzIQvfINY/+/sMaehSvr/ao1iKhlBnfVVXZebDI=
X-Received: by 2002:ac2:54b4:: with SMTP id w20mr352825lfk.67.1578418721583;
 Tue, 07 Jan 2020 09:38:41 -0800 (PST)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 7 Jan 2020 23:08:30 +0530
Message-ID: <CA+G9fYvMX4gMi6hmTmukzgr1xPsoJsj0WTm=AS3hC5Mq-dLvsQ@mail.gmail.com>
Subject: Re: dma-direct: don't check swiotlb=force in dma_direct_map_resource
To:     hch@lst.de, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>
Cc:     robin.murphy@arm.com, m.szyprowski@samsung.com,
        linux- stable <stable@vger.kernel.org>,
        iommu@lists.linux-foundation.org,
        open list <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        lkft-triage@lists.linaro.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Following build error on stable-rc 5.4.9-rc1 for arm architecture.

dma/direct.c: In function 'dma_direct_possible':
dma/direct.c:329:3: error: too many arguments to function 'dma_capable'
   dma_capable(dev, dma_addr, size, true);
   ^~~~~~~~~~~
In file included from
/srv/oe/build/tmp-lkft-glibc/work-shared/am57xx-evm/kernel-source/include/linux/dma-direct.h:12:0,
                 from
/srv/oe/build/tmp-lkft-glibc/work-shared/am57xx-evm/kernel-source/kernel/dma/direct.c:10:
/srv/oe/build/tmp-lkft-glibc/work-shared/am57xx-evm/kernel-source/arch/arm/include/asm/dma-direct.h:17:20:
note: declared here
 static inline bool dma_capable(struct device *dev, dma_addr_t addr,
size_t size)
                    ^~~~~~~~~~~
In file included from
/srv/oe/build/tmp-lkft-glibc/work-shared/am57xx-evm/kernel-source/include/linux/init.h:5:0,
                 from
/srv/oe/build/tmp-lkft-glibc/work-shared/am57xx-evm/kernel-source/include/linux/memblock.h:12,
                 from
/srv/oe/build/tmp-lkft-glibc/work-shared/am57xx-evm/kernel-source/kernel/dma/direct.c:7:
dma/direct.c: In function 'dma_direct_map_resource':
dma/direct.c:378:16: error: too many arguments to function 'dma_capable'
  if (unlikely(!dma_capable(dev, dma_addr, size, false))) {
                ^
/srv/oe/build/tmp-lkft-glibc/work-shared/am57xx-evm/kernel-source/include/linux/compiler.h:78:42:
note: in definition of macro 'unlikely'
 # define unlikely(x) __builtin_expect(!!(x), 0)
                                          ^
In file included from
/srv/oe/build/tmp-lkft-glibc/work-shared/am57xx-evm/kernel-source/include/linux/dma-direct.h:12:0,
                 from
/srv/oe/build/tmp-lkft-glibc/work-shared/am57xx-evm/kernel-source/kernel/dma/direct.c:10:
/srv/oe/build/tmp-lkft-glibc/work-shared/am57xx-evm/kernel-source/arch/arm/include/asm/dma-direct.h:17:20:
note: declared here
 static inline bool dma_capable(struct device *dev, dma_addr_t addr,
size_t size)
                    ^~~~~~~~~~~
/srv/oe/build/tmp-lkft-glibc/work-shared/am57xx-evm/kernel-source/scripts/Makefile.build:265:
recipe for target 'kernel/dma/direct.o' failed

Full build log link,
https://ci.linaro.org/view/lkft/job/openembedded-lkft-linux-stable-rc-5.4/DISTRO=lkft,MACHINE=am57xx-evm,label=docker-lkft/44/consoleText

-- 
Linaro LKFT
https://lkft.linaro.org
