Return-Path: <SRS0=7jSw=YF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD5CEC10F14
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Oct 2019 09:26:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A9FA206A1
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Oct 2019 09:26:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729150AbfJLJ0q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 12 Oct 2019 05:26:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37490 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728446AbfJLJYp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Oct 2019 05:24:45 -0400
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1CD61796EE
        for <linux-kernel@vger.kernel.org>; Sat, 12 Oct 2019 09:24:45 +0000 (UTC)
Received: by mail-pf1-f199.google.com with SMTP id u21so6493188pfm.22
        for <linux-kernel@vger.kernel.org>; Sat, 12 Oct 2019 02:24:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hWcbBHf19jxlqiVNxkcFZpfyhMvDvY5g4o+W8hzWUhI=;
        b=WZ2MuEhgS5MnXND1d5rL0h8lECbMjmVhKTBFOCTOoV+v4b1G34kf1wyiigowMzXcep
         E3+fqKR2ULQeYwODkS2pFjcGqNYyoqcea//v1kU4e7lmPO6x8jV3twnNmD0iAtOD7KzO
         HM3g7r6z16qz199AKdx9Dd3TIrJfDmy8j5BXIIMHo/mvU8aH2Kjn0colo5SoAtA4LGFK
         gQ4ELeF4lldVgXTq4eCyWfysF2NDPa0ROvC91slGU621xOl5nyEiOCCbm67bojlLR4FV
         6Ht96vc2hGCgVv8yPJnpgcdco872bVhLqJdZfGFP4a4WfsNuUDEcjUysZSs+JbcUoBbo
         6/0A==
X-Gm-Message-State: APjAAAW+vtsA6suq+gIa0DsnzqV6Bfq+k5FgQUZdXvL/7ZAxZ81Xnu9q
        GkyQIxmp8s15exJQiNTd8ywg5R4T5AKNniVSlx4HspivJZv2/v3Ccy9hnEOEK2pv70gfrRuHcLo
        lWIPzOSjEEroFsTwAWShZx81N
X-Received: by 2002:a63:5ec6:: with SMTP id s189mr21233248pgb.185.1570872284377;
        Sat, 12 Oct 2019 02:24:44 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzoe8OqVqux7YSZOPy5RZvCH1uxYywzcapN4VKk60TF7wNaf/v/YjKnFPqIPYqjrYYH6n3yRw==
X-Received: by 2002:a63:5ec6:: with SMTP id s189mr21233216pgb.185.1570872283766;
        Sat, 12 Oct 2019 02:24:43 -0700 (PDT)
Received: from localhost.localdomain ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id s97sm15944686pjc.4.2019.10.12.02.24.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 12 Oct 2019 02:24:43 -0700 (PDT)
Subject: Re: [PATCH v3 2/2] x86/kdump: Reserve extra memory when SME or SEV is
 active
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     Dave Young <dyoung@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Thomas Lendacky <Thomas.Lendacky@amd.com>,
        Baoquan He <bhe@redhat.com>, Lianbo Jiang <lijiang@redhat.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>
References: <20190910151341.14986-1-kasong@redhat.com>
 <20190910151341.14986-3-kasong@redhat.com>
 <20190911055618.GA104115@gmail.com>
 <CACPcB9eZUZ1fCsc1GZs9MJnoqLK9Ld5KEx0_emx8J44Mjcy3WA@mail.gmail.com>
 <20190927054208.GA13426@dhcp-128-65.nay.redhat.com>
