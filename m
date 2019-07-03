Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42F85C0650E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 15:20:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 168DD2189E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 15:20:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="alSKkrNq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726964AbfGCPUy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 11:20:54 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:40352 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725847AbfGCPUx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 11:20:53 -0400
Received: by mail-pl1-f194.google.com with SMTP id a93so1426395pla.7;
        Wed, 03 Jul 2019 08:20:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=npfUX5g4NBmsetcgst/lwNx2V3HsW1aIbrFYjh+u9+o=;
        b=alSKkrNqbdr9OhZoF+JB968jD/7tRgD/xcQov7+FUTen/Ddk0DLlixffd5mSiU7rdX
         wuZ1kN/mSj+LVjPC/UF22/otJMVPWXLvAYXFUgk2PhSGjbASrR9TpLo7pZMMmedn5GQi
         PisnW3Kx/HJRdyDQhrd3cmxtGv45R04+wlNamvh77uuM/oK01fKHr+BtMgzGxZ3nB8xs
         nDgKEEJ5nXkjrbvB8JZ7ftAKz7ZiHueNRIp+ZcU5ULyfcAUlCLK3/clhlcs+1C4YfrL9
         hjAb/hOmmUb3PLtOwtPUo6vgn5fxrrsJG+hNcyi/oFx7HyKEeHvyvTjp09q7Kv4r+kiB
         wi0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=npfUX5g4NBmsetcgst/lwNx2V3HsW1aIbrFYjh+u9+o=;
        b=Vw4Al8dvBWV44lJHR0o8dcRy0211rfyB/BlBGvq9TrJXcAnxLX54plMoikCaTj+hdV
         hYKwFMHmT526Tg6pd7o7qVPLtpNLSQgAF/0O5yxfqTNSz3MXYO7RgH+4+KFSBE58Glad
         ACa6vGdEpu5sh1w/fNdRQ8i5T8bzN55/u4lNUK6xFEKdsHik2Se1o32gpDsUVu1Kw7Md
         JyJVxuzWGK04nK10ptjun4kFeJsZaDoLYl5pB6hW0bXhxreLjZJ0liU1Rnxp7Idv/OpH
         XRDInqjtG/6DExFexfWnJdVo1/fZcIEgQVFATonR8mUAus6M11s1qms087MTuh4SP3JR
         uy8Q==
X-Gm-Message-State: APjAAAXJJXgIFi5BDfg1RvjqJPMXJNcbWRpqQLZpkw8kRXOCHT09zuBk
        Boc5Ru4922tH7doBPl266tC+bgh1Zom/GdSPFjc=
X-Google-Smtp-Source: APXvYqw9zwX67ErTPi0PgCyAJYOtm7UgoOXqo7N4NhEw1YJtstI0VpEEPjHenFDEyA+XPXs0Sn3xcK40ybUv5JOs1Ks=
X-Received: by 2002:a17:902:694a:: with SMTP id k10mr42645894plt.255.1562167253133;
 Wed, 03 Jul 2019 08:20:53 -0700 (PDT)
MIME-Version: 1.0
References: <20190703131908.26138-1-huangfq.daxian@gmail.com>
In-Reply-To: <20190703131908.26138-1-huangfq.daxian@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 3 Jul 2019 18:20:41 +0300
Message-ID: <CAHp75Vef=H492wUnGWGSu7wg5qTb0Q7Y1VrcM60WK=8ejr=bcQ@mail.gmail.com>
Subject: Re: [PATCH 19/30] platform/x86: Use kmemdup rather than duplicating
 its implementation
To:     Fuqian Huang <huangfq.daxian@gmail.com>
Cc:     Corentin Chary <corentin.chary@gmail.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Henrique de Moraes Holschuh <ibm-acpi@hmh.eng.br>,
        acpi4asus-user <acpi4asus-user@lists.sourceforge.net>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thinkpad-acpi devel ML <ibm-acpi-devel@lists.sourceforge.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 3, 2019 at 4:19 PM Fuqian Huang <huangfq.daxian@gmail.com> wrote:
>
> kmemdup is introduced to duplicate a region of memory in a neat way.
> Rather than kmalloc/kzalloc + memset, which the programmer needs to
> write the size twice (sometimes lead to mistakes), kmemdup improves
> readability, leads to smaller code and also reduce the chances of mistakes.
> Suggestion to use kmemdup rather than using kmalloc/kzalloc + memset.
>

Please, split on driver basis and use correct prefix.

> Signed-off-by: Fuqian Huang <huangfq.daxian@gmail.com>
> ---
>  drivers/platform/x86/asus-wmi.c      |  3 +--
>  drivers/platform/x86/thinkpad_acpi.c | 17 +++++++----------
>  2 files changed, 8 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
> index 9b18a184e0aa..472b317ad814 100644
> --- a/drivers/platform/x86/asus-wmi.c
> +++ b/drivers/platform/x86/asus-wmi.c
> @@ -260,12 +260,11 @@ static int asus_wmi_evaluate_method_agfn(const struct acpi_buffer args)
>          * Copy to dma capable address otherwise memory corruption occurs as
>          * bios has to be able to access it.
>          */
> -       input.pointer = kzalloc(args.length, GFP_DMA | GFP_KERNEL);
> +       input.pointer = kmemdup(args.pointer, args.length, GFP_DMA | GFP_KERNEL);
>         input.length = args.length;
>         if (!input.pointer)
>                 return -ENOMEM;
>         phys_addr = virt_to_phys(input.pointer);
> -       memcpy(input.pointer, args.pointer, args.length);
>
>         status = asus_wmi_evaluate_method(ASUS_WMI_METHODID_AGFN,
>                                         phys_addr, 0, &retval);
> diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
> index 7bde4640ef34..d379bdf98a0f 100644
> --- a/drivers/platform/x86/thinkpad_acpi.c
> +++ b/drivers/platform/x86/thinkpad_acpi.c
> @@ -3647,22 +3647,19 @@ static int __init hotkey_init(struct ibm_init_struct *iibm)
>                 goto err_exit;
>
>         /* Set up key map */
> -       hotkey_keycode_map = kmalloc(TPACPI_HOTKEY_MAP_SIZE,
> -                                       GFP_KERNEL);
> -       if (!hotkey_keycode_map) {
> -               pr_err("failed to allocate memory for key map\n");
> -               res = -ENOMEM;
> -               goto err_exit;
> -       }
> -
>         keymap_id = tpacpi_check_quirks(tpacpi_keymap_qtable,
>                                         ARRAY_SIZE(tpacpi_keymap_qtable));
>         BUG_ON(keymap_id >= ARRAY_SIZE(tpacpi_keymaps));
>         dbg_printk(TPACPI_DBG_INIT | TPACPI_DBG_HKEY,
>                    "using keymap number %lu\n", keymap_id);
>
> -       memcpy(hotkey_keycode_map, &tpacpi_keymaps[keymap_id],
> -               TPACPI_HOTKEY_MAP_SIZE);
> +       hotkey_keycode_map = kmemdup(&tpacpi_keymaps[keymap_id],
> +                       TPACPI_HOTKEY_MAP_SIZE, GFP_KERNEL);
> +       if (!hotkey_keycode_map) {
> +               pr_err("failed to allocate memory for key map\n");
> +               res = -ENOMEM;
> +               goto err_exit;
> +       }
>
>         input_set_capability(tpacpi_inputdev, EV_MSC, MSC_SCAN);
>         tpacpi_inputdev->keycodesize = TPACPI_HOTKEY_MAP_TYPESIZE;
> --
> 2.11.0
>


-- 
With Best Regards,
Andy Shevchenko
