Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FFF5C282DD
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 17:35:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5641D206F0
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 17:35:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GlavMRnk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729772AbgAHRfq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 12:35:46 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:42797 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727328AbgAHRfq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 12:35:46 -0500
Received: by mail-pf1-f196.google.com with SMTP id 4so1961884pfz.9
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jan 2020 09:35:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=rmW2SzOQEkvk2YaV0aUVml7cYubYeEYDGdw5v7jx240=;
        b=GlavMRnkhXH1aB2TH7QtnGDlMVa6vrEtZJwggwWLFxVrwuOBizZz+pZljt4JBQyKdc
         KA1GOVRt6HNKDDO0AE2sCJHpRDTnPglDsVR5yd3hSMsQt2LwCSDawd5SK4IEYteUVXcl
         jPea4QR/8/1KGtjGNj1ve6lEy3ijcb0ogWGXorloja/VKpsrjw4aUgZK/6ntmhyPDQpF
         Z3qrAK0faGmGHcUxSWLkVAeOl5QrQjhSvyupHYsFXg6K9++PEcm5gSHxNDvtQST5wTFD
         BxD73r+q+0yqWodVVsYeJ2tkGvRIvDl1f6ll/gL+IDiiWjrld9tjorLCr5qXhuCUrlJj
         kesA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rmW2SzOQEkvk2YaV0aUVml7cYubYeEYDGdw5v7jx240=;
        b=ZLYXqJ+chaKgSP4OWU3Ek3dJGOg69XOtvw/uvQD0odyWbAAAEp1Srd899zW+/KZM+n
         qS5v2zvHmJBEhZINP8ymTrLyDkt3AEp80j5+8gn3K5tl1lq67t7rEBNK9c4T0V+De2HG
         AoBZ3z4ShsPdDmu9frkM2zq3hSBldehL0XIe1pGQTXGGPFIv9OXF2flXsSdI1uWfLIF9
         GPliwQpqDs4ztTcbBXK/9yJWT3qhRsQJGMCCeYOkArw+mbj6Q5+DalTBXOwTf0o/LT0v
         /C0uO5IGlPq/ZMPcw7Qs1pMQ9rYtmL+DoYhQ8UUKnbdGIY0NtBdpFoyNbNwzHGGLM0Zz
         buoA==
X-Gm-Message-State: APjAAAUmTXACpEnOpsGqzdSuroy4lWkxuhnM2Gd5wxuweWvNZZtZic3X
        q/W87zrWUaJ1R8QSjnN4PUwc6hF3DhfDp0nb
X-Google-Smtp-Source: APXvYqziV3O3a/qHFr9ZqFBNqv4rjrqR+guZ967CrjBY0tju4nXXiEOviJPP+dyc8+/P4SwholzkOw==
X-Received: by 2002:a63:1c64:: with SMTP id c36mr5785756pgm.302.1578504945032;
        Wed, 08 Jan 2020 09:35:45 -0800 (PST)
Received: from gnomeregan01.cam.corp.google.com ([2620:15c:6:14:50b7:ffca:29c4:6488])
        by smtp.googlemail.com with ESMTPSA id b12sm4257418pfi.157.2020.01.08.09.35.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jan 2020 09:35:44 -0800 (PST)
Subject: Re: [PATCH v2 2/2] iommu/vt-d: skip invalid RMRR entries
To:     Lu Baolu <baolu.lu@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Joerg Roedel <joro@8bytes.org>,
        Yian Chen <yian.chen@intel.com>,
        Sohil Mehta <sohil.mehta@intel.com>
Cc:     iommu@lists.linux-foundation.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
References: <20200107191610.178185-1-brho@google.com>
 <20200107191610.178185-3-brho@google.com>
 <bc129b51-73d3-3ed0-93a5-07df6566d535@linux.intel.com>
From:   Barret Rhoden <brho@google.com>
Message-ID: <c0f992fd-aaad-9250-2103-fa290db46387@google.com>
Date:   Wed, 8 Jan 2020 12:35:41 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <bc129b51-73d3-3ed0-93a5-07df6566d535@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/7/20 8:27 PM, Lu Baolu wrote:
>> diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
>> index a8bb458845bc..32c3c6338a3d 100644
>> --- a/drivers/iommu/intel-iommu.c
>> +++ b/drivers/iommu/intel-iommu.c
>> @@ -4315,13 +4315,25 @@ static void __init init_iommu_pm_ops(void)
>>   static inline void init_iommu_pm_ops(void) {}
>>   #endif    /* CONFIG_PM */
>> +static int rmrr_validity_check(struct acpi_dmar_reserved_memory *rmrr)
>> +{
>> +    if ((rmrr->base_address & PAGE_MASK) ||
>> +        (rmrr->end_address <= rmrr->base_address) ||
>> +        ((rmrr->end_address - rmrr->base_address + 1) & PAGE_MASK)) {
>> +        pr_err(FW_BUG "Broken RMRR base: %#018Lx end: %#018Lx\n",
>> +               rmrr->base_address, rmrr->end_address);
> 
> Since you will WARN_TAINT below, do you still want an error message
> here?

I'm fine either way.

I put it in since arch_rmrr_sanity_check() also has a pr_err():

	pr_err(FW_BUG "No firmware reserved region can cover this RMRR
                [%#018Lx-%#018Lx], contact BIOS vendor for fixes\n",
                start, end - 1);

Thanks,

Barret

