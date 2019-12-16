Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92E9FC43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 15:33:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6613020717
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 15:33:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CvItLLLF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728399AbfLPPdw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 10:33:52 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:44473 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728280AbfLPPdw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 10:33:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576510430;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Z0ykzv4O9XDflANBBucUp6ssbent/uqQftfOjZxhGN0=;
        b=CvItLLLFf9H0OcxsysiMIYLsVR993UsqrVKMkYsTASsyRTNbjoURpshFMP1kK9iGXKnGaQ
        mg5uX2nXfGMYeE3HPJlDj7wxZ9s3bQy4jMzWVKalFf4vzitTXsxrQ/SHuBWBh4HWbtdnWz
        Aq0+rKZ8agxql3pc30/68RGVyfBb0AU=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-280-R_s1NlYMOwem18pCbqPcqw-1; Mon, 16 Dec 2019 10:33:49 -0500
X-MC-Unique: R_s1NlYMOwem18pCbqPcqw-1
Received: by mail-qt1-f198.google.com with SMTP id z12so244584qts.15
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2019 07:33:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Z0ykzv4O9XDflANBBucUp6ssbent/uqQftfOjZxhGN0=;
        b=E1po9uamIFPsMIznCtJUr77hB8GHVnnXrBu6CiB/EkD8p6nHSPZPxNjOK7MCSOSskZ
         Ohlmka4gcChP3pumNdUKDNCEjDighUwh9lf9TpM4kuRAD00tjhTkuUSB1L0WHtVwaxa7
         DWhfbG85XntBaYT91gJM3za13j+yLprdsnSr/xvRX85jzCBOUiGyNKlkQKSSM5elZ7Cj
         /W6Jv2Z645ATLT87Rt849XILNJNs5HEuX7iX4xvtd26p0VWCbFyIpERAC7F2y2L10txc
         yNNR2LNAvvN/l8Hu+rUOh8Z6fGmzasfJT3X6ICeNCgA4FZgZCROIAzYEJh6dusR+/X0D
         aVMQ==
X-Gm-Message-State: APjAAAUfMx+9MDiAhelw0tUxkceECk1LqfenB7JYUTMn+hzCkMKleSuu
        WrO+qSuS5/dZLADKQXVRxN2u7VLwYcW5C7SjoC0wRtNyNTOnYFxjUuG3/DVgf+xq1RQ1BMw7ZZ4
        l+Z25quXF7yFDajys3jm6HHm3
X-Received: by 2002:a05:620a:b18:: with SMTP id t24mr27387986qkg.341.1576510428730;
        Mon, 16 Dec 2019 07:33:48 -0800 (PST)
X-Google-Smtp-Source: APXvYqwYwsAN4Q+QC29+/ynoBvhgn+sVgs19/Aa51xUTnXtyYxuSUmHPy54H02pcDC57nW5rMIQk2w==
X-Received: by 2002:a05:620a:b18:: with SMTP id t24mr27387965qkg.341.1576510428508;
        Mon, 16 Dec 2019 07:33:48 -0800 (PST)
Received: from redhat.com ([212.199.108.238])
        by smtp.gmail.com with ESMTPSA id b191sm6118550qkg.43.2019.12.16.07.33.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2019 07:33:47 -0800 (PST)
Date:   Mon, 16 Dec 2019 10:33:42 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Peter Xu <peterx@redhat.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>
Subject: Re: [PATCH RFC 04/15] KVM: Implement ring-based dirty memory tracking
Message-ID: <20191216103251-mutt-send-email-mst@kernel.org>
References: <20191129213505.18472-1-peterx@redhat.com>
 <20191129213505.18472-5-peterx@redhat.com>
 <20191211063830-mutt-send-email-mst@kernel.org>
 <20191211205952.GA5091@xz-x1>
 <20191211172713-mutt-send-email-mst@kernel.org>
 <46ceb88c-0ddd-0d9a-7128-3aa5a7d9d233@redhat.com>
 <20191215173302.GB83861@xz-x1>
 <20191216044619-mutt-send-email-mst@kernel.org>
 <20191216150754.GC83861@xz-x1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191216150754.GC83861@xz-x1>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 16, 2019 at 10:07:54AM -0500, Peter Xu wrote:
> On Mon, Dec 16, 2019 at 04:47:36AM -0500, Michael S. Tsirkin wrote:
> > On Sun, Dec 15, 2019 at 12:33:02PM -0500, Peter Xu wrote:
> > > On Thu, Dec 12, 2019 at 01:08:14AM +0100, Paolo Bonzini wrote:
> > > > >>> What depends on what here? Looks suspicious ...
> > > > >>
> > > > >> Hmm, I think maybe it can be removed because the entry pointer
> > > > >> reference below should be an ordering constraint already?
> > > > 
> > > > entry->xxx depends on ring->reset_index.
> > > 
> > > Yes that's true, but...
> > > 
> > >         entry = &ring->dirty_gfns[ring->reset_index & (ring->size - 1)];
> > >         /* barrier? */
> > >         next_slot = READ_ONCE(entry->slot);
> > >         next_offset = READ_ONCE(entry->offset);
> > > 
> > > ... I think entry->xxx depends on entry first, then entry depends on
> > > reset_index.  So it seems fine because all things have a dependency?
> > 
> > Is reset_index changed from another thread then?
> > If yes then you want to read reset_index with READ_ONCE.
> > That includes a dependency barrier.
> 
> There're a few readers, but only this function will change it
> (kvm_dirty_ring_reset).  Thanks,

Then you don't need any barriers in this function.
readers need at least READ_ONCE.

> -- 
> Peter Xu

