Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93009C47E49
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 08:52:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67CC420684
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 08:52:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rrxFfBuN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438486AbfJXIwG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 04:52:06 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:46134 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730467AbfJXIwE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 04:52:04 -0400
Received: by mail-pl1-f194.google.com with SMTP id q21so3444120plr.13;
        Thu, 24 Oct 2019 01:52:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=uPX6O9l+kuYjBcPYdh37KOiS7f3AWvLRqvSNRDK/hlY=;
        b=rrxFfBuNj1V+uFY7mLjfFUPtV4lB6aOMWJC30bQxiPaE9cV/lD9sVOk3SIk3xxu0UX
         7F6JWvBWNVcMfeQWKPE8B5LBRJjebHT/fuosPKegNwFQzyIYFqbONhmfvmuGJ4lcZfxN
         MDyqg014EdBJuLkMqaIOgHYKfC8AYe+RSXf2U0eV33pxwwElrd7XoEzdWfO0gI2utY+f
         2uNL8ed8lY1uV4upV/zKMvG/NspEHAmx+GchOcN00B0baykx4rU66sP4SS9BkTDBMdRV
         25+LfK7LnYZKNtfAg4wEHKm85FsLkusC2tgS3ToH08UFikNjzerI4RCY9jdRwyBgtwdb
         pgsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=uPX6O9l+kuYjBcPYdh37KOiS7f3AWvLRqvSNRDK/hlY=;
        b=Pp7aTGlLmlj69k73EB4mIzKLJsspL7zQ11zRs/Tj+Slgr3TtCi4ZuOP7S1n2aYLcB1
         AomH5N7XunEwzrWWxuz7LM26PUMb9hTdHNEyGUtcceHS43f6tj1otwrnBhmyhbIFxQpL
         WzFWKY30QiCG7JMzKI4ZITb0s4BXSbQoBzp3/CfT9ZhhMMAd7jnXYbS+7PKZQAAXEDaf
         kX5h9bL1wf7/5MVXDjARPKAlCa+1Wwxozf7fczPUXIwCqW60QLh9pg4z9i+TVrvDK5d5
         Clzds1qJEeP5ZkiZeQbtGfzn/udA2+o1Z5IodxKh6pFFmMSo49EoXHPY8CgySm6Cz1me
         odUg==
X-Gm-Message-State: APjAAAWG/pPwv+v+EHnlliDcfkibmj/d5HRh6NiAQ7WJ6de33PHBLZqI
        nLd+/DG1pAIi1wNYfEkuo+o=
X-Google-Smtp-Source: APXvYqwhJuw0T1sHz53pKJca5ZWdTYoQJUWebP9bGeR93OHzONyszouIpVMtloMWhRzOz/GbyuihGw==
X-Received: by 2002:a17:902:b60a:: with SMTP id b10mr15125831pls.130.1571907123451;
        Thu, 24 Oct 2019 01:52:03 -0700 (PDT)
Received: from [192.168.1.60] (59-120-186-245.HINET-IP.hinet.net. [59.120.186.245])
        by smtp.gmail.com with ESMTPSA id s191sm23097338pgc.94.2019.10.24.01.52.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 24 Oct 2019 01:52:02 -0700 (PDT)
Subject: Re: [PATCH V2 5/7] USB: serial: f81232: Set F81534A serial port with
 RS232 mode
To:     Johan Hovold <johan@kernel.org>
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, peter_hong@fintek.com.tw,
        "Ji-Ze Hong (Peter Hong)" <hpeter+linux_kernel@gmail.com>
References: <20190923022449.10952-1-hpeter+linux_kernel@gmail.com>
 <20190923022449.10952-6-hpeter+linux_kernel@gmail.com>
 <20191023115300.GU24768@localhost>
From:   "Ji-Ze Hong (Peter Hong)" <hpeter@gmail.com>
Message-ID: <f3a8b0bd-79f7-3bef-4d07-69774c87873a@gmail.com>
Date:   Thu, 24 Oct 2019 16:52:01 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191023115300.GU24768@localhost>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Johan,

Johan Hovold 於 2019/10/23 下午 07:53 寫道:
> On Mon, Sep 23, 2019 at 10:24:47AM +0800, Ji-Ze Hong (Peter Hong) wrote:
>> The Fintek F81532A/534A/535/536 is USB-to-2/4/8/12 serial ports device
>> and the serial ports are default disabled. Each port contains max 3 pins
>> GPIO and the 3 pins are default pull high with input mode.
>>
>> When the serial port had activated (running probe()), we'll transform the
>> 3 pins from GPIO function publicly to control Tranceiver privately use.
> 
> I'm not sure I understand what you're saying here.
> 
>> We'll default set to 0/0/1 for control transceiver to RS232 mode.
>>
>> Otherwise, If the serial port is not active, the 3 pins is in GPIO mode
>> and controlled by global GPIO device with VID/PID: 2c42/16f8.
> 
> Does this mean that you can control the three GPIOs either through the
> serial device or through the gpio-control device (which are two separate
> USB devices)?
> 

Yes, when 1 F81534A connect to Host, it'll report device as following.
	virtual HUB
		GPIO Device.
		serial port 1
		...
		serial port n

The link are F81534A pin-out:
	https://imgur.com/a/AZHqQ1N

So we can control F81534A series all GPIO pins via GPIO Device.
Serial ports are also control MODE0_x,  MODE1_x,  MODE2_x
(e.g. UART1 MODE0_1,  MODE1_1,  MODE2_1), but when Serial ports
is h/w disabled (DTR pull low), the mode pin will change to GPIO pin.


> Ok, so you reset the tranceiver config on every probe.
> 
> Are the three GPIOs always connected to one particular tranceiver, or
> are they truly general purpose?
> 
> In the latter case, it doesn't seem like a good idea to drive pins 0
> and 1 low here as you have know idea what they're used for.

If we want to change the mode pin to GPIO pin, it need do h/w disable.
It the serial ports are activated, the 3 pin will be mode pin and set
default 0/0/1 to RS232 mode due to this driver not implement RS422/485
currently.

Thanks
-- 
With Best Regards,
Peter Hong
