Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70A7CC43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 15:08:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4304B206D7
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 15:08:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VFSw4NDt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728309AbfLPPIC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 10:08:02 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:59517 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728109AbfLPPIB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 10:08:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576508880;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AaYS2d/uqJ46OLZ/1yehXsn/hccZMKnfSM509Os6C9g=;
        b=VFSw4NDthCFlshRJzj/ySHqpxi7Lla4Yc9u4AiLJP5DTNrfWmmMy3WJDagPvzVe0BDkQc1
        j0V6fFuwJPUI798zwzAUvvW04yWB8qeODJ5BAgs23f0qCvF5sZdzOXNP9XkdiUEFhkusUU
        rKkahV/Ib7PyDZ3QU1tmkKE82KNOjhg=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-340-zveWtJhwOGuRg1iqWa_FSg-1; Mon, 16 Dec 2019 10:07:55 -0500
X-MC-Unique: zveWtJhwOGuRg1iqWa_FSg-1
Received: by mail-qt1-f200.google.com with SMTP id l4so4765500qte.18
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2019 07:07:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=AaYS2d/uqJ46OLZ/1yehXsn/hccZMKnfSM509Os6C9g=;
        b=IC98AC2eqXt9ABWWZyFdRfFtmH4RQRpTi9xZa4+SJx8BSDEhQ131ubAmPK5RaZrvFB
         XVxRgWyaMCoSoHdzRgeTQP/gz8k0t6uO5HO8VJDlb4GGt0HnZ4yoBh0spKwCqiPj1WM7
         5SjKMD7hOzQxzS7Md6QzGUf5bEr/0bY0REVcBpS6pp42ZHMLdzYrrRvxvvdKhoiv37Ds
         X0Rk35w9DcHk34wmovOJtiOne+N7UAMhXuut/hjqxCIo9ukVUO0J09qn/PGvmmWYv0CD
         4zlT39C7C85QADZ1YK3i5bnIYKs28gKg+fyrpG1WS79b/S979J6cb+1pr51vb6mhUL0q
         4DYw==
X-Gm-Message-State: APjAAAXGIQeZhRjxpJTdbXh2v2gUXyw2DLKRCliiq6ltB4bRQF+fod42
        uzhXsHrWVRLyYIVL8ayBTTLujaWXEcxaU/eV37AlFfoukdB8IQZyTcfA+yxG2UX10GKwtsKqyBm
        ZUQ+0+zKBetWrGwHFkWHmpqas
X-Received: by 2002:ac8:787:: with SMTP id l7mr18610234qth.99.1576508875502;
        Mon, 16 Dec 2019 07:07:55 -0800 (PST)
X-Google-Smtp-Source: APXvYqwYfnL3o3dLmvysdxBkpTp3PrdiWzj1LMSkxOlgD/ePz+FfCYUR507X8Dna+HG79+AXJS7/Tg==
X-Received: by 2002:ac8:787:: with SMTP id l7mr18610206qth.99.1576508875250;
        Mon, 16 Dec 2019 07:07:55 -0800 (PST)
Received: from xz-x1 (CPEf81d0fb19163-CMf81d0fb19160.cpe.net.fido.ca. [72.137.123.47])
        by smtp.gmail.com with ESMTPSA id w1sm5343645qtk.31.2019.12.16.07.07.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2019 07:07:54 -0800 (PST)
Date:   Mon, 16 Dec 2019 10:07:54 -0500
From:   Peter Xu <peterx@redhat.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>
Subject: Re: [PATCH RFC 04/15] KVM: Implement ring-based dirty memory tracking
Message-ID: <20191216150754.GC83861@xz-x1>
References: <20191129213505.18472-1-peterx@redhat.com>
 <20191129213505.18472-5-peterx@redhat.com>
 <20191211063830-mutt-send-email-mst@kernel.org>
 <20191211205952.GA5091@xz-x1>
 <20191211172713-mutt-send-email-mst@kernel.org>
 <46ceb88c-0ddd-0d9a-7128-3aa5a7d9d233@redhat.com>
 <20191215173302.GB83861@xz-x1>
 <20191216044619-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191216044619-mutt-send-email-mst@kernel.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 16, 2019 at 04:47:36AM -0500, Michael S. Tsirkin wrote:
> On Sun, Dec 15, 2019 at 12:33:02PM -0500, Peter Xu wrote:
> > On Thu, Dec 12, 2019 at 01:08:14AM +0100, Paolo Bonzini wrote:
> > > >>> What depends on what here? Looks suspicious ...
> > > >>
> > > >> Hmm, I think maybe it can be removed because the entry pointer
> > > >> reference below should be an ordering constraint already?
> > > 
> > > entry->xxx depends on ring->reset_index.
> > 
> > Yes that's true, but...
> > 
> >         entry = &ring->dirty_gfns[ring->reset_index & (ring->size - 1)];
> >         /* barrier? */
> >         next_slot = READ_ONCE(entry->slot);
> >         next_offset = READ_ONCE(entry->offset);
> > 
> > ... I think entry->xxx depends on entry first, then entry depends on
> > reset_index.  So it seems fine because all things have a dependency?
> 
> Is reset_index changed from another thread then?
> If yes then you want to read reset_index with READ_ONCE.
> That includes a dependency barrier.

There're a few readers, but only this function will change it
(kvm_dirty_ring_reset).  Thanks,

-- 
Peter Xu

