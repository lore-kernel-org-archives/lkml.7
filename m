Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DC43C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 16:54:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BC0E2184D
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 16:54:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727210AbfCTQyZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 12:54:25 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:50254 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726802AbfCTQyY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 12:54:24 -0400
Received: from mail-pg1-f197.google.com ([209.85.215.197])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1h6eTJ-0003Qg-4k
        for linux-kernel@vger.kernel.org; Wed, 20 Mar 2019 16:53:45 +0000
Received: by mail-pg1-f197.google.com with SMTP id m17so3233481pgk.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2019 09:53:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=dxJWoIz0OohpqrsgAAAJ3mxbTeSGS7Rzl2WL0VnK300=;
        b=aLr5qyV//78C9baOepFEy7U6EhtEQvF9SkKuZBuECKrJo05CZcu1+wPlj3Qjjf0kMG
         dQ2hFWY8IYlFtTmcFPQF6fyFdUBQB/m9wsrmW6mVD+B+jO9GwmAQ6xU5sguRb5glj2Gm
         lnW0X26EXUyUARLPF3hxrkxUsRoxsC7/gJOZrUeR0EAI1HOCe1VWv0pytp7sT3PSQzY3
         KTMYiQqQrnwaK86v212Q/S196vWCmqEzVDYrl/cn55v7pZaxHTbnffbQa/xWNDt+ijms
         zDOMfrtlZMdeUJQhcZ1Opua57Kp7+ikuB9FDsw42U9G88kWjSM0cL8kX0kjfJ3SPZWiE
         0Yvg==
X-Gm-Message-State: APjAAAXpZO+EDlSCX2lD/Oq5VRTemSn8l2swIc8XlIrPv08rLoNxMG1Z
        MoTcHTc4B7On4uFf3U5I4/i5QL9RslQ6hz3hq9WvTPZw6CkBmQ0krvB+TOqbYn3nNWUC4Esxg+a
        JWEqDd5at03cqMA1Ul7cr2e3/syM1HRjpy4xgjIJFuA==
X-Received: by 2002:a65:5c87:: with SMTP id a7mr8129965pgt.356.1553100823329;
        Wed, 20 Mar 2019 09:53:43 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwHB/+dd/lqWqIqjwOaWCqgHfdXaZZZjOepfhrDP4vLzhhTpyOKNJPD77MauIhj/1+NBYVyVA==
X-Received: by 2002:a65:5c87:: with SMTP id a7mr8129934pgt.356.1553100822861;
        Wed, 20 Mar 2019 09:53:42 -0700 (PDT)
Received: from 2001-b011-380f-14b9-3545-ed86-5779-c442.dynamic-ip6.hinet.net (2001-b011-380f-14b9-3545-ed86-5779-c442.dynamic-ip6.hinet.net. [2001:b011:380f:14b9:3545:ed86:5779:c442])
        by smtp.gmail.com with ESMTPSA id k26sm3152435pfo.111.2019.03.20.09.53.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Mar 2019 09:53:42 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8;
        delsp=yes;
        format=flowed
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH] ELAN touchpad i2c_hid bugs fix
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <9151d116-958c-9298-9427-fe803a163e9f@redhat.com>
Date:   Thu, 21 Mar 2019 00:53:39 +0800
Cc:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        hotwater438@tutanota.com, Jiri Kosina <jikos@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>, bigeasy@linutronix.de,
        Dmitry Torokhov <dtor@chromium.org>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 8bit
Message-Id: <F03846A5-6C42-4290-AF72-F644C809A50A@canonical.com>
References: <LaQHUFs--3-1@tutanota.com>
 <CAO-hwJLGABHATo-fOc_jgc8uNeLDv7cemsHuQMj7zRJWmfyp4g@mail.gmail.com>
 <9151d116-958c-9298-9427-fe803a163e9f@redhat.com>
To:     Hans de Goede <hdegoede@redhat.com>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hans,

at 23:39, Hans de Goede <hdegoede@redhat.com> wrote:

