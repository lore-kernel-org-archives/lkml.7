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
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB8D5C28CC0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 23:07:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94CE5242E4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 23:07:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M3qzbB1q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726683AbfE2XHa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 19:07:30 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:37587 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726512AbfE2XHa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 19:07:30 -0400
Received: by mail-pl1-f195.google.com with SMTP id e7so1217608pln.4
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2019 16:07:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=EbuoCefVnNXOM+7/3lTJLOeEE6MIMd3tES4l4TDHW64=;
        b=M3qzbB1qBronEk3HobFj0grL6qxn37uEHDCE23Rc9qHgtHVbbm7aetvz/fMuixWxxU
         18ifnSGCUWmA8JSF7pqwjqGf7Vm4ytetknLeNECbQzJZYrD2xncVVlFfRqBuPK5oqm62
         A8upO2dHAIenvci/wvlYReVClbElOEFJTes8v3rFEhQaZTzVYhOjndZWm9vBfaTQ8T+m
         a7EWYUcaF6cDefqdDWahKl9XCxJobHvwxlTWGMR/HKk0ZUv258X+kfpede/Xg2Koc2k9
         ID51BNwbNVj6+5jGUZJK9BwclNT+3waLnGXyFTsrp3Z7u6G/S4EOXO30iQQHIYNUeoOd
         +Paw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=EbuoCefVnNXOM+7/3lTJLOeEE6MIMd3tES4l4TDHW64=;
        b=mK/BAHsGVLSbLrHf+3vlRpkr2hY13sYHbeBbv+XyGyEI4z6kVzT0q4CHBMgUimPuyJ
         78KSGJR9cjl/UMfxWOEsZafjWALus088zEiOq0PptUKg2G7DB/YTe38tXFDbvMvISL91
         f2WczsmeOQESwXcVkOZdRkn4dk634QUYlv/7pXfGr3yBUoEvSnKsf1zLL0T50CZS9Kck
         Hs0/Y4ugz4oa6OfD/Cs9r5y9STb9Mnv7jOExOw+NqEANussOud84pne1C+Z2gUTxOzo3
         Ee+A6PUcAKxz5v5EEus24QD9xan2ORoC+vc11Lf77rnPvH30hzJSDBxGz6COouEs8/Pl
         kR4g==
X-Gm-Message-State: APjAAAUqqErFW9hQdqBjjUmxqeIZQD4NoSreyJ3tcXo5PsTHhMLsN17J
        rFdyjsKSRD891Cfl1nNEywA=
X-Google-Smtp-Source: APXvYqyZnGjzHeeiqAw/QSIZUGr4a34eKBKdG3AsoGh8+Qmht/O/mRzd7nLEOS8kavtAfsemH3fTvQ==
X-Received: by 2002:a17:902:b18f:: with SMTP id s15mr576136plr.44.1559171249534;
        Wed, 29 May 2019 16:07:29 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id e6sm773276pfl.115.2019.05.29.16.07.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 29 May 2019 16:07:28 -0700 (PDT)
Date:   Wed, 29 May 2019 16:06:19 -0700
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     robin.murphy@arm.com, m.szyprowski@samsung.com, vdumpa@nvidia.com,
        linux@armlinux.org.uk, catalin.marinas@arm.com,
        will.deacon@arm.com, chris@zankel.net, jcmvbkbc@gmail.com,
        joro@8bytes.org, dwmw2@infradead.org, tony@atomide.com,
        akpm@linux-foundation.org, sfr@canb.auug.org.au,
        treding@nvidia.com, keescook@chromium.org, iamjoonsoo.kim@lge.com,
        wsa+renesas@sang-engineering.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, iommu@lists.linux-foundation.org,
        dann.frazier@canonical.com
Subject: Re: [PATCH v3 0/2] Optimize dma_*_from_contiguous calls
Message-ID: <20190529230618.GC17556@Asurada-Nvidia.nvidia.com>
References: <20190524040633.16854-1-nicoleotsuka@gmail.com>
 <20190528060424.GA11521@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190528060424.GA11521@lst.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 28, 2019 at 08:04:24AM +0200, Christoph Hellwig wrote:
> Thanks,
> 
> applied to dma-mapping for-next.
> 
> Can you also send a conversion of drivers/iommu/dma-iommu.c to your
> new helpers against this tree?
> 
> http://git.infradead.org/users/hch/dma-mapping.git/shortlog/refs/heads/for-next

I can. There is a reported regression with !CONFIG_DMA_CMA now
so I will do that after a fix is merged and the whole thing is
stable.

Thank you
