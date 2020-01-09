Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 908E6C282DD
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 16:40:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67936206ED
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 16:40:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M5qzIFRU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387778AbgAIQkf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 11:40:35 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:34487 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730477AbgAIQke (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 11:40:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578588033;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=S/z9cSjm4MFRCg23zobmeqQEga1mN5PQBjlffN7ciXs=;
        b=M5qzIFRUB9thBD6LydK4xPr9HVMYHHE6nBuW6RbUkryKpBsU0TOL//yr1uJT4acTQqP5gK
        POZkmV3tpmXJOUGMOXsiPHG9RXCO//0bxE3UoWMCo+dh0yltcv+ZqZEQt46eNXQBdrzOSe
        YYx18sEL4BCCdjCSFmTreA9iaiMlwzA=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-12-mB3kPUi8MpyGVbte_3Iwsg-1; Thu, 09 Jan 2020 11:40:30 -0500
X-MC-Unique: mB3kPUi8MpyGVbte_3Iwsg-1
Received: by mail-qv1-f72.google.com with SMTP id g15so4457369qvk.11
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jan 2020 08:40:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=S/z9cSjm4MFRCg23zobmeqQEga1mN5PQBjlffN7ciXs=;
        b=i2joTdmDrzAEVtqwjEBAefhE6FZCws9rAckH8FI8GLu4CD62dd0o1+IvAu9pwIB2wI
         fC7bUNJoyQ4KvSN69/O0F/Uq6WrR67BJOsRqqKkKvcM+1zV3ez9M8sEJGdGeFh5Mys1w
         S14CAD7FDYNncc0sbwNtsrf+85PQ67ZdYD8FSTkAtIKKu0ayBrdWA9cJJaIn7v9Pl/ao
         Of/xv/ZpNvTYuXzHswylHMRdWwyYCDk+vc9yfXPFZm7OFj8VLGI3dxWaAG0/kXMpGu6L
         H/poxcsppwMkO0diMGCLGQ12Hi4kQwksora6CfgqXcIxiNHaXFuZWZYxSHR+vbTXqI+R
         65UQ==
X-Gm-Message-State: APjAAAXSznkFjI4t0qUjuKrIUXavtL473rH57J0B2Y2W0Hb71tEo4Qfe
        WG7SZIsH0Y68SDHnLtSCb0dT8Q1U0rCAvav9WSV+n+djiXrqEfTQnOKB49h2yBNlsHAA6V8c72T
        YqXMdyPxzWi7ELFTqJhGAswyN
X-Received: by 2002:ae9:c318:: with SMTP id n24mr10603486qkg.38.1578588030513;
        Thu, 09 Jan 2020 08:40:30 -0800 (PST)
X-Google-Smtp-Source: APXvYqyDVYHhz9ZSpnK4rVVgNRnHdbjFbv/jn4JOFdx9W3R587rNjBIdioKEtRvSFXqG5VWAVpZcXQ==
X-Received: by 2002:ae9:c318:: with SMTP id n24mr10603463qkg.38.1578588030295;
        Thu, 09 Jan 2020 08:40:30 -0800 (PST)
Received: from redhat.com (bzq-79-183-34-164.red.bezeqint.net. [79.183.34.164])
        by smtp.gmail.com with ESMTPSA id s27sm3265926qkm.97.2020.01.09.08.40.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2020 08:40:29 -0800 (PST)
Date:   Thu, 9 Jan 2020 11:40:23 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Peter Xu <peterx@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Christophe de Dinechin <dinechin@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Yan Zhao <yan.y.zhao@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Kevin Kevin <kevin.tian@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>
Subject: Re: [PATCH v3 00/21] KVM: Dirty ring interface
Message-ID: <20200109113001-mutt-send-email-mst@kernel.org>
References: <20200109145729.32898-1-peterx@redhat.com>
 <20200109105443-mutt-send-email-mst@kernel.org>
 <20200109161742.GC15671@xz-x1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200109161742.GC15671@xz-x1>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 09, 2020 at 11:17:42AM -0500, Peter Xu wrote:
> On Thu, Jan 09, 2020 at 10:59:50AM -0500, Michael S. Tsirkin wrote:
> > On Thu, Jan 09, 2020 at 09:57:08AM -0500, Peter Xu wrote:
> > > Branch is here: https://github.com/xzpeter/linux/tree/kvm-dirty-ring
> > > (based on kvm/queue)
> > > 
> > > Please refer to either the previous cover letters, or documentation
> > > update in patch 12 for the big picture.
> > 
> > I would rather you pasted it here. There's no way to respond otherwise.
> 
> Sure, will do in the next post.
> 
> > 
> > For something that's presumably an optimization, isn't there
> > some kind of testing that can be done to show the benefits?
> > What kind of gain was observed?
> 
> Since the interface seems to settle soon, maybe it's time to work on
> the QEMU part so I can give some number.  It would be interesting to
> know the curves between dirty logging and dirty ring even for some
> small vms that have some workloads inside.
> 
> > 
> > I know it's mostly relevant for huge VMs, but OTOH these
> > probably use huge pages.
> 
> Yes huge VMs could benefit more, especially if the dirty rate is not
> that high, I believe.  Though, could you elaborate on why huge pages
> are special here?
> 
> Thanks,

With hugetlbfs there are less bits to test: e.g. with 2M pages a single
bit set marks 512 pages as dirty.  We do not take advantage of this
but it looks like a rather obvious optimization.

> -- 
> Peter Xu

