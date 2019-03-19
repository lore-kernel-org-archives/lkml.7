Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2491BC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 21:22:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFA7B20850
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 21:22:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="mB5mkRew"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727426AbfCSVW0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 17:22:26 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:46153 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726712AbfCSVW0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 17:22:26 -0400
Received: by mail-ot1-f65.google.com with SMTP id c18so142944otl.13
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2019 14:22:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MNwiVpfGk3bQ+Y9AQVFuLEbxJUByoleMAgYrrdgJDFI=;
        b=mB5mkRewGL+QRfO4aAS+ve+CCjVFvHGLZMC0ybgF3XAPaQ3lt0dLdqT2+vSc/AwcFV
         ko6jd+dlRmwkov6aUaAVkcMX9yY/bmng3kDoxG3xdlN3HrWixn8VklMt9eDAq0SVXHd5
         dxrL9CIcwR3AYZ5fv30MvsaT9EF04BFZBKELmFaXpfyq/yiK1KabvgAa1Rrm6oGDupCo
         TQqziq4zv5vDyBOca70WLAq04/Y8esZXQVONY26yfknYbGSB5XkyiQTqAx60/7ZSDOlU
         o/hADS1EiqPTfH0sdn6RIu4Djc7EhHTmvA9O2Ev0LCQHg2LK0Yibpid0PMY/9KBCh9X9
         p38g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MNwiVpfGk3bQ+Y9AQVFuLEbxJUByoleMAgYrrdgJDFI=;
        b=S0XzVRoYYkK5Y5Wx6U8RNIr5QJK5p4bJkRpZUo6V7Hhk1urMZ6K66zfBU7oITOD89V
         AfYe4vsJSn+7cub9PYw6I81Bcd7ksTbVOfFdwYwuYbEzGpZ1zi5z+e0bBeNVROx78cfF
         DhMjJYj9q5UYhLJQwOxRz6Qi28Q28ABvx4NxTcZDiutyIuqtY3scQY2uTfTn1e5JBR/m
         hOsFbj7h/xyNISN5UxCAJjKFQcRj0REICq5JQr61GOOSBwKhYS7Y4Zva41AXGa/+kJEP
         azBfG6l22noOnl5qbQTv9E/EigaFdcqTe3tGZpt4ejoppQAYSCy1NY1ze7XAftnna/hz
         kiew==
X-Gm-Message-State: APjAAAUewd1TScetatydbDzvucg9ManIMlHYMzlh49fD5IQhhWcins1B
        XROxgkOp6RK51JPc31h6rpSTwqmsFLFe9UeBUb8=
X-Google-Smtp-Source: APXvYqwsRe+chiRp9/ji/QVAmBj039OoAMZwpbFziC3gzhPQTzCB4itVVKO28A5WCryAH9GyeMP1kbChpc64OUyNJrA=
X-Received: by 2002:a9d:5614:: with SMTP id e20mr3125794oti.348.1553030544566;
 Tue, 19 Mar 2019 14:22:24 -0700 (PDT)
MIME-Version: 1.0
References: <20190318095851.4062-1-narmstrong@baylibre.com>
 <20190318095851.4062-2-narmstrong@baylibre.com> <CAFBinCDfOEvmQcE7TgYvXmM1f=pywYbjhbAZWs4AYNXs8y6y7Q@mail.gmail.com>
 <7f391daf-db70-101a-18c7-04abf9c5a164@baylibre.com>
In-Reply-To: <7f391daf-db70-101a-18c7-04abf9c5a164@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Tue, 19 Mar 2019 22:22:13 +0100
Message-ID: <CAFBinCBduFG5uK9ghDW98fe4t17UeZj1b3STHByVY15C-3hB2A@mail.gmail.com>
Subject: Re: [PATCH v2 1/8] arm64: dts: meson: g12a: Add AO Clock + Reset
 Controller support
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     khilman@baylibre.com, linux-amlogic@lists.infradead.org,
        Jerome Brunet <jbrunet@baylibre.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Neil,

On Tue, Mar 19, 2019 at 9:47 AM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> On 18/03/2019 21:02, Martin Blumenstingl wrote:
> > Hi Neil,
> >
> > On Mon, Mar 18, 2019 at 10:59 AM Neil Armstrong <narmstrong@baylibre.com> wrote:
> >>
> >> Add nodes and properties for the AO Clocks and Resets.
> >>
> >> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> >> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> >> ---
> >>  arch/arm64/boot/dts/amlogic/meson-g12a.dtsi | 18 ++++++++++++++++++
> >>  1 file changed, 18 insertions(+)
> >>
> >> diff --git a/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
> >> index 31ddf9444b3e..5c0983edf837 100644
> >> --- a/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
> >> +++ b/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
> >> @@ -4,6 +4,7 @@
> >>   */
> >>
> >>  #include <dt-bindings/gpio/gpio.h>
> >> +#include <dt-bindings/clock/g12a-clkc.h>
> >>  #include <dt-bindings/interrupt-controller/irq.h>
> >>  #include <dt-bindings/interrupt-controller/arm-gic.h>
> >>
> >> @@ -122,6 +123,23 @@
> >>                         #size-cells = <2>;
> >>                         ranges = <0x0 0x0 0x0 0xff800000 0x0 0x100000>;
> >>
> >> +                       rti: sys-ctrl@0 {
> >> +                               compatible = "amlogic,meson-gx-ao-sysctrl",
> >> +                                            "simple-mfd", "syscon";
> >> +                               reg = <0x0 0x0 0x0 0x100>;
> >> +                               #address-cells = <2>;
> >> +                               #size-cells = <2>;
> >> +                               ranges = <0x0 0x0 0x0 0x0 0x0 0x100>;
> > sorry for noticing this only very late: I missed the #address-cells,
> > #size-cells and ranges property in my last review
> > do you have any change queued which requires this?
> > my understanding is that the drivers for all RTI children should use
> > the register offsets relative to the RTI start address. In that case
> > the child nodes neither have a unit-address nor a reg property, making
> > the last three properties unnecessary.
>
> We need the address-cells/size-cells and `ranges;` to satisfy the need
> for the gpio subnode of the pinctrl node.
>
> For GX, we didn't add the pinctrl in the sysctrl_AO subnode, but we should
> overwise we have overlapping.
ah, I see - thank you for the explanation.

setting #address-cells and #size-cells will probably yield dtc
warnings for the children without unit-address / reg property.
also the pinctrl driver and the syscon driver would still ioremap
overlapping memory regions (syscon: the full 0x100 range, the pinctrl
driver various 4 and 8 byte registers) because both are ioremap'ing
their register space.
but indeed, the overlapping dt nodes are solved with this approach.

Rob acked a binding for the Lantiq XWAY SoC's with a simple-mfd /
syscon as parent and children with a reg property. The parent node
defines a reg and ranges property, but neither #size-cells nor
#address-cells. the binding is documented here: [0]
The requirements seem similar to our pinctrl needs. We could end up
with only a single syscon and no overlapping ioremap for the pinctrl
driver and we may not even have to change the binding.

with this mail I want to start a discussion about the bindings of the
AO pin controller (similar to how we re-considered the binding of the
AO clock controller in the past). at the same time I'm not saying that
we immediately have to change it.


Regards
Martin


[0] https://www.kernel.org/doc/Documentation/devicetree/bindings/mips/lantiq/rcu.txt
