Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25491C282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 13:40:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0EA92064A
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 13:40:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555940412;
	bh=bELYdU20kXQtDdCJx2stGpStz6flReMe7DNfqabCDSw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=l1lI6ZFd9f3Qpj6g5DN0cD92vfd4yERXiKJnJC7XOtgv4UJS+yGt4fZX5ssghfiea
	 tyQ2GVrpoO2gCwMM7CUsMK97aqVMzFhLpwhtvW5fsrFbSf/vlvzWpTpOckXqN4HVfX
	 NmGrT9kc/XoUAeEGYBeIc+SOGIma5cHC8oiyAcPc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727482AbfDVNkK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 09:40:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:41148 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727069AbfDVNkK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 09:40:10 -0400
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 771ED21473;
        Mon, 22 Apr 2019 13:40:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555940408;
        bh=bELYdU20kXQtDdCJx2stGpStz6flReMe7DNfqabCDSw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=My2PGPbkXCN4LcbRO+ur4ALNmcWs7R/0sVpBLZ6fg+7oDi1f1mW+2PTVxD8BrYShp
         YdAI4c8CC1gQvI9vug0zovFU92nZk3gBO4EL14lxzGAEIEIaaqMOMxfM45N2wR4YkD
         gK9nFJa9y/6ioF8BQDA/6oacjKjrESdTub0RNWLU=
Received: by mail-qt1-f170.google.com with SMTP id w26so5287619qto.13;
        Mon, 22 Apr 2019 06:40:08 -0700 (PDT)
X-Gm-Message-State: APjAAAWrjOnHy2SG9PT9vZaDAtfT/lf26KJkmmEHsCP1PpsEhs22/vUs
        5OpkVw79Hp7otaTVKzKiNiPtvRDooPn9mj2vSA==
X-Google-Smtp-Source: APXvYqwKjV1O7na+j0LqP55p9ndz4b1/75v+MoEkHCD9LkbBe5OX/XaNqaKC4DAJuhhamDRIPnBAv8kHguPSsvhIkqs=
X-Received: by 2002:ac8:610f:: with SMTP id a15mr7923908qtm.257.1555940407602;
 Mon, 22 Apr 2019 06:40:07 -0700 (PDT)
MIME-Version: 1.0
References: <20190417165514.18689-1-angus@akkea.ca> <20190417165514.18689-2-angus@akkea.ca>
 <20190418151350.GC32345@bogus> <79d43377285d6897847ac1452afbb18a@www.akkea.ca>
In-Reply-To: <79d43377285d6897847ac1452afbb18a@www.akkea.ca>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 22 Apr 2019 08:39:55 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLZwUWrLO-m4BC6vXjBVDyY7hf8LE-amyDNgaJz3-=n0g@mail.gmail.com>
Message-ID: <CAL_JsqLZwUWrLO-m4BC6vXjBVDyY7hf8LE-amyDNgaJz3-=n0g@mail.gmail.com>
Subject: Re: [PATCH v5 1/3] arm64: dts: fsl: librem5: Add a device tree for
 the Librem5 devkit
To:     Angus Ainslie <angus@akkea.ca>
Cc:     angus.ainslie@puri.sm, Marco Felsch <m.felsch@pengutronix.de>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Guo Ren <guoren@kernel.org>,
        Thierry Reding <treding@nvidia.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        =?UTF-8?Q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Jacky Bai <ping.bai@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Bruno Thomsen <bruno.thomsen@gmail.com>,
        devicetree@vger.kernel.org,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-riscv@lists.infradead.org,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 18, 2019 at 12:44 PM Angus Ainslie <angus@akkea.ca> wrote:
