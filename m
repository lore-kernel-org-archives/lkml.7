Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFD67C282DD
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 19:23:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 871E920678
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 19:23:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JBcbekXI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729842AbgAITXY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 14:23:24 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:25274 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729754AbgAITXY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 14:23:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578597802;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lAyG93/wDPRo61G3IJlDyRKcV1uCp592GYMDO3Bi2fo=;
        b=JBcbekXI0E/PsbD3Eamxgwhe55i/kruMEym8Uc6SJxtnh8rMdKVWbI/qP/J0IBA9lmFJR6
        kRowRKMzoTTYm2GF+onECaSJrA+87wi1LpSsQQ1/Sl26i3ZhmPyF3KbNCGN0mF6lntVBJc
        nD189FjFJMvi8+g88r1G4auB7NLj+70=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-2-vfLb1nIgM-e413cDdVPtjg-1; Thu, 09 Jan 2020 14:23:21 -0500
X-MC-Unique: vfLb1nIgM-e413cDdVPtjg-1
Received: by mail-qk1-f198.google.com with SMTP id a73so4854723qkg.5
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jan 2020 11:23:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lAyG93/wDPRo61G3IJlDyRKcV1uCp592GYMDO3Bi2fo=;
        b=ujiUUfx6sbfYHc9rTp1ab2Rv4PcqahMesn5dLcHhQpjO/JyAkG/TBl5SG1o2qnnt/J
         /JAR/Vu8wIF5iOxiC2Vt1y6INgHKhpYLvWSP3jgkXlLgsZiwU1B/OktQyZgcGXeNb1bF
         It8Up14IQVkk1HPbkhF1S8QtC6rsNQ9kgepMZv5GTKSDPdnNfs1PUvyfHcdiLVQ9pUTM
         +FqirPKDraHhVUsDSgZzWnEkawJtO96HoLgOVRLelLSwrBxECWS51hVy3YAZB0uu0Fg8
         vLCBc1uPvFv07Cl+537Wbspv4U+sKl05+qXpN+0A/NkRg1FlS6MUmgQvN7/21cSQL0qb
         SD3A==
X-Gm-Message-State: APjAAAVGiV+c2TInDC9P6yr/a9SySlf1cGrDl99wgeBnyVI1sqLc9rJe
        5O6l2gtLSpiLoEzTsGxm4+FqRNp7X1BZvbqx/7SapjKBWsAhdIhHGSILNJzVWnRzNBeTwXCP1Z3
        NHLOoqgucFwofFnC1AElO5rEO
X-Received: by 2002:ac8:43d0:: with SMTP id w16mr9585870qtn.43.1578597800727;
        Thu, 09 Jan 2020 11:23:20 -0800 (PST)
X-Google-Smtp-Source: APXvYqy9hERTrat16wk0EtLZVIdLUjS5G34C0KVLv9397Lnq/NGLGR3Zwgtm6nAaVDXMp6iwyJi0xw==
X-Received: by 2002:ac8:43d0:: with SMTP id w16mr9585849qtn.43.1578597800465;
        Thu, 09 Jan 2020 11:23:20 -0800 (PST)
Received: from xz-x1 ([104.156.64.74])
        by smtp.gmail.com with ESMTPSA id b191sm3574155qkg.43.2020.01.09.11.23.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2020 11:23:19 -0800 (PST)
Date:   Thu, 9 Jan 2020 14:23:18 -0500
From:   Peter Xu <peterx@redhat.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Alex Williamson <alex.williamson@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Christophe de Dinechin <dinechin@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Yan Zhao <yan.y.zhao@intel.com>,
        Jason Wang <jasowang@redhat.com>,
        Kevin Kevin <kevin.tian@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        Kirti Wankhede <kwankhede@nvidia.com>
Subject: Re: [PATCH v3 00/21] KVM: Dirty ring interface
Message-ID: <20200109192318.GF36997@xz-x1>
References: <20200109145729.32898-1-peterx@redhat.com>
 <20200109094711.00eb96b1@w520.home>
 <20200109175808.GC36997@xz-x1>
 <20200109140948-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200109140948-mutt-send-email-mst@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 09, 2020 at 02:13:54PM -0500, Michael S. Tsirkin wrote:
> On Thu, Jan 09, 2020 at 12:58:08PM -0500, Peter Xu wrote:
> > On Thu, Jan 09, 2020 at 09:47:11AM -0700, Alex Williamson wrote:
> > > On Thu,  9 Jan 2020 09:57:08 -0500
> > > Peter Xu <peterx@redhat.com> wrote:
> > > 
> > > > Branch is here: https://github.com/xzpeter/linux/tree/kvm-dirty-ring
> > > > (based on kvm/queue)
> > > > 
> > > > Please refer to either the previous cover letters, or documentation
> > > > update in patch 12 for the big picture.  Previous posts:
> > > > 
> > > > V1: https://lore.kernel.org/kvm/20191129213505.18472-1-peterx@redhat.com
> > > > V2: https://lore.kernel.org/kvm/20191221014938.58831-1-peterx@redhat.com
> > > > 
> > > > The major change in V3 is that we dropped the whole waitqueue and the
> > > > global lock. With that, we have clean per-vcpu ring and no default
> > > > ring any more.  The two kvmgt refactoring patches were also included
> > > > to show the dependency of the works.
> > > 
> > > Hi Peter,
> > 
> > Hi, Alex,
> > 
> > > 
> > > Would you recommend this style of interface for vfio dirty page
> > > tracking as well?  This mechanism seems very tuned to sparse page
> > > dirtying, how well does it handle fully dirty, or even significantly
> > > dirty regions?
> > 
> > That's truely the point why I think the dirty bitmap can still be used
> > and should be kept.  IIUC the dirty ring starts from COLO where (1)
> > dirty rate is very low, and (2) sync happens frequently.  That's a
> > perfect ground for dirty ring.  However it for sure does not mean that
> > dirty ring can solve all the issues.  As you said, I believe the full
> > dirty is another extreme in that dirty bitmap could perform better.
> > 
> > > We also don't really have "active" dirty page tracking
> > > in vfio, we simply assume that if a page is pinned or otherwise mapped
> > > that it's dirty, so I think we'd constantly be trying to re-populate
> > > the dirty ring with pages that we've seen the user consume, which
> > > doesn't seem like a good fit versus a bitmap solution.  Thanks,
> > 
> > Right, so I confess I don't know whether dirty ring is the ideal
> > solutioon for vfio either.  Actually if we're tracking by page maps or
> > pinnings, then IMHO it also means that it could be more suitable to
> > use an modified version of dirty ring buffer (as you suggested in the
> > other thread), in that we can track dirty using (addr, len) range
> > rather than a single page address.  That could be hard for KVM because
> > in KVM the page will be mostly trapped in 4K granularity in page
> > faults, and it'll also be hard to merge continuous entries with
> > previous ones because the userspace could be reading the entries (so
> > after we publish the previous 4K dirty page, we should not modify the
> > entry any more).
> 
> An easy way would be to keep a couple of entries around, not pushing
> them into the ring until later.  In fact deferring queue write until
> there's a bunch of data to be pushed is a very handy optimization.

I feel like I proposed similar thing in the other thread. :-)

> 
> When building UAPI's it makes sense to try and keep them generic
> rather than tying them to a given implementation.
> 
> That's one of the reasons I called for using something
> resembling vring_packed_desc.

But again, I just want to make sure I don't over-engineer...

I'll wait for further feedback from others for this.

Thanks,

-- 
Peter Xu

