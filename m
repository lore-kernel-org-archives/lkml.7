Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56A72C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 13:31:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CB5E2075E
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 13:31:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727175AbfC1Nb4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 09:31:56 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:39542 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725948AbfC1Nby (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 09:31:54 -0400
Received: by mail-ed1-f68.google.com with SMTP id p20so16735499eds.6
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2019 06:31:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=l6Vi8M4ajulsz02axgUDKeUfX8n+UOgrRKvsQmmLB60=;
        b=MLF5grDzJNukbpYZYadIFjiKAUegfYKevoTA3X3ALtvUm38zrS57HqxJYLRWi88utf
         pMoEQQic/kAKrmak4+TY31Y/D7ELsadwUZRU978Qcq6IM5v9thENoK39TQk8tvqoU89J
         3b31fmrXRvPtARsYGnYmVdeADAqWc+h6d+5FJLYbbINpEmI1yYrd5O+4p3/RfwongqZT
         aK2JCOD0uWGEE3HCctFYHJLiWPtHbbMvVL3dncQ6Isq3uZhJRwNrywZE7CIqneLXOGyp
         4NLOlQ2h1bq+Xm/wjftSQwzZsWvKM+JW/jV1Cs6PuVLRwb8cA26/aDwe4qEDW7Rvm2+o
         0P6A==
X-Gm-Message-State: APjAAAU7SAvZJM8ZdOMBSFXqnSNj+4VxVqHM/30vt4d221zdMObMVUR0
        yDuKG76umgUhh6wsobaiBQOeEg==
X-Google-Smtp-Source: APXvYqx/j5UR646Fhx+l0sWn/xsh5PB29P7IXMYGniPMVKugpo8K6Kmnz4y+TRYzCKMWzxqnZZcSlg==
X-Received: by 2002:a50:c40f:: with SMTP id v15mr7549109edf.236.1553779911867;
        Thu, 28 Mar 2019 06:31:51 -0700 (PDT)
Received: from shalem.localdomain (84-106-84-65.cable.dynamic.v4.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id t8sm5209991ejk.6.2019.03.28.06.31.49
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Mar 2019 06:31:50 -0700 (PDT)
Subject: Re: [PATCH v2] ACPI / PM: Propagate KEY_POWER to user space when
 resume
To:     "Chen, Hu" <hu1.chen@intel.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
References: <CAJZ5v0g3+S0vkW0XTzMKA8rYCtgy7yJ+UDc5xG4rRcdTbcJ=Lg@mail.gmail.com>
 <20190328103448.20335-1-hu1.chen@intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <1ad154aa-4d92-395d-890c-fe81b0bf21b5@redhat.com>
Date:   Thu, 28 Mar 2019 14:31:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.0
MIME-Version: 1.0
In-Reply-To: <20190328103448.20335-1-hu1.chen@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 28-03-19 11:34, Chen, Hu wrote:
> I run Android on x86 PC (it's a NUC). Everytime I press the power button
> to wake the system, it suspends right away. After some debug, I find
> that Android wants to see KEY_POWER at resume. Otherwise, its
> opportunistic suspend will kick in shortly.
> 
> However, other OS such as Ubuntu doesn't like KEY_POWER at resume. So
> add a knob "/sys/module/button/parameters/key_power_at_resume" for users
> to select.

We've had a similar discussion about the power-button on Bay Trail tablets,
which often is connected to a GPIO driver.

There we had the opposite problem, that regular desktop environments
like GNOME (and the related daemons) will immediately re-suspend again
on resume because of a KEY_POWER press event at resume. I submitted patches
to make the gpio-keys code not send a keypress on resume (configurable
per button) but that got nacked by Dmitry, the input subsystem maintainer.

It seems that this mostly is an evdev/input policy decision so that
this patch is going to need an ack from Dmitry, I've added Dmitry
to the Cc.

Note that after my kernel level fix for the Bay Trail devices got
nacked, I worked-around this in userspace:

https://gitlab.gnome.org/GNOME/gnome-settings-daemon/commit/f2ae8a3b9905cde7a9c12f78cb84689e97203380

But for GNOME only, e.g. KDE will likely still have a problem with
a KEY_POWER event being reported after suspend.

It seems the problem is that we have 2 different userspaces here
which have exact opposite expectations wrt KEY_POWER reporting
after a wakeup from suspend with the power-button. Android expects
it to be reported, which is why gpio-keys is reporting it since it
is mostly used with Android, where as classic Linux desktop-environments
expect it to NOT be reported, which is why the acpi-button.c code
so far has not reported it :|

I believe that unconditionally sending KEY_POWER after resume
will indeed causes issues for standard Linux distros, so I believe
that your solution with a parameter for people who want to run
android on plain x86 hardware is the best we can do now, but
I really wish we would remedy this situation one way or the other.

I wanted to give everyone involved the whole story, hence the
long mail :)

Regards,

Hans






> 
> Signed-off-by: Chen, Hu <hu1.chen@intel.com>
> ---
> 
>   drivers/acpi/button.c | 6 +++++-
>   drivers/acpi/sleep.c  | 8 ++++++++
>   2 files changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/button.c b/drivers/acpi/button.c
> index a19ff3977ac4..f98e6d85dd2b 100644
> --- a/drivers/acpi/button.c
> +++ b/drivers/acpi/button.c
> @@ -129,6 +129,10 @@ struct acpi_button {
>   	bool suspended;
>   };
>   
> +/* does userspace want to see KEY_POWER at resume? */
> +static bool key_power_at_resume __read_mostly;
> +module_param(key_power_at_resume, bool, 0644);
> +
>   static BLOCKING_NOTIFIER_HEAD(acpi_lid_notifier);
>   static struct acpi_device *lid_device;
>   static u8 lid_init_state = ACPI_BUTTON_LID_INIT_METHOD;
> @@ -417,7 +421,7 @@ static void acpi_button_notify(struct acpi_device *device, u32 event)
>   			int keycode;
>   
>   			acpi_pm_wakeup_event(&device->dev);
> -			if (button->suspended)
> +			if (button->suspended && !key_power_at_resume)
>   				break;
>   
>   			keycode = test_bit(KEY_SLEEP, input->keybit) ?
> diff --git a/drivers/acpi/sleep.c b/drivers/acpi/sleep.c
> index 403c4ff15349..c5dcee9f5872 100644
> --- a/drivers/acpi/sleep.c
> +++ b/drivers/acpi/sleep.c
> @@ -462,6 +462,13 @@ static int find_powerf_dev(struct device *dev, void *data)
>   	return !strcmp(hid, ACPI_BUTTON_HID_POWERF);
>   }
>   
> +static void pwr_btn_notify(struct device *dev)
> +{
> +	struct acpi_device *device = to_acpi_device(dev);
> +
> +	device->driver->ops.notify(device, ACPI_FIXED_HARDWARE_EVENT);
> +}
> +
>   /**
>    *	acpi_pm_finish - Instruct the platform to leave a sleep state.
>    *
> @@ -505,6 +512,7 @@ static void acpi_pm_finish(void)
>   				      find_powerf_dev);
>   	if (pwr_btn_dev) {
>   		pm_wakeup_event(pwr_btn_dev, 0);
> +		pwr_btn_notify(pwr_btn_dev);
>   		put_device(pwr_btn_dev);
>   	}
>   }
> 
