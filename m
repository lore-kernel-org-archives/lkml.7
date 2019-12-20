Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB245C2D0C0
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 09:25:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 900B124680
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 09:25:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XCSvcuHZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727362AbfLTJZW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Dec 2019 04:25:22 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:28404 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727188AbfLTJZT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 04:25:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576833918;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LsxcLVbBun1f96xBFFfgPOlzuKGlq4r29EdM+SsmX7k=;
        b=XCSvcuHZl4fYpSg3+lJGo7wB9zu/5eGQ/Sk161B0dNiEKY/TWOPMT4PKIswsjbfsgWmozX
        30WcZ2NxviW42XxYvpMCXrNS4PQvI3F//kMadPHcURTdX5+TGwZjCutY6tAVNbdh0tM9XC
        VNIv2l6v3eIrXbxeJYOQ8yICFjiWQr0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-227-DN7bz1JNNq-O5ERHkaPWew-1; Fri, 20 Dec 2019 04:25:17 -0500
X-MC-Unique: DN7bz1JNNq-O5ERHkaPWew-1
Received: by mail-wr1-f70.google.com with SMTP id z15so915952wrw.0
        for <linux-kernel@vger.kernel.org>; Fri, 20 Dec 2019 01:25:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LsxcLVbBun1f96xBFFfgPOlzuKGlq4r29EdM+SsmX7k=;
        b=BxhYflSWIamtWaqafq9ptcVlKqEOwwtJFh7/2nEnj/3uSaoRSScv84Ya0DWLDk3uNc
         jUZ8N6GlYlUzrF4y/V9U9HzH5l20CQavFHpw914qMgY2MTxIe2SHElVGlz0VWYFQHmpA
         OQisBnJunPs0TROHzgIjae4SUfmAMpGsMLQ6dvVRsjn8kl9BdVEvuQ8nng61oqvNAyZ/
         K+XPyJK/MX5cwir6NtfekFws1D9t/FGLLWsK1NW7fV+A2BcMmdkUVNrih5S9oeE8Liyw
         7+Ko5DaQ8VTGVR9Yt93+Qr3sJupvdgUsZ3KdCY3j+dm+ud7DzNOLJsPUwqpYryL4sAu3
         U7kQ==
X-Gm-Message-State: APjAAAU56jsobPB+iDtI6wDjuAl2EVY8OkEGUpxudbdff3X8aUDei+Km
        SLUiJEf0HfiaJjKfJNyoNQFDRoKuN8DljpevPDyiK968iEyWdKOYkuRBlKR2/n+dack+WA2EyIH
        Mu0clu8kxFuLKPcA+2FdES3/0
X-Received: by 2002:a05:600c:246:: with SMTP id 6mr15371254wmj.122.1576833916356;
        Fri, 20 Dec 2019 01:25:16 -0800 (PST)
X-Google-Smtp-Source: APXvYqzw8wZPLS7TkKIeuMQ4kT47hh6TgBs/pAj1q7SP7litoY6M7b4efDd9KnpDPbJZMMJOaN3lqQ==
X-Received: by 2002:a05:600c:246:: with SMTP id 6mr15371232wmj.122.1576833916119;
        Fri, 20 Dec 2019 01:25:16 -0800 (PST)
Received: from [192.168.10.150] ([93.56.166.5])
        by smtp.gmail.com with ESMTPSA id m7sm9097969wrr.40.2019.12.20.01.25.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Dec 2019 01:25:15 -0800 (PST)
Subject: Re: [PATCH v2] kvm/svm: PKU not currently supported
To:     Sean Christopherson <sean.j.christopherson@intel.com>,
        John Allen <john.allen@amd.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        rkrcmar@redhat.com, vkuznets@redhat.com
References: <20191219201759.21860-1-john.allen@amd.com>
 <20191219203214.GC6439@linux.intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <8a77e3b9-049e-e622-9332-9bebb829bc3d@redhat.com>
Date:   Fri, 20 Dec 2019 10:25:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191219203214.GC6439@linux.intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/12/19 21:32, Sean Christopherson wrote:
> On Thu, Dec 19, 2019 at 02:17:59PM -0600, John Allen wrote:
>> Current SVM implementation does not have support for handling PKU. Guests
>> running on a host with future AMD cpus that support the feature will read
>> garbage from the PKRU register and will hit segmentation faults on boot as
>> memory is getting marked as protected that should not be. Ensure that cpuid
>> from SVM does not advertise the feature.
>>
>> Signed-off-by: John Allen <john.allen@amd.com>
>> ---
>> v2:
>>   -Introduce kvm_x86_ops->pku_supported()
> 
> I like the v1 approach better, it's less code to unwind when SVM gains
> support for virtualizaing PKU.
> 
> The existing cases of kvm_x86_ops->*_supported() in __do_cpuid_func() are
> necessary to handle cases where it may not be possible to expose a feature
> even though it's supported in hardware, host and KVM, e.g. VMX's separate
> MSR-based features and PT's software control to hide it from guest.  In
> this case, hiding PKU is purely due to lack of support in KVM.  The SVM
> series to enable PKU can then delete a single line of SVM code instead of
> having to go back in and do surgery on x86 and VMX.
> 

I sort of liked the V1 approach better, in that I liked using
set_supported_cpuid but I didn't like *removing* features from it.

I think all *_supported() should be removed, and the code moved from
__do_cpuid_func() to set_supported_cpuid.

For now, however, this one is consistent with other features so I am
applying it.

Paolo

