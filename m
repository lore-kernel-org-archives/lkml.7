Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 774FFC33CA2
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 19:37:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46F80206ED
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 19:37:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OmyXfLOZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731167AbgAIThG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 14:37:06 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:23834 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729854AbgAIThG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 14:37:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578598625;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=u2L+6QoH0unQY1zZnaaxRdBowT9MR5BCuv5QzmnWT7U=;
        b=OmyXfLOZO+NTzgYZAeJirVFSrxR9ChVx3LcpJtJZhJeu+WwtCLbBfFanNEd/kSn7Xz5Acr
        Nxqp/MQg7qGCtfwngPlk9P+mqbwRSDvDetLHz6TCHkxQo5cCnCGwsLgbKEgnTQxGpVW+Io
        Q7BX1SxHregFpgFeVZxUEHmK/Tvyp7w=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-105-BSjt9MTFPGCqt-sKEjcRXg-1; Thu, 09 Jan 2020 14:37:04 -0500
X-MC-Unique: BSjt9MTFPGCqt-sKEjcRXg-1
Received: by mail-qt1-f200.google.com with SMTP id m15so4229162qtc.18
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jan 2020 11:37:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=u2L+6QoH0unQY1zZnaaxRdBowT9MR5BCuv5QzmnWT7U=;
        b=Es+nB1lLA1kv0NVXZKQ5mBDF8M69MKPv/V/pvdc6vfXy4Xf8jjoPhsUMKTn7C33CDV
         RNk9Pq1P+bPc6zQ96gf9O+Od3nozCJ+87W7VNbGKL5C3NWaobJ2HqysPfm34dopQwnfs
         3Q2cVtuhy1PqmxvFb+M+MH1sorTJhMNhyI8xZjGCYGTRtWmnpdhXojiQFQdLa4ELnqDZ
         qieodhtnfSunrA5pHrOOx8sD4C9pykscYFgAX7H2t1x9/i9fExrBmi+N6aEJFPn5Npd7
         EiT5WnNXoiCO3gHaEEStfO9gw/dqLsv9Mg14Fxad3IfHb1DNqRzmUu07y28/cNh+8zex
         upwQ==
X-Gm-Message-State: APjAAAWGrw5UnDdLeXvENm6kjbo2b5g22nYxVNji7u3bYXGtVJIxD84F
        KtUBRKS89RcNciihABavrBfsSeZ/U/TRTf2PlQBwngADfLFQhBXjutwdaqt5/JiogOY3I5roo6e
        pJwR7cv+aFubxdEbpcAW1ZZnC
X-Received: by 2002:a05:620a:143b:: with SMTP id k27mr10644212qkj.262.1578598623566;
        Thu, 09 Jan 2020 11:37:03 -0800 (PST)
X-Google-Smtp-Source: APXvYqwBkyC8ff/t9Z0cRBa2GyWP8ASoK/Sw3be4MYuzdIQJb+iilhmNlhJeXq+yhgWbj0EEsyDvHw==
X-Received: by 2002:a05:620a:143b:: with SMTP id k27mr10644192qkj.262.1578598623356;
        Thu, 09 Jan 2020 11:37:03 -0800 (PST)
Received: from redhat.com (bzq-79-183-34-164.red.bezeqint.net. [79.183.34.164])
        by smtp.gmail.com with ESMTPSA id f5sm3537502qke.109.2020.01.09.11.36.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2020 11:37:02 -0800 (PST)
Date:   Thu, 9 Jan 2020 14:36:56 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Peter Xu <peterx@redhat.com>
Cc:     Alex Williamson <alex.williamson@redhat.com>, kvm@vger.kernel.org,
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
Message-ID: <20200109143620-mutt-send-email-mst@kernel.org>
References: <20200109145729.32898-1-peterx@redhat.com>
 <20200109145729.32898-13-peterx@redhat.com>
 <20200109110110-mutt-send-email-mst@kernel.org>
 <20200109095610.167cd9f0@w520.home>
 <20200109192116.GE36997@xz-x1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200109192116.GE36997@xz-x1>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 09, 2020 at 02:21:16PM -0500, Peter Xu wrote:
> On Thu, Jan 09, 2020 at 09:56:10AM -0700, Alex Williamson wrote:
> 
> [...]
> 
> > > > +Dirty GFNs (Guest Frame Numbers) are stored in the dirty_gfns array.
> > > > +For each of the dirty entry it's defined as:
> > > > +
> > > > +struct kvm_dirty_gfn {
> > > > +        __u32 pad;  
> > > 
> > > How about sticking a length here?
> > > This way huge pages can be dirtied in one go.
> > 
> > Not just huge pages, but any contiguous range of dirty pages could be
> > reported far more concisely.  Thanks,
> 
> I replied in the other thread on why I thought KVM might not suite
> that (while vfio may).
> 
> Actually we can even do that for KVM as long as we keep a per-vcpu
> last-dirtied GFN range cache (so we don't publish a dirty GFN right
> after it's dirtied), then we grow that cached dirtied range as long as
> the continuous next/previous page is dirtied.  If we found that the
> current dirty GFN is not continuous to the cached range, we publish
> the cached range and let the new GFN be the starting of last-dirtied
> GFN range cache.
> 
> However I am not sure how much we'll gain from it.  Maybe we can do
> that when we have a real use case for it.  For now I'm not sure
> whether it would worth the effort.
> 
> Thanks,

I agree for the implementation but I think UAPI should support that
from ground up so we don't need to support two kinds of formats.

> -- 
> Peter Xu

