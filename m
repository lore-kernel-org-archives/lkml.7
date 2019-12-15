Return-Path: <SRS0=qvRn=2F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07EECC2D0CB
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Dec 2019 09:29:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C822F2067C
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Dec 2019 09:29:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Jtgj2rb7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726146AbfLOJ3g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Dec 2019 04:29:36 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:21476 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726049AbfLOJ3g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Dec 2019 04:29:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576402175;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/cbRoYQjVF9Fb6jVOjdPPWTnHMqlJsBUDXZ6cVmV9Xc=;
        b=Jtgj2rb7BtAlt0K2wkZLTr8xBvV1brmnrCp+kx00OK1sdoB2xHUueoCs2hwLHrc5h2jop/
        QtADurIPJtkwPA7TLc6l+DDkDfd4j39jwmwSOz4aGSuemDuN303mILY5D3n1OUoQGsdPqG
        3S167WmdbZYn1dWbKH1/QW672SYl10s=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-21-hFAZHep3O5q6kbQEDR2GuA-1; Sun, 15 Dec 2019 04:29:31 -0500
X-MC-Unique: hFAZHep3O5q6kbQEDR2GuA-1
Received: by mail-wr1-f70.google.com with SMTP id j13so2007123wrr.20
        for <linux-kernel@vger.kernel.org>; Sun, 15 Dec 2019 01:29:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/cbRoYQjVF9Fb6jVOjdPPWTnHMqlJsBUDXZ6cVmV9Xc=;
        b=fjRb7/PGef3Sptz9BpRGQwDGJx6UF1/eiT5WvIvhB6tnxPqV8DRcYtx9fEtnjb5j29
         KFxljQkCjyrQagTTtmKXBYEWPOqWt9sRnuXyivlWY3Qc8GQb9xH1BjhSIZP2om6pyouE
         jnkUpsCLuYnhBtKieT/WOjraieldOKqUZVz1puVPXyh6uq4M0Lglij7AnJCN1EdF24UN
         IbrV4GrF5TcaJZDTpniSNgLnRbm4jtbDjX2g7MynHW+p8LfLXNIoWcuLhL+uoq/yzlcF
         wA2x2SVz9qeV3+mTcIlSv0MRgoOzQvda0DhqrMcMmcDpTovrgmJ0IhA0uL0W2spmxLl7
         GI9g==
X-Gm-Message-State: APjAAAXZOmQ939RHssAnsl4j1zxS+0ePQZNfD8Wb9LsQNjNpXjCYUYpD
        qIXDV1jUKFSCH9lyUv0R/irN4VHhLEwOtYlxOwHyX9wi1/6A7QNA+MXX7GqMNTXVsY1H3Zv6Q/O
        kTR3sFEwHOTEgFjF14aZ6b3Iz
X-Received: by 2002:adf:f508:: with SMTP id q8mr23869133wro.334.1576402169916;
        Sun, 15 Dec 2019 01:29:29 -0800 (PST)
X-Google-Smtp-Source: APXvYqxSQuoeSXK2JQ2a3NYGSOG+IKU4rIEY4e8d8n4cgPva88Rr6fI9uU2IyMvMty0zVO7CDBdDhQ==
X-Received: by 2002:adf:f508:: with SMTP id q8mr23869104wro.334.1576402169688;
        Sun, 15 Dec 2019 01:29:29 -0800 (PST)
Received: from redhat.com (bzq-79-181-48-215.red.bezeqint.net. [79.181.48.215])
        by smtp.gmail.com with ESMTPSA id p17sm17373292wmk.30.2019.12.15.01.29.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Dec 2019 01:29:28 -0800 (PST)
Date:   Sun, 15 Dec 2019 04:29:25 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Alexander Duyck <alexander.h.duyck@linux.intel.com>
Cc:     Alexander Duyck <alexander.duyck@gmail.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, willy@infradead.org,
        mhocko@kernel.org, linux-mm@kvack.org, akpm@linux-foundation.org,
        mgorman@techsingularity.net, vbabka@suse.cz,
        yang.zhang.wz@gmail.com, nitesh@redhat.com, konrad.wilk@oracle.com,
        david@redhat.com, pagupta@redhat.com, riel@surriel.com,
        lcapitulino@redhat.com, dave.hansen@intel.com,
        wei.w.wang@intel.com, aarcange@redhat.com, pbonzini@redhat.com,
        dan.j.williams@intel.com, osalvador@suse.de
Subject: Re: [PATCH v15 6/7] virtio-balloon: Add support for providing free
 page reports to host
