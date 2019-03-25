Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43799C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 10:49:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A0D920870
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 10:49:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gk8j1sA2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730818AbfCYKta (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 06:49:30 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:43311 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729727AbfCYKta (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 06:49:30 -0400
Received: by mail-lj1-f194.google.com with SMTP id f18so7336463lja.10
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 03:49:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yKSnMNgsK72hHgboIbJfV2LQi9P9bdxvIOPmlTDtT6Q=;
        b=Gk8j1sA2x0xWAat5PcZzOkRdkafohQymq0CGT2ic8uKU1S2WgiUQgKdlfFT5dotbkX
         14P90NjDOveS/fTyl72e6qBaWDjvmuqDnIQPUhslyQ/0AnrJKzsC9bnlSKByMr5yqd4k
         GpICMfEmfD8v1+YM5t6vUiQ6R2UoqMFGCVwBcj+JzyYX0olbR1XIce39Q07Vmb1T2SfJ
         +d2vqBMi5Go5b77XT4sznLqtQzbkulfMzIz1B0yf0ooPqIkmaa2RObxBEyqv68XpNQPt
         oJ5FnMfoVCT0G4vviFNyIvwbigrBxhjSWklxYK6g38ZBQ0LLsOYNXo26zjcI9QzGIAc5
         HPFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yKSnMNgsK72hHgboIbJfV2LQi9P9bdxvIOPmlTDtT6Q=;
        b=SRr/2xiSPh8mp1c0e7cYNZRxu5cNW8cMwZXw8NeVqiezomXqMNJWTn5FhVno0r413q
         MvJDEKUx2E9+YKM6KYHuha0eyONMtuIbmLKgbfFjfTFSWQq5i+bpUHGQvkebqPQuYcQx
         yY+KaW2NXJcfOhKyLFnXLsMzo0c2QCa2Vcuf/+s/1Zhndkh0Hep/PEqRlVL7frxqMu/7
         jwxHSIHvVZCDlP9Eto8A1AX0vBVlajrCBQhHzJApsUHS7/MVyaVbBbBUFxGhsBEseR/L
         +wDDF2N4uYuYJp815MIvzu/kX7dQ8F4Bp6zud12zcaDY/IXwrN+xOHp6tgz6UiDPwCvk
         xPPQ==
X-Gm-Message-State: APjAAAVKJeP6gnE554YHUwbjTGRZOnt27ZfGRog/2n5SY6xwwH5cLmEk
        +8NPzX3ZOzj01XpkZZOLXYaZSFdg8FoxZiHh1gg=
X-Google-Smtp-Source: APXvYqzjxgC1ISnZMdwW059r3itnf2X+XCSGm8TCKU+Yl+zSByx4zFobtj9vMmdqTNVUeBAoQ0Q+pMC4Hg0jGMvgPx0=
X-Received: by 2002:a2e:899a:: with SMTP id c26mr12653589lji.192.1553510967905;
 Mon, 25 Mar 2019 03:49:27 -0700 (PDT)
MIME-Version: 1.0
References: <20190325050100.29517-1-andrew.smirnov@gmail.com>
In-Reply-To: <20190325050100.29517-1-andrew.smirnov@gmail.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Mon, 25 Mar 2019 07:49:30 -0300
Message-ID: <CAOMZO5BOR2DS-w3oOHsT_hTttgK=OPQZYwUywXdZFLRzbrb6Zg@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: imx6qdl: Specify IMX6QDL_CLK_IPG as "ipg" clock
 for SDMA
To:     Andrey Smirnov <andrew.smirnov@gmail.com>
Cc:     Shawn Guo <shawnguo@kernel.org>, Angus Ainslie <angus@akkea.ca>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Chris Healy <cphealy@gmail.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Lucas Stach <l.stach@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrey,

On Mon, Mar 25, 2019 at 2:01 AM Andrey Smirnov <andrew.smirnov@gmail.com> wrote:

> diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
> index 9f9aa6e7ed0e..354feba077b2 100644
> --- a/arch/arm/boot/dts/imx6qdl.dtsi
> +++ b/arch/arm/boot/dts/imx6qdl.dtsi
> @@ -949,7 +949,7 @@
>                                 compatible = "fsl,imx6q-sdma", "fsl,imx35-sdma";
>                                 reg = <0x020ec000 0x4000>;
>                                 interrupts = <0 2 IRQ_TYPE_LEVEL_HIGH>;
> -                               clocks = <&clks IMX6QDL_CLK_SDMA>,
> +                               clocks = <&clks IMX6QDL_CLK_IPG>,

This problem affects other i.MX SoCs, such as i,MX6SX as originally
reported here:
https://patchwork.kernel.org/patch/10864867/

So I think we need either a  dtsi fix for the other i.MX SoCs or maybe
a fix in the SDMA driver?
