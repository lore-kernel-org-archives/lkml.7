Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD89EC43218
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 17:45:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5ED9F2084F
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 17:45:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kTUrEh4f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729887AbfDYRp5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 13:45:57 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:35514 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725937AbfDYRp5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 13:45:57 -0400
Received: by mail-pf1-f193.google.com with SMTP id t21so280831pfh.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2019 10:45:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=j9qZO7ISwheuh0lbYxd9xz+ytxsYFl0seiSJ23an6S0=;
        b=kTUrEh4fFTMPDjkGGmlff+C2Kdr5fr5hNbcXJwsIO2VOiSh0izCnPc1E6JfY8LvJUy
         fsWzevyOqfzWqnZ9nSph7Zc+BZNw7541Ku5Cv0gBs3ShkrQxMpF72Ps98goLm2lGiDC0
         OUcgE0RX11/cfKnmkW7LdFORnqGzzc8rSNcvrwviSpO0E+xhNpJkqO0IdMvHHleKaI7i
         kh3JP4/QadnHwRLRb1DEKrIw+sWF9sF+gxjF4wciFzSNnA45G9rsjPJUETkpcXMOVHVN
         +HlsXKb6RakB+xTxKSjF6lWaBnI4JmMsQRfHJtVRQRk3YpBhfJLA3PBOajPXmYTDQXR5
         CtFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=j9qZO7ISwheuh0lbYxd9xz+ytxsYFl0seiSJ23an6S0=;
        b=kd83hU3o8FzIoWgtreW2EXQe03X1kJHeRX3EOCx+wPHSnkXilN/hkGz3QB1YYc2/VU
         iebZGZm+avMF7VyX12pGsA7HpKLG8jC3s458TgBulqbBSVSkNQbm1+T5Oxq/iSWBHyMV
         S7h2ULZ3AYuIa/BccSUV+dIJwA0lWLQUKyPFmNxsgfGE3LjUqTj7KVJHvbljpPx7S8AG
         cMzjcFooiWMJVDii6Yyk6lIkGmdJ6jLDWLDjCvOYpoux1dJe6crZ1S2DOm76zx5aUNqI
         UmHgldfkZmxirBsRBE3VdQ2Ozw6C54bcEobNdXyPAsmY/rbByJD03HVet+kSAU6Zyy1s
         lv9g==
X-Gm-Message-State: APjAAAUeTNjtyuah3luMskuK6ANmg64U0ZPZNV9fSvO1ThRSlcc9LJEa
        PB9gCWl/G6jHd9Ak+HoaR+lY9w==
X-Google-Smtp-Source: APXvYqwXyB3KJiMK0Nx+GCQzKwRvo03s/JvpBTgjor+HPg+Z8XY2yBwk/T9tjhtV+uKdmwUHRKfWOw==
X-Received: by 2002:a65:5049:: with SMTP id k9mr37362775pgo.229.1556214356275;
        Thu, 25 Apr 2019 10:45:56 -0700 (PDT)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id r11sm29730988pga.87.2019.04.25.10.45.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 25 Apr 2019 10:45:55 -0700 (PDT)
Date:   Thu, 25 Apr 2019 11:45:53 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        coresight@lists.linaro.org, mike.leach@linaro.org,
        rjw@rjwysocki.net, robert.walker@arm.com
Subject: Re: [PATCH v2 33/36] coresight: acpi: Support for components
Message-ID: <20190425174553.GB4080@xps15>
References: <1555344260-12375-1-git-send-email-suzuki.poulose@arm.com>
 <1555344260-12375-34-git-send-email-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1555344260-12375-34-git-send-email-suzuki.poulose@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 15, 2019 at 05:04:16PM +0100, Suzuki K Poulose wrote:
> All AMBA devices are handled via ACPI AMBA scan notifier
> infrastructure. The platform devices get the ACPI id
> added to their driver.
> 
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
>  drivers/acpi/acpi_amba.c                           | 9 +++++++++
>  drivers/hwtracing/coresight/coresight-replicator.c | 9 ++++++++-
>  2 files changed, 17 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/acpi_amba.c b/drivers/acpi/acpi_amba.c
> index 7f77c07..eef5a69 100644
> --- a/drivers/acpi/acpi_amba.c
> +++ b/drivers/acpi/acpi_amba.c
> @@ -24,6 +24,15 @@
>  
>  static const struct acpi_device_id amba_id_list[] = {
>  	{"ARMH0061", 0}, /* PL061 GPIO Device */
> +	{"ARMHC500", 0}, /* ARM CoreSight ETM4x */
> +	{"ARMHC501", 0}, /* ARM CoreSight ETR */
> +	{"ARMHC502", 0}, /* ARM CoreSight STM */
> +	{"ARMHC503", 0}, /* ARM CoreSight Debug */
> +	{"ARMHC979", 0}, /* ARM CoreSight TPIU */
> +	{"ARMHC97C", 0}, /* ARM CoreSight SoC-400 TMC, SoC-600 ETF/ETB */
> +	{"ARMHC98D", 0}, /* ARM CoreSight Dynamic Replicator */
> +	{"ARMHC9CA", 0}, /* ARM CoreSight CATU */
> +	{"ARMHC9FF", 0}, /* ARM CoreSight Funnel */
>  	{"", 0},
>  };
>  
> diff --git a/drivers/hwtracing/coresight/coresight-replicator.c b/drivers/hwtracing/coresight/coresight-replicator.c
> index 2eb489c..a8f42df 100644
> --- a/drivers/hwtracing/coresight/coresight-replicator.c
> +++ b/drivers/hwtracing/coresight/coresight-replicator.c
> @@ -5,6 +5,7 @@
>   * Description: CoreSight Replicator driver
>   */
>  
> +#include <linux/acpi.h>
>  #include <linux/amba/bus.h>
>  #include <linux/kernel.h>
>  #include <linux/device.h>
> @@ -290,11 +291,17 @@ static const struct of_device_id static_replicator_match[] = {
>  	{}
>  };
>  
> +#ifdef CONFIG_ACPI
> +static const struct acpi_device_id static_replicator_acpi_ids[] = {
> +	{"ARMHC985", 0}, /* ARM CoreSight Static Replicator */
> +};
> +#endif
>  static struct platform_driver static_replicator_driver = {
>  	.probe          = static_replicator_probe,
>  	.driver         = {
>  		.name   = "coresight-replicator",
> -		.of_match_table = static_replicator_match,
> +		.of_match_table = of_match_ptr(static_replicator_match),
> +		.acpi_match_table = ACPI_PTR(static_replicator_acpi_ids),
>  		.pm	= &replicator_dev_pm_ops,
>  		.suppress_bind_attrs = true,
>  	},

For the coresight part: Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>

You probably want to split this patch in half so that Rafael can pick up the
the first part of it in his tree.

I am done reviewing the core part of this set and will do 33-36 next week.  For
the next revision I would leave them out and send a separate set in order to
avoid delaying the ACPI part.

Thanks,
Mathieu

> -- 
> 2.7.4
> 
