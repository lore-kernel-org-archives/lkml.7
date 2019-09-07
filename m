Return-Path: <SRS0=QEJJ=XC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 197E5C43331
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Sep 2019 16:58:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4416218AF
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Sep 2019 16:58:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XWI8k7YV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395027AbfIGQ6W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Sep 2019 12:58:22 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:45043 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392087AbfIGQ6V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Sep 2019 12:58:21 -0400
Received: by mail-pl1-f196.google.com with SMTP id k1so4630873pls.11;
        Sat, 07 Sep 2019 09:58:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yDrrDGlJSS1HA6vAyhvfLglWjzQeqOMw+pM6lTwM9X4=;
        b=XWI8k7YV7OcRKTZwNvMeqG4ilNldn0x0GRcYxPXRvKGDXrcpVUQbIeJjSwwFmV12qf
         +L4yOj7bOuPP0vCGnPUKzgbCpv7iOSybaTosOueADle+4sWdTjenABlMtT6Tr4KKDiHr
         stuRx0DsOHuYIqjWA64mhVDcYZiUB7fZIHI+dsqcZBGaE1WgWyxNFj6gOtfN58H83E/0
         TQ3mH2O2Iqb7McRmui3eK9qaTVicc17fSo6CIgt2bbNm7oCqbVuVJnQJVprnZnPAU+kJ
         AwAf5G2qXdmGSTDzvO/T/OAQjA4dbFWwWCY3jV0hg4HP6OHrJr/KO4KuVXHBbqxe7r2K
         eH6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yDrrDGlJSS1HA6vAyhvfLglWjzQeqOMw+pM6lTwM9X4=;
        b=s7V0LqhgAoPE6ZB2tBxgHMwwDE3+rvS2W7bWCggcDtJoVULUPlW4CB28WBmfDy5wsT
         2WwANLU9U6T83jej70IXvJm8ddSWLMhwE6QK1UaQ5aSn736WsnFkbgxdZmi+mn0tre0B
         PixX/cDP930Enx/Feo+jcL+vXDarcPn1c6KQb7vM1QgvCP9MKCzihUuCpvcvjOouovxd
         1wwdOCyEfMRzAN1jXsB61c/q3iEDnEeCM/N4ezW7s27SgzbJ22Xaj0uJf+7vYhGzdX6S
         6bPzkdbzf6cN2/fF+ULaKTNsQInTstMrPhoRWeyzRekeWQHhZh1uIuOz5Xkd61s9V+b0
         DpqA==
X-Gm-Message-State: APjAAAUbYZoP5bQcNv2OgF8fcPsvVcP85DfNODjrJ6wlVLVcgB6E4EkX
        Eg/YAn1bctwWK08sS81u/vzfWbATK8OtMY41NsYsSv9b92hM7Q==
X-Google-Smtp-Source: APXvYqy6T8ahdnEpjbWmlvFJtPNdeHtA428g5MC78bMHMiTQC8Clfnz2jor8SeWCA32MIqt/dCRzTnUOC55/j8+qw5Y=
X-Received: by 2002:a17:902:9895:: with SMTP id s21mr15260713plp.255.1567875500528;
 Sat, 07 Sep 2019 09:58:20 -0700 (PDT)
MIME-Version: 1.0
References: <20190816014140.10687-1-m.v.b@runbox.com>
In-Reply-To: <20190816014140.10687-1-m.v.b@runbox.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 7 Sep 2019 19:58:07 +0300
Message-ID: <CAHp75VeyN-xCktHC=Tn6yrvELswBXMmygyXJp_EmuZ-Az61kSA@mail.gmail.com>
Subject: Re: [PATCH] platform/x86: intel_pmc_core: Do not ioremap RAM
To:     "M. Vefa Bicakci" <m.v.b@runbox.com>
Cc:     Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rajneesh Bhardwaj <rajneesh.bhardwaj@intel.com>,
        Vishwanath Somayaji <vishwanath.somayaji@intel.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 16, 2019 at 4:42 AM M. Vefa Bicakci <m.v.b@runbox.com> wrote:
