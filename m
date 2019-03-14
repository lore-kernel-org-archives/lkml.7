Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9A77C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 15:05:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A02021852
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 15:05:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="f8CCMdQ+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726933AbfCNPF4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 11:05:56 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:33602 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726539AbfCNPFz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 11:05:55 -0400
Received: by mail-lj1-f194.google.com with SMTP id z7so5151361lji.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2019 08:05:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=lSt++3v9MSKo0O79TPdHq4C6wWt4nBv7D9CXWFbJwn0=;
        b=f8CCMdQ+s9CrpT/BsQxJ3UzBvH102wnp5qrWzyjRMQ4HYg3atEFswDDyNHzxWL0fU1
         3gvzQCPfarguF7/C8Zp8WGUS6ojvEW2s2C4GzHfAJlsuGpVikt89P+uVJaIV+cONyx2A
         6/rYQC6ACFwsEjWsGKGzxNa0Wv/y81IlAFv9Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=lSt++3v9MSKo0O79TPdHq4C6wWt4nBv7D9CXWFbJwn0=;
        b=F4JCfbeoXd3UmX8tUBUGtbg7lPMYY2uNvwHF5BczKef0x0We3E8a66feIC8A65eJZA
         HMIVYXABGbLu1FPt0+W0S0Ochsf+qUugR9D65pUn72dcmeRKyPaNx1YgbKWGwn1H6DIe
         fldLk7MYrNV4coXJLXW6a3hG2w1sD3/QpSIYz3nxgq22n/0Rjq9kpbn0HtvBWZUrAoOq
         7JRT67HEDORCR2utxMmKhKNPOWQRnWDsCVGXR3686fxddFPlb/y2NPgwk+bsM5M+9Sal
         IVA5FX1Jc4RkMfYJZRGWjAN9HG1nrvBooDlL1enGRWwGUzm1mnmwILXJEONA/yw6xdH5
         2KcQ==
X-Gm-Message-State: APjAAAUdqlomBp/BaOQU/xaqkeK2ogFZin4OftxAO1Xm9qPTc3EM5lpp
        8q+iOjUATIrCzJf6w2cB/bAKuA==
X-Google-Smtp-Source: APXvYqzgDaOThiEVcXybSFaWSti4Io9DrBPWuDrhIZJfdIW3NjmqjvUttaAJcwd//xDxuYfu0rz8Zw==
X-Received: by 2002:a2e:2165:: with SMTP id h98mr26963656ljh.117.1552575953323;
        Thu, 14 Mar 2019 08:05:53 -0700 (PDT)
Received: from [172.16.11.26] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id p21sm2781826lfd.4.2019.03.14.08.05.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Mar 2019 08:05:52 -0700 (PDT)
Subject: Re: [PATCH v2 6/6] leds: netdev trigger: allow setting initial values
 in device tree
To:     Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Pavel Machek <pavel@ucw.cz>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20190313202615.22883-1-linux@rasmusvillemoes.dk>
 <20190314140619.3309-1-linux@rasmusvillemoes.dk>
 <20190314140619.3309-7-linux@rasmusvillemoes.dk>
 <742bd6b2-0a11-858e-d727-204b0313265e@gmail.com>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <10d65087-2ae5-8ddf-e9be-02c9341b452b@rasmusvillemoes.dk>
Date:   Thu, 14 Mar 2019 16:05:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <742bd6b2-0a11-858e-d727-204b0313265e@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/03/2019 15.24, Jacek Anaszewski wrote:
> Rasmus,
> 
> Thank you for the update.
> Still, there is one thing to improve.
> 

>>   static int netdev_trig_activate(struct led_classdev *led_cdev)
>>   {
>>       struct led_netdev_data *trigger_data;
>> @@ -423,6 +451,8 @@ static int netdev_trig_activate(struct
>> led_classdev *led_cdev)
>>       trigger_data->mode = 0;
>>       atomic_set(&trigger_data->interval, msecs_to_jiffies(50));
>>       trigger_data->last_activity = 0;
>> +    if (led_cdev->flags & LED_INIT_DEFAULT_TRIGGER)
>> +        netdev_trig_of_init(led_cdev, trigger_data);
> 
> We don't necessarily want OF settings to be used for initialization on
> each LED trigger activation for the LED class device, but only on the
> first one. That's why the triggers using this flags clean it here:
> 
> led_cdev->flags &= ~LED_INIT_DEFAULT_TRIGGER;

Right, I noticed that pattern, but wondered about it. If this is
supposed to be a general thing, why isn't it just done by the trigger
core after the call of led_trigger_set() in the two places the bit gets
set? I.e.

		led_cdev->flags |= LED_INIT_DEFAULT_TRIGGER;
		led_trigger_set(led_cdev, trig);
+		led_cdev->flags &= ~LED_INIT_DEFAULT_TRIGGER;

I can certainly add clearing the flag to my code, just wondering.

Rasmus
