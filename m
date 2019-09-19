Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 068BEC3A5A6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 13:03:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7E2521929
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 13:03:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732057AbfISNDU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 09:03:20 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:40206 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387465AbfISNDT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 09:03:19 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 595B228A9C6
Subject: Re: [PATCH] platform/chrome: chromeos_tbmc : Report wake events.
To:     Ravi Chandra Sadineni <ravisadineni@chromium.org>,
        bleung@chromium.org, swboyd@chromium.org, tbroch@chromium.org,
        linux-kernel@vger.kernel.org
References: <20190830231404.60005-1-ravisadineni@chromium.org>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <37bb8176-34c8-c711-b6be-d64d6aec68e6@collabora.com>
Date:   Thu, 19 Sep 2019 15:03:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20190830231404.60005-1-ravisadineni@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 31/8/19 1:14, Ravi Chandra Sadineni wrote:
> Mark chromeos_tbmc as wake capable and report wake events. This helps to
> abort suspend on seeing a tablet mode switch event when kernel is
> suspending. This also helps identifying if chroemos_tbmc is the wake
> source.
> 
> Signed-off-by: Ravi Chandra Sadineni <ravisadineni@chromium.org>

Applied for 5.4, the patches went to linux-next some time ago but sorry for late
reply.

Thanks,
 Enric

> ---
>  drivers/platform/chrome/chromeos_tbmc.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/platform/chrome/chromeos_tbmc.c b/drivers/platform/chrome/chromeos_tbmc.c
> index ce259ec9f990..d1cf8f3463ce 100644
> --- a/drivers/platform/chrome/chromeos_tbmc.c
> +++ b/drivers/platform/chrome/chromeos_tbmc.c
> @@ -47,6 +47,7 @@ static __maybe_unused int chromeos_tbmc_resume(struct device *dev)
>  
>  static void chromeos_tbmc_notify(struct acpi_device *adev, u32 event)
>  {
> +	acpi_pm_wakeup_event(&adev->dev);
>  	switch (event) {
>  	case 0x80:
>  		chromeos_tbmc_query_switch(adev, adev->driver_data);
> @@ -90,6 +91,7 @@ static int chromeos_tbmc_add(struct acpi_device *adev)
>  		dev_err(dev, "cannot register input device\n");
>  		return ret;
>  	}
> +	device_init_wakeup(dev, true);
>  	return 0;
>  }
>  
> 
