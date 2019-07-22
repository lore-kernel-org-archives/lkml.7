Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FBDAC76191
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 02:28:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E620E21926
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 02:28:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com header.i=@bytedance-com.20150623.gappssmtp.com header.b="eNbCOiRw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728628AbfGVC2h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Jul 2019 22:28:37 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:45153 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726233AbfGVC2h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Jul 2019 22:28:37 -0400
Received: by mail-pg1-f196.google.com with SMTP id o13so16892502pgp.12
        for <linux-kernel@vger.kernel.org>; Sun, 21 Jul 2019 19:28:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=Fc57iZooFUGdv6qNrbOBvEc0PY3/VGgAe5H9TF7JjL8=;
        b=eNbCOiRwDs+ySw54XbIGNe3yKnxSpAvCJByMktDNBQJmkKii1iQYRQiY1AYCvzWAe8
         2pxXCq92+EgtgIfKi8csHLFAQUjiSIZfZXZ7ekfCCopi+tVshPOLYGaNZjj5u2BUhhKL
         2bRyhV+Oej0UbyZkuYM0w9QZyKUJ5Ec/kJ+UR5lbVFy4OA1cqGy6q1XCo1sWI9+vukql
         mhFOUPapCB7uZa0tFV+TcTpoHdop3E+mKwOQzCJ0Ob7xWf1nJNyrW6m4sh5OJhGA75Wu
         /SEjlbE3X5sWXkhsUVp8bA0ahpSep600frH1R29pav1HpFjdbTjAE+3RvFFICEEQ/9r5
         Swbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=Fc57iZooFUGdv6qNrbOBvEc0PY3/VGgAe5H9TF7JjL8=;
        b=Sphi1SkzO5XDD1Jpu0N+YFWfhv1VVdaKSbbDgczBOh4gELxem0YYRdtFSpFddWPjK3
         He1bXW7z4Jm3BV/R2nfyyjtDNZkvW42Jm7UpclHYlW2lvxDSzx0x/ySFeE0/TxOhs3pE
         +GF06+MVjp4s0Cz/Yp3gNY7srD1OCNj5qkJEgOMuNNdwFEOWgsgTFrSp3GDQlUh62DyB
         I7dl6Jh0yUFAy/1bJU7uD1WU+f5gx8Rye+pfvOfL4L4EzlS7L+8Q0S0D2d9bCroDvOIf
         ove1Y4QZljaZWxOFBxulvcxOBxI1sVB3K9twVJBCYlP37ekvj7jQN4VAL8sd6gzZhuS8
         Gu5A==
X-Gm-Message-State: APjAAAVal6h8cpJkht5H4CQE5yQ6zuQ1O9Zvpb4Gnox5TxltdJurkQkQ
        gjH+6jPkfVBZ58uqVaRQ6vhx0Q==
X-Google-Smtp-Source: APXvYqwTxu3VG5Bi11QcKHVnH3qmZ+80hSignczcoWr0IHvVOzsdHhCWBCQHVZh6fidkGg/U/k61gw==
X-Received: by 2002:a63:6f81:: with SMTP id k123mr70534951pgc.12.1563762516382;
        Sun, 21 Jul 2019 19:28:36 -0700 (PDT)
Received: from [10.2.194.19] ([61.120.150.70])
        by smtp.gmail.com with ESMTPSA id v184sm37517750pfb.82.2019.07.21.19.28.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 21 Jul 2019 19:28:35 -0700 (PDT)
Subject: Re: [External Email] Re: [PATCH 1/2] virtio-mmio: Process vrings more
 proactively
To:     "Michael S. Tsirkin" <mst@redhat.com>,
        Fei Li <lifei.shirley@bytedance.com>
Cc:     linux-kernel@vger.kernel.org, Jason Wang <jasowang@redhat.com>,
        Pawel Moll <pawel.moll@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>
References: <20190719133135.32418-1-lifei.shirley@bytedance.com>
 <20190719133135.32418-2-lifei.shirley@bytedance.com>
 <20190719111440-mutt-send-email-mst@kernel.org>
From:   Fam Zheng <zhengfeiran@bytedance.com>
Message-ID: <5b29804b-528b-61bd-1ab6-4e442d360cf9@bytedance.com>
Date:   Mon, 22 Jul 2019 10:28:30 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190719111440-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 7/19/19 11:17 PM, Michael S. Tsirkin wrote:
> On Fri, Jul 19, 2019 at 09:31:34PM +0800, Fei Li wrote:
>> From: Fam Zheng <zhengfeiran@bytedance.com>
>>
>> This allows the backend to _not_ trap mmio read of the status register
>> after injecting IRQ in the data path, which can improve the performance
>> significantly by avoiding a vmexit for each interrupt.
>>
>> More importantly it also makes it possible for Firecracker to hook up
>> virtio-mmio with vhost-net, in which case there isn't a way to implement
>> proper status register handling.
>>
>> For a complete backend that does set either INT_CONFIG bit or INT_VRING
>> bit upon generating irq, what happens hasn't changed.
>>
>> Signed-off-by: Fam Zheng <zhengfeiran@bytedance.com>
> This has a side effect of skipping vring callbacks
> if they trigger at the same time with a config
> interrupt.
> I don't see why this is safe.

Good point! I think the block can be moved out from the else block and 
run unconditionally then.

Fam


>
>
>> ---
>>   drivers/virtio/virtio_mmio.c | 4 +---
>>   1 file changed, 1 insertion(+), 3 deletions(-)
>>
>> diff --git a/drivers/virtio/virtio_mmio.c b/drivers/virtio/virtio_mmio.c
>> index e09edb5c5e06..9b42502b2204 100644
>> --- a/drivers/virtio/virtio_mmio.c
>> +++ b/drivers/virtio/virtio_mmio.c
>> @@ -295,9 +295,7 @@ static irqreturn_t vm_interrupt(int irq, void *opaque)
>>   	if (unlikely(status & VIRTIO_MMIO_INT_CONFIG)) {
>>   		virtio_config_changed(&vm_dev->vdev);
>>   		ret = IRQ_HANDLED;
>> -	}
>> -
>> -	if (likely(status & VIRTIO_MMIO_INT_VRING)) {
>> +	} else {
>>   		spin_lock_irqsave(&vm_dev->lock, flags);
>>   		list_for_each_entry(info, &vm_dev->virtqueues, node)
>>   			ret |= vring_interrupt(irq, info->vq);
>> -- 
>> 2.11.0
