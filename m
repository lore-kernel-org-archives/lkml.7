Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B39ADC282DD
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 17:08:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82AEA2067D
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 17:08:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Rsp1qbnb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387971AbgAIRIz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 12:08:55 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:28159 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2387629AbgAIRIz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 12:08:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578589733;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NNEsFj/o0jBF/fCYORNopN7APt59GO74aaqbRZLn7eo=;
        b=Rsp1qbnblWIFDOn5Wqy8eCmuIqDJgeM5qOGx0+WpNBG53/dm4zwb6ZXrfzsa7sd5d01rFY
        43hlPUP0WrzwT215bo7hLFyfRghsjvyukk1dY4QeDFSkZg2KLVeWSw8D05PM46WxNbHeCW
        6EfW+I0zdj4aAQKo3hxoxRgcNEtbPoo=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-325-999TfOfqPGutqZtBHTAekQ-1; Thu, 09 Jan 2020 12:08:52 -0500
X-MC-Unique: 999TfOfqPGutqZtBHTAekQ-1
Received: by mail-qk1-f197.google.com with SMTP id a73so4600154qkg.5
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jan 2020 09:08:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NNEsFj/o0jBF/fCYORNopN7APt59GO74aaqbRZLn7eo=;
        b=eTMWE2M4UneXXZc89oPaVSvnayXFFfqNMNOwONmDIWS34asMamGsU1j5hqVv6asPom
         +S+pN2y6F2t9UguXPNVlZo1Ib8/QEb67WGGuWaoQ/WSyjp1LJ8g6rqzK1jA0qLsd+iZv
         aHmw0U3dOVB/fDqdzwcj4S1uihZDq/b7jrCf919FxvkUbeguOMInUM99e+/uLpE2vAin
         SPVFEXFtrkFq9PSiQAVymsnxCeTZKyXYyNfmiKvbzQC+9GiZuqBfQ8u+AfUOHWqGbn34
         gHTWC+hqgih9GiFs4jkAumjDpCQjpHzot+10XUORo//KLnA0vRo/y6FOurmB7nf+G7Ye
         ef1A==
X-Gm-Message-State: APjAAAXrabejg9JWykMYTyAF9sIwTXRfcEQ3DejJDbj72YByhmQduQw/
        b7OYpXgseJ4PRkpmVFfjsckDsQ3AqWswx0MHbjmwodrbNOl/M71t8sEYv/o6N9gCcrFzxy8Ah5y
        mQ5w4NXfNQ3DwEq3wlZqUWPoU
X-Received: by 2002:ac8:59:: with SMTP id i25mr8915421qtg.110.1578589731665;
        Thu, 09 Jan 2020 09:08:51 -0800 (PST)
X-Google-Smtp-Source: APXvYqxmi+GInpmAyf4dUoy+x6coGpcUyilqGJsYyHvmUNTmQpEgNWR+lquAycQvqlL2YFSE84UNug==
X-Received: by 2002:ac8:59:: with SMTP id i25mr8915400qtg.110.1578589731447;
        Thu, 09 Jan 2020 09:08:51 -0800 (PST)
Received: from xz-x1 ([104.156.64.74])
        by smtp.gmail.com with ESMTPSA id h34sm3670383qtc.62.2020.01.09.09.08.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2020 09:08:50 -0800 (PST)
Date:   Thu, 9 Jan 2020 12:08:49 -0500
From:   Peter Xu <peterx@redhat.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
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
Message-ID: <20200109170849.GB36997@xz-x1>
References: <20200109145729.32898-1-peterx@redhat.com>
 <20200109105443-mutt-send-email-mst@kernel.org>
 <20200109161742.GC15671@xz-x1>
 <20200109113001-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200109113001-mutt-send-email-mst@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 09, 2020 at 11:40:23AM -0500, Michael S. Tsirkin wrote:

[...]

> > > I know it's mostly relevant for huge VMs, but OTOH these
> > > probably use huge pages.
> > 
> > Yes huge VMs could benefit more, especially if the dirty rate is not
> > that high, I believe.  Though, could you elaborate on why huge pages
> > are special here?
> > 
> > Thanks,
> 
> With hugetlbfs there are less bits to test: e.g. with 2M pages a single
> bit set marks 512 pages as dirty.  We do not take advantage of this
> but it looks like a rather obvious optimization.

Right, but isn't that the trade-off between granularity of dirty
tracking and how easy it is to collect the dirty bits?  Say, it'll be
merely impossible to migrate 1G-huge-page-backed guests if we track
dirty bits using huge page granularity, since each touch of guest
memory will cause another 1G memory to be transferred even if most of
the content is the same.  2M can be somewhere in the middle, but still
the same write amplify issue exists.

PS. that seems to be another topic after all besides the dirty ring
series because we need to change our policy first if we want to track
it with huge pages; with that, for dirty ring we can start to leverage
the kvm_dirty_gfn.pad to store the page size with another new kvm cap
when we really want.

Thanks,

-- 
Peter Xu

