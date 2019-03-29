Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47B76C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 11:38:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 203662070B
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 11:38:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729444AbfC2Lip (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 07:38:45 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:41723 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729427AbfC2Lio (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 07:38:44 -0400
Received: by mail-ed1-f66.google.com with SMTP id a25so1724377edc.8
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2019 04:38:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rAnVMt8GhLjBWwxOXsGQcZyhd7rTqgvVhbN3cBWYk0I=;
        b=K1UIJ5fTiAxZADT+ZLg03Z6TfDOygE+6L7qAC9BlvXNpEIE19FCyf9XNBpwrejuIwd
         em9YEVVFRJXcDOAaeH5xOaA7vpzDcD9uKoXtbEo2shM+R1e2CpCKAqr7zSM5CYaRAWRo
         uadgRowaWPa3aJGzu9tfXgXcOosEEiG/Q83fvaLW7FMWAOX7sUq3lfrDqcqtCiLyqsoq
         glHN9KrhOhjNm2RkGh79Xm9sUlHwn5AMGyBhNNsNUsCxKSeVS5L5HFgMGg+YkXScKx7Q
         zMqat6V+adQQKWo2PpJCy2BkTz3m5cEwokiCJG0DCNnhgms3AmVv42iiiI8SYwymAePM
         9Fww==
X-Gm-Message-State: APjAAAUMf0laDCWXuxwS2l3FNnLnUaOvUVhGa/pBDds5bds8rbRgh5va
        uIBBJwQtB43/vgmCQta2siFFP/9N0X0=
X-Google-Smtp-Source: APXvYqyD8DkP9bxkzlwnPQqdiRhAfxQOmlNNfMXQpczMa+T0bjQOS20nmCFTBdmif7L9Rpe5CSKIuA==
X-Received: by 2002:a17:906:896:: with SMTP id n22mr27265298eje.117.1553859522595;
        Fri, 29 Mar 2019 04:38:42 -0700 (PDT)
Received: from localhost.localdomain ([62.140.137.96])
        by smtp.gmail.com with ESMTPSA id bs21sm330351ejb.11.2019.03.29.04.38.41
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 Mar 2019 04:38:41 -0700 (PDT)
Subject: Re: [PATCH v2] ACPI / PM: Propagate KEY_POWER to user space when
 resume
To:     Pavel Machek <pavel@ucw.cz>, "Chen, Hu" <hu1.chen@intel.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <CAJZ5v0g3+S0vkW0XTzMKA8rYCtgy7yJ+UDc5xG4rRcdTbcJ=Lg@mail.gmail.com>
 <20190328103448.20335-1-hu1.chen@intel.com>
 <20190329102519.GA11784@atrey.karlin.mff.cuni.cz>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <23bc59ef-fc25-440b-ab1c-c5db6b5cf6d2@redhat.com>
Date:   Fri, 29 Mar 2019 12:38:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190329102519.GA11784@atrey.karlin.mff.cuni.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 3/29/19 11:25 AM, Pavel Machek wrote:
>> I run Android on x86 PC (it's a NUC). Everytime I press the power button
>> to wake the system, it suspends right away. After some debug, I find
>> that Android wants to see KEY_POWER at resume. Otherwise, its
>> opportunistic suspend will kick in shortly.
>>
>> However, other OS such as Ubuntu doesn't like KEY_POWER at resume. So
>> add a knob "/sys/module/button/parameters/key_power_at_resume" for users
>> to select.
>>
>> Signed-off-by: Chen, Hu <hu1.chen@intel.com>
> 
> NAK.
> 
> Fix android, lets not break kernel.

It is not that simple, as I explained in my other reply to this
patch, we alreayd have inconsistent behavior here inside the kernel.

When KEY_POWER is handled by the gpio-keys driver it does explicitly
send a KET_POWER press event when the system is woken up through the
power-button.

Arguably that is more consistent, e.g. some systems can also be woken
up through a home-button press and in that case we do want the KEY_HOMEPAGE
to be propagated to userspace after the wakeup so that we not only wake
but also switch to the homescreen (whatever that might be).

Also Android does have a good reason for wanting this, there are
many possible wakeup causes and just staying awake after wakeup is
not always the righ response. So android needs to know what is the
cause of the wakeup and the KEY_POWER event tells it the wakeup was
due to a power-button press, so the user explicitly wants the system
to wakeup.

Note I'm not saying that I'm happy with any of this, but simply NACK-ing
this patch is IMHO not the answer.

Regards,

Hans




> 
> 								Pavel
>> ---
>>
>>   drivers/acpi/button.c | 6 +++++-
>>   drivers/acpi/sleep.c  | 8 ++++++++
>>   2 files changed, 13 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/acpi/button.c b/drivers/acpi/button.c
>> index a19ff3977ac4..f98e6d85dd2b 100644
>> --- a/drivers/acpi/button.c
>> +++ b/drivers/acpi/button.c
>> @@ -129,6 +129,10 @@ struct acpi_button {
>>   	bool suspended;
>>   };
>>   
>> +/* does userspace want to see KEY_POWER at resume? */
>> +static bool key_power_at_resume __read_mostly;
>> +module_param(key_power_at_resume, bool, 0644);
>> +
>>   static BLOCKING_NOTIFIER_HEAD(acpi_lid_notifier);
>>   static struct acpi_device *lid_device;
>>   static u8 lid_init_state = ACPI_BUTTON_LID_INIT_METHOD;
>> @@ -417,7 +421,7 @@ static void acpi_button_notify(struct acpi_device *device, u32 event)
>>   			int keycode;
>>   
>>   			acpi_pm_wakeup_event(&device->dev);
>> -			if (button->suspended)
>> +			if (button->suspended && !key_power_at_resume)
>>   				break;
>>   
>>   			keycode = test_bit(KEY_SLEEP, input->keybit) ?
>> diff --git a/drivers/acpi/sleep.c b/drivers/acpi/sleep.c
>> index 403c4ff15349..c5dcee9f5872 100644
>> --- a/drivers/acpi/sleep.c
>> +++ b/drivers/acpi/sleep.c
>> @@ -462,6 +462,13 @@ static int find_powerf_dev(struct device *dev, void *data)
>>   	return !strcmp(hid, ACPI_BUTTON_HID_POWERF);
>>   }
>>   
>> +static void pwr_btn_notify(struct device *dev)
>> +{
>> +	struct acpi_device *device = to_acpi_device(dev);
>> +
>> +	device->driver->ops.notify(device, ACPI_FIXED_HARDWARE_EVENT);
>> +}
>> +
>>   /**
>>    *	acpi_pm_finish - Instruct the platform to leave a sleep state.
>>    *
>> @@ -505,6 +512,7 @@ static void acpi_pm_finish(void)
>>   				      find_powerf_dev);
>>   	if (pwr_btn_dev) {
>>   		pm_wakeup_event(pwr_btn_dev, 0);
>> +		pwr_btn_notify(pwr_btn_dev);
>>   		put_device(pwr_btn_dev);
>>   	}
>>   }
> 
