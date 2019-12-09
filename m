Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8567DC2BD09
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 09:37:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 593BC20692
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 09:37:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HyTEMvde"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727524AbfLIJhH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 04:37:07 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:58910 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727160AbfLIJhG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 04:37:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575884226;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Yz/Z2Uyi82Tsm+Aa8fxJXMQfCMt+llfBcTS4k9m0UwA=;
        b=HyTEMvdeuKwOWQVIG56vr0Kq+46Acdl+8fC5yE3b0Z3nYuZH1pab5Io+bre1TAl6Bg71fo
        3AfGc7pTeFXr3SYWDg2D/rptnpEalqeYEG+raXgn+voMX/dOBnjKYVj0e2hyjnqT88TVez
        FLHxn7ZfC/tgTTiHl3FJtCC36DgD/1c=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-422-t_M8r7xpMP6lDhRa-Mn_sA-1; Mon, 09 Dec 2019 04:37:03 -0500
Received: by mail-wr1-f72.google.com with SMTP id u18so7228795wrn.11
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2019 01:37:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Yz/Z2Uyi82Tsm+Aa8fxJXMQfCMt+llfBcTS4k9m0UwA=;
        b=AfG2A8RadLRfl7xIV1/F81HwGlVJPcOBK4IhrA+liRwxwc5qzGfPo+h24xxosdc6mP
         QVDdwUxb8e/ABuQoB1j9g0o03AfCdEPbLw0qPmUOrXauicLs6OE6V9vNbzIdPLir0Lbb
         KIaT/LKPKfobym4Ijs8ouHVtcqe7vd79YNkx5wYsjYi0/wwzfP4ckH3QV24m/J5/9gLy
         Ux+eeO9nEsmvJGxNiUnvNpD3MrzdYc5hDB/mCwz/1g1JBxbcYohZYDpKFDSXmXkeiEoK
         AKMVKuvnIGp6watp4/idJAWE0zUbM/oAE7t1Fyk/hJr4IL65BNPzFg6gWvhXEWqO/Rbz
         AKqw==
X-Gm-Message-State: APjAAAUF8t5c8YmAnFnhodevbSfGRm9pFpV3NzsqrlFO9YIVPZ6hq2Fx
        77EG85ETy7MPu1vnLIl4UJmSRHo7YudY6x3I3yK51bYSSvFE87WgxXjDEXvo51EGfNQXWm9jwRn
        OXN423zzNL5GPATG+/Gbr4b8e
X-Received: by 2002:a1c:e909:: with SMTP id q9mr24499556wmc.30.1575884221780;
        Mon, 09 Dec 2019 01:37:01 -0800 (PST)
X-Google-Smtp-Source: APXvYqzAW5LiyEF46zD4Bc+SWJqctxeL2ft11pv6kleMPxWl5MUVH4VkiuoT9F9bBt7G0hp8RX36XA==
X-Received: by 2002:a1c:e909:: with SMTP id q9mr24499533wmc.30.1575884221452;
        Mon, 09 Dec 2019 01:37:01 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:e9bb:92e9:fcc3:7ba9? ([2001:b07:6468:f312:e9bb:92e9:fcc3:7ba9])
        by smtp.gmail.com with ESMTPSA id n30sm12564626wmd.3.2019.12.09.01.37.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Dec 2019 01:37:00 -0800 (PST)
Subject: Re: [PATCH RFC 04/15] KVM: Implement ring-based dirty memory tracking
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Peter Xu <peterx@redhat.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>
References: <20191129213505.18472-1-peterx@redhat.com>
 <20191129213505.18472-5-peterx@redhat.com>
 <20191202201036.GJ4063@linux.intel.com> <20191202211640.GF31681@xz-x1>
 <20191202215049.GB8120@linux.intel.com>
 <fd882b9f-e510-ff0d-db43-eced75427fc6@redhat.com>
 <20191203184600.GB19877@linux.intel.com>
 <374f18f1-0592-9b70-adbb-0a72cc77d426@redhat.com>
 <20191207002904.GA29396@linux.intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <224ef677-4f25-fb61-2450-b95816333876@redhat.com>
Date:   Mon, 9 Dec 2019 10:37:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191207002904.GA29396@linux.intel.com>
Content-Language: en-US
X-MC-Unique: t_M8r7xpMP6lDhRa-Mn_sA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/12/19 01:29, Sean Christopherson wrote:
> On Wed, Dec 04, 2019 at 11:05:47AM +0100, Paolo Bonzini wrote:
>> On 03/12/19 19:46, Sean Christopherson wrote:
>>> Rather than reserve entries, what if vCPUs reserved an entire ring?  Create
>>> a pool of N=nr_vcpus rings that are shared by all vCPUs.  To mark pages
>>> dirty, a vCPU claims a ring, pushes the pages into the ring, and then
>>> returns the ring to the pool.  If pushing pages hits the soft limit, a
>>> request is made to drain the ring and the ring is not returned to the pool
>>> until it is drained.
>>>
>>> Except for acquiring a ring, which likely can be heavily optimized, that'd
>>> allow parallel processing (#1), and would provide a facsimile of #2 as
>>> pushing more pages onto a ring would naturally increase the likelihood of
>>> triggering a drain.  And it might be interesting to see the effect of using
>>> different methods of ring selection, e.g. pure round robin, LRU, last used
>>> on the current vCPU, etc...
>>
>> If you are creating nr_vcpus rings, and draining is done on the vCPU
>> thread that has filled the ring, why not create nr_vcpus+1?  The current
>> code then is exactly the same as pre-claiming a ring per vCPU and never
>> releasing it, and using a spinlock to claim the per-VM ring.
> 
> Because I really don't like kvm_get_running_vcpu() :-)

I also don't like it particularly, but I think it's okay to wrap it into
a nicer API.

> Binding the rings to vCPUs also makes for an inflexible API, e.g. the
> amount of memory required for the rings scales linearly with the number of
> vCPUs, or maybe there's a use case for having M:N vCPUs:rings.

If we can get rid of the dirty bitmap, the amount of memory is probably
going to be smaller anyway.  For example at 64k per ring, 256 rings
occupy 16 MiB of memory, and that is the cost of dirty bitmaps for 512
GiB of guest memory, and that's probably what you can expect for the
memory of a 256-vCPU guest (at least roughly: if the memory is 128 GiB,
the extra 12 MiB for dirty page rings don't really matter).

Paolo

> That being said, I'm pretty clueless when it comes to implementing and
> tuning the userspace side of this type of stuff, so feel free to ignore my
> thoughts on the API.
> 

