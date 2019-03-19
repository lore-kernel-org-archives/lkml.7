Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19CAAC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 15:24:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D306520811
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 15:24:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="lnpP+bLR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727472AbfCSPYR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 11:24:17 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:55516 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726579AbfCSPYR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 11:24:17 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x2JFO5Kb117118;
        Tue, 19 Mar 2019 10:24:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1553009045;
        bh=CpzEqGyOCfpNpw9oixEL1eTI8BmbOV0KTjwVSvnTDAM=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=lnpP+bLRLhii5KP+yVHYpanAac0o0TU0I9/xcMi1rsS6Xzv8glkLSX3R9IbVEyofw
         mdPhVR6YBGsWFz4/wicQ+BA7hXzbsB4neHK61gMs494NiRw+h6i/ZL1q2etyJDBYV5
         chIPEHg/ezSXCKAsAspJGJZzSpxCYQWR0LQ86Beg=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x2JFO5wL085998
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 19 Mar 2019 10:24:05 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Tue, 19
 Mar 2019 10:24:05 -0500
Received: from dflp33.itg.ti.com (10.64.6.16) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5 via Frontend Transport;
 Tue, 19 Mar 2019 10:24:05 -0500
Received: from [10.250.67.168] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id x2JFO4xN000625;
        Tue, 19 Mar 2019 10:24:04 -0500
Subject: Re: [RFC][PATCH 1/5 v2] dma-buf: Add dma-buf heaps framework
To:     Brian Starkey <Brian.Starkey@arm.com>,
        John Stultz <john.stultz@linaro.org>
CC:     lkml <linux-kernel@vger.kernel.org>,
        Laura Abbott <labbott@redhat.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Liam Mark <lmark@codeaurora.org>,
        Chenbo Feng <fengc@google.com>,
        Alistair Strachan <astrachan@google.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        nd <nd@arm.com>
References: <1551819273-640-1-git-send-email-john.stultz@linaro.org>
 <1551819273-640-2-git-send-email-john.stultz@linaro.org>
 <20190319120825.3mvdxp5saluboy7o@DESKTOP-E1NTVVP.localdomain>
From:   "Andrew F. Davis" <afd@ti.com>
Message-ID: <0deeabd5-9f61-b250-a531-a86c6c58b679@ti.com>
Date:   Tue, 19 Mar 2019 10:24:04 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190319120825.3mvdxp5saluboy7o@DESKTOP-E1NTVVP.localdomain>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/19/19 7:08 AM, Brian Starkey wrote:
> Hi John,
> 
> On Tue, Mar 05, 2019 at 12:54:29PM -0800, John Stultz wrote:
>> From: "Andrew F. Davis" <afd@ti.com>
> 
> [snip]
> 
>> +
>> +#define NUM_HEAP_MINORS 128
>> +static DEFINE_IDR(dma_heap_idr);
>> +static DEFINE_MUTEX(minor_lock); /* Protect idr accesses */
> 
> I saw that Matthew Wilcox is trying to nuke idr:
> https://patchwork.freedesktop.org/series/57073/
> 
> Perhaps a different data structure could be considered? (I don't have
> an informed opinion on which).
> 

Looks like XArray is the suggested replacement. Should be easy enough,
the minor number would just index to our heap struct directly, I'll give
it a shot and see.

>> +
>> +dev_t dma_heap_devt;
>> +struct class *dma_heap_class;
>> +struct list_head dma_heap_list;
>> +struct dentry *dma_heap_debug_root;
>> +
>> +static int dma_heap_buffer_alloc(struct dma_heap *heap, size_t len,
>> +				 unsigned int flags)
>> +{
>> +	len = PAGE_ALIGN(len);
>> +	if (!len)
>> +		return -EINVAL;
> 
> I think aligning len to pages only makes sense if heaps are going to
> allocate aligned to pages too. Perhaps that's an implicit assumption?
> If so, lets document it.
> 
> Why not let the heaps take care of aligning len however they want
> though?
> 

This is how I originally had it, but I think we couldn't find any case
where you would want an the start or end of a buffer to not fall on a
page boundary here. It would only lead to problems. As you say though,
nothing keeping us from moving that into the heaps themselves.

> ...
> 
>> +
>> +int dma_heap_add(struct dma_heap *heap)
>> +{
>> +	struct device *dev_ret;
>> +	int ret;
>> +
>> +	if (!heap->name || !strcmp(heap->name, "")) {
>> +		pr_err("dma_heap: Cannot add heap without a name\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +	if (!heap->ops || !heap->ops->allocate) {
>> +		pr_err("dma_heap: Cannot add heap with invalid ops struct\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +	/* Find unused minor number */
>> +	mutex_lock(&minor_lock);
>> +	ret = idr_alloc(&dma_heap_idr, heap, 0, NUM_HEAP_MINORS, GFP_KERNEL);
>> +	mutex_unlock(&minor_lock);
>> +	if (ret < 0) {
>> +		pr_err("dma_heap: Unable to get minor number for heap\n");
>> +		return ret;
>> +	}
>> +	heap->minor = ret;
>> +
>> +	/* Create device */
>> +	heap->heap_devt = MKDEV(MAJOR(dma_heap_devt), heap->minor);
>> +	dev_ret = device_create(dma_heap_class,
>> +				NULL,
>> +				heap->heap_devt,
>> +				NULL,
>> +				heap->name);
>> +	if (IS_ERR(dev_ret)) {
>> +		pr_err("dma_heap: Unable to create char device\n");
>> +		return PTR_ERR(dev_ret);
>> +	}
>> +
>> +	/* Add device */
>> +	cdev_init(&heap->heap_cdev, &dma_heap_fops);
>> +	ret = cdev_add(&heap->heap_cdev, dma_heap_devt, NUM_HEAP_MINORS);
> 
> Shouldn't this be s/dma_heap_devt/heap->heap_devt/ and a count of 1?
> 

Hmm, strange this ever worked before..

> Also would it be better to have cdev_add/device_create the other way
> around? First create the char device, then once it's all set up
> register it with sysfs.
> 

Yes that does seem to be more common, lets flip it.

>> +	if (ret < 0) {
>> +		device_destroy(dma_heap_class, heap->heap_devt);
>> +		pr_err("dma_heap: Unable to add char device\n");
>> +		return ret;
>> +	}
>> +
>> +	return 0;
>> +}
>> +EXPORT_SYMBOL(dma_heap_add);
> 
> Until we've figured out how modules are going to work, I still think
> it would be a good idea to not export this.
> 

Agree.

Andrew

> Cheers,
> -Brian
> 
