Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 929C7C282DD
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 17:58:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6674220678
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 17:58:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VzfZCWij"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388382AbgAIR6P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 12:58:15 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:26372 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728653AbgAIR6O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 12:58:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578592693;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JBGSTMtmWapJS7aBgL4O9DuYqc+2+k4w5AKnZpuk488=;
        b=VzfZCWijviXbgejBIXy4PNOlt/GxElb3tRBCwPU47Maa0xd1XNCu0JCisOq0LdVeb+s0K1
        JGp8jC5PBwIK0nFN5+NwvADUWTU9OyEgcog1z2msiy79ieMg5xJxerbgO2LGe9kUzd6j7h
        rH6ZHC86SQJzBJA5mzvmnAc2E9FOLPI=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-309-3UJ-Lq4yMau93p41SrjGcQ-1; Thu, 09 Jan 2020 12:58:12 -0500
X-MC-Unique: 3UJ-Lq4yMau93p41SrjGcQ-1
Received: by mail-qv1-f72.google.com with SMTP id z9so4590366qvo.10
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jan 2020 09:58:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JBGSTMtmWapJS7aBgL4O9DuYqc+2+k4w5AKnZpuk488=;
        b=VTsJvaI8yFPsqpQlbTLgwQHBrnlD+an739WX4++0OK9aC5cAxywZGrMQeuYtvGyoQG
         dHQRfZsZKXpPuPaCzaGcMX6nd3YENBFjnpOQGbPWGfJkRQi1x6BxoDsnLwUG/KghH3cl
         DO+kzpQPxhB23g/pKEv6NGLGEKZ9L9NnxKymBr9Il1PRFwMU7oWsU5zCzObygz1ZtZWs
         eu4g3aoF1GWuuaMa5lX/j8w0NCJZF78jJS1gZNBHRK02f8mJkYhwDRYQjcm3yQc7RT1g
         Hi5kS7Mnu8a42lyWsRwpjQOJftCeuCJa4MRLaVNoxY8GC11bx7+RJ7HsHBZJgg5RN+3X
         sx/Q==
X-Gm-Message-State: APjAAAXSTXYaIwVPrWD6UKuR59kASEJ5tk3I6A9BvLa2YxgmXV9ljg7M
        dMPJT7UoWaV4A+ciO6OvRSREP6QjHBP+mSb51F5l5SluhiBkwG33EGR2R9IT+xidLcIcFcWP4cF
        ziuubMaFPRvBw3gCu2zqqa/Y/
X-Received: by 2002:a37:741:: with SMTP id 62mr10826923qkh.310.1578592691599;
        Thu, 09 Jan 2020 09:58:11 -0800 (PST)
X-Google-Smtp-Source: APXvYqzt1tMKJXpEnh6bxif8A5j8quYCW2A3DAAhInV3udIOmMoe0L+3TtDOeF++5RCfLS3gNbma3w==
X-Received: by 2002:a37:741:: with SMTP id 62mr10826899qkh.310.1578592691311;
        Thu, 09 Jan 2020 09:58:11 -0800 (PST)
Received: from xz-x1 ([104.156.64.74])
        by smtp.gmail.com with ESMTPSA id q20sm224975qtl.82.2020.01.09.09.58.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2020 09:58:10 -0800 (PST)
Date:   Thu, 9 Jan 2020 12:58:08 -0500
From:   Peter Xu <peterx@redhat.com>
To:     Alex Williamson <alex.williamson@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Christophe de Dinechin <dinechin@redhat.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Yan Zhao <yan.y.zhao@intel.com>,
        Jason Wang <jasowang@redhat.com>,
        Kevin Kevin <kevin.tian@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        Kirti Wankhede <kwankhede@nvidia.com>
Subject: Re: [PATCH v3 00/21] KVM: Dirty ring interface
Message-ID: <20200109175808.GC36997@xz-x1>
References: <20200109145729.32898-1-peterx@redhat.com>
 <20200109094711.00eb96b1@w520.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200109094711.00eb96b1@w520.home>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 09, 2020 at 09:47:11AM -0700, Alex Williamson wrote:
> On Thu,  9 Jan 2020 09:57:08 -0500
> Peter Xu <peterx@redhat.com> wrote:
> 
> > Branch is here: https://github.com/xzpeter/linux/tree/kvm-dirty-ring
> > (based on kvm/queue)
> > 
> > Please refer to either the previous cover letters, or documentation
> > update in patch 12 for the big picture.  Previous posts:
> > 
> > V1: https://lore.kernel.org/kvm/20191129213505.18472-1-peterx@redhat.com
> > V2: https://lore.kernel.org/kvm/20191221014938.58831-1-peterx@redhat.com
> > 
> > The major change in V3 is that we dropped the whole waitqueue and the
> > global lock. With that, we have clean per-vcpu ring and no default
> > ring any more.  The two kvmgt refactoring patches were also included
> > to show the dependency of the works.
> 
> Hi Peter,

Hi, Alex,

> 
> Would you recommend this style of interface for vfio dirty page
> tracking as well?  This mechanism seems very tuned to sparse page
> dirtying, how well does it handle fully dirty, or even significantly
> dirty regions?

That's truely the point why I think the dirty bitmap can still be used
and should be kept.  IIUC the dirty ring starts from COLO where (1)
dirty rate is very low, and (2) sync happens frequently.  That's a
perfect ground for dirty ring.  However it for sure does not mean that
dirty ring can solve all the issues.  As you said, I believe the full
dirty is another extreme in that dirty bitmap could perform better.

> We also don't really have "active" dirty page tracking
> in vfio, we simply assume that if a page is pinned or otherwise mapped
> that it's dirty, so I think we'd constantly be trying to re-populate
> the dirty ring with pages that we've seen the user consume, which
> doesn't seem like a good fit versus a bitmap solution.  Thanks,

Right, so I confess I don't know whether dirty ring is the ideal
solutioon for vfio either.  Actually if we're tracking by page maps or
pinnings, then IMHO it also means that it could be more suitable to
use an modified version of dirty ring buffer (as you suggested in the
other thread), in that we can track dirty using (addr, len) range
rather than a single page address.  That could be hard for KVM because
in KVM the page will be mostly trapped in 4K granularity in page
faults, and it'll also be hard to merge continuous entries with
previous ones because the userspace could be reading the entries (so
after we publish the previous 4K dirty page, we should not modify the
entry any more).  VFIO should not have this restriction because the
marking of dirty page range can be atomic when the range of pages are
mapped or pinned.

Thanks,

-- 
Peter Xu

