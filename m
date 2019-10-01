Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D310ECE58A
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 16:02:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7061B2133F
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 16:02:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="erLpYgoQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389853AbfJAQCU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 12:02:20 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:45556 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732756AbfJAQCT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 12:02:19 -0400
Received: by mail-io1-f67.google.com with SMTP id c25so49225714iot.12
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2019 09:02:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=gzi5F38nYz4q1+zWjnpkp9mXCPxISIRw+yzzuhROKoQ=;
        b=erLpYgoQl2arc1QonX+IsMDjWEUHNpnW9f9j4jwZaYF6hJx30OnZQoJHPQ7PbEgvRh
         N+23Lxx4oQuiX7VBPH8Rv3Nn+vNXwsQNb7ZK/j+ThkrbV4F9s+Rr/4gIrBX31lI0sNFH
         t4wFITNnYulUWlgwYo/bcwIZhDuf5TCvH8aa45ga4RxWzUNXU2boT1Nxh6SGxeKYbkCU
         Fy7c1s/lxtG8uAyf3VQ6SHv3/fUbFseSYz3+pjJmdji3xhwlaL/rSkOZiaUHYnDJkuVR
         18R34znx1vWuIIONLqXhuktbSEzuU3F9uTBCilG4OxVsX206jcB9cnkOCN4syu038gk+
         clYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gzi5F38nYz4q1+zWjnpkp9mXCPxISIRw+yzzuhROKoQ=;
        b=hyKrYjtsDsoj3QuI4N5dfArH8uGLR3k0gapccjaOu/Oi54D2beM8osjwHmcs0C9XM2
         3sykSFYNPOarL7H2f0txhhY7DGLmq1HFwAZ6jMsf/9TXpzphGzQb6BGg8Suh0r9X2IzS
         e0qlp/PXEzC6Xl2fMV8APPQg5fP/Tk70ypIYmc11KVIb8zJiDVPZibKGbBGudVlY4v4R
         YM9kOtXoXgnDueI5fd6arHJeozphfO7bYmwLxMnxsWZOOh2syhDNepaYC37wU/At/l8Z
         OmMNbqt/ubG9CmvYFr+HHLOhzt3ZVOssE8Ef7wuruPQfXAIwEfL71GTe4kWouNZXZv1i
         p+Nw==
X-Gm-Message-State: APjAAAVNli3r0cyTiHQzmYrDs++W6URM+uXgkdYNAGXkq2jDSedJi1sN
        FHEyT3+QhlGjO+n6FlmgTqRq22W7UWkSMg==
X-Google-Smtp-Source: APXvYqzzyMV7tR/JUb30p2Yc/xp2zJL29JdNUr7d9S5n2DetK2I4DerUSEPK2xTBqvGazQna4WtLMA==
X-Received: by 2002:a6b:6613:: with SMTP id a19mr17190502ioc.241.1569945737769;
        Tue, 01 Oct 2019 09:02:17 -0700 (PDT)
Received: from [192.168.1.50] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id q11sm6978034ilc.29.2019.10.01.09.02.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 01 Oct 2019 09:02:16 -0700 (PDT)
Subject: Re: [PATCH] io_uring: use __kernel_timespec in timeout ABI
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     y2038 Mailman List <y2038@lists.linaro.org>,
        Linux API <linux-api@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        =?UTF-8?Q?Stefan_B=c3=bchler?= <source@stbuehler.de>,
        Hannes Reinecke <hare@suse.com>,
        Jackie Liu <liuyun01@kylinos.cn>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hristo Venev <hristo@venev.name>,
        linux-block <linux-block@vger.kernel.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20190930202055.1748710-1-arnd@arndb.de>
 <8d5d34da-e1f0-1ab5-461e-f3145e52c48a@kernel.dk>
 <623e1d27-d3b1-3241-bfd4-eb94ce70da14@kernel.dk>
 <CAK8P3a3AAFXNmpQwuirzM+jgEQGj9tMC_5oaSs4CfiEVGmTkZg@mail.gmail.com>
 <ca0a5bbe-c20e-d5be-110e-942c604ad2d7@kernel.dk>
 <CAK8P3a19TDk0uo1eu4CcaKHvQCPUJGMjBV8Txtpgvg1ifAgW_A@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <77f90d5b-d6f8-b395-ba57-9d1f0ece9a00@kernel.dk>
Date:   Tue, 1 Oct 2019 10:02:15 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAK8P3a19TDk0uo1eu4CcaKHvQCPUJGMjBV8Txtpgvg1ifAgW_A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/1/19 9:57 AM, Arnd Bergmann wrote:
> On Tue, Oct 1, 2019 at 5:52 PM Jens Axboe <axboe@kernel.dk> wrote:
>> On 10/1/19 9:49 AM, Arnd Bergmann wrote:
>>> On Tue, Oct 1, 2019 at 5:38 PM Jens Axboe <axboe@kernel.dk> wrote:
> 
>>> What's wrong with using __kernel_timespec? Just the name?
>>> I suppose liburing could add a macro to give it a different name
>>> for its users.
>>
>> Just that it seems I need to make it available through liburing on
>> systems that don't have it yet. Not a big deal, though.
> 
> Ah, right. I t would not cover the case of building against kernel
> headers earlier than linux-5.1 but running on a 5.4+ kernel.
> 
> I assumed that that you would require new kernel headers anyway,
> but if you have a copy of the io_uring header, that is not necessary.

Since I rely mostly on folks using liburing, we include the header as
well. So I'm just going to use __kernel_timespec in liburing, and have
a check to define it if we don't have it.

>> One thing that struck me about this approach - we then lose the ability to
>> differentiate between "don't want a timed timeout" with ts == NULL, vs
>> tv_sec and tv_nsec both being 0.
> 
> You could always define a special constant such as
> '#define IO_URING_TIMEOUT_NEVER -1ull' if you want to
> support for 'never wait if it's not already done' and 'wait indefinitely'.

That thought did occur to me, but that seems pretty ugly... The ts == NULL
vs ts != NULL and timeout set is a more well understood pattern.

-- 
Jens Axboe

