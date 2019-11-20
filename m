Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37C30C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 17:59:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 109EA20679
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 17:59:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728027AbfKTR7t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 12:59:49 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:37756 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727442AbfKTR7s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 12:59:48 -0500
Received: by mail-ot1-f67.google.com with SMTP id d5so393810otp.4
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2019 09:59:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zBB9OsnBCrlScEEQaEUduHBYkfuZALzvxczmYt/dJsU=;
        b=pc6KYITr55wk4fIuuuVxbZoQJq2MyolGgD5/wpYGI/zQUtSgjQYggQfJT6cL4U7V/L
         4oe8BBXiYpeA+N8BK8gel1M0B0qYtku9mBSMjQHRFEoAD/1TAg2EFE3ji1sNO91AwhZE
         Z5SvB0Spg+YCOkvqXsXR00Dp7A4LAF7aW1xLscACCzsOn3Y3PGOKgO4hG7otc3TWaNY4
         tbJvUB8tnWw6xuOo/boDUm0PhRTP7WjLBDd3221SIVJvpOxRndUZkCdJPWkzNPbUYk38
         mmtg+3I2GrMlN4yPAsHmdLSnj/nIpi+vdn9PG7r6MVJ7BDFVnj4PeLwg7n7Ozq4WqQbD
         JRDQ==
X-Gm-Message-State: APjAAAVlPW+63vcMy83V2olpsJJ89XAipQrfkLr8VPS/Nddqt5ZNHtXz
        uP4fuc5GdoxZNwc7xfUGbZyKa6lh
X-Google-Smtp-Source: APXvYqzgyX8+wGptCdurAvWhRC2tBLrufmFLmBMrjTrUNQQMIvDDZlBrEpdQZtFUWmxFVbVr1Yb8nw==
X-Received: by 2002:a9d:4003:: with SMTP id m3mr3209204ote.50.1574272787102;
        Wed, 20 Nov 2019 09:59:47 -0800 (PST)
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com. [209.85.210.43])
        by smtp.gmail.com with ESMTPSA id 9sm252248oiq.33.2019.11.20.09.59.46
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Nov 2019 09:59:46 -0800 (PST)
Received: by mail-ot1-f43.google.com with SMTP id r24so336992otk.12
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2019 09:59:46 -0800 (PST)
X-Received: by 2002:a9d:173:: with SMTP id 106mr3009123otu.205.1574272785900;
 Wed, 20 Nov 2019 09:59:45 -0800 (PST)
MIME-Version: 1.0
References: <20191118112324.22725-1-linux@rasmusvillemoes.dk> <20191118112324.22725-14-linux@rasmusvillemoes.dk>
In-Reply-To: <20191118112324.22725-14-linux@rasmusvillemoes.dk>
From:   Li Yang <leoyang.li@nxp.com>
Date:   Wed, 20 Nov 2019 11:59:34 -0600
X-Gmail-Original-Message-ID: <CADRPPNT4+zZd6fezcDcN=0EcezR4mHqnrOBBEexqBLyrV_THXQ@mail.gmail.com>
Message-ID: <CADRPPNT4+zZd6fezcDcN=0EcezR4mHqnrOBBEexqBLyrV_THXQ@mail.gmail.com>
Subject: Re: [PATCH v5 13/48] powerpc/83xx: remove mpc83xx_ipic_and_qe_init_IRQ
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Scott Wood <oss@buserror.net>
Cc:     Qiang Zhao <qiang.zhao@nxp.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Timur Tabi <timur@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 18, 2019 at 5:29 AM Rasmus Villemoes
<linux@rasmusvillemoes.dk> wrote:

Hi Scott,

What do you think of the PowerPC related changes(patch 13,14)?  Can we
have you ACK and merge the series from soc tree?

