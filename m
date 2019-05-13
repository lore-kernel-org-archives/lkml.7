Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43400C04AA7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 13:14:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14149208CA
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 13:14:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557753295;
	bh=VwtWFe82NQyYvYoXS+dtxKyqgLhN647dFTgo27HN5Xc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=RAG/c452F+aXvfPnLIcMJIZpMc0BVj/hh4B8ImQJ6RYV1CIcDQvzYNjRw90qTJa2F
	 jbiStSmCiqs8BbhMSphUrJLf/ULyloNO3RtrpQ+PZ4gvjFjDIQ+DghGKMpisy6hhOg
	 HvpTtXzrfOqzhLewV4sygaiSqZ3MzTfeocv/yTIg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730104AbfEMNOy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 09:14:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:44450 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727747AbfEMNOx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 09:14:53 -0400
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7150921880;
        Mon, 13 May 2019 13:14:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557753292;
        bh=VwtWFe82NQyYvYoXS+dtxKyqgLhN647dFTgo27HN5Xc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=xDuIGcF71WV/Z9zZp0QhkJLT6Bgs4okvzLFlGuN8BYqCGch6GiM1xFfeaPdZBuvAl
         D+AZg2hSeDNC0IwCdxFvbemaVMUzq657/Ky1SfIXw23lYiDIJW/6+RIToetGsF/vP+
         zTSLMeyFaEPr7lDtXW6FXajfBJvJwaZ5T5YSDb8k=
Received: by mail-qt1-f172.google.com with SMTP id t1so5684846qtc.12;
        Mon, 13 May 2019 06:14:52 -0700 (PDT)
X-Gm-Message-State: APjAAAU74QyNgN5EmZVMMZ7Eco4vkXIshzmBbmB6E+Ez9fx4auR2ZXij
        RPucLA/ix7aaUBOPqiLWagDM3NvrQxgv1KyGbg==
X-Google-Smtp-Source: APXvYqwWMO5obIjPRcGJzR/ig61QJkCy4isJj/MiEsKIL2bKQue6FTAFMYSeDH+zq9a10KCUY7nH5hpQRKtSkXpqVN0=
X-Received: by 2002:ac8:641:: with SMTP id e1mr23494317qth.76.1557753291566;
 Mon, 13 May 2019 06:14:51 -0700 (PDT)
MIME-Version: 1.0
References: <20190513003819.356-1-hsinyi@chromium.org>
In-Reply-To: <20190513003819.356-1-hsinyi@chromium.org>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 13 May 2019 08:14:40 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+Z5+M7fYCrkRKqN1yKTu6uyMKRKh-R4b-cj46y18hXOw@mail.gmail.com>
Message-ID: <CAL_Jsq+Z5+M7fYCrkRKqN1yKTu6uyMKRKh-R4b-cj46y18hXOw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] fdt: add support for rng-seed
To:     Hsin-Yi Wang <hsinyi@chromium.org>
Cc:     "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Kees Cook <keescook@chromium.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Architecture Mailman List <boot-architecture@lists.linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Michal Hocko <mhocko@suse.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Miles Chen <miles.chen@mediatek.com>,
        James Morse <james.morse@arm.com>,
        Andrew Murray <andrew.murray@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 12, 2019 at 7:39 PM Hsin-Yi Wang <hsinyi@chromium.org> wrote:
>
> Introducing a chosen node, rng-seed, which is an entropy that can be
> passed to kernel called very early to increase initial device
> randomness. Bootloader should provide this entropy and the value is
> read from /chosen/rng-seed in DT.
>
> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> ---
> change log:
> v1->v2:
> * call function in early_init_dt_scan_chosen
> * will add doc to devicetree-org/dt-schema on github if this is accepted
> ---
>  Documentation/devicetree/bindings/chosen.txt | 14 ++++++++++++++
>  drivers/of/fdt.c                             | 11 +++++++++++
>  2 files changed, 25 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/chosen.txt b/Documentation/devicetree/bindings/chosen.txt
> index 45e79172a646..fef5c82672dc 100644
> --- a/Documentation/devicetree/bindings/chosen.txt
> +++ b/Documentation/devicetree/bindings/chosen.txt
> @@ -28,6 +28,20 @@ mode) when EFI_RNG_PROTOCOL is supported, it will be overwritten by
>  the Linux EFI stub (which will populate the property itself, using
>  EFI_RNG_PROTOCOL).
>
> +rng-seed
> +-----------
> +
> +This property served as an entropy to add device randomness. It is parsed
> +as a byte array, e.g.
> +
> +/ {
> +       chosen {
> +               rng-seed = <0x31 0x95 0x1b 0x3c 0xc9 0xfa 0xb3 ...>;
> +       };
> +};
> +
> +This random value should be provided by bootloader.
> +
>  stdout-path
>  -----------
>
> diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
> index de893c9616a1..96ea5eba9dd5 100644
> --- a/drivers/of/fdt.c
> +++ b/drivers/of/fdt.c
> @@ -24,6 +24,7 @@
>  #include <linux/debugfs.h>
>  #include <linux/serial_core.h>
>  #include <linux/sysfs.h>
> +#include <linux/random.h>
>
>  #include <asm/setup.h>  /* for COMMAND_LINE_SIZE */
>  #include <asm/page.h>
> @@ -1079,6 +1080,7 @@ int __init early_init_dt_scan_chosen(unsigned long node, const char *uname,
>  {
>         int l;
>         const char *p;
> +       const void *rng_seed;
>
>         pr_debug("search \"chosen\", depth: %d, uname: %s\n", depth, uname);
>
> @@ -1113,6 +1115,15 @@ int __init early_init_dt_scan_chosen(unsigned long node, const char *uname,
>
>         pr_debug("Command line is: %s\n", (char*)data);
>
> +       rng_seed = of_get_flat_dt_prop(node, "rng-seed", &l);
> +       if (!rng_seed || l == 0)
> +               return 1;

This only works if this hunk stays at the end of the function. I'd
invert the if and move the next 2 functions under it.

> +
> +       /* try to clear seed so it won't be found. */
> +        fdt_nop_property(initial_boot_params, node, "rng-seed");

I'd just delete the property.

Also, what about kexec? Don't you need to add a new seed?

> +
> +        add_device_randomness(rng_seed, l);
> +
>         /* break now */
>         return 1;
>  }
> --
> 2.20.1
>
