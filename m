Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A5A0C47404
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 14:05:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E3AF21848
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 14:05:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="r0N9yf2b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731037AbfJIOFR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 10:05:17 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54870 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727769AbfJIOFQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 10:05:16 -0400
Received: by mail-wm1-f66.google.com with SMTP id p7so2773005wmp.4
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2019 07:05:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Uj3uK+PXxvqbeopMnt61nNLWeJ5KhO8l4CJVLwumEdU=;
        b=r0N9yf2b+byu4vuI8y0JeeHavanBpTMDQpn/KaBT8Gm4fGqhrZiXJi0RqeKptEsRWn
         Br9sL6Yil/FWaiOqUwPcODWe94yJNRyZzu/B8LEWYVr9gHUdwbSDbtiDcmi2byyJImGC
         YXqINhsTJVv9QKm5SIub8rUPhTw6lqrIfQDn6bO+Fhi9lPH2JT8Tz16ne+srPsgphekB
         7HBBcyqyGGKSqEmo58Ndwm8VYH6Q/cg0zXvAVuOMeGHts28iFJiR2szzJePhV1zYuapJ
         ORG/XU7r4bwCNqLU+5GO4AscWIvAVeOsZPxTu36s4L+htHTizyP8MCAdOnMgeKp0V12x
         8nKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Uj3uK+PXxvqbeopMnt61nNLWeJ5KhO8l4CJVLwumEdU=;
        b=MboPDVKK4O1PKNiPwtFMTrz4cymj4wdsqKViKcoiG//X75DTe47X66Gr/vu9S5w8Qo
         mPpqpQiEZHT/fkUAAgWG0zzYFhJrL1vJE1pv/lLApinI9Qb/OKfBDti7wB0zqx19R1im
         Oeq6Ib3VBli1yVxlHXiL0xX/xJ/HdlGl4ihx1L98+E7Bro8rgkhcFLY62r5E8hQfyJzE
         J5x9t/nIVLPYZ0d8c2fskMfH6gnAI69ttpOdVdXr9xTtuWJM3j8lgTMBFKfmA6XVXtOo
         Pa7ZWOWThMHKlMX/aj3b+mccGpNHfalMpLcc1biqJj9tjPcbKH5IYB60S/o5vy2HC1h/
         5aSA==
X-Gm-Message-State: APjAAAX+wAaL1tKroY49WZ0NZizsOnNo7+u/7eO5uBzBZCcJpNxig1hf
        Flhy0RjIz1LAv1bvX3hcdZlcJw==
X-Google-Smtp-Source: APXvYqwTU1rnlyXZsfzUTaF2tYxe+uafBqiZSZYxBNpBuDzM8Nr7Tt4r2+AOyoXwV4lcRyYbLYeo8Q==
X-Received: by 2002:a7b:ce12:: with SMTP id m18mr2759228wmc.108.1570629914590;
        Wed, 09 Oct 2019 07:05:14 -0700 (PDT)
Received: from [192.168.86.34] (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.googlemail.com with ESMTPSA id s12sm2897774wra.82.2019.10.09.07.05.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Oct 2019 07:05:13 -0700 (PDT)
Subject: Re: [PATCH] firmware: vpd: Add an interface to read VPD value
To:     Stephen Boyd <swboyd@chromium.org>,
        Cheng-yi Chiang <cychiang@chromium.org>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Tzung-Bi Shih <tzungbi@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ALSA development <alsa-devel@alsa-project.org>,
        Hung-Te Lin <hungte@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sean Paul <seanpaul@chromium.org>,
        Mark Brown <broonie@kernel.org>,
        Dylan Reid <dgreid@chromium.org>,
        Tzung-Bi Shih <tzungbi@chromium.org>
References: <20191007071610.65714-1-cychiang@chromium.org>
 <CA+Px+wWkr1xmSpgEkSaGS7UZu8TKUYvSnbjimBRH29=kDtcHKA@mail.gmail.com>
 <ebf9bc3f-a531-6c5b-a146-d80fe6c5d772@roeck-us.net>
 <CAFv8NwLuYKHJoG9YR3WvofwiMnXCgYv-Sk7t5jCvTZbST+Ctjw@mail.gmail.com>
 <5d9b5b3e.1c69fb81.7203c.1215@mx.google.com>
 <CAFv8Nw+x6V-995ijyws1Q36W1MpaP=kNJeiVtNakH-uC3Vgg9Q@mail.gmail.com>
 <5d9ca7e4.1c69fb81.7f8fa.3f7d@mx.google.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <e968e478-bb48-5b05-b6c4-ae1bf77f714f@linaro.org>
Date:   Wed, 9 Oct 2019 15:05:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <5d9ca7e4.1c69fb81.7f8fa.3f7d@mx.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 08/10/2019 16:14, Stephen Boyd wrote:
>> 3) As my use case does not use device tree, it is hard for ASoC
>> machine to access nvmem device. I am wondering if I can use
>> nvm_cell_lookup so machine driver can find the nvmem device using a
>> con_id. But currently the cell lookup API requires a matched device,
>> which does not fit my usage because there will be different machine
>> drivers requesting the value.
>> I think I can still workaround this by adding the lookup table in
>> machine driver. This would seem to be a bit weird because I found that
>> most lookup table is added in provider side, not consumer side. Not
>> sure if this is logically correct.
> Maybe Srini has some input here. It looks like your main concern is
> consumer to provider mapping?
> 

In non-DT setup, there are various ways to lookup nvmem provider.

1> nvmem_device_get()/put() using provider devid/name. I think you 
should be able to use this in your case.
2> nvmem_register_notifier() which notifies when nvmem provider is added 
to system.
3> nvmem_device_find() with own match function this will be merged in 
next window (https://lkml.org/lkml/2019/10/3/215)


If none of these are of any help, could explain what exactly are you 
looking for w.r.t nvmem to be able to move to what Stephen Boyd suggested?

--srini