Message-ID: <20191215042538-mutt-send-email-mst@kernel.org>
References: <20191205161928.19548.41654.stgit@localhost.localdomain>
 <20191205162255.19548.63866.stgit@localhost.localdomain>
 <20191213020553-mutt-send-email-mst@kernel.org>
 <de779bcc6ccae238dbdedcc61db88abbdb8f291e.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <de779bcc6ccae238dbdedcc61db88abbdb8f291e.camel@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 13, 2019 at 08:35:13AM -0800, Alexander Duyck wrote:
> On Fri, 2019-12-13 at 02:08 -0500, Michael S. Tsirkin wrote:
> > On Thu, Dec 05, 2019 at 08:22:55AM -0800, Alexander Duyck wrote:
> > > From: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> > > 
> > > Add support for the page reporting feature provided by virtio-balloon.
> > > Reporting differs from the regular balloon functionality in that is is
> > > much less durable than a standard memory balloon. Instead of creating a
> > > list of pages that cannot be accessed the pages are only inaccessible
> > > while they are being indicated to the virtio interface. Once the
> > > interface has acknowledged them they are placed back into their respective
> > > free lists and are once again accessible by the guest system.
> > > 
> > > Unlike a standard balloon we don't inflate and deflate the pages. Instead
> > > we perform the reporting, and once the reporting is completed it is
> > > assumed that the page has been dropped from the guest and will be faulted
> > > back in the next time the page is accessed.
> > > 
> > > For this reason when I had originally introduced the patch set I referred
> > > to this behavior as a "bubble" instead of a "balloon" since the duration
> > > is short lived, and when the page is touched the "bubble" is popped and
> > > the page is faulted back in.
> > > 
> > > Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> > 
> > virtio POV is fine here:
> > 
> > Acked-by: Michael S. Tsirkin <mst@redhat.com>
> > 
> > However please copy virtio-comment on UAPI changes.
> 
> So I have been avoiding copying virtio-dev on the kernel changes as I had
> gotten feedback that it was annoying some people as they were getting
> bounces since they were not subscribed. Will the same type of thing happen
> with virtio-comment?

Same thing.

> > If possible isolate the last chunk in a patch by itself
> > to make it easier for non-kernel developers to review.
> 
> Are you talking about the change in "include/uapi/linux/virtio_balloon.h"?
> 
> I have it as a standalone patch in the QEMU set, and for the QEMU set I
> had included virtio-dev.

That's enough then.

> Would you prefer I include virtio-comment instead
> or in addition to virtio-dev? My thought is that I would prefer to keep
> the virtio people focused on the QEMU code since they are probably more
> comfortable with that, and the kernel people focused on the kernel code.

virtio-dev is enough too.


> > > ---
> > >  drivers/virtio/Kconfig              |    1 +
> > >  drivers/virtio/virtio_balloon.c     |   64 +++++++++++++++++++++++++++++++++++
> > >  include/uapi/linux/virtio_balloon.h |    1 +
> > >  3 files changed, 66 insertions(+)
> 
> <snip>
> 
> > > 
> > > diff --git a/include/uapi/linux/virtio_balloon.h b/include/uapi/linux/virtio_balloon.h
> > > index a1966cd7b677..19974392d324 100644
> > > --- a/include/uapi/linux/virtio_balloon.h
> > > +++ b/include/uapi/linux/virtio_balloon.h
> > > @@ -36,6 +36,7 @@
> > >  #define VIRTIO_BALLOON_F_DEFLATE_ON_OOM	2 /* Deflate balloon on OOM */
> > >  #define VIRTIO_BALLOON_F_FREE_PAGE_HINT	3 /* VQ to report free pages */
> > >  #define VIRTIO_BALLOON_F_PAGE_POISON	4 /* Guest is using page poisoning */
> > > +#define VIRTIO_BALLOON_F_REPORTING	5 /* Page reporting virtqueue */
> > >  
> > >  /* Size of a PFN in the balloon interface. */
> > >  #define VIRTIO_BALLOON_PFN_SHIFT 12
> 
> If this is the bit we are talking about I have it split out already into a
> QEMU specific patch as well, it can be found here:
> https://lore.kernel.org/lkml/20191205162422.19737.57728.stgit@localhost.localdomain/
> 
> If needed I could probably add a cover page and/or update the comments in
> that patch if that is needed to better explain the change.
> 
> Thanks.
> 
> - Alex

Updating comment in this patch can't hurt.
But yes, this is OK as is, too, I just missed that you did it.

-- 
MST

