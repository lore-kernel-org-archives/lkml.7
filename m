Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6164C4CECF
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 16:12:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6ABA2089F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 16:12:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KFwU3oII"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388279AbfIWQMm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 12:12:42 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:43152 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728465AbfIWQMl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 12:12:41 -0400
Received: by mail-lf1-f68.google.com with SMTP id u3so10550110lfl.10;
        Mon, 23 Sep 2019 09:12:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1hzRvLmUM+ysGZky33iPZSKotjWOEXjXtFvGtAqUHW0=;
        b=KFwU3oIIuCsBoUbTlON6Ye3xOEX1qg4RElY+lAR4eAhlleuHeZRzS418f9YNW5ONPD
         ICDQZc7C6ZDCWoQST5RUU5CWJYkqY39FRY87a7jpH/4vITDuzLQ4VW9AmgKqpcZ2Ps5X
         ZFjiabeek2WH8HUJ9SJy8rBMDxgWNpp19ZRPDcGQg9HPSnjdCDoss6o9O7cCq/MdDPGd
         CC5fjnwswE7vGvevXiqD17ZZrFi3nzMnbCQRruaS40lnGxzLz63kGlBtKyxhrLbtOexp
         JYigpZQtzRw85JGhV+QoAdNI6EBtKLYOfH4do+MqOtTyTH1g1aezJa4lfwc5n570ba3l
         MOWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1hzRvLmUM+ysGZky33iPZSKotjWOEXjXtFvGtAqUHW0=;
        b=Z03FGsOPJf3djlLNcZJNsl2pHbZ3VfSNqquZwOPVcFzMskqyPwsi+S4g4IQnlTpGQN
         Oj2jdCHV3Y72V3cEFpn4gtI+FrSmbO/X7Ix/JDBv5FjXLsrUtD176SDgW0SL2Ta++SLy
         aYaEN/t9xR00dAtAbClP6f2roJaWtIyR9vhuzZNKUSmoVKeSdL+adp5cbu9rI0vnVfKC
         Z9ErEXl2hoLaa/e5+mXTarvYICStBXnseHv3BgHWVV5s4qAd1EGhTnyUnV2dOdDGU4qU
         NCf3r/KFMs+H0mIJK8N/TXvw1CKCWpGQ54NrPSEomperRwvMVpGGOJwN4r4/mc9RP8Ee
         upyg==
X-Gm-Message-State: APjAAAUpUiQvpzBkq4ZcQDNnPuARl9abu8gFu/9wzPU9LU0wlEwZy8Xz
        DUIMUZzwBXu5bZEOmN9SOV6XIdYlcljHGcwvYXA=
X-Google-Smtp-Source: APXvYqxCaLtqla4IXcVqTac5HqTY/oD5Unli/bJZAhH0Tw01CYJFkAE93ed3DzQbUW3I7SVs6tFeBPdykxbJX2qVK/c=
X-Received: by 2002:ac2:47e3:: with SMTP id b3mr236808lfp.80.1569255159037;
 Mon, 23 Sep 2019 09:12:39 -0700 (PDT)
MIME-Version: 1.0
References: <1569248002-2485-1-git-send-email-laurentiu.palcu@nxp.com> <1569248002-2485-6-git-send-email-laurentiu.palcu@nxp.com>
In-Reply-To: <1569248002-2485-6-git-send-email-laurentiu.palcu@nxp.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Mon, 23 Sep 2019 13:12:42 -0300
Message-ID: <CAOMZO5AOVfBpz2Azh65iT_W3CBZUxf9KnqA=kdow7XWd4j--Qg@mail.gmail.com>
Subject: Re: [PATCH 5/5] arm64: dts: imx8mq: add DCSS node
To:     Laurentiu Palcu <laurentiu.palcu@nxp.com>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        =?UTF-8?Q?Guido_G=C3=BCnther?= <agx@sigxcpu.org>,
        Lucas Stach <l.stach@pengutronix.de>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Laurentiu,

On Mon, Sep 23, 2019 at 11:14 AM Laurentiu Palcu
<laurentiu.palcu@nxp.com> wrote:

> +
> +                       dcss: dcss@0x32e00000 {

Node names should be generic, so:

dcss: display-controller@32e00000

> +                               #address-cells = <1>;
> +                               #size-cells = <0>;
> +                               compatible = "nxp,imx8mq-dcss";
> +                               reg = <0x32e00000 0x2D000>, <0x32e2f000 0x1000>;

0x2d000 for consistency.

> +                               interrupts = <6>, <8>, <9>;

The interrupts are passed in the <GIC_SPI xxx IRQ_TYPE_LEVEL_HIGH> format.
