Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3B09C32753
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 00:07:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EB7D208C2
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 00:07:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=fossix-org.20150623.gappssmtp.com header.i=@fossix-org.20150623.gappssmtp.com header.b="uTNUm8o8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728432AbfHOAH3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 20:07:29 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:40550 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725895AbfHOAH3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 20:07:29 -0400
Received: by mail-pf1-f193.google.com with SMTP id w16so348181pfn.7
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2019 17:07:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fossix-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=6AkzvLAhb44ySDSJof1CTP/r441hp6IrMh57XhAQ5QU=;
        b=uTNUm8o8XrLZ9gJdyQUCzqYZPOXtQBONmBrOtlIg3G96m8gQeXFVHZ/GbdoZUgU0ex
         dPZgtSMZQ1l84qTJw9wpkmg8RXPiCpCn7WsvaBZU8FmMktORf6NYE/vEjjhmm3nTvEle
         JRfKL0vnPtnqxle8w60zC2OT7flRUEsenZdtRTvZjm9vbSvJmBjKpEfZSmYEdeTKYlKG
         WD5ac56SN1E3n/MJPeLK7XjbjXUDIWmdMnT2nauS6H5TSj4AxxXURYF96Qfis5HSbZjS
         qK+9oQAi7RC+rVzxnmvR6Oxl+uPcIohFR6H7V+nhF6CBJYg1lNrtmSY9BsVCpKj9EYOC
         evaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=6AkzvLAhb44ySDSJof1CTP/r441hp6IrMh57XhAQ5QU=;
        b=O3MpesX0tInthiInw4k3YHCcH4hcXNSKuZubsOGdqTIQpefgQiIYlcrYlEQhjLCYuj
         iWfQu9xer9/U5OhYp/ZMMqvd6Kfjr254u74X5+vWGGnAecn42q76qdAdumV2h259tgMD
         e6/zgar28Rht1v6D9Qv0JSzdtxaJYZ9Rm6y3DgXyrrisLJvcvvA7/juxwZouKD+U+Lw4
         qwX2wsw7OjiHI+ETVMcDYEeHYXntlX+94CalCcsosieNbaY4cn/pcsJAFIgpPaO70r9F
         mOHnykrcUeffsT456J4NTPZyhve89v68iUEsC8+rf7iE29vu7OF9s2WxcO+mgY8bwEjH
         AhkQ==
X-Gm-Message-State: APjAAAVCzFDsTByFkRZSszLxTSNZc1dgPyMoH8Z5aspSx9X01avuIUbr
        EhHR38eabrOXGCE+7cRaJ7X58ZsG7yN6mw==
X-Google-Smtp-Source: APXvYqwAf9uoH1s9sLDcRT8qkxaQoZiC+RAh4A0ZNB5kuA3yUd9Ew79QgOBoM1AP9p33GX0KgR8q+g==
X-Received: by 2002:a62:1688:: with SMTP id 130mr2607323pfw.187.1565827648302;
        Wed, 14 Aug 2019 17:07:28 -0700 (PDT)
Received: from localhost ([49.205.218.176])
        by smtp.gmail.com with ESMTPSA id n185sm762325pga.16.2019.08.14.17.07.26
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 14 Aug 2019 17:07:27 -0700 (PDT)
From:   Santosh Sivaraj <santosh@fossix.org>
To:     Balbir Singh <bsingharora@gmail.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Cc:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Mahesh Salgaonkar <mahesh@linux.ibm.com>,
        Reza Arbab <arbab@linux.ibm.com>,
        Chandan Rajendra <chandan@linux.vnet.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        christophe leroy <christophe.leroy@c-s.fr>
Subject: Re: [PATCH v9 7/7] powerpc: add machine check safe copy_to_user
In-Reply-To: <74d12529-d068-0210-e229-5cea68bcf9da@gmail.com>
References: <20190812092236.16648-1-santosh@fossix.org> <20190812092236.16648-8-santosh@fossix.org> <74d12529-d068-0210-e229-5cea68bcf9da@gmail.com>
Date:   Thu, 15 Aug 2019 05:37:24 +0530
Message-ID: <874l2jqojn.fsf@santosiv.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Balbir,

Balbir Singh <bsingharora@gmail.com> writes:

> On 12/8/19 7:22 pm, Santosh Sivaraj wrote:
>> Use  memcpy_mcsafe() implementation to define copy_to_user_mcsafe()
>> 
>> Signed-off-by: Santosh Sivaraj <santosh@fossix.org>
>> ---
>>  arch/powerpc/Kconfig               |  1 +
>>  arch/powerpc/include/asm/uaccess.h | 14 ++++++++++++++
>>  2 files changed, 15 insertions(+)
>> 
>> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
>> index 77f6ebf97113..4316e36095a2 100644
>> --- a/arch/powerpc/Kconfig
>> +++ b/arch/powerpc/Kconfig
>> @@ -137,6 +137,7 @@ config PPC
>>  	select ARCH_HAS_STRICT_KERNEL_RWX	if ((PPC_BOOK3S_64 || PPC32) && !RELOCATABLE && !HIBERNATION)
>>  	select ARCH_HAS_TICK_BROADCAST		if GENERIC_CLOCKEVENTS_BROADCAST
>>  	select ARCH_HAS_UACCESS_FLUSHCACHE	if PPC64
>> +	select ARCH_HAS_UACCESS_MCSAFE		if PPC64
>>  	select ARCH_HAS_UBSAN_SANITIZE_ALL
>>  	select ARCH_HAVE_NMI_SAFE_CMPXCHG
>>  	select ARCH_KEEP_MEMBLOCK
>> diff --git a/arch/powerpc/include/asm/uaccess.h b/arch/powerpc/include/asm/uaccess.h
>> index 8b03eb44e876..15002b51ff18 100644
>> --- a/arch/powerpc/include/asm/uaccess.h
>> +++ b/arch/powerpc/include/asm/uaccess.h
>> @@ -387,6 +387,20 @@ static inline unsigned long raw_copy_to_user(void __user *to,
>>  	return ret;
>>  }
>>  
>> +static __always_inline unsigned long __must_check
>> +copy_to_user_mcsafe(void __user *to, const void *from, unsigned long n)
>> +{
>> +	if (likely(check_copy_size(from, n, true))) {
>> +		if (access_ok(to, n)) {
>> +			allow_write_to_user(to, n);
>> +			n = memcpy_mcsafe((void *)to, from, n);
>> +			prevent_write_to_user(to, n);
>> +		}
>> +	}
>> +
>> +	return n;
>
> Do we always return n independent of the check_copy_size return value and
> access_ok return values?

Yes we always return the remaining bytes not copied even if check_copy_size
or access_ok fails.

Santosh

>
> Balbir Singh.
>
>> +}
>> +
>>  extern unsigned long __clear_user(void __user *addr, unsigned long size);
>>  
>>  static inline unsigned long clear_user(void __user *addr, unsigned long size)
>> 
