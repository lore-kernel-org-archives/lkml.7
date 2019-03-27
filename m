Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AEB0C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 13:57:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A8B82087C
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 13:57:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="QrH9P8Tb";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="fuo8Otpg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728637AbfC0N5m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 09:57:42 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:34482 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728177AbfC0N5m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 09:57:42 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id A9CFD60E41; Wed, 27 Mar 2019 13:57:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553695061;
        bh=Wn6vBSnHGe7dotbUAX3aczoCqcXh2t7Qa7LW/BmHVs8=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=QrH9P8Tb5LkVkawgS8c5aeiTCImZf/Wpz3a+1zvjlhG11MqSHzKzOfPmxgBOk7dCS
         +h4r269J/QfoKAPZZ0k4z3Sd9XHwc9E6hApEWeB1hEAm7KR7oPfv+ABMGQb/+l028D
         qccO5/yuJTUs7LobJaFj+6ey1SzzM2Zq5OM0Iuc8=
Received: from [10.204.79.83] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id F2769609F3;
        Wed, 27 Mar 2019 13:57:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553695060;
        bh=Wn6vBSnHGe7dotbUAX3aczoCqcXh2t7Qa7LW/BmHVs8=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=fuo8OtpgclrxxCdT6mhGodvYZoV0ENxvDFU1HZrddRhWh8Ep/0UHU1fBDB6yvugE7
         xTwAoTi8YcURsQ/x5RT+jDHeOP9dGf/Tu+5GmvKJ/hoTHmxZZlBuOP5Ys1lk5pM4uU
         ffaGWm3dqXQegJDxwNCwcmDmQsUJWdIPMsAgeqtE=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org F2769609F3
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mojha@codeaurora.org
Subject: Re: [PATCH] usb: u132-hcd: fix potential NULL pointer dereference
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kangjie Lu <kjlu@umn.edu>
Cc:     pakki001@umn.edu, Colin Ian King <colin.king@canonical.com>,
        Jia-Ju Bai <baijiaju1990@gmail.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190319135609.GA16254@kroah.com>
 <20190319173407.7279-1-kjlu@umn.edu> <20190326044132.GA19677@kroah.com>
From:   Mukesh Ojha <mojha@codeaurora.org>
Message-ID: <484452ec-d3a3-f663-158c-1308c297b8d1@codeaurora.org>
Date:   Wed, 27 Mar 2019 19:27:30 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.0
MIME-Version: 1.0
In-Reply-To: <20190326044132.GA19677@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please change the patch version in subject while sending patch.

On 3/26/2019 10:11 AM, Greg Kroah-Hartman wrote:
> On Tue, Mar 19, 2019 at 12:34:06PM -0500, Kangjie Lu wrote:
>> In case create_singlethread_workqueue fails, the fix notifies
>> callers the error to avoid potential NULL pointer dereferences.
>>
>> Signed-off-by: Kangjie Lu <kjlu@umn.edu>


Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>

-Mukesh

>> ---
>> removed "unlikely"
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
>> +	if (!workqueue)
>> +		return -ENOMEM;
>>   	retval = platform_driver_register(&u132_platform_driver);
>>   	return retval;
> if platform_driver_register() fails, shouldn't you clean up the
> workqueue?  That can be a separate patch, that's not your fault here :)

I have taken care of it.

https://lore.kernel.org/patchwork/patch/1054800/



>
> thanks,
>
> greg k-h
