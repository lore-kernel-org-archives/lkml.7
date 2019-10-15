Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92BDFC10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 04:50:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E6622089C
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 04:50:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728063AbfJOEuW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 00:50:22 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:52265 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726825AbfJOEuV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 00:50:21 -0400
Received: from mail-pl1-f198.google.com ([209.85.214.198])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <gpiccoli@canonical.com>)
        id 1iKEmp-0002pF-Q1
        for linux-kernel@vger.kernel.org; Tue, 15 Oct 2019 04:50:19 +0000
Received: by mail-pl1-f198.google.com with SMTP id d1so11342447plj.9
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2019 21:50:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=arIxZVQOQ+cfkJxb4yxz7C3o33+rZWOc/lBYT2wRroE=;
        b=dMwq4NIO8AUWMN4zFUP3Ei6b4hVMVnZFO+W4KwAVNj92KC1QIlLS5unJbVUI24oHTH
         HX665AP3y7a+FJ9Ln0PlFmko3MHHtVj9DErfB121qI6k4GCsB/YFwalzMB9CBKPlrASq
         vEDvMHNRFfQ0vZ12KSIY06AcXvDo7T6Q1RLOJ6l3+8w7v+XyJuNYxG26vqsbaGhTuz75
         PsZB2i0maQENLpBv9NwWGaazymWQf/PNILCCY7TEnEkX8+0EvvXnH5H4xcf6Jy3CXpTo
         Jt3zBb92uc96e8o+tGbaOkx/tJnbVW4MvzMBvASBtAS0CqeY0s/8cfQitiVghMRPZlMg
         1DTg==
X-Gm-Message-State: APjAAAVrcUhNYqAnggbGL5bRviBBfAw1fFM4WbIuvy7HIZK9x+1K3QmM
        jcnkFN+11DrgNNl4m1fqgcGcQxMzH+OHPS3NsDehuy54c+dd0Vd0lv+oixC/RRXXZt5Yg2zZpDp
        DNx5sDSUJYIrxNwBBj7OcdqrfuVfZH8njguAKar2bdw==
X-Received: by 2002:a63:e211:: with SMTP id q17mr36673529pgh.316.1571115018403;
        Mon, 14 Oct 2019 21:50:18 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzBj0er8XaKQeV5zGp92dPcULkWzyxa66qJbWhpo3yzosfwO2gJWjcOGh5E2EMS4KJlOsqjTA==
X-Received: by 2002:a63:e211:: with SMTP id q17mr36673498pgh.316.1571115017970;
        Mon, 14 Oct 2019 21:50:17 -0700 (PDT)
Received: from [192.168.1.200] (201-92-249-168.dsl.telesp.net.br. [201.92.249.168])
        by smtp.gmail.com with ESMTPSA id w6sm22169908pfj.17.2019.10.14.21.50.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 14 Oct 2019 21:50:17 -0700 (PDT)
Subject: Re: [PATCH] hugetlb: Add nohugepages parameter to prevent hugepages
 creation
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        jay.vosburgh@canonical.com, kernel@gpiccoli.net
References: <20191011223955.1435-1-gpiccoli@canonical.com>
 <c145a020-5ae0-e3a5-0251-199618cfaa9e@oracle.com>
