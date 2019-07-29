Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12BE5C433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 11:44:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3D1620651
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 11:44:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OarXZMdj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387787AbfG2LoK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 07:44:10 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:43611 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387701AbfG2LoK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 07:44:10 -0400
Received: by mail-pf1-f195.google.com with SMTP id i189so27905981pfg.10;
        Mon, 29 Jul 2019 04:44:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=/GdbQmHDgRxOIS9Wz7Qs+ZEMMYW4qyH6JYf9o6A1T0U=;
        b=OarXZMdjsEIRH/B2hQgEb/RKA3uNUmUrj/k5djGinq6oLebsIYvUwa6wNSoYX6RAfW
         QeeSa4wZ6xZDk0h9GfP6/ya67iYrpV+8SZ05T0c5+RPVhigzCm6CW6hlwn99gdAGb15V
         0RkEqZudL0Pmw4ZFHjoxenhULkWdsfZyYIa86MmfPsPETKlD5khr0WnI4zV3712tWpMm
         JI7s34YoD2VACRzirHt0oQrfaAB4j5HnAyeHpQZapbzsLizkjFStVHmaq2zD6vpTMqaJ
         B+WZX8inoo3mTfh/IERGkPm7npXdbNp/r6f7IX3NpHVRqP6DPD7uqFt0mx2OsipuUzW2
         /IFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=/GdbQmHDgRxOIS9Wz7Qs+ZEMMYW4qyH6JYf9o6A1T0U=;
        b=mvlstNHGWpPWmNrITbHSCx/GglpXY7J3WQAbXpsz/qr7eJ4KtKij0c8jqfEY9Si8eT
         ABxrOZTEELGLRKOZwv5cRaeAwUBKvHzTws5CwKQZF+KcCslNZh3zZVudWHJaXXby2sU6
         d+EPgFtNmsla6P+RbuoKKYwNEGHBs1kA3t7lVPnBgV2EEyVE6a36+ZNjGbWZ5NvTRdJp
         yZzm05ECiq1kYNBuR+KQs0EVhTKNy1Uw/MaufGz1NjrK/64q5iBf+h9iv9j0en9ypY+M
         T0T9P7Ct16V7Wf0jDe7dS2wCSxfXUiDugwV9t8+Updp8hL0z1bdvZa+BhELtvn34SPII
         eoPg==
X-Gm-Message-State: APjAAAUIVYMl9U2IRvajEQ2uME+7oT5Qk40H++FPgN4ePxqNGzmUgoq9
        vKoRIeen24NhYBYPCK3OSOHrcuhoysw=
X-Google-Smtp-Source: APXvYqy3GsKrIff1bHm1Y5Fg99sIIA4Iv+DUlUtjbfv6ilsoa/uoUdhdryfVBc72f6L3uxxptqcfCA==
X-Received: by 2002:a17:90a:cb01:: with SMTP id z1mr110535882pjt.93.1564400649494;
        Mon, 29 Jul 2019 04:44:09 -0700 (PDT)
Received: from ?IPv6:2402:f000:4:72:808::177e? ([2402:f000:4:72:808::177e])
        by smtp.gmail.com with ESMTPSA id z12sm42867392pfn.29.2019.07.29.04.44.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Jul 2019 04:44:08 -0700 (PDT)
Subject: Re: [PATCH] usb: storage: sddr55: Fix a possible null-pointer
 dereference in sddr55_transport()
To:     Oliver Neukum <oneukum@suse.com>, gregkh@linuxfoundation.org,
        stern@rowland.harvard.edu
Cc:     usb-storage@lists.one-eyed-alien.net, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
References: <20190729100555.2081-1-baijiaju1990@gmail.com>
 <1564398922.25582.6.camel@suse.com>
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
Message-ID: <8d21d256-8c03-7864-d45b-fb7f2590721e@gmail.com>
Date:   Mon, 29 Jul 2019 19:44:08 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1564398922.25582.6.camel@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019/7/29 19:15, Oliver Neukum wrote:
> Am Montag, den 29.07.2019, 18:05 +0800 schrieb Jia-Ju Bai:
>
> Hi,
>
>> In sddr55_transport(), there is an if statement on line 836 to check
>> whether info->lba_to_pba is NULL:
>>      if (info->lba_to_pba == NULL || ...)
>>
>> When info->lba_to_pba is NULL, it is used on line 948:
>>      pba = info->lba_to_pba[lba];
>>
>> Thus, a possible null-pointer dereference may occur.
> Yes, in practice READ_CAPACITY will always be called and set
> up the correct translation table, but you can probably exploit
> this.
>
>> To fix this bug, info->lba_to_pba is checked before being used.
>>
>> This bug is found by a static analysis tool STCheck written by us.
>>
>> Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
>> ---
>>   drivers/usb/storage/sddr55.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/usb/storage/sddr55.c b/drivers/usb/storage/sddr55.c
>> index b8527c55335b..50afc39aa21d 100644
>> --- a/drivers/usb/storage/sddr55.c
>> +++ b/drivers/usb/storage/sddr55.c
>> @@ -945,7 +945,8 @@ static int sddr55_transport(struct scsi_cmnd *srb, struct us_data *us)
>>   			return USB_STOR_TRANSPORT_FAILED;
>>   		}
>>   
>> -		pba = info->lba_to_pba[lba];
>> +		if (info->lba_to_pba)
>> +			pba = info->lba_to_pba[lba];
> If you use that fix, pba will be uninitialized when used. It should be
> something like:
>
> pba = info->lba_to_pba ? info->lba_to_pba[lba] : 0;

Thanks for the advice.
I will send a v2 patch.


Best wishes,
Jia-Ju Bai
