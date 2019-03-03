Return-Path: <SRS0=GAfv=RG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33A3DC43381
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 18:47:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F047E20835
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 18:47:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tg44EyDM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726636AbfCCSrf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Mar 2019 13:47:35 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42483 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726533AbfCCSrf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Mar 2019 13:47:35 -0500
Received: by mail-wr1-f67.google.com with SMTP id r5so3130358wrg.9
        for <linux-kernel@vger.kernel.org>; Sun, 03 Mar 2019 10:47:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=kDSJ5VV+d9TL5g5ut9vqvS7n2jj+8u/Q6KI8d2smF8s=;
        b=tg44EyDMgLeMNd37cn5rnYWuglfH84EfKqJ34AXQyWI3pUsKv9AdJiqvazglkwxfHs
         SeO5CGfSPLVbDoRT4kx/Tq1HlZiZ4gb27qilR0WKjH5fDNDG07El2PFg4g1Am9qcOit8
         GCkLmBaWDwd1YQzKZVAh08a/Kv3DKVuizKi6O17Jy1e83IoXS6b5RX7huKLG22yyrWDv
         LSWMLZ56x/wiqIgQ53J7uAB2Z4tccDrdEdbZj+edbCjAHAQWfyagFyhNxAkoc9EY8Nul
         sAnbyiXNsNMPP5QH33L0ZExIm86Wp1EKPDkt5+KiIgVAgUdw3/WyBfIjYzSRinjNbj6y
         jB7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kDSJ5VV+d9TL5g5ut9vqvS7n2jj+8u/Q6KI8d2smF8s=;
        b=q4kRcuj608gcZpTOqq91JV3B5qXM3eiinQ4QCbP5Wy9Kh3ThKnJjcTgwgNbgET4zxW
         ZiBwR9FK3BYEa+QA03kkmgqcxaXb7nZfD7YcuXXoOBLsUnKCb/SeBHcdpvV3dC3CYOSh
         fBjSqeoiNtg4DpZMT0DKm2Iot//Y8+ouQxHydMtCXN5NCHvsdsAvddJHweKO8DsnFZnY
         PB4aDrT7+FpRJpjgWeiLyN7mjVspzR4n1XmTz1tx9ZmltNqM30vHjm38gOySLt+DKCyP
         ltKyxBQ64opxDPnxKbR/Mz/WaUAC/YzY2vrdc6edurcStFDfmSjg3Twc/DFsEiQ2I1hk
         oZew==
X-Gm-Message-State: APjAAAWeMeoUf15I0dOnDw8Q3xcp5piAYsKXDnpdb018P/9shRZiDm0w
        m96uTd89SP3hWtPTy0iKRpeo7NGV
X-Google-Smtp-Source: APXvYqwmy2oVY8vjT5hzny73dK72amENKLVDecURiRGh0jL5WBMXb7GeEK9DFumNCbLZPly55kCQ2Q==
X-Received: by 2002:adf:d4c6:: with SMTP id w6mr10048660wrk.65.1551638853258;
        Sun, 03 Mar 2019 10:47:33 -0800 (PST)
Received: from ?IPv6:2003:ea:8bf1:e200:35a8:f48d:4b19:96c9? (p200300EA8BF1E20035A8F48D4B1996C9.dip0.t-ipconnect.de. [2003:ea:8bf1:e200:35a8:f48d:4b19:96c9])
        by smtp.googlemail.com with ESMTPSA id s5sm16125607wra.77.2019.03.03.10.47.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 03 Mar 2019 10:47:32 -0800 (PST)
Subject: Re: Fwd: [PATCH net-next 1/2] lib: string: add strreplace_nonalnum
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <981d965e-b25b-be2b-2067-07aec5eafc7a@gmail.com>
 <43eb3aad-0e0b-9019-dfe3-47f205607df0@gmail.com>
 <20190303175514.GA16636@kroah.com>
 <e55de1df-b70a-93b5-9f18-072392fa0657@gmail.com>
 <20190303181509.GE16636@kroah.com>
 <a833dcdd-6473-3426-cc80-405b3d100750@gmail.com>
 <20190303184111.GA28073@kroah.com>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Message-ID: <0724dc17-728c-4748-0fe8-8378d682928b@gmail.com>
Date:   Sun, 3 Mar 2019 19:47:29 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190303184111.GA28073@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03.03.2019 19:41, Greg Kroah-Hartman wrote:
> On Sun, Mar 03, 2019 at 07:32:53PM +0100, Heiner Kallweit wrote:
>> On 03.03.2019 19:15, Greg Kroah-Hartman wrote:
>>> On Sun, Mar 03, 2019 at 07:04:21PM +0100, Heiner Kallweit wrote:
>>>> On 03.03.2019 18:55, Greg Kroah-Hartman wrote:
>>>>> On Sun, Mar 03, 2019 at 06:47:32PM +0100, Heiner Kallweit wrote:
>>>>>> I submitted this through the netdev tree, maybe relevant for you as well.
>>>>>> See also here: https://marc.info/?t=155103900100003&r=1&w=2
>>>>>>
>>>>>> -------- Forwarded Message --------
>>>>>> Subject: [PATCH net-next 1/2] lib: string: add strreplace_nonalnum
>>>>>> Date: Sun, 3 Mar 2019 18:20:50 +0100
>>>>>> From: Heiner Kallweit <hkallweit1@gmail.com>
>>>>>> To: Florian Fainelli <f.fainelli@gmail.com>, Andrew Lunn <andrew@lunn.ch>, David Miller <davem@davemloft.net>
>>>>>> CC: netdev@vger.kernel.org <netdev@vger.kernel.org>
>>>>>>
>>>>>> Add a new function strreplace_nonalnum that replaces all
>>>>>> non-alphanumeric characters. Such functionality is needed e.g. when a
>>>>>> string is supposed to be used in a sysfs file name. If '\0' is given
>>>>>> as new character then non-alphanumeric characters are cut. 
>>>>>
>>>>> sysfs doesn't have any such requirements, it can use whatever you want
>>>>> to give it for a filename.
>>>>>
>>>> Even a slash?
>>>
>>> Is a slash an illegal character for a file to have?  It's up to the vfs
>>> to care about this, don't force random parts of the kernel to care :)
>>>
>>>> HWMON drivers is an example where such functionality occurs open-coded.
>>>
>>> Is that data coming from userspace or from a kernel driver?
>>>
>> Usually from a kernel driver. That's what
>> Documentation/hwmon/hwmon-kernel-api.txt says:
> 
> Usually?  So userspace can set the name?
> 
I'm not sure about that.

>> All supported hwmon device registration functions only accept valid device
>> names. Device names including invalid characters (whitespace, '*', or '-')
>> will be rejected. The 'name' parameter is mandatory.
>>
>> The hwmon subsystem has an own function to check for such characters:
>> hwmon_is_bad_char()
> 
> It looks like hwmon is the only thing that cares about this then, why
> do you want to make this a common function?
> 
In phylib we have a similar issue, sysfs is broken if a PHY driver name
includes a slash, typically if some driver author uses "10 / 100 Mbit"
or similar.
IIRC for HWMON there has been some longer discussion about how to deal
with naming, I'd be curious to hear Guenter's opinion on the topic.

> thanks,
> 
> greg k-h
> 
Heiner
