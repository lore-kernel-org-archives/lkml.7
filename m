Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B319C4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 19:28:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0300B2245A
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 19:28:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569526091;
	bh=Q3HgT1S8hRne5x66P6TKM4ZffmG6vbM0NvPQTtsTBi8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=SUuI4wlIa6IiscOWn94cNwTgfoYZWyxqRy1Vymtfe8vK15uJYGeHjS2/T4f1v7El4
	 UyyDyXoUliHKf+lAJgCCFs8fXkiIk0waGcg9RpaQQGTz4gd3cO+jFLyQIQ8q0dyn3Z
	 xBilODJ6YSvu1cZlF7xmkkMTcNjM1dvkzUiHf60Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728570AbfIZT2K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Sep 2019 15:28:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:33404 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727707AbfIZT2J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 15:28:09 -0400
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 62D8E2245C
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2019 19:28:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569526088;
        bh=Q3HgT1S8hRne5x66P6TKM4ZffmG6vbM0NvPQTtsTBi8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=rIfKSl2BwfyIcUbpqBQgqxtP17/hvL3KUUO+cw6Z+SP/zd1Mihq6rV/CWdBoJtJIA
         mgKNRikoTV8ejS6zgX/5QL06BPuRRGdP0a/Z9hh0XByKU/Q02D+NUVnMm9IeTA8nuE
         yIF5a9HyQwO6X9+IZEymJpCtjCobxHnIXCFbjIiY=
Received: by mail-qt1-f176.google.com with SMTP id f7so4294971qtq.7
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2019 12:28:08 -0700 (PDT)
X-Gm-Message-State: APjAAAV3F5CphwNMCJzZ+FqLEt4IP73/MFzUdhui1CiCj7ius3bmSI0W
        VWZiZErUOIkTIdzar5WF0hXkx8jAhxFp5kEXHA==
X-Google-Smtp-Source: APXvYqz1Trwf6INqRqIjdxgP2sU3qQFOjF7D+XJ82dz5/HGpBEy1TyXgmXd7PISmFfl2z4F+lPm3NwAot2+vuKrkR98=
X-Received: by 2002:a0c:8a6d:: with SMTP id 42mr4369110qvu.138.1569526087509;
 Thu, 26 Sep 2019 12:28:07 -0700 (PDT)
MIME-Version: 1.0
References: <20190925215006.12056-1-robh@kernel.org> <e898c025-32a7-1d2c-3501-c99556f7cdd4@arm.com>
 <1ae7f42e-bf93-b335-b543-653fae5cf49f@epam.com> <28440326-ed76-b014-c1b8-02125c3214b9@arm.com>
 <f63f55eb-969e-6364-5781-a227d0c04e4c@epam.com>
In-Reply-To: <f63f55eb-969e-6364-5781-a227d0c04e4c@epam.com>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 26 Sep 2019 14:27:56 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKJP3itMOueZD7fGH2b6VNFrTuozW5tWyKN3uBg4gYMzA@mail.gmail.com>
Message-ID: <CAL_JsqKJP3itMOueZD7fGH2b6VNFrTuozW5tWyKN3uBg4gYMzA@mail.gmail.com>
Subject: Re: [RFC PATCH] xen/gntdev: Stop abusing DT of_dma_configure API
To:     Oleksandr Andrushchenko <Oleksandr_Andrushchenko@epam.com>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Julien Grall <julien.grall@arm.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        Oleksandr Andrushchenko <andr2000@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 26, 2019 at 6:16 AM Oleksandr Andrushchenko
<Oleksandr_Andrushchenko@epam.com> wrote:
>
> On 9/26/19 1:46 PM, Robin Murphy wrote:
> > On 2019-09-26 11:17 am, Oleksandr Andrushchenko wrote:
> >>
> >> On 9/26/19 12:49 PM, Julien Grall wrote:
> >>> Hi Rob,
> >>>
> >>>
> >>> On 9/25/19 10:50 PM, Rob Herring wrote:
> >>>> As the comment says, this isn't a DT based device. of_dma_configure()
> >>>> is going to stop allowing a NULL DT node, so this needs to be fixed.
> >>>
> >>> And this can't work on arch not selecting CONFIG_OF and can select
> >>> CONFIG_XEN_GRANT_DMA_ALLOC.
> >>>
> >>> We are lucky enough on x86 because, AFAICT, arch_setup_dma_ops is just
> >>> a nop.
> >>>
> >> No luck is needed as [1] does nothing for those platforms not using
> >> CONFIG_OF
> >>>>
> >>>> Not sure exactly what setup besides arch_setup_dma_ops is needed...
> >>>
> >>> We probably want to update dma_mask, coherent_dma_mask and
> >>> dma_pfn_offset.
> >>>
> >>> Also, while look at of_configure_dma, I noticed that we consider the
> >>> DMA will not be coherent for the grant-table. Oleksandr, do you know
> >>> why they can't be coherent?
> >> The main and the only reason to use of_configure_dma is that if we don't
> >> then we
> >> are about to stay with dma_dummy_ops [2]. It effectively means that
> >> operations on dma-bufs
> >> will end up returning errors, like [3], [4], thus not making it possible
> >> for Xen PV DRM and DMA
> >> part of gntdev driver to do what we need (dma-bufs in our use-cases
> >> allow zero-copying
> >> while using graphics buffers and many more).
> >>
> >> I didn't find any better way of achieving that, but of_configure_dma...
> >> If there is any better solution which will not break the existing
> >> functionality then
> >> I will definitely change the drivers so we do not abuse DT )
> >> Before that, please keep in mind that merging this RFC will break Xen PV
> >> DRM +
> >> DMA buf support in gntdev...
> >> Hope we can work out some acceptable solution, so everyone is happy
> >
> > As I mentioned elsewhere, the recent dma-direct rework means that
> > dma_dummy_ops are now only explicitly installed for the ACPI error
> > case, so - much as I may dislike it - you should get regular
> > (direct/SWIOTLB) ops by default again.
> Ah, my bad, I missed that change. So, if no dummy dma ops are to be used
> then
> I believe we can apply both changes, e.g. remove of_dma_configure from
> both of the drivers.

What about the dma masks? I think there's a default setup, but it is
considered a driver bug to not set its mask. xen_drm_front sets the
coherent_dma_mask (why only 32-bits though?), but not the dma_mask.
gntdev is doing neither. I could copy out what of_dma_configure does
but better for the Xen folks to decide what is needed or not and test
the change. I'm not setup to test any of this.

Rob
