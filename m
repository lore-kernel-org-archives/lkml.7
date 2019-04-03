Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ABD2C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 17:45:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B56C206DF
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 17:45:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vcliyMVw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726607AbfDCRpO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 13:45:14 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:51644 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726151AbfDCRpO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 13:45:14 -0400
Received: by mail-wm1-f68.google.com with SMTP id 4so8393059wmf.1;
        Wed, 03 Apr 2019 10:45:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=JLkGukoqV2ks5xZqU5AF00WrxKiuH39UwFo2hmZwP5U=;
        b=vcliyMVw3pd1vox/os+jyYFmnm3a4T2XDLTwdU5MmeD/PBKRKbCAh3yG+EgUM4eQkh
         UlOBVWbr8PeDHfDZ9imIH8AOUVzJL0Lw589dZhXtVb/keK0zoirSZYFKCk6NYF1FdxUH
         5ooiXIzAA1tjUZgj5/2r4tVdnWo+/lX+9fnhNU5RFyXV0FvDK8TFhdj6DUjUcCaE/BLc
         za5qhSMNYB5xRgVjNCOiqF/Q5GUUS7coBqKq0gveT63ETV9u77nzwJlqdDJQRuXsrbBx
         8XVrGM5obYaDrkvSxIjDGWTG1grOl9nu8kg+IO/DmlOuNXVS2xnIH+691sdKCI2jbkE1
         TnZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JLkGukoqV2ks5xZqU5AF00WrxKiuH39UwFo2hmZwP5U=;
        b=n0Jgo/eX/GGULJJs6K0fY1wFy358JNBzv5HmWEK1aRcc0dffFZQ4gH31GgtoEH29/y
         UYbvSLbvLy1fFYVqsW9nsQfTJ5l3OM8FhZr5tqNTATFqRbCuEH0D58/TJSexUP+TsEuC
         Dp33UZtBG32J0pXqpwu4spzP2QEpSXlGkXYsOtTQuc8RCpX8LZXmIWMyOW3I7YCRmY86
         60jqIVz6FM+GNXtLQTMZxcWtQ5h4RHZaSGHwImK9ewKex4TQNjv1euPpKEBMJC5haLTf
         Cw6GILFTHvJ2X+Gj7uR74yS2B9wmXZivl0kCneNF7kT+8rJweMDN8rL9tTLRL3uGVBj1
         mmDQ==
X-Gm-Message-State: APjAAAWkafSPKocx2IjkXEXWVAn2JrzfFpN7BsBBRe3U7YCG5uHFSQDt
        RrVrxM/6bP9btY4hgJt+OVEhx8VW
X-Google-Smtp-Source: APXvYqziKKAAj7LPxAjrO4F1GMEvOUHYTGOoWJeLAzp7SIx92TFNftJqq9tLATabTvQVqVCchB6tZg==
X-Received: by 2002:a1c:658a:: with SMTP id z132mr848821wmb.92.1554313511737;
        Wed, 03 Apr 2019 10:45:11 -0700 (PDT)
Received: from [192.168.1.19] (bkr161.neoplus.adsl.tpnet.pl. [83.28.185.161])
        by smtp.gmail.com with ESMTPSA id a11sm18085070wrx.5.2019.04.03.10.45.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Apr 2019 10:45:11 -0700 (PDT)
Subject: Re: [PATCH 3/4] mfd: ti-lmu: Remove LM3532 backlight driver
 references
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Dan Murphy <dmurphy@ti.com>, robh+dt@kernel.org, pavel@ucw.cz,
        tony@atomide.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org
References: <20190321142838.22985-1-dmurphy@ti.com>
 <20190321142838.22985-3-dmurphy@ti.com>
 <8769a95d-179f-6219-0a63-9dd623cdd297@gmail.com> <20190325075317.GW4731@dell>
 <c950b7d3-eeb1-2dc2-b732-3a40d5b3a8b7@gmail.com>
 <20190403075709.GD11301@dell>
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
Message-ID: <8b771488-a914-0d75-6e9b-9a67b4c5017e@gmail.com>
Date:   Wed, 3 Apr 2019 19:45:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190403075709.GD11301@dell>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/3/19 9:57 AM, Lee Jones wrote:
> On Mon, 25 Mar 2019, Jacek Anaszewski wrote:
> 
>> On 3/25/19 8:53 AM, Lee Jones wrote:
>>> On Sat, 23 Mar 2019, Jacek Anaszewski wrote:
>>>
>>>> Hi Lee,
>>>>
>>>> Can we have your ack for this going via LED tree, please?
>>>
>>> Patch looks okay.
>>>
>>> You can take it through the LED, but if you do I will need you to send
>>> me a pull-request to a minimised immutable branch please.
>>>
>>> If you cannot do this, I can apply the set and provide the same to
>>> you.
>>>
>>> If you choose the former:
>>>
>>>     Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
>>>
>>> Please let me know what you decide
>>>
>>
>> I've been exposing integration branches in the past, but after Linus'
>> message [0] I have my doubts now. I wonder if it wouldn't make more
>> sense if I just took the patches, and you'd cherry-pick them only in
>> case such a need occurs. This way we would avoid this whole merge
>> noise, which in an optimistic and very plausible case will not be needed
>> at all.
>>
>> [0] https://lkml.org/lkml/2017/4/19/1104
> 
> That email is 2 years old, and does not seem relevant to what we're
> trying to achieve.  I've only ever had issues when *not* creating
> immutable branches for these, cross subsystem scenarios.  The
> shared branches I create are always minimalist and never change.
> 
> I'm happy to take the patches and create a suitable pull-request for
> you if you are uncomfortable with the process.  I just need your Ack
> to do so.  Up to you.

I don't have any problem with the process. The clear gain of cherry
picking is more linear history. And the branch can be always created
when such a need occurs in linux-next.

That being said, I will send you a pull request once we sort out
the problem with obtaining a reference to the backlight node.

-- 
Best regards,
Jacek Anaszewski
