Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02978C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 20:25:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCA6F21871
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 20:25:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="FBezPb+P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726511AbfCOUZN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 16:25:13 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:45450 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726292AbfCOUZN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 16:25:13 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x2FKOjGj040565;
        Fri, 15 Mar 2019 15:24:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1552681485;
        bh=wABOveJnWUn+P+j/gJAh/x9s3BNdmYToGkKoqGqody0=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=FBezPb+PgE5XufIuf6h4WCPH1unzj743zXaKGUQsZSoYr7jF8AnDLXliG5R99xt9i
         zHWImE4xdhVZtdBLLAAzJz/Fsfm1ufVpdGB6EKGOOR+y6cSc6ZH6YpVaVohK17SA2W
         IR4xZoZ5wmABeSU62wJtFGHGvNeQlffF6dL34FS0=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x2FKOjCs109470
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 15 Mar 2019 15:24:45 -0500
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Fri, 15
 Mar 2019 15:24:44 -0500
Received: from dflp33.itg.ti.com (10.64.6.16) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5 via Frontend Transport;
 Fri, 15 Mar 2019 15:24:44 -0500
Received: from [128.247.58.147] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id x2FKOicJ030323;
        Fri, 15 Mar 2019 15:24:44 -0500
Subject: Re: [RFC][PATCH 1/5 v2] dma-buf: Add dma-buf heaps framework
To:     Christoph Hellwig <hch@infradead.org>,
        John Stultz <john.stultz@linaro.org>
CC:     lkml <linux-kernel@vger.kernel.org>,
        Laura Abbott <labbott@redhat.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Liam Mark <lmark@codeaurora.org>,
        Brian Starkey <Brian.Starkey@arm.com>,
        Chenbo Feng <fengc@google.com>,
        Alistair Strachan <astrachan@google.com>,
        <dri-devel@lists.freedesktop.org>
References: <1551819273-640-1-git-send-email-john.stultz@linaro.org>
 <1551819273-640-2-git-send-email-john.stultz@linaro.org>
 <20190315085446.GA4470@infradead.org>
From:   "Andrew F. Davis" <afd@ti.com>
Message-ID: <525c65f4-7d73-bc77-5086-4db70e6e54f2@ti.com>
Date:   Fri, 15 Mar 2019 15:24:44 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190315085446.GA4470@infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/15/19 3:54 AM, Christoph Hellwig wrote:
>> +static int dma_heap_release(struct inode *inode, struct file *filp)
>> +{
>> +	filp->private_data = NULL;
>> +
>> +	return 0;
>> +}
> 
> No point in clearing ->private_data, the file is about to be freed.
> 

This was leftover from when release had some memory to free, will remove.

>> +
>> +static long dma_heap_ioctl(struct file *filp, unsigned int cmd,
>> +			   unsigned long arg)
> 
> Pleae don't use the weird legacy filp naming, file is a perfectly
> valid and readable default name for struct file pointers.
> 

Thanks for info, I saw both used and this was used where I found the
prototype so I used it too, will fix.

>> +{
>> +	switch (cmd) {
>> +	case DMA_HEAP_IOC_ALLOC:
>> +	{
>> +		struct dma_heap_allocation_data heap_allocation;
>> +		struct dma_heap *heap = filp->private_data;
>> +		int fd;
> 
> Please split each ioctl into a separate function from the very start,
> otherwise this will grow into a spaghetty mess sooner than you can
> see cheese.
> 

Good idea, will fix.

>> +	dev_ret = device_create(dma_heap_class,
>> +				NULL,
>> +				heap->heap_devt,
>> +				NULL,
>> +				heap->name);
> 
> No need this weird argument alignment.
> 

I kinda like it this way, if everything cant fit on one line then
everything gets its own line, seems more consistent. If there is strong
objection I can fix.
