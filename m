Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13F75C4CEC9
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 20:03:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8483207FC
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 20:03:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OEJKl4nB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389826AbfIRUDw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 16:03:52 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:46994 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389813AbfIRUDv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 16:03:51 -0400
Received: by mail-pf1-f194.google.com with SMTP id q5so666677pfg.13;
        Wed, 18 Sep 2019 13:03:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DA1nVWCwGZiuG0z+FpUS64gSHzee6LAQ0oy8pdAlQsU=;
        b=OEJKl4nBl6ex6sKTzBbxuqQ6odXD819Xqz/R5bIJGCFf7RqnPEVasuNoxDdnNsIxYu
         EVKwl/IqdW5B5k7xsYwAflsc72QNwewgRp0qDkeDHx1A3enfMnxPYKVDMAeUlxM5OmCL
         xpqlBiKfA4NH0WZdey2ME+495ZpKoXF8n13z4JQxvi+oQDoo6u+lhXTUfAbl2MkqMveO
         8ezK8DAr43WhmLWciPBtj8exOzXrYVb49GfW07c25hDYk6IyBz4FG5hjm0j+O2zraYQR
         Qbr+LTFTk4aVdEoLNiTkhjJ/QfyDZUtc/QTCv6AAYiJ89vpLHBYhiVnJOjuruYRVt9Tj
         tM6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DA1nVWCwGZiuG0z+FpUS64gSHzee6LAQ0oy8pdAlQsU=;
        b=bFI7RNZs+U8j9eiO8wNbmPGcGsDimC2LJGjvDqctms3JOqSpb5H780XVVI4S50McqT
         i4UWAORSZC/inA4E0c0r/vOGuJGyOC+tAgyd8GcfkxYh5r08E3avPp8sca3/BwHy27gv
         TVleiIvh9E6es2XfEDHTDwEorumxUWaKepFl60TWyP2YDE8t2ES+SUWchQg85IhPhkG8
         jVgGt9wXBqZthAbSoEG/cilM1ABIVNpIwF9wG4w3pBV8WGkZ8tlnmgyi1ri86YCHApS5
         1hcbHeu4wcpihH482AccuxEFbCpp67j21HDZKh3ydjNvx7Sa1isX2UIiE3mrAGZkHWNb
         IHFw==
X-Gm-Message-State: APjAAAVtQjyueROiSRmnkpnL8AaQId+MtsC4KumVKcQeoUL8dqcGs1lC
        hMDCDpEe45fvh608wUVGn3RZEoSeBi6muM0XW6Q=
X-Google-Smtp-Source: APXvYqzgiSdaXROJHtHBgU43ShcZ2JFNuOzYcPhZ1/QT6UJGlgn8F68AHVw2AwAVKauwfKxMphD16qlMkzmCUNtHjTk=
X-Received: by 2002:a63:1cd:: with SMTP id 196mr5543402pgb.74.1568837030705;
 Wed, 18 Sep 2019 13:03:50 -0700 (PDT)
MIME-Version: 1.0
References: <20190918195652.2137765-1-arnd@arndb.de>
In-Reply-To: <20190918195652.2137765-1-arnd@arndb.de>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 18 Sep 2019 23:03:39 +0300
Message-ID: <CAHp75VdLLkFSYhvvXtzyEVeay3reBaYfJuzfd6qQ4Rw+k7QLKQ@mail.gmail.com>
Subject: Re: [PATCH] platform/x86: asus-wmi: add ACPI_BATTERY dependency
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Kristian Klausen <kristian@klausen.dk>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 18, 2019 at 10:57 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> Without this dependency, we can run into a link failure:
>
> drivers/platform/x86/asus-wmi.o: In function `asus_wmi_remove':
> asus-wmi.c:(.text+0x430): undefined reference to `battery_hook_unregister'
> drivers/platform/x86/asus-wmi.o: In function `asus_wmi_probe':
> asus-wmi.c:(.text+0x2c6f): undefined reference to `battery_hook_register'
>

Thanks, the similar is in my tree. I will send it later.

> Fixes: 7973353e92ee ("platform/x86: asus-wmi: Refactor charge threshold to use the battery hooking API")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/platform/x86/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
> index 1b67bb578f9f..d81de3f4f72e 100644
> --- a/drivers/platform/x86/Kconfig
> +++ b/drivers/platform/x86/Kconfig
> @@ -680,6 +680,7 @@ config ASUS_WMI
>         depends on RFKILL || RFKILL = n
>         depends on HOTPLUG_PCI
>         depends on ACPI_VIDEO || ACPI_VIDEO = n
> +       depends on ACPI_BATTERY
>         select INPUT_SPARSEKMAP
>         select LEDS_CLASS
>         select NEW_LEDS
> --
> 2.20.0
>


-- 
With Best Regards,
Andy Shevchenko
