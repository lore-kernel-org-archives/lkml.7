Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AC52C10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 17:12:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20A822064A
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 17:12:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R4WvWG0v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389772AbfDRRMU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 13:12:20 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:42742 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733192AbfDRRMT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 13:12:19 -0400
Received: by mail-lf1-f68.google.com with SMTP id w23so2179153lfc.9;
        Thu, 18 Apr 2019 10:12:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=MoyGmjZnnTNWSJhSUjWdzndYBMMaKL1MShmbVYpKMlg=;
        b=R4WvWG0vXn9eqmPbGAgpQtQy1ofO6aVolyirGNAHzdRYbTCFslA+EsdJafqWXOOmm1
         RXaG/xG0biii6ZZaL5P4H7kSHSgtAfVe5wcSpqGGrHLWJHYwQ20pvAEMfxhK7kY8+w6z
         jqzZMPIGXHTe67h+TNNcuhW3dOhQjtpTHfFo/xvu+ZeG+qM3/dM5iFfcg70X/H3UTG84
         Eo/e+34gRV3ozGQHwChXa52ra7Iev/JaZr0/Nnw30V073+/4dLrfWHqrOYlFMG8L2/o4
         v+Jq78IX6w6ibV8NWshpbbvhckH1vxoK8f2j9+x7aBof3+ljEmc1iF7aKkV0sfUWFPvg
         62zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=MoyGmjZnnTNWSJhSUjWdzndYBMMaKL1MShmbVYpKMlg=;
        b=Dcz9Ryi4VfECJJmAQvyizftm8It+07QQ30baKcw1YOxWB8C8lmU5EUJTvMEk5zcHSx
         ETxohB5IMUBp3tA2y4E2lxMTDMWAp3yYd+o5ZXQGQQZyrWQ0zZXYW3TICQlzU+qL/8vn
         dCYhCdMjpzBRZ3GUMKY3JxoSd8BUls4O7cDo5NHvL055q2Ix4XH2x4HLqkbZeABV+0Fn
         3n9lEhf4Y9rIJBh4fcbWNmDAEr35cK8lc4qp8Nv0lRnR+PcOJVfacSyUd9dvnkcg+HW0
         nwG/amTNF6iOiqkm0IhgyD/zI6c0iozg1gjTADtfy4v2ndWZ5NrW134TPs7tFH7UpRzf
         AU4g==
X-Gm-Message-State: APjAAAU//aBfIbiYzzBuhYPGtkUeRjh+kVoFLOl9dH0Lm+kuPbDyRRWu
        nq+YsFwaUdutr8rt+8tujvz752lE
X-Google-Smtp-Source: APXvYqxGj6Gv5PDeaQRt/mgFQKBu/JhLsuibK0KoZ0fvO+nQpHIM4lQLQYI9QOxGmJhHu0psnGf8Dg==
X-Received: by 2002:a19:2943:: with SMTP id p64mr1058292lfp.0.1555607537074;
        Thu, 18 Apr 2019 10:12:17 -0700 (PDT)
Received: from [192.168.1.19] (bfw35.neoplus.adsl.tpnet.pl. [83.28.60.35])
        by smtp.gmail.com with ESMTPSA id u3sm525705lju.51.2019.04.18.10.12.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Apr 2019 10:12:16 -0700 (PDT)
Subject: Re: [PATCH v4 01/26] ALSA: line6: Avoid polluting led_* namespace
To:     Takashi Iwai <tiwai@suse.de>, Pavel Machek <pavel@ucw.cz>
Cc:     linux-leds@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        dtor@google.com, robh@kernel.org, Jaroslav Kysela <perex@perex.cz>,
        linux@roeck-us.net, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190417205439.17685-1-jacek.anaszewski@gmail.com>
 <20190417205439.17685-2-jacek.anaszewski@gmail.com>
 <s5h8sw7riwt.wl-tiwai@suse.de> <20190418122135.GA6925@amd>
 <s5htvevh56y.wl-tiwai@suse.de>
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
Message-ID: <b0d841c4-f027-d99d-ab76-721fba4a2a1e@gmail.com>
Date:   Thu, 18 Apr 2019 19:12:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <s5htvevh56y.wl-tiwai@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/18/19 2:24 PM, Takashi Iwai wrote:
> On Thu, 18 Apr 2019 14:21:35 +0200,
> Pavel Machek wrote:
>>
>> On Thu 2019-04-18 07:17:54, Takashi Iwai wrote:
>>> On Wed, 17 Apr 2019 22:54:14 +0200,
>>> Jacek Anaszewski wrote:
>>>>
>>>> led_colors clashes with the array of the same name being added
>>>> to the LED class. Do the following amendments to fix this issue
>>>> and the other prospective one.
>>>>
>>>> led_colors -> toneport_led_colors
>>>> led_init_vals -> toneport_led_init_vals
>>>>
>>>> Fixes: f44edd7b2bbed ("ALSA: line6/toneport: Implement LED controls via LED class")
>>>> Signed-off-by: Jacek Anaszewski <jacek.anaszewski@gmail.com>
>>>> Cc: Jaroslav Kysela <perex@perex.cz>
>>>> Cc: Takashi Iwai <tiwai@suse.com>
>>>> Cc: Arnd Bergmann <arnd@arndb.de>
>>>
>>> Looks good.
>>>
>>> Feel free to take my ack:
>>>    Reviewed-by: Takashi Iwai <tiwai@suse.de>

Thanks.

>> I guess this is independend of pretty much everything, and should be
>> taken through the sound tree?
> 
> I don't mind either way.  If it's easier for you to take through sound
> tree, just let me know.

I prefer to take it via LED tree as this patch is needed
by the LED naming set.

-- 
Best regards,
Jacek Anaszewski
