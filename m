Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B3B3C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 10:51:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46DB62075B
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 10:51:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MPsBCCS0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728360AbfDPKv3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 06:51:29 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:35440 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726241AbfDPKv2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 06:51:28 -0400
Received: by mail-lj1-f195.google.com with SMTP id t4so10150238ljc.2;
        Tue, 16 Apr 2019 03:51:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CFj5zMfOTX+3TzhFRY1aTS7aUMDT9tUdVbCULikU1+U=;
        b=MPsBCCS0D4Yf8KSJ/Ji4bOVXNme3A/0dZe7oXLV439ZKi+DE5648cqASxhVNedjcEI
         k3aabHRQrX+Ww2eATdr2wpeM8bus5VajBTMzuooE2besAA603eHJ1oVIc9GgDRQtEO0I
         LaOin0IBF+IlfMfdzf3vYCgm8mftb3TwsQS7EA1fdkUHOQHFB1HErJxXlWb3wlbU/S7y
         JteoPg8MDqvEpK6f0hM7sTmimfX/k2wjyLq62s4j+KR0mlQKP5GTHjUOAZCNSXipTGKd
         t6HRw+paEwnL6N+yh6OkKYXI27NKFeTNQYzBeZsNefCxSGdsiZGiZwdkjZw7+X70t3hl
         wslg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CFj5zMfOTX+3TzhFRY1aTS7aUMDT9tUdVbCULikU1+U=;
        b=EgjK/+n9qPdhVWvvA3TTn+sES3dro7Rkm75GHK5YB0htYB3/YSD9eWNJtdj6CnAOBN
         YGfE5dxmQH31LDNpXHHq5zV/V7TxGVdYjjvfsaZIAx0zVJU3Nr3H5NAwD/BM+7hROJK9
         tab+cnll9K/4cQZNiOI5KfQGX6N7eaZX1UUxymlbfJzsVtffanljqx7uYPlFlwRdMEs6
         2J8XrTk8p2LHjQUCc6LW03HB65yZyGNqWeKCc8ujGxpXhEXXNSLW7WRFF/cefEDWMrZt
         lCTdgJMPWEmOtqovkC4bxuRnAPeL9Q8XlnSu2yKgcPdRkeushDjVi+I8BhRZ8l9P8AO/
         cMyQ==
X-Gm-Message-State: APjAAAXCqOAwe2QxW654KPbTYApmau7g9X3U0/0IMs1XiPYn5kSdl5IT
        AtbJjszgXHRSQ3a7y/4MPT15lZhX8X2i5IvxptZJzg==
X-Google-Smtp-Source: APXvYqylH27ZusytrmH9QZSXJOsmqvV9UdEFqDRs8406M4DLFQXsI4DLtq85bDN5rfBqPtM4M2QjoT8M/q5y9jfn+yI=
X-Received: by 2002:a2e:6e14:: with SMTP id j20mr26382729ljc.172.1555411886616;
 Tue, 16 Apr 2019 03:51:26 -0700 (PDT)
MIME-Version: 1.0
References: <20190411232315.19588-1-olteanv@gmail.com> <20190411232315.19588-2-olteanv@gmail.com>
In-Reply-To: <20190411232315.19588-2-olteanv@gmail.com>
From:   Vladimir Oltean <olteanv@gmail.com>
Date:   Tue, 16 Apr 2019 13:51:15 +0300
Message-ID: <CA+h21hqnF5+VXZnHeipKMEHRmxmgRkXuQQQuiDE4-gKj6OAO4w@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] ARM: dts: ls1021: Fix SGMII PCS link remaining
 down after PHY disconnect
To:     shawnguo@kernel.org, leoyang.li@nxp.com,
        Claudiu Manoil <claudiu.manoil@nxp.com>
Cc:     robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev <netdev@vger.kernel.org>, davem@davemloft.net
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Apr 2019 at 02:27, Vladimir Oltean <olteanv@gmail.com> wrote:
>
> Each eTSEC MAC has its own TBI (SGMII) PCS and private MDIO bus.
> But due to a DTS oversight, both SGMII-compatible MACs of the LS1021 SoC
> are pointing towards the same internal PCS. Therefore nobody is
> controlling the internal PCS of eTSEC0.
>
> Upon initial ndo_open, the SGMII link is ok by virtue of U-boot
> initialization. But upon an ifdown/ifup sequence, the code path from
> ndo_open -> init_phy -> gfar_configure_serdes does not get executed for
> the PCS of eTSEC0 (and is executed twice for MAC eTSEC1). So the SGMII
> link remains down for eTSEC0. On the LS1021A-TWR board, to signal this
> failure condition, the PHY driver keeps printing
> '803x_aneg_done: SGMII link is not ok'.
>
> Fixes: 055223d4d22d ("ARM: dts: ls1021a: Enable the eTSEC ports on QDS and TWR")
> Signed-off-by: Vladimir Oltean <olteanv@gmail.com>
> Reviewed-by: Claudiu Manoil <claudiu.manoil@nxp.com>
> ---
>  arch/arm/boot/dts/ls1021a-twr.dts | 9 ++++++++-
>  arch/arm/boot/dts/ls1021a.dtsi    | 9 +++++++++
>  2 files changed, 17 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm/boot/dts/ls1021a-twr.dts b/arch/arm/boot/dts/ls1021a-twr.dts
> index 97e1fb7ea932..9b1fe99d55b1 100644
> --- a/arch/arm/boot/dts/ls1021a-twr.dts
> +++ b/arch/arm/boot/dts/ls1021a-twr.dts
> @@ -145,7 +145,7 @@
>  };
>
>  &enet0 {
> -       tbi-handle = <&tbi1>;
> +       tbi-handle = <&tbi0>;
>         phy-handle = <&sgmii_phy2>;
>         phy-connection-type = "sgmii";
>         status = "okay";
> @@ -225,6 +225,13 @@
>         sgmii_phy2: ethernet-phy@2 {
>                 reg = <0x2>;
>         };
> +       tbi0: tbi-phy@1f {
> +               reg = <0x1f>;
> +               device_type = "tbi-phy";
> +       };
> +};
> +
> +&mdio1 {
>         tbi1: tbi-phy@1f {
>                 reg = <0x1f>;
>                 device_type = "tbi-phy";
> diff --git a/arch/arm/boot/dts/ls1021a.dtsi b/arch/arm/boot/dts/ls1021a.dtsi
> index 1a2a9509d9c2..89eab1fd1f7f 100644
> --- a/arch/arm/boot/dts/ls1021a.dtsi
> +++ b/arch/arm/boot/dts/ls1021a.dtsi
> @@ -709,6 +709,15 @@
>                               <0x0 0x2d10030 0x0 0x4>;
>                 };
>
> +               mdio1: mdio@2d64000 {
> +                       compatible = "fsl,etsec2-mdio";
> +                       device_type = "mdio";
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
> +                       reg = <0x0 0x2d64000 0x0 0x4000>,
> +                             <0x0 0x2d50030 0x0 0x4>;
> +               };
> +
>                 ptp_clock@2d10e00 {
>                         compatible = "fsl,etsec-ptp";
>                         reg = <0x0 0x2d10e00 0x0 0xb0>;
> --
> 2.17.1
>

Hi Leo,

Just a reminder that I resent this patch rebased on top of the
compatible string change.

Thanks,
-Vladimir
