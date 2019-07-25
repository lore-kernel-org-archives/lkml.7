Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44A4EC76190
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 17:44:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 189212084C
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 17:44:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tHgnHRXU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391257AbfGYRoL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 13:44:11 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:37641 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389004AbfGYRoL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 13:44:11 -0400
Received: by mail-pf1-f195.google.com with SMTP id 19so23114248pfa.4;
        Thu, 25 Jul 2019 10:44:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=F1UAd0NAfu4/AD+pKmFdZqYRIwZPuAgiz507KIuTUu0=;
        b=tHgnHRXUiGTMjTcR2hueEd2TixdbiBau3BS+FsHeIeUAsFdtkvzmE8Zbg0MU5p+YlW
         LrItiadPbiltPNWAWxgKjcganHhE3rbfLcyBWptNErX5LatSVDq1t4pr2Ktg45DJb7kI
         o8ayjt5orHffZniU0HNV4FRuO2RVebowXaMotoZ8nV0nEbA5Nb7pVcimmmL1tyPMnVCt
         lH0+HjIt9GY38fGsIxlRWPBo5lpkFTyTq5SNBnlBdw/s0f1K0A03PCKONNObRGC/BUWh
         c7hFOWGVz6YELr3KoYVzTFsDh558VPKBr37g6AA1ELK9VOQVwvoqlEEFiNG6JN6KTBCQ
         AiQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=F1UAd0NAfu4/AD+pKmFdZqYRIwZPuAgiz507KIuTUu0=;
        b=NPkg3gMa0hxeAKznXB+aYKzyXY/bwjuYIzhgih8SBmrjmwRVCrPRdQhnXSojSaO7aK
         73G70BSVG01h4pzLQhkv/MbrLCqvJE0OPWahkKOXkopYQEUTNc0ZNwkXPLmALhOrFjKk
         gBpJOO5kPqGNHjwgWh7c+xT61OI3BJd0qhwpTFMcX7tl5xbWGnB6a5ZO+lmHT8ce+so+
         Kb144oDllzk9O/3H4hzoDcakubtzH3I13gq6tCWKR7DxhhiZdmFGw20zNctYx0YHj3bo
         Onhzo/bYjPwvzTX5P2nBmtKO0m4WSqioY+Eud6YxLKCkMJYXgQoOFu+/MiI89f2uWpDv
         hsow==
X-Gm-Message-State: APjAAAXvVORci9TsAey0GZMulV3D7jVeG/aA8oXgvVKCohjng3Olxzso
        WnACDXfsRuiMhHc7z4HK/A03WQ9C8sY0LGLHSNY=
X-Google-Smtp-Source: APXvYqw+4+bf528CSyzjWwmIIIDYau9QdqfYZBS0bdCrHm4PmVXfTbo1UNG3jaDGiqVWB+g+0cGpjP+FniOJvzZ4Aog=
X-Received: by 2002:a62:4e86:: with SMTP id c128mr17803119pfb.64.1564076650526;
 Thu, 25 Jul 2019 10:44:10 -0700 (PDT)
MIME-Version: 1.0
References: <20190703163000.315-1-huangfq.daxian@gmail.com>
In-Reply-To: <20190703163000.315-1-huangfq.daxian@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 25 Jul 2019 20:43:59 +0300
Message-ID: <CAHp75Vefj9dBFHYn84ZHMteWgGEAq5bvAuvgbO8XRZcn_UdXHA@mail.gmail.com>
Subject: Re: [PATCH v2 21/35] platform/x86/thinkpad: Use kmemdup rather than
 duplicating its implementation
To:     Fuqian Huang <huangfq.daxian@gmail.com>
Cc:     Henrique de Moraes Holschuh <ibm-acpi@hmh.eng.br>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Thinkpad-acpi devel ML <ibm-acpi-devel@lists.sourceforge.net>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 3, 2019 at 7:30 PM Fuqian Huang <huangfq.daxian@gmail.com> wrote:
>
> kmemdup is introduced to duplicate a region of memory in a neat way.
> Rather than kmalloc/kzalloc + memcpy, which the programmer needs to
> write the size twice (sometimes lead to mistakes), kmemdup improves
> readability, leads to smaller code and also reduce the chances of mistakes.
> Suggestion to use kmemdup rather than using kmalloc/kzalloc + memcpy.
>

Pushed to my review and testing queue, thanks!

> Signed-off-by: Fuqian Huang <huangfq.daxian@gmail.com>
> ---
> Changes in v2:
>   - Fix a typo in commit message (memset -> memcpy)
>
>  drivers/platform/x86/thinkpad_acpi.c | 17 +++++++----------
>  1 file changed, 7 insertions(+), 10 deletions(-)
>
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
