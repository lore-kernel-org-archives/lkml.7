Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CECE4C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 19:45:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A38142146E
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 19:45:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727017AbfCMTpO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 15:45:14 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:36368 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726420AbfCMTpN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 15:45:13 -0400
Received: by mail-qt1-f194.google.com with SMTP id b3so3387789qtj.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2019 12:45:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ipyu9ybUUEPsU55tvzWzKOyy6kBr08ODEhyCDNc2yqQ=;
        b=jmkQJxdSJB5SyRW8HV7g2SvlKs693KFoewD6NJkiqhz1Fzt7MCJ/Cxy6S0AqKdDfIs
         kj3uJPmDjKKLnCQMEqk4aU9AKK70j0H4qQm1e3qlNpEiq0u9X73DP9ATDI+HakExg07L
         ktfr9WSIR1hapsz+Kw4aasu8PVDDhG0KtTxn7WdtljRot1elrHytc8+FZCj56ZWJ7Gu/
         jpi6RvxJlWbnSa0Jmutjp31za7U8/n3Lp6nDkhTPwDJwQR4WiqouhXRLs8I1Q57NYoge
         GI5ckqa+JBOiC/GJwspddrcgrdsIJZgWQ8G/sAcrSnS31ELE266rfM2fQWDFhpewCS84
         7RAQ==
X-Gm-Message-State: APjAAAUKtbyYwMMPi+VoY19DLQqvsjXbdaP+trsbgwAE8Fp2jhjcxXy/
        Jfqzc4Dek3RGIuIb+hoypNJg/PmdK+jz+hHcMgs=
X-Google-Smtp-Source: APXvYqwj5Dockp3MIy2Mhy5XwkyjsVXJnrf8kcJnrnxJlHxeZEu/vvAg02KtEmpFIupkuGGLTFytnv8J8oBBMukeIvg=
X-Received: by 2002:ac8:237b:: with SMTP id b56mr35713034qtb.343.1552506312212;
 Wed, 13 Mar 2019 12:45:12 -0700 (PDT)
MIME-Version: 1.0
References: <20190304195951.1118807-1-arnd@arndb.de> <b0b995a1-3211-870f-01af-ce837c18e8f9@arm.com>
 <CAK8P3a2KQKTDQCQcFR7ZTFJ+_XhfKpy9W27r+YV=iD6hLVu2xg@mail.gmail.com>
 <957e168a-2589-89c7-3a72-5071a7b6c65a@arm.com> <20190308152355.GA20230@lst.de>
 <124f4e49-9eb1-99d9-35f4-c2ef3dff8415@arm.com> <20190313183254.GC4926@lst.de>
In-Reply-To: <20190313183254.GC4926@lst.de>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 13 Mar 2019 20:44:55 +0100
Message-ID: <CAK8P3a0yj5TqP95KNwM3uhYuhVSuiLkwYWQe-nLyyVd0j7sGtw@mail.gmail.com>
Subject: Re: [Xen-devel] [PATCH] Revert "swiotlb: remove SWIOTLB_MAP_ERROR"
To:     Christoph Hellwig <hch@lst.de>
Cc:     Julien Grall <julien.grall@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        "open list:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
        Joerg Roedel <jroedel@suse.de>,
        xen-devel <xen-devel@lists.xenproject.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 13, 2019 at 7:33 PM Christoph Hellwig <hch@lst.de> wrote:
> On Fri, Mar 08, 2019 at 05:25:57PM +0000, Julien Grall wrote:
> > In the common case, Dom0 also contains the PV backend drivers. Those
> > drivers may directly use the guest buffer in the DMA request (so a copy is
> > avoided). To avoid using a bounce buffer too much, xen-swiotlb will find
> > the host physical address associated to the guest buffer and will use it to
> > compute the DMA address.
> >
> > While Dom0 kernel may only deal with 32-bit physical address, the
> > hypervisor can still deal with up to 40-bit physical address. This means
> > the guest memory can be allocated above the 4GB threshold. Hence why the
> > dma_addr_t is always 64-bit with CONFIG_XEN=y.
>
> This at least makes some sense.  But is it really so much better to
> avoid having a 64-bit phys_addr_t?

I like the way we tie phys_addr_t to the page table format, as it seems
consistent to have phys_addr_t be whichever data type can be addressed
through virtual memory.

The main practical advantage I see in allowing phys_addr_t and dma_addr_t
to be independent rather than having both of them be the same and grow
to as much as is needed is that most randconfig issues I found that
result from a type mismatch are for real bugs, typically in driver code that
is written under the assumption that both have not only the same size
but also the same binary representation for a given memory address.

      Arnd
