Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90EAFC352AA
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 17:44:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6511520679
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 17:44:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="XDzxFVBl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728400AbfJARoC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 13:44:02 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:33868 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726096AbfJARoC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 13:44:02 -0400
Received: by mail-qk1-f195.google.com with SMTP id q203so12113102qke.1
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2019 10:44:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=iEhC4rBksrqGUyOLde28S6MdRltK4FanlvR62miO8Ng=;
        b=XDzxFVBlNwrv8acclBscPjFygnMn27IiO/iYUcxaTV5UgMssfzgFoUQQmxnoujgRSn
         9nO6IvoD5m3afkh6JDhc0+mCaIPR3iEJRQ7wnNvRI8NXNs+PV0n7+5H46/AO6/nkQVRQ
         FzOFJLW5TRsX2nJjZBbvncdSqUtO5MY1ENWBed2U85HhmkQuc2LYx9Sr0XHxl8F0pqMw
         VedHc425xtXTg5XXT7abXEAOudNDdwWpGxAZ69yveZfEabeFJOy2vZD/tXxrWpAVgZB2
         VpvdPu35rpgwn0Sl9oD8266enQ6P/krd/5cGT16mQeQBRk1pCTtcbIes5D3dai1ThFZT
         pJGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=iEhC4rBksrqGUyOLde28S6MdRltK4FanlvR62miO8Ng=;
        b=QXoSTgCk/bjPd4skNPvgBZNbhcxQByi3J72P2VaKKMHp3og+sqc6EaV6RvffCUnx6F
         G8PpJNxMA6IFZRl2p6me8L2EmU+QdaRDjOirxGXuv8ha3HaYTVTGWeoT7Zf8Irf5dIHt
         u9kB6//kMRUKqo9n/+wZalU9ULfXKgNhcg+Hip21JKhJx1FYrMZgYBdzlv4zNpdew6Z1
         3/L4mLJ+wbCfQ2EhgIZcmwFlkXaKzVPVOdHsY8sbZ8oe9XqfqyNVKRQkXtJTjhO8GzML
         /xnKcaSYmZHkr1PQ8cPJyMZbofWjxImhy592QvGWx8hGyU/Pe7QTL61zUNixmcHzFd7x
         7f6w==
X-Gm-Message-State: APjAAAUduW1ntTtuVUISow2f1yNImlOF4DV3j6NAApK4G5Tt82Q5lozD
        gPw7FBhGRYLGtPm00XCOBQxMcQ==
X-Google-Smtp-Source: APXvYqyywUgxVDQJT3yz8Aini7DEixOhKfmaWm6XtpNF/scEZrYZwc8TZCT+bBf2zf77VdBL7PL5hQ==
X-Received: by 2002:a37:4d02:: with SMTP id a2mr7378463qkb.63.1569951839878;
        Tue, 01 Oct 2019 10:43:59 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-180.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.180])
        by smtp.gmail.com with ESMTPSA id k17sm11991937qtk.7.2019.10.01.10.43.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 01 Oct 2019 10:43:59 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iFMBq-0005M4-Sj; Tue, 01 Oct 2019 14:43:58 -0300
Date:   Tue, 1 Oct 2019 14:43:58 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Alan Mikhak <alan.mikhak@sifive.com>
Cc:     linux-kernel@vger.kernel.org, martin.petersen@oracle.com,
        alexios.zavras@intel.com, ming.lei@redhat.com,
        gregkh@linuxfoundation.org, tglx@linutronix.de,
        christophe.leroy@c-s.fr, Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>
Subject: Re: [PATCH] scatterlist: Validate page before calling PageSlab()
Message-ID: <20191001174358.GG22532@ziepe.ca>
References: <1569885755-10947-1-git-send-email-alan.mikhak@sifive.com>
 <20191001121623.GA22532@ziepe.ca>
 <CABEDWGzsJR+YpX7eDrt_EerT0VEHjpBXSpc6Nzbbmvqc2OiR8Q@mail.gmail.com>
 <20191001171220.GF22532@ziepe.ca>
 <CABEDWGyDh6t2t9UXpw=tu1f6Sz=3YTMH6mG05cSTz74zyR9H+A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABEDWGyDh6t2t9UXpw=tu1f6Sz=3YTMH6mG05cSTz74zyR9H+A@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 01, 2019 at 10:26:38AM -0700, Alan Mikhak wrote:

> > > Cost of adding page structs to a large PCI I/O address range can be
> > > quite substantial. Allowing PCI I/O pages without page structs may be
> > > desirable. Perhaps it is worth considering this cost.
> >
> > This is generally agreed, but nobody has figured out a solution.
> >
> > > Scatterlist has no problem doing its memcpy() from pages without a
> > > page struct that were obtained from ioremap(). It is only at
> >
> > Calling memcpy on pointers from ioremap is very much not allowed. Code
> > has to use the iomem safe memcpy.
>
> Is it in the realm of possible to add support for such PCI I/O pages
> to scatterlist? Perhaps some solution is possible by adding a new
> function, say sg_set_iomem_page(), and a new SG_MITER_IOMEM flag that
> tells scatterlist to use iomem safe memcpy functions when the page is
> not backed by page struct because it was obtained from ioremap(). This
> flag can also be used at sg_miter_stop() to not call PageSlab() or
> flush_kernel_dcache_page().

People have tried many different things so far, it is more comple than
just the copy functions as there is also sg_page to worry about.

> If supporting PCI I/O pages is not possible, would it be possible to
> check for invalid page pointers in sg_set_page() and communicate the
> requirement for a page struct backing in its description?

Clarifying the comments seems reasonable to me.

Jason
