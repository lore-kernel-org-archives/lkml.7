Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A6D6C10F03
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 15:00:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FEEF20811
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 15:00:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="GtFyJA5/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726472AbfC1PAP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 11:00:15 -0400
Received: from mta-p6.oit.umn.edu ([134.84.196.206]:49018 "EHLO
        mta-p6.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726076AbfC1PAO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 11:00:14 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p6.oit.umn.edu (Postfix) with ESMTP id 35EB9CC1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2019 15:00:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p6.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p6.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id QUqPxzLT6rTK for <linux-kernel@vger.kernel.org>;
        Thu, 28 Mar 2019 10:00:13 -0500 (CDT)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p6.oit.umn.edu (Postfix) with ESMTPS id 07D31D61
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2019 10:00:12 -0500 (CDT)
Received: by mail-io1-f71.google.com with SMTP id s24so15911730ioe.17
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2019 08:00:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=YWSrUGkwcGWWeGYaF/IJQXLuzLlHybIatRW4u4gHLH0=;
        b=GtFyJA5/4VuNZdXRc7qaLnj0y9rlpL6gGRK2U5LzHtSZ+pC5LguoYSDWbHyrALy7G4
         HxyVBIbep5VyEN92E03rMRZ0Rk+GP3CWGwqTN12+9NWGbaKzgDdWr+FMYLbO43mWShjb
         k7UnfUwkLXUziRxi1t6WKmp3giTc92TfGVDB/RWHs9MfoveLa1wpCcRbo+fOPrpqlwQl
         //jUG5TrG4Q6ICSMsw7aaKfNgjxCZCI+Mpz/lppRbi9go1m0hKVZU923xJB5BXnBMejO
         sAAGW3eHROA23thRVdnrBAefrOwZXcJaziMH4ThyJzink7mYZAWcOeJhfVeErzb9/bbW
         EUvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=YWSrUGkwcGWWeGYaF/IJQXLuzLlHybIatRW4u4gHLH0=;
        b=EpRitbkAGc4G69qo6InH9ytoo+r4aA4G2rs/5Vs7Sz2y0tvWme4BlxWJGnqImmY9+Z
         uyHgWVV2rGyzQF077YF2m34agVLRV3Rod7JQCTGnbRGTv3olqe/kJpTiRPko4XRlJvH8
         UM9AjCfON6zPmOAVffLA4e6fCc7RR5oREWr9L/Tt8qtVEgqowoE6VOmV96I6jFIQfKCw
         w/8fgWuSSiHtuWpDQKgfDbC5H/7egbrljjR1F3PKmEHJdZzvTANrC9d5uyAYe8tziw/7
         +Pk8RcMoNo4dFJ5/Ai7I2muWyh5cP0wB5RwFhE3qC8nXACZcsk8jB1urrao/EUl2DbV7
         I52Q==
X-Gm-Message-State: APjAAAVJN0wRv+TPIVaP8JCZrtawRVLM/SFyWbUhubIq4+tsX0OybhV7
        uiODCXq0IYIgGrd9JgPnS9Mx9VOJi72rpM6wI6hJ4j4qJqVSt+cLotTpaxBx1b8B8yfkOwwFB4c
        fDx/UsKVgzJazE2HclXVfwSZrJ+SX
X-Received: by 2002:a5d:8717:: with SMTP id u23mr2515376iom.93.1553785212160;
        Thu, 28 Mar 2019 08:00:12 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzUFYBel8E7c3BwKif8q7MHr72imYObu6pfx7YyMK9lYdqq/sih+bainr+EBYPVaMNDCTYdpQ==
X-Received: by 2002:a5d:8717:: with SMTP id u23mr2515349iom.93.1553785211832;
        Thu, 28 Mar 2019 08:00:11 -0700 (PDT)
Received: from [128.101.106.63] (cs-bee-u.cs.umn.edu. [128.101.106.63])
        by smtp.gmail.com with ESMTPSA id u8sm2184354ita.25.2019.03.28.08.00.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Mar 2019 08:00:11 -0700 (PDT)
Subject: Re: [PATCH v3] media: rga: fix NULL pointer dereferences,
 use-after-free, memory leak
To:     Hans Verkuil <hverkuil@xs4all.nl>
Cc:     pakki001@umn.edu, Jacob chen <jacob2.chen@rock-chips.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>, linux-media@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
References: <ff11d704-489f-836e-6c9d-1b2fb5e963b6@arm.com>
 <20190314050344.29790-1-kjlu@umn.edu>
 <47c6d19c-96bd-49e1-7a3e-702fc50df670@xs4all.nl>
From:   Kangjie Lu <kjlu@umn.edu>
Message-ID: <c1751cd8-f93d-7045-d7ed-911c88ba9650@umn.edu>
Date:   Thu, 28 Mar 2019 10:00:09 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <47c6d19c-96bd-49e1-7a3e-702fc50df670@xs4all.nl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/28/19 9:47 AM, Hans Verkuil wrote:
> Hi Kangjie,
>
> Unfortunately there are more issues with the cleanup sequence in
> this probe function:
>
> On 3/14/19 6:03 AM, Kangjie Lu wrote:
>> 1. dma_alloc_attrs, __get_free_pages can fail and return NULL.
>> Further uses of their return values lead to NULL pointer
>> dereferences
>>
>> 2. In the error-handling path, video_unregister_device uses
>> "rga->vfd" which has been freed by video_device_release
>>
>> 3. The error handling for v4l2_m2m_init and video_register_device
>> has memory-leak issues
>>
>> The patch fixes the above issues.
>>
>> Signed-off-by: Kangjie Lu <kjlu@umn.edu>
>> ---
>>   drivers/media/platform/rockchip/rga/rga.c | 26 ++++++++++++++++++++---
>>   1 file changed, 23 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/media/platform/rockchip/rga/rga.c b/drivers/media/platform/rockchip/rga/rga.c
>> index 5c653287185f..468365ceb99d 100644
>> --- a/drivers/media/platform/rockchip/rga/rga.c
>> +++ b/drivers/media/platform/rockchip/rga/rga.c
>> @@ -889,11 +889,24 @@ static int rga_probe(struct platform_device *pdev)
>>   	rga->cmdbuf_virt = dma_alloc_attrs(rga->dev, RGA_CMDBUF_SIZE,
>>   					   &rga->cmdbuf_phy, GFP_KERNEL,
>>   					   DMA_ATTR_WRITE_COMBINE);
>> +	if (!rga->cmdbuf_virt) {
>> +		ret = -ENOMEM;
>> +		goto unreg_video_dev;
> Actually, the unreg_video_dev label makes no sense: if the video device
> is successfully registered, then probe() returns 0. So you never need to
> unregister the video device again. You *do* need to release it with
> video_device_release().
>
> So this should be a goto rel_vdev.
>
> And the cleanup sequence at the end also fails to call v4l2_m2m_release().
>
> Can you make v4?


Thanks for the feedback. Will send a v4.


>
> Thanks!
>
> 	Hans
>
>> +	}
>>   
>>   	rga->src_mmu_pages =
>>   		(unsigned int *)__get_free_pages(GFP_KERNEL | __GFP_ZERO, 3);
>> +	if (!rga->src_mmu_pages) {
>> +		ret = -ENOMEM;
>> +		goto free_dma_attrs;
>> +	}
>> +
>>   	rga->dst_mmu_pages =
>>   		(unsigned int *)__get_free_pages(GFP_KERNEL | __GFP_ZERO, 3);
>> +	if (!rga->dst_mmu_pages) {
>> +		ret = -ENOMEM;
>> +		goto free_dst_pages;
>> +	}
>>   
>>   	def_frame.stride = (def_frame.width * def_frame.fmt->depth) >> 3;
>>   	def_frame.size = def_frame.stride * def_frame.height;
>> @@ -901,7 +914,7 @@ static int rga_probe(struct platform_device *pdev)
>>   	ret = video_register_device(vfd, VFL_TYPE_GRABBER, -1);
>>   	if (ret) {
>>   		v4l2_err(&rga->v4l2_dev, "Failed to register video device\n");
>> -		goto rel_vdev;
>> +		goto free_pages;
>>   	}
>>   
>>   	v4l2_info(&rga->v4l2_dev, "Registered %s as /dev/%s\n",
>> @@ -909,10 +922,17 @@ static int rga_probe(struct platform_device *pdev)
>>   
>>   	return 0;
>>   
>> -rel_vdev:
>> -	video_device_release(vfd);
>> +free_pages:
>> +	free_pages((unsigned long)rga->src_mmu_pages, 3);
>> +free_dst_pages:
>> +	free_pages((unsigned long)rga->dst_mmu_pages, 3);
>> +free_dma_attrs:
>> +	dma_free_attrs(rga->dev, RGA_CMDBUF_SIZE, rga->cmdbuf_virt,
>> +		       rga->cmdbuf_phy,
>> +		       DMA_ATTR_WRITE_COMBINE);
>>   unreg_video_dev:
>>   	video_unregister_device(rga->vfd);
>> +	video_device_release(vfd);
>>   unreg_v4l2_dev:
>>   	v4l2_device_unregister(&rga->v4l2_dev);
>>   err_put_clk:
>>
