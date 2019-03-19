Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF712C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 17:20:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0C1D20863
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 17:20:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="jDkbwlbY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727885AbfCSRUL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 13:20:11 -0400
Received: from mta-p6.oit.umn.edu ([134.84.196.206]:39036 "EHLO
        mta-p6.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726857AbfCSRUJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 13:20:09 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p6.oit.umn.edu (Postfix) with ESMTP id 5DC649D2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2019 17:20:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p6.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p6.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id pcxd05eQzQoj for <linux-kernel@vger.kernel.org>;
        Tue, 19 Mar 2019 12:20:08 -0500 (CDT)
Received: from mail-it1-f197.google.com (mail-it1-f197.google.com [209.85.166.197])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p6.oit.umn.edu (Postfix) with ESMTPS id 1C6FFCF6
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2019 12:20:08 -0500 (CDT)
Received: by mail-it1-f197.google.com with SMTP id j18so18033733itl.6
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2019 10:20:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=KaR3N1FpAReCIY2t+BDFxfPRzj3N4WbhEtnv+BeiWXs=;
        b=jDkbwlbYbZQF10eYeuIU+41YpctUp0Dey0hWrqqBCHGB+H8PkLJqiQE+22rEqxyOUd
         hMoF40utaTpw0Ptkrn/Ag+VQfMl5DcEoArXp3E9oM+Ij0Bw2y/6mwhOQw5B4gjLqnYOl
         umXzmBS3P0lD39i1pbhyiXOh3GyDh4KqTRxFOnhrkjVBgjsPaAml65an1w69I+4DsA4J
         h4vopvwDgT46K1pQS3DB2TIAnVo8aL9YVjMcFm701yXEIKVvnCG169vdO3TRqiCHQFhT
         FvODkzR5v+OUq1C4ezAY5s/ttpFAex4fc9QHLHbGT06+KD6BRI62pl9LtOESaMtE0NHx
         1t7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=KaR3N1FpAReCIY2t+BDFxfPRzj3N4WbhEtnv+BeiWXs=;
        b=NYII0gRogpUulxPm66KrmkHhcyBOFIVssA403XkZfRKbvUgfZKvuvBScg7w+48g5s+
         AsQNVdPsZYgAnF4ZsxIBv58EQePU/99qxppsuFXQAZtSTADD2lXkU+uZksKw8Jjhq57e
         koJ43obzGh6WIEMIzlTSIoc64mZIaoU+uDH+7sgMBnsf79BUzXA9Pq3cm/VjkkjH0bHC
         /ODYyOx7QrPYb37FfW6F8ESJEETQShMDX0tmDZjZjaTFkFPfGepiAlVrAqwtf6KnJGkd
         W3SQh9r9qm7LgTr1q36H4pOSy1kkixk625lLmwxWA7Zi+jP9vctxizQ0T2acmeCTNTno
         cQlA==
X-Gm-Message-State: APjAAAV/D0Mpexw0N1BrKCjMXFfacmqBhuO18zLs8iWuxewR4dDpV/3x
        Cv4j0yCSg4Ff6QpvawFOFTpOWuQWOeLkbzP4YpLB2O6X4/lPrHArWCFEk9VcMt3OkmLVjrccH/7
        KpWRA26As2X5X6VO6ed6Ef0sCP5W6
X-Received: by 2002:a6b:e402:: with SMTP id u2mr2302148iog.45.1553016007266;
        Tue, 19 Mar 2019 10:20:07 -0700 (PDT)
X-Google-Smtp-Source: APXvYqychnKClekCymUTddHQ1zKfI9pFQEb4ApNtrA6+w85gHIVmz+IzWbLCiOLXnzUQuZXS/U/twA==
X-Received: by 2002:a6b:e402:: with SMTP id u2mr2302125iog.45.1553016006934;
        Tue, 19 Mar 2019 10:20:06 -0700 (PDT)
Received: from [128.101.106.63] (cs-bee-u.cs.umn.edu. [128.101.106.63])
        by smtp.gmail.com with ESMTPSA id m2sm1862492itc.42.2019.03.19.10.20.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Mar 2019 10:20:06 -0700 (PDT)
Subject: Re: [PATCH] usb: u132-hcd: fix potential NULL pointer dereference
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     pakki001@umn.edu, Colin Ian King <colin.king@canonical.com>,
        Jia-Ju Bai <baijiaju1990@gmail.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190314072713.20666-1-kjlu@umn.edu>
 <20190319135609.GA16254@kroah.com>
From:   Kangjie Lu <kjlu@umn.edu>
Message-ID: <440c18a2-aa7c-9253-0ad8-27ac0a0440d6@umn.edu>
Date:   Tue, 19 Mar 2019 12:20:05 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190319135609.GA16254@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/19/19 8:56 AM, Greg Kroah-Hartman wrote:
> On Thu, Mar 14, 2019 at 02:27:11AM -0500, Kangjie Lu wrote:
>> In case create_singlethread_workqueue fails, the fix notifies
>> callers the error to avoid potential NULL pointer dereferences.
>>
>> Signed-off-by: Kangjie Lu <kjlu@umn.edu>
>> ---
>>   drivers/usb/host/u132-hcd.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/usb/host/u132-hcd.c b/drivers/usb/host/u132-hcd.c
>> index 934584f0a20a..6d5b532b03f8 100644
>> --- a/drivers/usb/host/u132-hcd.c
>> +++ b/drivers/usb/host/u132-hcd.c
>> @@ -3203,6 +3203,8 @@ static int __init u132_hcd_init(void)
>>   		return -ENODEV;
>>   	printk(KERN_INFO "driver %s\n", hcd_name);
>>   	workqueue = create_singlethread_workqueue("u132");
>> +	if (unlikely(!workqueue))
> You only ever use unlikely/likely if you can actually measure the
> difference with and without it.  For stuff like this, it is not needed
> at all, and in fact, the compiler and CPU already know this type of
> thing, so it is going to be faster without it.
>
> And are you sure you properly unwound from anything that was
> created/initialized above these lines?
I didn't see what resources require release in this
case.
Given the existing error paths for usb_disabled() and
platform_driver_register(), returning -ENOMEM looks
like a consistent error handling. Let me know if it
isn't.


>
> thanks,
>
> greg k-h
