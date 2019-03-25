Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE242C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 08:58:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFAD720879
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 08:58:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730120AbfCYI6Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 04:58:16 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:42166 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730043AbfCYI6Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 04:58:16 -0400
Received: by mail-ed1-f68.google.com with SMTP id x61so1101360edc.9
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 01:58:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=sUxhpw2ykPU///z75+PZyHry3xp49RL40JZfcUI7I10=;
        b=lV10wRL0wLt79WD6aw4hayPoRZi9Ohl/rVSFqgoBiqG7osTsNdCcCUYgV6Jbyi28gF
         oGmope+Ud89Zss/arl+FEo46I7nxdc5XjZ/HWNVhPC1iDh/f47f5dz4PoMRIWVBzvq1/
         9hWMTksdjhLQvVW6iqa55o2TIxD7pW83yeFNxyz783L1SN+dtPRTC/6c/Hhq44rCbR0m
         J1MmEiR1+umU/OzdUAsYDm4EgQCHlUcNqtsE0ZSlXOklAZ/ZHcEXy9c/BLwvDSrbYTHI
         O5oSGUH4MtpBCIhYnSMWxJ+eqsOeI0yvFg5lWCN8nAvxN2GbNhF56LioeCfcgHphyTQK
         MrLg==
X-Gm-Message-State: APjAAAX8DwIoPdHESMjykceSzEadDDEoa89jvbYffC8RiJnTd1rhyqxh
        oAUxcpYXPCGnRXT8+X/D9lTrZw==
X-Google-Smtp-Source: APXvYqxkWCY8LlwYVdjq+G0FIRoYR5hRF2hrkFVtTiZdL1ogze2+lhLlQUASrxFZq+HTuANOVz2EeQ==
X-Received: by 2002:a50:eac9:: with SMTP id u9mr5063737edp.159.1553504293735;
        Mon, 25 Mar 2019 01:58:13 -0700 (PDT)
Received: from shalem.localdomain (84-106-84-65.cable.dynamic.v4.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id c57sm5404276ede.28.2019.03.25.01.58.12
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Mar 2019 01:58:13 -0700 (PDT)
Subject: Re: [linux-sunxi] Re: [PATCH v3 3/9] power: supply: axp20x_usb_power:
 allow disabling input current limiting
To:     Chen-Yu Tsai <wens@kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>
References: <20190321084850.20769-1-wens@kernel.org>
 <20190321084850.20769-4-wens@kernel.org>
 <20190321093012.kg72voxs5kw5xtzu@flea>
 <CAGb2v66bh0UXcjScHRL5U4f_mBALDN6Vckt=9sjziz09qygcxA@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <3a896485-d7d4-e221-6e66-34bbdb0c0f6e@redhat.com>
Date:   Mon, 25 Mar 2019 09:58:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.0
MIME-Version: 1.0
In-Reply-To: <CAGb2v66bh0UXcjScHRL5U4f_mBALDN6Vckt=9sjziz09qygcxA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 25-03-19 03:45, Chen-Yu Tsai wrote:
> On Thu, Mar 21, 2019 at 5:30 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
>>
>> Hi,
>>
>> The rest of the series is
>> Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>
>>
>> On Thu, Mar 21, 2019 at 04:48:44PM +0800, Chen-Yu Tsai wrote:
>>> From: Chen-Yu Tsai <wens@csie.org>
>>>
>>> The AXP PMICs allow the user to disable current limiting on the VBUS
>>> input. While read-out of this setting was already supported by the
>>> driver, it did not allow the user to configure the PMIC to disable
>>> current limiting.
>>>
>>> Add support for this.
>>>
>>> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
>>
>> Do we really want to do that though? That could have some pretty bad
>> consequences.
> 
> If I understand the manual correctly, the PMIC has two mode of operation
> with regards to VBUS. Normal operation means the PMIC will try to limit
> the current draw to maintain VBUS above the set V_hold (defaults to 4.4V).
> This is in addition to the current limit set in this patch.
> 
> The other mode of operation is bypass, where it ignores the voltage limit.
> Not sure if it also ignores the current limit, but probably not. In any
> case we don't support this mode in the driver.
> 
> So I can think of a few cases where this might be bad:
> 
> 1. High current draw results in excessive voltage drop and heating over
>     line / traces due to insufficient conductor area. This should be covered
>     by the voltage holding mechanism.
> 
> 2. Over taxing the external power supply. This should also result in some
>     voltage drop for simple power bricks. Advanced ones would either have
>     current limiting or over-current protection.
> 
> What bad consequences are you thinking of?

Lets say you use a typical 5v / 2A charger-plug, lets also say that at full
load this brick has an efficiency of 90%. At full load it delivers 10W of
power, while consuming 11.1W dissipating 1.1W of losses as heat.

Now lets say we disable current-limiting and rely only on the V_hold
mechanism, lets say that we end up with 4.5 volts at 2.4 amps because of
this and since we are now operating in overload conditions the
efficiency has fallen to 80% (approx. 4.5/5.0 * 90%) so now at full load
it delivers 10.8W of power, while consuming 13.5W dissipating 2.7W of
losses as heat. Chances are the the small plastic enclosure of your
typical charger-plug cannot dissipate this much and will start warming
up, until it bursts into flames.

Disabling current limit protection is a very bad idea because you will
end up in an equilibrium between the Vhold from the charger-ic and the
over-current protection from the power-brick where you are over the
design limit of the power-brick.

I actually like what the TI charger-ics are doing here a lot more then
what the AXP series is doing, with TI charger-ics if you set a current
limit > 500mA and the power-brick's voltages drops too much because of
this (or because of a bad cable) it automatically falls back to 500mA.
Where as at least with the AXP288, it simply starts drawing 1.5A at 4.5V
with a bad cable, but in this case the dissipation at least is happening
inside the cable rather then inside the charger-plug, which typically
already gets quite hot under normal operation conditions.

Disabling the current limit is basically the same as what bad USB-A
to USB-C cables which have a Rp-3.0 resistor in the C plug do, these tell
the device with the Type-C plug it can safely draw 3A from the A-port the
A plug is plugged into. The web is full of stories about this causing
damage to machines, e.g.:

"Bohn's Nexus 6P drew too much power from his MacBook Air while using a third-party cord, frying the machine and making the USB Type-C ports work only intermittently."

From: https://www.laptopmag.com/articles/how-to-find-safe-usb-type-c-cables

Another good link about the problems caused by these bad Rp resistor
values in Type-C to Type-A cables (which also effectively disable the
current-limit on the device charging on the C-end of the cable):
https://plus.google.com/102617628172847077584/posts/HakwCMmd346

Note this second link is going away in 6 days as google is retiring
google+.

Anyways TL;DR: Disabling the current-limit is a bad idea and really
nothing good can come from this.

Regards,

Hans


