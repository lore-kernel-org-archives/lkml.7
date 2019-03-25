Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9BE5C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 10:56:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A218B2085A
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 10:56:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lightnvm-io.20150623.gappssmtp.com header.i=@lightnvm-io.20150623.gappssmtp.com header.b="HpsxF7hf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730755AbfCYK4l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 06:56:41 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:41833 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729727AbfCYK4l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 06:56:41 -0400
Received: by mail-ed1-f67.google.com with SMTP id a25so7079491edc.8
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 03:56:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=JtrkeL7DaI8KDO1P0D14YhwS5PPBTQS2EvHfHX3xuoU=;
        b=HpsxF7hf8Yp1Rx7GZkRoi0SAUTSi31KGgTEAAYdrCKhlgNaIpP+1uxyOzX2840k54B
         8PosezTFjcWTDtKXhplUBvDNFyR9l+/rRec/zjjFIn9HB8LjYjWM2IZLmMlcY2bxWEer
         0xKwXoQVsYc3wBarZfuQi4VFx7yaVg59YQX8aFqXjwU2vtc35SrcXWswfRerYkwGRmHW
         3QiVk2cQI7bRDNi046Jrz5L3jU6bRrY871fW/iuJ3/5Kor1b+HFDB680rc6M7Nz3ANfw
         JvmJHBRTcMCBt87OvpiGMQIUl49szYvAjgcymQSM6JQBovUkV4GslvXpN5rU+W1WpbbM
         W+gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JtrkeL7DaI8KDO1P0D14YhwS5PPBTQS2EvHfHX3xuoU=;
        b=pBDYlXhn/fRZYhL6wY2vy3rUr5FxI2g5MdjQkFGszwLfk3fSxSTkeqrCP1SQ0tBEt9
         ABWqsm72EhbnAqx7AThz0jzG4NM4oxKUUoUIKDI6EKyedFsymJFwZ26ZYcexU3I636Yn
         OdbAIO0pWsT6U5+Ew3GwPkrZBF+0d5zZ+7He7/uAIOtytLCt/qQZSPUnXEGvFNvrTbe0
         k+v2ItOYCerGuK6lj6DYmMH0qfE8+f9DR3f7dkXRYIRpQbEXdzgOgT4h3pWhF0Ch/T2i
         L20hzMQhnkXY5yODaO8dtALwgCC/DXryMVolx7hHcbvvG7y6k744157b4Q0N/42YoNTY
         SuzA==
X-Gm-Message-State: APjAAAU8Np9U8Q/sPEcak6+Fw5z2vwbAj3BKjLpTvWVMuJzAcVONQR6W
        yNKhY9EmEABimRZxnnFXe+t7W6VflmM=
X-Google-Smtp-Source: APXvYqzORhm3J+1lp2LCVv3K3Mk1l7CC5mLTbtXo61Sxd4dGSGQEVFSGn8l/GLASe9V6N2IC16QlTg==
X-Received: by 2002:a50:eb4d:: with SMTP id z13mr8503173edp.200.1553511398976;
        Mon, 25 Mar 2019 03:56:38 -0700 (PDT)
Received: from [192.168.0.36] (2-111-91-225-cable.dk.customer.tdc.net. [2.111.91.225])
        by smtp.googlemail.com with ESMTPSA id d91sm5332758edc.75.2019.03.25.03.56.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Mar 2019 03:56:38 -0700 (PDT)
Subject: Re: [PATCH] nvme: lightnvm: expose OC devices as zero size to OS
To:     Marcin Dziegielewski <marcin.dziegielewski@intel.com>
Cc:     igor.j.konopko@intel.com, Keith Busch <keith.busch@intel.com>,
        Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <1552570910-11706-1-git-send-email-marcin.dziegielewski@intel.com>
 <4e43d40a-b253-1493-da38-70a8c062749e@lightnvm.io>
 <16807f7f-075b-aa27-72c3-a905772ac36d@intel.com>
From:   =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <b6ad4793-11a5-2958-f01e-b62774541299@lightnvm.io>
Date:   Mon, 25 Mar 2019 11:56:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <16807f7f-075b-aa27-72c3-a905772ac36d@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/18/19 2:32 PM, Marcin Dziegielewski wrote:
> On 3/14/19 2:56 PM, Matias Bjørling wrote:
>> On 3/14/19 6:41 AM, Marcin Dziegielewski wrote:
>>> Open channel devices are not able to handle traditional
>>> IO requests addressed by LBA, so following current
>>> approach to exposing special nvme devices as zero size
>>> (e.g. with namespace formatted to use metadata) also
>>> open channel devices should be exposed as zero size
>>> to OS.
>>>
>>> Signed-off-by: Marcin Dziegielewski <marcin.dziegielewski@intel.com>
>>> ---
>>>   drivers/nvme/host/core.c | 3 ++-
>>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
>>> index 07bf2bf..52cd5c8 100644
>>> --- a/drivers/nvme/host/core.c
>>> +++ b/drivers/nvme/host/core.c
>>> @@ -1606,7 +1606,8 @@ static void nvme_update_disk_info(struct 
>>> gendisk *disk,
>>>       if (ns->ms && !ns->ext &&
>>>           (ns->ctrl->ops->flags & NVME_F_METADATA_SUPPORTED))
>>>           nvme_init_integrity(disk, ns->ms, ns->pi_type);
>>> -    if (ns->ms && !nvme_ns_has_pi(ns) && !blk_get_integrity(disk))
>>> +    if ((ns->ms && !nvme_ns_has_pi(ns) && !blk_get_integrity(disk)) ||
>>> +        ns->ndev)
>>>           capacity = 0;
>>>       set_capacity(disk, capacity);
>>>
>>
>> Marcin,
>>
>> The read/write as traditional I/Os feature is supported in OCSSD 2.0. 
>> For example, one can hook support up through the zone device support 
>> in the kernel. There is a patch here that enables it here:
>>
>> https://github.com/OpenChannelSSD/linux/commit/e79e747601a315784e505d51a9265e82a3e7613c 
>>
>>
>> With that, an OCSSD device can be used as a traditional zoned block 
>> device, and use the existing infrastructure. Which is really neat.
>>
>> It is not upstream, since it depends on some features that we 
>> introduce with zoned namespaces, but in general, tools can read/write 
>> from a block device as any other, just honoring the special write 
>> rules that are for OCSSD/zoned block devices.
>>
>> -Matias
> 
> Matias,
> 
> If zone related changes will be in upstream soon, I agree that this 
> patch is not needed.
> 
> But, I can not agree that tools can use OCSSD device as normal block 
> device - for example in current implementation I don't see way to send 
> erase request and of course without it we can not send write. Because of 
> that, it was my intention to block normal IO to OCSSD device by default.
> 
> Marcin

It is implemented the same way as "Zone reset" is implemented in 
ZAC/ZBC. The kernel converts the trim to a vector erase and issues that 
instead.
