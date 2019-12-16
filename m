Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 626FEC43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 19:35:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3620C206E0
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 19:35:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="V6QZCNSy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727422AbfLPTfa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 14:35:30 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:44933 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726664AbfLPTf3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 14:35:29 -0500
Received: by mail-pf1-f196.google.com with SMTP id d199so6143795pfd.11
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2019 11:35:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=CkQ65CjNVt4hNQc5fIVwGwBcjZEAsNi6X9HREDxycBo=;
        b=V6QZCNSyM+juWCR4X2eqZmLVQ6jevW5eE/xWhjKgwrHxE+dfA9pKL4I8NMlNgy8p1U
         dLJkUfasvP8rJALOAqxvawWRnHUgtdAR4kWzSYBfS2xCqZna65xnOZY35ujuEJ+sQXWw
         bg3lw9JNoQUblP3TnXxrvCQDeRLKLjOvlCTufd0EXdjEFEwlTSuGZkDjmM6HazAhx6B/
         zDw6Di5WncWNx39QBbmL8QOO/n928cQoDEFb/w2/7uXTKh71V/bfcDNxHy5rFr/1VLvC
         2g4aPB0NuqJYTU/iM9pca0JsIPN/4Bs3FX+0QchEGJTiFZs7VsERnPjU/zJzw/80InW5
         uBiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CkQ65CjNVt4hNQc5fIVwGwBcjZEAsNi6X9HREDxycBo=;
        b=jv3BgaNzv20iCGw9jGbueA8Sm241vzxJzyCptEusjLmabu8lhrR/8YYytecE2IAm5y
         8qU9zK+ha5FjMNJsxQwo3v12Jz94Q7qdFlOWnioBLM+e6El1KNnLoBuFsihPKYBDwimE
         TtXlyNhSIHIUgF+u0LuMNqgJ21xzbi3zRxODxodchy7Zc1FfBSoMe7WZaSfURTFDFQEs
         SkJtyu1I2+7oqjkWFl5Fom0hkZxRA+FFDV5nVS7iNx4V7QZHYKfQuTtCd/Www4FMOp/I
         wKsvNvwvgpV/Zdp/Drcl6X0WXY3AviQ0QPCBDwEiDnERiwI2CdYxTR3oidyGlKaEfGfq
         FUMQ==
X-Gm-Message-State: APjAAAWeTk+KC2a9jtPq2nW213JpRQovRN9VaIQ2iEYcJHs6uhgek3Gk
        5HaOmxUXVC/dl7Yh7GjiP3YABg==
X-Google-Smtp-Source: APXvYqzgOZ1uRhn9JxOPVQ4nRzUnloZT6mVaYm126ILaYf0ERKQKahlEFl5v5phKXCzBWat2/J5yrA==
X-Received: by 2002:aa7:9988:: with SMTP id k8mr17217363pfh.200.1576524928619;
        Mon, 16 Dec 2019 11:35:28 -0800 (PST)
Received: from gnomeregan.cam.corp.google.com ([2620:15c:6:14:ad22:1cbb:d8fa:7d55])
        by smtp.googlemail.com with ESMTPSA id q9sm23976818pgc.5.2019.12.16.11.35.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Dec 2019 11:35:28 -0800 (PST)
Subject: Re: [PATCH 1/3] iommu/vt-d: skip RMRR entries that fail the sanity
 check
To:     "Chen, Yian" <yian.chen@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Joerg Roedel <joro@8bytes.org>,
        Sohil Mehta <sohil.mehta@intel.com>
Cc:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        x86@kernel.org
References: <20191211194606.87940-1-brho@google.com>
 <20191211194606.87940-2-brho@google.com>
 <99a294a0-444e-81f9-19a2-216aef03f356@intel.com>
From:   Barret Rhoden <brho@google.com>
Message-ID: <93820c21-8a37-d8f0-dacb-29cee694a91d@google.com>
Date:   Mon, 16 Dec 2019 14:35:26 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <99a294a0-444e-81f9-19a2-216aef03f356@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/16/19 2:07 PM, Chen, Yian wrote:
> 
> 
> On 12/11/2019 11:46 AM, Barret Rhoden wrote:
>> RMRR entries describe memory regions that are DMA targets for devices
>> outside the kernel's control.
>>
>> RMRR entries that fail the sanity check are pointing to regions of
>> memory that the firmware did not tell the kernel are reserved or
>> otherwise should not be used.
>>
>> Instead of aborting DMAR processing, this commit skips these RMRR
>> entries.  They will not be mapped into the IOMMU, but the IOMMU can
>> still be utilized.  If anything, when the IOMMU is on, those devices
>> will not be able to clobber RAM that the kernel has allocated from those
>> regions.
>>
>> Signed-off-by: Barret Rhoden <brho@google.com>
>> ---
>>   drivers/iommu/intel-iommu.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
>> index f168cd8ee570..f7e09244c9e4 100644
>> --- a/drivers/iommu/intel-iommu.c
>> +++ b/drivers/iommu/intel-iommu.c
>> @@ -4316,7 +4316,7 @@ int __init dmar_parse_one_rmrr(struct 
>> acpi_dmar_header *header, void *arg)
>>       rmrr = (struct acpi_dmar_reserved_memory *)header;
>>       ret = arch_rmrr_sanity_check(rmrr);
>>       if (ret)
>> -        return ret;
>> +        return 0;
>>       rmrru = kzalloc(sizeof(*rmrru), GFP_KERNEL);
>>       if (!rmrru)
> Parsing rmrr function should report the error to caller. The behavior to 
> response the error can be
> chose  by the caller in the calling stack, for example, 
> dmar_walk_remapping_entries().
> A concern is that ignoring a detected firmware bug might have a 
> potential side impact though
> it seemed safe for your case.

That's a little difficult given the current code.  Once we are in
dmar_walk_remapping_entries(), the specific function (parse_one_rmrr) is 
called via callback:

	ret = cb->cb[iter->type](iter, cb->arg[iter->type]);
	if (ret)
		return ret;

If there's an error of any sort, it aborts the walk.  Handling the 
specific errors here is difficult, since we don't know what the errors 
mean to the specific callback.  Is there some errno we can use that 
means "there was a problem, but it's not so bad that you have to abort, 
but I figured you ought to know"?  Not that I think that's a good idea.

The knowledge of whether or not a specific error is worth aborting all 
DMAR functionality is best known inside the specific callback.  The only 
handling to do is print a warning and either skip it or abort.

I think skipping the entry for a bad RMRR is better than aborting 
completely, though I understand if people don't like that.  It's 
debatable.  By aborting, we lose the ability to use the IOMMU at all, 
but we are still in a situation where the devices using the RMRR regions 
might be clobbering kernel memory, right?  Using the IOMMU (with no 
mappings for the bad RMRRs) would stop those devices from clobbering memory.

Regardless, I have two other patches in this series that could resolve 
the problem for me and probably other people.  I'd just like at least 
one of the three patches to get merged so that my machine boots when the 
original commit f036c7fa0ab6 ("iommu/vt-d: Check VT-d RMRR region in 
BIOS is reported as reserved") gets released.

Thanks,

Barret

