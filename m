Return-Path: <SRS0=KwB+=SC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1A93C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 10:52:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B66A3206B7
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 10:52:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n+p5h5Uc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727005AbfCaKwQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 Mar 2019 06:52:16 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:46429 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726586AbfCaKwQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Mar 2019 06:52:16 -0400
Received: by mail-lf1-f67.google.com with SMTP id r25so4212765lfn.13;
        Sun, 31 Mar 2019 03:52:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=sDimXiWMgxF4JQd6yf7DIRqjlMezRr6R5gDuav8TEl4=;
        b=n+p5h5Ucs3wgfa/Kbr5PM9jdmsKIoSQ+H/0x7ZPJ9+vbNj8J1Kl/hwuVTdZVxX0Cly
         RtfKWZZ5XRht5oWcqfGDphAgxbHoQyjezCn9nDFPc+TV3K6P6GPtRI6PylM5/dIhQZWM
         ET3LrOhX/8STMrIv8yYzxfNNOQfqpagNucK4NCa4YwvboUf49QG82wwm3VKO1qlxh6Ix
         6oDTDy81dhHGOL+zcFi3eATFDISaM9Ik419Cx64pqplcG/F9mmyFAyVyWoqr9+oiuuxi
         VepwYanbIUWpcPp7iBOOGtJvwli2XcIyFtisi9Ym4fJaOSoQuwa6cWxjWKgyh7udiJTc
         3Oqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=sDimXiWMgxF4JQd6yf7DIRqjlMezRr6R5gDuav8TEl4=;
        b=tO9+CQfmidMqr/rHZIHMgNKugifMEy6x5P46LO68vty4WPxdBuvi1TRe+AIRqmRCph
         mDCKu4ZuJfGT7/RD4yn5r0+owPYXwmyEdDRQKxqtBKSlRIRZSkZGFUvQjIEUk0EIdTa2
         NkLr+grI+00IzEcR9Dzt7+mHqHZWpflwbviq+IAp5vL5OjgcE9DiWmZn5SqoszDNCwea
         /VskUUL2Mx/ZzAKBKARI/WLs0gA2SEq5qvVbKTtMCVeouHSIdllJ0UYp5UN1qmjr4vMM
         eAQbbtwRD8LnUB/31zb6Q/Qp7cYDplAc11DLRKCEv+ewytAh6GfcmLt3YBP3cbPbbIyq
         VcfQ==
X-Gm-Message-State: APjAAAWp9VC6bfqDCtLBrxyNTN5jhyRwhU8/2GSVMk2MAAdWsMagA/Gs
        uHoBeLLwRTLyKVuZLtY3OIa05M42
X-Google-Smtp-Source: APXvYqwQDMwF7mLdVo+sifFfLxy6w0KHKrtCH1tiingNixvgrEYuYNLK4I0hCiUGZDZHEIFvEDHpxg==
X-Received: by 2002:ac2:592f:: with SMTP id v15mr25569329lfi.133.1554029533361;
        Sun, 31 Mar 2019 03:52:13 -0700 (PDT)
Received: from [192.168.1.19] (bds153.neoplus.adsl.tpnet.pl. [83.28.4.153])
        by smtp.gmail.com with ESMTPSA id v11sm1228132lfb.68.2019.03.31.03.52.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 31 Mar 2019 03:52:12 -0700 (PDT)
Subject: Re: [PATCH] leds: fix a potential NULL pointer dereference
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Kangjie Lu <kjlu@umn.edu>, pakki001@umn.edu,
        Riku Voipio <riku.voipio@iki.fi>, Pavel Machek <pavel@ucw.cz>,
        linux-leds@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20190309060411.29074-1-kjlu@umn.edu>
 <8c616b91-8f0d-f53b-af10-4d768063c5a0@gmail.com>
 <CAMuHMdXELu2tcSB5C1yKUGft6sDGPAy997ApPzy17n0MssfyWA@mail.gmail.com>
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
Message-ID: <1c8358dd-528a-9801-db0d-45e06cbe797f@gmail.com>
Date:   Sun, 31 Mar 2019 12:52:05 +0200
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

Hi Linus,

Yesterday I submitted pull request [0] containing this patch, but
the patch turns out to be pointless. Since I see my pull request merged
on top of mainline trunk I suspect it will not be a problem to
drop the patch or even whole pull request. In the latter case I'll
re-submit it for -rc4.

Sorry for the confusion.

Best regards,
Jacek Anaszewski

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
> Moreover, this cannot happen, as pca9532_of_populate_pdata() already
> contains a similar check.
> 
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
> 
> Gr{oetje,eeting}s,
> 
>                          Geert
> 

[0] https://lkml.org/lkml/2019/3/30/222
