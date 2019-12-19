Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57ED8C2D0C0
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 12:36:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27C33218AC
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 12:36:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oazMuqqE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726793AbfLSMgA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 07:36:00 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:42135 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726699AbfLSMf7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 07:35:59 -0500
Received: by mail-pg1-f195.google.com with SMTP id s64so3044685pgb.9;
        Thu, 19 Dec 2019 04:35:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=eh5hZOMRljMPnv55Lwz50F0tmp+Jyr2lxLZ2b+evS5U=;
        b=oazMuqqEwVaHG4v0mQT1aW5fsyMNy74q0Vh9dn6T1BN2kShnCrM1DPZhhHIr4pyLx/
         oYjUXKz3+jf3WSOM4x0ldbBrZlMhDcFBdxzG8i/iFY/iinIbxoWS3358jL5rHnGrtfSY
         QSk1It9BuOXWvgHr7gsAZ3wWdS1fMIDtZi1RgmnxttKOclxsfCjcn26DFQRC+ioZEMv1
         yvuDpZ1FXxneMG+VbCzMVqb61d50g5+Vlb++qKD/tfUUGK9Lq11HMn3zmKfQ/thbE6gJ
         k4JPyXoKx/mYY02pFbuJD+L58b1LvB9hMbNqVjgbXXa+DFgwc/d6nouu6g5VXKn6toom
         H95g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=eh5hZOMRljMPnv55Lwz50F0tmp+Jyr2lxLZ2b+evS5U=;
        b=ugs0sxGSSi4mLXlgKAT0tdP3L/kz0Kpg3+gIJ2hOsFkcIZu6cvLp1ak2QbNsQudES3
         YluLbOhFQXSh4tJ4c0cAvjV3wpSSlIi4736elZo94v2dinp5Wbz3gpZgOGHWME7S2wNb
         NKlO0oNslBis813apP37wvA0EswOvtMpN8mQ+e7aHs7Wz3FaxOFciurkAMfarRtchMRT
         svEAW9TBVwIDtgwWlDjlPwy88V7izYfyxvSH5y4+8AcPLtm3KdI2eOM/OBacX9P32sB9
         jRBkPyqz4DJJ3QZ+8KoKFXRs5xH8X08OsOkBcd7MFzY/JiaRN6cAg9hWwwipjavB0980
         eLWg==
X-Gm-Message-State: APjAAAU2/caHv0Vq8fjxYgIso8oMNEEgNe9ixboU8urh27xGi95NGJ2B
        Trl/EItvd5NuPSVLGR2Ha9XYjihM/nA=
X-Google-Smtp-Source: APXvYqwMfMW79dbAhwnatpapCfr+AIM1mB/IsztI5To9PK3koD0gy3r0Ay2giZBNGhGgDag2UrFmxQ==
X-Received: by 2002:aa7:914b:: with SMTP id 11mr9725108pfi.69.1576758958804;
        Thu, 19 Dec 2019 04:35:58 -0800 (PST)
Received: from ?IPv6:2402:f000:1:1501:200:5efe:166.111.139.116? ([2402:f000:1:1501:200:5efe:a66f:8b74])
        by smtp.gmail.com with ESMTPSA id q12sm6768455pjq.10.2019.12.19.04.35.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Dec 2019 04:35:58 -0800 (PST)
Subject: Re: [PATCH 1/2] gpio: gpio-grgpio: fix possible
 sleep-in-atomic-context bugs in grgpio_remove()
To:     Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio <linux-gpio@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20191218132551.10537-1-baijiaju1990@gmail.com>
 <CAMpxmJXZKZYg_B_EpGbnoCEfdKw756KF5gurC4ck6RwjNd7A-g@mail.gmail.com>
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
Message-ID: <d315dba3-19b9-d860-e557-d083efd9127d@gmail.com>
Date:   Thu, 19 Dec 2019 20:35:58 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <CAMpxmJXZKZYg_B_EpGbnoCEfdKw756KF5gurC4ck6RwjNd7A-g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019/12/19 19:10, Bartosz Golaszewski wrote:
> śr., 18 gru 2019 o 14:26 Jia-Ju Bai <baijiaju1990@gmail.com> napisał(a):
>> The driver may sleep while holding a spinlock.
>> The function call path (from bottom to top) in Linux 4.19 is:
>>
>> drivers/gpio/gpiolib-sysfs.c, 796:
>>          mutex_lock in gpiochip_sysfs_unregister
>> drivers/gpio/gpiolib.c, 1455:
>>          gpiochip_sysfs_unregister in gpiochip_remove
>> drivers/gpio/gpio-grgpio.c, 460:
>>          gpiochip_remove in grgpio_remove
>> drivers/gpio/gpio-grgpio.c, 449:
>>          _raw_spin_lock_irqsave in grgpio_remove
>>
>> kernel/irq/irqdomain.c, 243:
>>          mutex_lock in irq_domain_remove
>> drivers/gpio/gpio-grgpio.c, 463:
>>          irq_domain_remove in grgpio_remove
>> drivers/gpio/gpio-grgpio.c, 449:
>>          _raw_spin_lock_irqsave in grgpio_remove
>>
>> mutex_lock() can sleep at runtime.
>>
>> To fix these bugs, gpiochip_remove() and irq_domain_remove() are called
>> without holding the spinlock.
>>
>> These bugs are found by a static analysis tool STCheck written by myself.
>>
>> Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
>> ---
>>   drivers/gpio/gpio-grgpio.c      | 5 ++++-
>>   sound/soc/sti/uniperif_player.c | 3 ++-
>>   2 files changed, 6 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpio/gpio-grgpio.c b/drivers/gpio/gpio-grgpio.c
>> index 08234e64993a..60a2871c5ba7 100644
>> --- a/drivers/gpio/gpio-grgpio.c
>> +++ b/drivers/gpio/gpio-grgpio.c
>> @@ -448,13 +448,16 @@ static int grgpio_remove(struct platform_device *ofdev)
>>                  }
>>          }
>>
>> +       spin_unlock_irqrestore(&priv->gc.bgpio_lock, flags);
>> +
>>          gpiochip_remove(&priv->gc);
>>
>>          if (priv->domain)
>>                  irq_domain_remove(priv->domain);
>>
>>   out:
>> -       spin_unlock_irqrestore(&priv->gc.bgpio_lock, flags);
>> +       if (ret)
>> +               spin_unlock_irqrestore(&priv->gc.bgpio_lock, flags);
> In general there is no need for locking in remove() callbacks. I guess
> you can safely remove the spinlock here all together.

Okay, I will send a new patch.

>
>>          return ret;
>>   }
>> diff --git a/sound/soc/sti/uniperif_player.c b/sound/soc/sti/uniperif_player.c
>> index 48ea915b24ba..62244e207679 100644
>> --- a/sound/soc/sti/uniperif_player.c
>> +++ b/sound/soc/sti/uniperif_player.c
>> @@ -601,13 +601,14 @@ static int uni_player_ctl_iec958_put(struct snd_kcontrol *kcontrol,
>>          mutex_unlock(&player->ctrl_lock);
>>
>>          spin_lock_irqsave(&player->irq_lock, flags);
>> +       spin_unlock_irqrestore(&player->irq_lock, flags);
> Yeah I can tell this was generated automatically - what does this line
> is expected to achieve?

Ah, sorry, this is my mistake.
I forgot to reset the kernel code before writing the patch...


Best wishes,
Jia-Ju Bai
