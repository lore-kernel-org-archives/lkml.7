Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8198EC43603
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 21:59:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 514A921D7D
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 21:59:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZobevB9e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726994AbfLRV7J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 16:59:09 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:29389 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727505AbfLRV7E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 16:59:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576706343;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xyRq0uSWZtoF1xSeEB8lICjPIcYYqv0mpEMiHQwYmsc=;
        b=ZobevB9evxz2RgIMe+dHIFnQWUUaXf9xhegU6owLqq3OdoVW8c4u7i36HIckZwYMGu3kj3
        aYE4x8QrTir48rqJIPhFhEIbwnKvAqnycAtvqnDMi2teXwYvw5P2Rkn30ZcD3/gxjCHhZf
        +eNCpTUn5fQD/QdVRSHHGa8LUob4kq0=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-280-AI67nVF-N920XRFMH7kMRA-1; Wed, 18 Dec 2019 16:59:00 -0500
X-MC-Unique: AI67nVF-N920XRFMH7kMRA-1
Received: by mail-qv1-f70.google.com with SMTP id d7so2298923qvq.12
        for <linux-kernel@vger.kernel.org>; Wed, 18 Dec 2019 13:59:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xyRq0uSWZtoF1xSeEB8lICjPIcYYqv0mpEMiHQwYmsc=;
        b=T8tQofdGnKlTEn4eoYXNwGNzZDkuny7/edml+4nz5EbpyANj69DKUKAU0nH9E3/d+1
         kEuB5L0gfPhpzApa/gGwWS+gGGzu5O6zyzmNMjzlEusmd20Ogaa3WWH49TXtlPAlaGou
         SCrGEmVK4rgW4C3Q8rJBrBiJUykGogFWvnU3n0NNTNOKOs90n8M4kJ03WFAScLFdb5Z9
         MeF38NganVmE5vRQpdhmN1ANZQrYUgkVfdnoTBaFGKdJ4sTAx7Q7N2F5D/UgXj4zRovG
         HsJPtSrJ3L6+qEpwGI9LljlA2qj/cMgT26DsMwu2vq3a076nHWiCPGxpso3+AsCZZ0/k
         2eWQ==
X-Gm-Message-State: APjAAAUpfVPD9+sDGypf8rxWicC3PzeYrf/UB8QF6acbLMuIOCOaWjjN
        aEMiAAgp2UUZKxovMfA48vEGNpX/WwEjj+J1L5jh++eL3oo565RvuKJu+OfIX9W5XP0Odcf/obu
        RhY9EkcLLT7LMSpZsgJtfZHK1
X-Received: by 2002:a37:4905:: with SMTP id w5mr4969504qka.267.1576706340079;
        Wed, 18 Dec 2019 13:59:00 -0800 (PST)
X-Google-Smtp-Source: APXvYqzVX8iG95niunFTpS5tBBbhXdu5Y9XJU2Owx29mSQ+hRkMsBGZvfhvamN55CSq/5e+E+hVhyg==
X-Received: by 2002:a37:4905:: with SMTP id w5mr4969484qka.267.1576706339769;
        Wed, 18 Dec 2019 13:58:59 -0800 (PST)
Received: from xz-x1 ([104.156.64.74])
        by smtp.gmail.com with ESMTPSA id e2sm1066715qkb.112.2019.12.18.13.58.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2019 13:58:58 -0800 (PST)
Date:   Wed, 18 Dec 2019 16:58:57 -0500
From:   Peter Xu <peterx@redhat.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        "Tian, Kevin" <kevin.tian@intel.com>
Subject: Re: [PATCH RFC 04/15] KVM: Implement ring-based dirty memory tracking
Message-ID: <20191218215857.GE26669@xz-x1>
References: <20191209215400.GA3352@xz-x1>
 <affd9d84-1b84-0c25-c431-a075c58c33dc@redhat.com>
 <20191210155259.GD3352@xz-x1>
 <3e6cb5ec-66c0-00ab-b75e-ad2beb1d216d@redhat.com>
 <20191215172124.GA83861@xz-x1>
 <f117d46a-7528-ce32-8e46-4f3f35937079@redhat.com>
 <20191216185454.GG83861@xz-x1>
 <815923d9-2d48-2915-4acb-97eb90996403@redhat.com>
 <20191217162405.GD7258@xz-x1>
 <c01d0732-2172-2573-8251-842e94da4cfc@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c01d0732-2172-2573-8251-842e94da4cfc@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 17, 2019 at 05:28:54PM +0100, Paolo Bonzini wrote:
> On 17/12/19 17:24, Peter Xu wrote:
> >> No, please pass it all the way down to the [&] functions but not to
> >> kvm_write_guest_page.  Those should keep using vcpu->kvm.
> > Actually I even wanted to refactor these helpers.  I mean, we have two
> > sets of helpers now, kvm_[vcpu]_{read|write}*(), so one set is per-vm,
> > the other set is per-vcpu.  IIUC the only difference of these two are
> > whether we should consider ((vcpu)->arch.hflags & HF_SMM_MASK) or we
> > just write to address space zero always.
> 
> Right.
> 
> > Could we unify them into a
> > single set of helper (I'll just drop the *_vcpu_* helpers because it's
> > longer when write) but we always pass in vcpu* as the first parameter?
> > Then we add another parameter "vcpu_smm" to show whether we want to
> > consider the HF_SMM_MASK flag.
> 
> You'd have to check through all KVM implementations whether you always
> have the vCPU.  Also non-x86 doesn't have address spaces, and by the
> time you add ", true" or ", false" it's longer than the "_vcpu_" you
> have removed.  So, not a good idea in my opinion. :D

Well, now I've changed my mind. :) (considering that we still have
many places that will not have vcpu*...)

I can simply add that "vcpu_smm" parameter to kvm_vcpu_write_*()
without removing the kvm_write_*() helpers.  Then I'll be able to
convert most of the kvm_write_*() (or its family) callers to
kvm_vcpu_write*(..., vcpu_smm=false) calls where proper.

Would that be good?

-- 
Peter Xu

