Return-Path: <SRS0=8hmg=W5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73200C3A59B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 07:38:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EAAD2190F
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 07:38:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729809AbfIBHij (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Sep 2019 03:38:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37526 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725839AbfIBHij (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 03:38:39 -0400
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 76BEC3B554
        for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2019 07:38:38 +0000 (UTC)
Received: by mail-pf1-f200.google.com with SMTP id v134so11167156pfc.18
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2019 00:38:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cempGh8txjaiNfEhKediKSz1B2YFsDdJLO12R3i/OBE=;
        b=Ah4GpdahD/a65ugubgaAKujsQMoQapiMp/7GpMfGAewDP4I/bOW4SBq5Z2yzkEHk4s
         8u8Z4dO8K//NvN9UCBsLnzmVerasgrJ01O7obSl2kSyPe+adVzBPlHL2Jf8S1ejLj4Rh
         ZnVUcVNLWFclLfYp+Qi1wOH4cugwhv4ppQ4zZ7e8vukKXh5s4v4YPoi0L1t5r4Cs5kVO
         GTX1xiBrlHwFlJN2zvvZiZ1Pof/VahgflnR9VBJBMEDxMbx+Pxc3V0M2yyoQcGjJ6n1B
         o2wIDhrgU0YCs7tEI1CnxHS6x8/qG/hsRf+pmY4JvMIu0ujq+uEugtpmjHrKgEeXvHRO
         PjIw==
X-Gm-Message-State: APjAAAUdpXZnVRUoeqIz6EUsyGnKjYJR5kp6157sH+RYX3+I3h6CM53h
        EyiLS+OJT2+bAPT6cZtS/xqZel63b2QVGWgRRDNW4jqSQPlxp1TgyGJ9etP1Radw1VqXB/POydR
        EKuNqJDbmGUKnefA2kcQ7mOiY
X-Received: by 2002:a65:50c5:: with SMTP id s5mr24042156pgp.368.1567409917880;
        Mon, 02 Sep 2019 00:38:37 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzFbzdBFR4NQntUKmudeBLYMKscKF5/o5GXgMqgYXlDtTNRCQbnWl9gRnXPcnsb19V4FGYaQg==
X-Received: by 2002:a65:50c5:: with SMTP id s5mr24042139pgp.368.1567409917482;
        Mon, 02 Sep 2019 00:38:37 -0700 (PDT)
Received: from wlc-trust-99.pek2.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id l3sm12699532pjq.24.2019.09.02.00.38.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Sep 2019 00:38:36 -0700 (PDT)
Subject: Re: [PATCH v2] x86/kdump: Reserve extra memory when SME or SEV is
 active
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Lendacky <Thomas.Lendacky@amd.com>,
        Baoquan He <bhe@redhat.com>, Lianbo Jiang <lijiang@redhat.com>,
        Dave Young <dyoung@redhat.com>, x86@kernel.org,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>
References: <20190826044535.9646-1-kasong@redhat.com>
 <20190830164513.GE30413@zn.tnic>
From:   Kairui Song <kasong@redhat.com>
Message-ID: <e70f1e99-f696-51e2-f50c-148bcda5dfb6@redhat.com>
Date:   Mon, 2 Sep 2019 15:38:22 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190830164513.GE30413@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/31/19 12:45 AM, Borislav Petkov wrote:
> On Mon, Aug 26, 2019 at 12:45:35PM +0800, Kairui Song wrote:
>> Since commit c7753208a94c ("x86, swiotlb: Add memory encryption support"),
>> SWIOTLB will be enabled even if there is less than 4G of memory when SME
>> is active, to support DMA of devices that not support address with the
>> encrypt bit.
>>
>> And commit aba2d9a6385a ("iommu/amd: Do not disable SWIOTLB if SME is
>> active") make the kernel keep SWIOTLB enabled even if there is an IOMMU.
>>
>> Then commit d7b417fa08d1 ("x86/mm: Add DMA support for SEV memory
>> encryption") will always force SWIOTLB to be enabled when SEV is active
>> in all cases.
>>
>> Now, when either SME or SEV is active, SWIOTLB will be force enabled,
>> and this is also true for kdump kernel. As a result kdump kernel will
>> run out of already scarce pre-reserved memory easily.
>>
>> So when SME/SEV is active, reserve extra memory for SWIOTLB to ensure
>> kdump kernel have enough memory, except when "crashkernel=size[KMG],high"
>> is specified or any offset is used. As for the high reservation case, an
>> extra low memory region will always be reserved and that is enough for
>> SWIOTLB. Else if the offset format is used, user should be fully aware
>> of any possible kdump kernel memory requirement and have to organize the
>> memory usage carefully.
>>
>> Signed-off-by: Kairui Song <kasong@redhat.com>
>>
>> ---
>> Update from V1:
>> - Use mem_encrypt_active() instead of "sme_active() || sev_active()"
>> - Don't reserve extra memory when ",high" or "@offset" is used, and
>>    don't print redundant message.
>> - Fix coding style problem
>>
>>   arch/x86/kernel/setup.c | 31 ++++++++++++++++++++++++++++---
>>   1 file changed, 28 insertions(+), 3 deletions(-)
>>
>> diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
>> index bbe35bf879f5..221beb10c55d 100644
>> --- a/arch/x86/kernel/setup.c
>> +++ b/arch/x86/kernel/setup.c
>> @@ -528,7 +528,7 @@ static int __init reserve_crashkernel_low(void)
>>   
>>   static void __init reserve_crashkernel(void)
>>   {
>> -	unsigned long long crash_size, crash_base, total_mem;
>> +	unsigned long long crash_size, crash_base, total_mem, mem_enc_req;
>>   	bool high = false;
>>   	int ret;
>>   
>> @@ -550,6 +550,15 @@ static void __init reserve_crashkernel(void)
>>   		return;
>>   	}
>>   
>> +	/*
>> +	 * When SME/SEV is active, it will always required an extra SWIOTLB
>> +	 * region.
>> +	 */
>> +	if (mem_encrypt_active())
>> +		mem_enc_req = ALIGN(swiotlb_size_or_default(), SZ_1M);
>> +	else
>> +		mem_enc_req = 0;
> 
> Hmm, ugly.

I agree with this, but didn't have a better idea about how toimprove it, so thanks for the suggestions below.

> 
> You set mem_enc_reg here ...
> 
>> +
>>   	/* 0 means: find the address automatically */
>>   	if (!crash_base) {
>>   		/*
>> @@ -563,11 +572,19 @@ static void __init reserve_crashkernel(void)
>>   		if (!high)
>>   			crash_base = memblock_find_in_range(CRASH_ALIGN,
>>   						CRASH_ADDR_LOW_MAX,
>> -						crash_size, CRASH_ALIGN);
>> -		if (!crash_base)
>> +						crash_size + mem_enc_req,
>> +						CRASH_ALIGN);
>> +		/*
>> +		 * For high reservation, an extra low memory for SWIOTLB will
>> +		 * always be reserved later, so no need to reserve extra
>> +		 * memory for memory encryption case here.
>> +		 */
>> +		if (!crash_base) {
>> +			mem_enc_req = 0;
> 
> ... but you clear it here...
> 
>>   			crash_base = memblock_find_in_range(CRASH_ALIGN,
>>   						CRASH_ADDR_HIGH_MAX,
>>   						crash_size, CRASH_ALIGN);
>> +		}
>>   		if (!crash_base) {
>>   			pr_info("crashkernel reservation failed - No suitable area found.\n");
>>   			return;
>> @@ -575,6 +592,7 @@ static void __init reserve_crashkernel(void)
>>   	} else {
>>   		unsigned long long start;
>>   
>> +		mem_enc_req = 0;
> 
> ... and here...
> 
>>   		start = memblock_find_in_range(crash_base,
>>   					       crash_base + crash_size,
>>   					       crash_size, 1 << 20);
>> @@ -583,6 +601,13 @@ static void __init reserve_crashkernel(void)
>>   			return;
>>   		}
>>   	}
>> +
>> +	if (mem_enc_req) {
>> +		pr_info("Memory encryption is active, crashkernel needs %ldMB extra memory\n",
>> +			(unsigned long)(mem_enc_req >> 20));
>> +		crash_size += mem_enc_req;
>> +	}
> 
> ... and then you report only when it is still set.
> 
> How about you carve out that if (!crash_base) { ... } else { } piece
> into a separate function without any further changes - only code
> movement? That is your patch 1.
> 
> Your patch 2 is then adding the mem_encrypt_active() check in the if
> (!crash_base && !high) case, i.e., only where you need it and issuing
> the pr_info from there instead of stretching that logic throughout the
> whole function and twisting my brain unnecessarily?
> 
> Thx.
> 

Will it be good if the final code looks like this?

diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index 48115cf11e0f..754b25d6e785 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -526,6 +526,69 @@ static int __init reserve_crashkernel_low(void)
  	return 0;
  }
  
+static int __init crashkernel_find_region(
+		unsigned long long *base,
+		unsigned long long *size,
+		bool high)
+{
+	unsigned long long start, mem_enc_req = 0;
+
+	/*
+	 * *base == 0 means: find the address automatically, else just
+	 * verify the region is useable
+	 */
+	if (*base) {
+		start = memblock_find_in_range(*base, *base + *size,
+					       *size, 1 << 20);
+		if (start != *base) {
+			pr_info("crashkernel reservation failed - memory is in use.\n");
+			return -EBUSY;
+		}
+		return 0;
+	}
+
+	/*
+	 * Set CRASH_ADDR_LOW_MAX upper bound for crash memory,
+	 * crashkernel=x,high reserves memory over 4G, also allocates
+	 * 256M extra low memory for DMA buffers and swiotlb.
+	 * But the extra memory is not required for all machines.
+	 * So try low memory first and fall back to high memory
+	 * unless "crashkernel=size[KMG],high" is specified.
+	 */
+	if (!high) {
+		/*
+		 * When SME/SEV is active and not using high reserve,
+		 * it will always required an extra SWIOTLB region.
+		 */
+		if (mem_encrypt_active())
+			mem_enc_req = ALIGN(swiotlb_size_or_default(), SZ_1M);
+
+		*base = memblock_find_in_range(CRASH_ALIGN,
+					       CRASH_ADDR_LOW_MAX,
+					       *size + mem_enc_req,
+					       CRASH_ALIGN);
+		if (*base) {
+			if (mem_enc_req) {
+				pr_info("Memory encryption is active, crashkernel needs %ldMB extra memory\n",
+					(unsigned long)(mem_enc_req >> 20));
+				*size += mem_enc_req;
+			}
+			return 0;
+		}
+	}
+
+	/* Try high reserve */
+	*base = memblock_find_in_range(CRASH_ALIGN,
+				       CRASH_ADDR_HIGH_MAX,
+				       *size, CRASH_ALIGN);
+	if (!*base) {
+		pr_info("crashkernel reservation failed - No suitable area found.\n");
+		return -ENOMEM;
+	}
+
+	return 0;
+}
+
  static void __init reserve_crashkernel(void)
  {
  	unsigned long long crash_size, crash_base, total_mem;
@@ -550,39 +613,10 @@ static void __init reserve_crashkernel(void)
  		return;
  	}
  
-	/* 0 means: find the address automatically */
-	if (!crash_base) {
-		/*
-		 * Set CRASH_ADDR_LOW_MAX upper bound for crash memory,
-		 * crashkernel=x,high reserves memory over 4G, also allocates
-		 * 256M extra low memory for DMA buffers and swiotlb.
-		 * But the extra memory is not required for all machines.
-		 * So try low memory first and fall back to high memory
-		 * unless "crashkernel=size[KMG],high" is specified.
-		 */
-		if (!high)
-			crash_base = memblock_find_in_range(CRASH_ALIGN,
-						CRASH_ADDR_LOW_MAX,
-						crash_size, CRASH_ALIGN);
-		if (!crash_base)
-			crash_base = memblock_find_in_range(CRASH_ALIGN,
-						CRASH_ADDR_HIGH_MAX,
-						crash_size, CRASH_ALIGN);
-		if (!crash_base) {
-			pr_info("crashkernel reservation failed - No suitable area found.\n");
-			return;
-		}
-	} else {
-		unsigned long long start;
+	ret = crashkernel_find_region(&crash_base, &crash_size, high);
+	if (ret)
+		return;
  
-		start = memblock_find_in_range(crash_base,
-					       crash_base + crash_size,
-					       crash_size, 1 << 20);
-		if (start != crash_base) {
-			pr_info("crashkernel reservation failed - memory is in use.\n");
-			return;
-		}
-	}
  	ret = memblock_reserve(crash_base, crash_size);
  	if (ret) {
  		pr_err("%s: Error reserving crashkernel memblock.\n", __func__);

---

If you are OK with this, I will split it into two patch and send V3.
