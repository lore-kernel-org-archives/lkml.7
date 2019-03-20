Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DE5DC10F05
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 15:39:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 288302146E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 15:39:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726822AbfCTPjU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 11:39:20 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:32781 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726366AbfCTPjT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 11:39:19 -0400
Received: by mail-ed1-f66.google.com with SMTP id q3so2413325edg.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2019 08:39:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=62VLVo9ABf0jtPa4TzMUQ9DHUwZre85OLRzDR12CTrc=;
        b=F68q8dX3tuABmJ3H36det7sUv+0IFnM5z60wggqxoHJx4yR4XGJgUZSvuDP4icv6Qy
         qoxdqSHlL0nlILRmq28wJcF9DUyW5XloOhhmUe6e217SJjkVC2PGujPJSUbHdEwmfkwB
         CeL3BlBVQS3HJHQ2RCov9udcjj46sY7Y1Ehwoht8mjWSzInZayipZxmBeKeF3iNQ+WRa
         e2mmM1ob50PgsKLJjcXkdOr/oGv4dfwrxMeMle2MUzKms6lf4DZgPyStXSA5N7HL0Ph3
         71qbJ6bFPgf1N6Zw0ZNo5JVWX7z6AVblxMv/QseOaNR2b7TmQgjPEVCsQOPS5a7YOP0E
         JBaQ==
X-Gm-Message-State: APjAAAW42byN8SMbMYCJwRaTfEJYWErPwauy64JCKfWa/nYeZby+JDFR
        qXLMkvC6rfaFo/GwVA/1dAoum23sbEU=
X-Google-Smtp-Source: APXvYqzy/vBorwIWC6Dyg7zYDSxdgkfEfu2ris5nGjCalBERgIextY97V8BE1APuZQ8tC1Hspb7y9w==
X-Received: by 2002:a17:906:2a86:: with SMTP id l6mr17227436eje.186.1553096358204;
        Wed, 20 Mar 2019 08:39:18 -0700 (PDT)
Received: from localhost.localdomain (546A5441.cm-12-3b.dynamic.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id k32sm754087ede.97.2019.03.20.08.39.16
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Mar 2019 08:39:17 -0700 (PDT)
Subject: Re: [PATCH] ELAN touchpad i2c_hid bugs fix
To:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        hotwater438@tutanota.com
Cc:     Jiri Kosina <jikos@kernel.org>,
        Kai Heng Feng <kai.heng.feng@canonical.com>,
        Stephen Boyd <swboyd@chromium.org>, bigeasy@linutronix.de,
        Dmitry Torokhov <dtor@chromium.org>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
References: <LaQHUFs--3-1@tutanota.com>
 <CAO-hwJLGABHATo-fOc_jgc8uNeLDv7cemsHuQMj7zRJWmfyp4g@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <9151d116-958c-9298-9427-fe803a163e9f@redhat.com>
Date:   Wed, 20 Mar 2019 16:39:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <CAO-hwJLGABHATo-fOc_jgc8uNeLDv7cemsHuQMj7zRJWmfyp4g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

H,

On 3/20/19 3:37 PM, Benjamin Tissoires wrote:

<snip>

>> The reason why i2c_hid_init_irq was moved is told by Hans De Goede
>> <hdegoede@redhat.com>:
>> i2c_hid_init_irq now checks for a quirk, so we must setup the quirks before we init the irq, and we cannot setup the quirk earlier, so we must init the irq later.
> 
> I am pretty sure you can paraphrase Hans in your commit message
> without having to formally quote him (Hans, please shout if you
> disagree).

Right, it is fine to explain why the irq init is moved without
quoting or even referring to me.

>> --- a/drivers/hid/hid-ids.h
>> +++ b/drivers/hid/hid-ids.h
>> @@ -389,6 +389,7 @@
>> #define USB_DEVICE_ID_TOSHIBA_CLICK_L9W 0x0401
>> #define USB_DEVICE_ID_HP_X2 0x074d
>> #define USB_DEVICE_ID_HP_X2_10_COVER 0x0755
>> +#define USB_DEVICE_ID_ELAN_TOUCHPAD 0x303e
> 
> I know Hans wanted you to use USB here, but I'd think we should have a
> I2C_DEVICE_ID_*
> There is no guarantees that this same PID will be used in a different
> chip over USB.
> We tend to not car about USB/I2C for the vendor IDs: the vendors
> decided to reuse their USB VID, which makes our life easier.

Ok, no objection from me to use an I2C_DEVICE_ID prefix, here it
is after all an I2C device.

>> #define USB_VENDOR_ID_ELECOM 0x056e
>> #define USB_DEVICE_ID_ELECOM_BM084 0x0061
>> diff --git a/drivers/hid/i2c-hid/i2c-hid-core.c b/drivers/hid/i2c-hid/i2c-hid-core.c
>> index 90164fed08d3..16b55c45e2e8 100644
>> --- a/drivers/hid/i2c-hid/i2c-hid-core.c
>> +++ b/drivers/hid/i2c-hid/i2c-hid-core.c
>> @@ -50,7 +50,8 @@
>> #define I2C_HID_QUIRK_NO_IRQ_AFTER_RESET BIT(1)
>> #define I2C_HID_QUIRK_NO_RUNTIME_PM BIT(2)
>> #define I2C_HID_QUIRK_DELAY_AFTER_SLEEP BIT(3)
>> -#define I2C_HID_QUIRK_BOGUS_IRQ BIT(4)
>> +#define I2C_HID_QUIRK_BOGUS_IRQ BIT(4)
>> +#define I2C_HID_QUIRK_FORCE_TRIGGER_FALLING BIT(5)
>>
>> /* flags */
>> #define I2C_HID_STARTED 0
>> @@ -182,8 +183,10 @@ static const struct i2c_hid_quirks {
>> I2C_HID_QUIRK_NO_RUNTIME_PM },
>> { I2C_VENDOR_ID_GOODIX, I2C_DEVICE_ID_GOODIX_01F0,
>> I2C_HID_QUIRK_NO_RUNTIME_PM },
>> + { USB_VENDOR_ID_ELAN, USB_DEVICE_ID_ELAN_TOUCHPAD,
>> + I2C_HID_QUIRK_BOGUS_IRQ | I2C_HID_QUIRK_FORCE_TRIGGER_FALLING },
>> { USB_VENDOR_ID_ELAN, HID_ANY_ID,
>> - I2C_HID_QUIRK_BOGUS_IRQ },
>> + I2C_HID_QUIRK_BOGUS_IRQ },

Benjamin, what I find interesting here is that the BOGUS_IRQ quirk
is also used on Elan devices, I suspect that these Elan devices
likely also need the I2C_HID_QUIRK_FORCE_TRIGGER_FALLING quirk
and then they probably will no longer need the bogus IRQ flag,
if you know about bugreports with an acpidump for any of the devices
needing the bogus IRQ quirk, then I (or you) can check how the IRQ is
declared there, I suspect it will be declared as level-low, just like
with the laptop this patch was written for. And it probably need to
be edge-falling instead of level-low just like this case.

Regards,

Hans

