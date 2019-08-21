Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9A81C3A59E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 14:30:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B6F221655
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 14:30:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HCxnGbwT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729405AbfHUOaf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 10:30:35 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:45883 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728608AbfHUOaf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 10:30:35 -0400
Received: by mail-pg1-f193.google.com with SMTP id o13so1403716pgp.12
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2019 07:30:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=POOVwfBmPp+2sirAEVl3ipBs6tHZED7y8cIVmeFMwTI=;
        b=HCxnGbwTQiVptAvliIZP8QPdeh/3wux4waX2rmVhZ250yWJhh7mV7xgYDLtXGW/1aR
         yA9Fjlzn3ToA1XPUxvgmPuGDSAr9jp7wBxhJ370vKDDq7Lq12QjvrxTszL2sdVHid/2u
         lVoWTqjawhYfaw2XYb39HZlOQhnb2MjUa1iUcNJLHO6ri45xcXnX1PNpqEPSmA1p/f3k
         X24ORaxi3QuupBMj76GYtevoIn+1BtGiM0iTuY8YaOGvQArF1o5t83crRulwAUi1OqK2
         N6v5SX8AQiMFbmPRtoPpfSTCuR2JKUQdi9+L2ORXwFMi9DHALw/x36RBxRZlKr2E+Cys
         NnAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=POOVwfBmPp+2sirAEVl3ipBs6tHZED7y8cIVmeFMwTI=;
        b=qpBbVnQWNfBqjyo/OtwNb4u+Gk8fjnuQP1ja6xfMsEz/PUv1QVtVvyB13B9Vfx3/vs
         VPX8vkn2H+b13GGNpJOQ3uOZcgBN1105WETiIa7eVe3zF18znt0T7dgyXJGhoI+ncCqx
         lNr/prqYpBlsS6P8bHPMh0wcEs9yPDhENmNQO8BRrBFk2bMQ2BAGTZiI2BPgdl3ozxkw
         f1WQwZxC9etoOScGZ8WjwBfVWmMkc7eGpDlSOzWU/BVyG7jLvh+JwgTc+rWUcEMP0pD+
         6oXGVniJFExlEg7/fAExtmKTB+4t/tdKVHFPrbkfo45neROdwmc8hnERY5VK50zg1sjk
         3Tkg==
X-Gm-Message-State: APjAAAWPVAXGGirE8rqr14th75kZ8xl6h1k3I2bnCO+CSRXW5wnS76DB
        IZ/IT5UwfxEguRkTjRnpHhP3BA==
X-Google-Smtp-Source: APXvYqxtWR+iPJC2pOJsFEDeO0ucRFGRqL5qglD26QMtE1THH7GQp6z16sJI2l8hCOKdoJXfQ0mFBw==
X-Received: by 2002:a63:1749:: with SMTP id 9mr30028396pgx.0.1566397834547;
        Wed, 21 Aug 2019 07:30:34 -0700 (PDT)
Received: from ?IPv6:240e:362:4ae:f300:a8a2:65b0:f68d:6da? ([240e:362:4ae:f300:a8a2:65b0:f68d:6da])
        by smtp.gmail.com with ESMTPSA id x128sm43918996pfd.52.2019.08.21.07.30.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Aug 2019 07:30:33 -0700 (PDT)
Subject: Re: [PATCH 2/2] uacce: add uacce module
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-accelerators@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, Kenneth Lee <liguozhu@hisilicon.com>,
        Zaibo Xu <xuzaibo@huawei.com>,
        Zhou Wang <wangzhou1@hisilicon.com>
References: <1565775265-21212-1-git-send-email-zhangfei.gao@linaro.org>
 <1565775265-21212-3-git-send-email-zhangfei.gao@linaro.org>
 <20190815141351.GD23267@kroah.com>
 <6daab785-a8f9-684e-eb71-7a81604d3bb0@linaro.org>
 <20190820165947.GC3736@kroah.com>
 <5d5cf0fc.1c69fb81.ec57f.b853SMTPIN_ADDED_BROKEN@mx.google.com>
 <20190821091709.GA22914@kroah.com>
