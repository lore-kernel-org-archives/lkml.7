Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65832C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 21:54:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AFEB20830
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 21:54:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554933241;
	bh=igfqVUJvHfC4/Lc+rM2btJrQ0bssNL4DEJbb09pJ4uc=;
	h=From:Subject:To:Cc:References:Date:In-Reply-To:List-ID:From;
	b=c9zMGuxk0/beL2oY4xGFqyVqe0wFqzBulIIwzKbWAkltfWLptvcRCqePByTCJ0R+f
	 4VJk39cciLJbesQ2ay+wAepwD8vcF4+iADadfCuzxazxRz04EUP4qitjIyJXr4zEKA
	 G7f9JpH5b0xFQ6ctyeokcKU12QsRPPKZISOiaWq8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726748AbfDJVyA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 17:54:00 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:38858 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726022AbfDJVx7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 17:53:59 -0400
Received: by mail-qt1-f194.google.com with SMTP id d13so4807578qth.5
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2019 14:53:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:subject:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=FNNkCCOpCVrsD7hVcfnPcZYMncHlpeZFL/47O/ZmfVU=;
        b=ZI6D8fT9Q4gSnzMXM2iZEcJE9Wm75O//EUXUb2Ww2xS3b0PiJmxUCt2PsO9RA/+bHz
         MFH2mGl3Gq5vEY+pOTNI3WMBmE9am7YInZQV5mo+TAtuW54EAj48nL8sOz6OlbS90oNF
         IXl9eth7hLQIv7iYjFHIyIiUPz+EqhrlYijv6Thaf2Dj7BffHdQ/tGNP2Jbn078IBivz
         4YZ/cUwGNN9Vy6O+61Ws1aS9onKIOhnsltISWfZ3XM4Gq4Z4mJjBb+rASUd/7MOmsylG
         /+mHC1pIdI0KJe+2wcLDVB2WUyAu9MO/aBe4PFrvqZLGYRLKEUfgkhKqZZi8r2eTRacp
         fJ7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:subject:to:cc:references:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=FNNkCCOpCVrsD7hVcfnPcZYMncHlpeZFL/47O/ZmfVU=;
        b=RviPtNOcV/jPtYSd5zKDN3wunCvIQD6/XlKQvWVCwcOJLmj1JhSflZdZk/k++RWkNj
         ANw1EHANDmzey4+Z/D/0Bgzv9oHGXNS4FKn9hzshcBOvyFggXIBXsWzjPqDimkD1r6Mc
         ehXXVwdxh3n2NARfTHBUFNpgw5kwsnrY+DB3o38IKManxQKLVEcq7SA26FpxMlUNEO9d
         +9mMOjV5/A6YNkKYAksVT3AostldIAhRRtCd3CXhk9Rb7x/s6Nvx6OdzeWV7XZejaQnt
         35vVohqAOskKTH2ZNYUKCzcKQT7z2PC0x2216KvmW28OZvMqwN5eWYcSm5d/F4Ns9fgB
         bS0Q==
X-Gm-Message-State: APjAAAUw4ovVq6TY8Z+JFjPjBr2aS6MJ2vy2MXdDAFfrls1+aOqiUz5t
        VSA69snd3lHY93HQow/nIdmPry0s
X-Google-Smtp-Source: APXvYqwNdA1fNbFd7MKIX0uPWFWouBHyMUp/tZkitQiRGpWSXgbiGdklMlOz9ouTwNJOQr28l6HlYw==
X-Received: by 2002:a0c:8772:: with SMTP id 47mr37237729qvi.120.1554933238454;
        Wed, 10 Apr 2019 14:53:58 -0700 (PDT)
Received: from [10.84.150.60] ([167.220.148.60])
        by smtp.gmail.com with ESMTPSA id u44sm18810575qte.40.2019.04.10.14.53.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Apr 2019 14:53:57 -0700 (PDT)
From:   Sinan Kaya <Okaya@kernel.org>
X-Google-Original-From: Sinan Kaya <okaya@kernel.org>
Subject: Re: [PATCH v1] init: Do not select DEBUG_KERNEL by default
To:     Kees Cook <keescook@chromium.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Adrian Reber <adrian@lisas.de>,
        Richard Guy Briggs <rgb@redhat.com>
References: <20190410212627.29514-1-okaya@kernel.org>
 <CAGXu5j+uBuPjDc+gGcxW_QoJJi7sQZ8m=Zg-Q2wKDxyTt7yGvg@mail.gmail.com>
Message-ID: <a9508cc3-3385-256e-2f27-c1e0a770ba69@kernel.org>
Date:   Wed, 10 Apr 2019 17:53:57 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAGXu5j+uBuPjDc+gGcxW_QoJJi7sQZ8m=Zg-Q2wKDxyTt7yGvg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/10/2019 5:45 PM, Kees Cook wrote:
> On Wed, Apr 10, 2019 at 2:26 PM Sinan Kaya <okaya@kernel.org> wrote:
>>
>> We can't seem to have a kernel with CONFIG_EXPERT set but
>> CONFIG_DEBUG_KERNEL unset these days.
>>
>> While some of the features under the CONFIG_EXPERT require
>> CONFIG_DEBUG_KERNEL, it doesn't apply for all features.
>>
>> The meaning of CONFIG_EXPERT and CONFIG_DEBUG_KERNEL has been
>> mixed here.
> 
> I don't agree: the point of EXPERT is to show _everything_, which
> means DEBUG_KERNEL should be selected to show those options as well. I
> think this is fine as-is. What is the problem you want to solve?
> 
> I think of it as low (nothing selected) medium (DEBUG_KERNEL) and high
> (EXPERT and DEBUG_KERNEL). So EXPERT enables DEBUG_KERNEL too.
> 

Sure, let's see if there is a better option.

I don't want any of the debug features in my kernel but still
need all the expert features. My kernel is considered a production
kernel. I don't really want to ship all the good debug enables.

On the other hand, I need the features under CONFIG_EXPERT to have
a functional system.

Let's take "multiple users" as an example.

What's the point of having a kernel without multiple users? :)

I don't see the relationship between CONFIG_DEBUG and CONFIG_EXPERT
as none of the features except KALLSYMS depend on it. If there was
a compile time dependency, I'd say move it to the things that need
it as this patch suggests.

P.S. I found a circular dependency now. I can respin the patch based
on feedback.
