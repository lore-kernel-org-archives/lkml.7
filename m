Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CFD3C28CC0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 22:49:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EEE8242CD
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 22:49:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kxP3qDMI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726676AbfE2WtV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 18:49:21 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:36837 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726501AbfE2WtV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 18:49:21 -0400
Received: by mail-pg1-f196.google.com with SMTP id a3so757303pgb.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2019 15:49:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=OtENOwKeHAEIcv8DtGFlUjGL0dIz5rExz7T3XsDoNZ8=;
        b=kxP3qDMIzoaU9z24i/FcOYvYCdzGKPbAwkgXh8mqLAlP0h6YYo+/xQkfBD8OHVleuJ
         DTOXqzHo7+JcQKVqt0qI9IZGLyOqPuB2qbQid2aOXHv4OAXoZlYdsSKK5MollRuLb9Ai
         nZiV78bSfNZUhc6EzNm2LeUa0hFEVomLt1iCe3erhmMyjyBw1VknYFNCdHQXSa9q10d8
         u+OD0jTmFnoiN7gNA0+uHiahUFn1N8IQOIEJCTnHGbMZpjm0FGw0Lsqly/w1z8yq46JC
         2CvgPcS9CjCkPhSCXQ4dObIlGL4C+A87Fm7uL3juH7YzM7uIqfeTSDuW+iGxx5+jdD9d
         UdTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=OtENOwKeHAEIcv8DtGFlUjGL0dIz5rExz7T3XsDoNZ8=;
        b=GpjwmBrcwydPd0wn806Bu1aMAFD/YeiaY9icsBEcZ6HboxLwstp8aGGOEq13V7EbD5
         enFfHNn5ZfnycGt/lIvVP4Jnr1DkRVrcBNnrQ1EQpvJI0vRwsbKNTDPQyuiU0Lq+BnTX
         E0/Qwd0a1PzkQitdGzEfRw6rva7H+yUAd1gYEgJjlfroCjt5L60TPML8FoydvmZAxlAJ
         MJIc8W0arNsug2YpaBjhmIrSH0JMLyfPJXqmwymK46W7H262FvV9Bp/eQqttPKdhEmke
         O2W+jn4pRMx6MbirCBkYlmUHG5SA1a1kMIeY6FqQ6YzfEGSlUSAEZXTzbFxCzAxeCjQP
         FDzw==
X-Gm-Message-State: APjAAAVLtX3unKktQ97yIkNRkl9ZEtsZYImxWio4Ql5zqLHRqdp4SxOX
        z1SpxTjY6wa7lU1suWlNWZM=
X-Google-Smtp-Source: APXvYqxCUru4wlx+HuYWWTkP4QLXjDPZV6qos9q5kkqjQNUFnwCoUEdp8vdWj72Y5aCS7V0F6OIzFw==
X-Received: by 2002:a62:4ed8:: with SMTP id c207mr44834pfb.241.1559170160671;
        Wed, 29 May 2019 15:49:20 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id j72sm637334pje.12.2019.05.29.15.49.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 29 May 2019 15:49:19 -0700 (PDT)
Date:   Wed, 29 May 2019 15:48:07 -0700
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     hch@lst.de, robin.murphy@arm.com, m.szyprowski@samsung.com,
        vdumpa@nvidia.com, linux@armlinux.org.uk, catalin.marinas@arm.com,
        will.deacon@arm.com, chris@zankel.net, jcmvbkbc@gmail.com,
        joro@8bytes.org, dwmw2@infradead.org, tony@atomide.com,
        akpm@linux-foundation.org, sfr@canb.auug.org.au,
        treding@nvidia.com, keescook@chromium.org, iamjoonsoo.kim@lge.com,
        wsa+renesas@sang-engineering.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, iommu@lists.linux-foundation.org,
        dann.frazier@canonical.com, clang-built-linux@googlegroups.com
Subject: Re: [PATCH v3 1/2] dma-contiguous: Abstract
 dma_{alloc,free}_contiguous()
Message-ID: <20190529224806.GA3270@Asurada-Nvidia.nvidia.com>
References: <20190524040633.16854-1-nicoleotsuka@gmail.com>
 <20190524040633.16854-2-nicoleotsuka@gmail.com>
 <20190529183546.GA12747@archlinux-epyc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190529183546.GA12747@archlinux-epyc>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nathan,

On Wed, May 29, 2019 at 11:35:46AM -0700, Nathan Chancellor wrote:
> This commit is causing boot failures in QEMU on x86_64 defconfig:
> 
> https://travis-ci.com/ClangBuiltLinux/continuous-integration/jobs/203825363
> 
> Attached is a bisect log and a boot log with GCC (just to show it is not
> a compiler thing).
> 
> My QEMU command line is:
> 
> qemu-system-x86_64 -m 512m \
>                    -drive file=images/x86_64/rootfs.ext4,format=raw,if=ide \
>                    -append 'console=ttyS0 root=/dev/sda' \
>                    -nographic \
>                    -kernel arch/x86_64/boot/bzImage
> 
> and the rootfs is available here:
> 
> https://github.com/ClangBuiltLinux/continuous-integration/raw/master/images/x86_64/rootfs.ext4

Thanks for reporting the bug.

I am able to repro the issue with the given command and rootfs. The
problem is that x86_64 has CONFIG_DMA_CMA=n so the helper function
is blank on x86_64 while dma-direct should be platform independent.

A simple fix is to add alloc_pages_node() for !CONFIG_DMA_CMA. I'll
submit a fix soon -- need to figure out a good way though. It seems
that adding the fallback to the !CONFIG_DMA_CMA version would cause
some recipe errors when building the kernel...
