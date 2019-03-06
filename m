Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83EF0C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 21:27:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C60A20657
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 21:27:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="pXwQEKe3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726234AbfCFV1m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 16:27:42 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:41468 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbfCFV1m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 16:27:42 -0500
Received: by mail-oi1-f195.google.com with SMTP id e7so11129845oia.8;
        Wed, 06 Mar 2019 13:27:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wfnQYJ9ZYPWLDmoAsuuOz4MnfdiiAyFbgZYkpIctsQw=;
        b=pXwQEKe398p9NqTp1Migh8Gljfdn5LNtRx4dXr0nuLQROc1E31OvuoXH7S07gTUeoL
         iiJTkmo2r6FJTV5x9knq/HX4z3BkKVfg0EduNWmBmUzkg2M2+GO909sxK2aRS/CJwPZl
         wGEpKv0CrC9jtmX5x9PEAT14GFelVIWCK+10HDB4UAu8/AO5d6wbQUEo8SQ3B6w3XXni
         EO3cLROVeMse8e5XWkHnvjcW2kEmqwq8dBZYxbqV0S53F3yUp0xI5Smd2nlQC0xHs8gl
         BWwzJxJL3Rl4t4Tug9OIohi3H5jm8JnCc69xxiiIN+oNLEkELvHPULwwCUmSiQfs757k
         bdng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wfnQYJ9ZYPWLDmoAsuuOz4MnfdiiAyFbgZYkpIctsQw=;
        b=XuFDL8OFdCcIeYO004uEEe2+iF9kLXbdiXPnpbw9EMrNIirvq8XVBiWDKoznyn7Nly
         pfGC+KUNi0H4q+vNrGZ6LEhUqirh6JCYyNgq8IJwTi5vI0BJE2ZEA5XrqdKXgQnHjTEX
         FWI3kWp9jx0qx32JoViG0D7RIvb/TVwsL6/lg0W3hs7nfi/s9reMwwDjKqYunHxjEOW7
         9g31gvvsaOjLSAXBL5vrTUXiuZVDLltD2g875AzmjAugJ2113p7KgMVrvRrfHY0Vf+27
         CpP/3rHWUkmWzyeWcZ7z75vZMW4f/CBRXOBnuPbVjvnM0E7/98by+nMIYvO68CLhdF8S
         FMqw==
X-Gm-Message-State: APjAAAVdB4+G1O3lUSUOwaq8VWJRtGKa5ButBqoJfnacZB++fj4MYEWG
        Cf8F8fbU5InJQ+o/QcE+9kG9hDgdWuP9Z3nkcGg=
X-Google-Smtp-Source: APXvYqziQVrcMvGA65w5hFphx3ZggVpQ+FudS9uwkIC3wb4hLSrfo2bAN1wdUmKmEpX565SFbMxTHS47D8NP85XV/kM=
X-Received: by 2002:aca:c286:: with SMTP id s128mr3047723oif.39.1551907660645;
 Wed, 06 Mar 2019 13:27:40 -0800 (PST)
MIME-Version: 1.0
References: <20190304103846.2060-1-narmstrong@baylibre.com> <20190304103846.2060-5-narmstrong@baylibre.com>
In-Reply-To: <20190304103846.2060-5-narmstrong@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Wed, 6 Mar 2019 22:27:29 +0100
Message-ID: <CAFBinCDthrw1zM8ryLOV4FDVvZecG8q8hGnNJVy8HOjTQRpFzg@mail.gmail.com>
Subject: Re: [PATCH v2 4/8] dt-bindings: usb: dwc3: Add Amlogic G12A DWC3 Glue Bindings
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     gregkh@linuxfoundation.org, hminas@synopsys.com, balbi@kernel.org,
        kishon@ti.com, devicetree@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Neil,

On Mon, Mar 4, 2019 at 11:40 AM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> Adds the bindings for the Amlogic G12A USB Glue HW.
>
> The Amlogic G12A SoC Family embeds 2 USB Controllers :
> - a DWC3 IP configured as Host for USB2 and USB3
> - a DWC2 IP configured as Peripheral USB2 Only
>
> A glue connects these both controllers to 2 USB2 PHYs,
> and optionnally to an USB3+PCIE Combo PHY shared with the PCIE controller.
>
> The Glue configures the UTMI 8bit interfaces for the USB2 PHYs, including
> routing of the OTG PHY between the DWC3 and DWC2 controllers, and
> setups the on-chip OTG mode selection for this PHY.
>
> The PHYs phandles are passed  to the Glue node since the Glue controls the
> interface with the PHY, not the DWC3 controller.
>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

[...]
> +                       dwc3: usb@ff500000 {
> +                               compatible = "snps,dwc3";
> +                               reg = <0x0 0xff500000 0x0 0x100000>;
> +                               interrupts = <GIC_SPI 30 IRQ_TYPE_LEVEL_HIGH>;
> +                               dr_mode = "host";
> +                               snps,dis_u2_susphy_quirk;
> +                               snps,quirk-frame-length-adjustment;
> +                       };
in v1 of the patch I asked whether we should pass the PHYs which are
connected to the dwc3 controller here as well (instead of only passing
them to the USBCTRL node).
we can still do this later on, the important part is: USBCTRL
interfaces with the PHYs -> that is already part of the binding.


Regards
Martin
