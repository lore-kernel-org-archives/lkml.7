Return-Path: <SRS0=SHWF=W4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86559C3A5A4
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Sep 2019 20:35:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FF2021897
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Sep 2019 20:35:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mvxfW2Rt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728961AbfIAUfU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Sep 2019 16:35:20 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:37155 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725955AbfIAUfU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Sep 2019 16:35:20 -0400
Received: by mail-pf1-f195.google.com with SMTP id y9so7689877pfl.4
        for <linux-kernel@vger.kernel.org>; Sun, 01 Sep 2019 13:35:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=UMz9j13CPipWdVYjch4adDtFWXAtjYrNSKsSdKhSILc=;
        b=mvxfW2Rt8/0uJ/cwQTEzc73ZEEki9DlUFiE5zlUcm3w4ZfNRAEYIWuarl+f8hwy6JY
         5DFaenL7to7Y3eZdBjobZpoLP5jUacAsTXheeGrznPYzl1I6PTTul1/dKs4tyHj82I41
         5io3t1x3adYBQBDjUbpL2Jy8v/kPnnjL22wlnPAi2hZpWpbDEjYZolEVXPJRsLBvMxDa
         az1bUoS+nkrh8YpQaxjLf+OadAonPIdMpPoMRJc69s67xUVpGcUNGBx7Z26Q6iAUdD+9
         PQBZnrrtuzCX41GtyguSJU4y75FDfcWA1Dx6wRXpx65hEnMTh+dHJg1xb3AXyuzaLLKl
         n8BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UMz9j13CPipWdVYjch4adDtFWXAtjYrNSKsSdKhSILc=;
        b=l8ZgbAd9h8PiC+kNiBeagQSSNyAUzHWqjdDNT9mbRHZfVdH8oGqjCRExMEibGdx/vL
         cOtRCdsTejeZrShSxTerllt2xic2csylxjBrqpPFdaqBNQEa2Lw3WCmUdngqB8JTIrHm
         V6ZVj9n6A+Eim5K1wLXTNvqGgyiCsQpoocpAZPpwynMQ4kZop1HHNw3aGQd9OP5XMksj
         LlL2afxFFJ2MtWY4ecLtXpmqNIsRpmBKnInwaORk3rgXly8nkS82AUsRdP3jkWtFWsm0
         kh+h3GuOkxRoEIaWkvLLAlkhVnvWL1bFX2O4rVyQAPpcN4ee1LMxztoJbNPwhbMy1HaY
         QDvg==
X-Gm-Message-State: APjAAAVReWoUcL/KUwysKeDAvkmx8aXbnaaysscvZJj1tlXWNi6FqhqM
        9atmAhwJWop1+mcOvjvjAJg=
X-Google-Smtp-Source: APXvYqzDuqMnY2mVqsHstoNFhTFtZtR0N4sRPNa9WtkN7E4Z8qlDxM2h2ZN0mOnp1q1WaDWiylowGA==
X-Received: by 2002:a65:640a:: with SMTP id a10mr21967201pgv.338.1567370119245;
        Sun, 01 Sep 2019 13:35:19 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id r4sm8176158pji.7.2019.09.01.13.35.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 01 Sep 2019 13:35:18 -0700 (PDT)
Subject: Re: [PATCH 2/3] pagewalk: separate function pointers from iterator
 data
To:     Jason Gunthorpe <jgg@mellanox.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?UTF-8?Q?Thomas_Hellstr=c3=b6m?= <thomas@shipmail.org>,
        Jerome Glisse <jglisse@redhat.com>,
        Steven Price <steven.price@arm.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Thomas Hellstrom <thellstrom@vmware.com>
References: <20190828141955.22210-1-hch@lst.de>
 <20190828141955.22210-3-hch@lst.de> <20190901184530.GA18656@roeck-us.net>
 <20190901193601.GB5208@mellanox.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <b26ac5ae-a90c-7db5-a26c-3ace2f1530c7@roeck-us.net>
Date:   Sun, 1 Sep 2019 13:35:16 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190901193601.GB5208@mellanox.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/1/19 12:36 PM, Jason Gunthorpe wrote:
> On Sun, Sep 01, 2019 at 11:45:30AM -0700, Guenter Roeck wrote:
>> On Wed, Aug 28, 2019 at 04:19:54PM +0200, Christoph Hellwig wrote:
>>> The mm_walk structure currently mixed data and code.  Split out the
>>> operations vectors into a new mm_walk_ops structure, and while we
>>> are changing the API also declare the mm_walk structure inside the
>>> walk_page_range and walk_page_vma functions.
>>>
>>> Based on patch from Linus Torvalds.
>>>
>>> Signed-off-by: Christoph Hellwig <hch@lst.de>
>>> Reviewed-by: Thomas Hellstrom <thellstrom@vmware.com>
>>> Reviewed-by: Steven Price <steven.price@arm.com>
>>> Reviewed-by: Jason Gunthorpe <jgg@mellanox.com>
>>
>> When building csky:defconfig:
>>
>> In file included from mm/madvise.c:30:
>> mm/madvise.c: In function 'madvise_free_single_vma':
>> arch/csky/include/asm/tlb.h:11:11: error:
>> 	invalid type argument of '->' (have 'struct mmu_gather')
> 
> I belive the macros above are missing brackets.. Can you confirm the
> below takes care of things? I'll add a patch if so
> 

Good catch. Yes, that fixes the build problem.

Guenter

> diff --git a/arch/csky/include/asm/tlb.h b/arch/csky/include/asm/tlb.h
> index 8c7cc097666f04..fdff9b8d70c811 100644
> --- a/arch/csky/include/asm/tlb.h
> +++ b/arch/csky/include/asm/tlb.h
> @@ -8,14 +8,14 @@
>   
>   #define tlb_start_vma(tlb, vma) \
>   	do { \
> -		if (!tlb->fullmm) \
> -			flush_cache_range(vma, vma->vm_start, vma->vm_end); \
> +		if (!(tlb)->fullmm) \
> +			flush_cache_range(vma, (vma)->vm_start, (vma)->vm_end); \
>   	}  while (0)
>   
>   #define tlb_end_vma(tlb, vma) \
>   	do { \
> -		if (!tlb->fullmm) \
> -			flush_tlb_range(vma, vma->vm_start, vma->vm_end); \
> +		if (!(tlb)->fullmm) \
> +			flush_tlb_range(vma, (vma)->vm_start, (vma)->vm_end); \
>   	}  while (0)
>   
>   #define tlb_flush(tlb) flush_tlb_mm((tlb)->mm)
> 
> Thanks,
> Jason
> 

