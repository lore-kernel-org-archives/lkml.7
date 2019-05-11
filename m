Return-Path: <SRS0=o7UO=TL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDBB5C04AB1
	for <linux-kernel@archiver.kernel.org>; Sat, 11 May 2019 16:39:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEA9C2173B
	for <linux-kernel@archiver.kernel.org>; Sat, 11 May 2019 16:39:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F21w5ckI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728664AbfEKQjw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 May 2019 12:39:52 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:41711 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726761AbfEKQjw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 May 2019 12:39:52 -0400
Received: by mail-yw1-f66.google.com with SMTP id o65so7346382ywd.8;
        Sat, 11 May 2019 09:39:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=cjY3Gi3PUp53aoD3Q4Ldyp9wbi6dZLozT0FvDch+7/I=;
        b=F21w5ckIZPkwVLLoInsNZ9dA+EtE3H0nvwGZWdrSk6cUqXpWBpFPnRtfy4HVcpVHSI
         VYSbgDV19avxyE+1HKdMq5CQpHN0frNrNtat+d5R3qTDyoei/cJJ3KXh2bdRqH4PyePL
         WtJjjsTpeFyn5i6jL9up2W0jnhwwIuI/DDi4extrCrsW2JCfPs45so0JJ80qjtQRJLfY
         rcQb2M9zy9iFECemeOXL+xRoyBI5HTt+7y3X1ed/Z7mMvNiQ4p8ZSluIJC9iTM3cFvKl
         bqg/2RaUqLtmTv25WlZbffbxxTGBldV5IOsPmi0FSshe8c4TBCd4BYrSnrmuDz0oVjqL
         mW/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=cjY3Gi3PUp53aoD3Q4Ldyp9wbi6dZLozT0FvDch+7/I=;
        b=HxUmAN3I+ABLql2tWXKVHXK347gu4oWOPEbuwjn6G5auRXgpt53JZ2THPCuc550wki
         /9XHZ4UOisC3eAJwYSlakiXme/yH8DdluECr/vxncOeZiQ9fJzCXOaVBigXe0ONLn2pR
         rDZr5X2cef2+Rr5V8vYO0PgM6iTtY+jhdp61t17SVHVRHNm5GXLbaVPDF2pjoNMPgvJn
         A0jT7EDR7WudaCP6112b83I/yrItvRfu/43r0Yq4tLXYjy2GpH7k0yLDHCMIAgruvA1H
         7HtE7Dl1ViAQLNIZO1qjsqdUAb9XiV36dAhFqyMr4QqRrGRJSr1EFe7iLfxz3tHYSGfn
         6TsA==
X-Gm-Message-State: APjAAAVKtylTy2LM38E7zkHTBvllpC4G16ZlX9zUSxNv0zelHeHUYm6m
        Ou8LYlYL/3FqWeAVhC9RUmcyE5RJSaDjpckt6HqARAL4
X-Google-Smtp-Source: APXvYqxDFe1vJo1pQCJPxkbL9SV4OT2qMXaYt0E9Lp32loF8V0v7A6o769xLglSXr6GAMZE7lGYiUpsvSkyOpJEH6V0=
X-Received: by 2002:a81:4850:: with SMTP id v77mr9327334ywa.264.1557592790807;
 Sat, 11 May 2019 09:39:50 -0700 (PDT)
MIME-Version: 1.0
References: <20190417173031.9920-1-peron.clem@gmail.com>
In-Reply-To: <20190417173031.9920-1-peron.clem@gmail.com>
From:   =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Date:   Sat, 11 May 2019 18:39:39 +0200
Message-ID: <CAJiuCccu_wfgio9wUcOCP0o4XPRgQOvTOZS8St7mV88TAdwaRg@mail.gmail.com>
Subject: Re: [PATCH v3 0/8] Allwinner H6 Mali GPU support
To:     Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maxime,

Is this series ok for you ?

Thanks,
Clement

On Wed, 17 Apr 2019 at 19:30, Cl=C3=A9ment P=C3=A9ron <peron.clem@gmail.com=
> wrote:
>
> Hi,
>
> The Allwinner H6 has a Mali-T720 MP2. The drivers are
> out-of-tree so this series only introduce the dt-bindings.
>
> The first patch is from Neil Amstrong and has been already
> merged in linux-amlogic. It is required for this series.
>
> The second patch is from Icenowy Zheng where I changed the
> order has required by Rob Herring.
> See: https://patchwork.kernel.org/patch/10699829/
>
> Thanks,
> Clement
>
> Changes in v3 (Thanks to Maxime Ripard):
>  - Reauthor Icenowy for her path
>
> Changes in v2 (Thanks to Maxime Ripard):
>  - Drop GPU OPP Table
>  - Add clocks and clock-names in required
>
> Cl=C3=A9ment P=C3=A9ron (6):
>   dt-bindings: gpu: mali-midgard: Add h6 mali gpu compatible
>   arm64: dts: allwinner: Add ARM Mali GPU node for H6
>   arm64: dts: allwinner: Add mali GPU supply for Pine H64
>   arm64: dts: allwinner: Add mali GPU supply for Beelink GS1
>   arm64: dts: allwinner: Add mali GPU supply for OrangePi Boards
>   arm64: dts: allwinner: Add mali GPU supply for OrangePi 3
>
> Icenowy Zheng (1):
>   dt-bindings: gpu: mali-midgard: Add bus clock bindings
>
> Neil Armstrong (1):
>   dt-bindings: gpu: mali-midgard: Add resets property
>
>  .../bindings/gpu/arm,mali-midgard.txt         | 27 +++++++++++++++++++
>  .../dts/allwinner/sun50i-h6-beelink-gs1.dts   |  5 ++++
>  .../dts/allwinner/sun50i-h6-orangepi-3.dts    |  5 ++++
>  .../dts/allwinner/sun50i-h6-orangepi.dtsi     |  5 ++++
>  .../boot/dts/allwinner/sun50i-h6-pine-h64.dts |  5 ++++
>  arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi  | 14 ++++++++++
>  6 files changed, 61 insertions(+)
>
> --
> 2.17.1
>
