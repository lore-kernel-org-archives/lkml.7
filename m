Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3317EC43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 22:03:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70621204EC
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 22:03:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="rPvcM/T3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727871AbfCEWC6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 17:02:58 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:42831 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726052AbfCEWC5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 17:02:57 -0500
Received: by mail-ot1-f66.google.com with SMTP id i5so8844082oto.9;
        Tue, 05 Mar 2019 14:02:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XDuXQsCaigZVdUoEjQk7N6E//pnQjrXnjYStu66ogns=;
        b=rPvcM/T3MNVyM2nZIM2Su4JZ+sON5tpVo5shJRkNvDFmQ5kca1l5f7YJ1wJMdrB5ku
         C7Ml96D5i6pUIoVPtTcwYspfWgbHNQv3cWtqhFCYrsngzr1laDw+VWdqoRNqzaIGhr6+
         /iP8OwfvJc5tO5nIwz1P8sdUKBLJA6RqzPX0aktTmyT8gOWwyFdkZ26e5emlv406wr2b
         RpQY6hsvx6DkD/kavXGjkL2mb/tqlsX5PE4p9Z0f+c6kRtianHrz4A/+pTxD7NMwXock
         XtEhntWQ8r3vf4Met1w8657hSN4rzsCH3Z9aNq7fuHXwCv9K29JbDXjFHwV2pCD1lJQZ
         KzSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XDuXQsCaigZVdUoEjQk7N6E//pnQjrXnjYStu66ogns=;
        b=rDbUCsMm2gmk7m0is8p3CxuAvWmCpczUkMACMAJhdcsmrcrgZfmhfgdD3GyF7E69RA
         kg6z4lDoNKPNxyTPnccEIG2GhzZNqbE9MELT7HGhVw4G6Q4OXe6r39Zb6ie9QHRBPfVO
         6M7qMpRq0tbNtmCJWfwxygGFRFM910qZCzfs7CRa7YUWg4Q2L4mq8FG3lnibyIks+9uo
         ElMpMwTB6k2pHpcm0UuCCc5/IhmnnYMnxKwYI1OFrKxphf4b3QsgnPZwl/ruesSNoiky
         N0AJjyILHJ5UsRMUUgL+T+rIEKEba+mmEChYNzyQ7X2aSYVshP8zdfVqcdZFjZvNAy74
         +hHg==
X-Gm-Message-State: APjAAAV0NQacOpynySLJ4F95/0xdqdGlxldmiDqlSKlaKd7f7NhJq8zi
        Mwy+ZvjztC2WZEgFkSjZP4uJTIg5JCInK1PR5HcRErtg
X-Google-Smtp-Source: APXvYqwSuvIrjMyWTYmxCDvwYh2qNIiDpIEXGC3ZZ7AoUWyWRH/eOEmxllLqutGxbyiAbe6e0IiILAfsZUSmkJ6M6QA=
X-Received: by 2002:a9d:5906:: with SMTP id t6mr2390395oth.308.1551823376548;
 Tue, 05 Mar 2019 14:02:56 -0800 (PST)
MIME-Version: 1.0
References: <20190304104916.3937-1-narmstrong@baylibre.com>
In-Reply-To: <20190304104916.3937-1-narmstrong@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Tue, 5 Mar 2019 23:02:45 +0100
Message-ID: <CAFBinCAkMSeMuXj++cWBYP4WFwAMEwm-EFHtLA5X85oe6kekTw@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: reset: meson-g12a: Add missing USB2 PHY resets
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     p.zabel@pengutronix.de, devicetree@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 4, 2019 at 11:49 AM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> The G12A Documentation lacked these 2 reset lines, but they are present and
> used for each USB 2 PHYs.
>
> Add them to the dt-bindings for the upcoming USB support.
>
> Fixes: dbfc54534dfc ("dt-bindings: reset: meson: add g12a bindings")
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

> ---
>  include/dt-bindings/reset/amlogic,meson-g12a-reset.h | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/include/dt-bindings/reset/amlogic,meson-g12a-reset.h b/include/dt-bindings/reset/amlogic,meson-g12a-reset.h
> index 8063e8314eef..6d487c5eba2c 100644
> --- a/include/dt-bindings/reset/amlogic,meson-g12a-reset.h
> +++ b/include/dt-bindings/reset/amlogic,meson-g12a-reset.h
> @@ -51,7 +51,10 @@
>  #define RESET_SD_EMMC_A                        44
>  #define RESET_SD_EMMC_B                        45
>  #define RESET_SD_EMMC_C                        46
> -/*                                     47-60 */
> +/*                                     47      */
> +#define RESET_USB_PHY20                        48
> +#define RESET_USB_PHY21                        49
because it's always hard to look up, here's the reference to that
information Amlogic's buildroot kernel
(buildroot_openlinux_kernel_4.9_fbdev_20180706):
kernel/aml-4.9/drivers/amlogic/usb/phy/phy-aml-new-usb2-v2.c uses:
writel((val | (0x3 << 16)), (void __iomem *) ((unsigned
long)phy->reset_regs + (0x21 * 4 - 0x8)));

this translates to:
- (0x21 * 4 - 0x8) = RESET1 register / reset line ID 32 and above
(reset line 0 is at "0x20 * 4 - 0x08")
- bits 16 and 17 = add 32 to that gives us reset IDs 48 and 49


Regards
Martin
