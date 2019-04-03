Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D654EC4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 08:54:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A50CC206B7
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 08:54:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726534AbfDCIyf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 04:54:35 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:37310 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726083AbfDCIyf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 04:54:35 -0400
Received: by mail-ed1-f67.google.com with SMTP id v21so367280edq.4
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2019 01:54:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Rc6JX/J0H0lELUIlyHnWgPMa2qMrRc1HE3FjVIepV/s=;
        b=n1SGuyOaseVVclrbxjLf3KtCeVTkgsQ5hRqsHz+maRs0HZng6nBpuyBepV9mSKSSCN
         ZmyYxeo2P9jO08btJMfQzbRdnb2P2vUjbyyT4R3LYVZ/sXu3yaYgVQcd+59wjYUb4Vik
         VwEIAoqvuWtRMwX4wLTHNy4R/bTc+69pNUqc/Z9agkuTqxh7180d8H7EypQPjkWE0lRS
         d5SDBefRcxVLGYjmHfabCc9I/GmGU7X+ZU6W5MxQpo11eI4wamrCmuvquIUDK9EqSAB/
         G8R5E7PfItxotxYlPQ+0pFZWbEHqeMzibstslxQm6HD2kchntEDlvU5ayJAu8yFBTjlE
         A+wQ==
X-Gm-Message-State: APjAAAWS/W0b4hkQ+gSiGitNnQXjUJIhsQI/HmxtY9RHliY4/kOn0HcY
        rMTPu93n/A4uUxGfclaM6R0+iWH9fvY=
X-Google-Smtp-Source: APXvYqxIZ/LO69Fcgv4N7etO6HKelbFbwUrOqq+v5EFl19oItyMfs388h+blHWXBDTBfQZjrh+p55w==
X-Received: by 2002:a50:b4af:: with SMTP id w44mr20263537edd.179.1554281672649;
        Wed, 03 Apr 2019 01:54:32 -0700 (PDT)
Received: from shalem.localdomain (84-106-84-65.cable.dynamic.v4.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id m3sm2856486ejn.76.2019.04.03.01.54.31
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Apr 2019 01:54:32 -0700 (PDT)
Subject: Re: [PATCH] ACPI / LPSS: Don't skip late system PM ops for hibernate
 on BYT/CHT
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>, rjw@rjwysocki.net
Cc:     lenb@kernel.org, rhowell@uwyo.edu, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190403054352.30120-1-kai.heng.feng@canonical.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <eb1462c9-ebef-7bd6-c263-3f4f2e8ba63d@redhat.com>
Date:   Wed, 3 Apr 2019 10:54:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190403054352.30120-1-kai.heng.feng@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 03-04-19 07:43, Kai-Heng Feng wrote:
> i2c-designware-platdrv fails to work after the system restored from
> hibernation:
> [ 272.775692] i2c_designware 80860F41:00: Unknown Synopsys component type: 0xffffffff
> 
> Commit 48402cee6889 ("ACPI / LPSS: Resume BYT/CHT I2C controllers from
> resume_noirq") makes acpi_lpss_{suspend_late,resume_early}() bail early
> on BYT/CHT as resume_from_noirq is set. This means dw_i2c_plat_resume()
> doesn't gets called by acpi_lpss_resume_early(), and this causes the
> issue.
> 
> Introduce acpi_lpss_{poweroff_late,restore_early}() to make sure
> driver's own poweroff_late and restore_early get called.
> 
> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=202139
> Fixes: 48402cee6889 ("ACPI / LPSS: Resume BYT/CHT I2C controllers from resume_noirq")
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>

The ordering problem fixed by commit 48402cee6889 can hit hibernate too,
so I think it would be better to do this instead to fix this problem:

diff --git a/drivers/acpi/acpi_lpss.c b/drivers/acpi/acpi_lpss.c
index 1e2a10a06b9d..cf768608437e 100644
--- a/drivers/acpi/acpi_lpss.c
+++ b/drivers/acpi/acpi_lpss.c
@@ -1142,8 +1142,8 @@ static struct dev_pm_domain acpi_lpss_pm_domain = {
  		.thaw_noirq = acpi_subsys_thaw_noirq,
  		.poweroff = acpi_subsys_suspend,
  		.poweroff_late = acpi_lpss_suspend_late,
-		.poweroff_noirq = acpi_subsys_suspend_noirq,
-		.restore_noirq = acpi_subsys_resume_noirq,
+		.poweroff_noirq = acpi_lpss_suspend_noirq,
+		.restore_noirq = acpi_lpss_resume_noirq,
  		.restore_early = acpi_lpss_resume_early,
  #endif
  		.runtime_suspend = acpi_lpss_runtime_suspend,

Then the i2c controllers on platforms with the resume_from_noirq
flag set for them will be ready for use while the PCI subsystem
runs the _PS0 / _PS3 methods of PCI devices which may use the
i2c controllers (which is what commit 48402cee6889 set out to fix
in the first place).

If people affected by the problem can give my version of the fix a test,
then that would be great.

Regards,

Hans




> ---
>   drivers/acpi/acpi_lpss.c | 14 ++++++++++++--
>   1 file changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/acpi/acpi_lpss.c b/drivers/acpi/acpi_lpss.c
> index 1e2a10a06b9d..49aef186d73d 100644
> --- a/drivers/acpi/acpi_lpss.c
> +++ b/drivers/acpi/acpi_lpss.c
> @@ -1058,6 +1058,11 @@ static int acpi_lpss_suspend_late(struct device *dev)
>   	return acpi_lpss_do_suspend_late(dev);
>   }
>   
> +static int acpi_lpss_poweroff_late(struct device *dev)
> +{
> +	return acpi_lpss_do_suspend_late(dev);
> +}
> +
>   static int acpi_lpss_suspend_noirq(struct device *dev)
>   {
>   	struct lpss_private_data *pdata = acpi_driver_data(ACPI_COMPANION(dev));
> @@ -1089,6 +1094,11 @@ static int acpi_lpss_resume_early(struct device *dev)
>   	return acpi_lpss_do_resume_early(dev);
>   }
>   
> +static int acpi_lpss_restore_early(struct device *dev)
> +{
> +	return acpi_lpss_do_resume_early(dev);
> +}
> +
>   static int acpi_lpss_resume_noirq(struct device *dev)
>   {
>   	struct lpss_private_data *pdata = acpi_driver_data(ACPI_COMPANION(dev));
> @@ -1141,10 +1151,10 @@ static struct dev_pm_domain acpi_lpss_pm_domain = {
>   		.freeze_noirq = acpi_subsys_freeze_noirq,
>   		.thaw_noirq = acpi_subsys_thaw_noirq,
>   		.poweroff = acpi_subsys_suspend,
> -		.poweroff_late = acpi_lpss_suspend_late,
> +		.poweroff_late = acpi_lpss_poweroff_late,
>   		.poweroff_noirq = acpi_subsys_suspend_noirq,
>   		.restore_noirq = acpi_subsys_resume_noirq,
> -		.restore_early = acpi_lpss_resume_early,
> +		.restore_early = acpi_lpss_restore_early,
>   #endif
>   		.runtime_suspend = acpi_lpss_runtime_suspend,
>   		.runtime_resume = acpi_lpss_runtime_resume,
> 
