Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85F4EC4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 18:48:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 540582070D
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 18:48:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q0N21rR+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729251AbfDBSsM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 14:48:12 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:35255 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726098AbfDBSsL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 14:48:11 -0400
Received: by mail-lf1-f67.google.com with SMTP id u21so9799666lfu.2;
        Tue, 02 Apr 2019 11:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=l4/iYAREkBO+Vdaix1Nr5iGsCa1mefapunOYwIiiKyg=;
        b=q0N21rR+H3nUrGf0JP1mkooPCEj6r8TOGgVM2jhV8wB7Z2tRAAJyLiyMCvY+rhXyK1
         UlK3242fGrTVqksPRW6nTIwzWIOhaHepvyD95gzfW1qbQtZ92xrI5aLV91V8jOWDhV8R
         xTAR9cCHgntjmeQr4gi8pnXqwY9opsOS8c/ApnWGg4+Lnaz9zp8ARGDs/KLSItOvieIc
         HsEpOcLstIobUo2tb/vkdXVwXc4d3UDbXzKcfP6dPn3OI7n54Kyh66IsiIH+PurDRmHf
         aOdHpcpwP+4M6Pv4XUQyXv12bq/rLSD1J+UWrb06u550R4Qpk76pzgTA2AGc5ol1GjXW
         Ckjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=l4/iYAREkBO+Vdaix1Nr5iGsCa1mefapunOYwIiiKyg=;
        b=mhCXEIO0NjrYWPrI5XrhAGHlG5RHOFSo+/dxLZYQnXE1jhu0AAvyw5jVl+A5CceiTz
         xd6o1kUgrWXrzRzP9xCjqxW9oFbNtAg9SOyp3vKGdMOh2Qe4pvb7gPBs2dcTKy5xKqo/
         T49aZGNg0UgaaTFYjkUUO/9IVIkE4mIYNhC2p1B/rvgmqTmKqT+/EcCg0Wb746waxOKt
         WF9/hzMYSMEF7YwOJM6pxEi6c7bJ8I3muN5qaKsFdnxDNuuzR6aTILhpPQpBcIIFzVey
         PMPT3CqYts68YHUXQO7qcFXPYjwUfsPt7CMA57zmJQua65EUA2YPx3fm8qtVl/r8Om7t
         Uiow==
X-Gm-Message-State: APjAAAVl3VC2NWNpjA8tovNMJ8xCtXClgWf94RkuL3C4eCEEBz7X8Mqa
        L/WzVmQyEHjBWcwhIGw+GwitdFBI
X-Google-Smtp-Source: APXvYqygl/VMh0+t1Sijl6/9WmgOgPNRYhdCowr5+B8OCaXWteUrUcUeNEz6g2rl/FITPRPB/qNc9A==
X-Received: by 2002:ac2:5581:: with SMTP id v1mr11186388lfg.92.1554230889001;
        Tue, 02 Apr 2019 11:48:09 -0700 (PDT)
Received: from [192.168.1.19] (ckb186.neoplus.adsl.tpnet.pl. [83.31.77.186])
        by smtp.gmail.com with ESMTPSA id u3sm2930782lju.51.2019.04.02.11.48.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Apr 2019 11:48:07 -0700 (PDT)
Subject: Re: [PATCH] leds: fix a potential NULL pointer dereference
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Kangjie Lu <kjlu@umn.edu>, pakki001@umn.edu,
        Riku Voipio <riku.voipio@iki.fi>, Pavel Machek <pavel@ucw.cz>,
        linux-leds@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20190309060411.29074-1-kjlu@umn.edu>
 <8c616b91-8f0d-f53b-af10-4d768063c5a0@gmail.com>
 <CAMuHMdXELu2tcSB5C1yKUGft6sDGPAy997ApPzy17n0MssfyWA@mail.gmail.com>
 <46573cc8-1666-d0a4-dadd-2b2f81e026fe@gmail.com>
 <CAMuHMdU9X2ah6q-RhqbAZnyaw9PHOsD5Q=Y9wmTU_uzJ0MLyuA@mail.gmail.com>
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
Message-ID: <2c17fc80-1781-ce71-641f-b2503d1b055c@gmail.com>
Date:   Tue, 2 Apr 2019 20:48:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAMuHMdU9X2ah6q-RhqbAZnyaw9PHOsD5Q=Y9wmTU_uzJ0MLyuA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert,

On 4/1/19 9:08 AM, Geert Uytterhoeven wrote:
> Hi Jacek,
> 
> On Sun, Mar 31, 2019 at 1:01 PM Jacek Anaszewski
> <jacek.anaszewski@gmail.com> wrote:
>> On 3/31/19 11:06 AM, Geert Uytterhoeven wrote:
>> On Sun, Mar 10, 2019 at 9:40 PM Jacek Anaszewski
>>> <jacek.anaszewski@gmail.com> wrote:
>>>> On 3/9/19 7:04 AM, Kangjie Lu wrote:
>>>>> In case of_match_device cannot find a match, the fixes returns
>>>>> -EINVAL to avoid NULL pointer dereference.
>>>>>
>>>>> Signed-off-by: Kangjie Lu <kjlu@umn.edu>
>>>>> ---
>>>>>     drivers/leds/leds-pca9532.c | 8 ++++++--
>>>>>     1 file changed, 6 insertions(+), 2 deletions(-)
>>>>>
>>>>> diff --git a/drivers/leds/leds-pca9532.c b/drivers/leds/leds-pca9532.c
>>>>> index 7fea18b0c15d..4b0335591728 100644
>>>>> --- a/drivers/leds/leds-pca9532.c
>>>>> +++ b/drivers/leds/leds-pca9532.c
>>>>> @@ -513,6 +513,7 @@ static int pca9532_probe(struct i2c_client *client,
>>>>>         const struct i2c_device_id *id)
>>>>>     {
>>>>>         int devid;
>>>>> +     const struct of_device_id *of_id;
>>>>>         struct pca9532_data *data = i2c_get_clientdata(client);
>>>>>         struct pca9532_platform_data *pca9532_pdata =
>>>>>                         dev_get_platdata(&client->dev);
>>>>> @@ -528,8 +529,11 @@ static int pca9532_probe(struct i2c_client *client,
>>>>>                         dev_err(&client->dev, "no platform data\n");
>>>>>                         return -EINVAL;
>>>>>                 }
>>>>> -             devid = (int)(uintptr_t)of_match_device(
>>>>> -                     of_pca9532_leds_match, &client->dev)->data;
>>>>> +             of_id = of_match_device(of_pca9532_leds_match,
>>>>> +                             &client->dev);
>>>>> +             if (unlikely(!of_id))
>>>
>>> Use of unlikey() is frowned upon.
>>
>> What do you mean? Can you give some reference?
> 
> I have more memories of this being discussed, but I could find only
> https://lwn.net/Articles/420019/

Thanks!

> It may be useful for some heavily used core code, but not in most drivers
> or uncritical code like probe paths, due to:
>    - many people getting it wrong,
>    - usually it doesn't make any difference at all.
> 
>>>> Applied to the for-5.2 branch of linux-leds.git.
>>>
>>> And also as a fix for v5.1...
>>
>> Yes, but it had been in linux-next for almost two weeks before that.
> 
> Sorry, I only noticed when it got upstream.

No problem.

-- 
Best regards,
Jacek Anaszewski
