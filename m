Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9321C10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 18:46:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B69212064A
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 18:46:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GW55Cyo5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390107AbfDRSqb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 14:46:31 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35746 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389750AbfDRSqa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 14:46:30 -0400
Received: by mail-wm1-f66.google.com with SMTP id y197so4006776wmd.0;
        Thu, 18 Apr 2019 11:46:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=J+ARRcrNlVitTWp2yUazxz5QtZpdksQLRjasJWR841c=;
        b=GW55Cyo5gZixn1/SoYvG5+me8WTGdkAtIpismnzqDPIeAJ6nnoQrs/ZoUiyppqiWnT
         p2PJ0fVwJH1p9ddOzLHPqoeffa/1ks62CYN3qOTn/HVoFFme0DlV9NBqfJLx7+8e7erv
         fVmOTgVmToB7YkhgWeU+RKlEz5p7x/EkudLq6PKA1pzbixzfv17ridWTn3Gs/kIg3Mor
         8yTWp4X1ma4kN+t4tFsUZQDuHtjNhe38wjMiQUieVps+ejm9KxediQiQNp/vNECp/u33
         Pr9cXcN0gscxD484V3kW4q8ww9+QUjMFcbYYuWkjeL/PXhtiVaxBfrNWXiI5NeF10Ue4
         oj8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=J+ARRcrNlVitTWp2yUazxz5QtZpdksQLRjasJWR841c=;
        b=dlr0Vwt0/44oLpDY7taelFM8zebOfDz7wr0xvYFHbOaBmn6OubGcOMVdRdl3nLT4sX
         7UFp/sWrXGXU07IcdMvt00cSIiPXpIpttb0GrlljltKO9oytgyhnFiu6k8Kwpa+sEGy6
         daw1pv/GnfQSFeqUeXTG/IN4GB5J7yuUX+fk3i5saERFAc5wHe3y/lOEVm2bFtKAckig
         MS0mW2ye35aw8wwH6Gt04fYjj1ptNKVQe3iLd1mo1m3PD7TMWEs2Ra3UDUxSTkMSPl2K
         +rFfGio0K6PMOGAXb6Ldvtvn6W+dmgo4RKAbZplFfLBb4feF1tRYHYz3G2UL0cHUgimH
         bAog==
X-Gm-Message-State: APjAAAUfcMsZgMaPcX6CSk0cTmhaYSpwfBX+vLuhiialQWYJNwbGxfxr
        GJuDVHreXxsieYucG2eI/k7iEL2m
X-Google-Smtp-Source: APXvYqyVxGfU4yv7rTDUtF3a/coRz2KZdfd4HhiKDREML/f+i93M4O9dfDt3nl4XdZhLUM59Of5wBg==
X-Received: by 2002:a1c:9617:: with SMTP id y23mr4594974wmd.31.1555613188252;
        Thu, 18 Apr 2019 11:46:28 -0700 (PDT)
Received: from [192.168.1.19] (bfw35.neoplus.adsl.tpnet.pl. [83.28.60.35])
        by smtp.gmail.com with ESMTPSA id c10sm3385612wro.48.2019.04.18.11.46.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Apr 2019 11:46:27 -0700 (PDT)
Subject: Re: [PATCH v4 01/26] ALSA: line6: Avoid polluting led_* namespace
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
To:     Takashi Iwai <tiwai@suse.de>, Pavel Machek <pavel@ucw.cz>
Cc:     linux-leds@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        dtor@google.com, robh@kernel.org, Jaroslav Kysela <perex@perex.cz>,
        linux@roeck-us.net, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190417205439.17685-1-jacek.anaszewski@gmail.com>
 <20190417205439.17685-2-jacek.anaszewski@gmail.com>
 <s5h8sw7riwt.wl-tiwai@suse.de> <20190418122135.GA6925@amd>
 <s5htvevh56y.wl-tiwai@suse.de>
 <b0d841c4-f027-d99d-ab76-721fba4a2a1e@gmail.com>
Message-ID: <4fbd3711-a1a9-cde0-cc63-d2ced55eff4a@gmail.com>
Date:   Thu, 18 Apr 2019 20:46:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <b0d841c4-f027-d99d-ab76-721fba4a2a1e@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/18/19 7:12 PM, Jacek Anaszewski wrote:
> On 4/18/19 2:24 PM, Takashi Iwai wrote:
>> On Thu, 18 Apr 2019 14:21:35 +0200,
>> Pavel Machek wrote:
>>>
>>> On Thu 2019-04-18 07:17:54, Takashi Iwai wrote:
>>>> On Wed, 17 Apr 2019 22:54:14 +0200,
>>>> Jacek Anaszewski wrote:
>>>>>
>>>>> led_colors clashes with the array of the same name being added
>>>>> to the LED class. Do the following amendments to fix this issue
>>>>> and the other prospective one.
>>>>>
>>>>> led_colors -> toneport_led_colors
>>>>> led_init_vals -> toneport_led_init_vals
>>>>>
>>>>> Fixes: f44edd7b2bbed ("ALSA: line6/toneport: Implement LED controls 
>>>>> via LED class")
>>>>> Signed-off-by: Jacek Anaszewski <jacek.anaszewski@gmail.com>
>>>>> Cc: Jaroslav Kysela <perex@perex.cz>
>>>>> Cc: Takashi Iwai <tiwai@suse.com>
>>>>> Cc: Arnd Bergmann <arnd@arndb.de>
>>>>
>>>> Looks good.
>>>>
>>>> Feel free to take my ack:
>>>>    Reviewed-by: Takashi Iwai <tiwai@suse.de>
> 
> Thanks.
> 
>>> I guess this is independend of pretty much everything, and should be
>>> taken through the sound tree?
>>
>> I don't mind either way.  If it's easier for you to take through sound
>> tree, just let me know.
> 
> I prefer to take it via LED tree as this patch is needed
> by the LED naming set.

Applied to the for-next branch of linux-leds.git.

-- 
Best regards,
Jacek Anaszewski
