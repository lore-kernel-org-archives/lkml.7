Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DDC4C04A6B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 15:18:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0749205C9
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 15:18:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557155885;
	bh=hXF5sMm+J+SLI4BOSS6PkmcTtKR/2EwVYeRZ89Dqmmc=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=t9KwQ4jwomLSG8JJh/g1tQNVwbWBGPJ2vrDonx6T5f7AtH+rVx9m8FJy0PEqFtwf2
	 ukXp+p2f0yoYnxbO/H4f83/Bw9+YWdLAomZaJfupOgGJfBSPi5/gAlQKLnNfsfZrUI
	 4hoL0N8NnVEl5ORP8B4STgGzHjAgyig3e44F0PVE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726866AbfEFPSD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 11:18:03 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:38038 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726229AbfEFPSD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 11:18:03 -0400
Received: by mail-it1-f195.google.com with SMTP id q19so20442781itk.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2019 08:18:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+pQydGOg4OcYDbNXBsQRT4Lvzf+ksqu8jt9++8oyYp8=;
        b=AZ9OASulQopNJAz/g6esfXYRGTB3j58sn9wd3Ww8ryDcz06MhO9qArg58Dib9dxzuI
         JHYxRfgi3aSjdur/8P5G5FjZzIndaDKGaVe5QlWe93g8xCeIhxs+lJpwgDLlg57cZnor
         MknrBcs0iOB3+Dh38qnXZKsEm5zx8YDk7kow0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+pQydGOg4OcYDbNXBsQRT4Lvzf+ksqu8jt9++8oyYp8=;
        b=T8yXAJupjZEMM/BryGP5qz/ZjCFbdqO3hEZp86opiiui8FMa1GuktY4FN/E+XJFn6y
         jKPcdLKJLM8G0QNe149GuMz+EOQD3y//yJ6Ax2XBPw+x99Ta7a6rP2fjEKnl3xS80or/
         FlAX0hFyqXcpMXnKbI3kFD2TU5a+354dOstCiAv1nPPjFi1BctNzr7yk9Y5YzSAPUe7w
         QeMEEADAee29jRxqaXGh2A7bkna6ym7roQw0kXRhwFVx3/cQEwy0+M/dWJ35tm8HuYt8
         1KB7VtiEbPGIWu1TTgjVWMwmjdXfGbfdMYElqqAyu4beVtIBwCqkpyEyREkCRrcnz4pr
         vt2A==
X-Gm-Message-State: APjAAAV6TM1NblWEyEK71CppaVA85b8FyPxiwbaEM2UfZCF+CnsPNFMj
        nc3Vhj6NtneI+AsCV86AlhpuPQ==
X-Google-Smtp-Source: APXvYqyPd66l+UgLY2N+cihkt4KtQKbB3decdpUkRANIYDmWD7+aar3uFt3aYwaCclD5MjkbHOTi1A==
X-Received: by 2002:a05:660c:111:: with SMTP id w17mr17449225itj.62.1557155882202;
        Mon, 06 May 2019 08:18:02 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id i72sm8735324itc.11.2019.05.06.08.18.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 May 2019 08:18:01 -0700 (PDT)
Subject: Re: [PATCH] selftests: add sleep between detach and usbip list -l
To:     Greg KH <greg@kroah.com>
Cc:     valentina.manea.m@gmail.com, shuah@kernel.org,
        linux-usb@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20190502194740.15344-1-skhan@linuxfoundation.org>
 <20190505091356.GB25646@kroah.com>
 <ed0a3115-ee5a-97b6-b69c-073c9595d734@linuxfoundation.org>
 <20190506151540.GA12755@kroah.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <b1bf8113-75a1-40dc-daf9-4411c3e87cfe@linuxfoundation.org>
Date:   Mon, 6 May 2019 09:18:00 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190506151540.GA12755@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/6/19 9:15 AM, Greg KH wrote:
> On Mon, May 06, 2019 at 08:47:15AM -0600, Shuah Khan wrote:
>> On 5/5/19 3:13 AM, Greg KH wrote:
>>> On Thu, May 02, 2019 at 01:47:40PM -0600, Shuah Khan wrote:
>>>> Add a sleep between detach and check for exportable devices to avoid
>>>> the following segfault from libc-2.27.so
>>>>
>>>> [ 6268.136108] usbip[5565]: segfault at 0 ip 00007f2a947bddfd sp 00007ffd1a8705e8 error 4 in libc-2.27.so[7f2a94703000+1e7000]
>>>>
>>>> Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
>>>> ---
>>>>    tools/testing/selftests/drivers/usb/usbip/usbip_test.sh | 4 ++++
>>>>    1 file changed, 4 insertions(+)
>>>>
>>>> diff --git a/tools/testing/selftests/drivers/usb/usbip/usbip_test.sh b/tools/testing/selftests/drivers/usb/usbip/usbip_test.sh
>>>> index 128f0ab24307..beacf24a8df7 100755
>>>> --- a/tools/testing/selftests/drivers/usb/usbip/usbip_test.sh
>>>> +++ b/tools/testing/selftests/drivers/usb/usbip/usbip_test.sh
>>>> @@ -171,10 +171,14 @@ echo "Detach invalid port tests - expect invalid port error message";
>>>>    src/usbip detach -p 100;
>>>>    echo "=============================================================="
>>>> +# let detach complete. Avoid segfaults from libc-2.27.so
>>>> +sleep 3;
>>>
>>> That feels very "arbitrary", why do we "know" it will take at most 3
>>> seconds?  I guess there's not much else we can do here except maybe
>>> somehow watch sysfs until the device is really gone?
>>>
>>
>> Yeah. Number 3 is somewhat arbitrary. It helps the host process the
>> detach request from the client and update the sysfs. Detach returns
>> as soon as client side is done, and the test is running the next
>> command on the host side. If I were run these commands manually, it
>> gives enough settling time. I am looking for a quick way to allow
>> settling time in this automated test.
> 
> Ok, you might want to document that you know it's a random number :)
> 

Okay. Will do. I will send v2. :)

thanks,
-- Shuah