>
> On a Xen-based PVH virtual machine with more than 4 GiB of RAM,
> intel_pmc_core fails initialization with the following warning message
> from the kernel, indicating that the driver is attempting to ioremap
> RAM:
>
>   ------------[ cut here ]------------
>   ioremap on RAM at 0x00000000fe000000 - 0x00000000fe001fff
>   WARNING: CPU: 1 PID: 434 at arch/x86/mm/ioremap.c:186 __ioremap_caller.constprop.0+0x2aa/0x2c0
>   Modules linked in: intel_pmc_core_pltdrv(+) xen_netfront(+) intel_pmc_core \
>     crct10dif_pclmul crc32_pclmul crc32c_intel ghash_clmulni_intel \
>     intel_rapl_perf pcspkr binfmt_misc u2mfn(O) xenfs xen_gntdev \
>     xen_gntalloc xen_blkback xen_privcmd xen_evtchn ip_tables overlay \
>     xen_blkfront
>   CPU: 1 PID: 434 Comm: systemd-udevd Tainted: G           O      5.3.0-rc3-next-20190809-1 #2
>   RIP: 0010:__ioremap_caller.constprop.0+0x2aa/0x2c0
>   Code: 05 0f c9 1b 01 49 09 c6 e9 8e fe ff ff 48 8d 54 24 28 48 c7 c7 68 87 0a 82 c6 05 c4 23 2b 01 01 48 8d 74 24 18 e8 d4 4a 06 00 <0f> 0b 45 31 ff e9 fe fe ff ff e8 e7 47 06 00 0f 1f 80 00 00 00 00
>   RSP: 0018:ffffc900002dfa20 EFLAGS: 00010282
>   RAX: 0000000000000000 RBX: ffffffffc0107000 RCX: 0000000000000006
>   RDX: 0000000000000007 RSI: 0000000000000092 RDI: ffff88813bb17540
>   RBP: 00000000fe000000 R08: 000000000000015f R09: 000000000000000a
>   R10: 000000000000000a R11: ffffc900002df8da R12: 0000000000002000
>   R13: 0000000000000000 R14: 0000000000000002 R15: ffffffff822da3a0
>   FS:  000072ecce666940(0000) GS:ffff88813bb00000(0000) knlGS:0000000000000000
>   CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>   CR2: 0000785be7346d20 CR3: 000000000d872001 CR4: 00000000003606e0
>   Call Trace:
>    ? pmc_core_probe+0x87/0x2d0 [intel_pmc_core]
>    pmc_core_probe+0x87/0x2d0 [intel_pmc_core]
>    platform_drv_probe+0x35/0x80
>    really_probe+0x298/0x3c0
>    driver_probe_device+0x7a/0x100
>    ? driver_allows_async_probing+0x50/0x50
>    bus_for_each_drv+0x8f/0xd0
>    __device_attach+0xf0/0x170
>    bus_probe_device+0x8e/0xa0
>    device_add+0x692/0x7e0
>    platform_device_add+0xe9/0x240
>    ? 0xffffffffc00ec000
>    do_one_initcall+0x59/0x214
>    do_init_module+0x5c/0x230
>    load_module+0x258d/0x2840
>    ? __do_sys_finit_module+0xbb/0x120
>    __do_sys_finit_module+0xbb/0x120
>    do_syscall_64+0x5f/0x1a0
>    entry_SYSCALL_64_after_hwframe+0x44/0xa9
>   RIP: 0033:0x72eccf662fad
>   Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d ab 9e 0c 00 f7 d8 64 89 01 48
>   RSP: 002b:00007ffd3710d018 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
>   RAX: ffffffffffffffda RBX: 000060ab8fda2530 RCX: 000072eccf662fad
>   RDX: 0000000000000000 RSI: 000072eccf2bd84d RDI: 0000000000000017
>   RBP: 0000000000020000 R08: 0000000000000000 R09: 0000000000000007
>   R10: 0000000000000017 R11: 0000000000000246 R12: 000072eccf2bd84d
>   R13: 0000000000000000 R14: 000060ab8fd9b5e0 R15: 0000000000000007
>   ---[ end trace 5e5421608729d6f4 ]---
>
> This issue appears to manifest itself because of the following fallback
> mechanism in the driver:
>
>         if (lpit_read_residency_count_address(&slp_s0_addr))
>                 pmcdev->base_addr = PMC_BASE_ADDR_DEFAULT;
>
> The validity of address PMC_BASE_ADDR_DEFAULT (i.e., 0xFE000000) is not
> verified by the driver, which is what this patch introduces. With this
> patch, if address PMC_BASE_ADDR_DEFAULT is in RAM, then the driver will
> not attempt to ioremap the aforementioned address.
>

Pushed to my review and testing queue, thanks!

P.S. I cut unnecessary output off.

> Signed-off-by: M. Vefa Bicakci <m.v.b@runbox.com>
> ---
>  drivers/platform/x86/intel_pmc_core.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/platform/x86/intel_pmc_core.c b/drivers/platform/x86/intel_pmc_core.c
> index c510d0d72475..3b6b8dcc4767 100644
> --- a/drivers/platform/x86/intel_pmc_core.c
> +++ b/drivers/platform/x86/intel_pmc_core.c
> @@ -878,10 +878,14 @@ static int pmc_core_probe(struct platform_device *pdev)
>         if (pmcdev->map == &spt_reg_map && !pci_dev_present(pmc_pci_ids))
>                 pmcdev->map = &cnp_reg_map;
>
> -       if (lpit_read_residency_count_address(&slp_s0_addr))
> +       if (lpit_read_residency_count_address(&slp_s0_addr)) {
>                 pmcdev->base_addr = PMC_BASE_ADDR_DEFAULT;
> -       else
> +
> +               if (page_is_ram(PHYS_PFN(pmcdev->base_addr)))
> +                       return -ENODEV;
> +       } else {
>                 pmcdev->base_addr = slp_s0_addr - pmcdev->map->slp_s0_offset;
> +       }
>
>         pmcdev->regbase = ioremap(pmcdev->base_addr,
>                                   pmcdev->map->regmap_length);
> --
> 2.21.0
>


-- 
With Best Regards,
Andy Shevchenko