> H,
>
> On 3/20/19 3:37 PM, Benjamin Tissoires wrote:
>
> <snip>
>
>>> The reason why i2c_hid_init_irq was moved is told by Hans De Goede
>>> <hdegoede@redhat.com>:
>>> i2c_hid_init_irq now checks for a quirk, so we must setup the quirks  
>>> before we init the irq, and we cannot setup the quirk earlier, so we  
>>> must init the irq later.
>> I am pretty sure you can paraphrase Hans in your commit message
>> without having to formally quote him (Hans, please shout if you
>> disagree).
>
> Right, it is fine to explain why the irq init is moved without
> quoting or even referring to me.
>
>>> --- a/drivers/hid/hid-ids.h
>>> +++ b/drivers/hid/hid-ids.h
>>> @@ -389,6 +389,7 @@
>>> #define USB_DEVICE_ID_TOSHIBA_CLICK_L9W 0x0401
>>> #define USB_DEVICE_ID_HP_X2 0x074d
>>> #define USB_DEVICE_ID_HP_X2_10_COVER 0x0755
>>> +#define USB_DEVICE_ID_ELAN_TOUCHPAD 0x303e
>> I know Hans wanted you to use USB here, but I'd think we should have a
>> I2C_DEVICE_ID_*
>> There is no guarantees that this same PID will be used in a different
>> chip over USB.
>> We tend to not car about USB/I2C for the vendor IDs: the vendors
>> decided to reuse their USB VID, which makes our life easier.
>
> Ok, no objection from me to use an I2C_DEVICE_ID prefix, here it
> is after all an I2C device.
>
>>> #define USB_VENDOR_ID_ELECOM 0x056e
>>> #define USB_DEVICE_ID_ELECOM_BM084 0x0061
>>> diff --git a/drivers/hid/i2c-hid/i2c-hid-core.c  
>>> b/drivers/hid/i2c-hid/i2c-hid-core.c
>>> index 90164fed08d3..16b55c45e2e8 100644
>>> --- a/drivers/hid/i2c-hid/i2c-hid-core.c
>>> +++ b/drivers/hid/i2c-hid/i2c-hid-core.c
>>> @@ -50,7 +50,8 @@
>>> #define I2C_HID_QUIRK_NO_IRQ_AFTER_RESET BIT(1)
>>> #define I2C_HID_QUIRK_NO_RUNTIME_PM BIT(2)
>>> #define I2C_HID_QUIRK_DELAY_AFTER_SLEEP BIT(3)
>>> -#define I2C_HID_QUIRK_BOGUS_IRQ BIT(4)
>>> +#define I2C_HID_QUIRK_BOGUS_IRQ BIT(4)
>>> +#define I2C_HID_QUIRK_FORCE_TRIGGER_FALLING BIT(5)
>>>
>>> /* flags */
>>> #define I2C_HID_STARTED 0
>>> @@ -182,8 +183,10 @@ static const struct i2c_hid_quirks {
>>> I2C_HID_QUIRK_NO_RUNTIME_PM },
>>> { I2C_VENDOR_ID_GOODIX, I2C_DEVICE_ID_GOODIX_01F0,
>>> I2C_HID_QUIRK_NO_RUNTIME_PM },
>>> + { USB_VENDOR_ID_ELAN, USB_DEVICE_ID_ELAN_TOUCHPAD,
>>> + I2C_HID_QUIRK_BOGUS_IRQ | I2C_HID_QUIRK_FORCE_TRIGGER_FALLING },
>>> { USB_VENDOR_ID_ELAN, HID_ANY_ID,
>>> - I2C_HID_QUIRK_BOGUS_IRQ },
>>> + I2C_HID_QUIRK_BOGUS_IRQ },
>
> Benjamin, what I find interesting here is that the BOGUS_IRQ quirk
> is also used on Elan devices, I suspect that these Elan devices
> likely also need the I2C_HID_QUIRK_FORCE_TRIGGER_FALLING quirk
> and then they probably will no longer need the bogus IRQ flag,
> if you know about bugreports with an acpidump for any of the devices
> needing the bogus IRQ quirk, then I (or you) can check how the IRQ is
> declared there, I suspect it will be declared as level-low, just like
> with the laptop this patch was written for. And it probably need to
> be edge-falling instead of level-low just like this case.

First, I’ve already tried using IRQF_TRIGGER_FALLING, unfortunately it  
doesn’t solve the issue for me.

I talked to Elan once, and they confirm the correct IRQ trigger is level  
low. So forcing falling trigger may break other platforms.

Recently we found that Elan touchpad doesn’t like GpioInt() from its _CRS.  
Once the Interrupt() is used instead, the issue goes away.

But I am not sure how to patch its DSDT/SSDT in i2c-hid.

Kai-Heng

>
> Regards,
>
> Hans


