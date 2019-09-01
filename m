Return-Path: <SRS0=SHWF=W4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08FADC3A5A4
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Sep 2019 11:44:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C727C21897
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Sep 2019 11:44:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="vhanXbkP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728786AbfIALo4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Sep 2019 07:44:56 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:40966 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726275AbfIALo4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Sep 2019 07:44:56 -0400
Received: by mail-ot1-f65.google.com with SMTP id o101so11107681ota.8;
        Sun, 01 Sep 2019 04:44:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=N5SW0h/ksHed7i/eHFWIqXI6qoMGR2BQIv5D3teJr74=;
        b=vhanXbkPhCASy7yp6E70RWXSIea3XKgBgpX4J0cjIOAXFMJTvv4io0WvNACb2Q3NHI
         KqPzpdfJDGsN3hcbHseg56/IVIqd+TCUKLGLCVlBCgoaBA3+DcXamXY36nT+rtVt/7UH
         z0Sx87ePMve/U0njqJexwh8+c8PfcU7rKefFregulzCaq0LKPs65DamwrPTnAZQ0/xmK
         +cduO/uBYFyqO1xVjiFqng6rNs1rMw21ZKXzSKn2lRN3OuElmSbwlOv+bg6vTiymyDXa
         J8X6pRqog59PPe0G6EpFNcdUq0OlIcD6RqJttG9cIFjx7MaQ92QUm2Lw13rLH5OmKldY
         wSAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=N5SW0h/ksHed7i/eHFWIqXI6qoMGR2BQIv5D3teJr74=;
        b=mXSc7pfz36It3eRnEARa4DepoA1DGU56pvEvvodFHPsP63ELHyfLRYPcuZ3whjyb7+
         9f9tYkX9rWdqzIyadB3S3AIPOoVHW47UydCJmCuBUxurs13waH1Pg/IBKc9njU+6JbDj
         Z2Bmg9c8411mhEeqO4QVKU5T3QnkVJYTLBHk+jeeGIQ+W8B4BrRAMmhudU4xGeJxO6Eg
         vhlwnYF4CVmvE6K4AtrYu+jUyJyFkOucptXLbcWYhWPqslQ51YZygYbSxvOWGol0PTK5
         CZ+6MlmwvFVBGsxf8Hn7/GIcqWx8hg0uhv3grkUMflfApga0XT3b+/poapgfPntHMXj8
         //ig==
X-Gm-Message-State: APjAAAVVbl+uXSsV8QlNh9Tibaht5nycZQn7DNR4Qpo7zekZrxqLuNSi
        M4BszCNc67KywXpKKBZCy6TlzZu86aV6Ocw1NX8=
X-Google-Smtp-Source: APXvYqxLmXiuv+TRf/3RDHS6aD3eo3thHXEQG33YbJzqOL7vyoTqfUAXob2N+E96QZArxo0XcqUwg5ritXmDRv0E4k0=
X-Received: by 2002:a9d:1d5:: with SMTP id e79mr19768337ote.98.1567338295280;
 Sun, 01 Sep 2019 04:44:55 -0700 (PDT)
MIME-Version: 1.0
References: <20190828202723.1145-1-linux.amoon@gmail.com> <20190828202723.1145-4-linux.amoon@gmail.com>
In-Reply-To: <20190828202723.1145-4-linux.amoon@gmail.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Sun, 1 Sep 2019 13:44:44 +0200
Message-ID: <CAFBinCB9NPtncyJCMWDbbzJnQafeaY5U3XHh=NuRZSCNDdO=Hg@mail.gmail.com>
Subject: Re: [PATCHv1 3/3] arm64: dts: meson: odroid-c2: Add missing regulator
 linked to HDMI supply
To:     Anand Moon <linux.amoon@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anand,

On Wed, Aug 28, 2019 at 10:27 PM Anand Moon <linux.amoon@gmail.com> wrote:
>
> As per shematics HDMI_P5V0 is supplied by P5V0 so add missing link.
typo: "schematics"

> Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> Cc: Jerome Brunet <jbrunet@baylibre.com>
> Cc: Neil Armstrong <narmstrong@baylibre.com>
> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> ---
>  arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts b/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
> index a078a1ee5004..47789fd50415 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
> +++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
> @@ -213,6 +213,8 @@
>         status = "okay";
>         pinctrl-0 = <&hdmi_hpd_pins>, <&hdmi_i2c_pins>;
>         pinctrl-names = "default";
> +       /* AP2331SA-7 */
> +       hdmi-supply = <&p5v0>;
>  };
my understanding based on odroid-c2_rev0.1_20150930.pdf is that:
- there's a (fixed) hdmi_p5v0 regulator using p5v0 as input
- the hdmi_p5v0 is the hdmi-supply

it doesn't change the functionality of this patch (since both supplies
are fixed regulators anyways)
you are already doing a nice cleanup with this series, so it would be
a shame to take a shortcut here


Martin
