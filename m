Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23BF9C5B57D
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 00:57:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDBAB2089C
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 00:57:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="Ky+Qov/F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727419AbfGCA5X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 20:57:23 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:40160 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727223AbfGCA5W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 20:57:22 -0400
Received: by mail-oi1-f193.google.com with SMTP id w196so591588oie.7;
        Tue, 02 Jul 2019 17:57:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EYSjJ+LydcEzxdw5idXtHVOIPJiJa1YBB46CfRDibpM=;
        b=Ky+Qov/F2L5VKJErmVkFIhuhAIV0b1AaOa7IMvL2kX/CUlcxAElMT3DrIgwtBnA4d1
         SQ/23AicMM7pBE+KLQpjWjno8WseCCJH2B9hFbvaoV728N3z07QHToIGQtDp6PfV94rI
         Dv/k6naII/d9qUlexdL/XoZ1IEf9ZOj3wXlcer1runlwnx96UQ55EyJWCSwYjcuyZSRV
         ETsmPLcasSQMP0aylaGM7CqMRgDkZzaVyopzqjOUyaupOk/n+qJGV3S3swBHCiTn9wm3
         l0vG4Le3nRf61YoCFWKKFPFbg2ybTvPs+QBi74QoDVpU5Ib2l0hrpfVXXPjP296aYkhL
         +tsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EYSjJ+LydcEzxdw5idXtHVOIPJiJa1YBB46CfRDibpM=;
        b=gi/DqSaxmCGMPVi1A3Wa+0wAzssTAUs3HTEMbC1c92zkXAMW0LNK8rZeME7DjvFTV7
         cT/Y6Fh9RlhqJt1emcMHwnSYkvo+nbMDEsN1RjEk0gNg8pfRGOFgPOQDNK1IFLfV41Hm
         c73xvi/3TdepC29NSdg0jsCbmFm/YEG58JDIO4sv3s5T9QpEjXXQm/pnpk7KFIVNa4+b
         cyGxvyGogGXXNxkM8bnDIKEy0l/TdcGb3iL8OhqSYlQMMgeDIJDNaus1ZgWmmCZBAPDx
         9EQ6Iw4i6lCg/I8ctx4/BxzIk6cyZsmqnQUGz7zsJ4HhjuESal7Rqwsfw8ZFF43gtMUe
         ed2Q==
X-Gm-Message-State: APjAAAXPhMsP7HnYat274GKKLw8JPC4awBWigg3oFKQaUvBCuNaUSEDZ
        mP2/Bg/NH7W05eZPz5l/DyHiadsdNajnelb6YTT7qTOC
X-Google-Smtp-Source: APXvYqyaGj0PCGVVeTWrqW1w/ckN7gLuV9G2Q3xfXsdrU6SN4A4wrK/wTIoCTD3mXZvotSia4JivxoObW/UzXuEV8E0=
X-Received: by 2002:a05:6808:8f0:: with SMTP id d16mr1556508oic.47.1562112065923;
 Tue, 02 Jul 2019 17:01:05 -0700 (PDT)
MIME-Version: 1.0
References: <20190701104705.18271-1-narmstrong@baylibre.com> <20190701104705.18271-3-narmstrong@baylibre.com>
In-Reply-To: <20190701104705.18271-3-narmstrong@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Wed, 3 Jul 2019 02:00:55 +0200
Message-ID: <CAFBinCAT1JaK6ksD9OzCK_wEEWJdaZL2vLzGeCzVVbz9V67btQ@mail.gmail.com>
Subject: Re: [RFC 02/11] dt-bindings: power: amlogic, meson-gx-pwrc: Add SM1 bindings
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     jbrunet@baylibre.com, khilman@baylibre.com,
        devicetree@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Neil,

On Mon, Jul 1, 2019 at 12:48 PM Neil Armstrong <narmstrong@baylibre.com> wrote:
[...]
> +General Purpose Power Controller
> +--------------------------------
>
> +The Amlogic SM1 SoCs embeds a General Purpose Power Controller used
> +to control the power domain for, at least, the USB PHYs and PCIe
> +peripherals.
AFAIK each binding document should only describe one IP block.
this one seems to be new / different

should it get it's own file?
also should it be a .yaml binding?

> +
> +Device Tree Bindings:
> +---------------------
> +
> +Required properties:
> +- compatible: should be one of the following :
> +       - "amlogic,meson-sm1-pwrc" for the Meson SM1 SoCs
> +- #power-domain-cells: should be 0
> +- amlogic,hhi-sysctrl: phandle to the HHI sysctrl node
> +
> +Parent node should have the following properties :
> +- compatible: "amlogic,meson-gx-ao-sysctrl", "syscon", "simple-mfd"
> +- reg: base address and size of the AO system control register space.
> +
> +
> +Example:
> +-------
> +
> +ao_sysctrl: sys-ctrl@0 {
> +       compatible = "amlogic,meson-gx-ao-sysctrl", "syscon", "simple-mfd";
> +       reg =  <0x0 0x0 0x0 0x100>;
> +
> +       pwrc: power-controller {
> +               compatible = "amlogic,meson-sm1-pwrc";
> +               #power-domain-cells = <1>;
> +               amlogic,hhi-sysctrl = <&hhi>;
> +       };
> +};
I'm not sure that we want to mix HHI and AO power domains in one driver again
back in March I asked a few questions about modelling the power
domains and Kevin explained that we can implement them hierarchical:
[0]
unfortunately I didn't have the time to work on this - however, now
that we implement a new driver: should we follow this hierarchical
approach?


Martin


[0] http://lists.infradead.org/pipermail/linux-amlogic/2019-March/010512.html