From:   zhangfei <zhangfei.gao@linaro.org>
Message-ID: <b88abb8d-50a9-b29e-d3e5-96cc585ecac4@linaro.org>
Date:   Wed, 21 Aug 2019 22:30:22 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190821091709.GA22914@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019/8/21 下午5:17, Greg Kroah-Hartman wrote:
> On Wed, Aug 21, 2019 at 03:21:18PM +0800, zhangfei.gao@foxmail.com wrote:
>> Hi, Greg
>>
>> On 2019/8/21 上午12:59, Greg Kroah-Hartman wrote:
>>> On Tue, Aug 20, 2019 at 09:08:55PM +0800, zhangfei wrote:
>>>> On 2019/8/15 下午10:13, Greg Kroah-Hartman wrote:
>>>>> On Wed, Aug 14, 2019 at 05:34:25PM +0800, Zhangfei Gao wrote:
>>>>>> +int uacce_register(struct uacce *uacce)
>>>>>> +{
>>>>>> +	int ret;
>>>>>> +
>>>>>> +	if (!uacce->pdev) {
>>>>>> +		pr_debug("uacce parent device not set\n");
>>>>>> +		return -ENODEV;
>>>>>> +	}
>>>>>> +
>>>>>> +	if (uacce->flags & UACCE_DEV_NOIOMMU) {
>>>>>> +		add_taint(TAINT_CRAP, LOCKDEP_STILL_OK);
>>>>>> +		dev_warn(uacce->pdev,
>>>>>> +			 "Register to noiommu mode, which export kernel data to user space and may vulnerable to attack");
>>>>>> +	}
>>>>> THat is odd, why even offer this feature then if it is a major issue?
>>>> UACCE_DEV_NOIOMMU maybe confusing here.
>>>>
>>>> In this mode, app use ioctl to get dma_handle from dma_alloc_coherent.
>>> That's odd, why not use the other default apis to do that?
>>>
>>>> It does not matter iommu is enabled or not.
>>>> In case iommu is disabled, it maybe dangerous to kernel, so we added warning here, is it required?
>>> You should use the other documentated apis for this, don't create your
>>> own.
>> I am sorry, not understand here.
>> Do you mean there is a standard ioctl or standard api in user space, it can
>> get dma_handle from dma_alloc_coherent from kernel?
> There should be a standard way to get such a handle from userspace
> today.  Isn't that what the ion interface does?  DRM also does this, as
> does UIO I think.
Thanks Greg,
Still not find it, will do more search.
But this may introduce dependency in our lib, like depend on ion?
> Do you have a spec somewhere that shows exactly what you are trying to
> do here, along with example userspace code?  It's hard to determine it
> given you only have one "half" of the code here and no users of the apis
> you are creating.
>
The purpose is doing dma in user space.
If sva is supported, we can directly use malloc memory.
If sva is not supported, device can not recognize va, so we get 
dma_handle via ioctl.

Sample user code is in
https://github.com/Linaro/warpdrive/blob/wdprd-v1-current/test/test_hisi_zip.c
hizip_wd_sched_init_cache:
     if (sched->qs[0].dev_flags & UACCE_DEV_NOIOMMU) {
         data_in = wd_get_pa_from_va(&sched->qs[0], wd_msg->data_in);
         data_out = wd_get_pa_from_va(&sched->qs[0], wd_msg->data_out);
     } else {
         data_in = wd_msg->data_in;
         data_out = wd_msg->data_out;
     }
     msg->source_addr_l = (__u64)data_in & 0xffffffff;
     msg->source_addr_h = (__u64)data_in >> 32;
     msg->dest_addr_l = (__u64)data_out & 0xffffffff;
     msg->dest_addr_h = (__u64)data_out >> 32;

Have added some explanation in warpdrive.rst, in the first patch.

The device can also be declared as UACCE_DEV_NOIOMMU. It can be used 
when the
device has no iommu support or the iommu is set in pass through mode.  
In this
case, the driver should map address to device by itself with DMA API. The
ioctl(UACCE_CMD_GET_SS_DMA) can be used to get the physical address, 
though it
is an untrusted and kernel-tainted behavior.

Thanks

