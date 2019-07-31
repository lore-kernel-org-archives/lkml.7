Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 256ABC32751
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 09:43:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC16B20665
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 09:43:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="t2jiJ6Zh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728748AbfGaJnH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 05:43:07 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:38890 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727409AbfGaJnH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 05:43:07 -0400
Received: by mail-pg1-f193.google.com with SMTP id f5so22874796pgu.5;
        Wed, 31 Jul 2019 02:43:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4oxIi/BVkp1npNpIoCR/QsGlH2mZ+bVRBFIPULa5x70=;
        b=t2jiJ6ZhaisYGYknSMnwAu1kKpTOw+FNjBs1HsPKgyNFkWEdHZ9ppFP4DxBJJ3u0FF
         YnuKgYMWkZ5ampcjGoU2xvx174Tx9+HJ71NzQmbrwwRBgF4hHOVzFJKENud0EUhe7WTA
         Qu6lw4qBKtl4K/Xi6s3Uy81jmociWmK2ln82Vy+MqsKodFBUQ7QBynJOkABsYlfSsl/a
         OwVpMh1MWHS9qtRBa1q7qP/M2adizwI/qIG9ZuZgrufT1GRG9JFkAx8X943Awwy4y1y/
         7BNwV6UjJ/P7/jQ70HxBfNqZa1BEZ4PjvBjM7PB0yaZXRwiDixFwrJSgqwS4gFex9wBa
         TOdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4oxIi/BVkp1npNpIoCR/QsGlH2mZ+bVRBFIPULa5x70=;
        b=IkWoLWOmHjPlPQPLDdLi1aH6MwpVotHFNIkxeCymoqPDWLcibnGnM5LZKUxt9ZmKv5
         K3tpYk3sPEolYjcr97mqdtG0j8Xr4NR90XsMYBVMDLs3rD1u8pXeA71vhr4vIHF0tKj+
         8SRi6QdMRWJL9JDC4YgYnTvTFd5NMguNnW3RLm6oCG5evp/aI9sNE4fkholODoBeb8OD
         L7jTTBLGcSQMBMBemxfaFwkcG6h20pmLovzQqypji7vdGtCNpiwiQ95OtjmNB8haBkLI
         5Da65Yi7MsOIVHL7Ckz1JMphLdPXBQ7Uj5YvsGlSeKC2tEiUclCXX8HrHoXFqoOZ1IKz
         q7xg==
X-Gm-Message-State: APjAAAV7BbpiWDU0geQhsUFRKNnaERJUGIIfjeWFaOufTHEpGabrv0Lp
        yC5/AGieXDtBdHcL9ip9/x4GVmArFZmOFMyp1q0=
X-Google-Smtp-Source: APXvYqw7HjLVmydb1zV/Bv8jyDvnbbbx7GuIOtPylFJ291+PFrzL5wYrfWLVUPjIAn2T2BcuVWPkcRr9QITaJ+zINDg=
X-Received: by 2002:a63:1020:: with SMTP id f32mr84410504pgl.203.1564566186380;
 Wed, 31 Jul 2019 02:43:06 -0700 (PDT)
MIME-Version: 1.0
References: <1564557670-10849-1-git-send-email-info@metux.net>
In-Reply-To: <1564557670-10849-1-git-send-email-info@metux.net>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 31 Jul 2019 12:42:55 +0300
Message-ID: <CAHp75VfoVr8wjeNj5KBUsexgREaCJYcr=1dPLDcQNN=VUAtdTw@mail.gmail.com>
Subject: Re: [PATCH] platform/x86/pcengines-apuv2: add mpcie reset gpio export
To:     "Enrico Weigelt, metux IT consult" <info@metux.net>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 31, 2019 at 10:21 AM Enrico Weigelt, metux IT consult
<info@metux.net> wrote:
>
> From: Florian Eckert <fe@dev.tdt.de>
>
> On APUx we have also mpcie2/mpcie3 reset pins. To make it possible to reset
> the ports from the userspace, add the definition to this platform
> device. The gpio can then be exported by the legancy gpio subsystem to
> toggle the mpcie reset pin.
>
> Signed-off-by: Florian Eckert <fe@dev.tdt.de>
> Acked-By: Enrico Weigelt <info@metux.net>

I'm not sure why you resend this, where is the changelog, where is the
version bump?..

> Author: Florian Eckert <fe@dev.tdt.de>

...moreover, what's this? We have From line and the first SoB in the
chain for authorship. If, in case, the author is not available and
some rework done, we usually give a credit as Co-developed-by or in
the commit message.

> ---
>  drivers/platform/x86/pcengines-apuv2.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/drivers/platform/x86/pcengines-apuv2.c b/drivers/platform/x86/pcengines-apuv2.c
> index e4c68ef..56703656 100644
> --- a/drivers/platform/x86/pcengines-apuv2.c
> +++ b/drivers/platform/x86/pcengines-apuv2.c
> @@ -32,6 +32,8 @@
>  #define APU2_GPIO_REG_LED3             AMD_FCH_GPIO_REG_GPIO59_DEVSLP1
>  #define APU2_GPIO_REG_MODESW           AMD_FCH_GPIO_REG_GPIO32_GE1
>  #define APU2_GPIO_REG_SIMSWAP          AMD_FCH_GPIO_REG_GPIO33_GE2
> +#define APU2_GPIO_REG_MPCIE2           AMD_FCH_GPIO_REG_GPIO59_DEVSLP0
> +#define APU2_GPIO_REG_MPCIE3           AMD_FCH_GPIO_REG_GPIO51
>
>  /* order in which the gpio lines are defined in the register list */
>  #define APU2_GPIO_LINE_LED1            0
> @@ -39,6 +41,8 @@
>  #define APU2_GPIO_LINE_LED3            2
>  #define APU2_GPIO_LINE_MODESW          3
>  #define APU2_GPIO_LINE_SIMSWAP         4
> +#define APU2_GPIO_LINE_MPCIE2          5
> +#define APU2_GPIO_LINE_MPCIE3          6
>
>  /* gpio device */
>
> @@ -48,6 +52,8 @@
>         [APU2_GPIO_LINE_LED3]           = APU2_GPIO_REG_LED3,
>         [APU2_GPIO_LINE_MODESW]         = APU2_GPIO_REG_MODESW,
>         [APU2_GPIO_LINE_SIMSWAP]        = APU2_GPIO_REG_SIMSWAP,
> +       [APU2_GPIO_LINE_MPCIE2]         = APU2_GPIO_REG_MPCIE2,
> +       [APU2_GPIO_LINE_MPCIE3]         = APU2_GPIO_REG_MPCIE3,
>  };
>
>  static const char * const apu2_gpio_names[] = {
> @@ -56,6 +62,8 @@
>         [APU2_GPIO_LINE_LED3]           = "front-led3",
>         [APU2_GPIO_LINE_MODESW]         = "front-button",
>         [APU2_GPIO_LINE_SIMSWAP]        = "simswap",
> +       [APU2_GPIO_LINE_MPCIE2]         = "mpcie2_reset",
> +       [APU2_GPIO_LINE_MPCIE3]         = "mpcie3_reset",
>  };
>
>  static const struct amd_fch_gpio_pdata board_apu2 = {
> --
> 1.9.1
>


-- 
With Best Regards,
Andy Shevchenko
