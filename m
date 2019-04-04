Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7D9EC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 18:48:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7517E20657
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 18:48:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KvFX4Kgh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730016AbfDDSso (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 14:48:44 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:46994 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727398AbfDDSso (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 14:48:44 -0400
Received: by mail-lf1-f68.google.com with SMTP id r25so2526712lfn.13;
        Thu, 04 Apr 2019 11:48:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=CbQ1/qZ4MVf6FqHTg8C0Lq5KKGzXWo9GvZYsM+qwvNE=;
        b=KvFX4KghzayWZJ80TDY84sZNp9DtdXo33KAPQgENuvfwx+vRDZx91Z5IS3UrkBi5Lr
         nPJCDndUuqPDGNjQfQ/HHJ3Wk4HRxzvzs2X2RzfW3uyGkTDw7lL0bd2OIr2DyP7uZKOt
         jQL1natlMcdmccABNj6mJ3HqU+64KFy39f3ph33kyhwNSveoYkc77wbsw1vFcTQcnweO
         S87IHfgTdpaU72GsD1v/NfPrOznjthpBbsuDh1JsDwnPv5Y4HEZ6b/JcFW5SYeR98y4M
         HRaCj0VYR8EH2BvgqzMXHB7/0JvKO9f1bs5KzVVFa40efw+Gu1OErCSSBhFqHVz1CXW4
         k24Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CbQ1/qZ4MVf6FqHTg8C0Lq5KKGzXWo9GvZYsM+qwvNE=;
        b=YFOVti9msjpCvz0Gm3TEkH4eIeI1M58YVhRvekP7GwkI8ahk0O69EVoEiGKddYDXXo
         viJNpTkl7wwnF/T1vODM42Y8ZJD4ShrxwNTeVR8XNohJjkQGxcv6tXo7uiUt13qa91SS
         nGv3CCf1d7lPlHerCsRcon0aIX56OkFVOSkZ0zPc4IMlB0B/6AWor2Qhmv8Di8purpow
         U7QLC/0YU4xH8rC/zwwRRpGKof55cYkf1PVlUqWgBtV5MJrXrihKRTCizeFwrzySJGbP
         4xq653jF6I55d+1uWLmvTwydjkOlciu6OqgdK8BLkn4GGoWWII6goVmiTSEwsfqPLybf
         3UjA==
X-Gm-Message-State: APjAAAWuq5gacPIAq+31WneoLRHGykRoOu0yNpnglzDvU75gRc9lYMdi
        tzwsWVFu7wSds5hKBsfhg4+X1cMR
X-Google-Smtp-Source: APXvYqwEfTlrdJxtSDZYdf6Tc02WeA8Eamd0tW3lLjoFicL+olb4TS15VwotcdyEIxzYfdwkiQ6l/Q==
X-Received: by 2002:ac2:5325:: with SMTP id f5mr4406521lfh.77.1554403721863;
        Thu, 04 Apr 2019 11:48:41 -0700 (PDT)
Received: from [192.168.1.19] (dkj99.neoplus.adsl.tpnet.pl. [83.24.13.99])
        by smtp.gmail.com with ESMTPSA id z83sm4179863ljb.48.2019.04.04.11.48.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Apr 2019 11:48:40 -0700 (PDT)
Subject: Re: [PATCH 4/4] leds: lm3532: Introduce the lm3532 LED driver
To:     Tony Lindgren <tony@atomide.com>, Dan Murphy <dmurphy@ti.com>
Cc:     robh+dt@kernel.org, pavel@ucw.cz, lee.jones@linaro.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-leds@vger.kernel.org, Sebastian Reichel <sre@kernel.org>
References: <20190321142838.22985-1-dmurphy@ti.com>
 <20190321142838.22985-4-dmurphy@ti.com> <20190404000909.GY49658@atomide.com>
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
Message-ID: <f4c0a946-fd0f-0071-0039-cfaea2f27ccc@gmail.com>
Date:   Thu, 4 Apr 2019 20:48:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190404000909.GY49658@atomide.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tony,

Thanks for the feedback.

On 4/4/19 2:09 AM, Tony Lindgren wrote:
> * Dan Murphy <dmurphy@ti.com> [190321 14:29]:
>> Introduce the Texas Instruments LM3532 White LED driver.
>> The driver supports ALS configurability or manual brightness
>> control.
>>
>> The driver also supports associating LED strings with specific
>> control banks in a group or as individually controlled strings.
> 
> I'm seeing slightly different naming under /sys/class/leds:
> 
> lm3532:backlight
> lm3532:platform::kbd_backlight

The problem is in the "platform:" being a part of DT
label property. It should not be included there if devicename
section is added in the driver.

> 
> Not sure if this is correct with the the "platform" and
> "::" there for the kbd_backlight?
> 
> With the dts change I posted, I've tested this with
> linux-next and Sebastian's DSI command mode patches
> "[PATCHv6 0/4] omapdrm: DSI command mode panel support".
> 
> So feel free to add:
> 
> Tested-by: Tony Lindgren <tony@atomide.com>
> 

-- 
Best regards,
Jacek Anaszewski
