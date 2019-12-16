Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 296E4C43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 15:47:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0064F206E0
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 15:47:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Sgdn5pob"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728480AbfLPPru (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 10:47:50 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:47090 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728328AbfLPPrt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 10:47:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576511267;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RgWQhpsAIADMZAP/1x3HqNJ9NVK8air/mo1dw8k/m4w=;
        b=Sgdn5pobUJ/ivfiBFRND0qiM5Eml3tJI4q1vuQemXgxXjnfrNGkvm3s4kCtkTFGXecGlZn
        aL4xTgtNibbXWwjLTHs4hVk1S1u6l5SrtW/FX8e6fYp2O2JgUzOJK48KZFnYrvIv5DQ1QK
        kgrP62TPXjvdSoONG/Lle+PqJRqi1Kc=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-436-ZfP21KXwNgaSecTEQa4hGA-1; Mon, 16 Dec 2019 10:47:44 -0500
X-MC-Unique: ZfP21KXwNgaSecTEQa4hGA-1
Received: by mail-qv1-f70.google.com with SMTP id l1so5516671qvu.13
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2019 07:47:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RgWQhpsAIADMZAP/1x3HqNJ9NVK8air/mo1dw8k/m4w=;
        b=cdAhcF29TWonSVC4arTqQSq1QFKXIfMvXhKw7abyxJLRXJnTajrAxm9+Cm+hXKZtvw
         vI92cH2MX3jEbD9xkf2fSgfqh/PjQ5jsZFETj1eM4kFP30v0vHGJT+WBeZplwCbL1DHc
         kORry/3povGOSO6Dqe8Lx/sgegzmDkHXVxEH4cU/VKQfY8P7/IUfQ/VsMMqIzCdQWUEP
         VjX6SO9bLAY9wgQg6D7P2ndcQYkQryfdgJ9y8s/gSJyx0p4x83eR8B7/khtCZ0JoJL0k
         1IR93eLkREHotClBUyVgeX8bUhxAymZK+A1/IALl1BN7c9YAGXvrStEhrwFm1+N9SpMP
         YXcw==
X-Gm-Message-State: APjAAAUYvUGlk+rRJarMZ0Ong3cQs6nvn14tgh3vgGHbfsP0WmTtepuF
        2Zf/vZoWz9wub77MwC+hDBfrG9xrDcl16x4SPTGCw/lrz6k1Uhcahdg6mPiZTbjOMrjwQbGxlY4
        o7KF470BwykcsFPDTpelHTxkk
X-Received: by 2002:a05:6214:108a:: with SMTP id o10mr26486295qvr.246.1576511264400;
        Mon, 16 Dec 2019 07:47:44 -0800 (PST)
X-Google-Smtp-Source: APXvYqx1PDmhMHZHSnB6wuEZN9qkZjX10yPTV1uCaDq6nRhK2p6zGEl4P7bhy8kKpOy1w0Z1WWcikg==
X-Received: by 2002:a05:6214:108a:: with SMTP id o10mr26486280qvr.246.1576511264193;
        Mon, 16 Dec 2019 07:47:44 -0800 (PST)
Received: from xz-x1 ([104.156.64.75])
        by smtp.gmail.com with ESMTPSA id b7sm6059467qkh.106.2019.12.16.07.47.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2019 07:47:42 -0800 (PST)
Date:   Mon, 16 Dec 2019 10:47:42 -0500
From:   Peter Xu <peterx@redhat.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>
Subject: Re: [PATCH RFC 04/15] KVM: Implement ring-based dirty memory tracking
Message-ID: <20191216154742.GF83861@xz-x1>
References: <20191129213505.18472-1-peterx@redhat.com>
 <20191129213505.18472-5-peterx@redhat.com>
 <20191211063830-mutt-send-email-mst@kernel.org>
 <20191211205952.GA5091@xz-x1>
 <20191211172713-mutt-send-email-mst@kernel.org>
 <46ceb88c-0ddd-0d9a-7128-3aa5a7d9d233@redhat.com>
 <20191215173302.GB83861@xz-x1>
 <20191216044619-mutt-send-email-mst@kernel.org>
 <20191216150754.GC83861@xz-x1>
 <20191216103251-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191216103251-mutt-send-email-mst@kernel.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 16, 2019 at 10:33:42AM -0500, Michael S. Tsirkin wrote:
> On Mon, Dec 16, 2019 at 10:07:54AM -0500, Peter Xu wrote:
> > On Mon, Dec 16, 2019 at 04:47:36AM -0500, Michael S. Tsirkin wrote:
> > > On Sun, Dec 15, 2019 at 12:33:02PM -0500, Peter Xu wrote:
> > > > On Thu, Dec 12, 2019 at 01:08:14AM +0100, Paolo Bonzini wrote:
> > > > > >>> What depends on what here? Looks suspicious ...
> > > > > >>
> > > > > >> Hmm, I think maybe it can be removed because the entry pointer
> > > > > >> reference below should be an ordering constraint already?
> > > > > 
> > > > > entry->xxx depends on ring->reset_index.
> > > > 
> > > > Yes that's true, but...
> > > > 
> > > >         entry = &ring->dirty_gfns[ring->reset_index & (ring->size - 1)];
> > > >         /* barrier? */
> > > >         next_slot = READ_ONCE(entry->slot);
> > > >         next_offset = READ_ONCE(entry->offset);
> > > > 
> > > > ... I think entry->xxx depends on entry first, then entry depends on
> > > > reset_index.  So it seems fine because all things have a dependency?
> > > 
> > > Is reset_index changed from another thread then?
> > > If yes then you want to read reset_index with READ_ONCE.
> > > That includes a dependency barrier.
> > 
> > There're a few readers, but only this function will change it
> > (kvm_dirty_ring_reset).  Thanks,
> 
> Then you don't need any barriers in this function.
> readers need at least READ_ONCE.

In our case even an old reset_index should not matter much here imho
because the worst case is we read an old reset so we stop pushing to a
ring when it's just being reset and at the same time it's soft-full
(so an extra user exit even race happened).  But I agree it's clearer
to READ_ONCE() on readers.  Thanks!

-- 
Peter Xu