Regards,
Leo
>
> This is now exactly the same as mpc83xx_ipic_init_IRQ, so just use
> that directly.
>
> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> ---
>  arch/powerpc/platforms/83xx/km83xx.c      | 2 +-
>  arch/powerpc/platforms/83xx/misc.c        | 7 -------
>  arch/powerpc/platforms/83xx/mpc832x_mds.c | 2 +-
>  arch/powerpc/platforms/83xx/mpc832x_rdb.c | 2 +-
>  arch/powerpc/platforms/83xx/mpc836x_mds.c | 2 +-
>  arch/powerpc/platforms/83xx/mpc836x_rdk.c | 2 +-
>  arch/powerpc/platforms/83xx/mpc83xx.h     | 5 -----
>  7 files changed, 5 insertions(+), 17 deletions(-)
>
> diff --git a/arch/powerpc/platforms/83xx/km83xx.c b/arch/powerpc/platforms/83xx/km83xx.c
> index 5c6227f7bc37..3d89569e9e71 100644
> --- a/arch/powerpc/platforms/83xx/km83xx.c
> +++ b/arch/powerpc/platforms/83xx/km83xx.c
> @@ -177,7 +177,7 @@ define_machine(mpc83xx_km) {
>         .name           = "mpc83xx-km-platform",
>         .probe          = mpc83xx_km_probe,
>         .setup_arch     = mpc83xx_km_setup_arch,
> -       .init_IRQ       = mpc83xx_ipic_and_qe_init_IRQ,
> +       .init_IRQ       = mpc83xx_ipic_init_IRQ,
>         .get_irq        = ipic_get_irq,
>         .restart        = mpc83xx_restart,
>         .time_init      = mpc83xx_time_init,
> diff --git a/arch/powerpc/platforms/83xx/misc.c b/arch/powerpc/platforms/83xx/misc.c
> index 6935a5b9fbd1..1d8306eb2958 100644
> --- a/arch/powerpc/platforms/83xx/misc.c
> +++ b/arch/powerpc/platforms/83xx/misc.c
> @@ -88,13 +88,6 @@ void __init mpc83xx_ipic_init_IRQ(void)
>         ipic_set_default_priority();
>  }
>
> -#ifdef CONFIG_QUICC_ENGINE
> -void __init mpc83xx_ipic_and_qe_init_IRQ(void)
> -{
> -       mpc83xx_ipic_init_IRQ();
> -}
> -#endif /* CONFIG_QUICC_ENGINE */
> -
>  static const struct of_device_id of_bus_ids[] __initconst = {
>         { .type = "soc", },
>         { .compatible = "soc", },
> diff --git a/arch/powerpc/platforms/83xx/mpc832x_mds.c b/arch/powerpc/platforms/83xx/mpc832x_mds.c
> index 1c73af104d19..6fa5402ebf20 100644
> --- a/arch/powerpc/platforms/83xx/mpc832x_mds.c
> +++ b/arch/powerpc/platforms/83xx/mpc832x_mds.c
> @@ -101,7 +101,7 @@ define_machine(mpc832x_mds) {
>         .name           = "MPC832x MDS",
>         .probe          = mpc832x_sys_probe,
>         .setup_arch     = mpc832x_sys_setup_arch,
> -       .init_IRQ       = mpc83xx_ipic_and_qe_init_IRQ,
> +       .init_IRQ       = mpc83xx_ipic_init_IRQ,
>         .get_irq        = ipic_get_irq,
>         .restart        = mpc83xx_restart,
>         .time_init      = mpc83xx_time_init,
> diff --git a/arch/powerpc/platforms/83xx/mpc832x_rdb.c b/arch/powerpc/platforms/83xx/mpc832x_rdb.c
> index 87f68ca06255..622c625d5ce4 100644
> --- a/arch/powerpc/platforms/83xx/mpc832x_rdb.c
> +++ b/arch/powerpc/platforms/83xx/mpc832x_rdb.c
> @@ -219,7 +219,7 @@ define_machine(mpc832x_rdb) {
>         .name           = "MPC832x RDB",
>         .probe          = mpc832x_rdb_probe,
>         .setup_arch     = mpc832x_rdb_setup_arch,
> -       .init_IRQ       = mpc83xx_ipic_and_qe_init_IRQ,
> +       .init_IRQ       = mpc83xx_ipic_init_IRQ,
>         .get_irq        = ipic_get_irq,
>         .restart        = mpc83xx_restart,
>         .time_init      = mpc83xx_time_init,
> diff --git a/arch/powerpc/platforms/83xx/mpc836x_mds.c b/arch/powerpc/platforms/83xx/mpc836x_mds.c
> index 5b484da9533e..219a83ab6c00 100644
> --- a/arch/powerpc/platforms/83xx/mpc836x_mds.c
> +++ b/arch/powerpc/platforms/83xx/mpc836x_mds.c
> @@ -208,7 +208,7 @@ define_machine(mpc836x_mds) {
>         .name           = "MPC836x MDS",
>         .probe          = mpc836x_mds_probe,
>         .setup_arch     = mpc836x_mds_setup_arch,
> -       .init_IRQ       = mpc83xx_ipic_and_qe_init_IRQ,
> +       .init_IRQ       = mpc83xx_ipic_init_IRQ,
>         .get_irq        = ipic_get_irq,
>         .restart        = mpc83xx_restart,
>         .time_init      = mpc83xx_time_init,
> diff --git a/arch/powerpc/platforms/83xx/mpc836x_rdk.c b/arch/powerpc/platforms/83xx/mpc836x_rdk.c
> index b7119e443920..b4aac2cde849 100644
> --- a/arch/powerpc/platforms/83xx/mpc836x_rdk.c
> +++ b/arch/powerpc/platforms/83xx/mpc836x_rdk.c
> @@ -41,7 +41,7 @@ define_machine(mpc836x_rdk) {
>         .name           = "MPC836x RDK",
>         .probe          = mpc836x_rdk_probe,
>         .setup_arch     = mpc836x_rdk_setup_arch,
> -       .init_IRQ       = mpc83xx_ipic_and_qe_init_IRQ,
> +       .init_IRQ       = mpc83xx_ipic_init_IRQ,
>         .get_irq        = ipic_get_irq,
>         .restart        = mpc83xx_restart,
>         .time_init      = mpc83xx_time_init,
> diff --git a/arch/powerpc/platforms/83xx/mpc83xx.h b/arch/powerpc/platforms/83xx/mpc83xx.h
> index d343f6ce2599..f37d04332fc7 100644
> --- a/arch/powerpc/platforms/83xx/mpc83xx.h
> +++ b/arch/powerpc/platforms/83xx/mpc83xx.h
> @@ -72,11 +72,6 @@ extern int mpc837x_usb_cfg(void);
>  extern int mpc834x_usb_cfg(void);
>  extern int mpc831x_usb_cfg(void);
>  extern void mpc83xx_ipic_init_IRQ(void);
> -#ifdef CONFIG_QUICC_ENGINE
> -extern void mpc83xx_ipic_and_qe_init_IRQ(void);
> -#else
> -#define mpc83xx_ipic_and_qe_init_IRQ mpc83xx_ipic_init_IRQ
> -#endif /* CONFIG_QUICC_ENGINE */
>
>  #ifdef CONFIG_PCI
>  extern void mpc83xx_setup_pci(void);
> --
> 2.23.0
>
