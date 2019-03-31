Return-Path: <SRS0=KwB+=SC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4293C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 11:02:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3567206B8
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 11:02:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JVb9j+jt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726988AbfCaLBy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 Mar 2019 07:01:54 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:35558 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726619AbfCaLBy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Mar 2019 07:01:54 -0400
Received: by mail-lf1-f66.google.com with SMTP id u21so4260382lfu.2;
        Sun, 31 Mar 2019 04:01:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=vIzDukIZvQkNEFxR4q4AGSd+nmER7cy8PaQ6bTGn85w=;
        b=JVb9j+jtaCtxxr9t+XafLg/ZLFscrD7U6UZU88dPNyh/1tN87rVf4bhVbBHP99GJv4
         665YN0kE+Kn50Li8EUdu9Jzmsyaifydv9yQ8ybfwfk9ehS6pFsJGVNh5xpno0mGKKEHH
         qhqdsTvcbTUC/+GT0F5HixpKcmJLJNIwM6JsKhaydgLZMVTKWOqOA/gQR32oFELY73CP
         wo7f2ABxkDZ6sHQjlEyhAORElUxVlKBZjyUxkWg2nhcXCVch7bfPaTc+JZB1xAw09Ol0
         zaXU2BcdovTcGz7joX36Fa+QJ9/e/fHb9Q4BOomXQW0w+lQMiY7cPtNMHBTgk3S2IE5O
         A+CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vIzDukIZvQkNEFxR4q4AGSd+nmER7cy8PaQ6bTGn85w=;
        b=st9f4gprzT/smUf3bZUOegeoU3Gj5VI7zJu5PRWTxU2zaneqSOy3B3MXxW6GxgGU1D
         +BK81cL2PLCbk4rYm3zgIp17n8verMTWORnZp/UnwBMQJghiuzKXfW2qUbawZEb2uSUg
         ZU9y3wseS6WGVOaM98hnuwgIOZV59VyVcaK3vuhE3tZBmqY2pxRYsdanYOyOrZnxugmZ
         BsZ5MJfJw/Din6hvIYkaiz/90xmjPuZtMrYDX/XZAZ5TFZN9SLSjSOqky8ej/cZzxl09
         hboa3zoC21HBUjAHHOTc2Rirqbk5e4UQWsJCgFizVmUHlygoWhgczH3HiDB0ZjgeYvCm
         0Dhw==
X-Gm-Message-State: APjAAAWswRuXXjsPkAzn/ysKp0eDYRtD5op3nRxN61KvyaFnKSw7ip3V
        hkE95LgqW/0+ueXc1UMylkHunY4U
X-Google-Smtp-Source: APXvYqypeFc2DnX/fWqj7vZq0+ar0AiUAFURlBxi5fFaanJSzFDpg3l6I+/zNPcsWD0SQDdbEN6AEA==
X-Received: by 2002:ac2:5305:: with SMTP id c5mr5032728lfh.153.1554030112334;
        Sun, 31 Mar 2019 04:01:52 -0700 (PDT)
Received: from [192.168.1.19] (bds153.neoplus.adsl.tpnet.pl. [83.28.4.153])
        by smtp.gmail.com with ESMTPSA id s16sm191455lji.61.2019.03.31.04.01.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 31 Mar 2019 04:01:51 -0700 (PDT)
Subject: Re: [PATCH] leds: fix a potential NULL pointer dereference
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Kangjie Lu <kjlu@umn.edu>, pakki001@umn.edu,
        Riku Voipio <riku.voipio@iki.fi>, Pavel Machek <pavel@ucw.cz>,
        linux-leds@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20190309060411.29074-1-kjlu@umn.edu>
 <8c616b91-8f0d-f53b-af10-4d768063c5a0@gmail.com>
 <CAMuHMdXELu2tcSB5C1yKUGft6sDGPAy997ApPzy17n0MssfyWA@mail.gmail.com>
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
Message-ID: <46573cc8-1666-d0a4-dadd-2b2f81e026fe@gmail.com>
Date:   Sun, 31 Mar 2019 13:01:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAMuHMdXELu2tcSB5C1yKUGft6sDGPAy997ApPzy17n0MssfyWA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert,

Thank you for the notification.

On 3/31/19 11:06 AM, Geert Uytterhoeven wrote:
> Hi Jacek,
> 
> On Sun, Mar 10, 2019 at 9:40 PM Jacek Anaszewski
> <jacek.anaszewski@gmail.com> wrote:
>> On 3/9/19 7:04 AM, Kangjie Lu wrote:
>>> In case of_match_device cannot find a match, the fixes returns
>>> -EINVAL to avoid NULL pointer dereference.
>>>
>>> Signed-off-by: Kangjie Lu <kjlu@umn.edu>
>>> ---
>>>    drivers/leds/leds-pca9532.c | 8 ++++++--
>>>    1 file changed, 6 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/leds/leds-pca9532.c b/drivers/leds/leds-pca9532.c
>>> index 7fea18b0c15d..4b0335591728 100644
>>> --- a/drivers/leds/leds-pca9532.c
>>> +++ b/drivers/leds/leds-pca9532.c
>>> @@ -513,6 +513,7 @@ static int pca9532_probe(struct i2c_client *client,
>>>        const struct i2c_device_id *id)
>>>    {
>>>        int devid;
>>> +     const struct of_device_id *of_id;
>>>        struct pca9532_data *data = i2c_get_clientdata(client);
>>>        struct pca9532_platform_data *pca9532_pdata =
>>>                        dev_get_platdata(&client->dev);
>>> @@ -528,8 +529,11 @@ static int pca9532_probe(struct i2c_client *client,
>>>                        dev_err(&client->dev, "no platform data\n");
>>>                        return -EINVAL;
>>>                }
>>> -             devid = (int)(uintptr_t)of_match_device(
>>> -                     of_pca9532_leds_match, &client->dev)->data;
>>> +             of_id = of_match_device(of_pca9532_leds_match,
>>> +                             &client->dev);
>>> +             if (unlikely(!of_id))
> 
> Use of unlikey() is frowned upon.

What do you mean? Can you give some reference?

> Moreover, this cannot happen, as pca9532_of_populate_pdata() already
> contains a similar check.

Right, I assumed this fixes a real problem and didn't spent too much
time investigating the whole context.. Lesson for the future.

> Kangjie: please stop submitting patches for missing checks, without
> investigating if the failures can actually happen. Thanks!
> 
>>> +                     return -EINVAL;
>>> +             devid = (int)of_id->data;
>>>        } else {
>>>                devid = id->driver_data;
>>>        }
>>
>>
>> Applied to the for-5.2 branch of linux-leds.git.
> 
> And also as a fix for v5.1...

Yes, but it had been in linux-next for almost two weeks before that.

-- 
Best regards,
Jacek Anaszewski
