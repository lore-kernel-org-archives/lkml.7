Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77CB3CA9EB7
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 17:32:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CD9421906
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 17:32:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iIjn6zOk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730230AbfJWRcg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 13:32:36 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:38308 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730140AbfJWRcf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 13:32:35 -0400
Received: by mail-io1-f67.google.com with SMTP id u8so25923478iom.5
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2019 10:32:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FHddi31URb1ZVMU1f/OlQcKL3JwlroIUzHSEfU1rm9E=;
        b=iIjn6zOkon2+vy3u6ieqyT3hIL8hquUtW4WVxARJ6GHQwHgVlZingSEfEw9ylY7oSA
         1F16bAeKpgTLYL8UJtX2Etu3picTNixpMhzj/ekoOwp/cmGSBH7kGopfJcid2JgAy8Zk
         1ekeWPNa7uy0YtmbrdEsazn/sa0lGt/eFUJMFsJwBgjiSuI4qlqblHgEO7XKfG3qksLr
         IDlP36H3VVyB02zXq77wDIDehyaKyQ3jmqrMyVY2/qASiIgVPru4z632XnyVSIxYBQHb
         w03wb0KJl4xmm3rZ2KTkP2qYtu2ybDHY5MESrnzdRpr3BOw+46Vdgg7SldIhK+UA0OV0
         GUcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FHddi31URb1ZVMU1f/OlQcKL3JwlroIUzHSEfU1rm9E=;
        b=LxfVudPcwKtBhaZkCKVrVuTn5A8IVBCtY3duYLEtOuAszNcvlvybvNNZPinLPbej3k
         3VnkqodZPw1fvLnlaPl99oiYYJG7pHT4k7jL1tjfF33g7Q8geJOo+QV0oC9z1f6uCqZ/
         4X5SaLR0JXwaBTD0ytr9l0XxIfbXCaTYSvs1QNs+302jRbXK+3O/U6hQ9h42rCuROOiW
         h1lHbbi72bw9qC9JIC5iXAip4RiqCvEQTq9GLwGjL58A4DfR7Cbc65qGdWUljrBln5V3
         XP4kQbk97yZ2DUQRLqeNUr3gqBj1J5zz+ilJxQ/N20O4WcPWrtxiNflkGsCeP4qEyytD
         yYbA==
X-Gm-Message-State: APjAAAWxgVrAJ/kV17Rro3+Bj+HQhrQuyaKWJTl/fXI5RmqJnl71v4K8
        m2tLZZ2cn0eZE1gJrllJrp+JpJg541apOxYr0m3qHg==
X-Google-Smtp-Source: APXvYqxyBYMtAL3D/OX0ZAdgMK8IVMiPoByH/BDSVN52PLwP4Oc1eswZzBzK266InVy9jGWBwrafm+J4exhXkFSElJs=
X-Received: by 2002:a6b:d104:: with SMTP id l4mr4641180iob.50.1571851952354;
 Wed, 23 Oct 2019 10:32:32 -0700 (PDT)
MIME-Version: 1.0
References: <a38ab93d870a3b1b341a5c0da14fc7f3d4056684.1570630040.git.michal.simek@xilinx.com>
In-Reply-To: <a38ab93d870a3b1b341a5c0da14fc7f3d4056684.1570630040.git.michal.simek@xilinx.com>
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
Date:   Wed, 23 Oct 2019 11:32:21 -0600
Message-ID: <CANLsYkzkk9yPezSyU50TmWjDAZ-5D2Hmo0YztQzm+mnyZf1Www@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: zynq: enablement of coresight topology
To:     Michal Simek <michal.simek@xilinx.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Michal Simek <monstr@monstr.eu>, git@xilinx.com,
        Zumeng Chen <zumeng.chen@windriver.com>,
        Quanyang Wang <quanyang.wang@windriver.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Crosthwaite <peter.crosthwaite@xilinx.com>,
        Rob Herring <robh+dt@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Rob Herring <robherring2@gmail.com>,
        Steffen Trumtrar <s.trumtrar@pengutronix.de>,
        devicetree@vger.kernel.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michal,

I was not CC'ed on the original post so I just noticed this today,
hence the late reply.  I don't know if you were looking for feedback
or already picked up the patch but here it is anyway.

