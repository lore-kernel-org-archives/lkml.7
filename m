Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLACK
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB1A5C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 08:23:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83A5A20675
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 08:23:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r9DbNFMd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726227AbfCGIXw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 03:23:52 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:44489 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726028AbfCGIXv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 03:23:51 -0500
Received: by mail-pg1-f193.google.com with SMTP id j3so10667743pgm.11;
        Thu, 07 Mar 2019 00:23:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xlSoW9n3/vhZTtvHjrlW/OG/u/jg3swLcYjt4fKauOM=;
        b=r9DbNFMdx884oMolSYmPmYcNrg1ZhwGTL9jmgTmpZR8CFU/LsSGZVx9+IC5nCNFUvC
         hMSdKGMkjbdp7uYvfAdQKdr7qwWx1EZw2RNq4TUSsqzwcGpxnWTi8qQ15NmRO88cv2u5
         d1CnIz0t6OG4i5IIgQhMpzyF1yS7fSDP39RWvAbezb0KVmJo7/9w6/+HNxgUcnWKK37v
         uL5GquTIJQdRnX3wUQ2WWDAW+gQQj4SAUwN4ewUnAuigYfs99K1yQ2gX+cTLHtMZl0Ey
         yFgZA0iYskqI2OmdxZsU7jrKzNXfj0JBXPq6hmny9an27VHCj+Qf8N7eZbB80K2v7tUo
         5k4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xlSoW9n3/vhZTtvHjrlW/OG/u/jg3swLcYjt4fKauOM=;
        b=iSQWeSKea2SLcFJqYaL0iglNmFfbhy4HcbfiUMCsS8PUjvfzTGNLc75UA1Oai3+ahr
         kBmJa8F0fW3m81GoOCsmmEPqaLjfrftZoFUqJsGcGHcfw0maxXMKWzbh984aLzEczmAx
         79h79BYjv4kKnR0ZJtSb5pgw8ieXZVXrjMis+syNMS3UqKtO7w6xVMFgCUnO2QE7nuwI
         MFzYE+KaPiYjOc7X3OwZEom04zzmM1XhNAjrwx1W1pqRXVjyXitZo0p2RE+wPS7WqGaK
         qHrTXtuz12TyxwbUSrwcy/OZd6BvRuFle/Ilk+JE0j8yUJjQADZscmDzpV2LDXndrwvP
         5wgw==
X-Gm-Message-State: APjAAAWavSdp2u7XKbbKjRHa7KJuUCHJDVNPzfysZPE32UR5VZNj8aw8
        8BjvV4hjw/UB25frlmr5uo09ui7/XScyZmJGQ/cdUhr25g0=
X-Google-Smtp-Source: APXvYqyCvVJ6r2pkwgpVwmEmrJgpMCka+tTOIkEr6udWA4j0z9MxIoaHAu6Qs5jnjb0d1xyvqxGNcvCpSPlfY++OlUc=
X-Received: by 2002:aa7:930b:: with SMTP id 11mr11658794pfj.49.1551947030319;
 Thu, 07 Mar 2019 00:23:50 -0800 (PST)
MIME-Version: 1.0
References: <20190307080820.9723-1-jiaxun.yang@flygoat.com>
In-Reply-To: <20190307080820.9723-1-jiaxun.yang@flygoat.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 7 Mar 2019 10:23:38 +0200
Message-ID: <CAHp75VeXPezw1Qyku2WvRPxF6euOX2BNdwFJTP37W9pdWRuynw@mail.gmail.com>
Subject: Re: [PATCH] platform/x86: thinkpad_acpi: disable bluetooth for some machines
To:     Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc:     Henrique de Moraes Holschuh <ibm-acpi@hmh.eng.br>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        ibm-acpi-devel@lists.sourceforge.net,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 7, 2019 at 10:09 AM Jiaxun Yang <jiaxun.yang@flygoat.com> wrote:
>
> Some AMD based ThinkPads have a firmware bug that calling
> "GBDC" will cause bluetooth on Intel wireless cards blocked.
>
> Probe these models by DMI match and disable bluetooth subdriver
> if specified Intel wireless card exist.

Thanks for a patch. My comments below.

(and take your time, there is merge window going on, so, your fix is
probably material for v5.1-rc2)

> @@ -79,6 +79,7 @@
>  #include <linux/jiffies.h>
>  #include <linux/workqueue.h>
>  #include <linux/acpi.h>

> +#include <linux/pci.h>
>  #include <linux/pci_ids.h>

The new include has included the old one with IDs.

>  #include <linux/power_supply.h>
>  #include <sound/core.h>
> @@ -4501,11 +4502,80 @@ static void bluetooth_exit(void)
>         bluetooth_shutdown();
>  }

> +static int __init have_bt_fwbug(void)
> +{
> +       /* Some AMD based ThinkPads have a firmware bug that calling
> +        * "GBDC" will cause bluetooth on Intel wireless cards blocked
> +        */

/*
 * Comments in multi-line style example.
 * Should look like this one.
 */

> +       if (dmi_check_system(bt_fwbug_list)) {

> +               if (pci_get_device(PCI_VENDOR_ID_INTEL, 0x24F3, NULL) || \
> +                   pci_get_device(PCI_VENDOR_ID_INTEL, 0x24FD, NULL) || \
> +                   pci_get_device(PCI_VENDOR_ID_INTEL, 0x2526, NULL))

You can do a table and use pci_match_device().
On top of it

if (x) {
 if (y)
  ...
}

equivalent to

if (x && y) {
 ...
}

> +                       return 1;
> +               else
> +                       return 0;
> +       } else {
> +                       return 0;
> +       }
> +}

> +       if (have_bt_fwbug()) {
> +               vdbg_printk(TPACPI_DBG_INIT | TPACPI_DBG_RFKILL,
> +                       FW_BUG "disable bluetooth subdriver for Intel cards\n");
> +               return 1;
> +       }
>         vdbg_printk(TPACPI_DBG_INIT | TPACPI_DBG_RFKILL,
>                         "initializing bluetooth subdriver\n");

Below I see the following:
        /* bluetooth not supported on 570, 600e/x, 770e, 770x, A21e, A2xm/p,
          G4x, R30, R31, R40e, R50e, T20-22, X20-21 */
       tp_features.bluetooth = hkey_handle &&
           acpi_evalf(hkey_handle, &status, "GBDC", "qd");

Is it possible to integrate your stuff to this one?
Or can you do similar, like tp_features.bluetooth = !have_bt_fwbug(); ?

-- 
With Best Regards,
Andy Shevchenko
