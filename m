Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7195CC282DD
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 19:06:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4833E206DB
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 19:06:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fASnDFOv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729808AbgAHTGo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 14:06:44 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:31657 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727328AbgAHTGn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 14:06:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578510403;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aIsPQkefvKbs8Mx+H3weFs4lkNWqI+3u39gZ7NmRyAU=;
        b=fASnDFOvoAQWhp7H3x73gwkjx9V2BNhd2MxoGJXql0B3v77/7akBJe/LCqxMtj0s5IDxi0
        Xghi2CDDxVUyyC8KLet/p0ik57DeKAXQ2JoTxOs3urbxclhprq5mcj0hyiv1M8dtoRVY9V
        ZNfz9ejmxwUI5CiIjdivp+5xxJ3gy3U=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-365-Yxg9cIQSM4a7XNlezvjO8g-1; Wed, 08 Jan 2020 14:06:41 -0500
X-MC-Unique: Yxg9cIQSM4a7XNlezvjO8g-1
Received: by mail-qt1-f197.google.com with SMTP id b7so2617183qtg.23
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jan 2020 11:06:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=aIsPQkefvKbs8Mx+H3weFs4lkNWqI+3u39gZ7NmRyAU=;
        b=YDqzQjkEHv/LC9c/xl1nirTFTe+sgRUBmvgp45HREjCAMPIyYzCT9bln0h1ZZPp2v3
         RFz2u36qhHcNonC0lq4c6+bVERxn/W3aXGOUzNMXlV33IsBkaaRkOJocb/ckoymQp1mr
         MkNegiNkMa1LTai9ueKqo5CwCSzACuBEkM2ibuuzYUj6lfB59Wmh/+X7rjqpIb91xuE4
         HgQRlJ7sKOl5woOXe3VrGrxqAgHdbPs/po4hpM8TDvD3JarTUncd8kQl/HWeHqlsYrew
         xXxpbBR+/F+5sunVohO+c7lljVH7SuHxa7JRoPE7fiDKnWW/C2YGOxWCtPoArOMClajU
         Bfiw==
X-Gm-Message-State: APjAAAVd//EKCUey05Lp9xgYWKDD0Z9OCQop2wtcMNV3Xybsth/5fMSo
        7ejn3r01lNVUI03ZE3ehdjq1lhbYErGm4DAt05voFQcJfNdrsGmtWUTYiJWI+Eh7+U7V3zK/62z
        GqFmCcBJLPKAiX5C0SN7rNvuU
X-Received: by 2002:ac8:2c7d:: with SMTP id e58mr4971749qta.196.1578510401495;
        Wed, 08 Jan 2020 11:06:41 -0800 (PST)
X-Google-Smtp-Source: APXvYqzQzt09Rs7mLLYG5FgB+AsfdPFCtd6ICoe8Ea8YxVYAtfHSxrWhnYkBa0bOXlLt5LtDkKxP0g==
X-Received: by 2002:ac8:2c7d:: with SMTP id e58mr4971717qta.196.1578510401266;
        Wed, 08 Jan 2020 11:06:41 -0800 (PST)
Received: from xz-x1 ([104.156.64.74])
        by smtp.gmail.com with ESMTPSA id 65sm2020756qtf.95.2020.01.08.11.06.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2020 11:06:40 -0800 (PST)
Date:   Wed, 8 Jan 2020 14:06:39 -0500
From:   Peter Xu <peterx@redhat.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        Christophe de Dinechin <dinechin@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Lei Cao <lei.cao@stratus.com>
Subject: Re: [PATCH RESEND v2 08/17] KVM: X86: Implement ring-based dirty
 memory tracking
Message-ID: <20200108190639.GE7096@xz-x1>
References: <20191221014938.58831-1-peterx@redhat.com>
 <20191221014938.58831-9-peterx@redhat.com>
 <20200108155210.GA7096@xz-x1>
 <9f7582b1-cfba-d096-2216-c5b06edc6ca9@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9f7582b1-cfba-d096-2216-c5b06edc6ca9@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 08, 2020 at 06:41:06PM +0100, Paolo Bonzini wrote:
> On 08/01/20 16:52, Peter Xu wrote:
> > here, which is still a bit tricky to makeup the kvmgt issue.
> > 
> > Now we still have the waitqueue but it'll only be used for
> > no-vcpu-context dirtyings, so:
> > 
> > - For no-vcpu-context: thread could wait in the waitqueue if it makes
> >   vcpu0's ring soft-full (note, previously it was hard-full, so here
> >   we make it easier to wait so we make sure )
> > 
> > - For with-vcpu-context: we should never wait, guaranteed by the fact
> >   that KVM_RUN will return now if soft-full for that vcpu ring, and
> >   above waitqueue will make sure even vcpu0's waitqueue won't be
> >   filled up by kvmgt
> > 
> > Again this is still a workaround for kvmgt and I think it should not
> > be needed after the refactoring.  It's just a way to not depend on
> > that work so this should work even with current kvmgt.
> 
> The kvmgt patches were posted, you could just include them in your next
> series and clean everything up.  You can get them at
> https://patchwork.kernel.org/cover/11316219/.

Good to know!

Maybe I'll simply drop all the redundants in the dirty ring series
assuming it's there?  Since these patchsets should not overlap with
each other (so looks more like an ordering constraints for merging).

Thanks,

-- 
Peter Xu

