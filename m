Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5B10C5DF63
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 18:23:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAB3D20869
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 18:23:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="RHZibutI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732542AbfKFSXf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 13:23:35 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:34160 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727397AbfKFSXe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 13:23:34 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id xA6INEYX092859;
        Wed, 6 Nov 2019 12:23:14 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1573064594;
        bh=mGi893+tyE2Y1fpH/uLzwoHNjFKJNU3RWrSp6pP4v+Y=;
        h=Subject:From:To:CC:References:Date:In-Reply-To;
        b=RHZibutIHrK2DOQb2uXuZW8tUkJEpwGQr2bK4I3vv1RgvmI7tz+ywC1MELqRZdunS
         8Py1YrU4ks4gLagq+JCnDM5ZMnIT2Tt5H7nLIqP47q9AtMxJKZzRgLjL5/YGrSGgKl
         ql6a9pRIRESUUatrYVoC67ACENvpM9o1NPayV3n0=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id xA6IND9F110572;
        Wed, 6 Nov 2019 12:23:13 -0600
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Wed, 6 Nov
 2019 12:23:13 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Wed, 6 Nov 2019 12:22:58 -0600
Received: from [10.250.45.147] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id xA6INCKu089618;
        Wed, 6 Nov 2019 12:23:12 -0600
Subject: Re: [PATCH v15 1/5] dma-buf: Add dma-buf heaps framework
From:   "Andrew F. Davis" <afd@ti.com>
To:     John Stultz <john.stultz@linaro.org>
CC:     Hillf Danton <hdanton@sina.com>,
        Sudipto Paul <Sudipto.Paul@arm.com>,
        Sandeep Patil <sspatil@google.com>,
        Vincent Donnefort <Vincent.Donnefort@arm.com>,
        Chenbo Feng <fengc@google.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Liam Mark <lmark@codeaurora.org>,
        Christoph Hellwig <hch@infradead.org>,
        Alistair Strachan <astrachan@google.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Hridya Valsaraju <hridya@google.com>,
        Pratik Patel <pratikp@codeaurora.org>
References: <20191106042252.72452-1-john.stultz@linaro.org>
 <20191106042252.72452-2-john.stultz@linaro.org>
 <7154851c-fc55-e157-5a01-21abdd4a23e6@ti.com>
 <CALAqxLW1vgLCik5WfDN7qkRsO=K9U4otNBp72aOH5UNN1jUgMQ@mail.gmail.com>
 <26700d4b-07c6-65b1-9fc6-bb3e239202e5@ti.com>
Message-ID: <546505bd-7ea7-6ae4-5dfa-44a3154fd5ea@ti.com>
Date:   Wed, 6 Nov 2019 13:23:12 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <26700d4b-07c6-65b1-9fc6-bb3e239202e5@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/6/19 12:18 PM, Andrew F. Davis wrote:
> On 11/6/19 12:03 PM, John Stultz wrote:
>> On Wed, Nov 6, 2019 at 5:52 AM Andrew F. Davis <afd@ti.com> wrote:
>>>
>>> On 11/5/19 11:22 PM, John Stultz wrote:
>>>> +unsigned int dma_heap_ioctl_cmds[] = {
>>>> +     DMA_HEAP_IOC_ALLOC,
>>>> +};
>>>> +
>>>> +static long dma_heap_ioctl(struct file *file, unsigned int ucmd,
>>>> +                        unsigned long arg)
>>>> +{
>>>> +     char stack_kdata[128];
>>>> +     char *kdata = stack_kdata;
>>>> +     unsigned int kcmd;
>>>> +     unsigned int in_size, out_size, drv_size, ksize;
>>>> +     int nr = _IOC_NR(ucmd);
>>>> +     int ret = 0;
>>>> +
>>>> +     if (nr >= ARRAY_SIZE(dma_heap_ioctl_cmds))
>>>> +             return -EINVAL;
>>>> +
>>>> +     /* Get the kernel ioctl cmd that matches */
>>>> +     kcmd = dma_heap_ioctl_cmds[nr];
>>>
>>>
>>> Why do we need this indirection here and all the complexity below? I
>>> know DRM ioctl does something like this but it has a massive table,
>>> legacy ioctls, driver defined ioctls, etc..
>>>
>>> I don't expect we will ever need complex handling like this, could we
>>> switch back to the more simple handler from v13?
>>
>> I agree it does add complexity, but I'm not sure I see how to avoid
>> some of this. The logic trying to handle that the user may pass a cmd
>> that has the same _IOC_NR() as DMA_HEAP_IOC_ALLOC but not the same
>> size. So the simple "switch(cmd) { case DMA_HEAP_IOC_ALLOC:" we had
>> before won't work (as the cmd will be a different value).
>>
> 
> 
> DMA_HEAP_IOC_ALLOC encodes everything we need, if the size is different
> then the switch case will not match. It handled everything we have.
> 
> 
>> Thus why I thought the cleanest approach would be to use the
>> dma_heap_ioctl_cmds array to convert from whatever the user cmd is to
>> the matching kernel cmd value.
>>
> 
> 
> There are no kernel or user commands, just commands, they will match or
> they are not valid. If someday we some need a variable sized ioctl then
> we can deal with that then.
> 


Had a little discussion about this on IRC #dri-devel (check logs for
today if you want to follow along). Conclusion being the way it is done
here should be fine to help support forward compatibility. If optional
extensions to the structure are made that grow the size of data passed
in then we can ignore that and zero out the returned data without harm.
It is up to the flags field to mark incompatible changes that should
error out from kernel.
Andrew

> Andrew
> 
> 
>> Do you have an alternative suggestion that I'm overlooking?
>>
>> thanks
>> -john
>>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
> 
