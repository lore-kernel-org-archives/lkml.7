Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D48CEC43603
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 16:42:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E9352146E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 16:42:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X3ZhmMLa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727492AbfLRQmF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 11:42:05 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:36258 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726980AbfLRQmF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 11:42:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576687324;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BATXLD2735eSsv+Ci71FjK/3o7MP7Rj1HcsBjxTaRLs=;
        b=X3ZhmMLam4JU9zMxGovo41TzSS5xMyR63vFtQoYgzWeqVjWi/ljHXaOXpr5RJp2cHtsJGB
        YesKCyKTtWaVa9C+NPy5HM3qrz/mLfLfRKaUwqjo+QS+Dfakpntu4wZmHzq9OCGh9SkStd
        GuiaqlW0V27RyHcPtjqpNt4qPFBqmGM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-179-p9GRNaV0Oc2UO8t_fHKP_A-1; Wed, 18 Dec 2019 11:42:03 -0500
X-MC-Unique: p9GRNaV0Oc2UO8t_fHKP_A-1
Received: by mail-wm1-f70.google.com with SMTP id f25so655775wmb.1
        for <linux-kernel@vger.kernel.org>; Wed, 18 Dec 2019 08:42:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BATXLD2735eSsv+Ci71FjK/3o7MP7Rj1HcsBjxTaRLs=;
        b=evBljkl/FFJ3dGovety7AAwOXCAx73ih4kKH/4BqrG7eQIbN47kxkiAYGOvLjbJfuc
         U52cbNqYMdBaHJBRKylQROtowGKgWsj3TnQUNDhDindrO/1WgoJZbOXpDHt5WTd0yjYK
         M7QS4VLJhGMEaMBJzEQfwPic3AXjc+xQ+64dz8yPsAkPSu74TMlbsJGGxBLS5i2/pMQc
         6w9YejWSvwj51pfpt7AoasEEBA/gyNZdNJceYSVKEK2LPvEvhr24VeydAXR0k6FJ1tdo
         qfN2WiQXI2ASiKord5lFc8WtcnOyyqUQkQokvvyEir3x3DLUcuC+QjrMHcFPSodNueD4
         iqeg==
X-Gm-Message-State: APjAAAX0R+kG8cW1eEIXz9G0aIY+f64XgNLy8YiIZ1dXdo7RJUXPGfar
        e/gZx4B8Sz0UMSThz2/orgdvU9WCH7PgrX1WtfGhMaE2/H0TMf65ABSpajm7cQ6gacUZPCgeZmo
        Yb1X2s6IM87eStJSPADbQTU0/
X-Received: by 2002:a1c:5f06:: with SMTP id t6mr4411544wmb.32.1576687321977;
        Wed, 18 Dec 2019 08:42:01 -0800 (PST)
X-Google-Smtp-Source: APXvYqy0w+0Foy8IN6Dsyw16t2SmXcya+bZVFa5MJ9MWOrDPKOP3jRs72UuDNTN4AafsY1gZ0dSTCw==
X-Received: by 2002:a1c:5f06:: with SMTP id t6mr4411519wmb.32.1576687321761;
        Wed, 18 Dec 2019 08:42:01 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:ac09:bce1:1c26:264c? ([2001:b07:6468:f312:ac09:bce1:1c26:264c])
        by smtp.gmail.com with ESMTPSA id v188sm3223075wma.10.2019.12.18.08.42.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Dec 2019 08:42:01 -0800 (PST)
Subject: Re: [PATCH RFC 04/15] KVM: Implement ring-based dirty memory tracking
To:     Peter Xu <peterx@redhat.com>
Cc:     Christophe de Dinechin <dinechin@redhat.com>,
        Christophe de Dinechin <christophe.de.dinechin@gmail.com>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Eric Auger <eric.auger@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>
References: <20191213202324.GI16429@xz-x1>
 <bc15650b-df59-f508-1090-21dafc6e8ad1@redhat.com>
 <E167A793-B42A-422D-8D46-B992CB6EBE69@redhat.com>
 <d59ac0eb-e65a-a46f-886e-6df80a2b142f@redhat.com>
 <20191217153837.GC7258@xz-x1>
 <ecb949d1-4539-305f-0a84-1704834e37ba@redhat.com>
 <20191217164244.GE7258@xz-x1>
 <c6d00ced-64ff-34af-99dd-abbcbac67836@redhat.com>
 <20191217194114.GG7258@xz-x1>
 <838084bf-efd7-009c-62ce-f11493242867@redhat.com>
 <20191218163238.GC26669@xz-x1>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <577e68a6-22ad-d8a2-81f3-1f71b02d0a18@redhat.com>
Date:   Wed, 18 Dec 2019 17:41:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191218163238.GC26669@xz-x1>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/12/19 17:32, Peter Xu wrote:
>> With PML it is.  Without PML, however, it would be much slower to
>> synchronize the dirty bitmap from KVM to userspace (one atomic operation
>> per page instead of one per 64 pages) and even impossible to have the
>> dirty ring.
>
> Indeed, however I think it'll be faster for hardware to mark page as
> dirty.  So could it be a tradeoff on whether we want the "collection"
> to be faster or "marking page dirty" to be faster?  IMHO "marking page
> dirty" could be even more important sometimes because that affects
> guest responsiveness (blocks vcpu execution), while the collection
> procedure can happen in parrallel with that.

The problem is that the marking page dirty will be many many times
slower, because you don't have this

                        if (!dirty_bitmap[i])
                                continue;

and instead you have to scan the whole of the page tables even if a
handful of bits are set (reading  4K of memory for every 2M of guest
RAM).  This can be quite bad for the TLB too.  It is certainly possible
that it turns out to be faster but I would be quite surprised and, with
PML, that is more or less moot.

Thanks,

Paolo

