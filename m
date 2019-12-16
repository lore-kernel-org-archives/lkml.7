Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97C2AC2D0BF
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 22:53:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CDEB2176D
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 22:53:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XXZ+IGap"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727437AbfLPWxg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 17:53:36 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:42896 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726487AbfLPWxf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 17:53:35 -0500
Received: by mail-io1-f67.google.com with SMTP id f82so8852213ioa.9
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2019 14:53:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RugfqCxXsqYSRLxdCfLtMG45h5Ag2X4I9A7YwT1uN7E=;
        b=XXZ+IGap9OUYsoKu59QewkNCOK0PFVk9ggPbUG2iuRZrpAd1IwXtlYzIauvXVxZgdN
         2m+S0vc8GNHb84/lT2PaIxA6EKyjo3TGFy5u0ZMHHxFjHOWc7IOm9l5hays3CfhoSYK0
         kduSEGqRf0WKJKsOfN1Xyc5jieOlDPE4GZRwM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RugfqCxXsqYSRLxdCfLtMG45h5Ag2X4I9A7YwT1uN7E=;
        b=knMP5uy/YDPT2O1bMO75ToRtVp1tYurEfWQ+70I3lZo0Rgik6hT41+J30Ea62ilhQn
         xcr7tTgUgctK9UtasD18OXwljp3lOaxSmTUK9LK8keRUM97MRxeFq2BX6QqQQrTQNWUS
         TGLHqly3/LOkziAMxRGaGi3y4AZ0qhwqTzkIQgKJil/9u4e7zJhf7ghPtbh7JFTxiZtP
         mS/mqBjTrI5vRszwpCu4/g9qqp9bK+BZIHUYV+0c2xz132N+MHrkn1glxRKm1tycgBfF
         61KMzwlOLmX3M2eHw8k7tJGAkA0Km3pgqnqEhz7NAAsZWZUVMTq7MqoW69RfbdxIOx+E
         s+IA==
X-Gm-Message-State: APjAAAW+0CPW/y9f066Q89In7tPlW8HfrOuZpPI+IlV2QjvOace/hF6A
        cCOtoFey85P4Ff4D12OWpibGD3Hpeis=
X-Google-Smtp-Source: APXvYqx6Uvq1H6q0zLrQZx4ih2wUSFY+a1bgfRBzcJKJQnIK2ncNXhILjKaeGJZD1V7T/ONe7MroqQ==
X-Received: by 2002:a02:c78f:: with SMTP id n15mr14181653jao.100.1576536814600;
        Mon, 16 Dec 2019 14:53:34 -0800 (PST)
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com. [209.85.166.181])
        by smtp.gmail.com with ESMTPSA id s8sm4703723iom.46.2019.12.16.14.53.33
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Dec 2019 14:53:34 -0800 (PST)
Received: by mail-il1-f181.google.com with SMTP id t17so6757165ilm.13
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2019 14:53:33 -0800 (PST)
X-Received: by 2002:a92:da44:: with SMTP id p4mr3093146ilq.168.1576536813310;
 Mon, 16 Dec 2019 14:53:33 -0800 (PST)
MIME-Version: 1.0
References: <20191216211613.131275-1-swboyd@chromium.org>
In-Reply-To: <20191216211613.131275-1-swboyd@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 16 Dec 2019 14:53:22 -0800
X-Gmail-Original-Message-ID: <CAD=FV=Urn0ZhQSaVBkdq0hTEqe=bDP0KPz87Rd4B_bCF2CoFUA@mail.gmail.com>
Message-ID: <CAD=FV=Urn0ZhQSaVBkdq0hTEqe=bDP0KPz87Rd4B_bCF2CoFUA@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: qcom: sdm845-cheza: Add cr50 spi node
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Dec 16, 2019 at 1:16 PM Stephen Boyd <swboyd@chromium.org> wrote:
>
> Add the cr50 device to the spi controller it is attached to. This
> enables /dev/tpm0 and some login things on Cheza.
>
> Cc: Douglas Anderson <dianders@chromium.org>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
>  arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi b/arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi
> index 9a4ff57fc877..f6683460dc82 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi
> @@ -651,6 +651,20 @@ &spi0 {
>         status = "okay";
>  };
>
> +&spi5 {
> +       status = "okay";
> +
> +       cr50@0 {

Between v2 and v3 of your upstream bindings you changed this from
"cr50@0" to "tpm@0" in the example.  I'm going to assume you did that
for some reason and you should be matching the binding example here.
...or you should change the binding example to be cr50@.


> +               compatible = "google,cr50";
> +               reg = <0>;
> +               pinctrl-names = "default";
> +               pinctrl-0 = <&h1_ap_int_odl>;
> +               spi-max-frequency = <800000>;
> +               interrupt-parent = <&tlmm>;
> +               interrupts = <129 IRQ_TYPE_EDGE_RISING>;

Certainly we need an interrupt, but I don't see it in the bindings.
Any idea why it isn't there?


-Doug
