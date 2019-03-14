Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ABA1C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 15:36:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16B9A217F5
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 15:36:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DAS7zAEf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726915AbfCNPgw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 11:36:52 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:34810 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726510AbfCNPgu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 11:36:50 -0400
Received: by mail-lj1-f194.google.com with SMTP id l5so5236155lje.1;
        Thu, 14 Mar 2019 08:36:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+msHXxIWxqfM8NrVRhSqGs9rb3Wy7R5ryQITgHgBVA0=;
        b=DAS7zAEf2V1/7Myttni1rl8R9AIoImuzINXKGLbX9ojVQbEFQkKSCY74/Po3eIb+gh
         2D+0Ib1LvyhuZsqNZRsRWwec6lTt693bc+xGTwStKbse6IUsZv+a4OGd2PVfmejO92aO
         pmAMzyykEiSDpx8bhS9LrdvQ+OvNZnnIt85mM46L4tSi3YSGuXV+A7u04tHHZ13RW3Po
         AH5CxNkPYRZPLwEcW9bBLQl939qMWyJMQTguJDP8tq2kXUCsXdozbzWaPzwYC+7OGsul
         eMLnwHIfhpgd9tT7uT8HqDuRdYVSPk58r6disOVPC/omI+qMy4pldtR2oaLnZkeQ8Z68
         9IEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+msHXxIWxqfM8NrVRhSqGs9rb3Wy7R5ryQITgHgBVA0=;
        b=hjitY/UHv89Ybi+fPwJ8JEk150ExsKRs65yHDhoSZQrqRLp9hPcmwDDvCZ9BVu2Vyu
         6Gupf5w4xNnuC+RO5i7nQQAWfSKkgUNNvtfadNUlFIoqRwhRpIj5gF8MMXtiBEpQvhyM
         mP0cqIYCMuVpRVkgCLyldjFJi5TO8zji4r235NQoYnYMTBSIH+afR6vnq/EwEBEiyseu
         wHLUBu+ZWbyemk3RBAB2IgMubCBVj04RswIrnwzRFOcssa5xpdJpgKcZzIf3dNh/M81I
         9nbIF7tl8f4X9133+L4hsr2Lv8jH8r4qNM4b1XTPW1fsDCfU2XaJwAIj6Hj/awpqmyom
         TN1w==
X-Gm-Message-State: APjAAAVe3PnjJNpkT2fY8wJQr1JaPCJD7AS00Bn11qVUyinXwzh9VoT7
        uZLdpG6ZXplmbip5rpJrvNMkDnpR
X-Google-Smtp-Source: APXvYqy9eJNH3TU+K07AMKj7vPbasOpC6eDPZPbS6F7p9PRuzpN+NihjBicKauOg1IO26z/zncyR+A==
X-Received: by 2002:a2e:9052:: with SMTP id n18mr4203051ljg.158.1552577807880;
        Thu, 14 Mar 2019 08:36:47 -0700 (PDT)
Received: from [192.168.1.18] (bfw164.neoplus.adsl.tpnet.pl. [83.28.60.164])
        by smtp.gmail.com with ESMTPSA id t81sm2122188lff.21.2019.03.14.08.36.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Mar 2019 08:36:46 -0700 (PDT)
Subject: Re: [PATCH v2 6/6] leds: netdev trigger: allow setting initial values
 in device tree
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Pavel Machek <pavel@ucw.cz>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20190313202615.22883-1-linux@rasmusvillemoes.dk>
 <20190314140619.3309-1-linux@rasmusvillemoes.dk>
 <20190314140619.3309-7-linux@rasmusvillemoes.dk>
 <742bd6b2-0a11-858e-d727-204b0313265e@gmail.com>
 <10d65087-2ae5-8ddf-e9be-02c9341b452b@rasmusvillemoes.dk>
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
Message-ID: <ddc53d4c-3da8-3f00-12dc-51df4a149bcf@gmail.com>
Date:   Thu, 14 Mar 2019 16:36:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <10d65087-2ae5-8ddf-e9be-02c9341b452b@rasmusvillemoes.dk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/14/19 4:05 PM, Rasmus Villemoes wrote:
> On 14/03/2019 15.24, Jacek Anaszewski wrote:
>> Rasmus,
>>
>> Thank you for the update.
>> Still, there is one thing to improve.
>>
> 
>>>    static int netdev_trig_activate(struct led_classdev *led_cdev)
>>>    {
>>>        struct led_netdev_data *trigger_data;
>>> @@ -423,6 +451,8 @@ static int netdev_trig_activate(struct
>>> led_classdev *led_cdev)
>>>        trigger_data->mode = 0;
>>>        atomic_set(&trigger_data->interval, msecs_to_jiffies(50));
>>>        trigger_data->last_activity = 0;
>>> +    if (led_cdev->flags & LED_INIT_DEFAULT_TRIGGER)
>>> +        netdev_trig_of_init(led_cdev, trigger_data);
>>
>> We don't necessarily want OF settings to be used for initialization on
>> each LED trigger activation for the LED class device, but only on the
>> first one. That's why the triggers using this flags clean it here:
>>
>> led_cdev->flags &= ~LED_INIT_DEFAULT_TRIGGER;
> 
> Right, I noticed that pattern, but wondered about it. If this is
> supposed to be a general thing, why isn't it just done by the trigger
> core after the call of led_trigger_set() in the two places the bit gets
> set? I.e.
> 
> 		led_cdev->flags |= LED_INIT_DEFAULT_TRIGGER;
> 		led_trigger_set(led_cdev, trig);
> +		led_cdev->flags &= ~LED_INIT_DEFAULT_TRIGGER;
> 
> I can certainly add clearing the flag to my code, just wondering.

Good point. It would have to be applied in both
led_trigger_set_default() and led_trigger_register(). So you either
need to add generic support for clearing the flag (and update the three
users) or update your patch alone.

-- 
Best regards,
Jacek Anaszewski
