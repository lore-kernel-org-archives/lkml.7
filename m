Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CF7CC282E1
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 03:50:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4FC52133D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 03:50:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I13Gm5o+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388799AbfEXDuX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 23:50:23 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:34959 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387454AbfEXDuX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 23:50:23 -0400
Received: by mail-pf1-f196.google.com with SMTP id d126so2260867pfd.2
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2019 20:50:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Meys5AbfHefJr2MxUEnx8+OGhp7ATRQ7K3gNKd4wdrU=;
        b=I13Gm5o+tN+033OCvQGYRdseWRYb9y90+wOF9EOUaj5QRKDbsWYikvdOqa1LdVYQEF
         2ZhjMALlX6tUrs4zDwq1lDEx7N9iOWHW8f55MRV5cptdY9kFlQIxNj/MkE6ngkkcj94E
         alV39V4sXHGmtUolQpKWYkEkBxkp8DzTJ4SGfD4WzrUJNVCoixeDMhYE2dhMyilMw2ag
         TV4Kvy3VTjC6YN5gvxd017GB+M3IZxKYs2+45rwxyjsVyd59inqpXo0xdPcb6v22bT/I
         Iz9pS2laGebLE5B2y8xaoswYxzXi0rdnnGrcsA/IhWJ1i6IxND6Hh/AQ4WdgnGhUunqw
         FuYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Meys5AbfHefJr2MxUEnx8+OGhp7ATRQ7K3gNKd4wdrU=;
        b=SUg/prABaePw4LuIt/Rdh66dPRE9m2U4D1/eCKA5xvSsOVl8g0FdUqaO/CmYsW/MRR
         4czGhZjZAx/AH3GLvhn/lPITr3XMdF5N9bYFX+epzWrFVXSSocbKkr4tuPAchHFgYGla
         qCNqN+sHc6LiuuHDmqsy2htgwQuUv+XjUBuXYjeLw1RxAQZVlTwcBhJn4vFfzrTlLfJn
         Q3m4cWeAVcEnsMoJEgxCQUdV73nTFiSrS2Qr69d9hMUTkf9GFhf1bpi8wbsgetfajGyU
         9vSh+SgHDDQp7srIN8E4TMMWZ893e6TXBfCXBM41DrZNpyn43USCzN0RGiv5LvWZZUVo
         BhOA==
X-Gm-Message-State: APjAAAVZA3grf/UyDzEuqWj0j+JasACr1hSXKA0M8DHylrJBFSfkDHvm
        io78waGBrV6fKpvjd+TM2TTpeUhBPDB8AA==
X-Google-Smtp-Source: APXvYqwM0tDEcOnafEzffzv+1HVI6tauA6VBDlswnPyYwQPKUIu5No+afsn7pJoH7g4zS0Uyp/cWMA==
X-Received: by 2002:a63:2a06:: with SMTP id q6mr16134258pgq.290.1558669821822;
        Thu, 23 May 2019 20:50:21 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id h11sm903497pfn.170.2019.05.23.20.50.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 23 May 2019 20:50:21 -0700 (PDT)
Date:   Thu, 23 May 2019 20:49:04 -0700
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     dann frazier <dann.frazier@canonical.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Robin Murphy <robin.murphy@arm.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>, chris@zankel.net,
        linux-xtensa@linux-xtensa.org, keescook@chromium.org,
        sfr@canb.auug.org.au, tony@atomide.com,
        Catalin Marinas <catalin.marinas@arm.com>, joro@8bytes.org,
        Will Deacon <will.deacon@arm.com>, linux@armlinux.org.uk,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        jcmvbkbc@gmail.com, wsa+renesas@sang-engineering.com,
        akpm@linux-foundation.org, treding@nvidia.com, dwmw2@infradead.org,
        iamjoonsoo.kim@lge.com,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2 1/2] dma-contiguous: Abstract dma_{alloc,
 free}_contiguous()
Message-ID: <20190524034904.GA30034@Asurada-Nvidia.nvidia.com>
References: <20190506223334.1834-1-nicoleotsuka@gmail.com>
 <20190506223334.1834-2-nicoleotsuka@gmail.com>
 <CALdTtnurdNe4+oJjSJfWw1ONf8-xvJ8KhonQkJNj+4LDZT7jAQ@mail.gmail.com>
 <CALdTtnuwRKkna_y5_5BdEYWNRbOQnLvtfz1PY-d4r78tj5hgVw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALdTtnuwRKkna_y5_5BdEYWNRbOQnLvtfz1PY-d4r78tj5hgVw@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 23, 2019 at 08:59:30PM -0600, dann frazier wrote:
> > > diff --git a/kernel/dma/contiguous.c b/kernel/dma/contiguous.c
> > > index b2a87905846d..21f39a6cb04f 100644
> > > --- a/kernel/dma/contiguous.c
> > > +++ b/kernel/dma/contiguous.c
> > > @@ -214,6 +214,54 @@ bool dma_release_from_contiguous(struct device *dev, struct page *pages,
> > >         return cma_release(dev_get_cma_area(dev), pages, count);
> > >  }
> >
> > This breaks the build for me if CONFIG_DMA_CMA=n:
> >
> >   LD [M]  fs/9p/9p.o
> > ld: fs/9p/vfs_inode.o: in function `dma_alloc_contiguous':
> > vfs_inode.c:(.text+0xa60): multiple definition of
> > `dma_alloc_contiguous'; fs/9p/vfs_super.o:vfs_super.c:(.text+0x500):
> > first defined here
> >
> > Do the following insertions need to be under an #ifdef CONFIG_DMA_CMA ?
> 
> Ah, no - the problem is actually a missing "static inline" in the
> !CONFIG_DMA_CMA version of dma_alloc_contiguous().

Yea, I saw it. Thanks for the testing and pointing it out.

Sending v3.....
