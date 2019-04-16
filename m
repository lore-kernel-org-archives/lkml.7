Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66C6BC10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 10:48:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 303602075B
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 10:48:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555411730;
	bh=E5s6TWOD8eVPs3a2cr126d17+usv15M3eCkR7GF5veo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=MijgBEOIh1z2tmL+L3tMwFGYq/zfAmUewTzyEN7ScAToXKqqhSriBRnfXUF7WTL4m
	 1ff6/ICrYjHEm5HjcQNqufa6zea5ewjDPFdX3OLQpZ0TylZnhtZbmD6IiSWdtIDbU5
	 QHPWxJlVJuIGVfk+thqP5Ut9nmRImNUFwR8FzBLw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729077AbfDPKst (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 06:48:49 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:42228 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726946AbfDPKss (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 06:48:48 -0400
Received: by mail-oi1-f195.google.com with SMTP id w139so16492086oie.9;
        Tue, 16 Apr 2019 03:48:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RNy7+FoNOc3Uq1hh3IyW820pNO0qp+tJiGTXxfoyC3Q=;
        b=dY+YKn33ujhHSps/Ip56A1YQo0k+uRiZtJ1Jd85cwCIi7nuwDseN8ggcEnGqH0MEKI
         nRvZNk3XcvUl4DoTcfJDUALLw9JDERk+EpzwjqQGRkUMCo/W7rwq4YVnGMiYgY+lqbr6
         FT5ZcYMH1EnwJYojB4jul/kPvtDScjOiczuOoiTUGKMdprOa4sHvMQv0BzhXH34XamBF
         5RMvo1TDFAIoSFYJnJTJD0CsjBHO6BgXGG/fArL1kleIhCTmcMvO39RtXaOKLaGPpJ/b
         3vrh+0hPWECPetfHM73fd0CGvzPMZlZTfVi86NffA3oZGoPmfLVurPEEdNWquIpD08/k
         uPZA==
X-Gm-Message-State: APjAAAX1ur73bAA7K6B8An+3bbBVDboTG/tw+8ai/oDC5MQ7jHBXrUic
        zj5gDOyNlkKLPk3Adk7V3gW+D1R6kEUanobPieM=
X-Google-Smtp-Source: APXvYqwpjC5aEl6HOqhfGrOvW0akOn408hy6N93DIIqdEgMAet3wY77afhBYUpCV8hwxn0BqC5bEm6E2cIxH8RGWT8U=
X-Received: by 2002:aca:8d3:: with SMTP id 202mr22643049oii.76.1555411727840;
 Tue, 16 Apr 2019 03:48:47 -0700 (PDT)
MIME-Version: 1.0
References: <1555344260-12375-28-git-send-email-suzuki.poulose@arm.com> <1555411164-26399-1-git-send-email-suzuki.poulose@arm.com>
In-Reply-To: <1555411164-26399-1-git-send-email-suzuki.poulose@arm.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 16 Apr 2019 12:48:36 +0200
Message-ID: <CAJZ5v0i2-11rgH5Y+83U041Eyp=SA56oPqDmS2g24SyYYJH3jg@mail.gmail.com>
Subject: Re: [RESEND][PATCH v2 27/36] drivers: Add a generic helper to match
 device by fwnode handle
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        coresight@lists.linaro.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 16, 2019 at 12:39 PM Suzuki K Poulose
<suzuki.poulose@arm.com> wrote:
>
> Make the device_fwnode_match() a generic helper to match device
> by fwnode handle for use with bus_find_device(). This will be
> also used by coresight.
>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Cc: linux-acpi@vger.kernel.org
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
>
> Resending with linux-acpi in Cc, as requested by Rafael.

Do any other patches in your series depend on this one?

>  drivers/base/devcon.c    | 5 -----
>  drivers/base/property.c  | 6 ++++++
>  include/linux/property.h | 1 +
>  3 files changed, 7 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/base/devcon.c b/drivers/base/devcon.c
> index 04db9ae..f4a9e30 100644
> --- a/drivers/base/devcon.c
> +++ b/drivers/base/devcon.c
> @@ -107,11 +107,6 @@ static struct bus_type *generic_match_buses[] = {
>         NULL,
>  };
>
> -static int device_fwnode_match(struct device *dev, void *fwnode)
> -{
> -       return dev_fwnode(dev) == fwnode;
> -}
> -
>  static void *device_connection_fwnode_match(struct device_connection *con)
>  {
>         struct bus_type *bus;
> diff --git a/drivers/base/property.c b/drivers/base/property.c
> index 8b91ab3..d10d923 100644
> --- a/drivers/base/property.c
> +++ b/drivers/base/property.c
> @@ -25,6 +25,12 @@ struct fwnode_handle *dev_fwnode(struct device *dev)
>  }
>  EXPORT_SYMBOL_GPL(dev_fwnode);
>
> +int device_fwnode_match(struct device *dev, void *fwnode)
> +{
> +       return dev_fwnode(dev) == fwnode;
> +}
> +EXPORT_SYMBOL_GPL(device_fwnode_match);
> +
>  /**
>   * device_property_present - check if a property of a device is present
>   * @dev: Device whose property is being checked
> diff --git a/include/linux/property.h b/include/linux/property.h
> index 65d3420..c8fd3d42 100644
> --- a/include/linux/property.h
> +++ b/include/linux/property.h
> @@ -34,6 +34,7 @@ enum dev_dma_attr {
>  };
>
>  struct fwnode_handle *dev_fwnode(struct device *dev);
> +int device_fwnode_match(struct device *dev, void *fwnode);
>
>  bool device_property_present(struct device *dev, const char *propname);
>  int device_property_read_u8_array(struct device *dev, const char *propname,
> --
> 2.7.4
>