>
> Hi Rob,
>
>
> On 2019-04-18 08:13, Rob Herring wrote:
> > On Wed, Apr 17, 2019 at 09:55:12AM -0700, Angus Ainslie (Purism) wrote:
> >> This is the development kit board for the Librem 5. The current level
> >> of
> >> support yields a working console and is able to boot userspace from
> >> the
> >> Network or eMMC.
> >>
> >> Additional subsystems that are active :
> >>
> >> - Both USB ports
> >> - SD card socket
> >> - WiFi usdhc
> >> - WWAN modem
> >> - GNSS
> >> - GPIO keys
> >> - LEDs
> >> - gyro
> >> - magnetometer
> >> - touchscreen
> >> - pwm
> >> - backlight
> >> - haptic motor
> >>
> >> Signed-off-by: Angus Ainslie (Purism) <angus@akkea.ca>
> >> ---
> >>  arch/arm64/boot/dts/freescale/Makefile        |   1 +
> >>  .../dts/freescale/imx8mq-librem5-devkit.dts   | 833
> >> ++++++++++++++++++
> >>  2 files changed, 834 insertions(+)
> >>  create mode 100644
> >> arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts
> >>
> >> diff --git a/arch/arm64/boot/dts/freescale/Makefile
> >> b/arch/arm64/boot/dts/freescale/Makefile
> >> index 0bd122f60549..c043aca66572 100644
> >> --- a/arch/arm64/boot/dts/freescale/Makefile
> >> +++ b/arch/arm64/boot/dts/freescale/Makefile
> >> @@ -22,6 +22,7 @@ dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-lx2160a-rdb.dtb
> >>
> >>  dtb-$(CONFIG_ARCH_MXC) += imx8mm-evk.dtb
> >>  dtb-$(CONFIG_ARCH_MXC) += imx8mq-evk.dtb
> >> +dtb-$(CONFIG_ARCH_MXC) += imx8mq-librem5-devkit.dtb
> >>  dtb-$(CONFIG_ARCH_MXC) += imx8mq-zii-ultra-rmb3.dtb
> >>  dtb-$(CONFIG_ARCH_MXC) += imx8mq-zii-ultra-zest.dtb
> >>  dtb-$(CONFIG_ARCH_MXC) += imx8qxp-mek.dtb
> >> diff --git a/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts
> >> b/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts
> >> new file mode 100644
> >> index 000000000000..846a72dc7640
> >> --- /dev/null
> >> +++ b/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts
> >
> >> +&usb3_phy0 {
> >> +    #address-cells = <1>;
> >> +    #size-cells = <0>;
> >> +    status = "okay";
> >> +
> >> +    port@0 {
> >> +            reg = <0>;
> >> +
> >> +            typec_hs: endpoint {
> >> +                    remote-endpoint = <&usb_con_hs>;
> >> +            };
> >> +    };
> >> +
> >> +    port@1 {
> >> +            reg = <1>;
> >> +
> >> +            typec_ss: endpoint {
> >> +                    remote-endpoint = <&usb_con_ss>;
> >> +            };
> >> +    };
> >
> > This is wrong. The graph should be between the USB controller and the
> > connector. The phy is not involved.
> >
> >> +};
> >> +
> >> +&usb3_phy1 {
> >> +    status = "okay";
> >> +};
> >> +
> >> +&usb_dwc3_0 {
> >> +    extcon = <&typec_ptn5100>;
> >
> > extcon is deprecated and you should only have the usb-connector
> > binding.
> > From the controller, you can walk the graph to the connector.
> >
>
> I not sure that I'm clear on what you mean. Here's what I think you want
> it changed to.

Yes, this looks correct.

>
> diff --git a/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts
> b/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts
> index 846a72dc7640..7b8770fdc5fb 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts
> +++ b/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts
> @@ -755,51 +755,50 @@
>   };
>
>   &uart4 { /* BT */
>          pinctrl-names = "default";
>          pinctrl-0 = <&pinctrl_uart4>, <&pinctrl_bt>;
>          uart-has-rtscts;
>          status = "okay";
>   };
>
>   &usb3_phy0 {
> +       status = "okay";
> +};
> +
> +&usb3_phy1 {
> +       status = "okay";
> +};
> +
> +&usb_dwc3_0 {
>          #address-cells = <1>;
>          #size-cells = <0>;
> +       dr_mode = "otg";
>          status = "okay";
>
>          port@0 {
>                  reg = <0>;
>
>                  typec_hs: endpoint {
>                          remote-endpoint = <&usb_con_hs>;
>                  };
>          };
>
>          port@1 {
>                  reg = <1>;
>
>                  typec_ss: endpoint {
>                          remote-endpoint = <&usb_con_ss>;
>                  };
>          };
>   };
>
> -&usb3_phy1 {
> -       status = "okay";
> -};
> -
> -&usb_dwc3_0 {
> -       extcon = <&typec_ptn5100>;
> -       dr_mode = "otg";
> -       status = "okay";
> -};
> -
>   &usb_dwc3_1 {
>          dr_mode = "host";
>          status = "okay";
>   };
>
>
>
> Thanks
> Angus
>
> >> +    dr_mode = "otg";
> >> +    status = "okay";
> >> +};
>