From:   "Guilherme G. Piccoli" <gpiccoli@canonical.com>
Openpgp: preference=signencrypt
Autocrypt: addr=gpiccoli@canonical.com; prefer-encrypt=mutual; keydata=
 mQENBFpVBxcBCADPNKmu2iNKLepiv8+Ssx7+fVR8lrL7cvakMNFPXsXk+f0Bgq9NazNKWJIn
 Qxpa1iEWTZcLS8ikjatHMECJJqWlt2YcjU5MGbH1mZh+bT3RxrJRhxONz5e5YILyNp7jX+Vh
 30rhj3J0vdrlIhPS8/bAt5tvTb3ceWEic9mWZMsosPavsKVcLIO6iZFlzXVu2WJ9cov8eQM/
 irIgzvmFEcRyiQ4K+XUhuA0ccGwgvoJv4/GWVPJFHfMX9+dat0Ev8HQEbN/mko/bUS4Wprdv
 7HR5tP9efSLucnsVzay0O6niZ61e5c97oUa9bdqHyApkCnGgKCpg7OZqLMM9Y3EcdMIJABEB
 AAG0LUd1aWxoZXJtZSBHLiBQaWNjb2xpIDxncGljY29saUBjYW5vbmljYWwuY29tPokBNwQT
 AQgAIQUCWmClvQIbAwULCQgHAgYVCAkKCwIEFgIDAQIeAQIXgAAKCRDOR5EF9K/7Gza3B/9d
 5yczvEwvlh6ksYq+juyuElLvNwMFuyMPsvMfP38UslU8S3lf+ETukN1S8XVdeq9yscwtsRW/
 4YoUwHinJGRovqy8gFlm3SAtjfdqysgJqUJwBmOtcsHkmvFXJmPPGVoH9rMCUr9s6VDPox8f
 q2W5M7XE9YpsfchS/0fMn+DenhQpV3W6pbLtuDvH/81GKrhxO8whSEkByZbbc+mqRhUSTdN3
 iMpRL0sULKPVYbVMbQEAnfJJ1LDkPqlTikAgt3peP7AaSpGs1e3pFzSEEW1VD2jIUmmDku0D
 LmTHRl4t9KpbU/H2/OPZkrm7809QovJGRAxjLLPcYOAP7DUeltveuQENBFpVBxcBCADbxD6J
 aNw/KgiSsbx5Sv8nNqO1ObTjhDR1wJw+02Bar9DGuFvx5/qs3ArSZkl8qX0X9Vhptk8rYnkn
 pfcrtPBYLoux8zmrGPA5vRgK2ItvSc0WN31YR/6nqnMfeC4CumFa/yLl26uzHJa5RYYQ47jg
 kZPehpc7IqEQ5IKy6cCKjgAkuvM1rDP1kWQ9noVhTUFr2SYVTT/WBHqUWorjhu57/OREo+Tl
 nxI1KrnmW0DbF52tYoHLt85dK10HQrV35OEFXuz0QPSNrYJT0CZHpUprkUxrupDgkM+2F5LI
 bIcaIQ4uDMWRyHpDbczQtmTke0x41AeIND3GUc+PQ4hWGp9XABEBAAGJAR8EGAEIAAkFAlpV
 BxcCGwwACgkQzkeRBfSv+xv1wwgAj39/45O3eHN5pK0XMyiRF4ihH9p1+8JVfBoSQw7AJ6oU
 1Hoa+sZnlag/l2GTjC8dfEGNoZd3aRxqfkTrpu2TcfT6jIAsxGjnu+fUCoRNZzmjvRziw3T8
 egSPz+GbNXrTXB8g/nc9mqHPPprOiVHDSK8aGoBqkQAPZDjUtRwVx112wtaQwArT2+bDbb/Y
 Yh6gTrYoRYHo6FuQl5YsHop/fmTahpTx11IMjuh6IJQ+lvdpdfYJ6hmAZ9kiVszDF6pGFVkY
 kHWtnE2Aa5qkxnA2HoFpqFifNWn5TyvJFpyqwVhVI8XYtXyVHub/WbXLWQwSJA4OHmqU8gDl
 X18zwLgdiQ==
Message-ID: <92e8451a-3a64-cde9-a879-10c0c9e857aa@canonical.com>
Date:   Tue, 15 Oct 2019 01:50:07 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <c145a020-5ae0-e3a5-0251-199618cfaa9e@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/10/2019 15:25, Mike Kravetz wrote:
>  [...]
> I don't know much about early_param(), so I will assume this works as you
> describe.  However, a quick grep shows hugepage options for ia64 also with
> early_param.
> 

Thanks a lot for the prompt and quite informative reply Mike.
I've checked this IA64 parameter after your mention, and it just sets
the hugepages size, I don't think it'll affect the purpose of this patch.


>> * The return when sysctl handler is prevented to progress due to
>> nohugepages is -EINVAL, but could be changed; I've just followed
>> present code there, but I'm OK changing that if we have suggestions.
> 
> It looks like you only have short circuited/prevented nr_hugepages via
> sysfs/sysctl.  Theoretically, one could set nr_overcommit_hugepages and
> still allocate hugetlb pages.  So, if you REALLY want to shut things down
> you need to stop this as well.
> 
> There is already a macro hugepages_supported() that can be set by arch
> specific code.  I wonder how difficult it would be to 'overwrite' the
> macro if nohugepages is specified.  Perhaps just a level of naming
> indirection.  This would use the existing code to prevent all hugetlb usage.
>

Outstanding! It's a much better idea to use hugepages_supported()
infrastructure, it prevents even the creation of hugepages-related sysfs
entries; I've worked a V2 with this modification, and it worked fine,
thanks for the suggestion.


> It seems like there may be some discussion about 'the right' way to
> do kdump.  I can't add to that discussion, but if such an option as
> nohugepages is needed, I can help.
> 

I think this parameter may be important/useful not only for kdump - it
is a legitimate way of disabling hugepages, something we don't currently
have on kernel. I'll submit a V2, for Ubuntu kdump specially this is
quite helpful!

Cheers,


Guilherme
