Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62A22ECE587
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 17:12:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F7262168B
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 17:12:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="cnvMiLlr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728420AbfJARMX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 13:12:23 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:32977 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725792AbfJARMW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 13:12:22 -0400
Received: by mail-qt1-f193.google.com with SMTP id r5so22600882qtd.0
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2019 10:12:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=J6dBLTJUr1ayorS1X/wuqaZamfgYcdnHpuqJt5uSLPg=;
        b=cnvMiLlrbSLAifWEHOvBwxzT/fH3OP1qfY0QYVJqjT7CBvTdigVRkukRjuB8NkrLNZ
         8KYD+X2WgyhuliBIf8/T1cQ0Xmlo/FKfQZtQIJKMuQ5vFWTYbCy+WTKAtTSNgDT0LhEx
         /t9qYP+L3X32XiOMlIXFWAPWWTASSOp/duXjDQktUr9lbAMx86p3OLeqSdruGLsC9Y3t
         7neZ7EXhN1DvxRNFajaGMt5Rg5GNucsHob5c8rmbGeG6Ymmp/rS9yQ6LNrWgSPXJ7xWE
         3cbVNJuTqgFTUwTlAy+nQHcEptUmtJH6P55Hb5sPVJ8AWU26EJHikwwKQ8XqiM7RSYpu
         BIhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=J6dBLTJUr1ayorS1X/wuqaZamfgYcdnHpuqJt5uSLPg=;
        b=AIn6HinkYcgsc0IhwZ9dHdse1DOsopudlfYbgUYG4rym8td3c3y+rlgkbvXzdhjeVt
         T/AowArI5GTWfI9Uxueb3z1jJeLLXkuL6dUbsv1Uugu2bATeTFrAIQCw/ejQUYDuPjBO
         f7wA9uVIyxmZgkc9j3WcaKHOe9RtY6BMeKS1wfJVNHhPjoy+K3dM6Jc8oiO0FTv782mj
         Jj7vgm4e4VFj5gql027P3HZxA3hLO2CKwMeNxmNxAHPondmJ5s+juFzNQqdxaJCFLokJ
         dl/ydp+s9tO9SgkWe1PsjZKVoOQMElgY0GlHf11aCneFTw8kCmBzAvhCrfWMFnDctytz
         AJpw==
X-Gm-Message-State: APjAAAU0K3Wq57uZtbklTIWrZeK35Pv5yuzOsDrrHvcmiOWwrimCMcFf
        hM8ZriAqSORkbFfXJPv7XA9TNg==
X-Google-Smtp-Source: APXvYqzE8t0dE2/+XQYl8bJ0ClQGr14JtntknULxHWzbTIzvKJt3iHFjG+VHI3AZrKyQ6yDnK/Poqg==
X-Received: by 2002:ac8:134c:: with SMTP id f12mr1701472qtj.162.1569949941698;
        Tue, 01 Oct 2019 10:12:21 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-180.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.180])
        by smtp.gmail.com with ESMTPSA id v7sm8755483qte.29.2019.10.01.10.12.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 01 Oct 2019 10:12:21 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iFLhE-0003Fi-QM; Tue, 01 Oct 2019 14:12:20 -0300
Date:   Tue, 1 Oct 2019 14:12:20 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Alan Mikhak <alan.mikhak@sifive.com>
Cc:     linux-kernel@vger.kernel.org, martin.petersen@oracle.com,
        alexios.zavras@intel.com, ming.lei@redhat.com,
        gregkh@linuxfoundation.org, tglx@linutronix.de,
        christophe.leroy@c-s.fr, Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>
Subject: Re: [PATCH] scatterlist: Validate page before calling PageSlab()
Message-ID: <20191001171220.GF22532@ziepe.ca>
References: <1569885755-10947-1-git-send-email-alan.mikhak@sifive.com>
 <20191001121623.GA22532@ziepe.ca>
 <CABEDWGzsJR+YpX7eDrt_EerT0VEHjpBXSpc6Nzbbmvqc2OiR8Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABEDWGzsJR+YpX7eDrt_EerT0VEHjpBXSpc6Nzbbmvqc2OiR8Q@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 01, 2019 at 10:09:48AM -0700, Alan Mikhak wrote:
> On Tue, Oct 1, 2019 at 5:16 AM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> >
> > On Mon, Sep 30, 2019 at 04:22:35PM -0700, Alan Mikhak wrote:
> > > From: Alan Mikhak <alan.mikhak@sifive.com>
> > >
> > > Modify sg_miter_stop() to validate the page pointer
> > > before calling PageSlab(). This check prevents a crash
> > > that will occur if PageSlab() gets called with a page
> > > pointer that is not backed by page struct.
> > >
> > > A virtual address obtained from ioremap() for a physical
> > > address in PCI address space can be assigned to a
> > > scatterlist segment using the public scatterlist API
> > > as in the following example:
> > >
> > > my_sg_set_page(struct scatterlist *sg,
> > >                const void __iomem *ioaddr,
> > >                size_t iosize)
> > > {
> > >       sg_set_page(sg,
> > >               virt_to_page(ioaddr),
> > >               (unsigned int)iosize,
> > >               offset_in_page(ioaddr));
> > >       sg_init_marker(sg, 1);
> > > }
> > >
> > > If the virtual address obtained from ioremap() is not
> > > backed by a page struct, virt_to_page() returns an
> > > invalid page pointer. However, sg_copy_buffer() can
> > > correctly recover the original virtual address. Such
> > > addresses can successfully be assigned to scatterlist
> > > segments to transfer data across the PCI bus with
> > > sg_copy_buffer() if it were not for the crash in
> > > PageSlab() when called by sg_miter_stop().
> >
> > I thought we already agreed in general that putting things that don't
> > have struct page into the scatter list was not allowed?
> >
> > Jason
> 
> Thanks Jason for your comment.
> 
> Cost of adding page structs to a large PCI I/O address range can be
> quite substantial. Allowing PCI I/O pages without page structs may be
> desirable. Perhaps it is worth considering this cost.

This is generally agreed, but nobody has figured out a solution.

> Scatterlist has no problem doing its memcpy() from pages without a
> page struct that were obtained from ioremap(). It is only at

Calling memcpy on pointers from ioremap is very much not allowed. Code
has to use the iomem safe memcpy.

Jason
