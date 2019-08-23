Return-Path: <SRS0=31nU=WT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FE39C3A5A4
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 19:48:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F06CB204EC
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 19:48:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Tbb+Qdzz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436882AbfHWTsf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Aug 2019 15:48:35 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:42177 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391525AbfHWTse (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 15:48:34 -0400
Received: by mail-pg1-f194.google.com with SMTP id p3so6298583pgb.9
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2019 12:48:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=mmvH/MiPBr+v/9h/NqmKdTN+9qaz3FZdG5BKqSNbGjY=;
        b=Tbb+QdzzrmYFKAD3GK9vLZkK/NM8omZ6WAKaHjyjKlIXmpyaUZNzp3xGyJygmI+m+P
         EbRS/GTRurPgwAA93u1mgXPaA95I7A50nyQ9mVEYWX1ICugwFitTt2NFpRb9jbXrsYEV
         SqQZ5gOgGEGKfbmjWSF9Ci8mtCOyazf4LFrp8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=mmvH/MiPBr+v/9h/NqmKdTN+9qaz3FZdG5BKqSNbGjY=;
        b=hWGMu0f6sXBLDNa3gTi2sIhsB7CYzuP2nY9ytNhY0Z8ZCTCW1YkAzXII2qP98k32Qc
         boi9dt+hNlqWdkJ7RhomG13b/kD/JzdERlHjR43jOaov9clF7IHmn6s8boFmbW9UcrnX
         Iqr3Vpux7YrPfYIgnZYadOAuitcEAjnxIy82U/hjTz+uYiaWn9uIlX95AW9oxczeq2kb
         Acq/3Sr9/7Ci884gcGSJqF/6C09PkERpZT5tpWPXWwaQsoiZm1VMGjA9cWm2EB/5QIa8
         vuhVqfqdSjeLLpucaVZ1ALTx5gG0/qQnt3lmpl2WewMKINFKyWnNM8cS5mYsrPfu4ZjD
         aWRg==
X-Gm-Message-State: APjAAAXUmwbAblNOxm6BPvP8kQ+r6aM5Hk+JU3DjWN4HjE+j7zvWvZtj
        aOT9HdF3hngzmwFdt26ybSDFRw==
X-Google-Smtp-Source: APXvYqy4Vu/BUixQkOsIGmHqPmpJ6AQ7tioo+6e6JH0ZmrWQBVeswubKUAMb+I6GuTOM8zvTUHfooA==
X-Received: by 2002:a63:524f:: with SMTP id s15mr5160553pgl.2.1566589713570;
        Fri, 23 Aug 2019 12:48:33 -0700 (PDT)
Received: from [10.136.13.65] ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id e6sm3256802pfn.71.2019.08.23.12.48.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Aug 2019 12:48:32 -0700 (PDT)
Subject: Re: [PATCH 3/3] firmware: add mutex fw_lock_fallback for race
 condition
To:     Takashi Iwai <tiwai@suse.de>, Luis Chamberlain <mcgrof@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Shuah Khan <shuah@kernel.org>, bjorn.andersson@linaro.org,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        Olof Johansson <olof@lixom.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Colin Ian King <colin.king@canonical.com>,
        Kees Cook <keescook@chromium.org>,
        linux-kselftest@vger.kernel.org
References: <20190816000945.29810-1-scott.branden@broadcom.com>
 <20190816000945.29810-4-scott.branden@broadcom.com>
 <20190819053937.GR16384@42.do-not-panic.com>
 <16823ee6-c52a-b3b5-caed-79c00772fa68@broadcom.com>
 <20190820012655.GU16384@42.do-not-panic.com> <s5hd0gwrx4j.wl-tiwai@suse.de>
From:   Scott Branden <scott.branden@broadcom.com>
Message-ID: <54ccd717-7749-3c45-320f-1c285e027d36@broadcom.com>
Date:   Fri, 23 Aug 2019 12:48:30 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <s5hd0gwrx4j.wl-tiwai@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2019-08-23 3:31 a.m., Takashi Iwai wrote:
> On Tue, 20 Aug 2019 03:26:55 +0200,
> Luis Chamberlain wrote:
>> On Mon, Aug 19, 2019 at 09:19:51AM -0700, Scott Branden wrote:
>>> To be honest, I find the entire firmware code sloppy.
>> And that is after years of cleanup on my part. Try going back to v4.1
>> for instance, check the code out then for an incredible horrific sight :)
>>
>>> I don't think the cache/no-cache feature is
>>> implemented or tested properly nor fallback to begin with.
>> I'm in total agreement! I *know* there must be holes in that code, and I
>> acknowledge a few possible gotchas on the commit logs. For instance, I
>> acknowledged that the firmware cache had a secondary purpose which was
>> not well documented or understood through commit e44565f62a720
>> ("firmware: fix batched requests - wake all waiters"). The firmware
>> cache allows for batching requests and sharing the same original request
>> for multiple consecutive requests which *race against each other*.
>> That's when I started having my doubts about the architecture of the
>> firmware cache mechanism, it seemed too complex and perhaps overkill
>> and considered killing it.
>>
>> As I noted in that commit, the firmware cache is used for:
>>      
>> 1) Addressing races with file lookups during the suspend/resume cycle by
>> keeping firmware in memory during the suspend/resume cycle
> Right, this one is the significant need.  And currently the fw loader
> core takes a complicated approach as:
>
> - Store firmware name string in devres for each firmware
> - Upon suspend, loop over all devices and associated firmware names,
>    create a list, then loop over the list for loading the firmware
>    files before sleeping.
> - Upon resume, release the firmware files that have been loaded at
>    suspend in a delayed manner.
>
> So we have different level of lists there, which make the code quite
> hard to understand.
>
> The reason of the above approach is because we didn't know which
> device driver would need the firmware at resume, so basically we do
> cache for all devices.  Maybe it'd better to look for the exact
> drivers that require the firmware at resume, and handle only such
> ones instead of catch-all approach.