On Wed, 9 Oct 2019 at 08:07, Michal Simek <michal.simek@xilinx.com> wrote:
>
> From: Zumeng Chen <zumeng.chen@windriver.com>
>
> This patch is to build the coresight topology structure of zynq-7000
> series according to the docs of coresight and userguide of zynq-7000.
>
> Signed-off-by: Zumeng Chen <zumeng.chen@windriver.com>
> Signed-off-by: Quanyang Wang <quanyang.wang@windriver.com>
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> ---
>
>  arch/arm/boot/dts/zynq-7000.dtsi | 158 +++++++++++++++++++++++++++++++
>  1 file changed, 158 insertions(+)
>
> diff --git a/arch/arm/boot/dts/zynq-7000.dtsi b/arch/arm/boot/dts/zynq-7000.dtsi
> index ca6425ad794c..86430ad76fee 100644
> --- a/arch/arm/boot/dts/zynq-7000.dtsi
> +++ b/arch/arm/boot/dts/zynq-7000.dtsi
> @@ -59,6 +59,40 @@
>                 regulator-always-on;
>         };
>
> +       replicator {
> +               compatible = "arm,coresight-static-replicator";
> +               clocks = <&clkc 27>, <&clkc 46>, <&clkc 47>;
> +               clock-names = "apb_pclk", "dbg_trc", "dbg_apb";
> +
> +               out-ports {
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
> +
> +                       /* replicator output ports */
> +                       port@0 {
> +                               reg = <0>;
> +                               replicator_out_port0: endpoint {
> +                                       remote-endpoint = <&tpiu_in_port>;
> +                               };
> +                       };
> +                       port@1 {
> +                               reg = <1>;
> +                               replicator_out_port1: endpoint {
> +                                       remote-endpoint = <&etb_in_port>;
> +                               };
> +                       };
> +               };
> +               in-ports {
> +                       /* replicator input port */
> +                       port {
> +                               replicator_in_port0: endpoint {
> +                                       slave-mode;

The slave-mode property is no longer required and probably an
oversight since it doesn't appear elsewhere in this patch.

> +                                       remote-endpoint = <&funnel_out_port>;
> +                               };
> +                       };
> +               };
> +       };
> +
>         amba: amba {
>                 compatible = "simple-bus";
>                 #address-cells = <1>;
> @@ -365,5 +399,129 @@
>                         reg = <0xf8005000 0x1000>;
>                         timeout-sec = <10>;
>                 };
> +
> +               etb@f8801000 {
> +                       compatible = "arm,coresight-etb10", "arm,primecell";
> +                       reg = <0xf8801000 0x1000>;
> +                       clocks = <&clkc 27>, <&clkc 46>, <&clkc 47>;
> +                       clock-names = "apb_pclk", "dbg_trc", "dbg_apb";
> +                       in-ports {
> +                               port {
> +                                       etb_in_port: endpoint {
> +                                               remote-endpoint = <&replicator_out_port1>;
> +                                       };
> +                               };
> +                       };
> +               };
> +
> +               tpiu@f8803000 {
> +                       compatible = "arm,coresight-tpiu", "arm,primecell";
> +                       reg = <0xf8803000 0x1000>;
> +                       clocks = <&clkc 27>, <&clkc 46>, <&clkc 47>;
> +                       clock-names = "apb_pclk", "dbg_trc", "dbg_apb";
> +                       in-ports {
> +                               port {
> +                                       tpiu_in_port: endpoint {
> +                                               remote-endpoint = <&replicator_out_port0>;
> +                                       };
> +                               };
> +                       };
> +               };
> +
> +               funnel@f8804000 {
> +                       compatible = "arm,coresight-static-funnel", "arm,primecell";
> +                       reg = <0xf8804000 0x1000>;
> +                       clocks = <&clkc 27>, <&clkc 46>, <&clkc 47>;
> +                       clock-names = "apb_pclk", "dbg_trc", "dbg_apb";
> +
> +                       /* funnel output ports */
> +                       out-ports {
> +                               port {
> +                                       funnel_out_port: endpoint {
> +                                               remote-endpoint =
> +                                                       <&replicator_in_port0>;
> +                                       };
> +                               };
> +                       };
> +
> +                       in-ports {
> +                               #address-cells = <1>;
> +                               #size-cells = <0>;
> +
> +                               /* funnel input ports */
> +                               port@0 {
> +                                       reg = <0>;
> +                                       funnel0_in_port0: endpoint {
> +                                               remote-endpoint = <&ptm0_out_port>;
> +                                       };
> +                               };
> +
> +                               port@1 {
> +                                       reg = <1>;
> +                                       funnel0_in_port1: endpoint {
> +                                               remote-endpoint = <&ptm1_out_port>;
> +                                       };
> +                               };
> +
> +                               port@2 {
> +                                       reg = <2>;
> +                                       funnel0_in_port2: endpoint {
> +                                       };
> +                               };
> +
> +                               port@3 {
> +                                       reg = <3>;
> +                                       funnel0_in_port3: endpoint {
> +                                               remote-endpoint = <&itm_out_port>;
> +                                       };
> +                               };
> +                               /* The other input ports are not connect to anything */
> +                       };
> +               };
> +
> +               /* ITM is not supported by kernel, only leave device node here */
> +               itm@f8805000 {
> +                       compatible = "arm,coresight-etm3x", "arm,primecell";

If I remember correctly ITM and ETMv3 are quite different - please
remove entirely.

> +                       reg = <0xf8805000 0x1000>;
> +                       clocks = <&clkc 27>, <&clkc 46>, <&clkc 47>;
> +                       clock-names = "apb_pclk", "dbg_trc", "dbg_apb";
> +                       out-ports {
> +                               port {
> +                                       itm_out_port: endpoint {
> +                                               remote-endpoint = <&funnel0_in_port3>;
> +                                       };
> +                               };
> +                       };
> +               };
> +
> +               ptm@f889c000 {
> +                       compatible = "arm,coresight-etm3x", "arm,primecell";
> +                       reg = <0xf889c000 0x1000>;
> +                       clocks = <&clkc 27>, <&clkc 46>, <&clkc 47>;
> +                       clock-names = "apb_pclk", "dbg_trc", "dbg_apb";
> +                       cpu = <&cpu0>;
> +                       out-ports {
> +                               port {
> +                                       ptm0_out_port: endpoint {
> +                                               remote-endpoint = <&funnel0_in_port0>;
> +                                       };
> +                               };
> +                       };
> +               };
> +
> +               ptm@f889d000 {
> +                       compatible = "arm,coresight-etm3x", "arm,primecell";
> +                       reg = <0xf889d000 0x1000>;
> +                       clocks = <&clkc 27>, <&clkc 46>, <&clkc 47>;
> +                       clock-names = "apb_pclk", "dbg_trc", "dbg_apb";
> +                       cpu = <&cpu1>;
> +                       out-ports {
> +                               port {
> +                                       ptm1_out_port: endpoint {
> +                                               remote-endpoint = <&funnel0_in_port1>;
> +                                       };
> +                               };
> +                       };
> +               };

With the above:

Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>

>         };
>  };
> --
> 2.17.1
>
