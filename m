Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 314E2C3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 14:08:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2333214DA
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 14:08:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S34JO61X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730533AbfHTOIW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 10:08:22 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:38728 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730501AbfHTOIV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 10:08:21 -0400
Received: by mail-io1-f68.google.com with SMTP id p12so9980900iog.5
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2019 07:08:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fpwbVMYwxUnibszpYPVBni4D9LBJrSdVRZvq8XMF3dc=;
        b=S34JO61XhS+u1GLjLFoTUKed6GVRRSgkk3Arpgx8OBkwxsoKRtiCnQQXdc09+4DtHY
         mbX+nvQfIMniKtrO+zL9vNlQ3VrCRvbep47ibmsFcv52bzUWXaJkCH08iw0XyLM/xehS
         uupRlRmIVwXIJsfpP4zE2GykQqXmDmBX33GLxBd/STXzc0pGgRlakZSOnM53B1xxkIoe
         LZ3jV11bWoW9IGZNgh2e+u1eSPggfJ1bH0cPltjml8wFIhvcWhXETP6ZCQphzaboTXmN
         Oh6VpLXyicoyLZjoSpvg5hE7IjJyflldFgYrxVeRgvcK+0oKeVbXjCcWSxVvPEql4j8b
         8XAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fpwbVMYwxUnibszpYPVBni4D9LBJrSdVRZvq8XMF3dc=;
        b=ppczk4wrgwNzeZWddi62ELzJE53O45H4j673jzgqXdW//WT/awX4aoPybUTJjEc/aA
         3vPYFAODSi+vxEmGq5yimce2vsxEV203ISZICFOP5IDrVGjB+PnAcT+hxF7PlSO/xxwc
         1oy0oXhN+uOsE+So+G2WrzJuoQ6NotuxVzayRY9AUzLLVXA3cWwj/p8d6hxU8mfzH4ii
         HI0Mnt9pcO6c/Df6RKqquLrQdqdcX3ASe/VDNnfCW7toxsHEz97lkU4SMBvAxQknQHFZ
         4hMCJuaPIi+woy2IROFHz1V4mev7wuB53hPSk8egl4TMTaWydDV2fjJCEcbGH0JD4Cvm
         pu3g==
X-Gm-Message-State: APjAAAWtiQ0yznqpVZcPCdyZs6Yj/jB/p88bsQ2nI5jPSV9sG/OLp2BT
        kLta2dBmL0lOGmwR8TcoYYT8ihGkpGeM4qGd1wM=
X-Google-Smtp-Source: APXvYqzqt6CWsnAUJZOQaWzeo+IS+I+nQxOIPR7m7CFVURAU5XmkaYUTy/8+9wGOBLp/m+OjVQgL/nYA7Z+kXtbaGko=
X-Received: by 2002:a02:8481:: with SMTP id f1mr3948058jai.112.1566310100786;
 Tue, 20 Aug 2019 07:08:20 -0700 (PDT)
MIME-Version: 1.0
References: <20190820030804.8892-1-andrew.smirnov@gmail.com>
In-Reply-To: <20190820030804.8892-1-andrew.smirnov@gmail.com>
From:   Chris Healy <cphealy@gmail.com>
Date:   Tue, 20 Aug 2019 07:08:09 -0700
Message-ID: <CAFXsbZoaZoM=1ue9vDpHhVgCaoymP=y8qza4U9Hsrh2wzsH_bQ@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: vf610-zii-cfu1: Slow I2C0 down to 100kHz
To:     Andrey Smirnov <andrew.smirnov@gmail.com>
Cc:     linux ARM <linux-arm-kernel@lists.infradead.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 19, 2019 at 8:08 PM Andrey Smirnov <andrew.smirnov@gmail.com> wrote:
>
> Fiber-optic module attached to the bus is only rated to work at
> 100kHz, so drop the bus frequncy to accomodate that.
>
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Chris Healy <cphealy@gmail.com>
> Cc: Fabio Estevam <festevam@gmail.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  arch/arm/boot/dts/vf610-zii-cfu1.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm/boot/dts/vf610-zii-cfu1.dts b/arch/arm/boot/dts/vf610-zii-cfu1.dts
> index ff460a1de85a..28732249cfc0 100644
> --- a/arch/arm/boot/dts/vf610-zii-cfu1.dts
> +++ b/arch/arm/boot/dts/vf610-zii-cfu1.dts
> @@ -207,7 +207,7 @@
>  };
>
>  &i2c0 {
> -       clock-frequency = <400000>;
> +       clock-frequency = <100000>;
>         pinctrl-names = "default";
>         pinctrl-0 = <&pinctrl_i2c0>;
>         status = "okay";
> --
> 2.21.0
>

Reviewed-by: Chris Healy <cphealy@gmail.com>
