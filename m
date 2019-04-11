Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D796C10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 12:34:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D17212073F
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 12:34:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rt8amp4h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726684AbfDKMeq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 08:34:46 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:46281 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726014AbfDKMep (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 08:34:45 -0400
Received: by mail-pf1-f196.google.com with SMTP id 9so3377617pfj.13;
        Thu, 11 Apr 2019 05:34:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KMdKIIiHipKQKDZGpqrpYyWUnjQx+WvOjRbBgeImJsA=;
        b=Rt8amp4hd8F2GS9qXUQci8A5SLByOiPZyEU6I1c9Y5aeqYpjSdyOTrdiTJw7nNHsdD
         CBOvJW1x7kzByhlAfmg4aQXZZlxz1ksg1Ahp9qTJk7R1/9ysIhQlBZFp7ejaeuMMBXUG
         ZBb3Rly4LN40bCD3A3vmtqXrUS8sYQ/i90qs9GDxxcqonUu0ydPZb/HyLUdwioySw+9N
         diU1R5MQ1bVai+zzxRxgGw9sxbC8cdhv1bhEwtEkGdvWe5CfuWwGuxTQehecCaU6bpKl
         bHIaKgac80i7Mxxob/KKsy43HabtlvIqkd8t59F9kNa204swlvmX9SQzosi6G1inylXl
         OVJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KMdKIIiHipKQKDZGpqrpYyWUnjQx+WvOjRbBgeImJsA=;
        b=uDbl0iy0Q65pHqi25NtSjPXcSrxc3hN5iJO3ACwjtuTgYxMQ6ollWNYHhzn8N+j05h
         l/j+rKgMg6hiV13DssZDwdRlywMFiL36WB4cRc/EraE6qfo7tw1ajyYfbmj+fCNSmDyR
         sYu/L6qE6R3+2nhsJXvHE+CKeWxllFFWQtZEgLaeWFCZr5QKrmKL3T7ZekmS19+0oejZ
         jvZiy44IxJ5YMIkDuS7ZUgTu+7j5E0afubP7q9rJx9zWvNQ1L+0zdQ9Lql64EupaGnan
         y04gbbpHT12y36qLnoXNcWYuQxW/uInhqnJwwSRV0Dq5vhVjYmtfLtM873sjVqPn+zIW
         93xg==
X-Gm-Message-State: APjAAAU+ol0wqYViVKjCWJf70cgvWqKfJnKuFlZX+BQh1LlPaV5Jlijo
        1VbEGb25KZp6Oqw5vAufNQ+NN8gM1TPxHBCKE1HLXR7H
X-Google-Smtp-Source: APXvYqzbF8eYfOavSgWa1wDzm1HtE4UJ6VkeikDJE1ncgZm6EHoMgDdMML/PKDzNgxDmySUiXZzSWxgNNHigMIs7feI=
X-Received: by 2002:a65:4302:: with SMTP id j2mr44574088pgq.291.1554986084822;
 Thu, 11 Apr 2019 05:34:44 -0700 (PDT)
MIME-Version: 1.0
References: <20190410152505.87041-1-heikki.krogerus@linux.intel.com> <20190410152505.87041-9-heikki.krogerus@linux.intel.com>
In-Reply-To: <20190410152505.87041-9-heikki.krogerus@linux.intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 11 Apr 2019 15:34:33 +0300
Message-ID: <CAHp75Vca6EdAYK=mQhrUfwyZZL75sQWHB2czWec1RSUvWcTEgA@mail.gmail.com>
Subject: Re: [PATCH v2 08/12] usb: typec: Registering real device entries for
 the muxes
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 10, 2019 at 6:25 PM Heikki Krogerus
<heikki.krogerus@linux.intel.com> wrote:
>
> Registering real device entries (struct device) for the mode
> muxes as well as for the orientation switches.
>
> The Type-C mux code was deliberately attempting to avoid
> creation of separate device entries for the orientation
> switch and the mode switch (alternate modes) because they
> are not physical devices. They are functions of a single
> physical multiplexer/demultiplexer switch device.
>
> Unfortunately because of the dependency we still have on the
> underlying mux device driver, we had to put in hacks like
> the one in the commit 3e3b81965cbf ("usb: typec: mux: Take
> care of driver module reference counting") to make sure the
> driver does not disappear from underneath us. Even with
> those hacks we were still left with a potential NUll pointer
> dereference scenario, so just creating the device entries,
> and letting the core take care of the dependencies. No more
> hacks needed.

>  drivers/platform/x86/intel_cht_int33fe.c |   4 +-

> diff --git a/drivers/platform/x86/intel_cht_int33fe.c b/drivers/platform/x86/intel_cht_int33fe.c
> index 6fa3cced6f8e..657b8d61554c 100644
> --- a/drivers/platform/x86/intel_cht_int33fe.c
> +++ b/drivers/platform/x86/intel_cht_int33fe.c
> @@ -173,10 +173,10 @@ static int cht_int33fe_probe(struct platform_device *pdev)
>         }
>
>         data->connections[0].endpoint[0] = "port0";
> -       data->connections[0].endpoint[1] = "i2c-pi3usb30532";
> +       data->connections[0].endpoint[1] = "i2c-pi3usb30532-switch";
>         data->connections[0].id = "orientation-switch";
>         data->connections[1].endpoint[0] = "port0";
> -       data->connections[1].endpoint[1] = "i2c-pi3usb30532";
> +       data->connections[1].endpoint[1] = "i2c-pi3usb30532-mux";
>         data->connections[1].id = "mode-switch";
>         data->connections[2].endpoint[0] = "i2c-fusb302";
>         data->connections[2].endpoint[1] = "intel_xhci_usb_sw-role-switch";

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

-- 
With Best Regards,
Andy Shevchenko
