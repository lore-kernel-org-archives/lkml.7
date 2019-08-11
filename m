Return-Path: <SRS0=XJun=WH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15B1DC433FF
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Aug 2019 01:35:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6E41208C2
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Aug 2019 01:35:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=fossix-org.20150623.gappssmtp.com header.i=@fossix-org.20150623.gappssmtp.com header.b="AXhhUFeo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726492AbfHKBfM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Aug 2019 21:35:12 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:36628 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725863AbfHKBfM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Aug 2019 21:35:12 -0400
Received: by mail-pg1-f193.google.com with SMTP id l21so47729067pgm.3
        for <linux-kernel@vger.kernel.org>; Sat, 10 Aug 2019 18:35:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fossix-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=Zw+nh8qCKQOD3K2GFW9bgpIFhSU9vSD+z99NnnwXM2c=;
        b=AXhhUFeoBKKdT9LsBrc2PAhjlbi66oD6k7OARW/cod+XbPKUbLhJWk1yy6JGRz4xUP
         x2H4e7331p+kJl0SVIcrzZSO1AfMmOte1PoYKDuWy1amc+HoFuQck8bflfZx2w0ODNs+
         ri4t//L0Keq5NT5hHM+Tgz4gEAcEn9ql6eaYoKF8HepGxWjANmlw5JKddNdfvtjyi3wu
         w7nR3+4uoFGBzjBsMoEHyEMMQH42pt/I4zX+649Knjg+Bl/exC8h2hewQnHaTGXh4pkL
         6UwLPZYdYoRNbvNjvzBDNSelAqF4gOL2AhvqN7fMj82ba/iPE6b5GSelJ4NVkbzbu4Qc
         aY8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=Zw+nh8qCKQOD3K2GFW9bgpIFhSU9vSD+z99NnnwXM2c=;
        b=AdsWFPtdxIWqkIr++qY+rrCHVJgAZ/gPe1QnU0xyPTVQ3e6GAphVILe5kB/CUVHgib
         9tasHC/rPgBr/uDL7n6pzcLKxYtpF8FJtDUtvEnQwCRJeVZGcV20VDlfGhAcEqGttkIs
         WRtCdB0AVRvpTGcStenogu8UteGrliMJGG2RKegBPIcFzEtc3N2eHeCNY52gyhuVpe6I
         E647bnLcwFEwXJr8lKm3cVqCLZbhfmqjcOtIPf32lGYfdZye5m44jehUg/Bx3kHY0CJt
         O6vqioRAdu4FBjZ8Y5Exw60jYhMHKb5B1osGO6oTPrY/32tsEks+0EoVvxPCTrOUTHjW
         Pxpw==
X-Gm-Message-State: APjAAAUJj38rZDcqXD/2OBrC7HqYh0LC6TeMe95KY4KwwaFjC1PBmmxO
        Tc/TKcdv/kVLuq8D3uMkyCacPw==
X-Google-Smtp-Source: APXvYqydaLReTPGJtMm22+pRsfy2OronyOq4BntAxsQzFMMtz7OvGX0hZQWSl1UjwwA74cJeApqAqQ==
X-Received: by 2002:a17:90a:8c18:: with SMTP id a24mr16554646pjo.111.1565487311837;
        Sat, 10 Aug 2019 18:35:11 -0700 (PDT)
Received: from localhost ([183.82.18.139])
        by smtp.gmail.com with ESMTPSA id 21sm8443524pjh.25.2019.08.10.18.35.10
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sat, 10 Aug 2019 18:35:11 -0700 (PDT)
From:   Santosh Sivaraj <santosh@fossix.org>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Cc:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Mahesh Salgaonkar <mahesh@linux.ibm.com>,
        Reza Arbab <arbab@linux.ibm.com>,
        Balbir Singh <bsingharora@gmail.com>,
        Chandan Rajendra <chandan@linux.vnet.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        christophe leroy <christophe.leroy@c-s.fr>
Subject: Re: [PATCH v8 7/7] powerpc: add machine check safe copy_to_user
In-Reply-To: <87lfw1s6u0.fsf@concordia.ellerman.id.au>
References: <20190807145700.25599-1-santosh@fossix.org> <20190807145700.25599-8-santosh@fossix.org> <87lfw1s6u0.fsf@concordia.ellerman.id.au>
Date:   Sun, 11 Aug 2019 07:05:09 +0530
Message-ID: <87mugg8oxe.fsf@santosiv.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Ellerman <mpe@ellerman.id.au> writes:

> Santosh Sivaraj <santosh@fossix.org> writes:
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
>> +}
>
> This looks OK to me.
>
> It would be nice though if copy_to_user_mcsafe() followed the pattern of
> the other copy_to_user() etc. routines where the arch code is only
> responsible for the actual arch details, and all the checks are done in
> the generic code. That would be a good cleanup to do after this has gone
> in, as the 2nd implementation of the API.

Sure, will do that.

>
> cheers

