Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 704ADC10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 19:24:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 401942077C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 19:24:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OajAVNCI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726952AbfDLTYT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 15:24:19 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:32888 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726755AbfDLTYT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 15:24:19 -0400
Received: by mail-lj1-f193.google.com with SMTP id f23so9901817ljc.0;
        Fri, 12 Apr 2019 12:24:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=TqniWxHWbwOC/SbBq7rswqd2MLGdgAFEKuDzGbclVkY=;
        b=OajAVNCIQug6nREPzyi4VoM6mgAKPGbdO544Pkh/7aL0BA12OmNs+sCkrDWJz+WncC
         +h6LYvv5MP75zA7eG2wHO6REK8uVSVFvFcZmwBPuhQdkfZz7b+57mzPYN29xNSRMqzy2
         B4wiJj89dyM4H4SjqstA0n6MRw0J2EWmLcWQvTcM2j+T6xAFwf7V2Fky7K5yQBXaln9R
         g4kGeLqfcuOG3pU2IklwwXzc9XCLqSIdNyzzGcX52KayIMc1cnUAjXoqb4Qok9nXhqiZ
         eQX8C0ciZ1V99czNmtHbTrS+R9qHZIrFyLpmTUWEBHIb0/wnEmxAL6bpNS0HBiQZrScE
         ns6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TqniWxHWbwOC/SbBq7rswqd2MLGdgAFEKuDzGbclVkY=;
        b=Ud+8g3DwqMB13NXVzgs78G3YHYxTqFMtVdjnjoFCXnCAF3c/QOx2AB/bvO+iIQLSCL
         FapVKDRkx1/8aFobcdTvfXynqZsymFywdtuSVUKRns7SdnsrAb8mXGvAnGbPHs3C6KSo
         9d6fCp8fOQ/rmUmUdKFqsJA4PKz7niJMYEIzAEEbq7qWTVXbblFkzmdEfW8c4MSbR2d8
         LwbXCBaICsKsQNzWvFv56+CyUz744c5zA+wphJUY4hHN/Of5mBrFV7gPbH3BV03e6b5c
         lJwEGH4HXzJrtUlsD3Xw5/YcarOOo7WTKMGtJ7BduYuV8R40BTIWereaXv9TZQWNyhcB
         k+fg==
X-Gm-Message-State: APjAAAXax0nEqSyCjvB267vijIvv07VyGJBk91mRkTGhT4aikx/pJJ7H
        FjybPpni4GlH9cP8vrs9E+/YCoJW
X-Google-Smtp-Source: APXvYqyDIr2QiKy9Afg/T62XMfU1k31uc3qQvNWGh2GI/3grEVJy8TGj8C62xKDuEb0QaiUs7k1ZQQ==
X-Received: by 2002:a2e:7215:: with SMTP id n21mr33130015ljc.105.1555097056417;
        Fri, 12 Apr 2019 12:24:16 -0700 (PDT)
Received: from [192.168.1.19] (chg144.neoplus.adsl.tpnet.pl. [83.31.4.144])
        by smtp.gmail.com with ESMTPSA id c5sm9297776ljd.18.2019.04.12.12.24.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Apr 2019 12:24:15 -0700 (PDT)
Subject: Re: [PATCH v2 2/7] dt: bindings: Add multicolor class dt bindings
 documention
To:     Dan Murphy <dmurphy@ti.com>, Marek Behun <marek.behun@nic.cz>
Cc:     robh+dt@kernel.org, pavel@ucw.cz, rdunlap@infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-leds@vger.kernel.org
References: <20190411193848.23140-1-dmurphy@ti.com>
 <20190411193848.23140-3-dmurphy@ti.com> <20190412000707.70f8319f@nic.cz>
 <4e22f95f-8658-99cd-145e-b96f9e8314f7@gmail.com>
 <579add89-e274-07d2-04a4-4998917a62ff@ti.com>
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
Message-ID: <19932d2d-28c4-9212-b38b-8b7008fb1d34@gmail.com>
Date:   Fri, 12 Apr 2019 21:24:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <579add89-e274-07d2-04a4-4998917a62ff@ti.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dan,

On 4/12/19 8:46 PM, Dan Murphy wrote:
> Jacek
> 
> On 4/12/19 1:14 PM, Jacek Anaszewski wrote:
>> Hi Marek,
>>
>> On 4/12/19 12:07 AM, Marek Behun wrote:
>>> Hi Dan,
>>> this probaly was discussed, but I did not follow brightness model
>>> discussions:
>>> what will happen if I set yellow by writing into yellow mode
>>> brightness, and then orange by writing orange model brightness?
>>> Will the resulting color be a mix of yellow and orange, or will the
>>> orange overwrite the yellow setting?
>>
>> Orange will overwrite yellow settings. When color name is given
>> it should be treated as a hue. Then changing brightness level
>> should affect the lightness of a hue, similarly like changing
>> L component of HSL color model. This will be however entirely
>> up to DT brightness-model designer how they will design their models.
>> We are not going to verify that in the LED multi color class.
>>
>> It implies that it will be possible to define arbitrary range
>> of color levels, not necessarily adhering to any established color
>> model. I think it could be useful to define brightness model
>> that allows to go from blue color (for cold) up to red (hot)
>> for representing a temperature for instance.
>>
>> These ideas will need however more documentation. Generally
>> we aim to propose only a convention.
>>
> 
> Ah but what about the issue of writing the monochrome LED color.  With your description
> it implies that when we write the red LED, the red LED will come on and if we write the blue
> LED then the red LED in theory should turn off and the blue come on.

Where did I write that? Probably the way I used word "color"
was not adequate in at least two cases, which may have confused
the reader.

Modifying monochrome color brightness levels (under colors dir)
will just modify corresponding IOUT brightness. Not affecting the
other. I'll try to rephrase what seems to may sound equivocal:

s/When color name is given/When brightness-model is given a color name/

s/arbitrary range of color levels/arbitrary range of brightness-model 
levels/


> But these could be used to mix the colors to create some abstract violet that is not defined in the brightness
> model.  Why should the brightness models and monochrome LEDs have two different operations.
> 
> Dan
> 

-- 
Best regards,
Jacek Anaszewski
