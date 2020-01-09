Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74A5BC33CA1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 19:09:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36DED2067D
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 19:09:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bJhJEPjm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388741AbgAITJE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 14:09:04 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:23671 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732258AbgAITJD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 14:09:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578596941;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Wn5Zuv80xKOsac1lq8/+TruwlKdERakoNi7IK73yy/E=;
        b=bJhJEPjmQLUHdDbknqPwk4TWawao7hWgB+WqwcdoKJzowLPksmCIgwfl6rJOZzzojYtZm9
        7UDSOpGt/V++QT5tRmC7GLi1IcaIlgNKUMR25jz0SWXMPErlUBrauPNUooO0K8VmDZx9Ik
        rbK4kgYNx0gTFoYnmVzWHHbxHUGIK1s=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-165-oTCvEOU-MgSqYWqLJ_jk_g-1; Thu, 09 Jan 2020 14:09:00 -0500
X-MC-Unique: oTCvEOU-MgSqYWqLJ_jk_g-1
Received: by mail-qk1-f198.google.com with SMTP id 194so4792433qkh.18
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jan 2020 11:09:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Wn5Zuv80xKOsac1lq8/+TruwlKdERakoNi7IK73yy/E=;
        b=eDm0BU1iFgT2QEryj+LP+QcXUEUiLZHB4st+5MGwL6EYFBNWQk427kH/cW6ESgXCUE
         rXRGmp+XUIiKEQJZzKimi6kjzlYXkHtwChZ5lLS+7Y45leO+JSX8uaT8Rc9R8DcQ1Hz5
         6+aIE4o2yTFM5BkZ8BUq3Vj6opA4So8HPFszrZh0Vl0OtFaDCvnu3kFH31yzmG/K/rF1
         lwZvVbPeV+J6io3lgehY7gXb1YFa7O3ziyKBGJDH6o579OYsRnwjobqh44SmDgpNpFB+
         Os7QxGAhWJ4ZLB3I+TAMrrfVSunvBcI8UTgDFiiDfZ5ftKtmdrGQk0WqzTOKJgWTPF/w
         U1wg==
X-Gm-Message-State: APjAAAUc98vQgdIZz6FlfWzJZkzm5QqfL+BkQwrDkJsujlL5wMGSyg0D
        ElQG9BDeCaVNB6mQDUlwOMXQnkOEkqahcpDkYI0ad3Anuhr1I+2d+/JhZJTO2TA/Ri92UDBGRrQ
        idD4CuXLbZqYTs7q+OCQDpI/L
X-Received: by 2002:a37:6706:: with SMTP id b6mr10292500qkc.461.1578596940070;
        Thu, 09 Jan 2020 11:09:00 -0800 (PST)
X-Google-Smtp-Source: APXvYqwLdjByYVhr9xxDwDxgAlgb4WngV9KzL1B4XjIChNcIFtx+pqdlEgKRsk5TjL575If71IHHaQ==
X-Received: by 2002:a37:6706:: with SMTP id b6mr10292474qkc.461.1578596939851;
        Thu, 09 Jan 2020 11:08:59 -0800 (PST)
Received: from redhat.com (bzq-79-183-34-164.red.bezeqint.net. [79.183.34.164])
        by smtp.gmail.com with ESMTPSA id p185sm3525999qkd.126.2020.01.09.11.08.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2020 11:08:58 -0800 (PST)
Date:   Thu, 9 Jan 2020 14:08:52 -0500
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
Message-ID: <20200109133434-mutt-send-email-mst@kernel.org>
References: <20200109145729.32898-1-peterx@redhat.com>
 <20200109105443-mutt-send-email-mst@kernel.org>
 <20200109161742.GC15671@xz-x1>
 <20200109113001-mutt-send-email-mst@kernel.org>
 <20200109170849.GB36997@xz-x1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200109170849.GB36997@xz-x1>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 09, 2020 at 12:08:49PM -0500, Peter Xu wrote:
> On Thu, Jan 09, 2020 at 11:40:23AM -0500, Michael S. Tsirkin wrote:
> 
> [...]
> 
> > > > I know it's mostly relevant for huge VMs, but OTOH these
> > > > probably use huge pages.
> > > 
> > > Yes huge VMs could benefit more, especially if the dirty rate is not
> > > that high, I believe.  Though, could you elaborate on why huge pages
> > > are special here?
> > > 
> > > Thanks,
> > 
> > With hugetlbfs there are less bits to test: e.g. with 2M pages a single
> > bit set marks 512 pages as dirty.  We do not take advantage of this
> > but it looks like a rather obvious optimization.
> 
> Right, but isn't that the trade-off between granularity of dirty
> tracking and how easy it is to collect the dirty bits?  Say, it'll be
> merely impossible to migrate 1G-huge-page-backed guests if we track
> dirty bits using huge page granularity, since each touch of guest
> memory will cause another 1G memory to be transferred even if most of
> the content is the same.  2M can be somewhere in the middle, but still
> the same write amplify issue exists.
>

OK I see I'm unclear.

IIUC at the moment KVM never uses huge pages if any part of the huge page is
tracked. But if all parts of the page are written to then huge page
is used.

In this situation the whole huge page is dirty and needs to be migrated.

> PS. that seems to be another topic after all besides the dirty ring
> series because we need to change our policy first if we want to track
> it with huge pages; with that, for dirty ring we can start to leverage
> the kvm_dirty_gfn.pad to store the page size with another new kvm cap
> when we really want.
> 
> Thanks,

Seems like leaking implementation detail to UAPI to me.


> -- 
> Peter Xu

