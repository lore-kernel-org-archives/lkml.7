Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3A12C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 08:57:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B462C2075E
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 08:57:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727977AbfCUI5l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 04:57:41 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:33616 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727841AbfCUI5k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 04:57:40 -0400
Received: by mail-ed1-f68.google.com with SMTP id q3so4347710edg.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2019 01:57:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Y5jCUnbj6iQhkm10NxgJNW0hnyPWa4m3NIxxLinn2oY=;
        b=bE2mdbzBzrI1UX9mE4h+o1oHKg6l8x3UyjWf2RirjRghm6dLll+pdlmnSxp1vOUzd5
         BRTJiNdVi8U5eiPt22gxcrkTt+h0fUlNWWTSLmKP8Y5ctQIASDba5IGc16c4L6wH3U+A
         MekkrrTPfh9rEt6GDE7jaow0vIQ2LmYg5/VAQT1N/dloSS+ftQft/iDQf9ot7xdtsud2
         2I6Z4VKKiQQZH3mrhJDkTixLWM2djIxEMMXE5/hLHTU3V1rfqgy/I7BSNOie5WAavk0+
         TsOGUu9ZpEMg6gzsA378bYIT8OpnL76p+31It1U/yAr/aGFq0nFcjwbHNmGWUwD5Y6G+
         epEA==
X-Gm-Message-State: APjAAAWjUrDKns0MjCf+V909sgFDdgAky5O38sOngBJXN5SXt5ENrQ/n
        YEljDbAWYHdJRVZ6DF7ouo/Q2z4bi6k=
X-Google-Smtp-Source: APXvYqwseQe3Txw/ujmaVTi2HdOPM21Tg44TcTrPQnyAg1HFHos+ZjWGPV9FL/Y7LICJxAHos3lTkw==
X-Received: by 2002:aa7:d1d0:: with SMTP id g16mr1728434edp.109.1553158658408;
        Thu, 21 Mar 2019 01:57:38 -0700 (PDT)
Received: from shalem.localdomain (546A5441.cm-12-3b.dynamic.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id d2sm922440ejk.38.2019.03.21.01.57.37
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Mar 2019 01:57:37 -0700 (PDT)
Subject: Re: [PATCH] ELAN touchpad i2c_hid bugs fix
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        hotwater438@tutanota.com, Jiri Kosina <jikos@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Dmitry Torokhov <dtor@chromium.org>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
References: <LaQHUFs--3-1@tutanota.com>
 <CAO-hwJLGABHATo-fOc_jgc8uNeLDv7cemsHuQMj7zRJWmfyp4g@mail.gmail.com>
 <9151d116-958c-9298-9427-fe803a163e9f@redhat.com>
 <F03846A5-6C42-4290-AF72-F644C809A50A@canonical.com>
 <CAHp75VcOG9H8u+tZyNN682r7+jsRZi8VoPPZ2uJPch1gNyFgmQ@mail.gmail.com>
 <220FEDBD-9A71-4C14-A7D6-3850D515865F@canonical.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <7ea678f8-a467-2fc1-42f6-89c5b7f1718c@redhat.com>
Date:   Thu, 21 Mar 2019 09:57:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.3
MIME-Version: 1.0
In-Reply-To: <220FEDBD-9A71-4C14-A7D6-3850D515865F@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 21-03-19 05:08, Kai-Heng Feng wrote:
> at 01:18, Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> 
>> On Wed, Mar 20, 2019 at 6:55 PM Kai-Heng Feng
>> <kai.heng.feng@canonical.com> wrote:
>>> at 23:39, Hans de Goede <hdegoede@redhat.com> wrote:
>>>> On 3/20/19 3:37 PM, Benjamin Tissoires wrote:
>>
>>>> Benjamin, what I find interesting here is that the BOGUS_IRQ quirk
>>>> is also used on Elan devices, I suspect that these Elan devices
>>>> likely also need the I2C_HID_QUIRK_FORCE_TRIGGER_FALLING quirk
>>>> and then they probably will no longer need the bogus IRQ flag,
>>>> if you know about bugreports with an acpidump for any of the devices
>>>> needing the bogus IRQ quirk, then I (or you) can check how the IRQ is
>>>> declared there, I suspect it will be declared as level-low, just like
>>>> with the laptop this patch was written for. And it probably need to
>>>> be edge-falling instead of level-low just like this case.
>>>
>>> First, I’ve already tried using IRQF_TRIGGER_FALLING, unfortunately it
>>> doesn’t solve the issue for me.
>>>
>>> I talked to Elan once, and they confirm the correct IRQ trigger is level
>>> low. So forcing falling trigger may break other platforms.
>>
>> As far as I understood Vladislav the quirk he got from Elan as well.
> 
> Ok, then this is really weird.
> 
>>
>>> Recently we found that Elan touchpad doesn’t like GpioInt() from its _CRS.
>>> Once the Interrupt() is used instead, the issue goes away.
>>
>> IIRC i2c core tries to get interrupt from Interrupt() resource and
>> then falls back to GpioInt().
>> See i2c_acpi_get_info() and i2c_device_probe().
> 
> Here’s its ASL:
> 
>      Scope (\_SB.PCI0.I2C4)
>      {
>          Device (TPD0)
>          {
>              Name (_ADR, One)  // _ADR: Address
>              Name (_HID, "DELL08AE")  // _HID: Hardware ID
>              Name (_CID, "PNP0C50" /* HID Protocol Device (I2C bus) */)  // _CID: Compatible ID
>              Name (_UID, One)  // _UID: Unique ID
>              Name (_S0W, 0x04)  // _S0W: S0 Device Wake State
>              Name (SBFB, ResourceTemplate ()
>              {
>                  I2cSerialBusV2 (0x002C, ControllerInitiated, 0x00061A80,
>                      AddressingMode7Bit, "\\_SB.PCI0.I2C4",
>                      0x00, ResourceConsumer, , Exclusive,
>                      )
>              })
>              Name (SBFG, ResourceTemplate ()
>              {
>                  GpioInt (Level, ActiveLow, ExclusiveAndWake, PullUp, 0x0000,
>                      "\\_SB.GPO1", 0x00, ResourceConsumer, ,
>                      )
>                      {   // Pin list
>                          0x0012
>                      }
>              })
>              Name (SBFI, ResourceTemplate ()
>              {
>                  Interrupt (ResourceConsumer, Level, ActiveLow, ExclusiveAndWake, ,, )
>                  {
>                      0x0000003C,
>                  }
>              })

OK, so both interrupt definitions declare the interrupt as Level, ActiveLow, so forcing
falling-edge here *might* help too.

Regards,

Hans

