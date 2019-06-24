Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1DA0C43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 10:51:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7ADC4208E4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 10:51:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729463AbfFXKvj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 06:51:39 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:41557 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728654AbfFXKvh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 06:51:37 -0400
Received: by mail-ed1-f67.google.com with SMTP id p15so21092186eds.8
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2019 03:51:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=t2vNhPqnjovK4zG9TO7OvRbTUDaxPdCfrbFcCQ4/rec=;
        b=PiWtPD82DbGjyLvrbpRxB0Rdyz1v0DLdrfijbCTxtSj1pKiiaaYvcW2Q9fH1q7sT7b
         NgmfkThWFbh7DIwLpoLUki6VXmFqUloGn+IE2t4+64RlK758f9iBTVMy1UnFw3BT1W3e
         uPy1i19U8gpSCQJ7QzCDbzqZn3PFvLWU+OD2t8QumHeXsQOuUStN6/2+GjDqn4pcaOD8
         japjhGNzrRyCx1l3g6zlQsMwCYY6fxYzNAEzrUOZ6iymMVK738Sae9v4T8RtRRIp3ACg
         pryRLuH/h/hdK+synwV2XiJJkg+meh87SWkieXmyXUfnblg2J6VoaAWOAZDPkAndk3JZ
         VcIw==
X-Gm-Message-State: APjAAAVlblafqmm7UPUgY7pRS8CxOVnqn/IhESVlg1Z60VNrq98i0KAM
        5Xda/tMxETAMkVkPprD7p3IG+Q==
X-Google-Smtp-Source: APXvYqy6CGkPLlV7tl6IxVnLDwe2iA+Fh94YFcTZLM1DjVz/O99S/BAFt5gA6FwddRHJzo8hvC3aBg==
X-Received: by 2002:a50:8b9c:: with SMTP id m28mr121540476edm.53.1561373494788;
        Mon, 24 Jun 2019 03:51:34 -0700 (PDT)
