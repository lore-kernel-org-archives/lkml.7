Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21244C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 20:15:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DB39206BB
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 20:15:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="t3et7p6L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389173AbfIEUPr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 16:15:47 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:35122 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731390AbfIEUPq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 16:15:46 -0400
Received: by mail-oi1-f194.google.com with SMTP id a127so3044660oii.2;
        Thu, 05 Sep 2019 13:15:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=f4Km6SD866R0K00m5TcRPMaTtKdzrbq/4ljlsuFwyq4=;
        b=t3et7p6L0/whLJE/CMRrP2K3uNDjk8pWYu6Z+iHJ/66Y1V1Y6L0cwifYXlDTXXLZU3
         3MBi7QwdaNrwDJDSiIIvPoke8D4qYmR5KifsoiZvryw5rCskksgTXJIgtTdbkyJgh8qV
         MJtYVr3BW9cjCbQ41WAa98hOnuGLeq4iDZN56LFw/ekt4nC8vTPzq264Qt5ezYI9sCTJ
         +c4RKH3NC5pp7zQoE+JvgkdxisarX3FPxmxyzSpxbX7RfbIIJzrBHCmsifjnzFTn+wL+
         HLYJB/guTPodagOyMZiPuYILX1K2IHMxDbuYFdTogyBfGFbE2z+fgHbQK52gQmjRpO/4
         8WXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=f4Km6SD866R0K00m5TcRPMaTtKdzrbq/4ljlsuFwyq4=;
        b=fkXZ1IDOaJtcW861V3DME/qmh7874GbQ1H7KFgh2NwhLp9NCTh6luCk3FAPrKEf1gh
         8RnbZSdSpNIWiSc4Qk5KwVlSqlero9g9BK41xWfVn+C6/+N/A/5uwc34xJQ/ZxMFh/sH
         MZi7r/QbUs0/1Px6wpAPwnWxTbTkDiXYi4vxqVxbdZP7PKf7RBIUN32w4zmn00HnCn7R
         9JzGb9JXRK43beXFJOwL1fj/+QGJ8c9BGnOq3r6CvdOjv6gEYdhCDNpq3w4nX1HSTIJ5
         kd3RP3yhopJIBv1VmBuA3yEe0OIEPxk54EUZ5pTdtiChivmzreFZzuNjuEhDh3DPCrA5
         1FPw==
X-Gm-Message-State: APjAAAWwZyW4xL4nnqOTtF5D6RPOJgXhkrsrAWqywiAKVzt3+cDOPvh8
        ukW4DoZghc4Z7H5VHbnxUQqiYLvfaICRwxV34eo=
X-Google-Smtp-Source: APXvYqz10+RYiYCkiOZQNb4X6pwZA8FC8OaEWNeVGyU1oIcgk9EjqHMgE+OjmcTpYIwU9qrIKMWD+qXHhX6pFCO82+I=
X-Received: by 2002:a05:6808:b14:: with SMTP id s20mr4202379oij.15.1567714545391;
 Thu, 05 Sep 2019 13:15:45 -0700 (PDT)
MIME-Version: 1.0
References: <1567667251-33466-1-git-send-email-jianxin.pan@amlogic.com> <1567667251-33466-5-git-send-email-jianxin.pan@amlogic.com>
In-Reply-To: <1567667251-33466-5-git-send-email-jianxin.pan@amlogic.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Thu, 5 Sep 2019 22:15:34 +0200
Message-ID: <CAFBinCBSmW4y-Dz7EkJMV8HOU4k6Z0G-K6T77XnVrHyubaSsdg@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] arm64: dts: add support for A1 based Amlogic AD401
To:     Jianxin Pan <jianxin.pan@amlogic.com>
Cc:     Kevin Hilman <khilman@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Carlo Caione <carlo@caione.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Jian Hu <jian.hu@amlogic.com>,
        Hanjie Lin <hanjie.lin@amlogic.com>,
        Xingyu Chen <xingyu.chen@amlogic.com>,
        Victor Wan <victor.wan@amlogic.com>,
        Qiufang Dai <qiufang.dai@amlogic.com>,
        Tao Zeng <tao.zeng@amlogic.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jianxin,

(it's great to see that you and your team are upstreaming this early)

On Thu, Sep 5, 2019 at 9:08 AM Jianxin Pan <jianxin.pan@amlogic.com> wrote:
[...]
> +       memory@0 {
> +               device_type = "memory";
> +               reg = <0x0 0x0 0x0 0x8000000>;
> +               /*linux,usable-memory = <0x0 0x0 0x0 0x8000000>;*/
why do we need that comment here (I don't understand it - why doesn't
the "reg" property cover this)?

> +       };
> +};
> +
> +&uart_AO_B {
> +       status = "okay";
> +};
> diff --git a/arch/arm64/boot/dts/amlogic/meson-a1.dtsi b/arch/arm64/boot/dts/amlogic/meson-a1.dtsi
> new file mode 100644
> index 00000000..4d476ac
> --- /dev/null
> +++ b/arch/arm64/boot/dts/amlogic/meson-a1.dtsi
> @@ -0,0 +1,122 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright (c) 2019 Amlogic, Inc. All rights reserved.
> + */
> +
> +#include <dt-bindings/interrupt-controller/irq.h>
> +#include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +/ {
> +       compatible = "amlogic,a1";
> +
> +       interrupt-parent = <&gic>;
> +       #address-cells = <2>;
> +       #size-cells = <2>;
> +
> +       cpus {
> +               #address-cells = <0x2>;
> +               #size-cells = <0x0>;
only now I notice that all our other .dtsi also use hex values
(instead of decimal as just a few lines above) here
do you know if there is a particular reason for this?

[...]
> +               uart_AO_B: serial@fe002000 {
> +                       compatible = "amlogic,meson-gx-uart",
> +                                    "amlogic,meson-ao-uart";
> +                                    reg = <0x0 0xfe002000 0x0 0x18>;
the indentation of the "reg" property is off here

also I'm a bit surprised to see no busses (like aobus, cbus, periphs, ...) here
aren't there any busses defined in the A1 SoC implementation or are
were you planning to add them later?


Martin
