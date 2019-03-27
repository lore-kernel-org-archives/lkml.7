Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 735D3C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 21:20:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37A7620700
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 21:20:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gp7f50xN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727928AbfC0VUS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 17:20:18 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:33424 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726891AbfC0VUR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 17:20:17 -0400
Received: by mail-lj1-f194.google.com with SMTP id f23so15762983ljc.0;
        Wed, 27 Mar 2019 14:20:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=dgBgvHD4VaNUc6w7Qklt9Uw5siX01DXVAa2M0l9n95s=;
        b=Gp7f50xNLzqzsxK3+ruWUvOJU/1ysiIp2d5TUcl8qYUBGG5SygIDE+OHtQJsvrU1aF
         D1UU9wxXIziuYFDc7/KN9HzEiFlURYBdXUvgf54iBkyRtVf9Xur2dHm4bqmBGI3o6bXu
         c/43/5nqOWmo0pL1k981UYEkINi5GBhlgaXBB9vnvK1I0zAG9CSppXOvAY8y9mwf0HDA
         Y7z5n2OZlqU3/yNaJELCGb5N5na1Pi5V8lcyZ96nb3078OKnMgg5wt+p35erDC/5NixA
         2edyRZrPYf+SmgaRpJUgGFvdSXxntjx2fAwepv0RvmUxaCGRacNjrweL/gGC9Z88GK0h
         a1gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dgBgvHD4VaNUc6w7Qklt9Uw5siX01DXVAa2M0l9n95s=;
        b=fCmnnVjH/A3j9nW8gQw3QxDz5mIM0sW6vyum3y/gDVa5wZluzZnTS0iEiBewx4udtd
         27FbHquFv1ACSulspuoV0sl+67dx2HXhw2YvD3dJmjLcS/CI+7JtBZWHfKCnTduDOKB2
         hHt0siBXqELtYaje4Vcic9RkVu075stR7Ne75DJwsfUToDcEVfkEg7C//chl5QlIB4ik
         zNbU53Yb6nChTAFNFu4J0oaZ4emifpstbEXG70hmVjK9l6P606kkKlxP5GI3dNyqz/yN
         FtLUJwl0A8ZGfgEuxTaoowBbfX09iqzY2K4FRJzRq9L7oy/ISPd3Qm/bIV0nFx7GYBya
         x00Q==
X-Gm-Message-State: APjAAAUI0oL6F2d7RJX2sYDdi7HNtc8VK5cRV43MD4+a9Z7ybURMROYn
        /tOgV5ZFWcWvvIOBFofo0+mCrIqN
X-Google-Smtp-Source: APXvYqz4NNBSw5900iNSFzrSFQ7fbGMuyBbTUKyidgM03marLE3iRMbslYFBkpvRvfjEIFDNqCByYA==
X-Received: by 2002:a2e:968c:: with SMTP id q12mr20720293lji.36.1553721614616;
        Wed, 27 Mar 2019 14:20:14 -0700 (PDT)
Received: from [192.168.1.19] (ckh73.neoplus.adsl.tpnet.pl. [83.31.83.73])
        by smtp.gmail.com with ESMTPSA id s64sm4969361lje.49.2019.03.27.14.20.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Mar 2019 14:20:13 -0700 (PDT)
Subject: Re: [PATCH v2 1/6] leds: netdev trigger: use memcpy in
 device_name_store
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Pavel Machek <pavel@ucw.cz>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-leds@vger.kernel.org
References: <20190313202615.22883-1-linux@rasmusvillemoes.dk>
 <20190314140619.3309-1-linux@rasmusvillemoes.dk>
 <20190314140619.3309-2-linux@rasmusvillemoes.dk>
 <987c3e60-edb3-44f0-be28-434c70bb8659@gmail.com>
 <d1fccd75-c48b-d585-1170-1c1b76e1e098@rasmusvillemoes.dk>
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
Message-ID: <21193aab-7880-d116-64e8-dd08afe5a47f@gmail.com>
Date:   Wed, 27 Mar 2019 22:20:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <d1fccd75-c48b-d585-1170-1c1b76e1e098@rasmusvillemoes.dk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/27/19 4:26 PM, Rasmus Villemoes wrote:
> On 26/03/2019 20.53, Jacek Anaszewski wrote:
>> Hi Rasmus,
>>
>> Thank you for the patch.
>>
>> On 3/14/19 3:06 PM, Rasmus Villemoes wrote:
>>> If userspace doesn't end the input with a newline (which can easily
>>> happen if the write happens from a C program that does write(fd,
>>> iface, strlen(iface))), we may end up including garbage from a
>>> previous, longer value in the device_name. For example
>>>
>>> # cat device_name
>>>
>>> # printf 'eth12' > device_name
>>> # cat device_name
>>> eth12
>>> # printf 'eth3' > device_name
>>> # cat device_name
>>> eth32
>>>
>>
>> Added tag:
>>
>> Fixes: 06f502f57d0d ("leds: trigger: Introduce a NETDEV trigger")
>>
>> and applied to the fixes-for-5.1-rc3 branch.
>>
> 
> You're stripping lines beginning with #. This is the commit in -next:
> 
> 
> commit 09466021a80c926aa7de68e5162bdfea2a117483
> Author: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> Date:   Thu Mar 14 15:06:14 2019 +0100
> 
>      leds: netdev trigger: use memcpy in device_name_store
> 
>      If userspace doesn't end the input with a newline (which can easily
>      happen if the write happens from a C program that does write(fd,
>      iface, strlen(iface))), we may end up including garbage from a
>      previous, longer value in the device_name. For example
> 
>      eth12
>      eth32
> 
> which is entirely useless and confusing. Please fix this before it
> actually hits mainline. And you may want to look into "git commit
> --cleanup" and/or "git config commit.cleanup" (scissors is much better
> than the default strip).

Thanks for the heads-up. I must admit I'm hitting into that for the
first time. After "git am" it was all OK, but it got screwed up after
"git rebase -i". And having "commit.cleanup = scissors" set globally all
the time is annoying if one extensively uses interactive rebase for
rewording commit messages. It entails the need for manual removal of
the whole stuff that appears then after actual commit message prepended
with "#" comment characters.

This is probably the reason why people use often other characters
for command prompt (see the other fix for ledtrig-netdev). Note that, 
while it is of no so great importance for mainline, when people cherry
pick such patch to their out-of-tree repositories and then rebase, they
hit into the same issue.

-- 
Best regards,
Jacek Anaszewski
