Return-Path: <SRS0=try7=ZI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA8CAC432C3
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 16:57:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AE9F2168B
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 16:57:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="N0rkrwOS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727996AbfKPQ5L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Nov 2019 11:57:11 -0500
Received: from mail-pf1-f182.google.com ([209.85.210.182]:46598 "EHLO
        mail-pf1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727629AbfKPQ5L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Nov 2019 11:57:11 -0500
Received: by mail-pf1-f182.google.com with SMTP id 193so8143311pfc.13
        for <linux-kernel@vger.kernel.org>; Sat, 16 Nov 2019 08:57:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=wCeZ0NDBlm1EZsjaPHiNTtKC7YyU9Uu+b4m8bOtAPXg=;
        b=N0rkrwOS9sB1urDsg27aLJxdVbBic6I77fwClS0ekU7+kMm4LFytBJ6m455Cg+hMfE
         9aoLbJ/CWtbq36rAKzdmNsB811neVbr6WZdIS/SCe/Vw2SNw9a2tbzfAZQ5QCeoYA6Ny
         p4K1bmFpnYHEq2qOoaZdfuKPMJfl131COdOkrhLL/GGhUsra7BRgRf4GVFDYKvEHbhpY
         dlbUQ+PlzSGh23WFx78F2vU/sQ7+lWJw9agZH25VqeMOk1FZwLvRrqxq1IPtqsvYLJnh
         w28rGzcw2Elq+2fbU2h+HJ9ms6A/Pog88PpTOz1U0zv+Oj+YaNWJv4DU3Bbxn4ICdrKT
         ib/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wCeZ0NDBlm1EZsjaPHiNTtKC7YyU9Uu+b4m8bOtAPXg=;
        b=EiGAb1lzNTtz1Z0UED9R0nniEJIxScCPdKy/HqEfOX96djCPtogi4/+0GEzRN8QlZO
         PxE+POiHlGNHur05+26ca+QdnIXJK8KCTWHq06+vXMSfXVgwGAYZS0RLnkVD9+onc/p6
         TFCS5c6iJYPFWwpd3ZDe3zQNsSBKhbjopXrdzxGqXgrPDKBYj1H4ps6kESN3cdZDT81f
         ngnwt4XN8Rdd7pGQqrdmHNulCG51JlPZsPamErt5ZFivCd4khz72+lsTjyhS43+KQ7Q5
         4EEBNsz08awYKyLDS0+7jb2Ic5CDCgQrEZe3T829sSnpyxT8tb4ZPqQFIrNEXTlMA0Eb
         UIeg==
X-Gm-Message-State: APjAAAW9b7lCkFI/HyvA/noZuLXRb0BqgzU8/r3rI+ZGMxxXBlaSQLSD
        MBlpFTOuVU5geEdh6uSGeFFc7lDcSik=
X-Google-Smtp-Source: APXvYqy28OXnOcl3MnoKQYULSLufjgDhybJA8Jumo7y7yI158d4acIWCAag6l/sfkVj2Li7NJ/MQHg==
X-Received: by 2002:a62:c1c1:: with SMTP id i184mr24285676pfg.65.1573923429814;
        Sat, 16 Nov 2019 08:57:09 -0800 (PST)
Received: from [192.168.1.188] ([66.219.217.79])
        by smtp.gmail.com with ESMTPSA id fz12sm12738027pjb.15.2019.11.16.08.57.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 16 Nov 2019 08:57:08 -0800 (PST)
Subject: Re: Recent slowdown in single object builds
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <d60946a1-fde3-ee6f-683a-42a611768bbf@kernel.dk>
 <CAK7LNATVHbMHqjboACJF8BbKianRfjiGhHTXjtQuJVmv2HFPUA@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <8caa1edf-9c6f-15e4-218d-c266013f8e28@kernel.dk>
Date:   Sat, 16 Nov 2019 09:57:06 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAK7LNATVHbMHqjboACJF8BbKianRfjiGhHTXjtQuJVmv2HFPUA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/16/19 12:17 AM, Masahiro Yamada wrote:
> On Sat, Nov 16, 2019 at 8:10 AM Jens Axboe <axboe@kernel.dk> wrote:
>>
>> Hi,
>>
>> I've noticed that current -git is a lot slower at doing single object
>> builds than earlier kernels. Here's an example, building the exact same
>> file on 5.2 and -git:
>>
>> $ time make fs/io_uring.o
>> real    0m5.953s
>> user    0m5.402s
>> sys     0m0.649s
>>
>> vs 5.2 based (with all the backports, identical file):
>>
>> $ time make fs/io_uring.o
>> real    0m3.218s
>> user    0m2.968s
>> sys     0m0.520s
>>
>> Any idea what's going on here? It's almost twice as slow, which is
>> problematic...
> 
> 
> 
> This is necessary cost
> to do single builds
> (394053f4a4b3e3eeeaa67b67fc886a9a75bd9e4d)
> but, it is much better in linux-next.

Very sad that it's now twice as slow as before, that's a real problem.
This isn't a marginal slowdown.

I've never had issues with single object builds before, and in fact
it's often useful to build stuff that's disabled as a single object.
Where's the report that led to this commit being necessary?

-- 
Jens Axboe

