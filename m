Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27EB2C43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 09:29:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEA1B2064B
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 09:29:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GeK+Bj/u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727052AbfLPJ3o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 04:29:44 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:36737 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726937AbfLPJ3n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 04:29:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576488582;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=D+soKtjNipH8IpDTofIGrq0aj+9fNzPNczOVUstfi40=;
        b=GeK+Bj/uKgosw892qxigAaBMbkiJ8wM6KWk0F45ziFEebaX3Kq+mRNTzdGvTLnt/zip/VH
        a8vD7RrLjvyuf7cWUe5FvQ7206qRryGsO9tkKwnfG2rNQBjG9U83LTw1T9X0K6DnGPRog5
        joAovHva9vU2uXgk2HqOCNXV3FIWGBQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-38-Esuma3D8M7SQ4SInaisa_g-1; Mon, 16 Dec 2019 04:29:39 -0500
X-MC-Unique: Esuma3D8M7SQ4SInaisa_g-1
Received: by mail-wr1-f70.google.com with SMTP id f10so3466473wro.14
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2019 01:29:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=D+soKtjNipH8IpDTofIGrq0aj+9fNzPNczOVUstfi40=;
        b=PADSJHNGBpY4l5Ef/3ABCEH1IrnTtB9s74NeMZqxxHXiBolfoHNN8DhRldp+oQKtq/
         6Enhh+lX+vmaERuCFWboQR8flSM6kVI/lkUN+4EmZR0qVSWhGy8IQMo+8lfIA9Lp9lTW
         W9k1ZH9UoDPCAyhGb0265xa0TUjtN26rX/4IrG2JnU4AgVnS/8s20XvYetrz9ay1TB8c
         Eoc3hh11ufnxHD/qyEsnGKIDVoEeKalpqC5/u9lT4bRuesxz2BYhTYeCWqrv2Wunjwq3
         NmbNbHIzRj/dwYFXcblIqD+s/Ire9SzGLTb+U6Eer3ga5QJOBLo3ewRmfHtBlmceDBLe
         Pr1g==
X-Gm-Message-State: APjAAAU19uzpFV1GK53eZKFacAPx7HW60TwQjbtZ762p2QnaqyaB93Qx
        JnOYs7DJoJkUCBdSovrv2FPwWrF6PL3C6gGGGutGc8c8RmOP/lwZAq/ZbfFpMKhs0AFg4KsDm1d
        4N5oSNlCOP8xo70zg9aP72pxa
X-Received: by 2002:a05:6000:12:: with SMTP id h18mr27350891wrx.87.1576488578199;
        Mon, 16 Dec 2019 01:29:38 -0800 (PST)
X-Google-Smtp-Source: APXvYqxcZPae2fpcmqbfNpMEm7htf9LRZYX5o97SGgIiTkAX1Z/FX+jXlRQPGctSI6IqUy1eUKeLNg==
X-Received: by 2002:a05:6000:12:: with SMTP id h18mr27350870wrx.87.1576488577987;
        Mon, 16 Dec 2019 01:29:37 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:cde8:2463:95a9:1d81? ([2001:b07:6468:f312:cde8:2463:95a9:1d81])
        by smtp.gmail.com with ESMTPSA id v14sm20958683wrm.28.2019.12.16.01.29.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Dec 2019 01:29:37 -0800 (PST)
Subject: Re: [PATCH RFC 04/15] KVM: Implement ring-based dirty memory tracking
To:     Peter Xu <peterx@redhat.com>
Cc:     Christophe de Dinechin <christophe.de.dinechin@gmail.com>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>
References: <20191129213505.18472-1-peterx@redhat.com>
 <20191129213505.18472-5-peterx@redhat.com> <m1lfrihj2n.fsf@dinechin.org>
 <20191213202324.GI16429@xz-x1>
 <bc15650b-df59-f508-1090-21dafc6e8ad1@redhat.com>
 <20191214162644.GK16429@xz-x1>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <0f084179-2a5d-e8d9-5870-3cc428105596@redhat.com>
Date:   Mon, 16 Dec 2019 10:29:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191214162644.GK16429@xz-x1>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/12/19 17:26, Peter Xu wrote:
> On Sat, Dec 14, 2019 at 08:57:26AM +0100, Paolo Bonzini wrote:
>> On 13/12/19 21:23, Peter Xu wrote:
>>>> What is the benefit of using u16 for that? That means with 4K pages, you
>>>> can share at most 256M of dirty memory each time? That seems low to me,
>>>> especially since it's sufficient to touch one byte in a page to dirty it.
>>>>
>>>> Actually, this is not consistent with the definition in the code ;-)
>>>> So I'll assume it's actually u32.
>>> Yes it's u32 now.  Actually I believe at least Paolo would prefer u16
>>> more. :)
>>
>> It has to be u16, because it overlaps the padding of the first entry.
> 
> Hmm, could you explain?
> 
> Note that here what Christophe commented is on dirty_index,
> reset_index of "struct kvm_dirty_ring", so imho it could really be
> anything we want as long as it can store a u32 (which is the size of
> the elements in kvm_dirty_ring_indexes).
> 
> If you were instead talking about the previous union definition of
> "struct kvm_dirty_gfns" rather than "struct kvm_dirty_ring", iiuc I've
> moved those indices out of it and defined kvm_dirty_ring_indexes which
> we expose via kvm_run, so we don't have that limitation as well any
> more?

Yeah, I meant that since the size has (had) to be u16 in the union, it
need not be bigger in kvm_dirty_ring.

I don't think having more than 2^16 entries in the *per-CPU* ring buffer
makes sense; lagging in recording dirty memory by more than 256 MiB per
CPU would mean a large pause later on resetting the ring buffers (your
KVM_CLEAR_DIRTY_LOG patches found the sweet spot to be around 1 GiB for
the whole system).

So I liked the union, but if you removed it you might as well align the
producer and consumer indices to 64 bytes so that they are in separate
cache lines.

Paolo