Yes, that would be better.  Or remove this cache mechanism entirely

and provide some helper functions of some sort to the limited

drivers that actually require such mechanism.

>
> OTOH, I find it's not bad to keep the loaded firmware file names per
> device and expose e.g. via sysfs.  Currently we have no way to look at
> which firmware files have been loaded afterwards; the only way to see
> it is enabling some debug option and read through kernel messages.
> (FWIW, I stumbled on this problem since I wanted to provide the split
>   kernel-firmware package on SUSE distro, and let the installer decide
>   which package to pick up.)
>
>> 2) Batched requests for the same file rely only on work from the first
>> file lookup, which keeps the firmware in memory until the last
>> release_firmware() is called
> IMO, this feature can be omitted if it makes things too complicated.
> I guess it were added because we handle the fw caching in anyway.
> There isn't a big need for this due to performance.  If the
> performance matters, such driver should re-use its own firmware by
> itself.

Any simplifications would be appreciated.

I sure don't understand what the code is trying to do.

>
> (snip)
>>> 3) I have a driver that uses request_firmware_into_buf and have multiple
>>> instances of the driver
>> Cool, is the driver upstream?
>>
>>> loading the same firmware in parallel.  Some of the data is not read
>>> correctly in each instance.
>> Makes perfect sense considering the lack of testing I noted.
>>
>>> I haven't yet to reproduce this issue with the firmware test
>> That's because of batched firmware request mechanism.
>>
>>> but currently
>>> have a mutex around the entire
>>> call to request_firmware_into_buf in our driver.
>> I will take a look at this now.
>>
>>> Perhaps it is better at this point to add a mutex in
>>> request_firmware_into_buf to make is entirely safe?
>> No, that is not sufficient, although it would also solve the
>> issue.
> The mutex for request_firmware_into_buf() doesn't sound like a good
> approach.  Basically the direct fw loading should work in parallel
> for the same firmware file.  We might have some bug wrt cache stuff,
> but it can be fixed properly.
>
> However, the fw loading in fallback mode can't run in parallel for
> the same file, per design -- no matter whether cached or not.
> So, if any, we'd need put a mutex around the fallback loader code.
> And, the mutex should be rather per device, not a global one.

Sure, whatever solves the issue.  All I wish to do is read

part of file into a buffer specified.

>
> Or we may trick it by appending the second parallel caller into the
> same wait queue, but the code will be more complex, so I don't think
> worth for it.
>
>
> thanks,
>
> Takashi
