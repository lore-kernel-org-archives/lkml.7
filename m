Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17440C10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 17:49:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D81E9218A3
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 17:49:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EW86v5/6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726951AbfDLRt4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 13:49:56 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37375 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726327AbfDLRt4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 13:49:56 -0400
Received: by mail-wr1-f67.google.com with SMTP id w10so13029755wrm.4;
        Fri, 12 Apr 2019 10:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=VgcMNko7l5DJIOfJtBTvwoP7PJiZ+4kcBGir77liTPA=;
        b=EW86v5/6YeQX4MTTkrcaWVfotNZmtpVgDwAzHD+yxd+qNSLVTxEvdi61R6Q+c3fRAh
         2L3oDJX2wk/9wOY7cFwtRMZ8lEACzbuw+oPWJ5hSsriNtQj2T6jkuxKVeGVMoL67Gy8Q
         8WdI93D5NMJSj+EtOqknJflsTOJn7gMiohMiphtCMMIjUcwCM5EZv9hQgUAmgp4T7TsJ
         QIMv5HkCTuzd8qLFb5eiNMXHk/ynmlo1VGvdOsr5K+CG6Fvgq06mcXPCqGYbspAl+row
         ctA6dYotmWf1l94nnDkI8SZ7UfcP2aIhHUtnCRGwWuYHk9K1XIGZ705PuBNrYVqkRKRa
         Q9oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VgcMNko7l5DJIOfJtBTvwoP7PJiZ+4kcBGir77liTPA=;
        b=S0DOxpgaWxA+gcS4QwpeKTznnqQx19S2IPXzU6HpO77NIFgr7N+45ozQfwVdFf3sKD
         QZoVx4lLRc+s5YuvWS6kjBDllsUdYoAlZ8GjbM81+SwBWFR7G2ITBJx8FBUsynDmixCg
         M3hbr/CW0yigHzYv34CC012IpjKJ2KsQYW+ajh2v5TEomUlR226wsv0xJm0Mb3DnyDvK
         0qMU9uHrAfLSonjeDnpqxTy0IVugASrsXJpqYeU4TKpW8jFZ6AwAXRqfo2BQm/VMDoDJ
         WVFmVcnacobmZPkKL+MEChiFJJN9jNSq3jyRcL83teJ+ndzaLeBznSgfVcyg0jFFVDHe
         HF6Q==
X-Gm-Message-State: APjAAAU5Z3B95DSySTWMHqmeE/EYvz1e98fhWOfrG8TvzKZfrz9rT7Ay
        rk9qRl44rZmo5JosTapvEWWVmBeETTo=
X-Google-Smtp-Source: APXvYqxZqzHJXhhJXdXNIpcFLn0NThTXvXz6EFddtvJ5mAXC4BIIzdR995QI37SmueFCsaIyIms1Fg==
X-Received: by 2002:a5d:5310:: with SMTP id e16mr15703488wrv.142.1555091394103;
        Fri, 12 Apr 2019 10:49:54 -0700 (PDT)
Received: from [192.168.20.141] ([194.99.104.18])
        by smtp.gmail.com with ESMTPSA id y1sm117900473wrd.34.2019.04.12.10.49.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Apr 2019 10:49:53 -0700 (PDT)
Subject: Re: [PATCH 01/11] platform/x86: asus-wmi: Fix hwmon device cleanup
To:     Daniel Drake <drake@endlessm.com>
Cc:     Corentin Chary <corentin.chary@gmail.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        acpi4asus-user <acpi4asus-user@lists.sourceforge.net>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>
References: <a8dd77f3-1e28-6416-5f04-aff44d5bb6d6@gmail.com>
 <f2822519-c137-560e-fe78-172202e52bfa@gmail.com>
 <CAD8Lp465z=HB5kKZEk7eHd9NVdhSLYhzgiH6Yg45v=j0TCU+SQ@mail.gmail.com>
From:   Yurii Pavlovskyi <yurii.pavlovskyi@gmail.com>
Message-ID: <3e14cbf9-2cb0-1a5d-9c2f-aa9ca014c660@gmail.com>
Date:   Fri, 12 Apr 2019 19:49:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAD8Lp465z=HB5kKZEk7eHd9NVdhSLYhzgiH6Yg45v=j0TCU+SQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Daniel,

thank you for the tip. I did not know about this function. It does indeed
seem to make this complete patch redundant looking at
6e5f62b9e3651e61 hwmon: (lm90) Use devm_hwmon_device_register_with_groups

I will surely implement it this way in the next version.

Best regards,
Yurii

On 11.04.19 10:21, Daniel Drake wrote:
> On Thu, Apr 11, 2019 at 4:21 AM Yurii Pavlovskyi
> <yurii.pavlovskyi@gmail.com> wrote:
>>
>> The asus-wmi driver does not clean up the hwmon device on exit or error.
>> To reproduce the bug, repeat rmmod, insmod to verify that device number
>> /sys/devices/platform/asus-nb-wmi/hwmon/hwmon?? grows every time. Add
>> pointer to the device in module state and call cleanup on error.
> 
> I wonder if this can be fixed more cleanly by using
> devm_hwmon_device_register_with_groups() ?
> 
> Thanks
> Daniel
> 
