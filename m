Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56DB3C43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 15:49:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A02B204EC
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 15:49:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="h0Hvchde"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727205AbfEBPtM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 11:49:12 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:53882 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727230AbfEBPtK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 11:49:10 -0400
Received: by mail-wm1-f66.google.com with SMTP id q15so3519942wmf.3
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2019 08:49:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=lmseT/oV4g4JyfQBt+kOYi8IdFsjCpNyJUcir6N564A=;
        b=h0Hvchdem+ldCKqn3c+OxwkVgp0lVMhxjrUO5N0FknvtRfbjKZExQdOUhKk3uxzcrY
         A2VbqSX7IbpEChSRb1xj13luAXv7BhbxK1XvxUU7gHyrsP11YqIg6+5g6gYPVEhSU9VJ
         4QEzFK6cDmGRA5ymrnBIOGej31q4qKffk8klBJv9Ss2r8U4gCAkAyfJKh+3ktexGtv9u
         QC5QqfCCFpNwKTX6iiJBJzXvTjTFXw896NvffhIsJRq/Wh0eb9HZGS+WcNPJ0cJ1YTim
         LxOR1Fpf3axYkbM4Ls39KYeyP0MyICPi6xYjObb7iGI9p+pqtZ46asxoA6A8KtBOkCxj
         nayQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=lmseT/oV4g4JyfQBt+kOYi8IdFsjCpNyJUcir6N564A=;
        b=dQxfLH3oi1DizJvnSVSgzbwkoEFCW8zV+wllEZNSp/cjTNC/L04NohGEjV0cCgz2KW
         ekOOEo+7KuTYa3dKJ5fsXnhNHWpXFa+0a3NUKh7B2YvndCdzTskCvfkVx0CnOYR3Q7b6
         kbeVC6pD7l/l5D+lPsK1pu+fm8B0GuUPMRg6qlWGGZNprM/X9d04Fts/zOeALvyBn8va
         m/AERE/Rt4o6KSXftJp3aTxDFIBB8AgOjqWyeMfkGfM+sYRTylynIzCMxeAv+b1Bv2mk
         mTE9YC0+EsL9oG/semYNfrfhCqS6VTCwzEvmmopf5JHY0WJr75RjjQwF5W++Lf9jyk14
         rLHw==
X-Gm-Message-State: APjAAAX6nDt59/2T5ncEeKDgdkQwg08Y/HfuUbECfjiMOpdy44aXi8c+
        hyppoLVGCvEg5AYdwfNC6IjLmw==
X-Google-Smtp-Source: APXvYqz5aYD2MjdtQ+TVC9p61KAANcm8pIxtBYpGCsO2J0+xh8h9y8M8Om6WZVW02vGoKu16S0pP7A==
X-Received: by 2002:a1c:cc10:: with SMTP id h16mr2973571wmb.39.1556812148787;
        Thu, 02 May 2019 08:49:08 -0700 (PDT)
Received: from arch-late (a109-49-46-234.cpe.netcabo.pt. [109.49.46.234])
        by smtp.gmail.com with ESMTPSA id t126sm986135wma.1.2019.05.02.08.49.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 02 May 2019 08:49:08 -0700 (PDT)
References: <20190430074730.8236-1-sebastien.szymanski@armadeus.com> <CAOMZO5D=BHWgOieLfz4bxL8v4bDmNOutUUnYSzW89KNtYn=Z9g@mail.gmail.com>
User-agent: mu4e 1.2.0; emacs 27.0.50
From:   Rui Miguel Silva <rui.silva@linaro.org>
To:     Fabio Estevam <festevam@gmail.com>
Cc:     =?utf-8?Q?S=C3=A9bastien?= Szymanski 
        <sebastien.szymanski@armadeus.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "moderated list\:ARM\/FREESCALE IMX \/ MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list\:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH 1/2] ARM: dts: imx6ul: Add csi node
In-reply-to: <CAOMZO5D=BHWgOieLfz4bxL8v4bDmNOutUUnYSzW89KNtYn=Z9g@mail.gmail.com>
Date:   Thu, 02 May 2019 16:49:06 +0100
Message-ID: <m3ftpw6eml.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Oi Fabio,
On Thu 02 May 2019 at 16:28, Fabio Estevam wrote:
> [Adding Rui]
>
> On Tue, Apr 30, 2019 at 4:47 AM S=C3=A9bastien Szymanski
> <sebastien.szymanski@armadeus.com> wrote:
>>
>> Add csi node for i.MX6UL SoC.
>>
>> Signed-off-by: S=C3=A9bastien Szymanski <sebastien.szymanski@armadeus.co=
m>
>> ---
>>  arch/arm/boot/dts/imx6ul.dtsi | 11 +++++++++++
>>  1 file changed, 11 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/imx6ul.dtsi b/arch/arm/boot/dts/imx6ul.dt=
si
>> index 62ed30c781ed..af322bc58333 100644
>> --- a/arch/arm/boot/dts/imx6ul.dtsi
>> +++ b/arch/arm/boot/dts/imx6ul.dtsi
>> @@ -951,6 +951,17 @@
>>                                 };
>>                         };
>>
>> +                       csi: csi@21c4000 {
>> +                               compatible =3D "fsl,imx6ul-csi", "fsl,im=
x7-csi";
>> +                               reg =3D <0x021c4000 0x4000>;
>> +                               interrupts =3D <GIC_SPI 7 IRQ_TYPE_LEVEL=
_HIGH>;
>> +                               clocks =3D <&clks IMX6UL_CLK_DUMMY>,
>> +                                        <&clks IMX6UL_CLK_CSI>,
>> +                                        <&clks IMX6UL_CLK_DUMMY>;
>> +                               clock-names =3D "axi", "mclk", "dcic";
>
> Also, I understand you followed
> Documentation/devicetree/bindings/media/imx7-csi.txt and passed these
> three clocks, but looking at the i.MX7D and i.MX6UL/ULL Reference
> Manuals, I don't find the  the descriptions for the "axi" and "dcic"
> CSI clocks.
>
> It looks like that only "mclk" is what we really need here.

Yeah, you are right.

>
> Should we change the bindings and the imx7-csi driver to not request
> "axi" and "dcic" clocks?
>
> Rui, what do you think? If you agree I can send a fix for this.

If you please, that would be great. thanks.

---
Cheers,
	Rui