From:   Kairui Song <kasong@redhat.com>
Message-ID: <3e1f65de-4539-736e-a7b4-3c726a001f4b@redhat.com>
Date:   Sat, 12 Oct 2019 17:24:31 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20190927054208.GA13426@dhcp-128-65.nay.redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/27/19 1:42 PM, Dave Young wrote:
> On 09/25/19 at 06:36pm, Kairui Song wrote:
>> On Wed, Sep 11, 2019 at 1:56 PM Ingo Molnar <mingo@kernel.org> wrote:
>>> * Kairui Song <kasong@redhat.com> wrote:
>>>
>>>> Since commit c7753208a94c ("x86, swiotlb: Add memory encryption support"),
>>>> SWIOTLB will be enabled even if there is less than 4G of memory when SME
>>>> is active, to support DMA of devices that not support address with the
>>>> encrypt bit.
>>>>
>>>> And commit aba2d9a6385a ("iommu/amd: Do not disable SWIOTLB if SME is
>>>> active") make the kernel keep SWIOTLB enabled even if there is an IOMMU.
>>>>
>>>> Then commit d7b417fa08d1 ("x86/mm: Add DMA support for SEV memory
>>>> encryption") will always force SWIOTLB to be enabled when SEV is active
>>>> in all cases.
>>>>
>>>> Now, when either SME or SEV is active, SWIOTLB will be force enabled,
>>>> and this is also true for kdump kernel. As a result kdump kernel will
>>>> run out of already scarce pre-reserved memory easily.
>>>>
>>>> So when SME/SEV is active, reserve extra memory for SWIOTLB to ensure
>>>> kdump kernel have enough memory, except when "crashkernel=size[KMG],high"
>>>> is specified or any offset is used. As for the high reservation case, an
>>>> extra low memory region will always be reserved and that is enough for
>>>> SWIOTLB. Else if the offset format is used, user should be fully aware
>>>> of any possible kdump kernel memory requirement and have to organize the
>>>> memory usage carefully.
>>>>
>>>> Signed-off-by: Kairui Song <kasong@redhat.com>
>>>> ---
>>>>   arch/x86/kernel/setup.c | 20 +++++++++++++++++---
>>>>   1 file changed, 17 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
>>>> index 71f20bb18cb0..ee6a2f1e2226 100644
>>>> --- a/arch/x86/kernel/setup.c
>>>> +++ b/arch/x86/kernel/setup.c
>>>> @@ -530,7 +530,7 @@ static int __init crashkernel_find_region(unsigned long long *crash_base,
>>>>                                          unsigned long long *crash_size,
>>>>                                          bool high)
>>>>   {
>>>> -     unsigned long long base, size;
>>>> +     unsigned long long base, size, mem_enc_req = 0;
>>>>
>>>>        base = *crash_base;
>>>>        size = *crash_size;
>>>> @@ -561,11 +561,25 @@ static int __init crashkernel_find_region(unsigned long long *crash_base,
>>>>        if (high)
>>>>                goto high_reserve;
>>>>
>>>> +     /*
>>>> +      * When SME/SEV is active and not using high reserve,
>>>> +      * it will always required an extra SWIOTLB region.
>>>> +      */
>>>> +     if (mem_encrypt_active())
>>>> +             mem_enc_req = ALIGN(swiotlb_size_or_default(), SZ_1M);
>>>> +
>>>>        base = memblock_find_in_range(CRASH_ALIGN,
>>>> -                                   CRASH_ADDR_LOW_MAX, size,
>>>> +                                   CRASH_ADDR_LOW_MAX,
>>>> +                                   size + mem_enc_req,
>>>>                                      CRASH_ALIGN);
>>>
>>
>> Hi Ingo,
>>
>> I re-read my previous reply, it's long and tedious, let me try to make
>> a more effective reply:
>>
>>> What sizes are we talking about here?
>>
>> The size here is how much memory will be reserved for kdump kernel, to
>> ensure kdump kernel and userspace can run without OOM.
>>
>>>
>>> - What is the possible size range of swiotlb_size_or_default()
>>
>> swiotlb_size_or_default() returns the swiotlb size, it's specified by
>> user using swiotlb=<size>, or default size (64MB)
>>
>>>
>>> - What is the size of CRASH_ADDR_LOW_MAX (the old limit)?
>>
>> It's 4G.
>>
>>>
>>> - Why do we replace one fixed limit with another fixed limit instead of
>>>    accurately sizing the area, with each required feature adding its own
>>>    requirement to the reservation size?
>>
>> It's quite hard to "accurately sizing the area".
>>
>> No way to tell the exact amount of memory kdump needs, we can only estimate.
>> Kdump kernel use different cmdline, drivers and components will have
>> special handling for kdump, and userspace is totally different.
> 
> Agreed about your above, but specific this the problem in this patch
> There should be other ways.
> 
> First thought about doing generic handling in swiotlb part, and do
> something like kdump_memory_reserve(size) Ingo suggested,  but according
> to you swiotlb init is late, so it can not increase the size, OTOH if
> reserve another region for kdump in swiotlb will cause other issues.
> 
> So let's think about other improvement, for example to see if you can
> call kdump_memory_reserve(size) in AMD SME init path, for example in
> mem_encrypt_init(), is it before crashkernel reservation?
> 
> If doable it will be at least cleaner than the code in this patch.
> 
> Thanks
> Dave
> 

How about something simple as following code? The logic and new function is as simple as
possible, just always reserve extra low memory when SME/SEV is active, ignore the high/low
reservation case. It will waste some memory with SME and high reservation though.

Was hesitating a lot about this series, one thing I'm thinking is that what is the point
of "crashkernel=" argument, if the crashkernel value could be adjusted according, the value
specified will seems more meanless or confusing...

And currently there isn't anything like crashkernel=auto or anything similiar to let kernel
calculate the value automatically, maybe the admin should be aware of the value or be informed
about the suitable crashkernel value after all?

diff --git a/arch/x86/include/asm/setup.h b/arch/x86/include/asm/setup.h
index ed8ec011a9fd..7263a237f689 100644
--- a/arch/x86/include/asm/setup.h
+++ b/arch/x86/include/asm/setup.h
@@ -44,6 +44,7 @@ void early_platform_quirks(void);
  
  extern unsigned long saved_video_mode;
  
+extern void kdump_need_extra_low_memory(unsigned long size);
  extern void reserve_standard_io_resources(void);
  extern void i386_reserve_resources(void);
  extern unsigned long __startup_64(unsigned long physaddr, struct boot_params *bp);
diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index 77ea96b794bd..e5888fb8e4bc 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -473,6 +473,13 @@ static void __init memblock_x86_reserve_range_setup_data(void)
  # define CRASH_ADDR_HIGH_MAX	SZ_64T
  #endif
  
+static __initdata unsigned long long crash_low_extra;
+
+void __init kdump_need_extra_low_memory(unsigned long size)
+{
+	crash_low_extra += size;
+}
+
  static int __init reserve_crashkernel_low(void)
  {
  #ifdef CONFIG_X86_64
@@ -501,6 +508,7 @@ static int __init reserve_crashkernel_low(void)
  			return 0;
  	}
  
+	low_size += crash_low_extra;
  	low_base = memblock_find_in_range(0, 1ULL << 32, low_size, CRASH_ALIGN);
  	if (!low_base) {
  		pr_err("Cannot reserve %ldMB crashkernel low memory, please try smaller size.\n",
@@ -563,8 +571,17 @@ static void __init reserve_crashkernel(void)
  		if (!high)
  			crash_base = memblock_find_in_range(CRASH_ALIGN,
  						CRASH_ADDR_LOW_MAX,
-						crash_size, CRASH_ALIGN);
-		if (!crash_base)
+						crash_size + crash_low_extra,
+						CRASH_ALIGN);
+		/*
+		 * If reserving the crashkernel memory in low region, then also
+		 * include the extra low memory requirement declared by other
+		 * components. If falled back to high reservation the dedicated
+		 * low crash memory will take care of that.
+		 */
+		if (crash_base)
+			crash_size += crash_low_extra;
+		else
  			crash_base = memblock_find_in_range(CRASH_ALIGN,
  						CRASH_ADDR_HIGH_MAX,
  						crash_size, CRASH_ALIGN);
diff --git a/arch/x86/mm/mem_encrypt.c b/arch/x86/mm/mem_encrypt.c
index 9268c12458c8..b4556d2dcb8e 100644
--- a/arch/x86/mm/mem_encrypt.c
+++ b/arch/x86/mm/mem_encrypt.c
@@ -415,6 +415,8 @@ void __init mem_encrypt_init(void)
  	if (sev_active())
  		static_branch_enable(&sev_enable_key);
  
+	kdump_need_extra_low_memory(swiotlb_size_or_default());
+
  	pr_info("AMD %s active\n",
  		sev_active() ? "Secure Encrypted Virtualization (SEV)"
  			     : "Secure Memory Encryption (SME)");
