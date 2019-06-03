Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32F95C04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 13:34:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0EFA27DBB
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 13:34:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Q+TCX9NG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728748AbfFCNes (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 09:34:48 -0400
Received: from mail-ua1-f65.google.com ([209.85.222.65]:36504 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727387AbfFCNer (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 09:34:47 -0400
Received: by mail-ua1-f65.google.com with SMTP id 94so6477561uam.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2019 06:34:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iTOR4s19inw6YQwhxy0CXAQucgvVed2kOMDp3ETSJq0=;
        b=Q+TCX9NGStBhrVViNBATbIVxpQv07Yf7esHbsRxw3NSascNQjVpfBlu2e0bCTx0nGM
         5tHxgVnccsILnUVnlCwpx+c1VUPfbPCLxaOICv7rBmWkVVJLWDMEYiNQyVPsrcgN9V5m
         JcT2mYYjie7daqe76DS8wtZA6sD1NEx9ExP/H/VrFeD5NdB6kSiF/F2K8Vl35BuOjrNs
         O2fPxlZU36VMsrYbd3aK3IxSeErRwGSv+x15ANfj17VPlmQ9ymL4w3aG+flUSBIbxqjo
         AvsP/WSWMdZUZ58OorFH6PFRpTW77VxU4OZXSTeF1GrXowttjGcx3aIZB9K0+PHBxHw8
         U8iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iTOR4s19inw6YQwhxy0CXAQucgvVed2kOMDp3ETSJq0=;
        b=R+hnHCVHGm+jFeEdUPKpqoJiwGbIlFpKyOPfjCjywi3bvQT3Drsfl36zTVBxppHrCC
         2k97qjYiBIpPy4mhTNQPpsjX35lGHPAKjn3f4d295iHsVrBIJh1g1m3UCvygk0yFO2BC
         v6cV2GgbzKjYoG5hF9Prg6URNGZ+PLtIngqj9dDVGTkAyUnCD63Ni8+l+9FMo9totnYC
         BJxNy/yRHQ1bB9UDRfQ+gV8S0nbhwd0EzNYzHnLlk9s12wruNYlW9n5F6e/c94b0ejA7
         0SYRoJGxpUaB6VY7Gc+TP+9XXppb9vbIkQ6uZ0r8bhC79OtrEQDOn69BwBlWJrUPnywB
         j25w==
X-Gm-Message-State: APjAAAXdbgbhoWtGYx92WfpBZ/G9e6eRQUCWr3uxemHt6u3mJU3ZVVW9
        xidbxbK0enwvU2+p7buLA3z/DEN4W4GJ1sg+vmDpzQ==
X-Google-Smtp-Source: APXvYqxp3yy8DxN4JfsvUu4iGuu38aEcdR6YIg+B2abb33POOSHXMVT6lknZdscjBCk3bsp7Vw5g5SKYGlgbDyo2QVo=
X-Received: by 2002:ab0:5608:: with SMTP id y8mr12658948uaa.129.1559568886891;
 Mon, 03 Jun 2019 06:34:46 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1558346019.git.baolin.wang@linaro.org> <ee4ad0e7e131e4d639dbf6bd25ad93726648ce1c.1558346019.git.baolin.wang@linaro.org>
In-Reply-To: <ee4ad0e7e131e4d639dbf6bd25ad93726648ce1c.1558346019.git.baolin.wang@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 3 Jun 2019 15:34:10 +0200
Message-ID: <CAPDyKFrWiG3KJad+L3NOQ-dC2XnBM-8mQGVEsVB_Qg0ACTfVag@mail.gmail.com>
Subject: Re: [PATCH 2/9] dt-bindings: mmc: sprd: Add another optional clock documentation
To:     Baolin Wang <baolin.wang@linaro.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        Vincent Guittot <vincent.guittot@linaro.org>, arm@kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 May 2019 at 12:12, Baolin Wang <baolin.wang@linaro.org> wrote:
>
> For some Spreadtrum platforms like SC9860 platform, we should enable another
> gate clock '2x_enable' to make the SD host controller work well. Thus add
> documentation for this optional clock.
>
> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> ---
>  .../devicetree/bindings/mmc/sdhci-sprd.txt         |    1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/mmc/sdhci-sprd.txt b/Documentation/devicetree/bindings/mmc/sdhci-sprd.txt
> index 45c9978..a285c77 100644
> --- a/Documentation/devicetree/bindings/mmc/sdhci-sprd.txt
> +++ b/Documentation/devicetree/bindings/mmc/sdhci-sprd.txt
> @@ -14,6 +14,7 @@ Required properties:
>  - clock-names: Should contain the following:
>         "sdio" - SDIO source clock (required)
>         "enable" - gate clock which used for enabling/disabling the device (required)
> +       "2x_enable" - gate clock controlling the device for some special platforms (optional)

This is a bit vague, could you please elaborate (and fold in that
information to the doc) on what kind of clock this is?

[...]

Kind regards
Uffe