Received: from shalem.localdomain (84-106-84-65.cable.dynamic.v4.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id w17sm3539385edi.15.2019.06.24.03.51.33
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Jun 2019 03:51:34 -0700 (PDT)
Subject: Re: [PATCH] ACPI / LPSS: Don't skip late system PM ops for hibernate
 on BYT/CHT
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "Robert R. Howell" <RHowell@uwyo.edu>
Cc:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
References: <20190403054352.30120-1-kai.heng.feng@canonical.com>
 <1588383.bXYZMuyLB9@kreacher> <e650be02-ec9b-742e-b34f-7944631107b5@uwyo.edu>
 <2830645.pXxymQ5XCC@kreacher>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <b02ef915-faf5-635d-bf2f-92dd10d274b1@redhat.com>
Date:   Mon, 24 Jun 2019 12:51:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <2830645.pXxymQ5XCC@kreacher>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rafael,

<snip>

> Sorry for the long delay.
> 
> I haven't dropped this issue on the floor, I hope that you are still able to follow up here.
> 
> Can you please test the appended patch instead of the previous one?
> 
> I have found some inconsistencies in the handling of hibernation in the ACPI PM domain
> and the LPSS driver that should be covered by this patch.

I know this is just a testing patch for now, but still I've given it
a quick look, some comments inline.

> ---
>   drivers/acpi/acpi_lpss.c |   63 +++++++++++++++++++++++++++++++++++------------
>   drivers/acpi/device_pm.c |   30 ++++++++++++++++++++--
>   include/linux/acpi.h     |    4 ++
>   3 files changed, 79 insertions(+), 18 deletions(-)
> 
> Index: linux-pm/drivers/acpi/device_pm.c
> ===================================================================
> --- linux-pm.orig/drivers/acpi/device_pm.c
> +++ linux-pm/drivers/acpi/device_pm.c
> @@ -1171,6 +1171,32 @@ int acpi_subsys_thaw_noirq(struct device
>   	return pm_generic_thaw_noirq(dev);
>   }
>   EXPORT_SYMBOL_GPL(acpi_subsys_thaw_noirq);
> +
> +/**
> + * acpi_subsys_restore_noirq - Run the device driver's "noirq" restore callback.
> + * @dev: Device to handle.
> + */
> +int acpi_subsys_restore_noirq(struct device *dev)
> +{
> +	/* This is analogous to what acpi_subsys_resune_noirq() does. */
> +	if (dev_pm_smart_suspend_and_suspended(dev))
> +		pm_runtime_set_active(dev);
> +
> +	return pm_generic_restore_noirq(dev);
> +}
> +EXPORT_SYMBOL_GPL(acpi_subsys_restore_noirq);
> +
> +/**
> + * acpi_subsys_restore_early - Restore device using ACPI.
> + * @dev: Device to restore.
> + */
> +int acpi_subsys_restore_early(struct device *dev)
> +{
> +	int ret = acpi_dev_resume(dev);
> +	return ret ? ret : pm_generic_restore_early(dev);
> +}
> +EXPORT_SYMBOL_GPL(acpi_subsys_restore_early);
> +
>   #endif /* CONFIG_PM_SLEEP */
>   
>   static struct dev_pm_domain acpi_general_pm_domain = {
> @@ -1192,8 +1218,8 @@ static struct dev_pm_domain acpi_general
>   		.poweroff = acpi_subsys_suspend,
>   		.poweroff_late = acpi_subsys_suspend_late,
>   		.poweroff_noirq = acpi_subsys_suspend_noirq,
> -		.restore_noirq = acpi_subsys_resume_noirq,
> -		.restore_early = acpi_subsys_resume_early,
> +		.restore_noirq = acpi_subsys_restore_noirq,
> +		.restore_early = acpi_subsys_restore_early,
>   #endif
>   	},
>   };
> Index: linux-pm/drivers/acpi/acpi_lpss.c
> ===================================================================
> --- linux-pm.orig/drivers/acpi/acpi_lpss.c
> +++ linux-pm/drivers/acpi/acpi_lpss.c
> @@ -1069,36 +1069,67 @@ static int acpi_lpss_suspend_noirq(struc
>   	return acpi_subsys_suspend_noirq(dev);
>   }
>   
> -static int acpi_lpss_do_resume_early(struct device *dev)
> +static int acpi_lpss_resume_noirq(struct device *dev)
>   {
> -	int ret = acpi_lpss_resume(dev);
> +	struct lpss_private_data *pdata = acpi_driver_data(ACPI_COMPANION(dev));
> +
> +	/* Follow acpi_subsys_resune_noirq(). */
> +	if (dev_pm_may_skip_resume(dev))
> +		return 0;
> +
> +	if (dev_pm_smart_suspend_and_suspended(dev))
> +		pm_runtime_set_active(dev);
>   
> -	return ret ? ret : pm_generic_resume_early(dev);
> +	if (pdata->dev_desc->resume_from_noirq) {
> +		int ret = acpi_lpss_resume(dev);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return pm_generic_resume_noirq(dev);
>   }

Hmm, normally acpi_lpss_resume runs at resume_early time, AFAIK
the order of resume callbacks calling is: resume_noirq, resume_early, resume

So normally our call order is:

---noirq-phase---
pm_generic_resume_noirq()
---early-phase---
acpi_lpss_resume()
pm_generic_resume_early()

My patch adding the resume_from_noirq flag, move the calling of
acpi_lpss_resume() to the resume_noirq phase (if the flag is
set) but kept the generic order, so the call order with the
flag set currently is:

---noirq-phase---
pm_generic_resume_noirq()
acpi_lpss_resume()
---early-phase---
pm_generic_resume_early()

So the order of the 3 calls relative to each other did not change.

You are changing this to:

---noirq-phase---
acpi_lpss_resume()
pm_generic_resume_noirq()
---early-phase---
pm_generic_resume_early()

So now when the flag is set acpi_lpss_resume() runs before
pm_generic_resume_noirq(). Is this intentional ?

Regards,

Hans




>   
>   static int acpi_lpss_resume_early(struct device *dev)
>   {
>   	struct lpss_private_data *pdata = acpi_driver_data(ACPI_COMPANION(dev));
>   
> -	if (pdata->dev_desc->resume_from_noirq)
> -		return 0;
> +	if (!pdata->dev_desc->resume_from_noirq) {
> +		int ret = acpi_lpss_resume(dev);
> +		if (ret)
> +			return ret;
> +	}
>   
> -	return acpi_lpss_do_resume_early(dev);
> +	return pm_generic_resume_early(dev);
>   }
>   
> -static int acpi_lpss_resume_noirq(struct device *dev)
> +static int acpi_lpss_restore_noirq(struct device *dev)
>   {
>   	struct lpss_private_data *pdata = acpi_driver_data(ACPI_COMPANION(dev));
> -	int ret;
>   
> -	ret = acpi_subsys_resume_noirq(dev);
> -	if (ret)
> -		return ret;
> +	/* Follow acpi_subsys_restore_noirq(). */
> +	if (dev_pm_smart_suspend_and_suspended(dev))
> +		pm_runtime_set_active(dev);
> +
> +	if (pdata->dev_desc->resume_from_noirq) {
> +		int ret = acpi_lpss_resume(dev);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return pm_generic_restore_noirq(dev);
> +}
> +
> +static int acpi_lpss_restore_early(struct device *dev)
> +{
> +	struct lpss_private_data *pdata = acpi_driver_data(ACPI_COMPANION(dev));
>   
> -	if (!dev_pm_may_skip_resume(dev) && pdata->dev_desc->resume_from_noirq)
> -		ret = acpi_lpss_do_resume_early(dev);
> +	if (!pdata->dev_desc->resume_from_noirq) {
> +		int ret = acpi_lpss_resume(dev);
> +		if (ret)
> +			return ret;
> +	}
>   
> -	return ret;
> +	return pm_generic_restore_early(dev);
>   }
>   
>   #endif /* CONFIG_PM_SLEEP */
> @@ -1140,8 +1171,8 @@ static struct dev_pm_domain acpi_lpss_pm
>   		.poweroff = acpi_subsys_suspend,
>   		.poweroff_late = acpi_lpss_suspend_late,
>   		.poweroff_noirq = acpi_lpss_suspend_noirq,
> -		.restore_noirq = acpi_lpss_resume_noirq,
> -		.restore_early = acpi_lpss_resume_early,
> +		.restore_noirq = acpi_lpss_restore_noirq,
> +		.restore_early = acpi_lpss_restore_early,
>   #endif
>   		.runtime_suspend = acpi_lpss_runtime_suspend,
>   		.runtime_resume = acpi_lpss_runtime_resume,
> Index: linux-pm/include/linux/acpi.h
> ===================================================================
> --- linux-pm.orig/include/linux/acpi.h
> +++ linux-pm/include/linux/acpi.h
> @@ -925,6 +925,8 @@ int acpi_subsys_freeze(struct device *de
>   int acpi_subsys_freeze_late(struct device *dev);
>   int acpi_subsys_freeze_noirq(struct device *dev);
>   int acpi_subsys_thaw_noirq(struct device *dev);
> +int acpi_subsys_restore_noirq(struct device *dev);
> +int acpi_subsys_restore_early(struct device *dev);
>   #else
>   static inline int acpi_dev_resume_early(struct device *dev) { return 0; }
>   static inline int acpi_subsys_prepare(struct device *dev) { return 0; }
> @@ -938,6 +940,8 @@ static inline int acpi_subsys_freeze(str
>   static inline int acpi_subsys_freeze_late(struct device *dev) { return 0; }
>   static inline int acpi_subsys_freeze_noirq(struct device *dev) { return 0; }
>   static inline int acpi_subsys_thaw_noirq(struct device *dev) { return 0; }
> +static inline int acpi_subsys_restore_noirq(struct device *dev) { return 0; }
> +static inline int acpi_subsys_restore_early(struct device *dev) { return 0; }
>   #endif
>   
>   #ifdef CONFIG_ACPI
> 
> 
> 
