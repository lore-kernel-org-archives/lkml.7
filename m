Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64232C5B579
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 16:29:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D27F208E3
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 16:29:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qtBdXq0X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726883AbfF1Q3g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 12:29:36 -0400
Received: from mail-ua1-f65.google.com ([209.85.222.65]:37802 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726618AbfF1Q3f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 12:29:35 -0400
Received: by mail-ua1-f65.google.com with SMTP id z13so2415038uaa.4
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2019 09:29:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bKHVDCcXPiE05peODNTqmlPBXDlbWR2UFo/K1we8S9c=;
        b=qtBdXq0XLD8BVGshscddAtfmjvkM+6vEB2fci5h7bCZ4QPj0ESqwfWXwFxyvi/bgia
         kVGVlU7Y0ZWBE++KzRXh3A/3Gu2lZ6RKr5PHf9WlBNxfOS/5/Wksj1RUTJ3ZKca12D/4
         ANk8oVjWBNAZ/5GUBCJqzKYf2rE9XPxBdJRUy5pynMcNABwPp+fWCNWF5kWfpv7cLuLn
         vsaPOk1Yunt+fZc8Mu0zuBdVCGK6Qg2DiX1apJzz/2NKU4KK3bNQNLYP9dAJ/JRswrfv
         VGLqYs5PjFjamcmAkCZV8ESowBAs/QIf/5reFutLohfqT+K9aTmiLimgGzHTcp7qqn+t
         Hmrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bKHVDCcXPiE05peODNTqmlPBXDlbWR2UFo/K1we8S9c=;
        b=DHNc95pL+mESaVEtU+5L4eOTET2PnkdE2THzWrlniv10h7Hlpi8OaliVBj77C2PoU8
         DqoEcM+itke6NwsAAjLyh8zwJERmtTUV3WneGCOHgBBXflkked72icjUBPzg+Jqt5RM7
         KLyAPHknAf2cDg0f68OKAZ7kKp1vHHhO6Jg2JovVqzHo+VUXMrA5s/SSsfXM6XIjA+sS
         OAw2T0Yp+pZ/dJSlgJYr5Io0DyeQTtKwoAI/5jYSr4mkH03SyQcl5m3KqJansKmExJqr
         1qnZjj45KMqNReIZHwE23EfWE+o7rLwRx9gT0JOGsufvNI7FYo3zFrsiy+vE8vCowwsQ
         RqlA==
X-Gm-Message-State: APjAAAWrfWje1wIcWbGvorFZCPIXzkqGnGv9SN3kAE6T5K51YoJMJ5/f
        i+5t7tYFLupcOjnNy47NOY9JM6qi+AyJDq/FNRA=
X-Google-Smtp-Source: APXvYqydPIyXvwKpPrZ8ZcD8HVaLsCpFTpEJpv8to51zjquBaIgU+1LKqb+TWKruUHtHlmYHoUFwJbecHP4cb9e2WiU=
X-Received: by 2002:ab0:67d6:: with SMTP id w22mr339818uar.68.1561739374480;
 Fri, 28 Jun 2019 09:29:34 -0700 (PDT)
MIME-Version: 1.0
References: <CACDBo564RoWpi8y2pOxoddnn0s3f3sA-fmNxpiXuxebV5TFBJA@mail.gmail.com>
 <CACDBo55GfomD4yAJ1qaOvdm8EQaD-28=etsRHb39goh+5VAeqw@mail.gmail.com> <20190626175131.GA17250@infradead.org>
In-Reply-To: <20190626175131.GA17250@infradead.org>
From:   Pankaj Suryawanshi <pankajssuryawanshi@gmail.com>
Date:   Fri, 28 Jun 2019 21:59:25 +0530
Message-ID: <CACDBo56fNVxVyNEGtKM+2R0X7DyZrrHMQr6Yw4NwJ6USjD5Png@mail.gmail.com>
Subject: Re: DMA-API attr - DMA_ATTR_NO_KERNEL_MAPPING
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-mm@kvack.org, Michal Hocko <mhocko@kernel.org>,
        linux-kernel@vger.kernel.org, Vlastimil Babka <vbabka@suse.cz>,
        iommu@lists.linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 26, 2019 at 11:21 PM Christoph Hellwig <hch@infradead.org> wrote:
>
> On Wed, Jun 26, 2019 at 10:12:45PM +0530, Pankaj Suryawanshi wrote:
> > [CC: linux kernel and Vlastimil Babka]
>
> The right list is the list for the DMA mapping subsystem, which is
> iommu@lists.linux-foundation.org.  I've also added that.
>
> > > I am writing driver in which I used DMA_ATTR_NO_KERNEL_MAPPING attribute
> > > for cma allocation using dma_alloc_attr(), as per kernel docs
> > > https://www.kernel.org/doc/Documentation/DMA-attributes.txt  buffers
> > > allocated with this attribute can be only passed to user space by calling
> > > dma_mmap_attrs().
> > >
> > > how can I mapped in kernel space (after dma_alloc_attr with
> > > DMA_ATTR_NO_KERNEL_MAPPING ) ?
>
> You can't.  And that is the whole point of that API.

1. We can again mapped in kernel space using dma_remap() api , because
when we are using  DMA_ATTR_NO_KERNEL_MAPPING for dma_alloc_attr it
returns the page as virtual address(in case of CMA) so we can mapped
it again using dma_remap().

2. We can mapped in kernel space using vmap() as used for ion-cma
https://github.com/torvalds/linux/tree/master/drivers/staging/android/ion
 as used in function ion_heap_map_kernel().

Please let me know if i am missing anything.
