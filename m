Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFFF0C432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 02:34:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EACA206D6
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 02:34:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="vRfVZ/9Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726325AbfKRCet (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Nov 2019 21:34:49 -0500
Received: from mail-pl1-f182.google.com ([209.85.214.182]:45561 "EHLO
        mail-pl1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725905AbfKRCes (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Nov 2019 21:34:48 -0500
Received: by mail-pl1-f182.google.com with SMTP id w7so8831065plz.12
        for <linux-kernel@vger.kernel.org>; Sun, 17 Nov 2019 18:34:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=nxeQCTFouT/2s5fT1e6V3nFQ4a6l1Cid4i4aOiaISzE=;
        b=vRfVZ/9Q0OQ9iYI/uGlws6Bk0WXb0lrIG6WllpGzCR/3YfmPGXJRNX1o1kE+hBsNrS
         QISpjk9kgyisEOmDFk9huwsluLKfDEmdt2Y/QsDB0AwdU3GhaBK3wvNFYOvs8Ild/GOq
         WxFkAYV9wvlR79VA/dQqoVZ/V9/vPEI32NUlTwPBfosKNy5PZi453Bz5Yg++TlayasrT
         D9sExeJD1rC54Ae4QeCUiXRNeJp+EkvyvzuyBFSoEhpAyJE0ufM+Uxw8J03XzvMbx6j6
         clST7zS1dA1LYdXOWDb6q4Wc9sPLsacv6eerQDHV8i+eXLCXIkH5AhwC6CNU2/NTVyCo
         hC2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nxeQCTFouT/2s5fT1e6V3nFQ4a6l1Cid4i4aOiaISzE=;
        b=lRPq37YtL8X3eVCv785tGyGDOCt//2CFCLskRXlfQJ6d4m7dk2cc9mP07brGs+gpL+
         u1MeJaif9le0Nvvq673dlyd7UR15+bzZpM6Bts+BrVQcfbcu03FKeUkI3Dx7lmCh6Z2k
         S5dak8CevTC231yvaTdgiXtCxDYJH/78ymyO4vFszOcEleCk7pBPTQaic6v3ErZFlbaQ
         /MxpEl8KOrJDqEbnSgiDdvSb/nr/LegPB8GoCrjlmgs3jNsXFGwg09b2gfB7cdmU9/9C
         WLHJ3tqsMCyTrdD/SAToekFdwRcW98nbTqzA+xJ9XW+y08aXhkQWhvHE2lybQqNVQ9Ot
         Z0bg==
X-Gm-Message-State: APjAAAWmTJ2Xv2DWzoBdRkmKN2UmvHUKyaQY30O8s55SnkJ1gj4ctex9
        9RavUXGayPe1loTw2phD7iXL8n4k5Wc=
X-Google-Smtp-Source: APXvYqzoCcD4MZKcKt/hzJeZ34eSGd4uZVquwZDi1OIa0omZc9KytuAg6FmOthTJrsvred2sJfcdJw==
X-Received: by 2002:a17:902:b203:: with SMTP id t3mr22878135plr.51.1574044486212;
        Sun, 17 Nov 2019 18:34:46 -0800 (PST)
Received: from [192.168.1.188] ([66.219.217.79])
        by smtp.gmail.com with ESMTPSA id e59sm21281508pjk.28.2019.11.17.18.34.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Nov 2019 18:34:45 -0800 (PST)
Subject: Re: Recent slowdown in single object builds
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <d60946a1-fde3-ee6f-683a-42a611768bbf@kernel.dk>
 <CAK7LNATVHbMHqjboACJF8BbKianRfjiGhHTXjtQuJVmv2HFPUA@mail.gmail.com>
 <8caa1edf-9c6f-15e4-218d-c266013f8e28@kernel.dk>
 <CAK7LNARUzJx==c1gh33obme21JiRR1CrKELkGpmPJQANx0LqSw@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <38007c4c-45ff-d00e-05c5-948a2df783df@kernel.dk>
Date:   Sun, 17 Nov 2019 19:34:42 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAK7LNARUzJx==c1gh33obme21JiRR1CrKELkGpmPJQANx0LqSw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/17/19 5:40 PM, Masahiro Yamada wrote:
> On Sun, Nov 17, 2019 at 1:57 AM Jens Axboe <axboe@kernel.dk> wrote:
>>
>> On 11/16/19 12:17 AM, Masahiro Yamada wrote:
>>> On Sat, Nov 16, 2019 at 8:10 AM Jens Axboe <axboe@kernel.dk> wrote:
>>>>
>>>> Hi,
>>>>
>>>> I've noticed that current -git is a lot slower at doing single object
>>>> builds than earlier kernels. Here's an example, building the exact same
>>>> file on 5.2 and -git:
>>>>
>>>> $ time make fs/io_uring.o
>>>> real    0m5.953s
>>>> user    0m5.402s
>>>> sys     0m0.649s
>>>>
>>>> vs 5.2 based (with all the backports, identical file):
>>>>
>>>> $ time make fs/io_uring.o
>>>> real    0m3.218s
>>>> user    0m2.968s
>>>> sys     0m0.520s
>>>>
>>>> Any idea what's going on here? It's almost twice as slow, which is
>>>> problematic...
> 
> 
> BTW, I am using a cheap machine based on Intel Core i7-6700K.
> I can build fs/io_uring.o (based on x86_64_defconfig) much faster.
> 
> 
> The slowdown (1.990 sec -> 2.861 sec) is not terrible for me.

For those of us that do single object builds all the time the slowdown
is pretty damn terrible. Granted that your 44% slowdown isn't as bad as
my 85% slowdown, but it's still a MASSIVE slowdown.

-- 
Jens Axboe

