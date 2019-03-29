Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07950C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 10:25:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDA99206B8
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 10:25:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728862AbfC2KZb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 06:25:31 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:56714 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728398AbfC2KZb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 06:25:31 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 2302E8059A; Fri, 29 Mar 2019 11:25:20 +0100 (CET)
Date:   Fri, 29 Mar 2019 11:25:20 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     "Chen, Hu" <hu1.chen@intel.com>
Cc:     hdegoede@redhat.com, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ACPI / PM: Propagate KEY_POWER to user space when
 resume
Message-ID: <20190329102519.GA11784@atrey.karlin.mff.cuni.cz>
References: <CAJZ5v0g3+S0vkW0XTzMKA8rYCtgy7yJ+UDc5xG4rRcdTbcJ=Lg@mail.gmail.com>
 <20190328103448.20335-1-hu1.chen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190328103448.20335-1-hu1.chen@intel.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> I run Android on x86 PC (it's a NUC). Everytime I press the power button
> to wake the system, it suspends right away. After some debug, I find
> that Android wants to see KEY_POWER at resume. Otherwise, its
> opportunistic suspend will kick in shortly.
> 
> However, other OS such as Ubuntu doesn't like KEY_POWER at resume. So
> add a knob "/sys/module/button/parameters/key_power_at_resume" for users
> to select.
> 
> Signed-off-by: Chen, Hu <hu1.chen@intel.com>

NAK.

Fix android, lets not break kernel.

								Pavel
> ---
> 
>  drivers/acpi/button.c | 6 +++++-
>  drivers/acpi/sleep.c  | 8 ++++++++
>  2 files changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/button.c b/drivers/acpi/button.c
> index a19ff3977ac4..f98e6d85dd2b 100644
> --- a/drivers/acpi/button.c
> +++ b/drivers/acpi/button.c
> @@ -129,6 +129,10 @@ struct acpi_button {
>  	bool suspended;
>  };
>  
> +/* does userspace want to see KEY_POWER at resume? */
> +static bool key_power_at_resume __read_mostly;
> +module_param(key_power_at_resume, bool, 0644);
> +
>  static BLOCKING_NOTIFIER_HEAD(acpi_lid_notifier);
>  static struct acpi_device *lid_device;
>  static u8 lid_init_state = ACPI_BUTTON_LID_INIT_METHOD;
> @@ -417,7 +421,7 @@ static void acpi_button_notify(struct acpi_device *device, u32 event)
>  			int keycode;
>  
>  			acpi_pm_wakeup_event(&device->dev);
> -			if (button->suspended)
> +			if (button->suspended && !key_power_at_resume)
>  				break;
>  
>  			keycode = test_bit(KEY_SLEEP, input->keybit) ?
> diff --git a/drivers/acpi/sleep.c b/drivers/acpi/sleep.c
> index 403c4ff15349..c5dcee9f5872 100644
> --- a/drivers/acpi/sleep.c
> +++ b/drivers/acpi/sleep.c
> @@ -462,6 +462,13 @@ static int find_powerf_dev(struct device *dev, void *data)
>  	return !strcmp(hid, ACPI_BUTTON_HID_POWERF);
>  }
>  
> +static void pwr_btn_notify(struct device *dev)
> +{
> +	struct acpi_device *device = to_acpi_device(dev);
> +
> +	device->driver->ops.notify(device, ACPI_FIXED_HARDWARE_EVENT);
> +}
> +
>  /**
>   *	acpi_pm_finish - Instruct the platform to leave a sleep state.
>   *
> @@ -505,6 +512,7 @@ static void acpi_pm_finish(void)
>  				      find_powerf_dev);
>  	if (pwr_btn_dev) {
>  		pm_wakeup_event(pwr_btn_dev, 0);
> +		pwr_btn_notify(pwr_btn_dev);
>  		put_device(pwr_btn_dev);
>  	}
>  }

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
