Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5EE1C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 13:05:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C05A2084F
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 13:05:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551445520;
	bh=WldMt/8kd+Om5h/ivtkwQoJGyAC9n5YIq/qhzqh2P98=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=iUR59Q/Oeyx1VcwsrEcmQMX2lcFJKPIhOpodn7F7VMQ4ASCW9/BssYH1HogNcR/wp
	 7hPiUYr0aum1/pO+kaLvFqn1uIPG7JnRgUnVI/3kcmVbQvAWdxQ7JYgFkya7wVybXp
	 kr5iLA6rzI8r+3ESlbH28DknP6FTNisDDsKu8NLM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731040AbfCANFT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 08:05:19 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:43682 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727697AbfCANFS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 08:05:18 -0500
Received: by mail-ot1-f66.google.com with SMTP id n71so20850401ota.10
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2019 05:05:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+QTJcCn9aYtaZYge7KSzxBOH7uyar5cNueRQbQhVfUA=;
        b=uBvoSDl4UqoJWWp1Th+JDk8qroepnrwPWjTUEcrDOYFrWPgP9YL3CNAyWq3ohREABq
         HUAgzde8b0M80x6+dzGxIK2lqXKGok8F1RM2xQCTgMN+dweNptIZeSnqzAu+hop5BgQF
         veJUVjPPD3YF+sxuYQmGROiRoilCeeouNSXdPQI+Q03mven9zX4j1558eXWamhLMPYFk
         Wd5DSyUoPiW+qeC5Wg8tDTqapb1uHTfTtNe+bKoh7/GgRfe9xgLFbTp6sFnUO6CqNnFd
         ikokGif4xq/+NrhTRjdZWiZYt0eOFaTnNyWwo6gAFib82kOlO6kM5c/h7Rpk1o7kDJlQ
         +Q5w==
X-Gm-Message-State: APjAAAXWbyHiQ7P9umUXYquQPyljmOp9KYC/fs7YCundvpMN/N2GfFQv
        tz026SyMJmphjxwW0swxfA5up7IPEESIz8Ac4d8=
X-Google-Smtp-Source: APXvYqzI5M1ylK7/xmvkwIEyVZfGEwo0sCJZyShXEqiacY3huTUIaF0bwFVsCc2W8F6V6seH7zNI3awrXCODk6YrlKc=
X-Received: by 2002:a9d:7cd3:: with SMTP id r19mr3384430otn.139.1551445517969;
 Fri, 01 Mar 2019 05:05:17 -0800 (PST)
MIME-Version: 1.0
References: <20190301122447.3503-1-johannes@sipsolutions.net>
In-Reply-To: <20190301122447.3503-1-johannes@sipsolutions.net>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 1 Mar 2019 14:05:06 +0100
Message-ID: <CAJZ5v0gvCv01V1dqYnPmNjfiC-FhpMALFBTkwt_fgm_cSoDmwg@mail.gmail.com>
Subject: Re: [PATCH] driver core: platform: remove misleading err_alloc label
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Johannes Berg <johannes.berg@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 1, 2019 at 2:01 PM Johannes Berg <johannes@sipsolutions.net> wrote:
>
> From: Johannes Berg <johannes.berg@intel.com>
>
> In platform_device_register_full() the err_alloc label is
> misleading, we only ever jump to it if the pdev is NULL,
> but it then proceeds to free it, which is a no-op.
>
> Remove the label and simply exit the function immediately.
>
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>

Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
>  drivers/base/platform.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/drivers/base/platform.c b/drivers/base/platform.c
> index 1c958eb33ef4..75fccb7dc908 100644
> --- a/drivers/base/platform.c
> +++ b/drivers/base/platform.c
> @@ -508,7 +508,7 @@ struct platform_device *platform_device_register_full(
>
>         pdev = platform_device_alloc(pdevinfo->name, pdevinfo->id);
>         if (!pdev)
> -               goto err_alloc;
> +               return ERR_PTR(-ENOMEM);
>
>         pdev->dev.parent = pdevinfo->parent;
>         pdev->dev.fwnode = pdevinfo->fwnode;
> @@ -553,8 +553,6 @@ struct platform_device *platform_device_register_full(
>  err:
>                 ACPI_COMPANION_SET(&pdev->dev, NULL);
>                 kfree(pdev->dev.dma_mask);
> -
> -err_alloc:
>                 platform_device_put(pdev);
>                 return ERR_PTR(ret);
>         }
> --
> 2.17.2
>
