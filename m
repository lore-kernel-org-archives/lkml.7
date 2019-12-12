Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A53ADC43603
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 07:36:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72D5122527
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 07:36:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FwRxY825"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728174AbfLLHgW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 02:36:22 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:36457 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728119AbfLLHgW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 02:36:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576136180;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9cfkJ5Ufa4kjVWWnLFP633QavJjP7jRiWlpS2WvklvE=;
        b=FwRxY825+60vc9PmQ+bC0sSetwjaqE2Qy1vBtRNvosfgHiwrdtuhMYbM2r2WnQ7hi0hwW5
        lkCEC01iOk++kjZvG0u5E5drPU1EETCmiQaAfKrlHCmP0tU4psc82lp/XRpVDA20fpd18N
        OnP/sSVBOG2dUw4qCCFm/Uaapy7L5u4=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-46-1xqflhsjNd2aiE43vt_Ypw-1; Thu, 12 Dec 2019 02:36:19 -0500
X-MC-Unique: 1xqflhsjNd2aiE43vt_Ypw-1
Received: by mail-qv1-f72.google.com with SMTP id l1so926814qvu.13
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2019 23:36:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9cfkJ5Ufa4kjVWWnLFP633QavJjP7jRiWlpS2WvklvE=;
        b=kh1SAeU3kjL2qwF0TVTrG+DqxEDMwaUkMrcpFxswBZkCTHCfPBudHY1tChSUJbuJzu
         tzVWOOKcAAKRGWdDQYZ+maEz4LsQMF2IhtpxUxjQ2M0OglaRutIXpWV7lq9+De1MlnoN
         s0SxdP5LubUCodmHMge54Bgv8HVBZ8U1KN1q7kpup4zP6TLdgkaHMWdmt8DapUtIz63o
         YBuqYTxUNTDkoihaTilPsb4JjLCcsX2Cl94lXuyXvfWm2aPOUHIwryNNgnj6KBIBrv59
         2pDW57olu6SQhN1C5RJodAuINyS5nbtbRv1amKQGjX/a3DZJtyeNlJ3tweb2E7OvugLH
         Jj+w==
X-Gm-Message-State: APjAAAXN7O5jzefCnpdtZAzvB6ZphXuzK58zAPwbWyeldZaiIIMBlkYA
        OVFp3PNwMeTZztEtLZ5yPtF0IX7u3ndo1wo0RI7NuWdQY3rYm4+I+/lM57HBRvYyvdT9jEzlutb
        rldAjTkd81DZeKUj4oLa7SLnk
X-Received: by 2002:a0c:f8d1:: with SMTP id h17mr7051926qvo.80.1576136179096;
        Wed, 11 Dec 2019 23:36:19 -0800 (PST)
X-Google-Smtp-Source: APXvYqy7n0VUXHhGOLoe1r/B4ld1vL6rsAl2Bm1uyVdOAyJr+xL+CjdY0j5Wt0fgQ0y+22OgYTq+sg==
X-Received: by 2002:a0c:f8d1:: with SMTP id h17mr7051910qvo.80.1576136178889;
        Wed, 11 Dec 2019 23:36:18 -0800 (PST)
Received: from redhat.com (bzq-79-181-48-215.red.bezeqint.net. [79.181.48.215])
        by smtp.gmail.com with ESMTPSA id j15sm1530212qtn.37.2019.12.11.23.36.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2019 23:36:17 -0800 (PST)
Date:   Thu, 12 Dec 2019 02:36:13 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Peter Xu <peterx@redhat.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>
Subject: Re: [PATCH RFC 04/15] KVM: Implement ring-based dirty memory tracking
Message-ID: <20191212023154-mutt-send-email-mst@kernel.org>
References: <20191129213505.18472-1-peterx@redhat.com>
 <20191129213505.18472-5-peterx@redhat.com>
 <20191211063830-mutt-send-email-mst@kernel.org>
 <20191211205952.GA5091@xz-x1>
 <20191211172713-mutt-send-email-mst@kernel.org>
 <46ceb88c-0ddd-0d9a-7128-3aa5a7d9d233@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <46ceb88c-0ddd-0d9a-7128-3aa5a7d9d233@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 12, 2019 at 01:08:14AM +0100, Paolo Bonzini wrote:
> >> I'd say it won't be a big issue on locking 1/2M of host mem for a
> >> vm...
> >> Also note that if dirty ring is enabled, I plan to evaporate the
> >> dirty_bitmap in the next post. The old kvm->dirty_bitmap takes
> >> $GUEST_MEM/32K*2 mem.  E.g., for 64G guest it's 64G/32K*2=4M.  If with
> >> dirty ring of 8 vcpus, that could be 64K*8=0.5M, which could be even
> >> less memory used.
> > 
> > Right - I think Avi described the bitmap in kernel memory as one of
> > design mistakes. Why repeat that with the new design?
> 
> Do you have a source for that?

Nope, it was a private talk.

> At least the dirty bitmap has to be
> accessed from atomic context so it seems unlikely that it can be moved
> to user memory.

Why is that? We could surely do it from VCPU context?

> The dirty ring could use user memory indeed, but it would be much harder
> to set up (multiple ioctls for each ring?  what to do if userspace
> forgets one? etc.).

Why multiple ioctls? If you do like virtio packed ring you just need the
base and the size.

-- 
MST

