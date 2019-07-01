Return-Path: <SRS0=3QRk=U6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD3FBC5B578
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 21:21:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B26E921479
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 21:21:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726990AbfGAVVm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 17:21:42 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:33512 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726586AbfGAVVl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 17:21:41 -0400
Received: by mail-qk1-f196.google.com with SMTP id r6so12309334qkc.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2019 14:21:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vimy2am5tc+rD/xkaD9O/1ePz04QqMZDvQsC/rSI12s=;
        b=AvYMB/5UkUd0MiGVG4uID0Oqdpj7JGWzlm70Q/Lxmcsgf2SNFYWY4q+v+M3FSCTunG
         xud4HciKfCJvEIbEC90RtEj0Ue6fEco8cfZ3fqa5PX7ZYtgxRiGHA1WWl3qTxiOjcCGa
         nNYadNarw0dIK0SjaRknC6Wla3+7MxRKn2HzuPSuw3rKLWq6AXbICLxE/seMXSmihpFx
         mwM7cD/gZf9+bYY0OOoKtvNV4XiDnD9PCQXjoe823DGGj2Dml92+pDeUaQmk9bq5/69F
         B1RQ8Npnk0eRjm10X4yM2cL5DgrrXiyuq6USSiqpFur2dcNMz/LdVQNPm1Cp/N3shJwJ
         46MA==
X-Gm-Message-State: APjAAAV0uqq2OypfHivOIo3kHe5nTUnZkWNzweFyfU9gk6cgFZ7Zrsbc
        odya1xWjGkZHryGcViCmdv+3OV8P3Tw=
X-Google-Smtp-Source: APXvYqwEbwGu7VDvwiqInD0tVoU8N0fnnh+r4CbGnQjuUVQYOup5mfzdSxC71RXZqEmYxijJ1eI9lg==
X-Received: by 2002:a37:a541:: with SMTP id o62mr22546799qke.90.1562016100614;
        Mon, 01 Jul 2019 14:21:40 -0700 (PDT)
Received: from [192.168.1.157] (pool-96-235-39-235.pitbpa.fios.verizon.net. [96.235.39.235])
        by smtp.gmail.com with ESMTPSA id w19sm5032580qkj.66.2019.07.01.14.21.39
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Jul 2019 14:21:40 -0700 (PDT)
Subject: Re: [PATCH] staging: android: ion: Bail out upon SIGKILL when
 allocating memory.
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Sumit Semwal <sumit.semwal@linaro.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <000000000000a861f6058b2699e0@google.com>
 <03763360-a7de-de87-eb90-ba7838143930@I-love.SAKURA.ne.jp>
 <d088f188-5f32-d8fc-b9a0-0b404f7501cc@I-love.SAKURA.ne.jp>
 <ceef00e8-819a-c0f0-cbb5-60e60e6631fe@redhat.com>
 <CAO_48GHu+c3_AxeMSpWbgwPZx4j7JOd6x5t9Jto7=jjV1xw9HA@mail.gmail.com>
 <b863d9a0-ac5b-8187-4373-b0532cf60e76@i-love.sakura.ne.jp>
From:   Laura Abbott <labbott@redhat.com>
Message-ID: <37ac2d6d-3fc6-53eb-c2cd-20c0e9ac2054@redhat.com>
Date:   Mon, 1 Jul 2019 17:21:39 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <b863d9a0-ac5b-8187-4373-b0532cf60e76@i-love.sakura.ne.jp>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/1/19 5:02 PM, Tetsuo Handa wrote:
> On 2019/07/01 23:02, Sumit Semwal wrote:
>>> Acked-by: Laura Abbott <labbott@redhat.com>
>> fwiw, Acked-by: Sumit Semwal <sumit.semwal@linaro.org>
> 
> Thank you for responding. You can carry this patch via whichever tree you like.
> 
> By the way, is "memory allocation from ion_system_heap_allocate() is calling
> ion_system_heap_shrink()"
> ( https://lkml.kernel.org/r/03763360-a7de-de87-eb90-ba7838143930@I-love.SAKURA.ne.jp )
> what we want? Such memory allocations might not want to call shrinkers...
> 

For what Ion gets typically used for we do want to be calling shrinkers.
I've had discussions with people in the past about the risk of Ion as
DoS vector due to its ability to allocate large amounts of memory.
At the very least, we probably shouldn't be trying to call the Ion shrinker
when we're in the middle of an ion allocation since shrinking won't do us
any good. We're in the process of re-working Ion at the moment so this
might be a good topic to bring up again.

Thanks,
Laura
