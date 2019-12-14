Return-Path: <SRS0=X3/1=2E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75DF9C43603
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Dec 2019 07:57:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DE062073D
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Dec 2019 07:57:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bDaus4Fg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726099AbfLNH5d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Dec 2019 02:57:33 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:55899 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725851AbfLNH5b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Dec 2019 02:57:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576310250;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=x9Bb0Zg6nYlZHmt3Jv+uUkpX8UNR1qjNTKqsdhP1H0A=;
        b=bDaus4FgtqVCH4gqVuupyzHz+YILhoU/NNhWpZPcl8uwWDfQ/mCMYoqQUlIOwuVJRo6Tkm
        ri70d5DEWmW0csVscdnzwjExZrMM6OYf4z48lbeeEchnbFrJ2/PzIoS5cPNrxdby+liEXT
        VZp9jKrxGAK1EKKGG+bT5OhN31rNAR8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-386-PNElSHXPMPiIVAmGfcHcmw-1; Sat, 14 Dec 2019 02:57:28 -0500
X-MC-Unique: PNElSHXPMPiIVAmGfcHcmw-1
Received: by mail-wr1-f70.google.com with SMTP id v17so665579wrm.17
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2019 23:57:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=x9Bb0Zg6nYlZHmt3Jv+uUkpX8UNR1qjNTKqsdhP1H0A=;
        b=aTQ1/9WIx7vIBljH3dHUnjruVmMqIqldnvQleRK4KpJPJgoP1TzBB5Wbr4A6hLbzpm
         p0hbXZTnrArlwWnFvljgjdwaSnlbJHMhVW9A92/doSTopIRYARtv+NXEKyRXYSCSwc/q
         5PtXGVLYb/Lycj87RwkxFxPvihJFGn1JaO+zZophzYE432ObM/j+WFuYO98+J3NoNL9p
         Mvvb9i5/sOuReuy5r8wDRScv5IZC1Fiz5Z6AooPGwfS3+fSSEjKlkcjLmewsGFk+pKQk
         /PKVo9uZcfc7uaHrjtS0mHVG3/T2hgjSEwJmIWvcwrNWBc7F+Kje3g8ZLHl5/nwD9T42
         d8hQ==
X-Gm-Message-State: APjAAAXUzvxbRx/Jsjes6TLwLJysFVlU7ToJR81dG5V3nMC3yPNOpKwj
        L1YQNGeYrTTAAq+YVF51U1izg6ouPKeAwoEiFIb/yEPtrMq3wkJMNAZVL8DjHm2iaVD/F3lqnfK
        gAZOKgFaLtxEtZFhVBrLWtk5I
X-Received: by 2002:a7b:c1d8:: with SMTP id a24mr18263336wmj.130.1576310247437;
        Fri, 13 Dec 2019 23:57:27 -0800 (PST)
X-Google-Smtp-Source: APXvYqxUPZl8ZJUZZxd6OiscWyJHrZpVYfPirrw/vPJCsP1enhyrIyTxhigfjg1mAw+ULmy66b/+CA==
X-Received: by 2002:a7b:c1d8:: with SMTP id a24mr18263308wmj.130.1576310247108;
        Fri, 13 Dec 2019 23:57:27 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:cde8:2463:95a9:1d81? ([2001:b07:6468:f312:cde8:2463:95a9:1d81])
        by smtp.gmail.com with ESMTPSA id n3sm13470462wmc.27.2019.12.13.23.57.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Dec 2019 23:57:26 -0800 (PST)
Subject: Re: [PATCH RFC 04/15] KVM: Implement ring-based dirty memory tracking
To:     Peter Xu <peterx@redhat.com>,
        Christophe de Dinechin <christophe.de.dinechin@gmail.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>
References: <20191129213505.18472-1-peterx@redhat.com>
 <20191129213505.18472-5-peterx@redhat.com> <m1lfrihj2n.fsf@dinechin.org>
 <20191213202324.GI16429@xz-x1>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <bc15650b-df59-f508-1090-21dafc6e8ad1@redhat.com>
Date:   Sat, 14 Dec 2019 08:57:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191213202324.GI16429@xz-x1>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/12/19 21:23, Peter Xu wrote:
>> What is the benefit of using u16 for that? That means with 4K pages, you
>> can share at most 256M of dirty memory each time? That seems low to me,
>> especially since it's sufficient to touch one byte in a page to dirty it.
>>
>> Actually, this is not consistent with the definition in the code ;-)
>> So I'll assume it's actually u32.
> Yes it's u32 now.  Actually I believe at least Paolo would prefer u16
> more. :)

It has to be u16, because it overlaps the padding of the first entry.

Paolo

> I think even u16 would be mostly enough (if you see, the maximum
> allowed value currently is 64K entries only, not a big one).  Again,
> the thing is that the userspace should be collecting the dirty bits,
> so the ring shouldn't reach full easily.  Even if it does, we should
> probably let it stop for a while as explained above.  It'll be
> inefficient only if we set it to a too-small value, imho.
> 

