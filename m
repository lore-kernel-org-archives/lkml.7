Return-Path: <SRS0=+gZy=2O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E4C2C2D0CF
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Dec 2019 15:24:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BF9B20409
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Dec 2019 15:24:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UuV+HSJ5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726269AbfLXPY2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Dec 2019 10:24:28 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:58981 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726168AbfLXPY2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Dec 2019 10:24:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1577201067;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ywK49erekGqxd3CUaRhTxMhJ8oeIv01btWZagZa8bg8=;
        b=UuV+HSJ5loTGn3LXItWstUI+LW223PJIFO2xVd5oopFvq6ti9xjsLD0d9IPJewbBYhZhTe
        Ss9gWabPSqRaB+wj1d/H9o5bQufOSkzUjN6G8kdH/LEQMqVt0Y2VmBHv8ZNbj4Bd2E+iVm
        B6EPflJONeQzoGfQutybJc3YaqzHIa8=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-170-hcIfPveTOi-AB-Goj7EJyQ-1; Tue, 24 Dec 2019 10:24:23 -0500
X-MC-Unique: hcIfPveTOi-AB-Goj7EJyQ-1
Received: by mail-qv1-f72.google.com with SMTP id g15so6638942qvk.11
        for <linux-kernel@vger.kernel.org>; Tue, 24 Dec 2019 07:24:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=ywK49erekGqxd3CUaRhTxMhJ8oeIv01btWZagZa8bg8=;
        b=OFLfmfwC4x+nDtkoYMjho/au8wOdnQOOaVi2jCQx1tumVLIQhu0I4EKaA//lvrdHuD
         W7Ha3UUnx+PeNxyiJit8smh9BbW2ase4MM4xug7uqztOhUlQ0l40WqbIdEEq+8W3LxE7
         aCIUkulWYQRuUMxoITQCeWSQaXTwlmwPqFBW8Y0LD8lMGUVddRApcOqkZdRhuya2hHMo
         av3uPL+fMLexbeW8Rx2qJ2JpuChtEueFN+O1W9ZGY31hOlZeu83A2kVAY1PBs73+jRhq
         K/cdjfHwJ2JpphsRSUxfA8t0O3pkiFPRl5/cjKvOuCHZ4jIYrus0vrArIWABb01dacB7
         l58w==
X-Gm-Message-State: APjAAAW4cac7IlUBhFpdkBwu+Wr3uY8ozu1rkYdCqUKE6MUbuw4y3eSR
        2t5V4PeYQPXKbw7KOHlmbF7wt+RyhGOmDVVyG6g4Th/WhmnSVXu4DBLRCu/1uiIrpSRHewRKkCl
        2SVyuGc13jAxJ3cgcv6PnStHb
X-Received: by 2002:a0c:b515:: with SMTP id d21mr29202516qve.106.1577201063044;
        Tue, 24 Dec 2019 07:24:23 -0800 (PST)
X-Google-Smtp-Source: APXvYqxROSsqGDowb78aAglNEiZ33GnO6TB2pNhWXqE4OuKHD3QbdllhHpK3icOUHHcvOCY9uvQPqQ==
X-Received: by 2002:a0c:b515:: with SMTP id d21mr29202468qve.106.1577201062364;
        Tue, 24 Dec 2019 07:24:22 -0800 (PST)
Received: from xz-x1 ([2607:9880:19c0:3f::2])
        by smtp.gmail.com with ESMTPSA id n190sm7034896qke.90.2019.12.24.07.24.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Dec 2019 07:24:21 -0800 (PST)
Date:   Tue, 24 Dec 2019 10:24:20 -0500
From:   Peter Xu <peterx@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dr David Alan Gilbert <dgilbert@redhat.com>,
        Christophe de Dinechin <dinechin@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>
Subject: Re: [PATCH RESEND v2 15/17] KVM: selftests: Add dirty ring buffer
 test
Message-ID: <20191224152420.GB17176@xz-x1>
References: <20191221020445.60476-1-peterx@redhat.com>
 <20191221020445.60476-5-peterx@redhat.com>
 <b0dc3d30-7fa5-3896-6905-9b1cb51d8d6c@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b0dc3d30-7fa5-3896-6905-9b1cb51d8d6c@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 24, 2019 at 02:50:48PM +0800, Jason Wang wrote:
> 
> On 2019/12/21 上午10:04, Peter Xu wrote:
> > Add the initial dirty ring buffer test.
> > 
> > The current test implements the userspace dirty ring collection, by
> > only reaping the dirty ring when the ring is full.
> > 
> > So it's still running asynchronously like this:
> 
> 
> I guess you meant "synchronously" here.

Yes, definitely. :)

-- 
Peter Xu

