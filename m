Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53579C4321A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 08:39:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30371208E3
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 08:39:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391387AbfFKIjL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 04:39:11 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:42939 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391146AbfFKIjK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 04:39:10 -0400
Received: by mail-ed1-f68.google.com with SMTP id z25so18802692edq.9
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2019 01:39:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=EZPJDu0+5poRi+ob6FAvc4kTQEKHJCev1SL/oyf3pzs=;
        b=DmPfvWtPV7JWe5FpYjp0naZf+x3bUT1P69aSCeVfgS+E2OLSSFy6J3rsyi9B3RI10E
         Vn0IlB2+JwnUL/KcbIi2eHfN5dE9bGs7c1wwSy0hJrMgBYd9buys19/ZbH6g78UvPI0H
         Rpe0RNXWTFdN/j4YCuyTd5AL8TOt4DMs+FDN1mvP5cM3di0VAO6X3jpmUohw8vxzaxzH
         s4kvbHa16E7SFAjRqlAOBtgwfULEHJwbIYoHW+qjz3YxeDy4bnE+q0ar2PzlA1dgZE6K
         bI8KSENfl/dg4Heia8EvhR4x/5HQPfXmqh2ko0H1sbDKN7dc+mAKAMrRTJdbGJZfStRa
         48+w==
X-Gm-Message-State: APjAAAWmL/0MxsxPM3k2SUzXvhOXScPiKIUc58LYg3P8Pw7OWd4yZxTy
        TW9uSp8g5zoZJHtUpfciTRV5i0LuDz8=
X-Google-Smtp-Source: APXvYqzMOTMnChDp4MCNUi3VgsI57hmj7rstuSGCuRXwJHHWKOgudtaqqrkWi6cuF6Jc+SPJDa0aoQ==
X-Received: by 2002:a50:9451:: with SMTP id q17mr16035952eda.119.1560242349441;
        Tue, 11 Jun 2019 01:39:09 -0700 (PDT)
Received: from shalem.localdomain (84-106-84-65.cable.dynamic.v4.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id b25sm666371eda.38.2019.06.11.01.39.08
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Jun 2019 01:39:08 -0700 (PDT)
Subject: Re: [PATCH -next] HID: logitech-dj: fix return value of
 logi_dj_recv_query_hidpp_devices
To:     Yuehaibing <yuehaibing@huawei.com>, jikos@kernel.org,
        benjamin.tissoires@redhat.com, jkosina@suse.cz
Cc:     linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
References: <20190525140908.2804-1-yuehaibing@huawei.com>
 <50800f5e-867d-ded9-235c-b9c2db1c41ef@huawei.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <c9510bce-525a-c4d4-531c-7cf55e141754@redhat.com>
Date:   Tue, 11 Jun 2019 10:39:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <50800f5e-867d-ded9-235c-b9c2db1c41ef@huawei.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 11-06-19 05:00, Yuehaibing wrote:
> Hi all,
> 
> Friendly ping...
> 
> On 2019/5/25 22:09, YueHaibing wrote:
>> We should return 'retval' as the correct return value
>> instead of always zero.
>>
>> Fixes: 74808f9115ce ("HID: logitech-dj: add support for non unifying receivers")
>> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans



>> ---
>>   drivers/hid/hid-logitech-dj.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/hid/hid-logitech-dj.c b/drivers/hid/hid-logitech-dj.c
>> index 41baa4dbbfcc..7f8db602eec0 100644
>> --- a/drivers/hid/hid-logitech-dj.c
>> +++ b/drivers/hid/hid-logitech-dj.c
>> @@ -1133,7 +1133,7 @@ static int logi_dj_recv_query_hidpp_devices(struct dj_receiver_dev *djrcv_dev)
>>   				    HID_REQ_SET_REPORT);
>>   
>>   	kfree(hidpp_report);
>> -	return 0;
>> +	return retval;
>>   }
>>   
>>   static int logi_dj_recv_query_paired_devices(struct dj_receiver_dev *djrcv_dev)
>>
> 
