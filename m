Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2AFCC352AA
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 18:23:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 799072168B
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 18:23:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569954224;
	bh=30tHIqsDuyS4f8J3OK28SndY+e+8UaTT56u/QQWRHho=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:List-ID:From;
	b=oS81r7JCge9+ZTJYCQculxhD6e7FAICReaPHaShNVKmSyZejrwYaSIsp4rPFf/dks
	 HRqS8wlDlOhHxGkEODzRCTpjMTkB4S8T1PrLL7uW2ipVHRbOLSJktan4ZHy+QbsCD5
	 AaRYl1D5q6VulhUQqyV+Ku2FVbNNoq5lgtmkGcbs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732115AbfJASXn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 14:23:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:56194 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731560AbfJASXn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 14:23:43 -0400
Received: from localhost (c-67-164-102-47.hsd1.ca.comcast.net [67.164.102.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 17FC820815;
        Tue,  1 Oct 2019 18:23:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569954221;
        bh=30tHIqsDuyS4f8J3OK28SndY+e+8UaTT56u/QQWRHho=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=odQoLLf6OCmnd+DWoF7HNvP7+n/w0zmHVkSI99DuU6myj5pv1WWcCBm02zyGc19Ql
         RqhAf1pvzE9QSnQhfdbwVrNyySAi8t7B6csVibpVIxtSEsZdmCyN3l7qyHCr1caS14
         uvWycia7O0XMDdyBU6ueyO+7Nfv74WN1/PWZBNzA=
Date:   Tue, 1 Oct 2019 11:23:40 -0700 (PDT)
From:   Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@sstabellini-ThinkPad-T480s
To:     Rob Herring <robh@kernel.org>
cc:     Oleksandr Andrushchenko <Oleksandr_Andrushchenko@epam.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Julien Grall <julien.grall@arm.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        Oleksandr Andrushchenko <andr2000@gmail.com>
Subject: Re: [RFC PATCH] xen/gntdev: Stop abusing DT of_dma_configure API
In-Reply-To: <CAL_JsqKJP3itMOueZD7fGH2b6VNFrTuozW5tWyKN3uBg4gYMzA@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1910011112020.20899@sstabellini-ThinkPad-T480s>
References: <20190925215006.12056-1-robh@kernel.org> <e898c025-32a7-1d2c-3501-c99556f7cdd4@arm.com> <1ae7f42e-bf93-b335-b543-653fae5cf49f@epam.com> <28440326-ed76-b014-c1b8-02125c3214b9@arm.com> <f63f55eb-969e-6364-5781-a227d0c04e4c@epam.com>
 <CAL_JsqKJP3itMOueZD7fGH2b6VNFrTuozW5tWyKN3uBg4gYMzA@mail.gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Sep 2019, Rob Herring wrote:
> On Thu, Sep 26, 2019 at 6:16 AM Oleksandr Andrushchenko
> <Oleksandr_Andrushchenko@epam.com> wrote:
> >
> > On 9/26/19 1:46 PM, Robin Murphy wrote:
> > > On 2019-09-26 11:17 am, Oleksandr Andrushchenko wrote:
> > >>
> > >> On 9/26/19 12:49 PM, Julien Grall wrote:
> > >>> Hi Rob,
> > >>>
> > >>>
> > >>> On 9/25/19 10:50 PM, Rob Herring wrote:
> > >>>> As the comment says, this isn't a DT based device. of_dma_configure()
> > >>>> is going to stop allowing a NULL DT node, so this needs to be fixed.
> > >>>
> > >>> And this can't work on arch not selecting CONFIG_OF and can select
> > >>> CONFIG_XEN_GRANT_DMA_ALLOC.
> > >>>
> > >>> We are lucky enough on x86 because, AFAICT, arch_setup_dma_ops is just
> > >>> a nop.
> > >>>
> > >> No luck is needed as [1] does nothing for those platforms not using
> > >> CONFIG_OF
> > >>>>
> > >>>> Not sure exactly what setup besides arch_setup_dma_ops is needed...
> > >>>
> > >>> We probably want to update dma_mask, coherent_dma_mask and
> > >>> dma_pfn_offset.
> > >>>
> > >>> Also, while look at of_configure_dma, I noticed that we consider the
> > >>> DMA will not be coherent for the grant-table. Oleksandr, do you know
> > >>> why they can't be coherent?
> > >> The main and the only reason to use of_configure_dma is that if we don't
> > >> then we
> > >> are about to stay with dma_dummy_ops [2]. It effectively means that
> > >> operations on dma-bufs
> > >> will end up returning errors, like [3], [4], thus not making it possible
> > >> for Xen PV DRM and DMA
> > >> part of gntdev driver to do what we need (dma-bufs in our use-cases
> > >> allow zero-copying
> > >> while using graphics buffers and many more).
> > >>
> > >> I didn't find any better way of achieving that, but of_configure_dma...
> > >> If there is any better solution which will not break the existing
> > >> functionality then
> > >> I will definitely change the drivers so we do not abuse DT )
> > >> Before that, please keep in mind that merging this RFC will break Xen PV
> > >> DRM +
> > >> DMA buf support in gntdev...
> > >> Hope we can work out some acceptable solution, so everyone is happy
> > >
> > > As I mentioned elsewhere, the recent dma-direct rework means that
> > > dma_dummy_ops are now only explicitly installed for the ACPI error
> > > case, so - much as I may dislike it - you should get regular
> > > (direct/SWIOTLB) ops by default again.
> > Ah, my bad, I missed that change. So, if no dummy dma ops are to be used
> > then
> > I believe we can apply both changes, e.g. remove of_dma_configure from
> > both of the drivers.
> 
> What about the dma masks? I think there's a default setup, but it is
> considered a driver bug to not set its mask. xen_drm_front sets the
> coherent_dma_mask (why only 32-bits though?), but not the dma_mask.
> gntdev is doing neither. I could copy out what of_dma_configure does
> but better for the Xen folks to decide what is needed or not and test
> the change. I'm not setup to test any of this.

FYI I have seen the issue Oleksandr is talking about too. I confirm that
the only reason for the of_configure_dma call is to get away from the
dummy_dma_ops and use the default dma_ops instead. I think this should
be mentioned in the commit message so that if one day the behavior
regarding dummy_dma_ops changes one more time, hopefully we'll be able
to figure out the issue more easily with bisection.

In regards to the coherent_dma_mask and dma_mask, I can't see why gntdev
would have any dma addressing limitations, so we should be able to set
both to 64 bits.  I also can't see why xen_drm_front would limit it to
32 bits, after all this is just the frontend, if anything it would be
the backend that has a limitation. So, we should be able to set both
dma_mask and coherent_dma_mask in xen_drm_front to 64 bits. Oleksandr,
can you confirm?
