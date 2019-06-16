Return-Path: <SRS0=7o0M=UP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81562C31E50
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Jun 2019 23:34:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C9C3205ED
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Jun 2019 23:34:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kDHAcFuF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727459AbfFPXau (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Jun 2019 19:30:50 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:45164 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727238AbfFPXau (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jun 2019 19:30:50 -0400
Received: by mail-lf1-f66.google.com with SMTP id u10so5108101lfm.12;
        Sun, 16 Jun 2019 16:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VsR4qH3Quc1HDcau96Vt06vNS8VQPWCgwBfYnvLlFks=;
        b=kDHAcFuFt5NMBgIOjjU+UpqZA+OtobCPFqC7+hpNToj8eHB8gWvQQF3/VnBGsqeSKe
         uKk7kykPnNI5+xlTWKQ8ootvDKXC4XFLW4Og1fm50Dan2KIY5XRuJMcJ6xuR8+6d9Y4p
         0qUBjoq9DclFgx+D45Aux4HrE9ORw1PvSMpY0yHc+ic341QXKWcjyjLDfKOpjU2cdDwp
         CqqUchYgzXEbeMx73gaBtFXQhauP8DEFoq6841UEQbTaRr47TEQo6kd19tx2k1MYluNQ
         bjfpdvMwuKiSx4lRRmcymOSQrWgB0Jy2Cg1Hd6ruzBPk3OGLdWIVr+BAAMGmUhSe4U9a
         l0ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VsR4qH3Quc1HDcau96Vt06vNS8VQPWCgwBfYnvLlFks=;
        b=YNXeEU0sctOAF6CtiTP/zcDsvhyiFSQpfngyG36v8t0smDK7Akt4gpzFrkQMV/EW4Q
         TCrZVX7KphZNDlfMYeCP495EYG1MsQt1lP7XRxeme0bW2mofyv4zCBTnDJHu56aF31OS
         gpi2zGTQSfrDjATQFiAg1UjLoEom20d57z2NMRSzxoSyrZqWEQ8SY/Fn3rki3UMraIYt
         PkOB86D3j/tOAWh8xTrW0f0XoZBXZAgQI7kpJxpNL0aiyDCUuqbOnq3PvVuOcmeUp4Gp
         3K57y+ay4K2VPR6+EoUCPNV/ju257PKW8tpTv2wdKFhQS60TEtF4awqrs6Y6l7iEXNrE
         rWUA==
X-Gm-Message-State: APjAAAVbv0bHKR7nCW8ExWIAp/2vSrauo1S4vI5eZd0nLitPrfkUzQB/
        GJLNBPuGaGjp/FT45x3fJQi/irM4zu1KrTs4Rto=
X-Google-Smtp-Source: APXvYqyeZ+75kYMyAoqTlOvU8ClVoGdKhHAO+Y1dv/4UZYIDHtsn1nrDZ/L8vzK8qffqSgwkgs/yw5jn9fD+iAVLg2M=
X-Received: by 2002:ac2:5a5e:: with SMTP id r30mr10747258lfn.12.1560727847800;
 Sun, 16 Jun 2019 16:30:47 -0700 (PDT)
MIME-Version: 1.0
References: <20190614080317.16850-1-andrew.smirnov@gmail.com>
In-Reply-To: <20190614080317.16850-1-andrew.smirnov@gmail.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Sun, 16 Jun 2019 20:30:56 -0300
Message-ID: <CAOMZO5Dpu_HLNWfCzx=hJTwbEJoGnY2KsXQM2JTqv34anfzGag@mail.gmail.com>
Subject: Re: [PATCH 1/2] ARM: dts: Add ZII support for ZII i.MX7 RMU2 board
To:     Andrey Smirnov <andrew.smirnov@gmail.com>
Cc:     "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Shawn Guo <shawnguo@kernel.org>, Rob Herring <robh@kernel.org>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Bob Langer <Bob.Langer@zii.aero>,
        Liang Pan <Liang.Pan@zii.aero>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrey,

On Fri, Jun 14, 2019 at 5:03 AM Andrey Smirnov <andrew.smirnov@gmail.com> wrote:

> +       mdio {
> +               fec1_phy: phy@0 {
> +                       pinctrl-names = "default";
> +                       pinctrl-0 = <&pinctrl_enet1_phy_reset>,
> +                                   <&pinctrl_enet1_phy_interrupt>;
> +                       reg = <0>;
> +                       interrupt-parent = <&gpio1>;
> +                       interrupts = <2 IRQ_TYPE_LEVEL_LOW>;
> +                       reset-gpio = <&gpio5 11 GPIO_ACTIVE_LOW>;

According to Documentation/devicetree/bindings/net/mdio.txt this
should be reset-gpios instead.
