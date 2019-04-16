Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC7C7C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 10:21:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 759D1206BA
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 10:21:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555410072;
	bh=eOT/fiCyB/Ca75NjAK2xVaZhjZDIDzZrJwth6tx66P0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=upjKtzPqW9xd3lO1NfcYA0xaQuDjbDx7if5NvYxKYoPg7aYNNBqXZIGQ3s5HQeJh/
	 PkNy+6Yb5wu18BbiOc8XcEee5OlSXDiRUbaxW6g45DWmURcH9+yhB9jpPDJvPBvsLn
	 pBrrvDtg+58IHncy+9bXUAfdyA5fDZCbFWzgHkG8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728729AbfDPKVL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 06:21:11 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:36795 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726682AbfDPKVL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 06:21:11 -0400
Received: by mail-oi1-f194.google.com with SMTP id l203so16480525oia.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2019 03:21:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+F9hvZKy5g65whbbMjq1W21W0DNS+z7KxJNroquwtvI=;
        b=OdzmFLfcp/9GdoClOzCj80QrAQVIxMuFxWKprH917uZHmh/ROqq4oPA5w1Xs5e5nn1
         kQXQ0DzAZBNFWObMO4ULa1UdA4sVyP+FZA4QAN78p6qcScL0MbBpkn10RA6LFT4jx5EK
         h6hTJXrt8fBIR2z1lpQ31N6nrkgB7j+xhmncRlTZ0AdT4/IretNoU0+9im4QLuotKaq8
         vzBeMS2eyyAKlElw0lI6MA/D3xmuFwWp9dKdsZdYDrhWbRTCrt8G4JPshruUF7EVkheu
         +R2L8k6cTRJN4CRv05xRxMtYd4YTaqbnl23O5I4/2YRXY4apTtWS8deuFH5z4bex29mR
         kfLw==
X-Gm-Message-State: APjAAAWlA8eOELFi9wlKpYx/gBi7OyDUQKYWWTpFPQKOg7ikxkF8OAIr
        8QUXG+cxKYDRK+MUqZbhvrSz1mSxqbdbsDrP4bA=
X-Google-Smtp-Source: APXvYqysPgsPaheFnGRLBFH0y3DvvWyKf8t3ZmbzBWCpjbcfhi+LH/L919n+jjVb0QoLZdvl9nFqP0c40RN7GIutHdY=
X-Received: by 2002:aca:5c55:: with SMTP id q82mr22522949oib.95.1555410070356;
 Tue, 16 Apr 2019 03:21:10 -0700 (PDT)
MIME-Version: 1.0
References: <1555344260-12375-1-git-send-email-suzuki.poulose@arm.com> <1555344260-12375-28-git-send-email-suzuki.poulose@arm.com>
In-Reply-To: <1555344260-12375-28-git-send-email-suzuki.poulose@arm.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 16 Apr 2019 12:20:59 +0200
Message-ID: <CAJZ5v0jZCwPm-mg5L43RbqLKq1vB9zno85G+LPUVb+73KLimVA@mail.gmail.com>
Subject: Re: [PATCH v2 27/36] drivers: Add a generic helper to match device by
 fwnode handle
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        coresight@lists.linaro.org,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        mike.leach@linaro.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        robert.walker@arm.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 15, 2019 at 6:06 PM Suzuki K Poulose <suzuki.poulose@arm.com> wrote:
>
> Make the device_fwnode_match() a generic helper to match device
> by fwnode handle for use with bus_find_device(). This will be
> also used by coresight.
>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>

Can you resend this with a CC to linux-acpi@vger.kernel.org, please?

There's some device properties material for 5.2 collected already and
it would be good to keep all that together.

> ---
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
