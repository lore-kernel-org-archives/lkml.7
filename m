Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7F2EC04AAC
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 06:37:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8720C205ED
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 06:37:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="frf8920I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726147AbfEFGhC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 02:37:02 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:44511 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725773AbfEFGhB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 02:37:01 -0400
Received: by mail-oi1-f194.google.com with SMTP id y25so1658135oih.11
        for <linux-kernel@vger.kernel.org>; Sun, 05 May 2019 23:37:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AsWrneXTR0dVmh3/0SghuMR1v5mpMf18phXdK8FnXQk=;
        b=frf8920IMdLHYA/tNXNdbO5znbdlL6YbO1Vla6P0uim8zVqGlJzdIdUoD9WDeJS6R8
         /s2Rt9jsQT/VZreSzLBh/1i1eBSmy3l3eHLvsSbEvK4Lgh1idRMTIPi0Z0JPe0rH4ybS
         s5pg63tEF90wA1Dlko0cr/SnnAAMkGfWeP1OOqGYkrles+0m21rVkBrpgS/tmXcJ5e9W
         XU7Dr5OGCdaMBI2txRDcgyJMb1dHaJiqoA32A0XpwSC5HhrYet6oFf5W4dHDv/jus9cM
         7e9xPoBFDurVIDAXFUmnJWqlfxY28c5ML7kuJ7sANzrCi4znsOpJZHVEpgmvLIfgHo4K
         QOvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AsWrneXTR0dVmh3/0SghuMR1v5mpMf18phXdK8FnXQk=;
        b=X8I8VD+uLpTERLYdjJqGWzM/nEEEo60NyU2PDuL1VpK6tdr0qbdJQO9EQNtXkaWGqv
         HM1oGojpRv0kO64YNKSZwYhyDcucm0Nv+B130GJ3zJqDCgP2ItOIxB8xLctZ1NDj38IH
         okLIJyac+nfD0GwkqO6lyXfBew0Lsp8bB+RDDWqEwhzX5wp28sR7GKjRkvkkIVmug4Jt
         FzC+Hf9ivFSCsgJ0UVeb7kEJ+owTeSMF4frawq5Ftpsh2vtMF0rKbvah31QyGUoSnr0A
         gSAmzGSJ2GAd30/GllcjLam4L+w4/v/oOIeZWoG97+gpZAcuumayW02FmGCSrlf4rlmT
         dXTg==
X-Gm-Message-State: APjAAAUYMb/gim1qqEpdCkXLczeij+rI+vond04X6QpuNPKIoXRrqHV+
        RzsDKkCnKmPqtJ01/zmoL1r9ownjuId5KK4fBjF0+w==
X-Google-Smtp-Source: APXvYqwfACU3oJMu1A/L3M8/Z8X5tpHYCsDugmBY2FX4wctU4dLdhD5XkYMiUU6ywBQrmX0xNHQIVr4RhVDekURBAXk=
X-Received: by 2002:aca:ba0b:: with SMTP id k11mr171531oif.57.1557124620939;
 Sun, 05 May 2019 23:37:00 -0700 (PDT)
MIME-Version: 1.0
References: <1246f7a9ce912458ea3b889b0c0e392897a664c8.1554879978.git.baolin.wang@linaro.org>
In-Reply-To: <1246f7a9ce912458ea3b889b0c0e392897a664c8.1554879978.git.baolin.wang@linaro.org>
From:   Baolin Wang <baolin.wang@linaro.org>
Date:   Mon, 6 May 2019 14:36:49 +0800
Message-ID: <CAMz4ku+1-w8va__JNkBME5tPuG0AdhzksVbNbYomqY94JggPVg@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: sprd: Add clock properties for serial devices
To:     Arnd Bergmann <arnd@arndb.de>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Olof Johansson <olof@lixom.net>, arm-soc <arm@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        DTML <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Olof,

On Wed, 10 Apr 2019 at 15:23, Baolin Wang <baolin.wang@linaro.org> wrote:
>
> We've introduced power management logics for the Spreadtrum serial
> controller by commit 062ec2774c8a ("serial: sprd: Add power management
> for the Spreadtrum serial controller"), thus add related clock properties
> to support this feature.
>
> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> ---

Could you take this patch through the arm-soc tree if no objections
from you? Thanks.

>  arch/arm64/boot/dts/sprd/whale2.dtsi |   16 ++++++++++++----
>  1 file changed, 12 insertions(+), 4 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/sprd/whale2.dtsi b/arch/arm64/boot/dts/sprd/whale2.dtsi
> index 34b6ca0..b5c5dce 100644
> --- a/arch/arm64/boot/dts/sprd/whale2.dtsi
> +++ b/arch/arm64/boot/dts/sprd/whale2.dtsi
> @@ -75,7 +75,9 @@
>                                              "sprd,sc9836-uart";
>                                 reg = <0x0 0x100>;
>                                 interrupts = <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>;
> -                               clocks = <&ext_26m>;
> +                               clock-names = "enable", "uart", "source";
> +                               clocks = <&apapb_gate CLK_UART0_EB>,
> +                                      <&ap_clk CLK_UART0>, <&ext_26m>;
>                                 status = "disabled";
>                         };
>
> @@ -84,7 +86,9 @@
>                                              "sprd,sc9836-uart";
>                                 reg = <0x100000 0x100>;
>                                 interrupts = <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>;
> -                               clocks = <&ext_26m>;
> +                               clock-names = "enable", "uart", "source";
> +                               clocks = <&apapb_gate CLK_UART1_EB>,
> +                                      <&ap_clk CLK_UART1>, <&ext_26m>;
>                                 status = "disabled";
>                         };
>
> @@ -93,7 +97,9 @@
>                                              "sprd,sc9836-uart";
>                                 reg = <0x200000 0x100>;
>                                 interrupts = <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>;
> -                               clocks = <&ext_26m>;
> +                               clock-names = "enable", "uart", "source";
> +                               clocks = <&apapb_gate CLK_UART2_EB>,
> +                                      <&ap_clk CLK_UART2>, <&ext_26m>;
>                                 status = "disabled";
>                         };
>
> @@ -102,7 +108,9 @@
>                                              "sprd,sc9836-uart";
>                                 reg = <0x300000 0x100>;
>                                 interrupts = <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>;
> -                               clocks = <&ext_26m>;
> +                               clock-names = "enable", "uart", "source";
> +                               clocks = <&apapb_gate CLK_UART3_EB>,
> +                                      <&ap_clk CLK_UART3>, <&ext_26m>;
>                                 status = "disabled";
>                         };
>                 };
> --
> 1.7.9.5
>


-- 
Baolin Wang
Best Regards
