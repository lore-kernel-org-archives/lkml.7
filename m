Return-Path: <SRS0=V+Ds=VJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28C3BC742B2
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 09:41:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC0412064B
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 09:41:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ozlabs-ru.20150623.gappssmtp.com header.i=@ozlabs-ru.20150623.gappssmtp.com header.b="CI1u2237"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726979AbfGLJl6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jul 2019 05:41:58 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:42569 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726025AbfGLJl5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 05:41:57 -0400
Received: by mail-pg1-f196.google.com with SMTP id t132so4286704pgb.9
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2019 02:41:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ozlabs-ru.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=PP9T1+gtHUwxVhVZ5rDjgJsT2BnVoNucdyhPBjT/6f0=;
        b=CI1u2237xitj/L1j9ySUZXA7nWKaxBQgnFzZ2ApZHyyeCSE35oZeFYBgsxzhS/Q4wY
         u7BHHCgq2pFiG0ZEXxSE+yg8noBjcgH7FZGLxbdYDq9U6BVfpFzhzHZa584Sam1RV0dx
         PgibEnp9hNzOBvL5V3Ic3oebvW8ZQ9aHYG8yZuZeI0RrXjdoAXq9r3U7Ty+/HjKGwNjK
         /VoULQcv75GLyYJzuZ8snYqq+9veFQMitkqWOAq6wRnvdkExT0JeZi3p2XxL+Qq7d855
         9ZP2r6YuWOf/oF9Kp5hSJSTCnC4V2YPLjy2nBsm1hIGW2unZG6ewYmrOfP32LY+4qc1r
         g5fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PP9T1+gtHUwxVhVZ5rDjgJsT2BnVoNucdyhPBjT/6f0=;
        b=CiIIWqbpOT0YcXbg3hi+eA/boCGVZUPBYTPknRf3IvLELVviiN/mAoB5IOWz6jVa5j
         ih4AiitBbgd9hZ3Kpcdd0+hs7bY97vp1iR4EVnZKwsi34ET6l1Av461hAewTNUY3gDUh
         Z30fWV8R5pxxwe8VRUxVJ2WCqh6wWUxj7yMqoUtaQq/F2H/E6wu/sZzt51KpydnMAvMD
         l7PspWT99hre3dTuzMsc7uwqnDtjGtSqPrBO9D1E8zAL2eADMtzHV6CFiEDkuiy3e19y
         iJGClU9K6KpJt8xXLHW4IuGEqQM5D4Z364W8PI45+NYhHGmu6T45Ge3C0p1zEtbH9wUx
         +gZA==
X-Gm-Message-State: APjAAAWrlj+AIq0ee8Ct+SyxEQJ7nWbPwgMeOGSSXnNzqnLGWSZmb9+v
        g3YYPyY2iyYnU0iDjKbiQudPtsZX
X-Google-Smtp-Source: APXvYqyhtfE4s9FM+Z0/vycYThrf/6GpPsrCIiTsucDK8UWR+ETHw5Gu+X9oYda5kGeP/v5FY3tttA==
X-Received: by 2002:a63:e807:: with SMTP id s7mr9392362pgh.194.1562924516895;
        Fri, 12 Jul 2019 02:41:56 -0700 (PDT)
Received: from [10.61.2.175] ([122.99.82.10])
        by smtp.gmail.com with ESMTPSA id f64sm8556676pfa.115.2019.07.12.02.41.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Jul 2019 02:41:56 -0700 (PDT)
Subject: Re: [PATCH kernel v4 0/4] powerpc/ioda2: Yet another attempt to allow
 DMA masks between 32 and 59
To:     linux-kernel@vger.kernel.org
Cc:     Oliver O'Halloran <oohall@gmail.com>,
        David Gibson <david@gibson.dropbear.id.au>,
        Sam Bobroff <sbobroff@linux.ibm.com>,
        Alistair Popple <alistair@popple.id.au>
References: <20190712092955.56218-1-aik@ozlabs.ru>
From:   Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <5c860fe3-ba6c-8915-a7dc-d03f3397f1b1@ozlabs.ru>
Date:   Fri, 12 Jul 2019 19:41:52 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190712092955.56218-1-aik@ozlabs.ru>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Argh. This was meant for the linuxppc list, will repost, please ignore this.


On 12/07/2019 19:29, Alexey Kardashevskiy wrote:
> This is an attempt to allow DMA masks between 32..59 which are not large
> enough to use either a PHB3 bypass mode or a sketchy bypass. Depending
> on the max order, up to 40 is usually available.
> 
> 
> This is based on sha1
> a2b6f26c264e Christophe Leroy "powerpc/module64: Use symbolic instructions names.".
> 
> Please comment. Thanks.
> 
> 
> 
> Alexey Kardashevskiy (4):
>    powerpc/powernv/ioda: Fix race in TCE level allocation
>    powerpc/iommu: Allow bypass-only for DMA
>    powerpc/powernv/ioda2: Allocate TCE table levels on demand for default
>      DMA window
>    powerpc/powernv/ioda2: Create bigger default window with 64k IOMMU
>      pages
> 
>   arch/powerpc/include/asm/iommu.h              |  8 +-
>   arch/powerpc/platforms/powernv/pci.h          |  2 +-
>   arch/powerpc/kernel/dma-iommu.c               | 11 ++-
>   arch/powerpc/kernel/iommu.c                   | 74 +++++++++++++------
>   arch/powerpc/platforms/powernv/pci-ioda-tce.c | 38 ++++++----
>   arch/powerpc/platforms/powernv/pci-ioda.c     | 40 ++++++++--
>   6 files changed, 121 insertions(+), 52 deletions(-)
> 

-- 
Alexey
