Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B87B3C43603
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 19:59:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C4C12466F
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 19:59:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hx44nlvt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729594AbfLET7j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Dec 2019 14:59:39 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:32895 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729154AbfLET7i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 14:59:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575575977;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KWNSf29mI3MtykR8BlHVVbiXJxX25JJg8iyhbBzj48A=;
        b=hx44nlvtkq5WwynOFC26Au9+OiJdNhIaVhIOnFcXhrcEijZaRlQ7sah/ZZazYwDBvWGLfc
        g7w0prt4gGmTggj6G/9cQX/tUbOF3BCzE9NTSNRZTcqq2xlAd2CWNODED92JIdWO7q0UFz
        dXUyEzSILSxcOktilvE0khRArDOr0Qk=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-241-MW0z7lwJNx6--d3CiyzHRg-1; Thu, 05 Dec 2019 14:59:36 -0500
Received: by mail-wr1-f72.google.com with SMTP id l20so2015581wrc.13
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2019 11:59:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KWNSf29mI3MtykR8BlHVVbiXJxX25JJg8iyhbBzj48A=;
        b=C1OL+5TqOk2rpn+zF6UNLuZWBgr6ncT9S1hzj7QuHumtBDay8CCzsznnEFzdkj9xMQ
         yEE46saLIlchAFxzOVh8ld1rf2or5yYx+4a/hrulRM6vaS5GSirBLKi3MWhDAXtSCXC6
         D6U8xIy4Ne+6BCi5uPQIIElW9S02sV2V1e+Icg3cFssbfQC1nlHWUnp2ib4mHqlhucj4
         +cipmAq3k3NYzIhdvRAq63LyG/6GQ85uV10nrpxLZCRWOjrEZRPBVGFTLKTY5X3Tr6nT
         nxTDC5wxdIO4VFZxz11yPn+8sLh2N1bLcQSEPqJlGzZHUHecx0s3g4mFHwMOQxDX333J
         KLuw==
X-Gm-Message-State: APjAAAUhWYUP9v+vcvWL2C4IYGePszTzfTsvaW0nfk535IFpb0jrMiS9
        +FD0MIvd2YPS8AzPO/m3154CvpmKZZebw5U7ZIpmfb5F5z0Dz3jVZCfJe58uzEHkmdEdNqtsJHW
        /H3x7adGBjIn8Xhfbz7ONPGoC
X-Received: by 2002:a5d:4d06:: with SMTP id z6mr11594384wrt.339.1575575975181;
        Thu, 05 Dec 2019 11:59:35 -0800 (PST)
X-Google-Smtp-Source: APXvYqy1+nxZUj2WeYhM+NnoFIwZZeGs5+NEtZLacBLSKNmWmfrA26sajlD3+6CNDAV4DoVVuD7YdQ==
X-Received: by 2002:a5d:4d06:: with SMTP id z6mr11594377wrt.339.1575575974905;
        Thu, 05 Dec 2019 11:59:34 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:541f:a977:4b60:6802? ([2001:b07:6468:f312:541f:a977:4b60:6802])
        by smtp.gmail.com with ESMTPSA id h127sm980721wme.31.2019.12.05.11.59.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Dec 2019 11:59:34 -0800 (PST)
Subject: Re: [PATCH RFC 00/15] KVM: Dirty ring interface
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>
References: <20191129213505.18472-1-peterx@redhat.com>
 <b8f28d8c-2486-2d66-04fd-a2674b598cfd@redhat.com>
 <20191202021337.GB18887@xz-x1>
 <b893745e-96c1-d8e4-85ec-9da257d0d44e@redhat.com>
 <20191205193055.GA7201@xz-x1>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <60888f25-2299-2a04-68c2-6eca171a2a18@redhat.com>
Date:   Thu, 5 Dec 2019 20:59:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191205193055.GA7201@xz-x1>
Content-Language: en-US
X-MC-Unique: MW0z7lwJNx6--d3CiyzHRg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/12/19 20:30, Peter Xu wrote:
>> Try enabling kvmmmu tracepoints too, it will tell
>> you more of the path that was taken while processing the EPT violation.
>
> These new tracepoints are extremely useful (which I didn't notice
> before).

Yes, they are!

> So here's the final culprit...
> 
> void kvm_reset_dirty_gfn(struct kvm *kvm, u32 slot, u64 offset, u64 mask)
> {
>         ...
> 	spin_lock(&kvm->mmu_lock);
> 	/* FIXME: we should use a single AND operation, but there is no
> 	 * applicable atomic API.
> 	 */
> 	while (mask) {
> 		clear_bit_le(offset + __ffs(mask), memslot->dirty_bitmap);
> 		mask &= mask - 1;
> 	}
> 
> 	kvm_arch_mmu_enable_log_dirty_pt_masked(kvm, memslot, offset, mask);
> 	spin_unlock(&kvm->mmu_lock);
> }
> 
> The mask is cleared before reaching
> kvm_arch_mmu_enable_log_dirty_pt_masked()..

I'm not sure why that results in two vmexits?  (clearing before
kvm_arch_mmu_enable_log_dirty_pt_masked is also what
KVM_{GET,CLEAR}_DIRTY_LOG does).

> The funny thing is that I did have a few more patches to even skip
> allocate the dirty_bitmap when dirty ring is enabled (hence in that
> tree I removed this while loop too, so that has no such problem).
> However I dropped those patches when I posted the RFC because I don't
> think it's mature, and the selftest didn't complain about that
> either..  Though, I do plan to redo that in v2 if you don't disagree.
> The major question would be whether the dirty_bitmap could still be
> for any use if dirty ring is enabled.

Userspace may want a dirty bitmap in addition to a list (for example:
list for migration, bitmap for framebuffer update), but it can also do a
pass over the dirty rings in order to update an internal bitmap.

So I think it make sense to make it either one or the other.

Paolo

