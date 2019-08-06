Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C52D9C32751
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 22:47:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 982C6216F4
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 22:47:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="V5F2ocdt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726864AbfHFWrt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 18:47:49 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38660 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726069AbfHFWrt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 18:47:49 -0400
Received: by mail-wr1-f65.google.com with SMTP id g17so89413029wrr.5
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2019 15:47:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=E8l+QFoWuIzZtkfAWu72ZGTXYhrklDytAgz3N4StbaY=;
        b=V5F2ocdtmdaN8wQ++AvKu/Ls+Qa9xYely0fr7vZUfDl1e4SNQMjmfIuKhKN2LPLSjR
         iSVc8kKdORj4on+/JoOq9KmTmaHU2ZR1kwTlmTj3P2KNUI+It8gfmMkW3PZ1ORgnPSxn
         YWvWd0W3NuX3fnVrlvgkTX6ZYFaDMSGkFg7eb3VxWvD3HNZQ5CaYDJPbIJV0KGOU2qBX
         WNxFfsMyEAiwfG4yE2BrBwNfkw6/F2EOKc6kmmV0k3wgDkGJuGu1Npb42ecOzSEgRVHv
         zXm1aoTf7QbNEhDo4Qs/outpOWLYqHh+r4q2cV7lvSeh+GrShsUN8Id53dfbAgAmjSjJ
         vuzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=E8l+QFoWuIzZtkfAWu72ZGTXYhrklDytAgz3N4StbaY=;
        b=L7s9tcikjwlqY5hnlSB/XINkQxD/frQvG5dWc0kltIN6++hBq3y+BHeBrTnRIIky3s
         MAgpWSIsvGd2+U8AM/AL7Y9UdJntgrfy6RqTjlNFpe9IlahJjamy8kfucTFZMhxqJaMs
         RgSBNVBTyyCcZ607C4rr+b8U7KyqVEmwic8EDg2eXlHLXuxp2gbAQ/AvVbDYSk3ijS7t
         i8EykbJ6vS+yuKYrZx2gPVeC4sWluZcTFN+z2wPrjmgVGhY3ekkpR35Jc8lMQ6FC5Icd
         RGO7siNDBZgLalsgXO6Bo/tW7RJ4X0a/XLgMVHpf/sG/u8YttCyON/dk5X1LFER90gQQ
         7aig==
X-Gm-Message-State: APjAAAXxieiq8h5L3cieWOliyRnfJMLIH0JIcsxvDalyK3dikHs7YN/p
        B7Q/FYuFMkauqVYEVPGeOOzY5T5vw0SpW8y2VaGBXwU0AkL9eR1NVIQdQsoIoqq3JDwkhF74QkU
        u/B0sQ++MXxjuRXlk/0MTFpgF3pmGADgPEizM+HxOe0NRQAcMFtnIwyiQuW8ygWYl0w9sGzbwBU
        aspuDM/3mLv9MUfgdeLWRoc9uchRhYDRs5sqxZatc=
X-Google-Smtp-Source: APXvYqxrez9lq0Wa0oDM52d1vpAuR1KM4DLPcp6tbNPmEJRDcwXpvbgvqmpLnHj4dLlbtDU63cIKLw==
X-Received: by 2002:a5d:628d:: with SMTP id k13mr6583026wru.69.1565131666383;
        Tue, 06 Aug 2019 15:47:46 -0700 (PDT)
Received: from [10.83.36.153] ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id s3sm93828850wmh.27.2019.08.06.15.47.45
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Aug 2019 15:47:45 -0700 (PDT)
Subject: Re: [PATCH 4.19 17/32] iommu/vt-d: Dont queue_iova() if there is no
 flush queue
To:     Pavel Machek <pavel@ucw.cz>
Cc:     linux-kernel@vger.kernel.org,
        David Woodhouse <dwmw2@infradead.org>,
        Joerg Roedel <joro@8bytes.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        iommu@lists.linux-foundation.org, Joerg Roedel <jroedel@suse.de>
References: <20190802092101.913646560@linuxfoundation.org>
 <20190802092107.177554199@linuxfoundation.org> <20190803213453.GA22416@amd>
From:   Dmitry Safonov <dima@arista.com>
Message-ID: <dc639510-5d88-5b05-a973-5f4b7c720f76@arista.com>
Date:   Tue, 6 Aug 2019 23:47:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190803213453.GA22416@amd>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CLOUD-SEC-AV-Info: arista,google_mail,monitor
X-CLOUD-SEC-AV-Sent: true
X-Gm-Spam: 0
X-Gm-Phishy: 0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pavel,

On 8/3/19 10:34 PM, Pavel Machek wrote:
> Hi!
> 
>> --- a/drivers/iommu/intel-iommu.c
>> +++ b/drivers/iommu/intel-iommu.c
>> @@ -3721,7 +3721,7 @@ static void intel_unmap(struct device *d
>>  
>>  	freelist = domain_unmap(domain, start_pfn, last_pfn);
>>  
>> -	if (intel_iommu_strict) {
>> +	if (intel_iommu_strict || !has_iova_flush_queue(&domain->iovad)) {
>>  		iommu_flush_iotlb_psi(iommu, domain, start_pfn,
>>  				      nrpages, !freelist, 0);
>>  		/* free iova */
>> --- a/drivers/iommu/iova.c
>> +++ b/drivers/iommu/iova.c
>> @@ -65,9 +65,14 @@ init_iova_domain(struct iova_domain *iov
>>  }
>>  EXPORT_SYMBOL_GPL(init_iova_domain);
>>  
>> +bool has_iova_flush_queue(struct iova_domain *iovad)
>> +{
>> +	return !!iovad->fq;
> 
> Should this be READ_ONCE()?

Why? Compiler can't anyhow assume that it's always true/false and there
is a clear data dependency between this and:
:	queue_iova(&domain->iovad, iova_pfn, nrpages,
:			   (unsigned long)freelist);

> 
>> @@ -100,13 +106,17 @@ int init_iova_flush_queue(struct iova_do
>>  	for_each_possible_cpu(cpu) {
>>  		struct iova_fq *fq;
>>  
>> -		fq = per_cpu_ptr(iovad->fq, cpu);
>> +		fq = per_cpu_ptr(queue, cpu);
>>  		fq->head = 0;
>>  		fq->tail = 0;
>>  
>>  		spin_lock_init(&fq->lock);
>>  	}
>>  
>> +	smp_wmb();
>> +
>> +	iovad->fq = queue;
>> +
> 
> Could we have a comment why the barrier is needed,

I'm up for the comment if you feel like it - in my POV it's quite
obvious that we want finish initializing the queue's internals before
assigning the queue. I didn't put the comment exactly because I felt
like it would state something evident [in my POV].

> and perhaps there
> should be oposing smp_rmb() somewhere? Does this need to be
> WRITE_ONCE() as it is racing against reader?

I feel confused. I might have forgotten everything about barriers, but
again if I'm not mistaken, one doesn't need a barrier in:
: if (A->a != NULL)
:     use(A); /* dereferences A->a */
: else
:     /* don't use `a' */

Thanks,
          Dmitry
