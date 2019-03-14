Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C31CC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 10:54:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0983C20449
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 10:54:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="gR3ld2O5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727415AbfCNKyK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 06:54:10 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:40957 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726693AbfCNKyK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 06:54:10 -0400
Received: by mail-lj1-f194.google.com with SMTP id x9so356559ljc.7
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2019 03:54:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=xMrqFaB9GZ3OesloTRBWPhBkq/c+AxqS4lz7v4TpmT0=;
        b=gR3ld2O5NzqBPOFW9rgNpM4l89Nq9YCSqtc2ROcOzDIXhcbebXoCw/lR3BMzBNY3gP
         QiytzCfdp1JJAeI0D+jgnU/qw6lQp2hBGT/jIhnlfhlG9pr2q7cJrU7RQL3ta9UTVshV
         /Sv2apm5AZgq3b88qW9ql2234nob2wVwKWkA4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xMrqFaB9GZ3OesloTRBWPhBkq/c+AxqS4lz7v4TpmT0=;
        b=Xp0j+y6zv63KHRzMj+f2SKP7v7eFRWqEVliCkTk8bgoUj9GfkfXYZ8lmvom75rcYSL
         bgwJoknTCbFo0zJ3W3Y95P3GUaDJ9vA/p2xiHwJQIBvzmRnPCzIDXr95na9+f83woPLV
         M8x/6fZ6nyYJE+xZf3ITxkO8f81H2x942ia/ajyyAmhgXoaO+oYg6kYvjOyvEYfKuvap
         RQEnV1TxMJslFHAsUuUbQLAaGjy4yNqd/amBZozUAUYZ6KXbfvriord+Oo8in4xt7uNc
         N0nt4FqxRTpmg8zTfCrAGMU4+qu0xKGHI9YMqc70bVU2CLKWtnTXcKLGzDHz5aZPveUK
         ZtHw==
X-Gm-Message-State: APjAAAWCZaDOFUhdw+PC3/hsxmwqoVypuFb9cvtZVHBsH7XmA4EVnUzP
        GY49OlejKomYc83tjy3AWfsUnw==
X-Google-Smtp-Source: APXvYqyJzE9q61s7DXGQaW5dDvxEc9ysTJPXvkjp3C7sIJg7nXePE+AwOxRtULrAZxXEvUeoC3lQ9w==
X-Received: by 2002:a2e:2202:: with SMTP id i2mr25358278lji.170.1552560848126;
        Thu, 14 Mar 2019 03:54:08 -0700 (PDT)
Received: from [172.16.11.26] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id u2sm221796lfm.83.2019.03.14.03.54.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Mar 2019 03:54:07 -0700 (PDT)
Subject: Re: [PATCH 1/4] leds: netdev trigger: use memcpy in device_name_store
To:     Pavel Machek <pavel@ucw.cz>
Cc:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-leds@vger.kernel.org
References: <20190311144227.GA4404@amd>
 <20190313202615.22883-1-linux@rasmusvillemoes.dk>
 <20190313202615.22883-2-linux@rasmusvillemoes.dk>
 <20190314101419.GA14455@amd>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <9324dc3c-a9dd-e179-6fc5-17b2fdaab74b@rasmusvillemoes.dk>
Date:   Thu, 14 Mar 2019 11:54:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190314101419.GA14455@amd>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/03/2019 11.14, Pavel Machek wrote:
> Hi!
> 
>> If userspace doesn't end the input with a newline (which can easily
>> happen if the write happens from a C program that does write(fd,
>> iface, strlen(iface))), we may end up including garbage from a
>> previous, longer value in the device_name. For example
>>
>> # cat device_name
>>
>> # printf 'eth12' > device_name
>> # cat device_name
>> eth12
>> # printf 'eth3' > device_name
>> # cat device_name
>> eth32
>>
>> I highly doubt anybody is relying on this behaviour, so switch to
>> simply copying the bytes (we've already checked that size is <
>> IFNAMSIZ) and unconditionally zero-terminate it; of course, we also
>> still have to strip a trailing newline.
> 
>   char device_name[IFNAMSIZ];
> 
> Ok, good catch reporting the bug, but are you sure the fix is right?
> 
> AFAICT the design is that device_name does _not_ have to be zero
> terminated, and your fix incorrectly limits the size of device_name.

Yes, I'm sure.

/**
 *      dev_valid_name - check if name is okay for network device
 *      @name: name string
 *
 *      Network device names need to be valid file names to
 *      to allow sysfs to work.  We also disallow any kind of
 *      whitespace.
 */
bool dev_valid_name(const char *name)
{
        if (*name == '\0')
                return false;
        if (strnlen(name, IFNAMSIZ) == IFNAMSIZ)
                return false;

so no netdevice name has a string length > 15 (IOW, there must be a nul
byte within the first 16 bytes of name). Also note all the places a
net_device->name is printed with a simple %s, so they are definitely
always 0-terminated.

Moreover, I'm actually not limiting anything more than was already done;
we already reject any input from userspace >= 16 bytes. I'm simply
ensuring that we're never confused by leftover garbage.

>> --- a/drivers/leds/trigger/ledtrig-netdev.c
>> +++ b/drivers/leds/trigger/ledtrig-netdev.c
>> @@ -122,7 +122,8 @@ static ssize_t device_name_store(struct device *dev,
>>  		trigger_data->net_dev = NULL;
>>  	}
>>  
>> -	strncpy(trigger_data->device_name, buf, size);
>> +	memcpy(trigger_data->device_name, buf, size);
>> +	trigger_data->device_name[size] = '\0';
> 
> I'd do = 0 for consistency with code below.

I'd rather the other way around :) but yeah, let's just be consistent.
I'll fix in next version.

> I believe the strncpy() is right to use here, but code should be
> modified so that zero-termination is not required.

So, I believe the above should convince you that strncpy is wrong. Or
rather, strncpy is really just a convoluted memcpy: the userspace input
doesn't contain a nul among the size bytes [1], so the "copy all the
bytes, but don't nul-terminate" semantics of strncpy kick in - which is
often a security bug, but the code is such that the zero at
device_name[15] (because it was originally kzalloc'ed) is never
overwritten. So in theory, we could keep strncpy and just add the
nul-termination, but the str* prefix is very misleading (which is
probably why the bug happened in the first place).

[1] And if it did, the "zero the rest of the output buffer" semantics
kick in. That's functionally equivalent to my memcpy() + write one nul
byte, since nothing after that first nul byte in device_name would ever
be inspected.

Rasmus
