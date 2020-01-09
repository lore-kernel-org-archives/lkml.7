Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3E3BC282DD
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 19:21:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C24FD20678
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 19:21:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DH0BC3B8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729656AbgAITVW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 14:21:22 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:52207 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726048AbgAITVV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 14:21:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578597680;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=j2tAf7QlKP0UcMnNcnRoIe/IdCfZzwSv+ZT1733dh8k=;
        b=DH0BC3B85FAgNDjZ3EPw0u2JsLif8yVvXPAzeW4YXUogHRc8+zG3TfZG5ONupeHM3xZ1yz
        LwrcSq+WYIMEB6aCByna0XEAVSHMN/31s01e9pBUDLJDF1eBlpjKVa5ee67f77895oWZOP
        WiLVQsQj7iQ3DHHmYILZanqWl+3PIy4=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-218-TJsqclsQPoCWE7nzpFipVQ-1; Thu, 09 Jan 2020 14:21:19 -0500
X-MC-Unique: TJsqclsQPoCWE7nzpFipVQ-1
Received: by mail-qk1-f200.google.com with SMTP id 65so4806349qkl.23
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jan 2020 11:21:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=j2tAf7QlKP0UcMnNcnRoIe/IdCfZzwSv+ZT1733dh8k=;
        b=pDI+7Bx7Ty2xs6OfZ9syvSdH4WRPuJAYMuZPITk9foUIqxVOuMmGXBjREpy3Z98fZ5
         7ayc04KlWtd6ytk4odBOuDW4Ug9nYSp8RwdcQHgY90YEY5rMyj2lxTeTAsEW+EF5MGQQ
         8QcW4PuJYFwItaI1VKx7NUsp4YXh5/+okNTJejYjQIIeQ+yFXrKPtJXPS+895VVPMoyp
         N927ic729KCB9fIlsM7GCh4gO1/dOJ9HKpFu4xKJKUjz7+h/r30XY+TjfvxsJLvtsZvA
         7QmwlIc5tZ/XdDRyU77OQQbeqtiIReKMWarmuMEX7bgqfnV9ILe4fIY+JG2waFSuYQ/v
         JMAw==
X-Gm-Message-State: APjAAAUEDhqjqbqQf0QN5Tox40rJCvai8oWbvi8/xU4lFxAdjaXb8VCP
        lL7HeY3SjrTKh+yvcQDcC+V+/kp5pGHcWFjnBq1bNziVEKTs4xAMDf+rLSMYfwtngRWbp/mrCCW
        l1kkH7AyOu7xoDRgc7hbwgREx
X-Received: by 2002:a37:6346:: with SMTP id x67mr11035079qkb.476.1578597679027;
        Thu, 09 Jan 2020 11:21:19 -0800 (PST)
X-Google-Smtp-Source: APXvYqwJ35TMWe63REWoNUz+5ICtG0O7L8dcVMFxBucgetRoY5By4dNp471rkq6hwhw+GldcYm3TPA==
X-Received: by 2002:a37:6346:: with SMTP id x67mr11035052qkb.476.1578597678831;
        Thu, 09 Jan 2020 11:21:18 -0800 (PST)
Received: from xz-x1 ([104.156.64.74])
        by smtp.gmail.com with ESMTPSA id j4sm3140523qtv.53.2020.01.09.11.21.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2020 11:21:17 -0800 (PST)
Date:   Thu, 9 Jan 2020 14:21:16 -0500
From:   Peter Xu <peterx@redhat.com>
To:     Alex Williamson <alex.williamson@redhat.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Christophe de Dinechin <dinechin@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Yan Zhao <yan.y.zhao@intel.com>,
        Jason Wang <jasowang@redhat.com>,
        Kevin Kevin <kevin.tian@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        Lei Cao <lei.cao@stratus.com>
Subject: Re: [PATCH v3 12/21] KVM: X86: Implement ring-based dirty memory
 tracking
Message-ID: <20200109192116.GE36997@xz-x1>
References: <20200109145729.32898-1-peterx@redhat.com>
 <20200109145729.32898-13-peterx@redhat.com>
 <20200109110110-mutt-send-email-mst@kernel.org>
 <20200109095610.167cd9f0@w520.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200109095610.167cd9f0@w520.home>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 09, 2020 at 09:56:10AM -0700, Alex Williamson wrote:

[...]

> > > +Dirty GFNs (Guest Frame Numbers) are stored in the dirty_gfns array.
> > > +For each of the dirty entry it's defined as:
> > > +
> > > +struct kvm_dirty_gfn {
> > > +        __u32 pad;  
> > 
> > How about sticking a length here?
> > This way huge pages can be dirtied in one go.
> 
> Not just huge pages, but any contiguous range of dirty pages could be
> reported far more concisely.  Thanks,

I replied in the other thread on why I thought KVM might not suite
that (while vfio may).

Actually we can even do that for KVM as long as we keep a per-vcpu
last-dirtied GFN range cache (so we don't publish a dirty GFN right
after it's dirtied), then we grow that cached dirtied range as long as
the continuous next/previous page is dirtied.  If we found that the
current dirty GFN is not continuous to the cached range, we publish
the cached range and let the new GFN be the starting of last-dirtied
GFN range cache.

However I am not sure how much we'll gain from it.  Maybe we can do
that when we have a real use case for it.  For now I'm not sure
whether it would worth the effort.

Thanks,

-- 
Peter Xu

