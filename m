Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEA16C04A6B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 14:53:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81561205ED
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 14:53:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557154426;
	bh=DQalAwsQuS1MPX2uoEtNnTNau1g2oBTncVKLtCehE6g=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=OpZ7n3UZt4eNVHxyVxZp/gyncqAyGMQilmS1Me2YsdCOMzoPIePaAxiXWFpsw2264
	 hzoDnao8HN33sLEkfTD1wyCKcUYPIImVodwI7oDOd1+CQPXIvyzd0GBP5lrRsbP2Ym
	 yCQhO5Cwih/PetyTzXYFIuZgagemJHNQDNTnbIEc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729116AbfEFOxo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 10:53:44 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:54378 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729286AbfEFOrS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 10:47:18 -0400
Received: by mail-it1-f195.google.com with SMTP id a190so20668253ite.4
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2019 07:47:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=DpOTHTN61DNh0jzA3oEB6+Erb5rOcYNfwyvkegv2Kn0=;
        b=YHXOsoSNPP+91o/8xFKA+1I+O1WnTJI+Pr6esCtIaRNNgKIicPD2Gh0yARBvQhzH0Y
         BakP/wZbniH9i/FfRVNfXkbYa0M8K+BKP5yMHcKdDJoWja4VJaCdSZHiG1MuGKQCDZ64
         ph3u/3UFn0JyCX0VYhubw5krtx5184RP3j64o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DpOTHTN61DNh0jzA3oEB6+Erb5rOcYNfwyvkegv2Kn0=;
        b=VKP8v5FE8HTBsduGgOA8rK06MEZOlXqZIyKg+JaQBaNGcEgZDLBR7ybljvBCXcpxcx
         8fb6ARaR4X0hk5bHx7GWF5uNFU3YeaaD4tJrx8avln+mGJWgx5el+1xksot9qa8XG8tb
         gTbGr5SPYt/6paSjdcljj6figcMBKJ6GPEx2w2h+EBBHE2EYI2AW5urfxZ2rldudUvI0
         jh0MdwkuO8pWMr/JF9kdiq1BNj6t9GZI/sOBm9mDJmfzzjiueETIo486FgUoT4lWraGF
         j1SeD0nNZyPJyV94yRHNgQ8Fm/TzWHIjCiXMzygOY1GTyPif4De/csivKfaRiCZfdyEZ
         mfZw==
X-Gm-Message-State: APjAAAUw6ZSf2qHhslWvf80e+bolglln/4aWvgn8oCaABuMp94iOTgmX
        i6H4Ov0buI487DMafKMxfkXIwPc1N1U=
X-Google-Smtp-Source: APXvYqxKSTCiJxdwYirrcVpxqxAb++n6X86LP1uUdw7zskem8MIedd+9DqDZSsQjNfBe0xXVMemvsw==
X-Received: by 2002:a05:660c:799:: with SMTP id h25mr18380320itk.85.1557154037724;
        Mon, 06 May 2019 07:47:17 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id q125sm3478606iod.88.2019.05.06.07.47.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 May 2019 07:47:16 -0700 (PDT)
Subject: Re: [PATCH] selftests: add sleep between detach and usbip list -l
To:     Greg KH <greg@kroah.com>
Cc:     valentina.manea.m@gmail.com, shuah@kernel.org,
        linux-usb@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20190502194740.15344-1-skhan@linuxfoundation.org>
 <20190505091356.GB25646@kroah.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <ed0a3115-ee5a-97b6-b69c-073c9595d734@linuxfoundation.org>
Date:   Mon, 6 May 2019 08:47:15 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190505091356.GB25646@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/5/19 3:13 AM, Greg KH wrote:
> On Thu, May 02, 2019 at 01:47:40PM -0600, Shuah Khan wrote:
>> Add a sleep between detach and check for exportable devices to avoid
>> the following segfault from libc-2.27.so
>>
>> [ 6268.136108] usbip[5565]: segfault at 0 ip 00007f2a947bddfd sp 00007ffd1a8705e8 error 4 in libc-2.27.so[7f2a94703000+1e7000]
>>
>> Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
>> ---
>>   tools/testing/selftests/drivers/usb/usbip/usbip_test.sh | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/tools/testing/selftests/drivers/usb/usbip/usbip_test.sh b/tools/testing/selftests/drivers/usb/usbip/usbip_test.sh
>> index 128f0ab24307..beacf24a8df7 100755
>> --- a/tools/testing/selftests/drivers/usb/usbip/usbip_test.sh
>> +++ b/tools/testing/selftests/drivers/usb/usbip/usbip_test.sh
>> @@ -171,10 +171,14 @@ echo "Detach invalid port tests - expect invalid port error message";
>>   src/usbip detach -p 100;
>>   echo "=============================================================="
>>   
>> +# let detach complete. Avoid segfaults from libc-2.27.so
>> +sleep 3;
> 
> That feels very "arbitrary", why do we "know" it will take at most 3
> seconds?  I guess there's not much else we can do here except maybe
> somehow watch sysfs until the device is really gone?
> 

Yeah. Number 3 is somewhat arbitrary. It helps the host process the
detach request from the client and update the sysfs. Detach returns
as soon as client side is done, and the test is running the next
command on the host side. If I were run these commands manually, it
gives enough settling time. I am looking for a quick way to allow
settling time in this automated test.


thanks,
-- Shuah
