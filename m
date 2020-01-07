Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B12DC33C8C
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 17:10:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1D472073D
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 17:10:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ChwYTFil"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728478AbgAGRK6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 12:10:58 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:42946 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728438AbgAGRK5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 12:10:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578417054;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8eOQq6KrMXleTrtscAiy92T1lAB+dCOfzwxoHOxIvL8=;
        b=ChwYTFilNU64ACXGsiYrE/v5elFIOOR7cRJojkJAb0XOW3cZM4GiLFLzpduI4N7NxGaifY
        RHL35FeCvzqk6X4pJnwVNdpywCTPlRfK5S4lcqSFkQ5BjuUk1y6Yof3FkZBtxRxB62Wr50
        X4Abhn4+1nlyBcSLoq0DSdfzZVi9DKE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-286-OubgHLdYOSmaU0ngna-onA-1; Tue, 07 Jan 2020 12:10:52 -0500
X-MC-Unique: OubgHLdYOSmaU0ngna-onA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D795218557C7;
        Tue,  7 Jan 2020 17:10:51 +0000 (UTC)
Received: from w520.home (ovpn-116-26.phx2.redhat.com [10.3.116.26])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 78EFD5C1B0;
        Tue,  7 Jan 2020 17:10:51 +0000 (UTC)
Date:   Tue, 7 Jan 2020 10:10:51 -0700
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Julia Lawall <julia.lawall@inria.fr>
Cc:     kernel-janitors@vger.kernel.org, Cornelia Huck <cohuck@redhat.com>,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] vfio: vfio_pci_nvlink2: use mmgrab
Message-ID: <20200107101051.6d3cd526@w520.home>
In-Reply-To: <alpine.DEB.2.21.2001071800090.3004@hadrien>
References: <1577634178-22530-1-git-send-email-Julia.Lawall@inria.fr>
        <1577634178-22530-3-git-send-email-Julia.Lawall@inria.fr>
        <20200106160505.2f962d38@w520.home>
        <alpine.DEB.2.21.2001071800090.3004@hadrien>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Jan 2020 18:00:31 +0100 (CET)
Julia Lawall <julia.lawall@inria.fr> wrote:

> On Mon, 6 Jan 2020, Alex Williamson wrote:
> 
> > On Sun, 29 Dec 2019 16:42:56 +0100
> > Julia Lawall <Julia.Lawall@inria.fr> wrote:
> >  
> > > Mmgrab was introduced in commit f1f1007644ff ("mm: add new mmgrab()
> > > helper") and most of the kernel was updated to use it. Update a
> > > remaining file.
> > >
> > > The semantic patch that makes this change is as follows:
> > > (http://coccinelle.lip6.fr/)
> > >
> > > <smpl>
> > > @@ expression e; @@
> > > - atomic_inc(&e->mm_count);
> > > + mmgrab(e);
> > > </smpl>
> > >
> > > Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>
> > >
> > > ---
> > >  drivers/vfio/pci/vfio_pci_nvlink2.c |    2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/vfio/pci/vfio_pci_nvlink2.c b/drivers/vfio/pci/vfio_pci_nvlink2.c
> > > index f2983f0f84be..43df10af7f66 100644
> > > --- a/drivers/vfio/pci/vfio_pci_nvlink2.c
> > > +++ b/drivers/vfio/pci/vfio_pci_nvlink2.c
> > > @@ -159,7 +159,7 @@ static int vfio_pci_nvgpu_mmap(struct vfio_pci_device *vdev,
> > >  	data->useraddr = vma->vm_start;
> > >  	data->mm = current->mm;
> > >
> > > -	atomic_inc(&data->mm->mm_count);
> > > +	mmgrab(data->mm);
> > >  	ret = (int) mm_iommu_newdev(data->mm, data->useraddr,
> > >  			vma_pages(vma), data->gpu_hpa, &data->mem);
> > >
> > >  
> >
> > Acked-by: Alex Williamson <alex.williamson@redhat.com>
> >
> > Thanks!  I'm assuming these will be routed via janitors tree, please
> > let me know if you intend me to grab these two vfio patches from the
> > series.  Thanks,  
> 
> Please take them directly.

Ok, I'll queue patches 2 & 3 for v5.6.  Thanks,

Alex

