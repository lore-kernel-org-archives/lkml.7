Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8D42C7618B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 11:38:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 965D222387
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 11:38:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727601AbfGXLiK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 07:38:10 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:43909 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727482AbfGXLiJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 07:38:09 -0400
Received: by mail-qt1-f196.google.com with SMTP id w17so768345qto.10
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2019 04:38:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OtXsM3EAnHCwOTu8jwk53eaCILY4JLC/RpCVWDNAsAc=;
        b=e6ENeNoDTjvOwJp34C/A8zpVfqnUuOinnCCRFDcDgkm/vMMsfYhJalVdnH3Mzv2nsC
         od7xR3EIMPMamLeTDs9NLMYKwAWfyuSEgvr5oy0wqbmGl2zSR6fcmT5KUpBoAAm6sx1O
         mAuYen2cyu9nl1l8mNXu2DjxHIvhPNOTnR5ypP0O/LrwYj/cF5xTEeWww3bM8hiBkk4T
         wURyK1dTnQYt94G+EAvttP6N9kJBGRDSITFHmzdsv5gwePyPuTJnn6Xmg9vwZ1KWjXDJ
         TAywjMJp1XJh83Udy1jZOpHZ9YjFH6Ly90z4HzcQsKvgLoT8dVHXVOGhA/+5l/hBi8Vd
         oaiQ==
X-Gm-Message-State: APjAAAVWnbTwRLhzYy01nWpel+nUFoX+py8QwXiI8p7eIMxsLZFyO1LA
        02GOVtQfeyIWEk2+dD6H0rllqg==
X-Google-Smtp-Source: APXvYqzZSre9ooa7vDedJRUD+3vOJbH1kq9xA43CbFviCJFtNHcxq5k6YU0WwwH4UdHDqHjv2ASKRw==
X-Received: by 2002:ac8:2409:: with SMTP id c9mr57284445qtc.145.1563968288928;
        Wed, 24 Jul 2019 04:38:08 -0700 (PDT)
Received: from [192.168.1.157] (pool-96-235-39-235.pitbpa.fios.verizon.net. [96.235.39.235])
        by smtp.gmail.com with ESMTPSA id 42sm24549812qtm.27.2019.07.24.04.38.07
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Jul 2019 04:38:08 -0700 (PDT)
Subject: Re: [PATCH v6 4/5] dma-buf: heaps: Add CMA heap to dmabuf heaps
To:     Christoph Hellwig <hch@infradead.org>,
        John Stultz <john.stultz@linaro.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Liam Mark <lmark@codeaurora.org>,
        Pratik Patel <pratikp@codeaurora.org>,
        Brian Starkey <Brian.Starkey@arm.com>,
        Vincent Donnefort <Vincent.Donnefort@arm.com>,
        Sudipto Paul <Sudipto.Paul@arm.com>,
        "Andrew F . Davis" <afd@ti.com>,
        Xu YiPing <xuyiping@hisilicon.com>,
        "Chenfeng (puck)" <puck.chen@hisilicon.com>,
        butao <butao@hisilicon.com>,
        "Xiaqing (A)" <saberlily.xia@hisilicon.com>,
        Yudongbin <yudongbin@hisilicon.com>,
        Chenbo Feng <fengc@google.com>,
        Alistair Strachan <astrachan@google.com>,
        dri-devel <dri-devel@lists.freedesktop.org>
References: <20190624194908.121273-1-john.stultz@linaro.org>
 <20190624194908.121273-5-john.stultz@linaro.org>
 <20190718100840.GB19666@infradead.org>
 <CALAqxLWLx_tHVjZqrSNWfQ_M2RGGqh4qth3hi9GGRdSPov-gcw@mail.gmail.com>
 <20190724065958.GC16225@infradead.org>
From:   Laura Abbott <labbott@redhat.com>
Message-ID: <25353c4f-5389-0352-b34e-78698b35e588@redhat.com>
Date:   Wed, 24 Jul 2019 07:38:07 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190724065958.GC16225@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/24/19 2:59 AM, Christoph Hellwig wrote:
> On Mon, Jul 22, 2019 at 10:04:06PM -0700, John Stultz wrote:
>> Apologies, I'm not sure I'm understanding your suggestion here.
>> dma_alloc_contiguous() does have some interesting optimizations
>> (avoiding allocating single page from cma), though its focus on
>> default area vs specific device area doesn't quite match up the usage
>> model for dma heaps.  Instead of allocating memory for a single
>> device, we want to be able to allow userland, for a given usage mode,
>> to be able to allocate a dmabuf from a specific heap of memory which
>> will satisfy the usage mode for that buffer pipeline (across multiple
>> devices).
>>
>> Now, indeed, the system and cma heaps in this patchset are a bit
>> simple/trivial (though useful with my devices that require contiguous
>> buffers for the display driver), but more complex ION heaps have
>> traditionally stayed out of tree in vendor code, in many cases making
>> incompatible tweaks to the ION core dmabuf exporter logic.
> 
> So what would the more complicated heaps be?
> 
>> That's why
>> dmabuf heaps is trying to destage ION in a way that allows heaps to
>> implement their exporter logic themselves, so we can start pulling
>> those more complicated heaps out of their vendor hidey-holes and get
>> some proper upstream review.
>>
>> But I suspect I just am confused as to what your suggesting. Maybe
>> could you expand a bit? Apologies for being a bit dense.
> 
> My suggestion is to merge the system and CMA heaps.  CMA (at least
> the system-wide CMA area) is really just an optimization to get
> large contigous regions more easily.  We should make use of it as
> transparent as possible, just like we do in the DMA code.
> 

It's not just an optimization for Ion though. Ion was designed to
let the callers choose between system and multiple CMA heaps. On other
systems there may be multiple CMA regions dedicated to a specific
purpose or placed at a specific address. The callers need to
be able to choose exactly whether they want a particular CMA region
or discontiguous regions.

Thanks,
Laura
