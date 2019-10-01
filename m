Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11C0EC352AA
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 12:16:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2FAB20700
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 12:16:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Gmq5RHPX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387706AbfJAMQ0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 08:16:26 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:40756 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725821AbfJAMQZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 08:16:25 -0400
Received: by mail-qt1-f193.google.com with SMTP id f7so21255428qtq.7
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2019 05:16:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=n+5Yy7YllNK/YrtqYQNhKYuL7vL1WzBjDBWr7u4jj4U=;
        b=Gmq5RHPXrDRIZQHN+johdaJhA4hUwTMqKgRtBS40lcknjY8J6j9lTXw8HUT64diSN3
         PBhoUu+nRLw51D+RidIPCAgqJPmMnKOkrMRG0neqTEg/wKeRgjvwGoPiNthc7oInjFzi
         VlibkmcktqXWheqi5nSG1z3pQKgrRVpToQ5BYPTBS1O5DGhLVzFQXh8oKQNbID7DxsbK
         QvBlYvVMBZjCDjQtCBPzTKQC91xBZUDL+3xQyS/XiSvMPJBlP78nA+utLkznZVodFI+F
         5nCdL9+HZpFkVnJ1ErPy8q9SmAeLF8QawG/XNnJ3vJhPk73z1h8LJRT0e1FsXue/tGL4
         HaiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=n+5Yy7YllNK/YrtqYQNhKYuL7vL1WzBjDBWr7u4jj4U=;
        b=uaG3ZXKHgMQka5m7y+Ju24qjb5sg0PyEDyrA+Vh+q78Do37bTsZjyZxQsmXxkRvkgh
         9dwb9fXPBgTnK9nYz6UM4IN1/9oud22PETGo/m0nZ6Rvtt+eCBNMu9EsaHg8qsCFOpnZ
         MBgPbsBf1v2CcvxTJQ6/b/iuv3yIjDpZTryeKeSkPFpb4H2Qv2u/qdyDERWojNEtd5O/
         PWep4QBAlQSNt4PvLy/Ob3gqLJ37Ck/n8lIAD9phsk6/9zBVoQTyvHZ1shxwEkwQo0uJ
         YI3LjE0zdEdPGCUve7Cn/45u/6gYgLVyOPObNKVUAdBF+IW7vha1TXWLfCVu1UDP74hQ
         pmjw==
X-Gm-Message-State: APjAAAWEf9DXu6/JaaSC7h6StxFoDA0NNGGYaMCtfbQW2G+ycpvlGgSq
        2nrgh74Ydr1dM4EfWVUOlg6xcA==
X-Google-Smtp-Source: APXvYqzKx2YD4iMn2tmYwWQ2Qkds9vCqdNEnDRQJeF6A9WFYOCYCZl5jx0IEd3HasEkBCTmmL/CBVA==
X-Received: by 2002:ad4:404b:: with SMTP id r11mr24659987qvp.58.1569932184549;
        Tue, 01 Oct 2019 05:16:24 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-180.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.180])
        by smtp.gmail.com with ESMTPSA id a36sm9056580qtk.21.2019.10.01.05.16.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 01 Oct 2019 05:16:23 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iFH4p-0006Rt-Cc; Tue, 01 Oct 2019 09:16:23 -0300
Date:   Tue, 1 Oct 2019 09:16:23 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Alan Mikhak <alan.mikhak@sifive.com>
Cc:     linux-kernel@vger.kernel.org, martin.petersen@oracle.com,
        alexios.zavras@intel.com, ming.lei@redhat.com,
        gregkh@linuxfoundation.org, tglx@linutronix.de,
        christophe.leroy@c-s.fr, palmer@sifive.com,
        paul.walmsley@sifive.com
Subject: Re: [PATCH] scatterlist: Validate page before calling PageSlab()
Message-ID: <20191001121623.GA22532@ziepe.ca>
References: <1569885755-10947-1-git-send-email-alan.mikhak@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1569885755-10947-1-git-send-email-alan.mikhak@sifive.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 30, 2019 at 04:22:35PM -0700, Alan Mikhak wrote:
> From: Alan Mikhak <alan.mikhak@sifive.com>
> 
> Modify sg_miter_stop() to validate the page pointer
> before calling PageSlab(). This check prevents a crash
> that will occur if PageSlab() gets called with a page
> pointer that is not backed by page struct.
> 
> A virtual address obtained from ioremap() for a physical
> address in PCI address space can be assigned to a
> scatterlist segment using the public scatterlist API
> as in the following example:
> 
> my_sg_set_page(struct scatterlist *sg,
>                const void __iomem *ioaddr,
>                size_t iosize)
> {
> 	sg_set_page(sg,
> 		virt_to_page(ioaddr),
> 		(unsigned int)iosize,
> 		offset_in_page(ioaddr));
> 	sg_init_marker(sg, 1);
> }
> 
> If the virtual address obtained from ioremap() is not
> backed by a page struct, virt_to_page() returns an
> invalid page pointer. However, sg_copy_buffer() can
> correctly recover the original virtual address. Such
> addresses can successfully be assigned to scatterlist
> segments to transfer data across the PCI bus with
> sg_copy_buffer() if it were not for the crash in
> PageSlab() when called by sg_miter_stop().

I thought we already agreed in general that putting things that don't
have struct page into the scatter list was not allowed?

Jason
