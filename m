Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56D4EC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 08:26:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 250D32075E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 08:26:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554366382;
	bh=E0tZjvkI7J53dhAqhJll0NZeehgs2C9JqsaiWYJO7uM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=sHAi40dxyx920sd0l5c4bX96iV8njB9m9f9M/CaQvo0BcNsMhgfCvnntuMKInd0RW
	 I+t0Cra4pW2xnfReBOhKJ6a3Aj8mSbrekUkj6xT2rH8+U1f8AuEQ3ncujN/ghsOJqZ
	 bsvtLfctPDBfmTsLF5n9o/Gp9DPXrRKZ/MGQnpbI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727773AbfDDI0U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 04:26:20 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:41935 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725914AbfDDI0U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 04:26:20 -0400
Received: by mail-oi1-f194.google.com with SMTP id v7so1176176oie.8
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2019 01:26:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sm+ubi2aoz5iNjZnLSFliywOspeWlby/mafXZrAF1rE=;
        b=oDFwjp2RTZudC/wAUc8u8cexUllxG49zkTpHx3QEfxg+kAqh3NJdVaLYczbkbq0i3h
         ntdqh119pVuIx0HqzY7EGBwn+aAO+oul/XwRaWltQoL8Dycf8xZVORbnXLQEf54Vlm76
         Ps5FRee9T6aEA0wB63RfKqiEMLVYyuS0ENtYsNdfZy6VqKtcergsM5ve6aGgF+zPNa/5
         rG3xFUtyic4SBT92Lc5OJrgFtFdzkMs/Jvpm/1tR1D4IINe+Wknvh1eUMt/yJ5eMghcL
         Ag+gajYTPkh82pEC+XA4mx2CcaRv2lJ2N/JOpMYuKMzj8IVtvb1Jcl9yUkYLuJk7YiO9
         ubeA==
X-Gm-Message-State: APjAAAUsYsaSsJ4vroggLgkRHtSzBOgy+1IE729FAPSlegNuCynnAKdJ
        Ai60Wvn/JSdpBNs1aWHq2x/zXxH0Ec18G0vlhm0=
X-Google-Smtp-Source: APXvYqyxOEv+Azbk6YisuI4IH+ikvziLRujR9m7xEcevpyyQMb1Qga3jBIYUUX404sOHkZow4o/YXlFVTQpWbtzGWgQ=
X-Received: by 2002:aca:5c55:: with SMTP id q82mr2524874oib.95.1554366379490;
 Thu, 04 Apr 2019 01:26:19 -0700 (PDT)
MIME-Version: 1.0
References: <20190404081158.16133-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20190404081158.16133-1-andriy.shevchenko@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 4 Apr 2019 10:26:08 +0200
Message-ID: <CAJZ5v0jTBZbge7AMLwXNU5vAB31SFVe5pM-z6OHFDS2yhnuhfA@mail.gmail.com>
Subject: Re: [PATCH v2] driver core: platform: Propagate error from insert_resource()
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 4, 2019 at 10:12 AM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> Since insert_resource() might return an error we don't need
> to shadow its error code and would safely propagate to the user.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
> - move an assignment to the separate line inside first branch (Rafael)
>
>  drivers/base/platform.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/base/platform.c b/drivers/base/platform.c
> index dab0a5abc391..9cf9e2af9efd 100644
> --- a/drivers/base/platform.c
> +++ b/drivers/base/platform.c
> @@ -438,10 +438,12 @@ int platform_device_add(struct platform_device *pdev)
>                                 p = &ioport_resource;
>                 }
>
> -               if (p && insert_resource(p, r)) {
> -                       dev_err(&pdev->dev, "failed to claim resource %d: %pR\n", i, r);
> -                       ret = -EBUSY;
> -                       goto failed;
> +               if (p) {
> +                       ret = insert_resource(p, r);
> +                       if (ret) {
> +                               dev_err(&pdev->dev, "failed to claim resource %d: %pR\n", i, r);
> +                               goto failed;
> +                       }
>                 }
>         }
>
> --
> 2.20.1
>
