Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ED67C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 21:42:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE57D20652
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 21:42:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="MPR0IdkG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726871AbfCEVmw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 16:42:52 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:43634 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726069AbfCEVmv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 16:42:51 -0500
Received: by mail-oi1-f193.google.com with SMTP id i8so8106396oib.10;
        Tue, 05 Mar 2019 13:42:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MOD4jyjI8RMFk80xHkOoeeVuPubtDARVBzjuJNAgK4o=;
        b=MPR0IdkGj4UN618A/kk4Ofm6oKt6cIm92w+9YkBPwuXZa4wTC8IMyFqc5VPGp1Djbs
         3HSn7GDs8RCcjspqgGIpCagtaYXUcy2ar4talSTXkCxTpIaMMjMp28QiVeMx8wY5K+dU
         m6iKCzn844MRmSZHacQv2tTyVxjlX8AGbrzxhK36UqcEtoqkoqxPuoiaD1hiAdw3tgu8
         eFkERHTFqfDA41me3AJcYLlvYhAhQqWssgiYaKET+fk7i5hEcZ20q2mBQtlgIsY/hQvD
         oVJj2QSOduixlnLnY6qxLD8kZxvDJ5tLcYwGDkwUA0OnIugmJovzhVmiB12KV4HznzhG
         DjrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MOD4jyjI8RMFk80xHkOoeeVuPubtDARVBzjuJNAgK4o=;
        b=png6lon+g+ds9oeQVbM+2QqL/x1nR47Umf37u8Zb7RARleMuCEGvnT/0Z5sV3kwTxw
         i0aGh9mipjhA5Al66CqwYIZ7NYk+EvClXDu4Qd7tvL02sh5HvoJN88RLHA738SWE9zdx
         EjdciIEi7XGHVZ71tzypSHQOjze2Y6Fa3Z6BD85UMaT2sahEe9uqRofck4vV1z9awPkm
         NTn1NOdNhCFD+8WrIF90KmkRDPkgMrBIzQwQlZrUKqLoZSEkuerJbaS4effhOgC65rP6
         sbbL5VjA0lbHJLE1gDy6sm2D9XJZ1KCxP005o2cLqFOQJMCGXTSgrhKQT2KfyMKdXUee
         ezvA==
X-Gm-Message-State: APjAAAVJcQ4siC99761hsNLzIUV3tdH/ZgYoBGR4S6ORJ3YmRa+f9YqZ
        I0h4IhIkhxfgh1M1tY+coWtKg33MSPcDQBYAucY=
X-Google-Smtp-Source: APXvYqyksJ+0KlMrRx3GQbccih1Q/btUaH8LrNjn7p+luy/KhmX/NYYTT5zc0TpVuieiYusskOeMxSyLDsy/oMRuFAA=
X-Received: by 2002:aca:c286:: with SMTP id s128mr379757oif.39.1551822170308;
 Tue, 05 Mar 2019 13:42:50 -0800 (PST)
MIME-Version: 1.0
References: <20190304103846.2060-1-narmstrong@baylibre.com> <20190304103846.2060-3-narmstrong@baylibre.com>
In-Reply-To: <20190304103846.2060-3-narmstrong@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Tue, 5 Mar 2019 22:42:39 +0100
Message-ID: <CAFBinCCp+bME0fnWRJx0L1E5aazUh1Hw-svsP7+D_QU4dP08nw@mail.gmail.com>
Subject: Re: [PATCH v2 2/8] dt-bindings: phy: Add Amlogic G12A USB3+PCIE Combo
 PHY Bindings
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     gregkh@linuxfoundation.org, hminas@synopsys.com, balbi@kernel.org,
        kishon@ti.com, devicetree@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-usb@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Neil,

On Mon, Mar 4, 2019 at 11:38 AM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> Add the Amlogic G12A Family USB3 + PCIE Combo PHY Bindings.
>
> This PHY can provide exclusively USB3 or PCIE support on shared I/Os.
>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> ---
>  .../bindings/phy/meson-g12a-usb3-pcie-phy.txt | 22 +++++++++++++++++++
>  1 file changed, 22 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/meson-g12a-usb3-pcie-phy.txt
>
> diff --git a/Documentation/devicetree/bindings/phy/meson-g12a-usb3-pcie-phy.txt b/Documentation/devicetree/bindings/phy/meson-g12a-usb3-pcie-phy.txt
> new file mode 100644
> index 000000000000..7cfc17e2df31
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/meson-g12a-usb3-pcie-phy.txt
> @@ -0,0 +1,22 @@
> +* Amlogic G12A USB3 + PCIE Combo PHY binding
> +
> +Required properties:
> +- compatible:  Should be "amlogic,meson-g12a-usb3-pcie-phy"
> +- #phys-cells: must be 1. The cell number is used to select the phy mode
> +  as defined in <dt-bindings/phy/phy.h> between PHY_TYPE_USB3 and PHY_TYPE_PCIE
> +- reg:         The base address and length of the registers
> +- clocks:      a phandle to the 100MHz reference clock of this PHY
> +- clock-names: must be "ref_clk"
> +- resets:      phandle to the reset lines for the PHY control
> +- reset-names: must be "phy"
one question on the resets:
- in v1 you had three reset lines: RESET_PCIE_CTRL_A, RESET_PCIE_PHY,
RESET_PCIE_APB
- in v2 you only have the "phy" reset line.
is this because the other two are connected to the PCIe controller
(Documentation/devicetree/bindings/pci/amlogic,meson-pcie.txt) instead
of the PHY?


Regards
Martin
